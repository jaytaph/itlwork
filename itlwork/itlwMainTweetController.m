//
//  itlwMainTweetController.m
//  itlwork
//
//  Created by Joshua Thijssen on 08-03-13.
//  Copyright (c) 2013 NoxLogic. All rights reserved.
//

#import "itlwMainTweetController.h"
#import "coreData/coreData.h"

@interface itlwMainTweetController ()

@end

@implementation itlwMainTweetController

@synthesize ManagedObjectContext;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        [self loadTweets];  
    }
    
    return self;
}

- (IBAction)performClick:(id)sender {
}

- (void)loadTweets {
    NSManagedObjectContext *moc = [self ManagedObjectContext];
    
    NSManagedObject *entity = [NSEntityDescription insertNewObjectForEntityForName:@"Tweet" inManagedObjectContext:moc];
    [entity setValue:@"Hello world!" forKey:@"tweet"];
    [entity setValue:@"echofon" forKey:@"via"];

    [moc save:nil];
}


@end
