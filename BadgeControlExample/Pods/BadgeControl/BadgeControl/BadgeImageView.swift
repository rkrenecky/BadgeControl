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
  
  // MARK: Initializers
  
  internal init(height: Int,
                center: CGPoint,
                text: String,
                badgeBackgroundColor: UIColor,
                badgeTextColor: UIColor,
                badgeTextFont: UIFont) {
    
    self.text = text
    self.badgeBackgroundColor = badgeBackgroundColor
    self.badgeTextColor = badgeTextColor
    self.badgeTextFont = badgeTextFont
    
    super.init(image: drawBadge(frame: CGRect(x: 0, y: 0, width: calculateWidth(from: Double(height), and: text), height: height)))
    super.center = center
  }
  
  public required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  // MARK: Private methods
  
  private func calculateWidth(from height: Double, and text: String) -> Int {
    return Int(height + (Double(text.count) - 1) * height / 2.4)
  }
  
  private func drawBadge(frame: CGRect = CGRect(x: 0, y: 0, width: 30, height: 30)) -> UIImage {
    let height = frame.height
    let ovalWidth = height
    let rightHemisphereX = frame.width - height
    let rectangleWidth = rightHemisphereX > 0 ? rightHemisphereX : 1
    
    UIGraphicsBeginImageContextWithOptions(frame.size, false, 0.0)
    let context = UIGraphicsGetCurrentContext()!
    
    let bezierPath = UIBezierPath()
    UIColor.black.setStroke()
    bezierPath.lineWidth = 1
    bezierPath.stroke()
    
    context.saveGState()
    drawRightHemisphere(rightHemisphereX, ovalWidth, height)
    context.restoreGState()
    drawLeftHemisphere(frame, ovalWidth, height)
    
    // Draw rectangle
    let rectanglePath = UIBezierPath(rect: CGRect(x: ovalWidth / 2, y: frame.minY, width: rectangleWidth, height: height))
    badgeBackgroundColor.setFill()
    rectanglePath.fill()
    
    context.saveGState()
    drawText(frame, context)
    context.restoreGState()
    
    let image = UIGraphicsGetImageFromCurrentImageContext()
    UIGraphicsEndImageContext()
    return image!
  }
  
  private func drawRightHemisphere(_ rightHemisphereX: CGFloat, _ ovalWidth: CGFloat, _ height: CGFloat) {
    let rightHemisphereRect = CGRect(x: rightHemisphereX, y: 0, width: ovalWidth, height: height)
    let rightHemispherePath = UIBezierPath()
    rightHemispherePath.addArc(withCenter: CGPoint(x: rightHemisphereRect.midX, y: rightHemisphereRect.midY),
                               radius: rightHemisphereRect.width / 2,
                               startAngle: -90 * CGFloat.pi / 180,
                               endAngle: -270 * CGFloat.pi / 180,
                               clockwise: true)
    rightHemispherePath.addLine(to: CGPoint(x: rightHemisphereRect.midX, y: rightHemisphereRect.midY))
    rightHemispherePath.close()
    
    badgeBackgroundColor.setFill()
    rightHemispherePath.fill()
  }
  
  private func drawLeftHemisphere(_ frame: CGRect, _ ovalWidth: CGFloat, _ height: CGFloat) {
    let leftHemisphereRect = CGRect(x: frame.minX, y: frame.minY, width: ovalWidth, height: height)
    let leftHemispherePath = UIBezierPath()
    leftHemispherePath.addArc(withCenter: CGPoint(x: leftHemisphereRect.midX, y: leftHemisphereRect.midY),
                              radius: leftHemisphereRect.width / 2,
                              startAngle: -270 * CGFloat.pi / 180,
                              endAngle: -90 * CGFloat.pi / 180, clockwise: true)
    leftHemispherePath.addLine(to: CGPoint(x: leftHemisphereRect.midX, y: leftHemisphereRect.midY))
    leftHemispherePath.close()
    
    badgeBackgroundColor.setFill()
    leftHemispherePath.fill()
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

