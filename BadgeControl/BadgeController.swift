//
//  BadgeController.swift
//  BadgeControl
//
//  Created by Robin Krenecky on 19.08.17.
//  Copyright © 2017 Robin Krenecky. All rights reserved.
//

import UIKit

open class BadgeController {

  // MARK: Public properties

  public var centerPosition: BadgeCenterPosition
  public var badgeBackgroundColor: UIColor
  public var badgeTextColor: UIColor
  public var badgeTextFont: UIFont
  public var borderWidth: CGFloat
  public var borderColor: UIColor
  public var animation: ((UIView) -> Void)?
  public var badgeHeight: Int
  public var currentBadge: BadgeImageView?

  public var animateOnlyWhenBadgeIsNotYetPresent: Bool

  // MARK: Private properties

  private weak var view: UIView?
  private var counter: Int? = nil
  private var centerPositionCGPoint: CGPoint? {
    guard let view = view else { return nil }
    return centerPosition.centerPoint(in: view)
  }

  // MARK: Initializers

  public init(for view: UIView,
              in centerPosition: BadgeCenterPosition = .upperRightCorner,
              badgeBackgroundColor: UIColor = .red,
              badgeTextColor: UIColor = .white,
              badgeTextFont: UIFont? = nil,
              borderWidth: CGFloat = 0.0,
              borderColor: UIColor = .black,
              animation: BadgeAnimation? = BadgeAnimations.defaultAnimation,
              badgeHeight: Int? = nil,
              animateOnlyWhenBadgeIsNotYetPresent: Bool = false) {

    self.view = view
    self.centerPosition = centerPosition
    self.badgeBackgroundColor = badgeBackgroundColor
    self.badgeTextColor = badgeTextColor
    self.borderWidth = borderWidth
    self.borderColor = borderColor
    self.animation = animation
    self.animateOnlyWhenBadgeIsNotYetPresent = animateOnlyWhenBadgeIsNotYetPresent

    if let badgeHeight = badgeHeight {
      self.badgeHeight = badgeHeight
    } else {
      self.badgeHeight = Int(view.frame.height / 1.35)
    }

    if let badgeTextFont = badgeTextFont {
      self.badgeTextFont = badgeTextFont
    } else {
      self.badgeTextFont = UIFont.systemFont(ofSize: CGFloat(self.badgeHeight) * 23 / 32)
    }
  }

  // MARK: Public methods

  public func addOrReplaceCurrent(with text: String? = nil, animated: Bool) {
    var animated = animated
    if currentBadge != nil {
      remove(animated: false)
      if animateOnlyWhenBadgeIsNotYetPresent { animated = false }
    }

    guard let centerPositionPoint = centerPositionCGPoint else { return }
    let badgeView = BadgeImageView(height: badgeHeight + Int(borderWidth * 2),
                                   center: centerPositionPoint,
                                   text: text ?? "",
                                   badgeBackgroundColor: badgeBackgroundColor,
                                   badgeTextColor: badgeTextColor,
                                   badgeTextFont: badgeTextFont,
                                   borderWidth: borderWidth,
                                   borderColor: borderColor)
    currentBadge = badgeView
    counter = Int(text ?? "")
    view?.addSubview(badgeView)
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
      addOrReplaceCurrent(with: "1", animated: animated)
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
