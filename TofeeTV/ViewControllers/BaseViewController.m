//
//  BaseViewController.m
//  GChat
//
//  Created by Tauqeer on 2014-09-26.
//  Copyright (c) 2014 Carlin. All rights reserved.
//

#import "BaseViewController.h"
#import "AppDelegate.h"
#import "DateFormatter.h"
#import <AVFoundation/AVFoundation.h>
#import "QZDateSelectorView.h"
#import "Config.h"
#import "CustomAddToListView.h"

@import AVKit;


@interface BaseViewController ()


@end

@implementation BaseViewController

-(void)addCollectionViewCellWithCollectionView:(UICollectionView *)collectionView withNibName:(NSString *)nibName withCellIdName:(NSString *)cellIdName
{
    
    [collectionView registerNib:[UINib nibWithNibName:nibName bundle:nil]
     forCellWithReuseIdentifier:cellIdName];
    
}


-(void)addTableViewCellWithTableView:(UITableView *)tableView withNibName:(NSString *)nibName withCellIdName:(NSString *)cellIdName
{
    
    
    [tableView registerNib:[UINib nibWithNibName:nibName bundle:nil] forCellReuseIdentifier:cellIdName];
    
}

-(void)shareAppWithText:(NSString *)textSharing andWithUrlSharing:(NSString *)urlSharing
{
    
    NSArray *activityItems = @[textSharing,[NSURL URLWithString:urlSharing]];
    
    UIActivityViewController *activityViewControntroller = [[UIActivityViewController alloc] initWithActivityItems:activityItems applicationActivities:nil];
    activityViewControntroller.excludedActivityTypes = @[];
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
        activityViewControntroller.popoverPresentationController.sourceView = self.view;
        activityViewControntroller.popoverPresentationController.sourceRect = CGRectMake(self.view.bounds.size.width/2, self.view.bounds.size.height/4, 0, 0);
    }
    
    [self presentViewController:activityViewControntroller animated:true completion:^{
    }];
    
}

-(void)SetTextFieldBorder :(UITextField *)textField withBorderColor:(UIColor *)borderColor {
    
    
    textField.layer.borderColor = textField.textColor.CGColor;
    
    
    
    [textField setValue:textField.textColor forKeyPath:@"_placeholderLabel.textColor"];
    
    [textField setValue:textField.font forKeyPath:@"_placeholderLabel.font"];
    
    
    textField.layer.borderWidth = 1.0;
    textField.layer.cornerRadius = 10.0;
    
    textField.layer.masksToBounds = YES;
    
    UIView *paddingView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, 20)];
    textField.leftView = paddingView;
    textField.leftViewMode = UITextFieldViewModeAlways;
   
    textField.delegate =self;
    
    //textField.font = FormTextSize;
    
    
    textField.textColor = FormTextColor;
    

}



-(void)SetTextFieldBorder :(UITextField *)textField{
    
    CALayer *border = [CALayer layer];
    CGFloat borderWidth = 2;
    border.borderColor = [UIColor grayColor].CGColor;
    border.frame = CGRectMake(0, textField.frame.size.height - borderWidth, textField.frame.size.width, textField.frame.size.height);
    border.borderWidth = borderWidth;
    [textField.layer addSublayer:border];
    textField.layer.masksToBounds = YES;
    
}

- (void)playerViewControllerDidStopPictureInPicture:(AVPlayerViewController *)playerViewController{
    [self hideLoader];
    

    NSLog(@"");
[playerViewController dismissViewControllerAnimated:YES completion:^{
    
}];
    

}

- (BOOL) isInternetConnectionAvailable
{
    Reachability *internet = [Reachability reachabilityWithHostName: @"www.google.com"];
    NetworkStatus netStatus = [internet currentReachabilityStatus];
    bool netConnection = false;
    switch (netStatus)
    {
        case NotReachable:
        {
            NSLog(@"Access Not Available");
            netConnection = false;
            break;
        }
        case ReachableViaWWAN:
        {
            netConnection = true;
            break;
        }
        case ReachableViaWiFi:
        {
            netConnection = true;
            break;
        }
    }
    return netConnection;
}

-(void)setWhenDidFilesWereDeletedLastTime{
    
    [self.userDefaults setObject:[DateFormatter showDate:[NSDate date] inStringFormate:@"dd-MM-yy"] forKey:@"WhenDidFilesWereDeletedLastTime"];
    
}


-(int)whenDidFilesWereDeletedLastTime{
    
    
    
    return 1;
    
}

-(void)EmptySandbox
{
    
    NSFileManager *fileMgr = [[NSFileManager alloc] init];
    NSError *error = nil;
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSArray *files = [fileMgr contentsOfDirectoryAtPath:documentsDirectory error:nil];
    
    while (files.count > 0) {
        NSString *documentsDirectory = [paths objectAtIndex:0];
        NSArray *directoryContents = [fileMgr contentsOfDirectoryAtPath:documentsDirectory error:&error];
        if (error == nil) {
            for (NSString *path in directoryContents) {
                NSString *fullPath = [documentsDirectory stringByAppendingPathComponent:path];
                BOOL removeSuccess = [fileMgr removeItemAtPath:fullPath error:&error];
                files = [fileMgr contentsOfDirectoryAtPath:documentsDirectory error:nil];
                if (!removeSuccess) {
                    // Error
                }
            }
        } else {
            // Error
        }
    }
}

-(NSString *)salt{
    
    return @"";
    
}

+(NSString *)giveServiceSalt{
    
    return @"";
    
}
-(NSUserDefaults *)userDefaults
{
    
    if (!_userDefaults) {
         _userDefaults = [NSUserDefaults standardUserDefaults];
    }
    return _userDefaults;
}


-(void)topImageViewTapped{
    
}


-(TitleHeading *)titleHeadingView
{
    if (!_titleHeadingView) {
        
        _titleHeadingView = (TitleHeading *)[self.view getViewFromNibName:@"TitleHeading" withWidth:146 withHeight:37];
        

        [_titleHeadingView setFrame:CGRectMake(10, 2, 137, 35)];
        [_titleHeadingView setTag:33];
        
        
        UILabel * currentLabel = [UILabel new];
 //       Candida Std

        
        
        
    }
    
    return _titleHeadingView;
    
}

