//
//  itlwAppDelegate.h
//  itlwork
//
//  Created by Joshua Thijssen on 07-03-13.
//  Copyright (c) 2013 NoxLogic. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "itlwMainViewController.h"

@class itlwMainViewController;

itlwMainViewController *mainViewController;

@interface itlwAppDelegate : NSObject <NSApplicationDelegate>

@property (assign) IBOutlet NSWindow *window;
@property (nonatomic, retain) IBOutlet itlwMainViewController *myVC;

@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;
@property (readonly, strong, nonatomic) NSManagedObjectModel *managedObjectModel;
@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext;

@property (unsafe_unretained) IBOutlet NSViewController *mainViewController;

@end


