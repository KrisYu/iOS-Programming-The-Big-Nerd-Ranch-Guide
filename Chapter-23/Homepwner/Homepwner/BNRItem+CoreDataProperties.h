//
//  BNRItem+CoreDataProperties.h
//  Homepwner
//
//  Created by Xue Yu on 5/16/18.
//  Copyright © 2018 Hi Rahim. All rights reserved.
//
//

#import "BNRItem+CoreDataClass.h"


NS_ASSUME_NONNULL_BEGIN

@interface BNRItem (CoreDataProperties)

+ (NSFetchRequest<BNRItem *> *)fetchRequest;

@property (nullable, nonatomic, copy) NSString *itemName;
@property (nullable, nonatomic, copy) NSString *serialNumber;
@property (nonatomic) int valueInDollars;
@property (nullable, nonatomic, copy) NSDate *dateCreated;
@property (nullable, nonatomic, copy) NSString *itemKey;
@property (nullable, nonatomic, retain) UIImage *thumbnail;
@property (nonatomic) double orderingValue;
@property (nullable, nonatomic, retain) NSManagedObject *assetType;

- (void)setThumbnailForImage: (UIImage *)image;

@end

NS_ASSUME_NONNULL_END
