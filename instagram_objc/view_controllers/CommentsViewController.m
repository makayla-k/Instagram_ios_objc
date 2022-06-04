//
//  CommentsViewController.m
//  instagram_objc
//
//  Created by Makayla Rodriguez on 6/1/22.
//

#import "CommentsViewController.h"
#import "CommentCell.h"
#import "Comment.h"

@interface CommentsViewController ()<UITableViewDataSource, UITableViewDelegate, UITextViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UITextView *postCommentView;
@property (strong, nonatomic) NSArray *commentsArray;

@end

@implementation CommentsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    
//    border around text view
    self.postCommentView.layer.borderWidth =.5;
    self.postCommentView.layer.cornerRadius = 5.0;
    
//    [self getComments];
    [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(onTimer) userInfo:nil repeats:true];

}

- (void)onTimer {
    PFQuery *query = [PFQuery queryWithClassName:@"Comment"];
    [query orderByDescending:@"createdAt"];
    [query whereKey:@"post" equalTo:self.post];
    [query includeKey:@"author"];

    // fetch data asynchronously
    [query findObjectsInBackgroundWithBlock:^(NSArray *comments, NSError *error) {
        if (comments != nil) {
            // do something with the array of object returned by the call
            self.commentsArray = comments;
            [self.tableView reloadData];
        } else {
            NSLog(@"%@", error.localizedDescription);
        }
    }];
}

//-(void)getComments {
//
//    PFQuery *query = [PFQuery queryWithClassName:@"Comment"];
//    [query orderByDescending:@"createdAt"];
//    [query whereKey:@"post" equalTo:self.post];
//    [query includeKey:@"author"];
//
//    // fetch data asynchronously
//    [query findObjectsInBackgroundWithBlock:^(NSArray *comments, NSError *error) {
//        if (comments != nil) {
//            // do something with the array of object returned by the call
//            self.commentsArray = comments;
//        } else {
//            NSLog(@"%@", error.localizedDescription);
//        }
//
//    }];
//
//}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.commentsArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    CommentCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CommentCell"];
    Comment *comment = self.commentsArray[indexPath.row];
    
    PFUser *user = comment[@"author"];
    
    cell.usernameLabel.text = user.username;
    cell.commentView.text = comment[@"text"];
    
    return cell;
}
- (IBAction)didTapPost:(id)sender {
    if(self.postCommentView.text != nil){
        [Comment postUserComment:self.postCommentView.text withPost: self.post withCompletion:^(BOOL succeeded, NSError * _Nullable error) {
            NSLog(@"Successfully posted comment!");
        }];
    }
    else{
        //    alert if no image was uploaded
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Error" message:@"Cannot post empty comment" preferredStyle:(UIAlertControllerStyleAlert)];
            // create an OK action
            UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"OK"style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                [self viewDidLoad];
            }];
            [alert addAction:okAction];
            
            [self presentViewController:alert animated:YES completion:^{
            // optional code for what happens after the alert controller has finished presenting
            }];
            
    }
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
