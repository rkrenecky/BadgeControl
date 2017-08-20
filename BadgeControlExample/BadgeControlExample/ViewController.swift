//
//  ViewController.swift
//  BadgeControl
//
//  Created by Robin Krenecky on 19.08.17.
//  Copyright © 2017 Robin Krenecky. All rights reserved.
//

import UIKit
import BadgeControl

class ViewController: UIViewController {

  @IBOutlet weak var imageView: UIButton!
  
  var first: BadgeController?
  var second: BadgeController?
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    first = BadgeController(for: imageView, in: .lowerLeftCorner, badgeBackgroundColor: UIColor.black, badgeTextColor: UIColor.green, badgeSizeResizingRatio: 1)
    first?.addOrReplaceCurrent(with: "99", animated: false)
    
    second = BadgeController(for: imageView, in: .upperRightCorner, badgeBackgroundColor: UIColor.blue, badgeTextColor: UIColor.yellow, badgeSizeResizingRatio: 0.8)
  }
  
  @IBAction func touch(_ sender: UIButton) {
    first?.increment(animated: true)
    second?.increment(animated: true)
  }
}
