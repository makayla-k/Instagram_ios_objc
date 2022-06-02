//
//  Post.h
//  instagram_objc
//
//  Created by Makayla Rodriguez on 6/1/22.
//

#import <Parse/Parse.h>

NS_ASSUME_NONNULL_BEGIN

@interface Post : PFObject<PFSubclassing>

@property (nonatomic, strong) PFUser *author;
@property (nonatomic, strong) NSString *caption;

@property (nonatomic, strong) PFFileObject *image;

+ (void) postUserImage: ( UIImage * _Nullable )image withCaption: ( NSString * _Nullable )caption withCompletion: (PFBooleanResultBlock  _Nullable)completion;


@end

NS_ASSUME_NONNULL_END
