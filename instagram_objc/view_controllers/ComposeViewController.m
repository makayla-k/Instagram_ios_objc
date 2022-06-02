//
//  ComposeViewController.m
//  instagram_objc
//
//  Created by Makayla Rodriguez on 6/1/22.
//

#import "ComposeViewController.h"
#import <Parse/Parse.h>
#import "Post.h"

@interface ComposeViewController ()<UIImagePickerControllerDelegate, UINavigationControllerDelegate>

@end

@implementation ComposeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
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
    
    self.postImage.image = editedImage;
    
    // Dismiss UIImagePickerController to go back to your original view controller
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)didTapPost:(id)sender {
    
    if(self.postImage.image != nil){
        [Post postUserImage:self.postImage.image withCaption:self.captionView.text withCompletion:^(BOOL succeeded, NSError * _Nullable error) {
            NSLog(@"Successfully posted image!");
            [self dismissViewControllerAnimated:YES completion:nil];
            [self.delegate didPost];
        }];
    }
    else{
        //    alert if no image was uploaded
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Error" message:@"An image must be selected to post." preferredStyle:(UIAlertControllerStyleAlert)];
            // create an OK action
            UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"OK"style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                [self viewDidLoad];
            }];
            [alert addAction:okAction];
            
            [self presentViewController:alert animated:YES completion:^{
            // optional code for what happens after the alert controller has finished presenting
            }];
            
    }
    
}

- (IBAction)didTapCancel:(id)sender {
    [self dismissViewControllerAnimated:true completion:nil];
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
