//
//  BadgeView.swift
//  BadgeControl
//
//  Created by Robin Krenecky on 19.08.17.
//  Copyright © 2017 Robin Krenecky. All rights reserved.
//

import UIKit

open class BadgeView: UIView {

  // MARK: Internal properties

  internal var height: CGFloat { didSet { updateUI() } }
  internal var centerPoint: CGPoint { didSet { updateUI() } }
  internal var text: String { didSet { updateUI() } }
  internal var badgeBackgroundColor: UIColor { didSet { updateUI() } }
  internal var badgeTextColor: UIColor { didSet { updateUI() } }
  internal var badgeTextFont: UIFont { didSet { updateUI() } }
  internal var borderWidth: CGFloat { didSet { updateUI() } }
  internal var borderColor: UIColor { didSet { updateUI() } }

  // MARK: Initializers

  public init(height: CGFloat,
              center: CGPoint,
              text: String,
              badgeBackgroundColor: UIColor,
              badgeTextColor: UIColor,
              badgeTextFont: UIFont,
              borderWidth: CGFloat,
              borderColor: UIColor) {

    self.height = height
    self.centerPoint = center
    self.text = text
    self.badgeBackgroundColor = badgeBackgroundColor
    self.badgeTextColor = badgeTextColor
    self.badgeTextFont = badgeTextFont
    self.borderWidth = borderWidth
    self.borderColor = borderColor

    super.init(frame: CGRect(x: 0,
                             y: 0,
                             width: BadgeView.calculateWidth(height: height, borderWidth: borderWidth, text: text),
                             height: height))

    backgroundColor = .clear
  }

  @available(*, unavailable, message: "Storyboard initiation is not supported.")
  public required init?(coder aDecoder: NSCoder) { fatalError("Not supported") }

  open override func draw(_ rect: CGRect) {
    frame = CGRect(x: 0, y: 0, width: BadgeView.calculateWidth(height: height, borderWidth: borderWidth, text: text), height: height)
    let height = frame.height - borderWidth
    let ovalWidth = height
    let rightHemisphereX = frame.width - borderWidth / 2 - height

    drawOval(height, ovalWidth, rightHemisphereX)
    drawText()
    center = centerPoint
  }

  // MARK: Private methods

  private static func calculateWidth(height: CGFloat, borderWidth: CGFloat, text: String) -> CGFloat {
    let height = height - borderWidth * 2
    let ratio = CGFloat(text.count > 0 ? text.count : 1)
    return CGFloat(height + (ratio - 1) * height / 2.4) + borderWidth * 2
  }

  private func drawOval(_ height: CGFloat, _ ovalWidth: CGFloat, _ rightHemisphereX: CGFloat) {
    var ovalPath = UIBezierPath()

    addRightHemisphereArc(to: &ovalPath, rightHemisphereX, ovalWidth, height)
    ovalPath.addLine(to: CGPoint(x: ovalWidth / 2, y: height + borderWidth / 2))
    addLeftHemisphereArc(to: &ovalPath, frame, ovalWidth, height)
    ovalPath.close()

    badgeBackgroundColor.setFill()
    ovalPath.fill()

    borderColor.setStroke()
    ovalPath.lineWidth = borderWidth
    ovalPath.stroke()
  }

  private func addRightHemisphereArc(to path: inout UIBezierPath, _ rightHemisphereX: CGFloat, _ ovalWidth: CGFloat, _ height: CGFloat) {
    let rightHemisphereRect = CGRect(x: rightHemisphereX, y: borderWidth / 2, width: ovalWidth, height: height)

    path.addArc(withCenter: CGPoint(x: rightHemisphereRect.midX, y: rightHemisphereRect.midY),
                radius: rightHemisphereRect.width / 2,
                startAngle: -90 * CGFloat.pi / 180,
                endAngle: -270 * CGFloat.pi / 180,
                clockwise: true)
  }

  private func addLeftHemisphereArc(to path: inout UIBezierPath, _ frame: CGRect, _ ovalWidth: CGFloat, _ height: CGFloat) {
    let leftHemisphereRect = CGRect(x: frame.minX + borderWidth / 2, y: frame.minY + borderWidth / 2, width: ovalWidth, height: height)

    path.addArc(withCenter: CGPoint(x: leftHemisphereRect.midX, y: leftHemisphereRect.midY),
                radius: leftHemisphereRect.width / 2,
                startAngle: -270 * CGFloat.pi / 180,
                endAngle: -90 * CGFloat.pi / 180,
                clockwise: true)
  }

  private func drawText() {
    let textRect = frame
    let textTextContent = text
    let textStyle = NSMutableParagraphStyle()
    textStyle.alignment = .center
    let textFontAttributes = [
      .font: badgeTextFont,
      .foregroundColor: badgeTextColor,
      .paragraphStyle: textStyle,
    ] as [NSAttributedString.Key: Any]

    let textTextHeight: CGFloat = textTextContent.boundingRect(with: CGSize(width: textRect.width, height: CGFloat.infinity),
                                                               options: .usesLineFragmentOrigin,
                                                               attributes: textFontAttributes,
                                                               context: nil).height

    textTextContent.draw(in: CGRect(x: textRect.minX, y: textRect.minY + (textRect.height - textTextHeight) / 2,
                                    width: textRect.width,
                                    height: textTextHeight),
                         withAttributes: textFontAttributes)
  }

  private func updateUI() {
    setNeedsDisplay()
  }

}
