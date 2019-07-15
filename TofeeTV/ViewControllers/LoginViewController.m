//
//  LoginViewController.m
//  GiftList
//
//  Created by Shehzad Bilal on 8/15/18.
//  Copyright © 2018 Grappetite. All rights reserved.
//

#import "LoginViewController.h"

@interface LoginViewController ()

@property (weak, nonatomic) IBOutlet UIButton *btnSignUp;

@property (weak, nonatomic) IBOutlet UIButton *btnFB;
@property (weak, nonatomic) IBOutlet UIView *viewContainerUsername;

@property (weak, nonatomic) IBOutlet UIView *viewContainerPassword;
@property (weak, nonatomic) IBOutlet UIButton *btnLogin;
@property (weak, nonatomic) IBOutlet UITextField *txtEmail;
@property (weak, nonatomic) IBOutlet UITextField *txtPassword;
@property (weak, nonatomic) IBOutlet UIButton *btnForgotPassword;

@end

@implementation LoginViewController

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self showAllFonts];
    
    ///[self makeButtonRounded:self.btnSignUp];
    
    self.txtEmail.delegate = self;
    self.txtPassword.delegate = self;
    
    
    
    
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:@"Not Registered? Sign Up" attributes:@{
                                                                                                                                            NSFontAttributeName: [UIFont fontWithName:FancyFont size: 22.0f],
                                                                                                                                            NSForegroundColorAttributeName: [UIColor whiteColor]
                                                                                                                                            }];
    [attributedString addAttribute:NSFontAttributeName value:[UIFont fontWithName:FancyFont size: 22.0f] range:NSMakeRange(16, 7)];
    
    
    [self.btnSignUp setAttributedTitle:attributedString forState:UIControlStateNormal];
    
    
    [self makeButtonRounded:self.btnFB];
    
    [self makeViewRounded:self.viewContainerUsername];
    [self makeViewRounded:self.viewContainerPassword];
    
    self.viewContainerPassword.superview.backgroundColor = [UIColor clearColor];
    
    self.btnLogin.superview.backgroundColor = [UIColor clearColor];
    [self makeButtonRounded:self.btnLogin];
    

    
    [self setTouchMethodWithLabel:self.view withSelector:@selector(viewTouched)];
    
    [self setTextFieldFont:self.txtEmail];
    [self setTextFieldFont:self.txtPassword];
    [self setPlaceHolderColorWithTextFieldWith:self.txtEmail];
    [self setPlaceHolderColorWithTextFieldWith:self.txtPassword];
    
    [self setupSignUPFormButtonsFont:self.btnLogin];
    [self.btnLogin setBackgroundColor:DefaultYellowColor2];
    
    [self setupSignUPFormButtonsFont:self.btnFB];

//   [self inititateTheAudioFile:@"App background loop" withFileType:@"wav" withOneTimePlay:NO];


}

- (void)makeButtonRounded:(UIButton *)btnFeedback
{
    
    btnFeedback.layer.cornerRadius  = 25;
    
    
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
- (IBAction)btnReset:(id)sender {

    [self showLoader];
    
    
    [User callForgetAccount:self.txtEmail.text withComplitionHandler:^(id result) {
    [self hideLoader];
   
        [self callAlertViewControllerWithTitle:@"" withMessage:result withOkButtonTitle:@"OK" withCancleTitle:@"" withOKHandler:^{
            
            [self.navigationController popViewControllerAnimated:YES];
            
        } withCancelHandler:^{
            
        }];
    } withFailueHandler:^{
            [self showLoader];
        [self showAlert:@"" message:@"Could not send email."];
    }];
    
}



@end
