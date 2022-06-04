//
//  CommentCell.m
//  instagram_objc
//
//  Created by Makayla Rodriguez on 6/1/22.
//

#import "CommentCell.h"

@implementation CommentCell

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
    
    self.usernameLabel.text = @"";
    self.commentView.text = @"";
    
}

@end
