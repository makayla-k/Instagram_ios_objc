//
//  HomeFeedViewController.m
//  instagram_objc
//
//  Created by Makayla Rodriguez on 5/31/22.
//

#import "HomeFeedViewController.h"
#import "PostCell.h"
#import "CommentsViewController.h"

@interface HomeFeedViewController ()<UITableViewDataSource, UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation HomeFeedViewController

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
    
    PostCell *cell = [tableView dequeueReusableCellWithIdentifier:@"PostCell"];
    
    cell.usernameTopLabel.text = @"Iron Man";
    cell.usernameBottomLabel.text = @"Iron Man";
    cell.captionView.text = @"If you like Captain America Unfollow Me!";
    
    return cell;
}



/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
*/

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    
    if([[segue identifier] isEqualToString:@"commentsSegue"]){
        UINavigationController *navigationController = [segue destinationViewController];
        CommentsViewController *commentViewController = (CommentsViewController*)navigationController.topViewController;
//        PostCell *tappedCell = sender;
//        NSIndexPath *indexPath = [self.tableView indexPathForCell:tappedCell];
        
    }
}

@end
