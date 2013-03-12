//
//  itlwMainViewController.m
//  itlwork
//
//  Created by Joshua Thijssen on 11-03-13.
//  Copyright (c) 2013 NoxLogic. All rights reserved.
//

#import "itlwMainWindowController.h"
#import "itlwTweetCell.h"
#import "Columns.h"
#import "Tweet.h"
#import "user.h"
#import <Growl/Growl.h>

@interface itlwMainWindowController ()

@end


@implementation itlwMainWindowController

@synthesize MessageBox;
@synthesize MessageLength;
@synthesize TweetTable;

@synthesize managedObjectModel;
@synthesize managedObjectContext;



- (id)initWithWindow:(NSWindow *)window
{
    self = [super initWithWindow:window];
    if (! self) return self;
    
    // Fetch all columns
    NSFetchRequest *fetchRequest = [NSFetchRequest fetchRequestWithEntityName:@"Columns"];
    NSArray *fetchedColumns = [self.managedObjectContext executeFetchRequest:fetchRequest error:nil];
    
    //    [TweetTable removeTableColumn:[[TweetTable tableColumns] lastObject]];
    
    for (Columns *columnData in fetchedColumns) {
        NSTableColumn *column = [[NSTableColumn alloc] initWithIdentifier:@"Col1"];
        [column setWidth:250];
        NSTableHeaderCell *header = [[NSTableHeaderCell alloc] initTextCell:columnData.name];
        [column setHeaderCell:header];
        [TweetTable addTableColumn:column];
    }
    [TweetTable reloadData];
    
    return self;
}


- (void)windowDidLoad
{
    [super windowDidLoad];
    
    // Implement this method to handle any initialization after your window controller's window has been loaded from its nib file.
}



- (NSInteger)numberOfRowsInTableView:(NSTableView *)tableView {
    NSManagedObjectContext *moc = [self managedObjectContext];
    
    NSFetchRequest *fetchRequest = [NSFetchRequest fetchRequestWithEntityName:@"Tweet"];
    NSArray *fetchedTweets = [moc executeFetchRequest:fetchRequest error:nil];
    
    return fetchedTweets.count;
}

- (NSView *)tableView:(NSTableView *)tableView viewForTableColumn:(NSTableColumn *)tableColumn row:(NSInteger)row {
    // Get index of tableColumn
    NSUInteger idx = [[tableView tableColumns] indexOfObjectIdenticalTo:tableColumn];
    if (idx == NSNotFound) {
        return nil;
    }
    
    NSManagedObjectContext *moc = [self managedObjectContext];
    NSFetchRequest *fetchRequest = [NSFetchRequest fetchRequestWithEntityName:@"Tweet"];
    [fetchRequest setFetchLimit:1];
    [fetchRequest setFetchOffset:0];
    NSArray *fetchedTweet = [moc executeFetchRequest:fetchRequest error:nil];
    Tweet *tweet = [fetchedTweet objectAtIndex:0];
    
    itlwTweetCell *cellView = [tableView makeViewWithIdentifier:@"TweetCellView" owner:self];
    
    NSDate *today = [NSDate date];
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"EE dd-MM HH:mm"];
    cellView.date.stringValue = [dateFormat stringFromDate:today];
    
    cellView.via.stringValue = tweet.via;
    
    cellView.followers.stringValue = [NSString stringWithFormat:@"%i", tweet.followers];
    
    cellView.tweet.stringValue = tweet.tweet;
    
    User *user = [tweet user];
    cellView.name.stringValue = user.name;
    
    return cellView;
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


- (IBAction)tweetButtonCliq:(NSButton *)sender {
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
