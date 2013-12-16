//
//  JESAppDelegate.h
//  JESCircularProgressView
//
//  Created by Jurre Stender on 15/12/13.
//  Copyright (c) 2013 jurrestender. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "JESCircularProgressView.h"

@interface JESAppDelegate : NSObject <NSApplicationDelegate>

@property (assign) IBOutlet NSWindow *window;
@property (assign) IBOutlet JESCircularProgressView *circularIndicator;
@property (assign) IBOutlet NSSlider *slider;

- (IBAction)setProgressAnimated:(id)sender;

@end
