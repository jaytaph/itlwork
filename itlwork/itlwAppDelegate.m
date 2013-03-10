//
//  itlwAppDelegate.m
//  itlwork
//
//  Created by Joshua Thijssen on 07-03-13.
//  Copyright (c) 2013 NoxLogic. All rights reserved.
//

#import "itlwAppDelegate.h"
#import "itlwMainTweetController.h"

@implementation itlwAppDelegate

@synthesize MessageBox;
@synthesize MessageLength;
@synthesize TweetTable;

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{
    // create columns for our table
    NSTableColumn *column1 = [[NSTableColumn alloc] initWithIdentifier:@"Col1"];
    NSTableColumn *column2 = [[NSTableColumn alloc] initWithIdentifier:@"Col2"];
    [column1 setWidth:250];
    [column2 setWidth:250];
    
    NSTableHeaderCell *header1 = [[NSTableHeaderCell alloc] initTextCell:@"Header1"];
    NSTableHeaderCell *header2 = [[NSTableHeaderCell alloc] initTextCell:@"Header2"];
    [column1 setHeaderCell:header1];
    [column2 setHeaderCell:header2];
    
    // generally you want to add at least one column to the table view.
    [TweetTable removeTableColumn:[[TweetTable tableColumns] lastObject]];
    [TweetTable addTableColumn:column1];
    [TweetTable addTableColumn:column2];
    [TweetTable reloadData];
    
    [itlwMainTweetController loadTweets];
}

- (void)controlTextDidChange:(NSNotification *)notification {
    NSTextField *textField = [notification object];

    NSInteger left = 140 - [[textField stringValue] length];
    NSString *s = [NSString stringWithFormat:@"%li", left];

    if (left < 0) {
        [MessageLength setTextColor:[NSColor redColor]];
    } else if (left < 14) {
        [MessageLength setTextColor:[NSColor blueColor]];
    } else {
        [MessageLength setTextColor:[NSColor blackColor]];
    }

    [MessageLength setStringValue: s];
}


- (IBAction)sendTweetClick:(id)sender {
    
    NSString *msg = [MessageBox stringValue];
    if ([msg length] == 0) return;

    // Reset tweet box and counter
    [MessageBox setStringValue:@""];
    [MessageLength setStringValue:@"140"];  // @TODO: This should be triggered instead of manually added i guess.

    // Load image from URL
    NSURL * imageURL = [NSURL URLWithString:@"https://si0.twimg.com/profile_images/3298514384/de0bf3eb346caaded1d069a83b7066cd_bigger.jpeg"];
    NSData *imageData = [NSData dataWithContentsOfURL:imageURL];
    
    
    // Send growl notification
    [GrowlApplicationBridge notifyWithTitle:@"@JayTaph:"
                                description:msg
                           notificationName:@"tweetReceived"
                                   iconData:imageData
                                   priority:0
                                   isSticky:NO
                               clickContext:nil];
}


@end
