//
//  JESCircularProgressView.m
//  JESCircularProgressView
//
//  Created by Jurre Stender on 15/12/13.
//  Copyright (c) 2013 jurrestender. All rights reserved.
//

#import "JESCircularProgressView.h"
#import <Quartz/Quartz.h>
#import "NSBezierPath+BezierPathQuartzUtilities.h"

#define DEFAULT_TINT_COLOR [NSColor colorWithDeviceRed:0.139 green:0.449 blue:0.867 alpha:1.000]

static const CGFloat JESDefaultAnimationDuration = 0.25;
static const CGFloat JESDefaultOuterLineWidth = 1;
static const CGFloat JESDefaultProgressLineWidth = 4;

@interface JESCircularProgressView ()

@property (nonatomic, assign) CAShapeLayer *progressLayer;
@property (nonatomic, assign) CAShapeLayer *outerLayer;
@property (nonatomic, strong) NSBezierPath *progressPath;
@property (nonatomic, strong) NSBezierPath *outerPath;

@end

@implementation JESCircularProgressView

#pragma mark - Initialization

- (id)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
	if (self) {
		[self setDefaultValues];
	}
	return self;
}

- (id)initWithFrame:(NSRect)frameRect {
    self = [super initWithFrame:frameRect];
	if (self) {
		[self setDefaultValues];
	}
	return self;
}

- (void)setDefaultValues {
    _progressLineWidth = JESDefaultProgressLineWidth;
    _outerLineWidth = JESDefaultOuterLineWidth;
    _tintColor = DEFAULT_TINT_COLOR;
    
    _animationDuration = JESDefaultAnimationDuration;

    [self setWantsLayer:YES];

	CAShapeLayer *progressShape = [CAShapeLayer layer];
	[progressShape setStrokeColor:[_tintColor CGColor]];
    [progressShape setFillColor:[[NSColor clearColor] CGColor]];
    progressShape.lineWidth = _progressLineWidth;
	[_layer addSublayer:progressShape];
	_progressLayer = progressShape;


    CAShapeLayer *outerLayer = [CAShapeLayer layer];
	[outerLayer setStrokeColor:[_tintColor CGColor]];
    [outerLayer setFillColor:[[NSColor clearColor] CGColor]];
    outerLayer.lineWidth = _outerLineWidth;
	[_layer addSublayer:outerLayer];
	_outerLayer = outerLayer;

    self.progress = 0;

    [self drawOuterCircle];
    [self drawProgressCircle];
}

#pragma mark - Getters/Setters

- (void)setProgressLineWidth:(CGFloat)lineWidth {
	_progressLineWidth = lineWidth;
	[[self progressLayer] setLineWidth:_progressLineWidth];
    [self setNeedsDisplay:YES];
}

- (void)setTintColor:(NSColor *)tintColor {
    _tintColor = tintColor;
    self.progressLayer.strokeColor = tintColor.CGColor;
    self.outerLayer.strokeColor = tintColor.CGColor;
    [self setNeedsDisplay:YES];
}

- (void)setProgress:(CGFloat)progress animated:(BOOL)animated {
    CGFloat currentProgress = _progress;
    _progress = MAX(MIN(progress, 1), 0);

    [CATransaction begin];
    if (animated) {
        CGFloat delta = fabs(_progress - currentProgress);
        [CATransaction setAnimationDuration:MAX(self.animationDuration, delta * 1.0)];
    } else {
        [CATransaction setDisableActions:YES];
    }
    [self.progressLayer setStrokeStart:0.0];
    [self.progressLayer setStrokeEnd:_progress];
    [CATransaction commit];
}

- (void)setProgress:(CGFloat)progress {
	[self setProgress:progress animated:NO];
}

#pragma mark - Drawing

- (void)drawProgressCircle {
    if (!self.progressPath) { _progressPath = [NSBezierPath bezierPath]; }

    [self.progressPath appendBezierPathWithArcWithCenter:[self center]
                                                  radius:[self radius]
                                              startAngle:90
                                                endAngle:(2.0 * M_PI - M_PI_2) + 90
                                               clockwise:YES];

	self.progressLayer.path = [self.progressPath quartzPath];
	self.progressLayer.frame = self.bounds;
}

- (void)drawOuterCircle {
    if (!_outerPath) {
        _outerPath = [NSBezierPath bezierPath];
        [self.outerPath appendBezierPathWithArcWithCenter:[self center]
                                                   radius:[self radius] + self.progressLineWidth
                                               startAngle:0
                                                 endAngle:(2.0 * M_PI - M_PI_2)
                                                clockwise:YES];
        self.outerLayer.path = [self.outerPath quartzPath];
        self.outerLayer.frame = self.bounds;
        [self.outerLayer setStrokeEnd:1];
    }
}

# pragma mark - Maths

- (CGFloat)progressInDegrees {
    return _progress * 360.0f;
}

- (CGFloat)radius {
    static CGFloat radius;
    if (!radius) {
        CGRect progressLineInset = [self progressLineInset];
        CGFloat width = progressLineInset.size.width;
        CGFloat height = progressLineInset.size.height;
        if (width > height) {
            radius = height / 2.0;
        } else {
            radius = width / 2.0;
        }
    }
    return floor(radius);
}

- (CGRect)progressLineInset {
    static CGRect progressLineInset;
    if (CGRectIsEmpty(progressLineInset)) {
        progressLineInset = CGRectIntegral(CGRectInset(self.bounds,
                                           round(self.progressLineWidth + self.outerLineWidth),
                                           round(self.progressLineWidth + self.outerLineWidth)));
    }
    return progressLineInset;
}

- (CGPoint)center {
    static CGPoint center;
    if (CGPointEqualToPoint(CGPointZero, center)) {
        center = CGPointMake(round(CGRectGetMidX([self progressLineInset])),
                             round(CGRectGetMidY([self progressLineInset])));
    }
    return center;
}

@end
