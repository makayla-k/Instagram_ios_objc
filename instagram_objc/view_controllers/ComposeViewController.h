//
//  ComposeViewController.h
//  instagram_objc
//
//  Created by Makayla Rodriguez on 6/1/22.
//

#import <UIKit/UIKit.h>
#import "Post.h"

NS_ASSUME_NONNULL_BEGIN

//@protocol ComposeViewControllerDelegate
//
//- (void)didPost:(Post *)post;
//
//@end


@interface ComposeViewController : UIViewController

//@property (nonatomic, weak) id<ComposeViewControllerDelegate> delegate;

@property (weak, nonatomic) IBOutlet UIImageView *postImage;
@property (weak, nonatomic) IBOutlet UITextView *captionView;


@end

NS_ASSUME_NONNULL_END
