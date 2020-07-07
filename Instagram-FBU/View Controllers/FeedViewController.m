//
//  FeedViewController.m
//  Instagram-FBU
//
//  Created by Diego de Jesus Ramirez on 07/07/20.
//  Copyright © 2020 DiegoRamirez. All rights reserved.
//

#import "FeedViewController.h"
#import "SceneDelegate.h"
#import "LoginViewController.h"
#import <Parse/Parse.h>

@interface FeedViewController ()

@end

@implementation FeedViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (IBAction)logout:(id)sender {
    SceneDelegate *sceneDelegate = (SceneDelegate *)self.view.window.windowScene.delegate;
    
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    LoginViewController *loginViewController = [storyboard instantiateViewControllerWithIdentifier:@"LoginViewController"];
    
    [PFUser logOutInBackgroundWithBlock:^(NSError * _Nullable error) {
        sceneDelegate.window.rootViewController = loginViewController;
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
