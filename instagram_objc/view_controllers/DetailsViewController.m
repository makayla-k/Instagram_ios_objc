//
//  DetailsViewController.m
//  instagram_objc
//
//  Created by Makayla Rodriguez on 6/2/22.
//

#import "DetailsViewController.h"
#import "Parse/Parse.h"
#import "Post.h"

@interface DetailsViewController ()

@end

@implementation DetailsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    PFUser *user = self.post[@"author"];
    if (user != nil) {
        // User found! update username label with username
        self.usernameTopLabel.text = user.username;
        self.usernameBottomLabel.text = user.username;
    } else {
        // No user found, set default username
        self.usernameTopLabel.text = @"🤖";
        self.usernameBottomLabel.text = @"🤖";
    }
    
//    get image from parse
    PFFileObject *userImageFile = self.post[@"image"];
    self.imageFile = userImageFile;
    [userImageFile getDataInBackgroundWithBlock:^(NSData *imageData, NSError *error) {
        if (!error) {
            self.postImage.image = [UIImage imageWithData:imageData];
        }
    }];
    
    
    self.captionLabel.text = self.post[@"caption"];
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
