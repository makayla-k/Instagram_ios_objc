//
//  Comment.h
//  instagram_objc
//
//  Created by Makayla Rodriguez on 6/3/22.
//

#import <Foundation/Foundation.h>
#import <Parse/Parse.h>

NS_ASSUME_NONNULL_BEGIN

@interface Comment : PFObject<PFSubclassing>

@property (nonatomic, strong) PFUser *author;
@property (nonatomic, strong) NSString *text;
@property (nonatomic, weak) PFObject *post;

+ (void) postUserComment: ( NSString * _Nullable )text withPost:( PFObject * _Nullable )post withCompletion: (PFBooleanResultBlock  _Nullable)completion;

@end

NS_ASSUME_NONNULL_END
