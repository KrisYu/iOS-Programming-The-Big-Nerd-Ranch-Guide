//
//  BNRImageTransformer.m
//  Homepwner
//
//  Created by Xue Yu on 5/16/18.
//  Copyright © 2018 Hi Rahim. All rights reserved.
//

#import "BNRImageTransformer.h"

@implementation BNRImageTransformer

+ (Class)transformedValueClass
{
    return [NSData class];
}

- (id)transformedValue:(id)value
{
    if (!value) {
        return nil;
    }
    
    if ([value isKindOfClass:[NSData class]]) {
        return value;
    }
    
    return UIImagePNGRepresentation(value);
}


-(id)reverseTransformedValue:(id)value
{
    return [UIImage imageWithData:value];
}
@end