-(UIFont *)segmentFont
{
    
    return [UIFont fontWithName:FontRegular size:16];
    
}
-(void)setMySegmentFont:(UISegmentedControl *)segment
{
    NSDictionary *attributes = [NSDictionary dictionaryWithObject:[self segmentFont]
                                                           forKey:NSFontAttributeName];
    [segment setTitleTextAttributes:attributes
                           forState:UIControlStateNormal];
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
   

    
    
    [self showAllFonts];
    


    if (self.showingTitleInCenter) {
        
        if(!_titleHeadingView)
        {
            _titleHeadingView = [self.navigationController.navigationBar viewWithTag:33];
            
        }
        _titleHeadingView.center = _titleHeadingView.superview.center;
        [_titleHeadingView setFrame:CGRectMake(_titleHeadingView.frame.origin.x, 2, _titleHeadingView.frame.size.width, _titleHeadingView.frame.size.height)];
        
    }
    

    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 50, 35)];
    
    [label sizeToFit];
    label.text = @"1";
    

    
    label.backgroundColor = DefaultRed;
    

    int currentCount =  [self.navigationController.viewControllers count];
    
    if (currentCount < 2)
    {
        [self.navigationController.navigationBar setTitleTextAttributes:
         @{NSForegroundColorAttributeName:[UIColor whiteColor],
           NSFontAttributeName:[UIFont fontWithName:FancyFont
                                               size:22]}];
        
        
        
        
        if (self.customTestColorForTitle)
        {
            [self.navigationController.navigationBar setTitleTextAttributes:
             @{NSForegroundColorAttributeName:[UIColor whiteColor],
               NSFontAttributeName:[UIFont fontWithName:FancyFont
                                                   size:22]}];
            
            
        }
        
        
    }
    

    
    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:nil action:nil];
    
    [self showAllFonts];
    
    

    

}



-(void)loginButtonTapped{
    
    [self performSegueWithIdentifier:@"segueLoginTapped" sender:self];
    
}
-(void)editProfileButtonTapped
{
    
    /*
    ProfileViewController * destination = [[ProfileViewController alloc] initWithNibName:@"ProfileViewController" bundle:nil];
    
    [self showViewController:destination sender:self];
    */
    
    
}

-(void) triggerAction:(NSNotification *) notification
{
    
    [self showAlert:@"" message:@"Error while uploading image"];
    
    
}




-(void)viewWillAppear:(BOOL)animated
{
    [self.titleHeadingView setHidden:NO];
    
    
    [super viewWillAppear:animated];
    
}



-(void)viewDidAppear:(BOOL)animated{
    
    
    
    
    [super viewDidAppear:animated];
 
 
}



-(void)topBarButtonTapped{
    
    NSLog(@"Top Bar Button Tapped");
    

    
    id currentSearch = [self viewControllerFromStoryBoard:@"Main" withViewControllerName:@"SelectCityViewController"];
    [self.navigationController pushViewController:currentSearch animated:YES];
}
-(void)btnLocationTapped{
    
    id currentSearch = [self viewControllerFromStoryBoard:@"Main" withViewControllerName:@"MapViewController"];
    
    
    if ([self isKindOfClass:[currentSearch class]]) {
        return;
    }
    
    [self.navigationController pushViewController:currentSearch animated:YES];
}







-(void)setMyMap{

    
    
}
-(UIStatusBarStyle)preferredStatusBarStyle{
    
    return UIStatusBarStyleDefault;
    
}

-(void)viewTouched
{
    //  [self slideBackToNormal];
    
    [self.view endEditing:YES];
    
    
}



-(void)restartLaoder{
    [self createNewLoader];
    
}
-(void)stopLoader{
    
    //[hud removeFromSuperview];
    
}

-(void)createNewLoaderForModal{
    
    id c = self.navigationController.view;
    
    if (!c) {
        c = self.view;
    }
  //  hud = [[MBProgressHUD alloc] initWithView:c];
    
    
   // [self.view addSubview:hud];
   // hud.labelText = @"Posting";
    
    //[hud show:YES];
    
}
- (void)createNewLoader{
    /*
    id c = self.navigationController.view;
    
    if (!c) {
        c = self.view;
    }
	hud = [[MBProgressHUD alloc] initWithView:c];
    
    
	[self.navigationController.view addSubview:hud];
	hud.labelText = @"Loading";
	
    [hud show:YES];
*/
    
}











-(void)showAlert:(NSString *)title message:(NSString *)currentMessage
{
    
    if ([currentMessage isKindOfClass:[NSArray class]]) {
        
        NSString * result = [[currentMessage valueForKey:@"id"] componentsJoinedByString:@","];
        currentMessage = result;
        
    }


    UIAlertController *myAlertController = [UIAlertController alertControllerWithTitle:title
                                                                               message: currentMessage
                                                                        preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction* ok = [UIAlertAction
                         actionWithTitle:@"OK"
                         style:UIAlertActionStyleDefault
                         handler:^(UIAlertAction * action)
                         {
                             [myAlertController dismissViewControllerAnimated:YES completion:nil];
                             
                         }];
    [myAlertController addAction: ok];
    [self presentViewController:myAlertController animated:YES completion:nil];
    
}

-(void)showAlert:(NSString *)title message:(NSString *)currentMessage customTag:(int)currentTag
{
        UIAlertView *ErrorAlert = [[UIAlertView alloc] initWithTitle:title
                                                             message:currentMessage
                                                            delegate:nil
                                                   cancelButtonTitle:@"OK"
                                                   otherButtonTitles:nil, nil];
        ErrorAlert.tag = currentTag;
        ErrorAlert.delegate = self;
        [ErrorAlert show];
  
    return;
   
}


-(BOOL) textFieldShouldReturn:(UITextField *)textField{
    
    [textField resignFirstResponder];
    return YES;
}

#pragma mark - SlideNavigationController Methods -

- (BOOL)slideNavigationControllerShouldDisplayLeftMenu
{
	return YES;
}

- (BOOL)slideNavigationControllerShouldDisplayRightMenu
{
	return NO;
}


-(void)settingTextDoneButtonWithTextBox:(UITextView *)textFeild withSelector:(SEL)selector
{
    UIToolbar* keyboardToolbar = [[UIToolbar alloc] init];
    [keyboardToolbar sizeToFit];
    UIBarButtonItem *flexBarButton = [[UIBarButtonItem alloc]
                                      initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace
                                      target:nil action:nil];
    UIBarButtonItem *doneBarButton = [[UIBarButtonItem alloc]
                                      initWithBarButtonSystemItem:UIBarButtonSystemItemDone
                                      target:self action:selector];
    keyboardToolbar.items = @[flexBarButton, doneBarButton];
    
    textFeild.inputAccessoryView = keyboardToolbar;
    
    //self.textFeild.inputAccessoryView = keyboardToolbar;
    
}
-(void)CallCreateNewChainView{
    UIViewController *desination = [self viewControllerFromStoryBoard:@"CreateVideo" withViewControllerName:@"SelectetChainTitleViewController"];
    
    
    [self.navigationController pushViewController:desination
                                         animated:YES];
    
}

-(void)closeButtonTapped
{
    
}
-(AppDelegate *)sharedDelegate{
    
    return (AppDelegate *)[[UIApplication sharedApplication] delegate];
    
}

-(NSString *)myCountryCode{
    
    NSUserDefaults *defaults;
    defaults = [NSUserDefaults standardUserDefaults];
    NSString *countryCode = [defaults objectForKey:@"phoneCode"];
    
    if (!countryCode) {
        return @"0";
        
    }
    return countryCode;
}

- (void)motionEnded:(UIEventSubtype)motion withEvent:(UIEvent *)event {
    
    if (motion == UIEventSubtypeMotionShake)
    {
        NSLog(@"Shaked");
        

    }
}


-(UIViewController *)viewControllerFromStoryBoard:(NSString *)storyboardName withViewControllerName:(NSString *)viewId{

 
    UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:storyboardName
                                                             bundle: nil];
    return (UIViewController *)[mainStoryboard
                                instantiateViewControllerWithIdentifier: viewId];

}

