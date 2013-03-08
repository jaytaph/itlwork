//
//  itlwAppDelegate.h
//  itlwork
//
//  Created by Joshua Thijssen on 07-03-13.
//  Copyright (c) 2013 NoxLogic. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface itlwAppDelegate : NSObject <NSApplicationDelegate>

@property (assign) IBOutlet NSWindow *window;

- (BOOL) textField: (NSTextField *) textField shouldChangeCharactersInRange: (NSRange) range replacementString: (NSString *) string;

@end
