import UIKit

internal class BadgeImageView: UIImageView {
  private let text: String
  private let badgeBackgroundColor: UIColor
  private let badgeTextColor: UIColor
  
  init(height: Int, center: CGPoint, text: String, badgeBackgroundColor: UIColor, badgeTextColor: UIColor) {
    self.text = text
    self.badgeBackgroundColor = badgeBackgroundColor
    self.badgeTextColor = badgeTextColor
    
    super.init(image: drawBadge(frame: CGRect(x: 0, y: 0, width: calculateWidth(from: height, and: text), height: height),
                                with: text,
                                badgeBackgroundColor: badgeBackgroundColor,
                                badgeTextColor: badgeTextColor))
    super.center = center
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  private func calculateWidth(from height: Int, and text: String) -> Int {
    return height + (text.count - 1) * height / 3
  }
  
  private func drawBadge(frame: CGRect = CGRect(x: 0, y: 0, width: 30, height: 30),
                         with text: String,
                         badgeBackgroundColor: UIColor,
                         badgeTextColor: UIColor) -> UIImage {
    
    let height = frame.height
    let ovalWidth = height
    let rectangleWidth = frame.width - height
    
    //// General Declarations
    UIGraphicsBeginImageContext(CGSize(width: frame.width, height: frame.height))
    let context = UIGraphicsGetCurrentContext()!
    
    //// Bezier Drawing
    let bezierPath = UIBezierPath()
    UIColor.black.setStroke()
    bezierPath.lineWidth = 1
    bezierPath.stroke()
    
    
    //// Right Hemisphere Drawing
    context.saveGState()
    
    let rightHemisphereRect = CGRect(x: rectangleWidth, y: 0, width: ovalWidth, height: height)
    let rightHemispherePath = UIBezierPath()
    rightHemispherePath.addArc(withCenter: CGPoint(x: rightHemisphereRect.midX, y: rightHemisphereRect.midY), radius: rightHemisphereRect.width / 2, startAngle: -90 * CGFloat.pi/180, endAngle: -270 * CGFloat.pi/180, clockwise: true)
    rightHemispherePath.addLine(to: CGPoint(x: rightHemisphereRect.midX, y: rightHemisphereRect.midY))
    rightHemispherePath.close()
    
    badgeBackgroundColor.setFill()
    rightHemispherePath.fill()
    
    context.restoreGState()
    
    
    //// Left Hemisphere Drawing
    let leftHemisphereRect = CGRect(x: frame.minX, y: frame.minY, width: ovalWidth, height: height)
    let leftHemispherePath = UIBezierPath()
    leftHemispherePath.addArc(withCenter: CGPoint(x: leftHemisphereRect.midX, y: leftHemisphereRect.midY), radius: leftHemisphereRect.width / 2, startAngle: -270 * CGFloat.pi/180, endAngle: -90 * CGFloat.pi/180, clockwise: true)
    leftHemispherePath.addLine(to: CGPoint(x: leftHemisphereRect.midX, y: leftHemisphereRect.midY))
    leftHemispherePath.close()
    
    badgeBackgroundColor.setFill()
    leftHemispherePath.fill()
    
    
    //// Rectangle Drawing
    let rectanglePath = UIBezierPath(rect: CGRect(x: ovalWidth / 2, y: frame.minY, width: rectangleWidth, height: height))
    badgeBackgroundColor.setFill()
    rectanglePath.fill()
    
    //// Text Drawing
    context.saveGState()
    
    let textRect = frame
    let textTextContent = text
    let textStyle = NSMutableParagraphStyle()
    textStyle.alignment = .center
    let textFontAttributes = [
      .font: UIFont.systemFont(ofSize: height * 23 / 32),
      .foregroundColor: badgeTextColor,
      .paragraphStyle: textStyle,
      ] as [NSAttributedStringKey: Any]
    
    let textTextHeight: CGFloat = textTextContent.boundingRect(with: CGSize(width: textRect.width, height: CGFloat.infinity), options: .usesLineFragmentOrigin, attributes: textFontAttributes, context: nil).height
    context.saveGState()
    context.clip(to: textRect)
    textTextContent.draw(in: CGRect(x: textRect.minX, y: textRect.minY + (textRect.height - textTextHeight) / 2, width: textRect.width, height: textTextHeight), withAttributes: textFontAttributes)
    context.restoreGState()
    
    context.restoreGState()
    
    let image = UIGraphicsGetImageFromCurrentImageContext()
    UIGraphicsEndImageContext()
    return image!
  }
}
