//
//  LoginViewController.m
//  Instagram-FBU
//
//  Created by Diego de Jesus Ramirez on 06/07/20.
//  Copyright © 2020 DiegoRamirez. All rights reserved.
//

#import "LoginViewController.h"
#import <Parse/Parse.h>

@interface LoginViewController ()
@property (weak, nonatomic) IBOutlet UITextField *usernameField;
@property (weak, nonatomic) IBOutlet UITextField *passwordField;
@property (weak, nonatomic) IBOutlet UITextField *emailField;

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)presentAlert:(NSString *)title message:(NSString *)message_body {
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:title message: message_body preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"Ok" style:UIAlertActionStyleDefault handler:^(UIAlertAction * action){
        // Ok action example
    }];
    [alert addAction:okAction];
    [self presentViewController:alert animated:YES completion:nil];
}

- (IBAction)signUp:(id)sender {
    if (self.usernameField.hasText && self.passwordField.hasText && self.emailField.hasText) {
        // initialize a user object
        PFUser *newUser = [PFUser user];
        
        // set user properties
        newUser.username = self.usernameField.text;
        newUser.email = self.emailField.text;
        newUser.password = self.passwordField.text;
        
        // call sign up function on the object
        [newUser signUpInBackgroundWithBlock:^(BOOL succeeded, NSError * error) {
            if (error != nil) {
                NSLog(@"Error: %@", error.localizedDescription);
                
                [self presentAlert:@"Error" message: error.localizedDescription];
            } else {
                NSLog(@"User registered successfully");
                
                // manually segue to logged in view
                [self performSegueWithIdentifier:@"loginToMainSegue" sender:nil];
            }
        }];
    } else {
        NSLog(@"Missing information for Sign Up");
    }
}

- (IBAction)login:(id)sender {
    if (self.usernameField.hasText && self.passwordField.hasText && self.emailField.hasText) {
        
        // Get users data from the text fields
        NSString *username = self.usernameField.text;
        NSString *password = self.passwordField.text;
        
        // Login using the Parser pod
        [PFUser logInWithUsernameInBackground:username password:password block:^(PFUser * user, NSError *  error) {
            if (error != nil) {
                NSLog(@"User log in failed: %@", error.localizedDescription);
                
                [self presentAlert:@"Error" message: error.localizedDescription];
            } else {
                NSLog(@"User logged in successfully");
                
                // manually segue to logged in view
                [self performSegueWithIdentifier:@"loginToMainSegue" sender:nil];
            }
        }];
    } else {
        NSLog(@"Missing information for Sign Up");
    }
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
