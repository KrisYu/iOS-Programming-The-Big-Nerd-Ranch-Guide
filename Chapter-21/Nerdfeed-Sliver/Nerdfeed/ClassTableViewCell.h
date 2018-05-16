//
//  ClassTableViewCell.h
//  Nerdfeed
//
//  Created by Xue Yu on 5/16/18.
//  Copyright © 2018 XueYu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ClassTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *courseName;
@property (weak, nonatomic) IBOutlet UILabel *courseTime;

@end
