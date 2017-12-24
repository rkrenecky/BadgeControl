//
//  BadgeImageView.swift
//  BadgeControl
//
//  Created by Robin Krenecky on 19.08.17.
//  Copyright © 2017 Robin Krenecky. All rights reserved.
//

import UIKit


public class BadgeImageView: UIImageView {
  
  // MARK: Private properties
  
  private let text: String
  private let badgeBackgroundColor: UIColor
  private let badgeTextColor: UIColor
  private let badgeTextFont: UIFont
  private let borderWidth: CGFloat
  private let borderColor: UIColor
  
  // MARK: Initializers
  
  internal init(height: Int,
                center: CGPoint,
                text: String,
                badgeBackgroundColor: UIColor,
                badgeTextColor: UIColor,
                badgeTextFont: UIFont,
                borderWidth: CGFloat,
                borderColor: UIColor) {
    
    self.text = text
    self.badgeBackgroundColor = badgeBackgroundColor
    self.badgeTextColor = badgeTextColor
    self.badgeTextFont = badgeTextFont
    self.borderWidth = borderWidth
    self.borderColor = borderColor
    
    super.init(image: drawBadge(frame: CGRect(x: 0, y: 0, width: calculateWidth(from: Double(height) - Double(borderWidth * 2), and: text), height: height)))
    super.center = center
  }
  
  public required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  // MARK: Private methods
  
  private func calculateWidth(from height: Double, and text: String) -> Int {
    let ratio = text.count > 0 ? text.count : 1
    return Int(height + (Double(ratio) - 1) * height / 2.4) + Int(borderWidth * 2)
  }
  
  private func drawBadge(frame: CGRect = CGRect(x: 0, y: 0, width: 30, height: 30)) -> UIImage {
    let height = frame.height - borderWidth
    let ovalWidth = height
    let rightHemisphereX = frame.width - borderWidth / 2 - height
    
    UIGraphicsBeginImageContextWithOptions(frame.size, false, 0.0)
    let context = UIGraphicsGetCurrentContext()!
    
    context.saveGState()
    drawOval(height, ovalWidth, rightHemisphereX)
    context.restoreGState()
    
    context.saveGState()
    drawText(frame, context)
    context.restoreGState()
    
    let image = UIGraphicsGetImageFromCurrentImageContext()
    UIGraphicsEndImageContext()
    return image!
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
  
  private func drawText(_ frame: CGRect, _ context: CGContext) {
    let textRect = frame
    let textTextContent = text
    let textStyle = NSMutableParagraphStyle()
    textStyle.alignment = .center
    let textFontAttributes = [
      .font: badgeTextFont,
      .foregroundColor: badgeTextColor,
      .paragraphStyle: textStyle,
      ] as [NSAttributedStringKey: Any]
    
    let textTextHeight: CGFloat = textTextContent.boundingRect(with: CGSize(width: textRect.width, height: CGFloat.infinity),
                                                               options: .usesLineFragmentOrigin,
                                                               attributes: textFontAttributes,
                                                               context: nil).height
    context.saveGState()
    context.clip(to: textRect)
    textTextContent.draw(in: CGRect(x: textRect.minX, y: textRect.minY + (textRect.height - textTextHeight) / 2,
                                    width: textRect.width,
                                    height: textTextHeight),
                         withAttributes: textFontAttributes)
  }
}
