//
//  JESCircularProgressView.h
//  JESCircularProgressView
//
//  Created by Jurre Stender on 15/12/13.
//  Copyright (c) 2013 jurrestender. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface JESCircularProgressView : NSView

/**
 *  The current progress is represented by a floating-point value between 0.0 and 1.0, 
 *  inclusive, where 1.0 indicates the completion of the task. The default value is 0.0. 
 *  Values less than 0.0 and greater than 1.0 are pinned to those limits.
 */
@property (nonatomic, assign) CGFloat progress;

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

/**
 *  Adjusts the current progress shown by the receiver, optionally animating the change.
 *
 *  @param progress The new progress value
 *  @param animated `YES` if the change should be animated, `NO` if the change should happen immediately.
 */
- (void)setProgress:(CGFloat)progress animated:(BOOL)animated;

@end
	