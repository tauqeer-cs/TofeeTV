//
//  RegitersViewController.m
//  TofeeTV
//
//  Created by Tauqeer Ahmed on 07/02/2019.
//  Copyright © 2019 Tauqeer. All rights reserved.
//

#import "RegitersViewController.h"

@interface RegitersViewController ()
@property (weak, nonatomic) IBOutlet UITextField *txtName;
@property (weak, nonatomic) IBOutlet UITextField *txtEmail;
@property (weak, nonatomic) IBOutlet UITextField *txtPassword;

@end

@implementation RegitersViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}
- (IBAction)btnRegisterTapped:(UIButton *)sender {
 
    [User callRegisterUserWithEmail:self.txtEmail.text withFirstName:self.txtName.text withLastName:@"" withPassword:self.txtPassword.text withImage:nil withComplitionHandler:^(id result) {
    
        
    } withFailueHandler:^{
        
    } withAlreadyExistsHandler:^(id result) {
        
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

@end
