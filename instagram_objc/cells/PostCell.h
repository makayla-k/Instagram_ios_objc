//
//  PostCell.h
//  instagram_objc
//
//  Created by Makayla Rodriguez on 6/1/22.
//

#import <UIKit/UIKit.h>
#import "Parse/Parse.h"

NS_ASSUME_NONNULL_BEGIN

@interface PostCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *profileImage;
@property (strong, nonatomic) PFFileObject *imageFileProfile;
@property (weak, nonatomic) IBOutlet UILabel *usernameTopLabel;
@property (weak, nonatomic) IBOutlet UIImageView *postImage;
@property (strong, nonatomic) PFFileObject *imageFilePost;
@property (weak, nonatomic) IBOutlet UILabel *usernameBottomLabel;
@property (weak, nonatomic) IBOutlet UITextView *captionView;
@property (weak, nonatomic) IBOutlet UIButton *commentButton;
@property (weak, nonatomic) IBOutlet UILabel *timestampLabel;
@property (weak, nonatomic) IBOutlet UIButton *infoButton;

@end

NS_ASSUME_NONNULL_END
