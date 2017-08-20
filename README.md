# BadgeControl
* Simply attach BadgeController to any UIView's subclasses and easily control the badge
* Customize size, position, background color, text color and animation of the badge

## Setup (Swift 4.0)
#### Setup with CocoaPods (iOS 10+)
* If you are using CocoaPods add this text to your Podfile and run `pod install`.

~~~ruby 
    pod 'BadgeControl', :git => 'https://github.com/kiwisip/BadgeControl.git', :tag => '1.0.3'
~~~
### Add source (iOS 9+)
* Add [BadgeController.swift](https://github.com/kiwisip/BadgeControl/blob/master/BadgeControl/BadgeController.swift), [BadgeImageView.swift](https://github.com/kiwisip/BadgeControl/blob/master/BadgeControl/BadgeImageView.swift) and [CenterPosition.swift](https://github.com/kiwisip/BadgeControl/blob/master/BadgeControl/CenterPosition.swift) to your project.

## Usage
Add `import BadgeControl` to your source code (unless you used the file setup method). <br><br>
Simply attach BadgeController to your UIView (or its subclass).

~~~swift
let badge = BadgeController(for: myUIView)
~~~

Add a text to your badge and present it with animation.
~~~swift
badge.addOrReplaceCurrent(with text: "1", animated: true)
~~~

Remove badge from its view.

~~~swift
badge.remove()
~~~

Simply increment or decrement the value on your badge (if it is numeric) and present it with animation.

~~~swift
badge.increment(animated: true)
badge.decrement(animated: true)
~~~


## Customization
You can customize badge's text font, size (with ratio), center position, background color, text color and animation.

~~~swift
badge.badgeTextFont = UIFont.systemFont(ofSize: 15)
badge.badgeSizeResizingRatio = 2 // badge will be 2x bigger than default

/* You can choose following center positions: upperLeftCorner, upperRightCorner, lowerLeftCorner, lowerRightCorner.
You can also choose default position by calling .custom(x: Double, y: Double)
*/
badge.centerPosition = .upperLeftCorner
badge.badgeBackgroundColor = UIColor.blue
badge.badgeTextColor = UIColor.yellow
badge.animation: ((UIView) -> Void)? = { }
~~~


You can use one of these initalizers for your convenience:

~~~swift
init(for view: UIView, badgeSizeResizingRatio: CGFloat = 1)
init(for view: UIView, in centerPosition: CenterPosition, badgeSizeResizingRatio: CGFloat = 1)
init(for view: UIView, badgeBackgroundColor: UIColor, badgeTextColor: UIColor, badgeSizeResizingRatio: CGFloat = 1)
init(for view: UIView, in centerPosition: CenterPosition, badgeBackgroundColor: UIColor, badgeTextColor: UIColor, badgeSizeResizingRatio: CGFloat = 1)
init(for view: UIView, badgeSizeResizingRatio: CGFloat = 1, animation: ((UIView) -> Void)?)
init(for view: UIView, in centerPosition: CenterPosition, badgeSizeResizingRatio: CG Float = 1, animation: ((UIView) -> Void)?
init(for view: UIView,badgeBackgroundColor: UIColor, badgeTextColor: UIColor, badgeSizeResizingRatio: CGFloat = 1, animation: ((UIView) -> Void)?)
init(for view: UIView, in centerPosition: CenterPosition, badgeBackgroundColor: UIColor, badgeTextColor: UIColor, badgeSizeResizingRatio: CGFloat = 1, animation: ((UIView) -> Void)?

~~~