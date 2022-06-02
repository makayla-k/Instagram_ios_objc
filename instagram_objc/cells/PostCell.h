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
@property (weak, nonatomic) IBOutlet UILabel *usernameTopLabel;
@property (weak, nonatomic) IBOutlet UIImageView *postImage;
@property (weak, nonatomic) IBOutlet UILabel *usernameBottomLabel;
@property (weak, nonatomic) IBOutlet UITextView *captionView;
@property (strong, nonatomic) PFFileObject *imageFile;

@end

NS_ASSUME_NONNULL_END
