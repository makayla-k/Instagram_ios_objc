//
//  CommentsViewController.m
//  instagram_objc
//
//  Created by Makayla Rodriguez on 6/1/22.
//

#import "CommentsViewController.h"
#import "CommentCell.h"

@interface CommentsViewController ()<UITableViewDataSource, UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation CommentsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 3;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    CommentCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CommentCell"];
    
    cell.usernameLabel.text = @"Iron Man";
    cell.commentView.text = @"If you like Captain America Unfollow Me!";
    
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
