//
//  User.h
//  itlwork
//
//  Created by Joshua Thijssen on 10-03-13.
//  Copyright (c) 2013 NoxLogic. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface User : NSManagedObject

@property (nonatomic, retain) NSString * id_str;
@property (nonatomic, retain) NSData * image;
@property (nonatomic, retain) NSString * image_url;
@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSManagedObject *tweets;

@end
