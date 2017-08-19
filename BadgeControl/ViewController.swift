//
//  ViewController.swift
//  BadgeControl
//
//  Created by Robin Krenecky on 19.08.17.
//  Copyright © 2017 Robin Krenecky. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

  @IBOutlet weak var imageView: UIButton!
  
  var counter = 1
  
  var badgeController: BadgeController?
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    badgeController = BadgeController(for: imageView, badgeSizeResizingRatio: 1.5)
    
    //    ...
    //    contr.increment(animated: true)
    //    contr.decrement(animated: false)
    //    change animation
    //    contr.animation = nil
    //    contr.badge.backgroundColor = UIColor.blue
    //    contr.badge.textColor = ...
    //    ...
  }
  
  @IBAction func touch(_ sender: UIButton) {
    badgeController?.add(with: "\(counter)")
    counter += 1
  }
}

