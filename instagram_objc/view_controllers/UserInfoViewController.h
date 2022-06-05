//
//  UserInfoViewController.h
//  instagram_objc
//
//  Created by Makayla Rodriguez on 6/4/22.
//

#import <UIKit/UIKit.h>
#import "Parse/Parse.h"

NS_ASSUME_NONNULL_BEGIN

@interface UserInfoViewController : UIViewController

@property (weak, nonatomic) PFUser *user;
@property (weak, nonatomic) IBOutlet UIImageView *profileImage;
@property (strong, nonatomic) PFFileObject *imageFileProfile;
@property (weak, nonatomic) IBOutlet UILabel *usernameLabel;

@end

NS_ASSUME_NONNULL_END
