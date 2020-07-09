//
//  PostTableViewCell.h
//  Instagram-FBU
//
//  Created by Diego de Jesus Ramirez on 08/07/20.
//  Copyright © 2020 DiegoRamirez. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface PostTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *postImage;
@property (weak, nonatomic) IBOutlet UILabel *captionLabel;

@end

NS_ASSUME_NONNULL_END
