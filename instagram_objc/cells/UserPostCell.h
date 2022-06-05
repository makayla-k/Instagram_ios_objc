//
//  UserPostCell.h
//  instagram_objc
//
//  Created by Makayla Rodriguez on 6/4/22.
//

#import <UIKit/UIKit.h>
#import "Parse/Parse.h"

NS_ASSUME_NONNULL_BEGIN

@interface UserPostCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *postProfileImage;
@property (strong, nonatomic) PFFileObject *imageFileProfile;
@property (weak, nonatomic) IBOutlet UILabel *usernameTopLabel;
@property (weak, nonatomic) IBOutlet UIImageView *postImage;
@property (strong, nonatomic) PFFileObject *imageFilePost;
@property (weak, nonatomic) IBOutlet UILabel *usernameBottomLabel;
@property (weak, nonatomic) IBOutlet UILabel *captionLabel;


@end

NS_ASSUME_NONNULL_END
