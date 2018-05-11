//
//  BNRImageStore.h
//  Homepwner
//
//  Created by Xue Yu on 4/30/18.
//  Copyright © 2018 Hi Rahim. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BNRImageStore : NSObject

+ (instancetype) sharedStore;

- (void)setImage: (UIImage *)image forKey:(NSString *)key;
- (UIImage *)imageForKey: (NSString *)key;
- (void)deleteImageForKey: (NSString *)key;

@end
