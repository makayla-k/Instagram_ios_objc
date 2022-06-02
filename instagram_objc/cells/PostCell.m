//
//  PostCell.m
//  instagram_objc
//
//  Created by Makayla Rodriguez on 6/1/22.
//

#import "PostCell.h"

@implementation PostCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)prepareForReuse {
    [super prepareForReuse];
    
    self.usernameTopLabel.text = @"";
    self.usernameBottomLabel.text = @"";
    
    self.postImage.image = nil;
    [self.imageFile cancel];
    
}

@end
