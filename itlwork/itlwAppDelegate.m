//
//  itlwAppDelegate.m
//  itlwork
//
//  Created by Joshua Thijssen on 07-03-13.
//  Copyright (c) 2013 NoxLogic. All rights reserved.
//

#import "itlwAppDelegate.h"
#import "itlwMainWindowController.h"
#import "itlwTweetCell.h"
#import "Columns.h"
#import "User.h"
#import "Tweet.h"

@implementation itlwAppDelegate 

//@synthesize TweetTable;
@synthesize persistentStoreCoordinator = _persistentStoreCoordinator;
@synthesize managedObjectModel = _managedObjectModel;
@synthesize managedObjectContext = _managedObjectContext;

itlwMainWindowController *mainWindowController;


- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{    
    NSManagedObjectContext *moc = [self managedObjectContext];
    
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
    
    tweet = [NSEntityDescription insertNewObjectForEntityForName:@"Tweet" inManagedObjectContext:moc];
    tweet.date=[NSDate date];
    tweet.via = @"itlwork";
    tweet.user = user1;
    tweet.id_str = @"3453161161";
    tweet.tweet = @"Another tweet";
    [moc save:nil];
    
    NSFetchRequest *allColumns = [[NSFetchRequest alloc] init];
    [allColumns setEntity:[NSEntityDescription entityForName:@"Columns" inManagedObjectContext:moc]];
    [allColumns setIncludesPropertyValues:NO];
    
    // Remove all existing columns. We start with a fresh set
    NSArray *columns = [moc executeFetchRequest:allColumns error:nil];
    for (NSManagedObject *column in columns) {
        [moc deleteObject:column];
    }
    [moc save:nil];
    
    
    Columns *column1 = [NSEntityDescription insertNewObjectForEntityForName:@"Columns" inManagedObjectContext:moc];
    column1.name = @"Friends - @jaytaph";
    
    Columns *column2 = [NSEntityDescription insertNewObjectForEntityForName:@"Columns" inManagedObjectContext:moc];
    column2.name = @"Mentions - @jaytaph";
    
//    Columns *column3 = [NSEntityDescription insertNewObjectForEntityForName:@"Columns" inManagedObjectContext:moc];
//    column3.name = @"Direct messages - @jaytaph";
//    
//    Columns *column4 = [NSEntityDescription insertNewObjectForEntityForName:@"Columns" inManagedObjectContext:moc];
//    column4.name = @"Search - #saffire";
//    
//    Columns *column5 = [NSEntityDescription insertNewObjectForEntityForName:@"Columns" inManagedObjectContext:moc];
//    column5.name = @"Search - #techademy";
    [moc save:nil];
    
    
    // Show main window
    _mainWindowController = [[itlwMainWindowController alloc] initWithWindowNibName:@"MainWindow"];
    _mainWindowController.managedObjectModel = [self managedObjectModel];
    _mainWindowController.managedObjectContext = [self managedObjectContext];
    [self.mainWindowController showWindow:self];
}



// Returns the directory the application uses to store the Core Data store file. This code uses a directory named "com.noxlogic.test" in the user's Application Support directory.
- (NSURL *)applicationFilesDirectory
{
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSURL *appSupportURL = [[fileManager URLsForDirectory:NSApplicationSupportDirectory inDomains:NSUserDomainMask] lastObject];
    return [appSupportURL URLByAppendingPathComponent:@"com.noxlogic.itlwork"];
}

// Creates if necessary and returns the managed object model for the application.
- (NSManagedObjectModel *)managedObjectModel
{
    if (_managedObjectModel) {
        return _managedObjectModel;
    }
	
    NSURL *modelURL = [[NSBundle mainBundle] URLForResource:@"itlwork" withExtension:@"momd"];
    _managedObjectModel = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL];
    return _managedObjectModel;
}

// Returns the persistent store coordinator for the application. This implementation creates and return a coordinator, having added the store for the application to it. (The directory for the store is created, if necessary.)
- (NSPersistentStoreCoordinator *)persistentStoreCoordinator
{
    if (_persistentStoreCoordinator) {
        return _persistentStoreCoordinator;
    }
    
    NSManagedObjectModel *mom = [self managedObjectModel];
    if (!mom) {
        NSLog(@"%@:%@ No model to generate a store from", [self class], NSStringFromSelector(_cmd));
        return nil;
    }
    
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSURL *applicationFilesDirectory = [self applicationFilesDirectory];
    NSError *error = nil;
    
    NSDictionary *properties = [applicationFilesDirectory resourceValuesForKeys:@[NSURLIsDirectoryKey] error:&error];
    
    if (!properties) {
        BOOL ok = NO;
        if ([error code] == NSFileReadNoSuchFileError) {
            ok = [fileManager createDirectoryAtPath:[applicationFilesDirectory path] withIntermediateDirectories:YES attributes:nil error:&error];
        }
        if (!ok) {
            [[NSApplication sharedApplication] presentError:error];
            return nil;
        }
    } else {
        if (![properties[NSURLIsDirectoryKey] boolValue]) {
            // Customize and localize this error.
            NSString *failureDescription = [NSString stringWithFormat:@"Expected a folder to store application data, found a file (%@).", [applicationFilesDirectory path]];
            
            NSMutableDictionary *dict = [NSMutableDictionary dictionary];
            [dict setValue:failureDescription forKey:NSLocalizedDescriptionKey];
            error = [NSError errorWithDomain:@"YOUR_ERROR_DOMAIN" code:101 userInfo:dict];
            
            [[NSApplication sharedApplication] presentError:error];
            return nil;
        }
    }
    
    NSURL *url = [applicationFilesDirectory URLByAppendingPathComponent:@"itlwork.storedata"];
    NSPersistentStoreCoordinator *coordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:mom];
    if (![coordinator addPersistentStoreWithType:NSXMLStoreType configuration:nil URL:url options:nil error:&error]) {
        [[NSApplication sharedApplication] presentError:error];
        return nil;
    }
    _persistentStoreCoordinator = coordinator;
    
    return _persistentStoreCoordinator;
}

// Returns the managed object context for the application (which is already bound to the persistent store coordinator for the application.)
- (NSManagedObjectContext *)managedObjectContext
{
    if (_managedObjectContext) {
        return _managedObjectContext;
    }
    
    NSPersistentStoreCoordinator *coordinator = [self persistentStoreCoordinator];
    if (!coordinator) {
        NSMutableDictionary *dict = [NSMutableDictionary dictionary];
        [dict setValue:@"Failed to initialize the store" forKey:NSLocalizedDescriptionKey];
        [dict setValue:@"There was an error building up the data file." forKey:NSLocalizedFailureReasonErrorKey];
        NSError *error = [NSError errorWithDomain:@"YOUR_ERROR_DOMAIN" code:9999 userInfo:dict];
        [[NSApplication sharedApplication] presentError:error];
        return nil;
    }
    _managedObjectContext = [[NSManagedObjectContext alloc] init];
    [_managedObjectContext setPersistentStoreCoordinator:coordinator];
    
    return _managedObjectContext;
}


@end
