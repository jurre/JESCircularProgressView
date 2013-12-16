//
//  JESAppDelegate.m
//  JESCircularProgressView
//
//  Created by Jurre Stender on 15/12/13.
//  Copyright (c) 2013 jurrestender. All rights reserved.
//

#import "JESAppDelegate.h"

@implementation JESAppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification {
    self.circularIndicator.animationDuration = 0.5;
    self.circularIndicator.outerLineWidth = 2;
    self.circularIndicator.progressLineWidth = 10;
    [self.circularIndicator setProgress:0.5 animated:YES];
}

- (IBAction)setProgressAnimated:(id)sender {
    CGFloat foo = [self.slider doubleValue] / 100.0f;
    [self.circularIndicator setProgress:foo animated:YES];
}

- (IBAction)setProgress:(id)sender {
    CGFloat foo = [self.slider doubleValue] / 100.0f;
    [self.circularIndicator setProgress:foo animated:NO];
}

@end
