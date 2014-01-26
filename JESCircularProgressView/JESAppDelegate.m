//
//  JESAppDelegate.m
//  JESCircularProgressView
//
//  Created by Jurre Stender on 15/12/13.
//  Copyright (c) 2013 jurrestender. All rights reserved.
//

#import "JESAppDelegate.h"

@interface JESAppDelegate ()

@property CGFloat timerProgress;
@property NSTimer *timer;

@end

@implementation JESAppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification {
    self.circularIndicator.animationDuration = 0.5;
    self.circularIndicator.outerLineWidth = 2;
    self.circularIndicator.progressLineWidth = 7;
//    self.circularIndicator.tintColor = [NSColor redColor];

    self.timer = [NSTimer scheduledTimerWithTimeInterval:1.0f target:self selector:@selector(tick) userInfo:Nil repeats:YES];
}

- (void)tick {
    if (self.timerProgress >= 1) {
        self.timer = nil;
    } else {
        self.timerProgress += arc4random() % 11 * 0.03;
        [self.circularIndicator setProgress:self.timerProgress animated:YES];
    }
}

- (IBAction)setProgressAnimated:(id)sender {
    CGFloat progress = [self.slider doubleValue] / 100.0f;
    [self.circularIndicator setProgress:progress animated:YES];
}

- (IBAction)setProgress:(id)sender {
    CGFloat progress = [self.slider doubleValue] / 100.0f;
    [self.circularIndicator setProgress:progress animated:NO];
}

@end
