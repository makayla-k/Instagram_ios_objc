//
//  HomeFeedViewController.m
//  instagram_objc
//
//  Created by Makayla Rodriguez on 5/31/22.
//

#import "HomeFeedViewController.h"
#import "PostCell.h"
#import "CommentsViewController.h"
#import "ComposeViewController.h"
#import "DetailsViewController.h"
#import "UserInfoViewController.h"

@interface HomeFeedViewController ()<ComposeViewControllerDelegate, UITableViewDataSource, UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) NSArray *postsArray;
@property (nonatomic, strong) UIRefreshControl *refreshControl;

@end

@implementation HomeFeedViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    
    [self getPosts];
    
    // Initialize a UIRefreshControl
        self.refreshControl = [[UIRefreshControl alloc] init];
        [self.refreshControl addTarget:self action:@selector(getPosts) forControlEvents:UIControlEventValueChanged];
        [self.tableView insertSubview:self.refreshControl atIndex:0];
}

-(void)getPosts {
    PFQuery *query = [PFQuery queryWithClassName:@"Post"];
    [query orderByDescending:@"createdAt"];
    [query includeKey:@"author"];

    // fetch data asynchronously
    [query findObjectsInBackgroundWithBlock:^(NSArray *posts, NSError *error) {
        if (posts != nil) {
            // do something with the array of object returned by the call
            self.postsArray = posts;
            [self.tableView reloadData];
        } else {
            NSLog(@"%@", error.localizedDescription);
        }
        
        [self.refreshControl endRefreshing];
    }];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.postsArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    PostCell *cell = [tableView dequeueReusableCellWithIdentifier:@"PostCell"];
    PFObject *post = self.postsArray[indexPath.row];
    
    cell.commentButton.tag = indexPath.row;
    cell.infoButton.tag = indexPath.row;
    cell.likeButton.tag = indexPath.row;

    
    PFUser *user = post[@"author"];
    if (user != nil) {
        // User found! update username label with username
        cell.usernameTopLabel.text = user.username;
        cell.usernameBottomLabel.text = user.username;
    } else {
        // No user found, set default username
        cell.usernameTopLabel.text = @"🤖";
        cell.usernameBottomLabel.text = @"🤖";
    }
    
    //    get profile image from parse
    PFFileObject *userProfileImageFile = user[@"profileImage"];
    cell.imageFileProfile = userProfileImageFile;
    [userProfileImageFile getDataInBackgroundWithBlock:^(NSData *imageData, NSError *error) {
        if (!error) {
            cell.profileImage.image = [UIImage imageWithData:imageData];
        }
    }];
    
//    get post image from parse
    PFFileObject *userImageFile = post[@"image"];
    cell.imageFilePost = userImageFile;
    [userImageFile getDataInBackgroundWithBlock:^(NSData *imageData, NSError *error) {
        if (!error) {
            cell.postImage.image = [UIImage imageWithData:imageData];
        }
    }];
    
    cell.captionView.text = post[@"caption"];
    cell.numberOfLikesLabel.text = [NSString stringWithFormat: @"%@", post[@"likes"]];
    
    // TODO: Format and set createdAtString
    NSDate *date = post.createdAt;
    //convert Date to time ago since now
    NSNumber *myDoubleNumber = [NSNumber numberWithDouble:date.timeIntervalSinceNow];
    double myNum = labs([myDoubleNumber doubleValue]);
    int temp;
    
    if(myNum > 86400) {
        temp = (myNum / 86400);
        cell.timestampLabel.text = [NSString stringWithFormat: @"%dd", temp];
    }
    else if(myNum > 3600) {
        temp = (myNum / 3600);
        cell.timestampLabel.text = [NSString stringWithFormat: @"%dh", temp];
    }
    else if(myNum > 60) {
        temp = (myNum / 60);
        cell.timestampLabel.text = [NSString stringWithFormat: @"%dm", temp];
    }
    else {
        temp = (myNum / 6);
        cell.timestampLabel.text = [NSString stringWithFormat: @"%ds", temp];
    }
        
    return cell;
}

- (IBAction)didTapLike:(id)sender {
    NSInteger i = [sender tag];
    PFObject *post = self.postsArray[i];
//    int likes = [[post objectForKey:@"likes"] intValue];
    [post incrementKey:@"likes"];
    
    [post saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
      if (succeeded) {
        // The score key has been incremented
          NSLog(@"succeeded updating post likes");
          [self.tableView reloadData];
      } else {
        // There was a problem, check error.description
      }
    }];

}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (void)didPost {
    [self getPosts];
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
*/

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    
    if([[segue identifier] isEqualToString:@"composeSegue"]){
        UINavigationController *navigationController = [segue destinationViewController];
        ComposeViewController *composeController = (ComposeViewController*)navigationController.topViewController;
        composeController.delegate = self;
    }
    if([[segue identifier] isEqualToString:@"commentsSegue"]){
        UINavigationController *navigationController = [segue destinationViewController];
        CommentsViewController *commentViewController = (CommentsViewController*)navigationController.topViewController;
        NSInteger i = [sender tag];
//        NSIndexPath *indexPath = tappedBtn.tag;
        Post *post = self.postsArray[i];
        commentViewController.post = post;

    }
    if([[segue identifier] isEqualToString:@"detailsSegue"]) {
        UINavigationController *navigationController = [segue destinationViewController];
        DetailsViewController *detailsViewController = (DetailsViewController*)navigationController.topViewController;
        PostCell *tappedCell = sender;
        NSIndexPath *indexPath = [self.tableView indexPathForCell:tappedCell];
        Post *post = self.postsArray[indexPath.row];
        detailsViewController.post = post;
    }
    if([[segue identifier] isEqualToString:@"profileInfoSegue"]) {
        UINavigationController *navigationController = [segue destinationViewController];
        UserInfoViewController *userInfoViewController = (UserInfoViewController*)navigationController.topViewController;
        NSInteger i = [sender tag];
        Post *post = self.postsArray[i];
        userInfoViewController.user = post[@"author"];
    }
}

@end
