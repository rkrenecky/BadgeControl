//
//  BadgeAnimations.swift
//  BadgeControl
//
//  Created by Robin Krenecky on 21.08.17.
//

import Foundation

public typealias BadgeAnimation = (UIView) -> Void

public struct BadgeAnimations {

  public static var defaultAnimation: BadgeAnimation = { badgeView in
    badgeView.transform = CGAffineTransform(scaleX: 2.7, y: 2.7)
    UIView.animate(
        withDuration: 0.5,
        delay: 0,
        usingSpringWithDamping: 0.5,
        initialSpringVelocity: 0.5,
        options: .curveEaseIn,
        animations: { badgeView.transform = CGAffineTransform.identity },
        completion: nil)
  }

  public static var leftRight: BadgeAnimation = { badgeView in
    let travelDistance = badgeView.frame.width * 1.5
    badgeView.center.x -= travelDistance
    UIView.animate(
        withDuration: 0.5,
        delay: 0,
        usingSpringWithDamping: 0.5,
        initialSpringVelocity: 0.5,
        options: .curveEaseOut,
        animations: { badgeView.center.x += travelDistance },
        completion: nil)
  }

  public static var rightLeft: BadgeAnimation = { badgeView in
    let travelDistance = badgeView.frame.width * 1.5
    badgeView.center.x += travelDistance
    UIView.animate(
        withDuration: 0.5,
        delay: 0,
        usingSpringWithDamping: 0.5,
        initialSpringVelocity: 0.5,
        options: .curveEaseOut,
        animations: { badgeView.center.x -= travelDistance },
        completion: nil)
  }

  public static var fadeIn: BadgeAnimation = { badgeView in
    badgeView.alpha = 0
    UIView.animate(
        withDuration: 1.5,
        delay: 0,
        usingSpringWithDamping: 1,
        initialSpringVelocity: 0.1,
        options: .curveEaseIn,
        animations: { badgeView.alpha = 1 },
        completion: nil)
  }

  public static var rolling: BadgeAnimation = { badgeView in
    badgeView.transform = CGAffineTransform(rotationAngle: .pi)
    UIView.animate(
        withDuration: 0.5,
        delay: 0,
        usingSpringWithDamping: 1,
        initialSpringVelocity: 0.5,
        options: .curveEaseIn,
        animations: { badgeView.transform = CGAffineTransform.identity },
        completion: nil)
  }

}