-(void)addBackGroundViewForTableView:(UITableView *)tableView withText:(NSString *)text{
    UIView *currentView = [UIView new];
    
    currentView.backgroundColor = [UIColor clearColor];
    
    [currentView setFrame:CGRectMake(tableView.frame.origin.x,
                                     tableView.frame.origin.y,
                                     tableView.frame.size.width,
                                     tableView.frame.size.height)];
    
    UILabel *messageLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 80, self.view.bounds.size.width, 30)];
    
    messageLabel.text = text;
    messageLabel.textColor = [UIColor blackColor];
    //messageLabel.numberOfLines = 0;
    messageLabel.textAlignment = NSTextAlignmentCenter;
    
    
    
    [currentView addSubview:messageLabel];
    
    
    tableView.backgroundView = currentView;
    
    if ([text length] == 0) {
               tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    }
    else
        tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    

}


+ (NSString *) makeMd5:(NSString *) input
{
    const char *cStr = [input UTF8String];
    unsigned char digest[16];
    CC_MD5( cStr, strlen(cStr), digest ); // This is the md5 call
    
    NSMutableString *output = [NSMutableString stringWithCapacity:CC_MD5_DIGEST_LENGTH * 2];
    
    for(int i = 0; i < CC_MD5_DIGEST_LENGTH; i++)
        [output appendFormat:@"%02x", digest[i]];
    
    return  output;
    
}


- (void)btnBackTapped {
    
    
    [self closeButtonTapped];
    
    
    [self.navigationController popViewControllerAnimated:YES];
    
}

-(int)groupId{
    

    if ([[self.userDefaults objectForKey:@"myProfileObject"] isKindOfClass:[NSArray class]]) {
        
        return [[[[self.userDefaults objectForKey:@"isFirstTimeSignUp"] firstObject] objectForKey:@"group_id"] intValue];
        
    }
    
    return [[[self.userDefaults objectForKey:@"myProfileObject"] objectForKey:@"group_id"] intValue];
    
}

-(NSString *)myJid{
    
    NSLog(@"%@",[self.userDefaults objectForKey:@"isFirstTimeSignUp"]);
    
    if ([[self.userDefaults objectForKey:@"isFirstTimeSignUp"] isKindOfClass:[NSArray class]]) {
        return [[[self.userDefaults objectForKey:@"isFirstTimeSignUp"] firstObject] objectForKey:@"id"];
    }
    return [[self.userDefaults objectForKey:@"isFirstTimeSignUp"] objectForKey:@"id"];
    
}

-(NSString *)myFullName{
    
    
    

    return [[self.myName stringByAppendingString:@" "] stringByAppendingString:self.myLastName];
    
}

-(NSString *)myName{
    
    

    if ([[self.userDefaults objectForKey:@"isFirstTimeSignUp"] isKindOfClass:[NSArray class]]) {
        return [[[self.userDefaults objectForKey:@"isFirstTimeSignUp"] firstObject] objectForKey:@"first_name"];
    }
    return [[self.userDefaults objectForKey:@"isFirstTimeSignUp"] objectForKey:@"first_name"];
    
}

-(NSString *)myLastName{
    
    
    NSLog(@"%@",[self.userDefaults objectForKey:@"isFirstTimeSignUp"]);
    
    if ([[self.userDefaults objectForKey:@"isFirstTimeSignUp"] isKindOfClass:[NSArray class]]) {
        return [[[self.userDefaults objectForKey:@"isFirstTimeSignUp"] firstObject] objectForKey:@"last_name"];
    }
    return [[self.userDefaults objectForKey:@"isFirstTimeSignUp"] objectForKey:@"last_name"];
    
}

-(NSString *)myEmail{
    
    
    if ([[self.userDefaults objectForKey:@"isFirstTimeSignUp"] isKindOfClass:[NSArray class]]) {
        return [[[self.userDefaults objectForKey:@"isFirstTimeSignUp"] firstObject] objectForKey:@"email"];
    }
    return [[self.userDefaults objectForKey:@"isFirstTimeSignUp"] objectForKey:@"email"];
    
}

-(NSString *)myPhoneNumber{
    
    
    if ([[self.userDefaults objectForKey:@"isFirstTimeSignUp"] isKindOfClass:[NSArray class]]) {
        return [[[self.userDefaults objectForKey:@"isFirstTimeSignUp"] firstObject] objectForKey:@"phone_number"];
    }
    return [[self.userDefaults objectForKey:@"isFirstTimeSignUp"] objectForKey:@"phone_number"];
    
}

-(NSString *)myGender{
    @try {
        
        
        
        if ([[self.userDefaults objectForKey:@"isFirstTimeSignUp"] isKindOfClass:[NSArray class]]) {
            return [[[self.userDefaults objectForKey:@"isFirstTimeSignUp"] firstObject] objectForKey:@"gender"];
        }
        return [[self.userDefaults objectForKey:@"isFirstTimeSignUp"] objectForKey:@"gender"];
        
        
    } @catch (NSException *exception) {
        
        return nil;
        
    }
    
}

-(NSString *)myDob{
    @try {
        
        
        
        if ([[self.userDefaults objectForKey:@"isFirstTimeSignUp"] isKindOfClass:[NSArray class]]) {
            return [[[self.userDefaults objectForKey:@"isFirstTimeSignUp"] firstObject] objectForKey:@"dob"];
        }
        return [[self.userDefaults objectForKey:@"isFirstTimeSignUp"] objectForKey:@"dob"];
        
        
    } @catch (NSException *exception) {
        
        return nil;
        
    }
    
}


