//
//  Tweet.h
//  itlwork
//
//  Created by Joshua Thijssen on 10-03-13.
//  Copyright (c) 2013 NoxLogic. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class User;

@interface Tweet : NSManagedObject

@property (nonatomic, retain) NSDate * date;
@property (nonatomic, retain) NSString * id_str;
@property (nonatomic, retain) NSString * tweet;
@property (nonatomic, retain) NSString * via;
@property (nonatomic, retain) User *user;

@end
