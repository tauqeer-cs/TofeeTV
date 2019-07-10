//
//  LoginOptionsViewController.m
//  TofeeTV
//
//  Created by Tauqeer Ahmed on 22/06/2019.
//  Copyright © 2019 Tauqeer. All rights reserved.
//

#import "LoginOptionsViewController.h"

@interface LoginOptionsViewController ()

@property (weak, nonatomic) IBOutlet UILabel *lblFb;
@property (weak, nonatomic) IBOutlet UILabel *lblEmail;

@end

@implementation LoginOptionsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.lblFb.userInteractionEnabled = YES;
    self.lblEmail.userInteractionEnabled = YES;
    
    //LoginOptionsViewController
    
    [self setTouchMethodWithLabel:self.lblEmail withSelector:@selector(emailButtonTapped)];
    
    [self setTouchMethodWithLabel:self.lblFb withSelector:@selector(fbButtonTapped)];
   // [self inititateTheAudioFile:@"App background loop" withFileType:@"wav" withOneTimePlay:NO];
    
    [self launcherThings];
    
    
}

-(void)getFacebookProfileInfos {
    
    //picture.type(large)
    
    FBSDKGraphRequest *requestMe = [[FBSDKGraphRequest alloc]initWithGraphPath:@"me" parameters: @{@"fields": @"id,name,link,first_name, last_name, email  "}];
    
    FBSDKGraphRequestConnection *connection = [[FBSDKGraphRequestConnection alloc] init];
    [connection addRequest:requestMe completionHandler:^(FBSDKGraphRequestConnection *connection,
                                                         id result,
                                                         NSError *error) {
        //ok wjat
        
        if (error)
        {
            
            
            
        }
        if(result)
        {
            //
            //self.currentDicationary = result;
            
            NSString *fbId = [result objectForKey:@"id"];
            
            
            
            
            
            NSString *pictureUrl =  [[[result objectForKey:@"picture"] objectForKey:@"data"] objectForKey:@"url"];
            
            [self showLoader];
            NSLog(@"%@",[FBSDKAccessToken currentAccessToken].tokenString);
            
            
            [User callRegisterUserWithSocial:[FBSDKAccessToken currentAccessToken].tokenString withComplitionHandler:^(id result) {
                
                
                [self hideLoader];
                
                
                [self changeTheViewRootControlletWithStoryBoardName:@"Main" withRootName:@"RootTapBar"];
                
                [User callAddPushIds:1 withComplitionHandler:^(id result) {
                    
                } withFailueHandler:^(id error) {
                    
                } withAlreadyExistsHandler:^(id result) {
                    
                }];
                
                
                
                NSLog(@"");
                
            } withFailueHandler:^(id error) {
                
                [self hideLoader];
                [self showAlert:Error message:ErrorWhileLoggingFacebook];
                
                
                
            } withAlreadyExistsHandler:^(id result) {
                
                [self showAlert:Error message:ErrorWhileLoggingFacebook];
                
                
            }];
            
            /*
             [User callCheckFbLoginIdExists:[FBSDKAccessToken currentAccessToken].tokenString
             withDoesNotExistsHandler:^(id result) {
             
             [self hideLoader];
             
             
             [self performSegueWithIdentifier:@"segueRegister2" sender:self];
             
             
             [self.userDefaults setObject:@"1" forKey:@"isFB"];
             
             [[NSUserDefaults standardUserDefaults] setObject:nil forKey:@"DisclaimerForChat"];
             
             
             
             
             } withFailueHandler:^{
             
             } withAlreadyExistsHandler:^(id result) {
             
             [self.userDefaults setObject:@"1" forKey:@"isFB"];
             [self hideLoader];
             [self changeMyRootViewWithStoryBoardName:@"Main" withViewControllerName:@"AppEntrance"];
             
             [[NSUserDefaults standardUserDefaults] setObject:@"1" forKey:@"DisclaimerForChat"];
             
             
             
             
             NSLog(@"");
             
             }];*/
            
            
            //url
            __block UIImage *tmp = nil;
            
            
            
        }
        
    }];
    
    [connection start];
}


-(void)emailButtonTapped{
    
    [self performSegueWithIdentifier:@"segueLoginViewController" sender:self];
    
}

-(void)fbButtonTapped {
    [self showLoader];
    
    FBSDKLoginManager *login = [[FBSDKLoginManager alloc] init];
    login.loginBehavior = FBSDKLoginBehaviorBrowser;
    [login logInWithReadPermissions:@[@"public_profile", @"email"]
                 fromViewController:self handler:^(FBSDKLoginManagerLoginResult *result, NSError *error) {
                     
                     
                     if (error)
                     {
                         // Process error
                         NSLog(@"Error");
                         [self hideLoader];
                         
                         [self showAlert:@"" message:ErrorWhileLoggingFacebook];
                         
                     }
                     else if (result.isCancelled)
                     {
                         // Handle cancellations
                         
                         [self hideLoader];
                         
                     }
                     else
                     {
                         
                         
                         [self getFacebookProfileInfos];
                         
                     }
                 }];
    
    
    
    
}
-(void)viewDidAppear:(BOOL)animated
{
    
    [super viewDidAppear:animated];
    
    [self.navigationController setNavigationBarHidden:YES animated:YES];
    
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
