//
//  DetailsViewController.m
//  Instagram-FBU
//
//  Created by Diego de Jesus Ramirez on 09/07/20.
//  Copyright © 2020 DiegoRamirez. All rights reserved.
//

#import "DetailsViewController.h"

@interface DetailsViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *postView;
@property (weak, nonatomic) IBOutlet UILabel *captionLabel;
@property (weak, nonatomic) IBOutlet UILabel *timestampLabel;

@end

@implementation DetailsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    //Setup the post caption and label
    self.captionLabel.text = self.post.caption;
    
    // Load image from PFFileObject
    // Instantiate a weak link to the cell and load in the image in the request
    [self.post.image getDataInBackgroundWithBlock:^(NSData *_Nullable data, NSError * _Nullable error) {
        if (error) {
            NSLog(@"Error getting image from data: %@", error.localizedDescription);
        } else {
            self.postView.image = [UIImage imageWithData:data];
        }
    }];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
