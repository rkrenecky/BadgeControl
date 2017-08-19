//
//  BadgeController.swift
//  badge
//
//  Created by Robin Krenecky on 19.08.17.
//  Copyright © 2017 Robin Krenecky. All rights reserved.
//

import UIKit

public class BadgeController {
  private let view: UIView
  
  public var centerPosition: CenterPosition = .upperRightCorner
  public var badgeBackgroundColor = UIColor.red
  public var badgeTextColor = UIColor.white
  
  public var badgeSizeResizingRatio: CGFloat
  lazy var badgeHeight = Int(view.frame.height / 2 * badgeSizeResizingRatio)
  
  private var centerPositionCGPoint: CGPoint {
    return centerPosition.getCenterPoint(in: view)
  }
  
  public var animation: ((UIView) -> Void)? = { badgeView in
    badgeView.transform = CGAffineTransform(scaleX: 3, y: 3)
    UIView.animate(withDuration: 0.75,
                   delay: 0,
                   usingSpringWithDamping: 0.5,
                   initialSpringVelocity: 2.2,
                   options: .curveLinear,
                   animations: { badgeView.transform = CGAffineTransform.identity },
                   completion: nil)
  }
  
  public init(for view: UIView, badgeSizeResizingRatio: CGFloat = 1) {
    self.view = view
    self.badgeSizeResizingRatio = badgeSizeResizingRatio
  }
  
  public convenience init(for view: UIView, in centerPosition: CenterPosition, badgeSizeResizingRatio: CGFloat = 1) {
    self.init(for: view, badgeSizeResizingRatio: badgeSizeResizingRatio)
    self.centerPosition = centerPosition
  }
  
  public convenience init(for view: UIView, badgeBackgroundColor: UIColor, badgeTextColor: UIColor, badgeSizeResizingRatio: CGFloat = 1) {
    self.init(for: view, badgeSizeResizingRatio: badgeSizeResizingRatio)
    self.badgeBackgroundColor = badgeBackgroundColor
    self.badgeTextColor = badgeTextColor
  }
  
  public convenience init(for view: UIView, in centerPosition: CenterPosition, badgeBackgroundColor: UIColor, badgeTextColor: UIColor, badgeSizeResizingRatio: CGFloat = 1) {
    self.init(for: view, in: centerPosition, badgeSizeResizingRatio: badgeSizeResizingRatio)
    self.badgeBackgroundColor = badgeBackgroundColor
    self.badgeTextColor = badgeTextColor
  }
  
  public convenience init(for view: UIView, badgeSizeResizingRatio: CGFloat = 1, animation: ((UIView) -> Void)?) {
    self.init(for: view, badgeSizeResizingRatio: badgeSizeResizingRatio)
    self.animation = animation
  }
  
  public convenience init(for view: UIView, in centerPosition: CenterPosition, badgeSizeResizingRatio: CGFloat = 1, animation: ((UIView) -> Void)?) {
    self.init(for: view, in: centerPosition, badgeSizeResizingRatio: badgeSizeResizingRatio)
    self.animation = animation
  }
  
  public convenience init(for view: UIView, badgeBackgroundColor: UIColor, badgeTextColor: UIColor, badgeSizeResizingRatio: CGFloat = 1, animation: ((UIView) -> Void)?) {
    self.init(for: view, badgeBackgroundColor: badgeBackgroundColor, badgeTextColor: badgeTextColor, badgeSizeResizingRatio: badgeSizeResizingRatio)
    self.animation = animation
  }
  
  public convenience init(for view: UIView, in centerPosition: CenterPosition, badgeBackgroundColor: UIColor, badgeTextColor: UIColor, badgeSizeResizingRatio: CGFloat = 1, animation: ((UIView) -> Void)?) {
    self.init(for: view, in: centerPosition, badgeBackgroundColor: badgeBackgroundColor, badgeTextColor: badgeTextColor, badgeSizeResizingRatio: badgeSizeResizingRatio)
    self.animation = animation
  }
  
  // add badge to ui view
  func add(with text: String) {
    let badgeView = BadgeImageView(height: badgeHeight,
                                   center: centerPositionCGPoint,
                                   text: text,
                                   badgeBackgroundColor: badgeBackgroundColor,
                                   badgeTextColor: badgeTextColor)
    view.addSubview(badgeView)
    animation?(badgeView)
  }
  
  func remove() { }
  
  func increment() { }
  
  func decrement() { }
}
