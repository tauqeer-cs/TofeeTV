//
//  ContactUsViewController.m
//  TofeeTV
//
//  Created by Tauqeer Ahmed on 10/07/2019.
//  Copyright © 2019 Tauqeer. All rights reserved.
//

#import "ContactUsViewController.h"

@interface ContactUsViewController ()

@property (nonatomic,weak) NSString * emailUsing;
@property (weak, nonatomic) IBOutlet UITextField *txtPhone;
@property (weak, nonatomic) IBOutlet UITextView *txtMessage;
@property (nonatomic, retain) IBInspectable NSString *placeholder;
@property (nonatomic, retain) IBInspectable UIColor *placeholderColor;
@property (nonatomic, retain) UILabel *placeHolderLabel;


@property (weak, nonatomic) IBOutlet UIButton *btnSend;

@end

@implementation ContactUsViewController

-(NSString *)emailUsing {
 
    return @"info@toffeetv.com";
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.txtPhone.textColor = [UIColor blackColor];
    [self setPlaceHolderColorWithTextFieldWith:self.txtPhone];
    self.txtMessage.textColor = [UIColor blackColor];
    self.placeholderColor = [UIColor blackColor];
    self.placeholder = @"  Enter message";
    
    self.txtMessage.delegate = self;

    self.txtMessage.text = self.placeholder;
    
    self.txtPhone.font = [UIFont fontWithName:FancyFont size:16.0];
    self.txtMessage.font = [UIFont fontWithName:FancyFont size:16.0];
    
    self.btnSend.titleLabel.font = [UIFont fontWithName:FancyFont size:18.0];
    
}

- (void)textViewDidBeginEditing:(UITextView *)textView
{
    if ([textView.text isEqualToString:self.placeholder]) {
        textView.text = @"";
        if (IS_IPHONE_5) {
            
            //[self slideUp:70];
            
        }
    }
    
    [textView becomeFirstResponder];
}

- (void)textViewDidEndEditing:(UITextView *)textView
{
    
    if ([textView.text isEqualToString:@""]) {
        
        textView.text = self.placeholder;
        
    }
    
    [textView resignFirstResponder];
    
}


- (IBAction)btnSendTapped:(UIButton *)sender {
    
    
    
    if ([self.txtMessage.text length] == 0 || [self.txtMessage.text isEqualToString:self.placeholder]) {
        
        [self showAlert:@"" message:@"Please enter message."];
        return;
        
    }

    [self showLoader];
    
    [User callContactUs:self.txtPhone.text withMessage:self.txtMessage.text withComplitionHandler:^(id result) {
    
        
        [self hideLoader];
        [self callAlertViewControllerWithTitle:@"" withMessage:@"Message sent successfully" withOkButtonTitle:@"OK" withCancleTitle:@"" withOKHandler:^{
            [self.navigationController popViewControllerAnimated:YES];
            
        } withCancelHandler:^{
            
        }];
        
    } withFailueHandler:^{
        
        [self hideLoader];
        [self showAlert:@"" message:@"Error while sending message."];
        
    }];
    
    
    
}

@end
