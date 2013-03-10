//
//  itlwAppDelegate.m
//  itlwork
//
//  Created by Joshua Thijssen on 07-03-13.
//  Copyright (c) 2013 NoxLogic. All rights reserved.
//

#import "itlwAppDelegate.h"
#import "itlwMainTweetController.h"
#import "Columns.h"
#import "User.h"
#import "Tweet.h"

@implementation itlwAppDelegate

@synthesize MessageBox;
@synthesize MessageLength;
@synthesize TweetTable;
@synthesize ManagedObjectContext;

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{
    // Add core data
    NSManagedObjectContext *moc = [self ManagedObjectContext];
    
    NSManagedObjectModel *managedObjectModel = [NSManagedObjectModel mergedModelFromBundles:nil];
    NSPersistentStoreCoordinator *persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:managedObjectModel];
    if (persistentStoreCoordinator != nil) {
        ManagedObjectContext = [[NSManagedObjectContext alloc] init];
        [ManagedObjectContext setPersistentStoreCoordinator: persistentStoreCoordinator];
    }

    User *user1 = [NSEntityDescription insertNewObjectForEntityForName:@"User" inManagedObjectContext:moc];
    
    user1.id_str = @"deadbeef";
    user1.image_url = @"https://si0.twimg.com/profile_images/3298514384/de0bf3eb346caaded1d069a83b7066cd_bigger.jpeg";
    user1.image = [NSData dataWithContentsOfURL:[NSURL URLWithString:user1.image_url]];
    user1.name = @"@JayTaph";
    [moc save:nil];

    Tweet *tweet;
    tweet = [NSEntityDescription insertNewObjectForEntityForName:@"Tweet" inManagedObjectContext:moc];
    tweet.date=[NSDate date];
    tweet.via = @"echofon";
    tweet.user = user1;
    tweet.id_str = @"123456789012";
    tweet.tweet = @"Hello tweet!";
    [moc save:nil];
    
    tweet = [NSEntityDescription insertNewObjectForEntityForName:@"Tweet2" inManagedObjectContext:moc];
    tweet.date=[NSDate date];
    tweet.via = @"itlwork";
    tweet.user = user1;
    tweet.id_str = @"3453161161";
    tweet.tweet = @"Another tweet";
    [moc save:nil];
    
    
    Columns *column1 = [NSEntityDescription insertNewObjectForEntityForName:@"Columns" inManagedObjectContext:moc];
    column1.name = @"Friends - @jaytaph";
    
    Columns *column2 = [NSEntityDescription insertNewObjectForEntityForName:@"Columns" inManagedObjectContext:moc];
    column2.name = @"Mentions - @jaytaph";
    
    Columns *column3 = [NSEntityDescription insertNewObjectForEntityForName:@"Columns" inManagedObjectContext:moc];
    column3.name = @"Direct messages - @jaytaph";
    
    Columns *column4 = [NSEntityDescription insertNewObjectForEntityForName:@"Columns" inManagedObjectContext:moc];
    column4.name = @"Search - #saffire";
    
    Columns *column5 = [NSEntityDescription insertNewObjectForEntityForName:@"Columns" inManagedObjectContext:moc];
    column5.name = @"Search - #techademy";

    
    [moc save:nil];

    
    
    
    // Fetch all columns
    NSFetchRequest *fetchRequest = [NSFetchRequest fetchRequestWithEntityName:@"Columns"];
    NSArray *fetchedColumns = [moc executeFetchRequest:fetchRequest error:nil];
    
    [TweetTable removeTableColumn:[[TweetTable tableColumns] lastObject]];

    for (Columns *columnData in fetchedColumns) {
        NSTableColumn *column = [[NSTableColumn alloc] initWithIdentifier:@"Col1"];
        [column setWidth:250];
        NSTableHeaderCell *header = [[NSTableHeaderCell alloc] initTextCell:columnData.name];
        [column setHeaderCell:header];
        [TweetTable addTableColumn:column];
    }
    [TweetTable reloadData];
    
    
/*
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
    
*/
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