-(NSString *)myRStatus{
    @try {
        
        
        id c = [self.userDefaults objectForKey:@"isFirstTimeSignUp"];
        
        if ([[self.userDefaults objectForKey:@"isFirstTimeSignUp"] isKindOfClass:[NSArray class]]) {
            return [[[self.userDefaults objectForKey:@"isFirstTimeSignUp"] firstObject] objectForKey:@"marital_status"];
        }
        return [[self.userDefaults objectForKey:@"isFirstTimeSignUp"] objectForKey:@"marital_status"];
        
        
    } @catch (NSException *exception) {
        
        return nil;
        
    }
    
}





-(NSString *)myProfileImageUrl{
    @try {



        if ([[self.userDefaults objectForKey:@"isFirstTimeSignUp"] isKindOfClass:[NSArray class]]) {
            return [[[self.userDefaults objectForKey:@"isFirstTimeSignUp"] firstObject] objectForKey:@"profile_image_url"];
        }
        return [[self.userDefaults objectForKey:@"isFirstTimeSignUp"] objectForKey:@"profile_image_url"];
    
        
    } @catch (NSException *exception) {
     
        return nil;
        
    }

}


-(NSDictionary *)completedAssetLink{
    
    return [self.userDefaults objectForKey:@"completedAssetLink"];;
    
}


-(void)connectionErrorDelegate{
    
    //[self.view makeToast:@"Unable to establish connection with the Server. Please check your internet connection and try again!"];
    
    
    for (UIView *allSubView in [self.view subviews])
    {
        if ([allSubView isKindOfClass:[UIActivityIndicatorView class]]) {
            
            UIActivityIndicatorView *tmp = allSubView;
            [tmp stopAnimating];
        
        }
        
    }
    
    [self stopLoader];
    
}



-(RestCall *)serviceCallObject{
    
    if (!_serviceCallObject) {
        _serviceCallObject = [RestCall new];
        _serviceCallObject.delegate =self;
    }
    return _serviceCallObject;
}


-(void)slideUp:(int)scale{
    CGRect viewFrame;
    viewFrame=self.view.frame;
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:.3];
    viewFrame.origin.y = -scale;
    self.view.frame=viewFrame;
    [UIView commitAnimations];
}

-(void)slideBackToNormal{
    CGRect viewFrame;
    viewFrame=self.view.frame;
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:.3];
    viewFrame.origin.y = 64;
    self.view.frame=viewFrame;
    [UIView commitAnimations];
}


-(void)makeCallToNumber:(NSString *)number{
    
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"tel://%@",number]]];
    
    
}


-(void)callNotificationWithTitle:(NSString *)title withInformation:(NSString *)info
{
    

}









#pragma mark AAShareBubbles


-(BOOL)checkForAnonymous{
    
    if ([[self myJid] isEqualToString:@"anonymous"]) {
        
        return NO;
    }
    else
        return YES;
    
    return NO;
    
}




-(UIDocumentInteractionController *) setupControllerWithURL: (NSURL*) fileURL usingDelegate: (id <UIDocumentInteractionControllerDelegate>) interactionDelegate {
    
    UIDocumentInteractionController *interactionController = [UIDocumentInteractionController
                                                              interactionControllerWithURL: fileURL];
    interactionController.delegate = interactionDelegate;
    return interactionController;
}



-(void)useMyCurrentLocationUpdated{
    
}






-(NSString *)myPhoneCode{
    
    return @"+1";
    
}


-(void)showLoader{
    

    @try {
        
        
        if (self.spinner) {
            
            [self.panel setHidden:NO];
            [self.view bringSubviewToFront:self.panel];
            
        }
        else {
            
            [self insertSpinnerOfStyle:RTSpinKitViewStylePlane backgroundColor:[UIColor colorWithRed:0 green:0 blue:0 alpha:0.5] label:@""];
            
            
            
        }
        
    } @catch (NSException *exception) {
        
        
    }
    
    
    
}

-(void)hideLoader{
    
    @try {
        
        [self.panel setHidden:YES];
        
        [self.view sendSubviewToBack:self.panel];
        
    } @catch (NSException *exception) {
        
    } @finally {
        
    }
    
}




-(BOOL)hasMadeAnyPurchased{
    //@"HasPurchasedTheItem"
    
    return YES;
    
    if ([self.userDefaults objectForKey:@"HasPurchasedTheItem"]) {
        
        return YES;
    }
    return NO;
    
}

-(void)insertSpinnerOfStyle:(RTSpinKitViewStyle)style
            backgroundColor:(UIColor*)backgroundColor
                      label:(NSString *)labelString
{
    CGRect screenBounds = [[UIScreen mainScreen] bounds];
    CGFloat screenWidth = CGRectGetWidth(screenBounds);
    
    self.spinner = [[RTSpinKitView alloc] initWithStyle:style color:[UIColor whiteColor]];
    
    self.spinner.center = CGPointMake(CGRectGetMidX(screenBounds), CGRectGetMidY(screenBounds));
    [self.spinner startAnimating];
    
    
    self.panel = [[UIView alloc] initWithFrame:CGRectOffset(self.view.bounds, 0.0, 0.0)];
    
    
    self.panel.backgroundColor = backgroundColor;
    
    [self.panel addSubview:self.spinner];
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 50.0, screenWidth, 30.0)];
    label.text = labelString;
    label.font = [UIFont systemFontOfSize:25.0];
    label.textColor = [UIColor whiteColor];
    
    self.spinnerLabel = label;
    
    if ([label respondsToSelector:@selector(tintColor)]) {
        label.textAlignment = NSTextAlignmentCenter;
    } else {
#pragma GCC diagnostic push
#pragma GCC diagnostic ignored "-Wdeprecated-declarations"
        label.textAlignment = UITextAlignmentCenter;
#pragma GCC diagnostic pop
        label.backgroundColor = [UIColor clearColor];
    }
    
    [self.panel addSubview:label];
    [self.view addSubview:self.panel];
    
    
}




-(void)addSearchToTableView:(UITableView *)tableView isHiddenIneditally:(BOOL)isHidden{
    
    self.searchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(0, 0, 320, 44)];
    self.searchBar.delegate = self;
    
    
    UISearchController *searchController = [[UISearchDisplayController alloc] initWithSearchBar:self.searchBar
                                                                             contentsController:self];
    
    searchController.delegate = self;
    
    if (!isHidden) {
        
        tableView.tableHeaderView = self.searchBar;
    }
}
-(BOOL)searchDisplayController:(UISearchDisplayController *)controller shouldReloadTableForSearchString:(NSString *)searchString{
    
    return YES;
}

