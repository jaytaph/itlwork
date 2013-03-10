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

@property (strong) IBOutlet NSImageView *image;
@property (strong) IBOutlet NSTextField *tweet;
@property (strong) IBOutlet NSTextField *date;
@property (strong) IBOutlet NSTextField *via;
@property (strong) IBOutlet NSTextField *name;
@property (strong) IBOutlet NSTextField *followers;
@property (strong) IBOutlet NSManagedObjectContext *ManagedObjectContext;

@end
