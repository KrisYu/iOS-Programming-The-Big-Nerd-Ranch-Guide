//
//  BNRItemCell.m
//  Homepwner
//
//  Created by Xue Yu on 5/13/18.
//  Copyright © 2018 Hi Rahim. All rights reserved.
//

#import "BNRItemCell.h"

@interface BNRItemCell ()

@property (nonatomic, weak) IBOutlet NSLayoutConstraint *imageViewHeightConstraint;


@end

@implementation BNRItemCell

- (IBAction)showImage:(id)sender
{
    if (self.actionBlock) {
        self.actionBlock();
    }
}

-(void) updateInterfaceForDynamicTypeSize
{
    UIFont *font = [UIFont preferredFontForTextStyle:UIFontTextStyleBody];
    self.nameLabel.font = font;
    self.serialNumberLabel.font = font;
    self.valueLabel.font = font;
    
    static NSDictionary *imageSizeDictionary;
    
    if (!imageSizeDictionary) {
        imageSizeDictionary = @{
                                UIContentSizeCategoryExtraSmall: @44,
                                UIContentSizeCategorySmall: @44,
                                UIContentSizeCategoryMedium: @44,
                                UIContentSizeCategoryLarge: @44,
                                UIContentSizeCategoryExtraLarge: @55,
                                UIContentSizeCategoryExtraExtraLarge: @65,
                                UIContentSizeCategoryExtraExtraExtraLarge: @75 };
    }
    
    NSString *userSize = [[UIApplication sharedApplication] preferredContentSizeCategory ];
    
    NSNumber *imageSize;
    if ([imageSizeDictionary objectForKey:userSize]) {
        imageSize = imageSizeDictionary[userSize];
    } else {
        imageSize = @44.0;
    }
    
    self.imageViewHeightConstraint.constant = imageSize.floatValue;
}

- (void) awakeFromNib
{
    [self updateInterfaceForDynamicTypeSize];
    
    NSNotificationCenter *nc = [NSNotificationCenter defaultCenter];
    [nc addObserver:self
           selector:@selector(updateInterfaceForDynamicTypeSize)
               name:UIContentSizeCategoryDidChangeNotification
             object:nil];
    
    NSLayoutConstraint *constraint = [NSLayoutConstraint constraintWithItem:self.thumbnailView
                                                                  attribute:NSLayoutAttributeHeight
                                                                  relatedBy:NSLayoutRelationEqual
                                                                     toItem:self.thumbnailView
                                                                  attribute:NSLayoutAttributeWidth
                                                                 multiplier:1
                                                                   constant:0];
    [self.thumbnailView addConstraint:constraint];
}


-(void) dealloc
{
    NSNotificationCenter *nc = [NSNotificationCenter defaultCenter];
    [nc removeObserver:self];
}
@end