-(void)searchBarCancelButtonClicked:(UISearchBar *)searchBar {
    
    self.isSearching = NO;
    
}
- (void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar {
    //isSearching = YES;
    
}



-(UIToolbar *)makeToolCarWithWithSelectorWith:(UIBarButtonItem *)barButtonDone
{
    
    UIToolbar *toolbar = [[UIToolbar alloc] init];
    [toolbar setBarStyle:UIBarStyleBlackTranslucent];
    [toolbar sizeToFit];
    
    UIBarButtonItem *buttonflexible = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    
    
    [toolbar setItems:[NSArray arrayWithObjects:buttonflexible,barButtonDone, nil]];
    _defaultFirstToolBar = toolbar;
    
    [toolbar sizeToFit];
    
    
    
    return toolbar;
    
}


- (void)btnPlayIntroVideoTapped:(NSString *)sender {
    
    NSString *introMediaUrl = sender;
    
    
    
    if(!introMediaUrl)
        return;
    
    NSURL *url;
        AVPlayer *player;
    if ([sender isKindOfClass:[AVURLAsset class]]) {
        //tmp
        
        AVURLAsset * tmp = sender;
        [tmp.URL path];
        url = [NSURL fileURLWithPath:[tmp.URL path]];
     
   
        player  = [AVPlayer playerWithURL:url];
        
    }
    else if ([sender contains:@"/var/mobile/"]){
        
        
        url = [NSURL fileURLWithPath:introMediaUrl];
        
        
        player  = [AVPlayer playerWithURL:url];
        
        
    }
    else{
        url=[[NSURL alloc] initWithString:introMediaUrl];
        player  = [AVPlayer playerWithURL:url];
        
    }


    
    _moviePlayer = [[AVPlayerViewController alloc] init];
    _moviePlayer.delegate = self;
    
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(videoDidFinish:)
                                                 name:AVPlayerItemDidPlayToEndTimeNotification
                                               object:[_moviePlayer.player currentItem]];
    
    
    _moviePlayer.showsPlaybackControls = YES;
    

    

    _moviePlayer.player = player;

    [self presentViewController:_moviePlayer animated:YES completion:nil];

    [player play];
    
}

- (void)videoDidFinish:(id)notification
{
    [self dismissViewControllerAnimated:YES completion:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    [self hideLoader];
    
    //fade out / remove subview
}



-(BOOL) validateStringContainsNumbersOnly:(NSString*)strng
{
    NSCharacterSet *s = [NSCharacterSet characterSetWithCharactersInString:@"+1234567890"];
    
    s = [s invertedSet];
    //And you can then use a string method to find if your string contains anything in the inverted set:
    
    NSRange r = [strng rangeOfCharacterFromSet:s];
    if (r.location != NSNotFound) {
        NSLog(@"the string contains illegal characters");
        return NO;
    }
    else
        return YES;
}

- (BOOL)isAlphanumeric:(NSString *)string
{
    NSString *regex = @"[A-Z]+";
    NSPredicate *test = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    BOOL result = [test evaluateWithObject:string];
    
    return result;
    
}

-(NSString*)stringByCleaningPhoneNumber: (NSString*) countryPrefix{
    
    NSString *clean = [countryPrefix stringByReplacingOccurrencesOfString:@" " withString:@""];
    clean = [clean stringByReplacingOccurrencesOfString:@"\u00a0" withString:@""];
    clean = [clean stringByReplacingOccurrencesOfString:@" " withString:@""];
    clean = [clean stringByReplacingOccurrencesOfString:@"-" withString:@""];
    clean = [clean stringByReplacingOccurrencesOfString:@"(" withString:@""];
    clean = [clean stringByReplacingOccurrencesOfString:@")" withString:@""];
    clean = [clean stringByReplacingOccurrencesOfString:@"." withString:@""];
    
    if(countryPrefix){
        NSString *totalPrefix = [NSString stringWithFormat:@"+%@", countryPrefix];
        if([clean hasPrefix:totalPrefix]){
            clean = [clean substringFromIndex:totalPrefix.length];
        }
    }
    return clean;
}

-(BOOL)hasPushTokenAlreadySet
{
    NSUserDefaults *defauls = [NSUserDefaults standardUserDefaults];
    
    //[defauls setObject:@"1" forKey:@"pushTokenHasBeenSaved"];
    
    if([defauls objectForKey:@"pushTokenHasBeenSaved"])
    {
        
        return true;
    }
    
    return false;
    
}
-(NSString *)converRawPhoneNumberToInternational:(NSString *)givenNumber currentCountryCode:(NSString *)countryCode
{
    NSString * currentString = [[givenNumber componentsSeparatedByCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] componentsJoinedByString:@""];
    
    @try {
        
        
        
        
        if ([currentString length] < 11) return currentString;
        
        if ([[currentString substringToIndex:1] isEqualToString:@"0"] || [[currentString substringToIndex:1] isEqualToString:@"+"])
        {
            
            if ([[currentString substringFromIndex:1] isEqualToString:@"0"]
                && [[currentString substringFromIndex:2] isEqualToString:@"0"])
            {
                
                NSLog(@"");
                
            }
            else if([[currentString substringToIndex:2] isEqualToString:@"00"])
            {
                currentString = [currentString stringByReplacingOccurrencesOfString:@"(" withString:@""];
                currentString =[currentString stringByReplacingOccurrencesOfString:@")" withString:@""];
                currentString = [currentString stringByReplacingOccurrencesOfString:@"-" withString:@""];
                
                NSString *tmp = [currentString substringFromIndex:2];
                
                tmp = [@"+" stringByAppendingString:tmp];
                currentString = tmp;
                
                NSLog(@"");
                
            }
            
            else if([[currentString substringToIndex:1] isEqualToString:@"+"])
            {
                //currentString = [currentString substringFromIndex:1];
                //currentString = [@"+" stringByAppendingString:currentString];
                
            }
            else{
                currentString = [currentString substringFromIndex:1];
                if ([countryCode contains:@"+"]) {
                    
                    countryCode =   [countryCode stringByReplacingOccurrencesOfString:@"+" withString:@""];
                }
                currentString = [[@"+" stringByAppendingString:countryCode]
                                 stringByAppendingString:currentString ];
                
            }
        }
        
        
        
        
        
        currentString = [self stringByCleaningPhoneNumber:currentString];
        
        
        return currentString;
        
    }
    
    @catch (NSException *exception) {
        
        return currentString;
        
    }
    
}



-(void)showImageFromHttpUrl:(NSString *)urlToShow{
    
    
    
}

-(void)callAlertViewControllerWithTitle:(NSString *)title withMessage:(NSString *)message withOkButtonTitle:(NSString *)okTitle withCancleTitle:(NSString *)cancleTitle withOKHandler:(void(^)(void))okHandler withCancelHandler:(void(^)(void))CancelHandler
{
    
    UIAlertController *myAlertController = [UIAlertController alertControllerWithTitle:title
                                                                               message:message
                                                                        preferredStyle:UIAlertControllerStyleAlert                   ];
    
    
    
    UIAlertAction* ok = [UIAlertAction
                         actionWithTitle:okTitle
                         style:UIAlertActionStyleDefault
                         handler:^(UIAlertAction * action)
                         {
                             
                             [myAlertController dismissViewControllerAnimated:YES completion:^{
                                 
                             }];
                             
                             okHandler();
                             
                         }];
    
    [myAlertController addAction: ok];
    
    if ([cancleTitle length] > 0) {

        UIAlertAction* cancelAction = [UIAlertAction
                                       actionWithTitle:cancleTitle
                                       style:UIAlertActionStyleDefault
                                       handler:^(UIAlertAction * action)
                                       {
                                           
                                           [myAlertController dismissViewControllerAnimated:YES completion:nil];
                                           
                                           
                                           CancelHandler();
                                           
                                       }];
        [myAlertController addAction: cancelAction];
    
        
    }
    
    //[myAlertController setBackgroundColor:[UIColor darkGrayColor]];

    
    //[[UIView appearanceWhenContainedIn:[UIAlertController class], nil] setBackgroundColor:[UIColor colorWithRed:0 green:0 blue:0 alpha:0.6]];

    
    //alertContentView.backgroundColor = UIColor.blackColor()

    
//myAlertController

    [self presentViewController:myAlertController animated:YES completion:^{
    
    }];
    
}

- (UIImage*)previewFromFileAtPath:(NSString*)path ratio:(CGFloat)ratio
{
    AVAsset *asset = [AVURLAsset assetWithURL:[NSURL fileURLWithPath:path]];
    AVAssetImageGenerator *imageGenerator = [[AVAssetImageGenerator alloc]initWithAsset:asset];
    CMTime duration = asset.duration;
    CGFloat durationInSeconds = duration.value / duration.timescale;
    CMTime time = CMTimeMakeWithSeconds(durationInSeconds * ratio, (int)duration.value);
    CGImageRef imageRef = [imageGenerator copyCGImageAtTime:time actualTime:NULL error:NULL];
    UIImage *thumbnail = [UIImage imageWithCGImage:imageRef];
    CGImageRelease(imageRef);
    
    return thumbnail;
}

-(void)setTouchMethodWithLabel:(UIView *)currentLabel withSelector:(SEL)selector
{
    UITapGestureRecognizer  * videoGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:selector];
    
    currentLabel.userInteractionEnabled = YES;
    [currentLabel addGestureRecognizer:videoGesture];
    
}


