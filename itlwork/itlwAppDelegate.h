//
//  itlwAppDelegate.h
//  itlwork
//
//  Created by Joshua Thijssen on 07-03-13.
//  Copyright (c) 2013 NoxLogic. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import <Growl/Growl.h>

@interface itlwAppDelegate : NSObject <NSApplicationDelegate>

@property (assign) IBOutlet NSWindow *window;

@property (weak) IBOutlet NSTextField *MessageBox;
@property (weak) IBOutlet NSTextField *MessageLength;
@property (weak) IBOutlet NSTableView *TweetTable;

@end
