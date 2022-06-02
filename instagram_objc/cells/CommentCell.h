//
//  CommentCell.h
//  instagram_objc
//
//  Created by Makayla Rodriguez on 6/1/22.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface CommentCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *usernameLabel;
@property (weak, nonatomic) IBOutlet UITextView *commentView;

@end

NS_ASSUME_NONNULL_END