-(void)setPlaceHolderColorWithTextFieldWith:(UITextField *)textField
{
    
    
    [textField setValue:[UIColor colorWithRed:26.0/255.0 green:26.0/255.0 blue:26.0/255.0 alpha:0.5] forKeyPath:@"_placeholderLabel.textColor"];
    
}
-(void)setTextFieldFont:(UITextField *)textField
{
    [textField setFont:[UIFont fontWithName:FontRegular size:16]];
}

-(void)setupSignUPFormButtonsFont:(UIButton *)button
{
    [button.titleLabel setFont:[UIFont fontWithName:FontRegular size:17]];
    
}
-(void)changeMyRootViewWithStoryBoardName:(NSString *)storyBoardName withViewControllerName:(NSString *)viewControllerName{
    
    AppDelegate *appDelegate =  (AppDelegate *)[UIApplication sharedApplication].delegate;
    
    

    
    UIWindow *window = (UIWindow *)[[UIApplication sharedApplication].windows firstObject];
    
    [UIView transitionFromView:window.rootViewController.view
                        toView:self.view
                      duration:0.65f
                       options:UIViewAnimationOptionTransitionCrossDissolve // transition animation
                    completion:^(BOOL finished){

                        [[UIApplication sharedApplication].keyWindow
                         setRootViewController:[self
                                                viewControllerFromStoryBoard:storyBoardName
                                                withViewControllerName:viewControllerName]];
                        
                        
                    }];
    
   
 
    
    
    
}


-(BuyProductViewController *)buyProdutsView{
    
   return [self viewControllerFromStoryBoard:@"Main" withViewControllerName:@"BuyProductViewController"];
    
}


-(void)decreaseFontBySize:(int)size withButton:(UILabel *)label{
    
    label.font = [UIFont fontWithName:label.font.fontName size:label.font.pointSize-1];
    
}

-(UIImage*)imageWithImage: (UIImage*) sourceImage scaledToWidth: (float) i_width
{
    float oldWidth = sourceImage.size.width;
    float scaleFactor = i_width / oldWidth;
    
    float newHeight = sourceImage.size.height * scaleFactor;
    float newWidth = oldWidth * scaleFactor;
    
    UIGraphicsBeginImageContext(CGSizeMake(newWidth, newHeight));
    [sourceImage drawInRect:CGRectMake(0, 0, newWidth, newHeight)];
    
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}

-(UIImage*)imageWithHeightImage: (UIImage*) sourceImage scaledToWidth: (float) i_height
{
    float oldHeight = sourceImage.size.height;
    
    float scaleFactor = i_height / oldHeight;
    
    
    float newHeight = sourceImage.size.width * scaleFactor;
    
    float newWidth = oldHeight * scaleFactor;
    
    
    UIGraphicsBeginImageContext(CGSizeMake(newHeight, newWidth));
    [sourceImage drawInRect:CGRectMake(0, 0, newHeight, newWidth)];
    
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}


- (NSString *)MD5:(NSString *)forItem{
    
    const char * pointer = [forItem UTF8String];
    
    unsigned char md5Buffer[CC_MD5_DIGEST_LENGTH];
    
    CC_MD5(pointer, (CC_LONG)strlen(pointer), md5Buffer);
    
    NSMutableString *string = [NSMutableString stringWithCapacity:CC_MD5_DIGEST_LENGTH * 2];
    for (int i = 0; i < CC_MD5_DIGEST_LENGTH; i++)
        [string appendFormat:@"%02x",md5Buffer[i]];
    
    return string;
}


