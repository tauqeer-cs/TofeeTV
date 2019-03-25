//
//  RegitersViewController.m
//  TofeeTV
//
//  Created by Tauqeer Ahmed on 07/02/2019.
//  Copyright © 2019 Tauqeer. All rights reserved.
//

#import "RegitersViewController.h"

@interface RegitersViewController ()

@property (weak, nonatomic) IBOutlet UITextField *txtEmail;
@property (weak, nonatomic) IBOutlet UITextField *txtPassword;

@property (weak, nonatomic) IBOutlet UIView *viewFullNameContainer;

@property (weak, nonatomic) IBOutlet UIView *viewEmailContainer;

@property (weak, nonatomic) IBOutlet UIView *viewPasswordContainer;

@property (weak, nonatomic) IBOutlet UIView *viewConfirmPasswordContainer;

@property (weak, nonatomic) IBOutlet UIView *viewTerms;
@property (weak, nonatomic) IBOutlet UIButton *btnIAgree;
@property (weak, nonatomic) IBOutlet UILabel *lblTermsText;

@property (weak, nonatomic) IBOutlet UIButton *btnRegister;


@property (weak, nonatomic) IBOutlet UITextField *txtFullName;


@property (weak, nonatomic) IBOutlet UITextField *txtConfirmPassword;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *viewHeightConstant;


@property (weak, nonatomic) IBOutlet UIButton *btnProfile;

@property (nonatomic,strong) UIImage * selectedImage;

@property (weak, nonatomic) IBOutlet UIButton *btnEdit;

@property (weak, nonatomic) IBOutlet UIButton *btnChangePasswordButton;



@end

@implementation RegitersViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Do any additional setup after loading the view.

    self.title = @"Sign Up";
    
    [self.viewTerms setHidden:YES];
    
    [self.btnProfile roundTheView];
    
    [self.viewTerms setBackgroundColor:[UIColor clearColor]];
    
    [self makeViewRounded:self.viewFullNameContainer];
    
    [self makeViewRounded:self.viewEmailContainer];
    
    [self makeViewRounded:self.viewPasswordContainer];
    
    [self makeViewRounded:self.viewConfirmPasswordContainer];
    
    [self makeButtonRounded:self.btnRegister];
    
    [self setupSignUPFormButtonsFont:self.btnRegister];
    
    [self.btnRegister setBackgroundColor:DefaultYellowColor2];
    
    
    
    
    [self setTextFieldFont:self.txtFullName];
    
    [self setTextFieldFont:self.txtEmail];
    [self setTextFieldFont:self.txtPassword];
    [self setTextFieldFont:self.txtConfirmPassword];
    
    
    [self setPlaceHolderColorWithTextFieldWith:self.txtFullName];
    [self setPlaceHolderColorWithTextFieldWith:self.txtEmail];
    [self setPlaceHolderColorWithTextFieldWith:self.txtPassword];
    [self setPlaceHolderColorWithTextFieldWith:self.txtConfirmPassword];
    
    
    self.txtFullName.delegate = self;

    self.txtPassword.delegate = self;
    self.txtEmail.delegate = self;
    
    
    [self.btnIAgree roundTheView];
    
    [self setLblTermsText];
    
    self.lblTermsText.userInteractionEnabled = YES;
    
    //[self setTouchMethodWithLabel:self.lblTermsText withSelector:@selector(showTerms)];
    
    
    
    
    
    //[self setTouchMethodWithLabel:self.lblTermsText withSelector:@selector(termsLabelTapped)];
    
    [self setTouchMethodWithLabel:self.view withSelector:@selector(viewTouched)];
    
    
}

/*
- (void)makeButtonRounded:(UIButton *)btnFeedback
{
    
    btnFeedback.layer.cornerRadius  = 25;
    
    
}*/


- (void)setLblTermsText {
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:IAgreeToTerms
                                                                                         attributes:@{
                                                                                                      NSFontAttributeName: [UIFont fontWithName:@"Raleway-Regular" size: 10.33f],
                                                                                                      NSForegroundColorAttributeName: [UIColor colorWithRed:214.0f / 255.0f green:4.0f / 255.0f blue:3.0f / 255.0f alpha:1.0f],
                                                                                                      NSKernAttributeName: @(0.26)
                                                                                                      }];
    [attributedString addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithWhite:74.0f / 255.0f alpha:1.0f] range:NSMakeRange(0, 14)];
    
    self.lblTermsText.attributedText = attributedString;
}

- (IBAction)btnRegisterTapped:(UIButton *)sender {
 
    if ([self.txtFullName.text length] == 0)
    {
        [self showAlert:Error message:PleaseFullname];
        return;
        
    }
    else if(![Validator validateEmailAddress:self.txtEmail.text])
    {
        [self showAlert:Error message:ValidEmailError];
        return;
        
    }
    else if(self.isEditMode)
    {
        
    }
    else if([self.txtPassword.text length] < 6)
    {
        
        [self showAlert:Error message:PasswordCntBeLessThan6];
        return;
        
    }
    else if(![self.txtPassword.text isEqualToString:self.txtConfirmPassword.text])
    {
        
        [self showAlert:Error message:PasswordAndConfirmPasswordDoesNotMatch];
        return;
        
    }
    
    if (self.isEditMode)
    {
        
    }
    /*
    else
        if (!self.btnIAgree.isSelected) {
            
            [self showAlert:Error message:PleaseReadTerms];
            
            return;
            
        }*/
    
    
    
    [self showLoader];
    
    
    [User callRegisterUserWithEmail:self.txtEmail.text withFirstName:self.txtFullName.text withLastName:@"" withPassword:self.txtPassword.text withImage:nil withComplitionHandler:^(id result) {
    
        [self changeTheViewRootControlletWithStoryBoardName:@"Main" withRootName:@"RootTapBar"];
        
        
        
        
    } withFailueHandler:^{
        
        [self hideLoader];
        
    } withAlreadyExistsHandler:^(id result) {
        
        [self showAlert:@"Error" message:@"User already exists"];
    }];
    
    
}

-(void)viewDidAppear:(BOOL)animated
{
    
    [super viewDidAppear:animated];
    
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    
}

-(void)viewTouched
{
    //  [self slideBackToNormal];
    
    [self.view endEditing:YES];
    
    
}



-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    
    
 if (textField.tag == 99)
    {
        
        if ([self.txtEmail.text length] == 0) {
            
            [self.txtEmail becomeFirstResponder];
            
        }
        else
        {
            [textField resignFirstResponder];
        }
        
    }
    else if (textField.tag == 2)
    {
        
        if ([self.txtPassword.text length] == 0) {
            
            [self.txtPassword becomeFirstResponder];
            
        }
        else
        {
            [textField resignFirstResponder];
        }
        
    }
    else if (textField.tag == 3)
    {
        
        if ([self.txtConfirmPassword.text length] == 0) {
            
            [self.txtConfirmPassword becomeFirstResponder];
            
        }
        else
        {
            [textField resignFirstResponder];
        }
        
    }
    else
    {
        [textField resignFirstResponder];
        
    }
    return YES;
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
