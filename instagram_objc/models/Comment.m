//
//  Comment.m
//  instagram_objc
//
//  Created by Makayla Rodriguez on 6/3/22.
//

#import "Comment.h"

@implementation Comment

@dynamic author;
@dynamic text;
@dynamic post;

+ (nonnull NSString *)parseClassName {
    return @"Comment";
}


+ (void) postUserComment: ( NSString * _Nullable )text withPost:( PFObject * _Nullable )post withCompletion: (PFBooleanResultBlock  _Nullable)completion {
    
    Comment *newComment = [Comment new];
    newComment.author = [PFUser currentUser];
    newComment.text = text;
    newComment.post = post;
    
    [newComment saveInBackgroundWithBlock: completion];
    
}

@end
