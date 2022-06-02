//
//  Post.m
//  instagram_objc
//
//  Created by Makayla Rodriguez on 6/1/22.
//

#import "Post.h"

@implementation Post

@dynamic user;
@dynamic caption;
@dynamic image;

+ (nonnull NSString *)parseClassName {
    return @"Post";
}

@end
