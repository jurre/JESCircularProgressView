# JESCircularProgressView

A little circular progress view for OSX that looks like the one used in the App Store.

![screenshot](https://raw.github.com/jurre/JESCircularProgressView/master/screenshots/progress.gif)

# Installing

Install it with the cocoapods:

```ruby
pod "JESCircularProgressView"
```

# Usage:

```objective-c

// YourAwesomeThing.h
#import "JESCircularProgressView.h"

...

@property (assign) IBOutlet JESCircularProgressView *circularProgressView;

// YourAwesomeThing.m

...

// And then you can be all like:
[self.circularProgressView setProgress:progress animated:YES];

// Or you could be like:
self.circularProgressView.progress = progress;
// But I made the whole animating thing so you might as well use it, right!?
```

## Configuring things

There's a few things you can configure:

```objective-c
/**
 *  The line width of the progress indicator.
 */
@property (nonatomic, assign) CGFloat progressLineWidth;

/**
 *  The line width of the outer circle.
 */
@property (nonatomic, assign) CGFloat outerLineWidth;

/**
 *  The duration of each animation.
 */
@property (nonatomic, assign) CGFloat animationDuration;

/**
 *  The color of the outer circle and progress line.
 */
@property (nonatomic, strong) NSColor *tintColor;
```
