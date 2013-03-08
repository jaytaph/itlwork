//
//  itlwAppDelegate.m
//  itlwork
//
//  Created by Joshua Thijssen on 07-03-13.
//  Copyright (c) 2013 NoxLogic. All rights reserved.
//

#import "itlwAppDelegate.h"

@implementation itlwAppDelegate

@synthesize MessageBox;
@synthesize MessageLength;

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{
    // Insert code here to initialize your application
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
    
    // Load image from URL
    NSURL * imageURL = [NSURL URLWithString:@"https://si0.twimg.com/profile_images/3298514384/de0bf3eb346caaded1d069a83b7066cd_bigger.jpeg"];
    NSData *imageData = [NSData dataWithContentsOfURL:imageURL];
    
    
    // Send growl notification
    [GrowlApplicationBridge notifyWithTitle:@"@JayTaph:"
                                description:[MessageBox stringValue]
                           notificationName:@"tweetReceived"
                                   iconData:imageData
                                   priority:0
                                   isSticky:NO
                               clickContext:nil];
    
    [MessageBox setStringValue:@""];
    [MessageLength setStringValue:@"140"];  // @TODO: This should be triggered instead of manually added i guess.

}

@end
