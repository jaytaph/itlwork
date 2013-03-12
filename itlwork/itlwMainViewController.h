//
//  itlwMainViewController.h
//  itlwork
//
//  Created by Joshua Thijssen on 11-03-13.
//  Copyright (c) 2013 NoxLogic. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface itlwMainViewController : NSWindowController <NSTableViewDataSource, NSTableViewDelegate>

@property (weak) IBOutlet NSTextField *MessageBox;
@property (weak) IBOutlet NSTextField *MessageLength;
@property (weak) IBOutlet NSTableView *TweetTable;

@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;
@property (readonly, strong, nonatomic) NSManagedObjectModel *managedObjectModel;
@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext;

@end
