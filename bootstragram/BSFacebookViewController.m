//
//  BSFacebookViewController.m
//  bootstragram
//
//  Created by Mickaël Floc'hlay on 26/03/2014.
//  Copyright (c) 2014 Bootstragram. All rights reserved.
//

#import "BSFacebookViewController.h"


@interface BSFacebookViewController ()

//@property (weak, nonatomic) IBOutlet FBProfilePictureView *profilePictureView;
//@property (weak, nonatomic) IBOutlet FBLoginView *loginView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *statusLabel;

@end

@implementation BSFacebookViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    //self.loginView.readPermissions = @[@"basic_info", @"email", @"user_likes"];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
 #pragma mark - Navigation

 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
 {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */


#pragma mark - Facebook Delegate

// This method will be called when the user information has been fetched
//- (void)loginViewFetchedUserInfo:(FBLoginView *)loginView user:(id<FBGraphUser>)user {
//    self.profilePictureView.profileID = user.id;
//    self.nameLabel.text = user.name;
//}

// Logged-in user experience
//- (void)loginViewShowingLoggedInUser:(FBLoginView *)loginView {
//    self.statusLabel.text = @"You're logged in as";
//}

// Logged-out user experience
//- (void)loginViewShowingLoggedOutUser:(FBLoginView *)loginView {
//    self.profilePictureView.profileID = nil;
//    self.nameLabel.text = @"";
//    self.statusLabel.text= @"You're not logged in!";
//}

// Handle possible errors that can occur during login
//- (void)loginView:(FBLoginView *)loginView handleError:(NSError *)error {
//    NSString *alertMessage, *alertTitle;
//
//    // If the user should perform an action outside of you app to recover,
//    // the SDK will provide a message for the user, you just need to surface it.
//    // This conveniently handles cases like Facebook password change or unverified Facebook accounts.
//    if ([FBErrorUtility shouldNotifyUserForError:error]) {
//        alertTitle = @"Facebook error";
//        alertMessage = [FBErrorUtility userMessageForError:error];
//
//        // This code will handle session closures that happen outside of the app
//        // You can take a look at our error handling guide to know more about it
//        // https://developers.facebook.com/docs/ios/errors
//    } else if ([FBErrorUtility errorCategoryForError:error] == FBErrorCategoryAuthenticationReopenSession) {
//        alertTitle = @"Session Error";
//        alertMessage = @"Your current session is no longer valid. Please log in again.";
//
//        // If the user has cancelled a login, we will do nothing.
//        // You can also choose to show the user a message if cancelling login will result in
//        // the user not being able to complete a task they had initiated in your app
//        // (like accessing FB-stored information or posting to Facebook)
//    } else if ([FBErrorUtility errorCategoryForError:error] == FBErrorCategoryUserCancelled) {
//        NSLog(@"user cancelled login");
//
//        // For simplicity, this sample handles other errors with a generic message
//        // You can checkout our error handling guide for more detailed information
//        // https://developers.facebook.com/docs/ios/errors
//    } else {
//        alertTitle  = @"Something went wrong";
//        alertMessage = @"Please try again later.";
//        NSLog(@"Unexpected error:%@", error);
//    }
//
//    if (alertMessage) {
//        [[[UIAlertView alloc] initWithTitle:alertTitle
//                                    message:alertMessage
//                                   delegate:nil
//                          cancelButtonTitle:@"OK"
//                          otherButtonTitles:nil] show];
//    }
//}


- (IBAction)shareAction:(id)sender {
    // We will post on behalf of the user, these are the permissions we need:
    NSArray *permissionsNeeded = @[@"publish_actions"];

    // Request the permissions the user currently has
//    [FBRequestConnection startWithGraphPath:@"/me/permissions"
//                          completionHandler:^(FBRequestConnection *connection, id result, NSError *error) {
//                              if (!error){
//                                  NSDictionary *currentPermissions= [(NSArray *)[result data] objectAtIndex:0];
//                                  NSMutableArray *requestPermissions = [[NSMutableArray alloc] initWithArray:@[]];
//
//                                  // Check if all the permissions we need are present in the user's current permissions
//                                  // If they are not present add them to the permissions to be requested
//                                  for (NSString *permission in permissionsNeeded){
//                                      if (![currentPermissions objectForKey:permission]){
//                                          [requestPermissions addObject:permission];
//                                      }
//                                  }
//
//                                  // If we have permissions to request
//                                  if ([requestPermissions count] > 0){
//                                      // Ask for the missing permissions
//                                      [FBSession.activeSession requestNewPublishPermissions:requestPermissions
//                                                                            defaultAudience:FBSessionDefaultAudienceFriends
//                                                                          completionHandler:^(FBSession *session, NSError *error) {
//                                                                              if (!error) {
//                                                                                  // Permission granted, we can request the user information
//                                                                                  [self makeRequestToShareLink];
//                                                                              } else {
//                                                                                  // An error occurred, handle the error
//                                                                                  // See our Handling Errors guide: https://developers.facebook.com/docs/ios/errors/
//                                                                                  DDLogError(@"%@", error.description);
//                                                                              }
//                                                                          }];
//                                  } else {
//                                      // Permissions are present, we can request the user information
//                                      [self makeRequestToShareLink];
//                                  }
//
//                              } else {
//                                  // There was an error requesting the permission information
//                                  // See our Handling Errors guide: https://developers.facebook.com/docs/ios/errors/
//                                  DDLogError(@"%@", error.description);
//                              }
//                          }];
}


- (void)makeRequestToShareLink {

    // NOTE: pre-filling fields associated with Facebook posts,
    // unless the user manually generated the content earlier in the workflow of your app,
    // can be against the Platform policies: https://developers.facebook.com/policy

    // Put together the dialog parameters
    NSMutableDictionary *params = [NSMutableDictionary dictionaryWithObjectsAndKeys:
                                   @"Sharing Tutorial", @"name",
                                   @"Build great social apps and get more installs.", @"caption",
                                   @"Allow your users to share stories on Facebook from your app using the iOS SDK.", @"description",
                                   @"https://developers.facebook.com/docs/ios/share/", @"link",
                                   @"http://i.imgur.com/g3Qc1HN.png", @"picture",
                                   nil];

    // Make the request
//    [FBRequestConnection startWithGraphPath:@"/me/feed"
//                                 parameters:params
//                                 HTTPMethod:@"POST"
//                          completionHandler:^(FBRequestConnection *connection, id result, NSError *error) {
//                              if (!error) {
//                                  // Link posted successfully to Facebook
//                                  DDLogVerbose(@"result: %@", result);
//                              } else {
//                                  // An error occurred, we need to handle the error
//                                  // See: https://developers.facebook.com/docs/ios/errors
//                                  DDLogVerbose(@"%@", error.description);
//                              }
//                          }];
}

@end
