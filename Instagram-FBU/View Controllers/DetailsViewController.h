//
//  DetailsViewController.h
//  Instagram-FBU
//
//  Created by Diego de Jesus Ramirez on 09/07/20.
//  Copyright © 2020 DiegoRamirez. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Post.h"

NS_ASSUME_NONNULL_BEGIN

@interface DetailsViewController : UIViewController

@property (nonatomic, strong) Post *post;

@end

NS_ASSUME_NONNULL_END
