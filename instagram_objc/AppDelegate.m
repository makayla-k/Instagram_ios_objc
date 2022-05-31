//
//  AppDelegate.m
//  instagram_objc
//
//  Created by Makayla Rodriguez on 5/30/22.
//

#import "AppDelegate.h"
#import <Parse/Parse.h>

@interface AppDelegate ()

@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
//    get values from keys file
    NSString *path = [[NSBundle mainBundle] pathForResource: @"Keys" ofType: @"plist"];
    NSDictionary *dict = [NSDictionary dictionaryWithContentsOfFile: path];
    
    // Override point for customization after application launch.
    [Parse initializeWithConfiguration:[ParseClientConfiguration configurationWithBlock:^(id<ParseMutableClientConfiguration> configuration) {
        configuration.applicationId = [dict objectForKey: @"application_Id"];
        configuration.clientKey = [dict objectForKey: @"client_Key"];
        configuration.server = @"https://parseapi.back4app.com/";
    }]];
    
    [self saveInstallationObject];
    
//    create a test user
//    PFUser *newUser = [PFUser user];
//    newUser.username = @"makayla";
//    newUser.password = @"makayla";
//    newUser.email = @"makayla@codepath.org";
//    [newUser signUpInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
//        if (succeeded) {
//            NSLog(@"Object saved!");
//        } else {
//            NSLog(@"Error: %@", error.description);
//        }
//    }];

    return YES;
}

-(void)saveInstallationObject{
    PFInstallation *currentInstallation = [PFInstallation currentInstallation];
    [currentInstallation saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        if (!error) {
            NSLog(@"You have successfully connected your app to Back4App!");
        }else{
            NSLog(@"installation save failed %@",error.debugDescription);
        }
    }];
}


#pragma mark - UISceneSession lifecycle


- (UISceneConfiguration *)application:(UIApplication *)application configurationForConnectingSceneSession:(UISceneSession *)connectingSceneSession options:(UISceneConnectionOptions *)options {
    // Called when a new scene session is being created.
    // Use this method to select a configuration to create the new scene with.
    return [[UISceneConfiguration alloc] initWithName:@"Default Configuration" sessionRole:connectingSceneSession.role];
}


- (void)application:(UIApplication *)application didDiscardSceneSessions:(NSSet<UISceneSession *> *)sceneSessions {
    // Called when the user discards a scene session.
    // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
    // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
}


@end
