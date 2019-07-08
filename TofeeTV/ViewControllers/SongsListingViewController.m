//
//  SongsListingViewController.m
//  TofeeTV
//
//  Created by Tauqeer Ahmed on 06/02/2019.
//  Copyright © 2019 Tauqeer. All rights reserved.
//

#import "SongsListingViewController.h"
#import "SongsCollectionViewCell.h"
#import "Song.h"
#import "VideoPlayerViewController.h"
#import "QuestionViewController.h"
#import "SelectSongOrGameViewController.h"
#import "ThankYouViewController.h"
#import "ProfileViewController.h"
#import <AdSupport/ASIdentifierManager.h>
#import "SongListingTableViewCell.h"

@interface SongsListingViewController ()<VideoPlayerViewControllerDelegate,UICollectionViewDelegate,UICollectionViewDataSource,GADBannerViewDelegate,UITableViewDelegate,UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;

@property (nonatomic,strong) NSArray <Song *>* dataSource;

@property (nonatomic,strong) NSArray * items;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *heightOfAdd;

@property (weak, nonatomic) IBOutlet GADBannerView *bannerView;
@property (weak, nonatomic) IBOutlet UITableView *tableView;


@end

@implementation SongsListingViewController



- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"Songs";
    self.items = @[@"Profile", @"Remove Ads",@"About Us",@"Contact Us", @"Logout"];
    [self makeDropDownSelectionWithItemsArray:self.items withCustomView:nil];
    [self addTableViewCellWithTableView:self.tableView withNibName:@"SongHeadingViewTableViewCell" withCellIdName:@"cellHeader"];
    
    [self addTableViewCellWithTableView:self.tableView withNibName:@"SongListingTableViewCell" withCellIdName:@"cellSongListing"];
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    self.tableView.backgroundColor = [UIColor colorWithRed:1.0 green:0.0 blue:222.0/255.0 alpha:1.0];
    
    [self showLoader];
    
    [self loadData];
    [self inititateTheAudioFile:@"App background loop" withFileType:@"wav" withOneTimePlay:NO];
    
    
    NSLog(@"%@",[[ASIdentifierManager sharedManager] advertisingIdentifier]);
    //ASIdentifierManager *manager = [ASIdentifierManagerClass sharedManager];
    
    self.request = [GADRequest request];
    self.request.testDevices = @[ @"931CA2DA0AF0484680E367B30FB570B0",kGADSimulatorID];
    self.bannerView.adUnitID = @"ca-app-pub-2522914220379856/3130957071";
    self.bannerView.rootViewController = self;
    

    self.bannerView.delegate = self;
    
    [self.bannerView loadRequest:self.request];
    self.heightOfAdd.constant = 50;


    [self launcherThings];
    
}

-(void)viewDidLayoutSubviews{
    
    [self.collectionView reloadData];
    
}
-(void)itemSelectedWithItesPath:(int)index
{

    if(index == 0 )
    {
        //show profile
        
        ProfileViewController * destination = [[ProfileViewController alloc] initWithNibName:@"ProfileViewController" bundle:nil];
        
        [self.navigationController pushViewController:destination animated:YES];
        
    }
    else if (index == 1)
    {
        //remove ads
    }
    else if(index == 2)
    {
        //About US
    }
    else if(index == 3)
    {
        //Contact Us
        
    }
    else  {
        
        
        NSUserDefaults *currentUserDefault = [NSUserDefaults standardUserDefaults];
        [currentUserDefault setObject:nil forKey:@"access_token"];
        [currentUserDefault setObject:nil forKey:@"isFirstTimeSignUp"];
        
        //[defauls setObject:nil forKey:@""];
        
        [self changeTheViewRootControlletWithStoryBoardName:@"SignUp" withRootName:@"SignUpRoot"];

        
        //logout
    }
    
}


