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

@interface JESCircularProgressView ()

@property (nonatomic, assign) CAShapeLayer *progressLayer;
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
    _progressLineWidth = 4;
    _outerLineWidth = 1;
    _tintColor = [NSColor colorWithDeviceRed:0.139 green:0.449 blue:0.867 alpha:1.000];
    
    _animationDuration = 0.25;

    [self setWantsLayer:YES];

	CAShapeLayer *shape = [CAShapeLayer layer];
	[shape setStrokeColor:[_tintColor CGColor]];
    [shape setFillColor:[[NSColor clearColor] CGColor]];
    shape.lineWidth = _progressLineWidth;
	[self.layer addSublayer:shape];
	_progressLayer = shape;

	[self setProgress:0.0 animated:NO];
}

#pragma mark - Getters/Setters

- (void)setProgressLineWidth:(CGFloat)lineWidth {
	_progressLineWidth = lineWidth;
	[[self progressLayer] setLineWidth:_progressLineWidth];
}

- (void)setTintColor:(NSColor *)tintColor {
    _tintColor = tintColor;
    self.progressLayer.strokeColor = tintColor.CGColor;
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
    [[self progressLayer] setStrokeEnd:_progress];
    [CATransaction commit];
}

- (void)setProgress:(CGFloat)progress {
	[self setProgress:progress animated:NO];
}

#pragma mark - Drawing

- (void)drawRect:(NSRect)dirtyRect {
    [self drawOuterCircle];
    [self drawProgressCircle];
}

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
    if (!self.outerPath) {
        NSGraphicsContext *graphicsContext = [NSGraphicsContext currentContext];
        CGContextRef context = [graphicsContext graphicsPort];
        CGContextSetStrokeColorWithColor(context, [self.tintColor CGColor]);
        CGContextSaveGState(context);

        self.outerPath = [NSBezierPath bezierPathWithOvalInRect:[self outerLineInset]];

        [self.outerPath setLineWidth:1.0f];
        [self.outerPath stroke];

        CGContextRestoreGState(context);
    }
}

# pragma mark - Maths

- (CGFloat)progressInDegrees {
    return self.progress * 360.0f;
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
    return radius;
}

- (CGRect)progressLineInset {
    static CGRect progressLineInset;
    if (CGRectIsEmpty(progressLineInset)) {
        progressLineInset = CGRectInset(self.bounds,
                                        self.progressLineWidth + self.outerLineWidth,
                                        self.progressLineWidth + self.outerLineWidth);
    }
    return progressLineInset;
}

- (CGRect)outerLineInset {
    static CGRect outerLineInset;
    if (CGRectIsEmpty(outerLineInset)) {
        outerLineInset = CGRectInset(self.bounds, self.outerLineWidth, self.outerLineWidth);
    }
    return outerLineInset;
}

- (CGPoint)center {
    static CGPoint center;
    if (CGPointEqualToPoint(CGPointZero, center)) {
        center = CGPointMake(CGRectGetMidX([self progressLineInset]),
                             CGRectGetMidY([self progressLineInset]));
    }
    return center;
}

@end
