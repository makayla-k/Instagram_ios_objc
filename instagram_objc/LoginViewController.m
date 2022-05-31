//
//  LoginViewController.m
//  instagram_objc
//
//  Created by Makayla Rodriguez on 5/31/22.
//

#import "LoginViewController.h"
#import <Parse/Parse.h>

@interface LoginViewController ()
@property (weak, nonatomic) IBOutlet UITextField *usernameField;
@property (weak, nonatomic) IBOutlet UITextField *passwordField;


@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)registerUser {
    // initialize a user object
    PFUser *newUser = [PFUser user];
    
    // set user properties
    newUser.username = self.usernameField.text;
    newUser.password = self.passwordField.text;
    
    // call sign up function on the object
    [newUser signUpInBackgroundWithBlock:^(BOOL succeeded, NSError * error) {
        if (error != nil) {
            //    alert if error when signing up
                UIAlertController *signupErroralert = [UIAlertController alertControllerWithTitle:@"Error"message:[NSString stringWithFormat:@"%@", error.localizedDescription] preferredStyle:(UIAlertControllerStyleAlert)];
                // create an OK action
                UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"OK"style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                }];
                [signupErroralert addAction:okAction];
            
            [self presentViewController:signupErroralert animated:YES completion:^{
            // optional code for what happens after the alert controller has finished presenting
            }];
            
            NSLog(@"Error: %@", error.localizedDescription);
        } else {
            
            UIAlertController *signedupalert = [UIAlertController alertControllerWithTitle:@"Successful!"message:@"User registered" preferredStyle:(UIAlertControllerStyleAlert)];
            // create an OK action
            UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"OK"style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            }];
            [signedupalert addAction:okAction];
        
        [self presentViewController:signedupalert animated:YES completion:^{
        // optional code for what happens after the alert controller has finished presenting
        }];
            NSLog(@"User registered successfully");
            
            // manually segue to logged in view
        }
    }];
}

- (void)loginUser {
    NSString *username = self.usernameField.text;
    NSString *password = self.passwordField.text;
    
    [PFUser logInWithUsernameInBackground:username password:password block:^(PFUser * user, NSError *  error) {
        if (error != nil) {
            NSLog(@"User log in failed: %@", error.localizedDescription);
        } else {
            NSLog(@"User logged in successfully");
            
            // display view controller that needs to shown after successful login
        }
    }];
}

-(BOOL)checkIfEmpty:(NSString *)text {
    if([text isEqual:@""]){
        return YES;
    }
    else{
        return NO;
    }
}

- (IBAction)onSignUp:(id)sender {
//    UI alert
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Text Required"message:@"Please make sure username / pasword fields are filled in"preferredStyle:(UIAlertControllerStyleAlert)];
    // create an OK action
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"OK"style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
    }];
    [alert addAction:okAction];
    
//    check if text fields are empty
    if( ![self checkIfEmpty:self.usernameField.text] || ![self checkIfEmpty:self.passwordField.text]){
        [self registerUser];
    }
    else{
        [self presentViewController:alert animated:YES completion:^{
        // optional code for what happens after the alert controller has finished presenting
    }];
    }
}
- (IBAction)onLogin:(id)sender {
    //    UI alert
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Text Required"message:@"Please make sure username / pasword fields are filled in"preferredStyle:(UIAlertControllerStyleAlert)];
        // create an OK action
        UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"OK"style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        }];
        [alert addAction:okAction];
        
    //    check if text fields are empty
        if( ![self checkIfEmpty:self.usernameField.text] || ![self checkIfEmpty:self.passwordField.text]){
            [self loginUser];
        }
        else{
            [self presentViewController:alert animated:YES completion:^{
            // optional code for what happens after the alert controller has finished presenting
        }];
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
