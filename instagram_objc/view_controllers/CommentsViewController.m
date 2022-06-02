//
//  CommentsViewController.m
//  instagram_objc
//
//  Created by Makayla Rodriguez on 6/1/22.
//

#import "CommentsViewController.h"
#import "CommentCell.h"

@interface CommentsViewController ()<UITableViewDataSource, UITableViewDelegate, UITextViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UITextView *postCommentView;
@property (weak, nonatomic) IBOutlet UIButton *postButton;

@end

@implementation CommentsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
//    self.postCommentView.delegate = self;
}

//- (BOOL)textViewShouldBeginEditing:(UITextView *)textView{
//    [textView becomeFirstResponder];
//    return YES;
//}
//
//- (BOOL)textViewShouldEndEditing:(UITextView *)textView{
//    //resign for exapmple
//    return YES;
//}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 3;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    CommentCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CommentCell"];
    
    cell.usernameLabel.text = @"Iron Man";
    cell.commentView.text = @"If you like Captain America Unfollow Me! I love";
    
    return cell;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
