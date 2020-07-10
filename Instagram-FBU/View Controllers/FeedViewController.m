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
#import "DetailsViewController.h"

@interface FeedViewController ()

@property (strong, nonatomic) NSMutableArray *posts;
@property (strong, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, strong) UIRefreshControl *refreshControl;

@end

@implementation FeedViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.posts = [[NSMutableArray alloc] init];
    
    // Set self as dataSource and delegate for the tableView
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    
    [self fetchPosts];
    
    // Setup for the refresh control
    self.refreshControl = [[UIRefreshControl alloc] init];
    
    // Create target-action pair with the control value change that calls the fetchMovies function
    [self.refreshControl addTarget:self action:@selector(fetchPosts) forControlEvents:UIControlEventValueChanged];
    [self.tableView insertSubview:self.refreshControl atIndex:0];
}

-(void)fetchPosts{
    // construct query
    PFQuery *query = [PFQuery queryWithClassName:@"Post"];
    query.limit = 20;
    [query includeKey:@"author"];

    // fetch data asynchronously
    [query findObjectsInBackgroundWithBlock:^(NSArray *posts, NSError *error) {
        NSLog(@"Here");
        if (posts != nil && !error) {
            // do something with the array of object returned by the call
            
            // Reverse the posts to show the most recent ones first
            // TODO: Add this to the query, to pass the workload to the server. Might even be necessary for infinite scrolling!
            posts = [[posts reverseObjectEnumerator] allObjects];
            
            
            self.posts = [NSMutableArray arrayWithArray:posts];
            [self.tableView  reloadData];
        } else {
            NSLog(@"%@", error.localizedDescription);
        }
        
        // Stio the refresh control
        [self.refreshControl endRefreshing];
    }];
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.posts.count;
}

- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    
    PostTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"PostTableViewCell"];
    
    Post *post = self.posts[indexPath.row];
    
    cell.captionLabel.text = post.caption;
    
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


#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
//     Get the new view controller using [segue destinationViewController].
//     Pass the selected object to the new view controller.
    
    if ([[segue identifier] isEqualToString:@"detailSegue"]) {
        // Set the tappedCell as the cell that initiated the segue
        UITableViewCell *tappedCell = sender;
        
        // Get the corresponding indexPath of the cell
        NSIndexPath *indexPath = [self.tableView indexPathForCell:tappedCell];
        
        // Get the movie corresponding to that cell
        Post *post = self.posts[indexPath.row];
        
        // Set the viewController to segue into and pass the movie object
        DetailsViewController *detailsViewController = [segue destinationViewController];
        detailsViewController.post = post;
    }
}





@end
