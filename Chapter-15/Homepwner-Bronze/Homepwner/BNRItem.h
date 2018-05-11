//
//  BNRItem.h
//  RandomItems
//
//  Created by Rahim Sonawalla on 3/20/14.
//  Copyright (c) 2014 Hi Rahim. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BNRItem : NSObject
@property (nonatomic, copy)  NSString *itemName;
@property (nonatomic, copy) NSString *serialNumber;
@property (nonatomic) int valueInDollars;
@property (nonatomic, readonly) NSDate *dateCreated;
@property (nonatomic, copy) NSString *itemKey;


+ (instancetype) randomItem;

// BNR designated initializer
- (instancetype)initWithItemName:(NSString *)name
                  valueInDollars:(int)value
                    serialNumber:(NSString *)sNumber;

- (instancetype)initWithItemName:(NSString *)name
                    serialNumber:(NSString *)sNumber;

- (instancetype)initWithItemName:(NSString *)name;


@end
