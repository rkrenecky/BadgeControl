//
//  CenterPosition.swift
//  BadgeControl
//
//  Created by Robin Krenecky on 19.08.17.
//  Copyright © 2017 Robin Krenecky. All rights reserved.
//

import UIKit

public enum BadgeCenterPosition {
  case upperLeftCorner
  case upperRightCorner
  case lowerLeftCorner
  case lowerRightCorner
  case custom(x: Double, y: Double)
  
  public func centerPoint(in view: UIView) -> CGPoint {
    switch self {
    case .upperLeftCorner:
      return CGPoint(x: 0, y: 0)
    case .upperRightCorner:
      return CGPoint(x: view.frame.width, y: 0)
    case .lowerLeftCorner:
      return CGPoint(x: 0, y: view.frame.height)
    case .lowerRightCorner:
      return CGPoint(x: view.frame.width, y: view.frame.height)
    case .custom(let x, let y):
      return CGPoint(x: x, y: y)
    }
  }
}
