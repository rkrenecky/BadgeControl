//
//  ViewController.swift
//  BadgeControl
//
//  Created by Robin Krenecky on 19.08.17.
//  Copyright © 2017 Robin Krenecky. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
  
  @IBOutlet weak var imageView: UIImageView!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    let badge = BadgeImageView(height: 200, center: CGPoint(x: 100, y: 100), text: "1", badgeColor: UIColor.red, textColor: UIColor.white)
    view.addSubview(badge)
    
    //    ...
    //    contr.increment(animated: true)
    //    contr.decrement(animated: false)
    //    change animation
    //    contr.animation = nil
    //    contr.badge.backgroundColor = UIColor.blue
    //    contr.badge.textColor = ...
    //    ...
  }
}