-(UIImage*)imageWithImageWithCheck: (UIImage*) sourceImage scaledToWidth: (float) i_width frameHeight:(float)frameHeight
{
    float oldWidth = sourceImage.size.width;
    float scaleFactor = i_width / oldWidth;
    
    float newHeight = sourceImage.size.height * scaleFactor;
    float newWidth = oldWidth * scaleFactor;
    
    UIGraphicsBeginImageContext(CGSizeMake(newWidth, newHeight));
    [sourceImage drawInRect:CGRectMake(0, 0, newWidth, newHeight)];
    
    
    if (newHeight > frameHeight) {
        
        int newOne = i_width;
        newOne = newOne - 20;
        frameHeight = frameHeight-10;
        return [self imageWithImageWithCheck:sourceImage scaledToWidth:newOne frameHeight:frameHeight];
        
    }
    
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}




-(UIImage*)imageWithImageHeight: (UIImage*) sourceImage scaledToWidth: (float) height
{
    float oldWidth = sourceImage.size.height;
    float scaleFactor = height / oldWidth;
    
    float newHeight = sourceImage.size.width * scaleFactor;
    float newWidth = oldWidth * scaleFactor;
    
    UIGraphicsBeginImageContext(CGSizeMake(newHeight, newWidth));
    [sourceImage drawInRect:CGRectMake(0, 0, newHeight, newWidth)];
    
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}



-(int)sizeWithImage: (UIImage*) sourceImage scaledToWidth: (float) i_width
{
    float oldWidth = sourceImage.size.width;
    float scaleFactor = i_width / oldWidth;
    
    float newHeight = sourceImage.size.height * scaleFactor;

    return newHeight;
}




-(NSString *)authToken{
    
    NSUserDefaults * myDefault =  [NSUserDefaults standardUserDefaults];
    id c =  [myDefault objectForKey:@"isFirstTimeSignUp"];
    
    if ([c isKindOfClass:[NSDictionary class]]) {
        
        return [c objectForKey:@"authtoken"];
        
    }
    return @"";
}

-(void)showErrorMessage{
    
    [self showAlert:@"" message:@"Error while loading data"];
    
    
}

- (void)styleWithButton:(UIButton *)currentButton{
    
    currentButton.layer.cornerRadius = 25;
    if (IS_IPHONE_5) {
        currentButton.layer.cornerRadius = 20;
        
    }
    currentButton.layer.borderColor = DefaultRed.CGColor;
    currentButton.layer.borderWidth = 1.0;
}

- (void)unlerLineTheLabelWithText:(NSString *)text
                        withLabel:(UILabel *)label
{
    [label setAttributedText: [[NSAttributedString alloc] initWithString:text
                                                              attributes:@{NSUnderlineStyleAttributeName:@(NSUnderlineStyleThick),
                                                                           NSUnderlineColorAttributeName:DefaultRed}]];
    
}




- (NSDictionary *)getChapterDataWithChapterNo:(int)chapterNo {
    NSString *path = [[NSBundle mainBundle] pathForResource: @"QuestionsPlist" ofType: @"plist"];
    NSDictionary *dict = [NSDictionary dictionaryWithContentsOfFile: path];
    NSString * chapterString =  [NSString stringWithFormat:@"Chapter %d",chapterNo];
    NSDictionary * tmpDic = [dict objectForKey:chapterString];
    return tmpDic;
}
-(void)setUpButtubleView{
    
    if (IS_IPHONE_6P) {
        
        self.buttonTopSpace.constant = -150;
        self.bubbleLEadingSpace.constant = -60;
        
        
    }
    else
        if (IS_IPHONE_5) {
            
            
            self.buttonTopSpace.constant = -190;
            self.bubbleLEadingSpace.constant = -120;
            
        }
        else
            if (IS_IPHONE_6) {
                
                self.buttonTopSpace.constant = -180;
                self.bubbleLEadingSpace.constant = -80;
            }
    
}

- (void)makeButtonRounded:(UIButton *)btnFeedback
{

    btnFeedback.layer.cornerRadius  = 20;

    
}

- (void)makeViewRounded:(UIView *)view
{
    
    view.layer.cornerRadius  = 25;
    view.layer.borderWidth = 1.0;
    view.layer.borderColor = [UIColor colorWithRed:194.0/255.0 green:196.0/255.0 blue:202.0/255.0 alpha:1.0].CGColor;
    
    
}

-(void)showAllFonts{
    
    NSArray *familyNames = [[NSArray alloc] initWithArray:[UIFont familyNames]];
    NSArray *fontNames;
    NSInteger indFamily, indFont;
    for (indFamily=0; indFamily<[familyNames count]; ++indFamily)
    {
        NSLog(@"Family name: %@", [familyNames objectAtIndex:indFamily]);
        fontNames = [[NSArray alloc] initWithArray:
                     [UIFont fontNamesForFamilyName:
                      [familyNames objectAtIndex:indFamily]]];
        for (indFont=0; indFont<[fontNames count]; ++indFont)
        {
            NSLog(@"    Font name: %@", [fontNames objectAtIndex:indFont]);
        }
    }
    
    NSLog(@"");
    
    
}

-(NSString *)giveNewStyledHTML:(UIWebView *)currentWebView withHtml:(NSString *)html
{
    
    
    
    NSString *finalHTML = [NSString stringWithFormat:@"<html> \n"
                           "<head> \n"
                           "<style type=\"text/css\"> \n"
                           "body {font-family: \"%@\"; font-size: %@;padding: 20px 20px 10px 20px;color:#425A76}"
                           "</style> "
                           "</head> "
                           "<body>%@</body>"
                           "</html>", FontRegular, [NSNumber numberWithInt:15.0],html];
    
    [currentWebView loadHTMLString:finalHTML baseURL:nil];
    
    
    return @"";
    
}

-(void)makeWebViewRounded:(UIWebView *)webView
{
    webView.layer.cornerRadius = 5;
    webView.clipsToBounds = YES;
    
}





-(NSMutableDictionary *)categoriesIds
{
    if (!_categoriesIds) {
        
        _categoriesIds = [NSMutableDictionary new];
    }
    return _categoriesIds;
    
}


-(void)showExternalUrl:(NSString *)externalUrl
{
    //externalUrl
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:externalUrl]];
    
}
-(void)changeTheViewRootControlletWithStoryBoardName:(NSString *)storyname withRootName:(NSString *)rootViewName
{
    UIStoryboard *storyBoard = [UIStoryboard storyboardWithName:storyname bundle:nil];
    UIViewController *initViewController;
    initViewController = [storyBoard instantiateViewControllerWithIdentifier:rootViewName];
    //self.window.rootViewController = initViewController;
    AppDelegate * sharedDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    sharedDelegate.window.rootViewController = initViewController;
    
    
    
}



-(NSMutableArray*)currentCategories{
    
    if (!_currentCategories) {
        
        _currentCategories = [NSMutableArray new];
        
    }
    return _currentCategories;
    
}

