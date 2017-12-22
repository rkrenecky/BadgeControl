//
//  BadgeController.swift
//  BadgeControl
//
//  Created by Robin Krenecky on 19.08.17.
//  Copyright © 2017 Robin Krenecky. All rights reserved.
//

import UIKit


public class BadgeController {

  // MARK: Public properties

  public var badgeTextFont: UIFont
  public var badgeSizeResizingRatio: CGFloat
  public var centerPosition: BadgeCenterPosition = .upperRightCorner
  public var badgeBackgroundColor = UIColor.red
  public var badgeTextColor = UIColor.white
  public var borderWidth: CGFloat = 0.0
  public var borderColor = UIColor.black
  public var animation: ((UIView) -> Void)? = BadgeAnimations.defaultAnimation

  public var animateOnlyWhenBadgeIsNotYetPresent = false

  // MARK: Private properties

  private unowned var view: UIView
  private var badgeHeight: Int
  private var currentBadge: BadgeImageView? = nil
  private var counter: Int? = nil
  private var centerPositionCGPoint: CGPoint { return centerPosition.getCenterPoint(in: view) }

  // MARK: Initializers

  public init(for view: UIView,
              badgeSizeResizingRatio: CGFloat = 1) {

    self.view = view
    self.badgeSizeResizingRatio = badgeSizeResizingRatio
    self.badgeHeight = Int(view.frame.height / 1.35 * badgeSizeResizingRatio)
    self.badgeTextFont = UIFont.systemFont(ofSize: CGFloat(badgeHeight) * 23 / 32)
  }

  public convenience init(for view: UIView,
                          in centerPosition: BadgeCenterPosition,
                          badgeSizeResizingRatio: CGFloat = 1) {

    self.init(for: view, badgeSizeResizingRatio: badgeSizeResizingRatio)
    self.centerPosition = centerPosition
  }

  public convenience init(for view: UIView,
                          badgeBackgroundColor: UIColor,
                          badgeTextColor: UIColor,
                          badgeSizeResizingRatio: CGFloat = 1) {

    self.init(for: view, badgeSizeResizingRatio: badgeSizeResizingRatio)
    self.badgeBackgroundColor = badgeBackgroundColor
    self.badgeTextColor = badgeTextColor
  }

  public convenience init(for view: UIView,
                          in centerPosition: BadgeCenterPosition,
                          badgeBackgroundColor: UIColor,
                          badgeTextColor: UIColor,
                          badgeSizeResizingRatio: CGFloat = 1) {

    self.init(for: view, in: centerPosition, badgeSizeResizingRatio: badgeSizeResizingRatio)
    self.badgeBackgroundColor = badgeBackgroundColor
    self.badgeTextColor = badgeTextColor
  }

  public convenience init(for view: UIView,
                          badgeSizeResizingRatio: CGFloat = 1,
                          animation: ((UIView) -> Void)?) {

    self.init(for: view, badgeSizeResizingRatio: badgeSizeResizingRatio)
    self.animation = animation
  }

  public convenience init(for view: UIView,
                          in centerPosition: BadgeCenterPosition,
                          badgeSizeResizingRatio: CGFloat = 1,
                          animation: ((UIView) -> Void)?) {

    self.init(for: view, in: centerPosition, badgeSizeResizingRatio: badgeSizeResizingRatio)
    self.animation = animation
  }

  public convenience init(for view: UIView,
                          badgeBackgroundColor: UIColor,
                          badgeTextColor: UIColor,
                          badgeSizeResizingRatio: CGFloat = 1,
                          animation: ((UIView) -> Void)?) {

    self.init(for: view,
              badgeBackgroundColor: badgeBackgroundColor,
              badgeTextColor: badgeTextColor,
              badgeSizeResizingRatio: badgeSizeResizingRatio)
    self.animation = animation
  }

  public convenience init(for view: UIView,
                          in centerPosition: BadgeCenterPosition,
                          badgeBackgroundColor: UIColor,
                          badgeTextColor: UIColor,
                          badgeSizeResizingRatio: CGFloat = 1,
                          animation: ((UIView) -> Void)?) {

    self.init(for: view,
              in: centerPosition,
              badgeBackgroundColor: badgeBackgroundColor,
              badgeTextColor: badgeTextColor,
              badgeSizeResizingRatio: badgeSizeResizingRatio)
    self.animation = animation
  }

  // MARK: Public methods

  public func addOrReplaceCurrent(with text: String, animated: Bool) {
    var animated = animated
    if currentBadge != nil {
      remove(animated: false)
      if animateOnlyWhenBadgeIsNotYetPresent { animated = false }
    }
    let badgeView = BadgeImageView(height: badgeHeight + Int(borderWidth * 2),
                                   center: centerPositionCGPoint,
                                   text: text,
                                   badgeBackgroundColor: badgeBackgroundColor,
                                   badgeTextColor: badgeTextColor,
                                   badgeTextFont: badgeTextFont)
    currentBadge = badgeView
    counter = Int(text)
    view.addSubview(badgeView)
    if animated { animation?(badgeView) }
  }

  public func remove(animated: Bool) {
    if animated, let currentBadge = currentBadge {
      removeBadgeWithAnimation(currentBadge)
      return
    }

    currentBadge?.removeFromSuperview()
    currentBadge = nil
    counter = nil
  }

  public func increment(animated: Bool) {
    if currentBadge != nil {
      guard let counter = counter else {
        print("Cannot increment non-numeric value")
        return
      }
      addOrReplaceCurrent(with: "\(counter + 1)", animated: animated)
    } else {
      addOrReplaceCurrent(with: ("1"), animated: animated)
    }
  }

  public func decrement(animated: Bool) {
    if currentBadge != nil {
      guard let counter = counter else {
        print("Cannot decrement non-numeric value")
        return
      }
      if counter > 1 {
        addOrReplaceCurrent(with: "\(counter - 1)", animated: animated)
      } else {
        remove(animated: animated)
      }
    }
  }

  private func removeBadgeWithAnimation(_ badge: BadgeImageView) {
    UIView.animate(withDuration: 0.7,
                   delay: 0,
                   usingSpringWithDamping: 1,
                   initialSpringVelocity: 0.3,
                   options: .curveLinear,
                   animations: {
                    badge.transform = CGAffineTransform(scaleX: 0.01, y: 0.01)
                    badge.alpha = 0

    },
                   completion: { _ in
                    self.remove(animated: false)
    })
  }
}
