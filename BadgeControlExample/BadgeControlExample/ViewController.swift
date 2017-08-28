//
//  ViewController.swift
//  BadgeControl
//
//  Created by Robin Krenecky on 19.08.17.
//  Copyright © 2017 Robin Krenecky. All rights reserved.
//

import UIKit
import BadgeControl

class ViewController: UIViewController, UITextFieldDelegate {
  
  @IBOutlet weak var imageView: UIImageView!
  @IBOutlet weak var badgeTitleTextField: UITextField!
  
  private var upperLeftBadge: BadgeController!
  private var upperRightBadge: BadgeController!
  private var lowerLeftBadge: BadgeController!
  private var lowerRightBadge: BadgeController!
  
  private var badges: [BadgeController] = []
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    badgeTitleTextField.delegate = self
    
    upperLeftBadge = BadgeController(for: imageView,
                                     in: .upperLeftCorner,
                                     badgeBackgroundColor: UIColor.blue,
                                     badgeTextColor: UIColor.yellow,
                                     badgeSizeResizingRatio: 0.75)
    upperRightBadge = BadgeController(for: imageView)
    lowerLeftBadge = BadgeController(for: imageView,
                                     in: .lowerLeftCorner,
                                     badgeBackgroundColor: UIColor.purple,
                                     badgeTextColor: UIColor.cyan)
    lowerRightBadge = BadgeController(for: imageView,
                                      in: .lowerRightCorner,
                                      badgeBackgroundColor: UIColor.brown,
                                      badgeTextColor: UIColor.green,
                                      badgeSizeResizingRatio: 0.5)
    
    badges = [upperLeftBadge, upperRightBadge, lowerLeftBadge, lowerRightBadge]
  }
  
  @IBAction func changeAnimation(_ sender: UISegmentedControl) {
    guard let title = sender.titleForSegment(at: sender.selectedSegmentIndex) else { return }
    
    switch title {
    case "default": badges.forEach { $0.animation = BadgeAnimations.defaultAnimation }
    case "leftRight": badges.forEach { $0.animation = BadgeAnimations.leftRight }
    case "rightLeft": badges.forEach { $0.animation = BadgeAnimations.rightLeft }
    case "fadeIn": badges.forEach { $0.animation = BadgeAnimations.fadeIn }
    case "roll": badges.forEach { $0.animation = BadgeAnimations.roll }
    default: return
    }
  }
  
  @IBAction func add(_ sender: UIButton) {
    guard let text = badgeTitleTextField.text, text != "" else { return }
    badges.forEach { $0.addOrReplaceCurrent(with: text, animated: true) }
  }
  
  @IBAction func remove(_ sender: UIButton) {
    badges.forEach { $0.remove() }
  }
  
  @IBAction func increment(_ sender: UIButton) {
    badges.forEach { $0.increment(animated: true) }
  }
  
  @IBAction func decrement(_ sender: UIButton) {
    badges.forEach { $0.decrement(animated: true) }
  }
  
  func textFieldShouldReturn(_ textField: UITextField) -> Bool {
    textField.resignFirstResponder()
    return true
  }
}
