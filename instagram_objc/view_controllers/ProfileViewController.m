//
//  ProfileViewController.m
//  instagram_objc
//
//  Created by Makayla Rodriguez on 5/31/22.
//

#import "ProfileViewController.h"
#import "Parse/Parse.h"
#import "SceneDelegate.h"
#import "LoginViewController.h"
#import "UserPostCell.h"

@interface ProfileViewController ()<UITableViewDelegate, UITableViewDataSource, UIImagePickerControllerDelegate, UINavigationControllerDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) NSArray *postsArray;

@end

@implementation ProfileViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    
    // Do any additional setup after loading the view.
    PFUser *user = [PFUser currentUser];
    //    get profile image from parse
    PFFileObject *userProfileImageFile = user[@"profileImage"];
    self.imageFileProfile = userProfileImageFile;
    [userProfileImageFile getDataInBackgroundWithBlock:^(NSData *imageData, NSError *error) {
        if (!error) {
            self.profileImage.image = [UIImage imageWithData:imageData];
        }
    }];
    
    self.usernameLabel.text = user.username;
    
    [self getPosts];
}

- (IBAction)onLogoutButton:(id)sender {
//    logout user
    [PFUser logOutInBackgroundWithBlock:^(NSError * _Nullable error) {
        // PFUser.current() will now be nil
    }];
    
    SceneDelegate *myDelegate = (SceneDelegate *)self.view.window.windowScene.delegate;
    
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    LoginViewController *loginViewController = [storyboard instantiateViewControllerWithIdentifier:@"LoginViewController"];
    myDelegate.window.rootViewController = loginViewController;
}
- (IBAction)didTapAddProfileImage:(id)sender {
    
    UIImagePickerController *imagePickerVC = [UIImagePickerController new];
    imagePickerVC.delegate = self;
    imagePickerVC.allowsEditing = YES;

    // The Xcode simulator does not support taking pictures, so let's first check that the camera is indeed supported on the device before trying to present it.
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        imagePickerVC.sourceType = UIImagePickerControllerSourceTypeCamera;
    }
    else {
        NSLog(@"Camera 🚫 available so we will use photo library instead");
        imagePickerVC.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    }

    [self presentViewController:imagePickerVC animated:YES completion:nil];
    
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info {
    
    // Get the image captured by the UIImagePickerController
//    UIImage *originalImage = info[UIImagePickerControllerOriginalImage];
    UIImage *editedImage = info[UIImagePickerControllerEditedImage];

    // Do something with the images (based on your use case)
    
    self.profileImage.image = editedImage;
    
    PFUser *user = [PFUser currentUser];
    
//    send image to parse
    user[@"profileImage"] = [self getPFFileFromImage:self.profileImage.image];
    [user saveInBackground];
    
    [self viewDidLoad];
    
    // Dismiss UIImagePickerController to go back to your original view controller
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (PFFileObject *)getPFFileFromImage: (UIImage * _Nullable)image {
 
    // check if image is not nil
    if (!image) {
        return nil;
    }
    
    NSData *imageData = UIImagePNGRepresentation(image);
    // get image data and check if that is not nil
    if (!imageData) {
        return nil;
    }
    
    return [PFFileObject fileObjectWithName:@"image.png" data:imageData];
}

-(void)getPosts {
    PFQuery *query = [PFQuery queryWithClassName:@"Post"];
    [query orderByDescending:@"createdAt"];
    [query includeKey:@"author"];
    [query whereKey:@"author" equalTo:[PFUser currentUser]];


    // fetch data asynchronously
    [query findObjectsInBackgroundWithBlock:^(NSArray *posts, NSError *error) {
        if (posts != nil) {
            // do something with the array of object returned by the call
            self.postsArray = posts;
            [self.tableView reloadData];
        } else {
            NSLog(@"%@", error.localizedDescription);
        }
        
    }];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.postsArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UserPostCell *cell = [tableView dequeueReusableCellWithIdentifier:@"userPostCell"];
    PFObject *post = self.postsArray[indexPath.row];
        
    PFUser *user = post[@"author"];
    if (user != nil) {
        // User found! update username label with username
        cell.usernameTopLabel.text = user.username;
        cell.usernameBottomLabel.text = user.username;
    } else {
        // No user found, set default username
        cell.usernameTopLabel.text = @"🤖";
        cell.usernameBottomLabel.text = @"🤖";
    }
    
    //    get profile image from parse
    PFFileObject *userProfileImageFile = user[@"profileImage"];
    cell.imageFileProfile = userProfileImageFile;
    [userProfileImageFile getDataInBackgroundWithBlock:^(NSData *imageData, NSError *error) {
        if (!error) {
            cell.postProfileImage.image = [UIImage imageWithData:imageData];
        }
    }];
    
//    get post image from parse
    PFFileObject *userImageFile = post[@"image"];
    cell.imageFilePost = userImageFile;
    [userImageFile getDataInBackgroundWithBlock:^(NSData *imageData, NSError *error) {
        if (!error) {
            cell.postImage.image = [UIImage imageWithData:imageData];
        }
    }];
    
    cell.captionLabel.text = post[@"caption"];
    
    return cell;
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