-(void)loadData
{
 
    [Song callGiveMeSongsListWithComiltionHandler:^(id  _Nonnull result) {
        
        
        [self hideLoader];
        
        self.dataSource = result;
        
        [self.tableView reloadData];
        
    } withFailueHandler:^(id  _Nonnull error) {
        [self hideLoader];
        
        [self callAlertViewControllerWithTitle:@"" withMessage:@"Error while loading data" withOkButtonTitle:@"OK" withCancleTitle:@"" withOKHandler:^{
            
            [self loadData];
            
        } withCancelHandler:^{
            
        }];
        
    }];
}
-(void)viewDidAppear:(BOOL)animated
{
    
    [super viewDidAppear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
}

/*/
-(NSInteger)collectionView:(UICollectionView *)collectionView
    numberOfItemsInSection:(NSInteger)section{
    
    return [self.dataSource count];
    
}

- (CGSize)collectionView:(UICollectionView *)collectionView
                  layout:(UICollectionViewLayout*)collectionViewLayout
  sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    return CGSizeMake([[UIScreen mainScreen ] bounds].size.width/2, [[UIScreen mainScreen ] bounds].size.width/2);
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView
                  cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    SongsCollectionViewCell *currentCell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cellSongs" forIndexPath:indexPath];
    currentCell.backgroundColor = DefaultPink2;
    
    
    currentCell.lblTitle.text = self.dataSource[indexPath.row].name;
    currentCell.contentView.layer.borderWidth = 2.0;
    currentCell.contentView.layer.borderColor = [UIColor whiteColor].CGColor;
    
    [currentCell.lockedImage setHidden:!self.dataSource[indexPath.row].canISeeThis];
    
    [FileManager
     loadImageFromurl:self.dataSource[indexPath.row].thumbNailUrl
     withComplitionHandler:^(id result) {
        [currentCell.imageShowing setImage:result];
    } withFailHander:^(int item) {
    }];
   
    return currentCell;
}


- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    [self performSegueWithIdentifier:@"showOptions" sender:self];
    
    return;
 
    Song * currentItem = self.dataSource[indexPath.row];
    
    if (!currentItem.fileOwned) {
        
        
        [self showLoader];
        
    
        [Song
         callUnlockWithScoreWithId:currentItem.itemId withComplition:^(id  _Nonnull result) {
             VideoPlayerViewController * destination = [[VideoPlayerViewController alloc] initWithNibName:@"VideoPlayerViewController" bundle:nil];
             
             AppDelegate * currentApp = (AppDelegate *)[[UIApplication sharedApplication] delegate];
             currentApp.currentSelectedItem = self.dataSource[indexPath.row];
             destination.currentSong = self.dataSource[indexPath.row];
             destination.delegate = self;
             [self presentViewController:destination animated:YES completion:^{
             }];
             [self loadData];
             
             
             
             
        } withFailueHandler:^(id  _Nonnull error) {
        
            [self hideLoader];
            
            [self showAlert:@"" message:@"Unable to unlock the song"];
            
        }];
        
        

        return;
    }
    AppDelegate * currentOne  = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    currentOne.shouldAutoRotate = YES;
    
    
    
    VideoPlayerViewController * destination = [[VideoPlayerViewController alloc] initWithNibName:@"VideoPlayerViewController" bundle:nil];
    
    AppDelegate * currentApp = [[UIApplication sharedApplication] delegate];
    currentApp.currentSelectedItem = self.dataSource[indexPath.row];
    destination.currentSong = self.dataSource[indexPath.row];
    destination.delegate = self;
    
    
    [self presentViewController:destination animated:YES completion:^{
        
    }];
    
    
    
}
*/
-(void)quizTapped:(id)itemTapped
{
 
    
    QuestionViewController * destination = [[QuestionViewController alloc] initWithNibName:self.questionViewControllerName
                                                                                    bundle:nil];
    destination.questionIndex = 0;
    destination.selectedSong = itemTapped;
    
    
    [self.navigationController showViewController:destination sender:nil];
}



// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.

    if ([segue.identifier isEqualToString:@"showOptions"])
    {
        SelectSongOrGameViewController * destination = segue.destinationViewController;
        destination.objectComing = self.dataSource[self.tableView.indexPathForSelectedRow.row - 1];
        if ([self.dataSource count] == self.tableView.indexPathForSelectedRow.row)
        {
        
            NSLog(@"Last One");
        }
        else {
            destination.nextSongLink = self.dataSource[self.tableView.indexPathForSelectedRow.row].videoUrl;
        }
        
    }

}


/// Tells the delegate an ad request loaded an ad.
- (void)adViewDidReceiveAd:(GADBannerView *)adView {
    NSLog(@"adViewDidReceiveAd");
    [self.bannerView setHidden:NO];
    
    
}

/// Tells the delegate an ad request failed.
- (void)adView:(GADBannerView *)adView
didFailToReceiveAdWithError:(GADRequestError *)error {
    NSLog(@"adView:didFailToReceiveAdWithError: %@", [error localizedDescription]);
}

/// Tells the delegate that a full-screen view will be presented in response
/// to the user clicking on an ad.
- (void)adViewWillPresentScreen:(GADBannerView *)adView {
    NSLog(@"adViewWillPresentScreen");
}

/// Tells the delegate that the full-screen view will be dismissed.
- (void)adViewWillDismissScreen:(GADBannerView *)adView {
    NSLog(@"adViewWillDismissScreen");
}

/// Tells the delegate that the full-screen view has been dismissed.
- (void)adViewDidDismissScreen:(GADBannerView *)adView {
    NSLog(@"adViewDidDismissScreen");
}

/// Tells the delegate that a user click will open another app (such as
/// the App Store), backgrounding the current app.
- (void)adViewWillLeaveApplication:(GADBannerView *)adView {
    //
    NSLog(@"adViewWillLeaveApplication");
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{

    if (indexPath.row > 0)
    {
        
        SongListingTableViewCell * tmpCell = [tableView dequeueReusableCellWithIdentifier:@"cellSongListing"];
        tmpCell.lblName.text = self.dataSource[indexPath.row-1].name;
        [tmpCell setSelectionStyle:UITableViewCellSelectionStyleNone];
        
        
        if (IS_IPad)
        {
            tmpCell.lblName.font = [UIFont fontWithName:tmpCell.lblName.font.fontName size:45];
        }

        if (indexPath.row % 2 == 0) {
       
            tmpCell.backgroundColor = [UIColor colorWithRed:198.0/255.0
                                                  green:0.0 blue:1.0 alpha:1.0];
            
        }
        else
        {
            tmpCell.backgroundColor = [UIColor colorWithRed:1.0 green:0.0 blue:222.0/255.0 alpha:1.0];
        }
        return tmpCell;
    }
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellHeader" forIndexPath:indexPath];
    
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    
    return cell;
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{

    if (indexPath.row == 0) {
        return [[UIScreen mainScreen] bounds].size.height/6;
    }
    
    return [[UIScreen mainScreen] bounds].size.height/12;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataSource.count + 1;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    //[self buttonBlip];
    [self performSegueWithIdentifier:@"showOptions" sender:self];
    
}

@end
