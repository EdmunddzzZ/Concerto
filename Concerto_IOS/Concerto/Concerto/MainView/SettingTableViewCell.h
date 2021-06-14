//
//  SettingTableViewCell.h
//  SchoolFriendGather
//
//  Created by 张德茂 on 2018/12/9.
//  Copyright © 2018 xianjun yang. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface SettingTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *contentLabel;
@property (weak ,nonatomic) IBOutlet UISwitch *sw;

@end

NS_ASSUME_NONNULL_END
