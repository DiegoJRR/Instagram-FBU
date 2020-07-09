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
#import "Post.h"
#import "PostTableViewCell.h"

@interface FeedViewController ()

@property (strong, nonatomic) NSMutableArray *posts;
@property (strong, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation FeedViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.posts = [[NSMutableArray alloc] init];
    
    // Set self as dataSource and delegate for the tableView
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    
    [self fetchPosts];
    [self.tableView reloadData];
}

-(void)fetchPosts{
    // construct query
    PFQuery *query = [PFQuery queryWithClassName:@"Post"];
    query.limit = 20;

    // fetch data asynchronously
    [query findObjectsInBackgroundWithBlock:^(NSArray *posts, NSError *error) {
        NSLog(@"Here");
        if (posts != nil && !error) {
            // do something with the array of object returned by the call
            self.posts = [NSMutableArray arrayWithArray:posts];
            [self.tableView  reloadData];
        } else {
            NSLog(@"%@", error.localizedDescription);
        }
    }];
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.posts.count;
}

- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    
    PostTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"PostTableViewCell"];
    
    Post *post = self.posts[indexPath.row];
    
    // Load image from PFFileObject
    // Instantiate a weak link to the cell and load in the image in the request
    __weak PostTableViewCell *weakSelf = cell;
    [post.image getDataInBackgroundWithBlock:^(NSData *_Nullable data, NSError * _Nullable error) {
        if (error) {
            NSLog(@"Error getting image from data: %@", error.localizedDescription);
        } else {
            weakSelf.postImage.image = [UIImage imageWithData:data];
        }
    }];
    
    return cell;
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