-(CustomAddToListView *)customAddView
{
    
    if (!_customAddView) {
        
        
        
        _customAddView = (CustomAddToListView *)[self.view addSubViewWithContainerView:self.view
                                                                       andEnteringView:_customAddView
                                                                           withNibName:@"CustomAddToListView"];
        
        [_customAddView setFrame:self.view.frame];
        
        [_customAddView.btnClose addTarget:self action:@selector(closeCustomAddTapped) forControlEvents:UIControlEventTouchUpInside];
        
        _customAddView.delegate =self;
        
        
        int i = 0;
        
        for (id currentItem in self.currentCategories)
        {
            
            
            UILabel * currentButton = [UILabel new];
            
            [currentButton setFrame:CGRectMake(0,i*40, 200, 35)];
            [currentButton setTextColor:_customAddView.lblSaveTitle.textColor];
            currentButton.text = currentItem;
            //currentButton.font = _customAddView.lblSaveTitle.font;
            [currentButton setFont:[UIFont fontWithName:FontRegular size:15]];
            currentButton.userInteractionEnabled = YES;
            currentButton.tag = i;
            
            
            [self setTouchMethodWithLabel:currentButton withSelector:@selector(wishListTapped:)];
            
            [_customAddView.itemsSroll addSubview:currentButton];
            
            i++;
            
        }
        
        
        
        UILabel * newButton = [UILabel new];
        
        [newButton setFrame:CGRectMake(0,i*40, 200, 35)];
        [newButton setTextColor:DefaultRed];
        newButton.text = @"New Giftlist";
        [newButton setFont:[UIFont fontWithName:FontRegular size:15]];
        newButton.userInteractionEnabled = YES;
        [self setTouchMethodWithLabel:newButton withSelector:@selector(addNewGiftListItemTapped)];
        
        [_customAddView.itemsSroll addSubview:newButton];
        
        
        i++;
        i++;
        
        
        [self.customAddView.itemsSroll setContentSize:CGSizeMake(self.customAddView.itemsSroll.frame.size.width, i*40)];
        
        
        UIView * currentLine = [UIView new];
        
        [currentLine setBackgroundColor:[UIColor colorWithRed:194.0/255.0 green:196.0/255.0 blue:202.0/255.0 alpha:1.0]];
        [currentLine setFrame:CGRectMake(-40, i*40+8, _customAddView.frame.size.width, 1)];
        currentLine.clipsToBounds = NO;
        
        //[_customAddView addSubview:currentLine];
        
    }
    return _customAddView;
    
}


-(void)purchaseItem:(NSString *)identifier
{
    
    [self showLoader];
    
    
    if(![IAPShare sharedHelper].iap) {
        //com.hashtaggospel
        //unlock123
        NSSet* dataSet = [[NSSet alloc] initWithObjects:identifier, nil];
        
        [IAPShare sharedHelper].iap = [[IAPHelper alloc] initWithProductIdentifiers:dataSet];
    }
    
    [IAPShare sharedHelper].iap.production = NO;
    
    
    [[IAPShare sharedHelper].iap requestProductsWithCompletion:^(SKProductsRequest* request,SKProductsResponse* response)
     {
         if(response > 0 ) {
             SKProduct* product =[[IAPShare sharedHelper].iap.products objectAtIndex:0];
             
             NSLog(@"Price: %@",[[IAPShare sharedHelper].iap getLocalePrice:product]);
             NSLog(@"Title: %@",product.localizedTitle);
             
             [[IAPShare sharedHelper].iap buyProduct:product
                                        onCompletion:^(SKPaymentTransaction* trans){
                                            
                                            if(trans.error)
                                            {
                                                
                                                NSLog(@"Fail %@",[trans.error localizedDescription]);
                                                
                                            }
                                            else if(trans.transactionState == SKPaymentTransactionStatePurchased) {
                                                
                                                [[IAPShare sharedHelper].iap checkReceipt:[NSData dataWithContentsOfURL:[[NSBundle mainBundle] appStoreReceiptURL]] AndSharedSecret:@"your sharesecret" onCompletion:^(NSString *response, NSError *error) {
                                                    
                                                    //Convert JSON String to NSDictionary
                                                    NSDictionary* rec = [IAPShare toJSON:response];
                                                    
                                                    if([rec[@"status"] integerValue]==0)
                                                    {
                                                        
                                                        [[IAPShare sharedHelper].iap provideContentWithTransaction:trans];
                                                        NSLog(@"SUCCESS %@",response);
                                                        NSLog(@"Pruchases %@",[IAPShare sharedHelper].iap.purchasedProducts);
                                                        
                                                        
                                                        
                                                        [self hideLoader];
                                                        
                                                        [self dismissViewControllerAnimated:YES completion:^{
                                                           
                                                            /*
                                                            if (self.chapterView) {
                                                                [self.chapterView showChapterWitId:self.chapterNo];
                                                                
                                                                
                                                            }
                                                            else if(self.groupChaptersView){
                                                                
                                                                [self.groupChaptersView showChapterWitId:self.chapterNo];
                                                                
                                                                
                                                            }
                                                            */
                                                            
                                                        }];
                                                        
                                                        
                                                        
                                                    }
                                                    else {
                                                        NSLog(@"Fail");
                                                    }
                                                }];
                                            }
                                            else if(trans.transactionState == SKPaymentTransactionStateFailed) {
                                                NSLog(@"Fail");
                                            }
                                        }];//end of buy product
         }
     }];
    
}


-(void)restoreItem:(NSString *)identifier
{
    
    [self showLoader];
    
    if(![IAPShare sharedHelper].iap) {
        //com.hashtaggospel
        //unlock123
        NSSet* dataSet = [[NSSet alloc] initWithObjects:identifier, nil];
        
        [IAPShare sharedHelper].iap = [[IAPHelper alloc] initWithProductIdentifiers:dataSet];
    }
    
    [[IAPShare sharedHelper].iap restoreProductsWithCompletion:^(SKPaymentQueue *payment, NSError *error) {
        
        //check with SKPaymentQueue
        
        // number of restore count
        int numberOfTransactions = payment.transactions.count;
        for (SKPaymentTransaction *transaction in payment.transactions)
        {
            NSString *purchased = transaction.payment.productIdentifier;
            if([purchased isEqualToString:identifier])
            {
                [self.userDefaults setValue:@"1" forKey:@"HasPurchasedTheItem"];
                
                [self hideLoader];
                
                [self dismissViewControllerAnimated:YES completion:^{
                    

                    
                }];
                
                
                
                
            }
        }
        
    }];
    
}

@end
