<img src='RepositoryImages/default.gif' width='260' alt='default'>
<img src='RepositoryImages/boom.gif' width='260' alt='boom'>
<img src='RepositoryImages/all.gif' width='260' alt='all'>

# BadgeControl
* Simply attach BadgeController to any UIView's subclasses and easily control the badge.
* Customize size, position, background color, text color and animation of the badge.

## Setup (Swift 4.0)
#### Setup with CocoaPods (iOS 9+)
* If you are using CocoaPods add this text to your Podfile and run `pod install`.

~~~ruby 
    pod 'BadgeControl', :git => 'https://github.com/kiwisip/BadgeControl.git'
~~~
### Add source (iOS 9+)
* Add [BadgeController.swift](https://github.com/kiwisip/BadgeControl/blob/master/BadgeControl/BadgeController.swift), [BadgeImageView.swift](https://github.com/kiwisip/BadgeControl/blob/master/BadgeControl/BadgeImageView.swift), [BadgeCenterPosition.swift](https://github.com/kiwisip/BadgeControl/blob/master/BadgeControl/BadgeCenterPosition.swift) and [BadgeAnimations.swift](https://github.com/kiwisip/BadgeControl/blob/master/BadgeControl/BadgeAnimations.swift) to your project.

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
You can customize badge's text font, background color, text color, size, center position and animation.

#### Text font, background color, text color and size
~~~swift
badge.badgeTextFont = UIFont.systemFont(ofSize: 15)
badge.badgeBackgroundColor = UIColor.blue
badge.badgeTextColor = UIColor.yellow
badge.badgeSizeResizingRatio = 2 // badge will be 2x bigger than default
~~~

#### Center position
You can choose following center positions: upperLeftCorner, upperRightCorner, lowerLeftCorner, lowerRightCorner. 

You can also choose custom position by calling .custom(x: Double, y: Double).

~~~swift
badge.centerPosition = .upperLeftCorner
badge.centerPosition = .custom(x: 10, y: 20)
~~~

#### Animations
You can choose one of the following animations:

###### Default animation
<img src='RepositoryImages/default.gif' width='170' alt='default'>

~~~swift
badge.animation = BadgeAnimations.default
~~~

###### Left-right animation
<img src='RepositoryImages/leftRight.gif' width='170' alt='default'>

~~~swift
badge.animation = BadgeAnimations.leftRight
~~~

###### Right-left animation
<img src='RepositoryImages/rightLeft.gif' width='170' alt='default'>

~~~swift
badge.animation = BadgeAnimations.rightLeft
~~~

###### Fade in animation
<img src='RepositoryImages/fadeIn.gif' width='170' alt='default'>

~~~swift
badge.animation = BadgeAnimations.fadeIn
~~~

###### Roll animation
<img src='RepositoryImages/roll.gif' width='170' alt='default'>

~~~swift
badge.animation = BadgeAnimations.roll
~~~

###### Custom
You can also provide your own animation of type ((UIView) -> Void).

~~~swift
badge.animation = { badgeView in
    ...
  }
~~~

#### Initialization
You can use one of these initalizers for your convenience:

~~~swift
init(for view: UIView, badgeSizeResizingRatio: CGFloat = 1)
init(for view: UIView, in centerPosition: CenterPosition, badgeSizeResizingRatio: CGFloat = 1)
init(for view: UIView, badgeBackgroundColor: UIColor, badgeTextColor: UIColor, badgeSizeResizingRatio: CGFloat = 1)
init(for view: UIView, in centerPosition: CenterPosition, badgeBackgroundColor: UIColor, badgeTextColor: UIColor, badgeSizeResizingRatio: CGFloat = 1)
init(for view: UIView, badgeSizeResizingRatio: CGFloat = 1, animation: ((UIView) -> Void)?)
init(for view: UIView, in centerPosition: CenterPosition, badgeSizeResizingRatio: CG Float = 1, animation: ((UIView) -> Void)?)
init(for view: UIView,badgeBackgroundColor: UIColor, badgeTextColor: UIColor, badgeSizeResizingRatio: CGFloat = 1, animation: ((UIView) -> Void)?)
init(for view: UIView, in centerPosition: CenterPosition, badgeBackgroundColor: UIColor, badgeTextColor: UIColor, badgeSizeResizingRatio: CGFloat = 1, animation: ((UIView) -> Void)?)

~~~

## License

BadgeControl is released under the [MIT License](LICENSE).

## Feedback is welcome

If you've found a bug or want to improve BadgeControl feel free to create an issue.
