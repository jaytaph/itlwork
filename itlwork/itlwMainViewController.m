//
//  itlwMainViewController.m
//  itlwork
//
//  Created by Joshua Thijssen on 11-03-13.
//  Copyright (c) 2013 NoxLogic. All rights reserved.
//

#import "itlwMainViewController.h"
#import "itlwTweetCell.h"
#import "Columns.h"
#import <Growl/Growl.h>

@interface itlwMainViewController ()

@end


@implementation itlwMainViewController

@synthesize MessageBox;
@synthesize MessageLength;
@synthesize TweetTable;

//
//- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
//{
//    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
//    if (!self) return self;
//    
//    // Fetch all columns
//    NSManagedObjectContext *moc = [self managedObjectContext];
//    NSFetchRequest *fetchRequest = [NSFetchRequest fetchRequestWithEntityName:@"Columns"];
//    NSArray *fetchedColumns = [moc executeFetchRequest:fetchRequest error:nil];
//    
//    //    [TweetTable removeTableColumn:[[TweetTable tableColumns] lastObject]];
//    
//    for (Columns *columnData in fetchedColumns) {
//        NSTableColumn *column = [[NSTableColumn alloc] initWithIdentifier:@"Col1"];
//        [column setWidth:250];
//        NSTableHeaderCell *header = [[NSTableHeaderCell alloc] initTextCell:columnData.name];
//        [column setHeaderCell:header];
//        [TweetTable addTableColumn:column];
//    }
//    [TweetTable reloadData];
//    
//    return self;
//}
//
//


- (NSInteger)numberOfRowsInTableView:(NSTableView *)tableView {
    NSManagedObjectContext *moc = [self managedObjectContext];
    
    NSFetchRequest *fetchRequest = [NSFetchRequest fetchRequestWithEntityName:@"Tweet"];
    NSArray *fetchedTweets = [moc executeFetchRequest:fetchRequest error:nil];
    
    return fetchedTweets.count;
}

- (NSView *)tableView:(NSTableView *)tableView viewForTableColumn:(NSTableColumn *)tableColumn row:(NSInteger)row {
    //    NSString *identifier = [tableColumn identifier];
    
    // Get index of tableColumn
    NSUInteger idx = [[tableView tableColumns] indexOfObjectIdenticalTo:tableColumn];
    if (idx == NSNotFound) {
        return nil;
    }
    
    
    itlwTweetCell *cellView = [tableView makeViewWithIdentifier:@"TweetCellView" owner:self];
    cellView.date = [NSDate date];
    //    NSTextField *a = [cellView via];
    //    [a setValue:@"via Echofon"];
    //    [cellView.followers setValue:[NSString stringWithFormat:@"%i", rand() * 10000]];
    //    [cellView.tweet setValue:@"@JayTaph i have no direct tips for books but you might want to talk to @CocoaHeadsNL or attend their meetings."];
    //    [cellView.name setValue:@"@TechAdemy"];
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
