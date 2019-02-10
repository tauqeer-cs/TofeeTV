//
//  LoginViewController.m
//  GiftList
//
//  Created by Shehzad Bilal on 8/15/18.
//  Copyright © 2018 Grappetite. All rights reserved.
//

#import "LoginViewController.h"

#import <FBSDKCoreKit/FBSDKCoreKit.h>
#import <FBSDKLoginKit/FBSDKLoginKit.h>

@interface LoginViewController ()

@property (weak, nonatomic) IBOutlet UIButton *btnSignUp;

@property (weak, nonatomic) IBOutlet UIButton *btnFB;
@property (weak, nonatomic) IBOutlet UIView *viewContainerUsername;

@property (weak, nonatomic) IBOutlet UIView *viewContainerPassword;
@property (weak, nonatomic) IBOutlet UIButton *btnLogin;
@property (weak, nonatomic) IBOutlet UITextField *txtEmail;
@property (weak, nonatomic) IBOutlet UITextField *txtPassword;
@property (weak, nonatomic) IBOutlet UIView *lblOR;
@property (weak, nonatomic) IBOutlet UILabel *lblOr;

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self showAllFonts];
    
    ///[self makeButtonRounded:self.btnSignUp];
    
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:@"Not Registered? Sign Up" attributes:@{
                                                                                                                                            NSFontAttributeName: [UIFont fontWithName:@"Raleway-Regular" size: 14.0f],
                                                                                                                                            NSForegroundColorAttributeName: [UIColor colorWithWhite:42.0f / 255.0f alpha:1.0f]
                                                                                                                                            }];
    [attributedString addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"Raleway-SemiBold" size: 14.0f] range:NSMakeRange(16, 7)];
    
    
    [self.btnSignUp setAttributedTitle:attributedString forState:UIControlStateNormal];
    
    
    [self makeButtonRounded:self.btnFB];
    
    [self makeViewRounded:self.viewContainerUsername];
    [self makeViewRounded:self.viewContainerPassword];
    
    self.viewContainerPassword.superview.backgroundColor = [UIColor clearColor];
    
    self.btnLogin.superview.backgroundColor = [UIColor clearColor];
    [self makeButtonRounded:self.btnLogin];
    
    //
    
    [self setTouchMethodWithLabel:self.view withSelector:@selector(viewTouched)];
    
    [self setTextFieldFont:self.txtEmail];
    [self setTextFieldFont:self.txtPassword];
    [self setPlaceHolderColorWithTextFieldWith:self.txtEmail];
    [self setPlaceHolderColorWithTextFieldWith:self.txtPassword];
    
    [self setupSignUPFormButtonsFont:self.btnLogin];
    [self.btnLogin setBackgroundColor:DefaultRed];
    [self setupSignUPFormButtonsFont:self.btnFB];
    [self.lblOr setFont:[UIFont fontWithName:FontRegular size:15.0]];
    
    
    

}

- (void)makeButtonRounded:(UIButton *)btnFeedback
{
    
    btnFeedback.layer.cornerRadius  = 25;
    
    
}



-(void)getFacebookProfileInfos {
    
    FBSDKGraphRequest *requestMe = [[FBSDKGraphRequest alloc]initWithGraphPath:@"me" parameters: @{@"fields": @"id,name,link,first_name, last_name, picture.type(large), email  "}];
    
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



- (IBAction)btnSignUpTapped:(id)sender
{

    [self changeTheViewRootControlletWithStoryBoardName:@"Main" withRootName:@"RootTapBar"];
    
    
    
    //[self performSegueWithIdentifier:@"segueRegister" sender:self];

}

- (IBAction)btnGoToRegisterTapped:(UIButton *)sender {
    
    
    [self performSegueWithIdentifier:@"segueRegister" sender:self];
    
    
}


- (IBAction)btnLoginTapped:(id)sender {
    
    
    
    if (![Validator validateEmailAddress:self.txtEmail.text]) {
        
        [self showAlert:Error message:ValidEmailError];
        return;
        
    }
    
    if ([self.txtPassword.text length] == 0) {
        
        
        [self showAlert:Error message:PleasePassword];
        return;
        
    }
    
    [self showLoader];
    
    
    [User callLoginUserWithEmail:self.txtEmail.text
                    withPassword:self.txtPassword.text
           withComplitionHandler:^(id result) {
        

               [self hideLoader];
               

               [self changeTheViewRootControlletWithStoryBoardName:@"Main" withRootName:@"RootTapBar"];
               
               
               
               [User callAddPushIds:1 withComplitionHandler:^(id result) {
                   
               } withFailueHandler:^(id error) {
                   
               } withAlreadyExistsHandler:^(id result) {
                   
               }];
               
               
    } withFailueHandler:^(id message) {
        
        [self hideLoader];
        
        [self showAlert:Error message:InvalidPassword];
        
    } withNoAccountExistsHandler:^(id result) {
        
        [self hideLoader];
        
    }];
    
}
- (IBAction)btnFacebookTapped:(UIButton *)sender {
    
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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
-(BOOL) textFieldShouldReturn:(UITextField *)textField{
    
    
    if (textField.tag == 11)
    {
    
        if ([self.txtPassword.text length] == 0) {
            
            [self.txtPassword becomeFirstResponder];
            
        }
        else
        {

        }
    }
    else
    {
                [textField resignFirstResponder];
        
    }
    return YES;
}




- (IBAction)btnForgotPasswordTapped:(UIButton *)sender {
    
    
    [self performSegueWithIdentifier:@"segueForgotPassword" sender:self];
    
    
    
    
    
}


@end
