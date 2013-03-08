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
    NSString *s = [@"Sending tweet: " stringByAppendingString:[MessageBox stringValue]];
    [MessageBox setStringValue:@""];
    [MessageLength setStringValue:@"140"];  // @TODO: This should be triggered instead of manually added i guess.

    NSAlert *alert = [[NSAlert alloc] init];
    [alert setMessageText:s];
    [alert runModal];

}

@end
