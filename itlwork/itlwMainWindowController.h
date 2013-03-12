//
//  itlwMainViewController.h
//  itlwork
//
//  Created by Joshua Thijssen on 11-03-13.
//  Copyright (c) 2013 NoxLogic. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface itlwMainWindowController : NSWindowController <NSTableViewDataSource, NSTableViewDelegate>

// Connections to our interface
@property (weak) IBOutlet NSTextField *MessageBox;
@property (weak) IBOutlet NSTextField *MessageLength;
@property (weak) IBOutlet NSTableView *TweetTable;
@property (weak) IBOutlet NSButton    *TweetButton;
- (IBAction)tweetButtonCliq:(NSButton *)sender;

@property NSManagedObjectModel *managedObjectModel;
@property NSManagedObjectContext *managedObjectContext;

@end
