//
//  ProfileViewController.h
//  instagram_objc
//
//  Created by Makayla Rodriguez on 5/31/22.
//

#import <UIKit/UIKit.h>
#import "Parse/Parse.h"

NS_ASSUME_NONNULL_BEGIN

@interface ProfileViewController : UIViewController
@property (weak, nonatomic) IBOutlet UIImageView *profileImage;
@property (strong, nonatomic) PFFileObject *imageFileProfile;
@property (weak, nonatomic) IBOutlet UITextField *usernameLabel;

@end

NS_ASSUME_NONNULL_END
