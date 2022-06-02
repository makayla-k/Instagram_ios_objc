//
//  Post.h
//  instagram_objc
//
//  Created by Makayla Rodriguez on 6/1/22.
//

#import <Parse/Parse.h>

NS_ASSUME_NONNULL_BEGIN

@interface Post : PFObject<PFSubclassing>

@property (nonatomic, strong) NSString *user;
@property (nonatomic, strong) NSString *caption;

@property (nonatomic, strong) UIImage *image;

@end

NS_ASSUME_NONNULL_END
