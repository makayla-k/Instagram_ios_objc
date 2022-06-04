//
//  CommentsViewController.h
//  instagram_objc
//
//  Created by Makayla Rodriguez on 6/1/22.
//

#import <UIKit/UIKit.h>
#import "Parse/Parse.h"

NS_ASSUME_NONNULL_BEGIN

@interface CommentsViewController : UIViewController

@property (weak, nonatomic) PFObject *post;

@end

NS_ASSUME_NONNULL_END
