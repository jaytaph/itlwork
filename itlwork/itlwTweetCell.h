//
//  itlwTweetCell
//  itlwork
//
//  Created by Joshua Thijssen on 08-03-13.
//  Copyright (c) 2013 NoxLogic. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface itlwTweetCell : NSTableCellView

@property (strong) IBOutlet NSImageCell *image;
@property (strong) IBOutlet NSTextField *tweet;
@property (strong) IBOutlet NSTextField *date;
@property (strong) IBOutlet NSTextField *via;
@property (strong) IBOutlet NSTextField *name;
@property (strong) IBOutlet NSTextField *followers;

@end
