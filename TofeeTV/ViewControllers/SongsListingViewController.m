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

@interface SongsListingViewController ()<VideoPlayerViewControllerDelegate,UICollectionViewDelegate,UICollectionViewDataSource>

@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;

@property (nonatomic,strong) NSArray <Song *>* dataSource;

@property (nonatomic,strong) NSArray * items;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *heightOfAdd;

@property (weak, nonatomic) IBOutlet GADBannerView *bannerView;


@end

@implementation SongsListingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"Songs";
    
    self.items = @[@"Profile", @"Remove Ads", @"Logout"];
    
    [self makeDropDownSelectionWithItemsArray:self.items withCustomView:nil];
    
    self.collectionView.dataSource = self;
    self.collectionView.delegate = self;
    
    [self addCollectionViewCellWithCollectionView:self.collectionView withNibName:@"SongsCollectionViewCell" withCellIdName:@"cellSongs"];
    
    
    [self showLoader];
    
    [self loadData];
    [self inititateTheAudioFile:@"App background loop" withFileType:@"wav" withOneTimePlay:NO];
    
    
    /*
    self.bannerView.adUnitID = @"ca-app-pub-1949777708516294/4870272595";
    self.bannerView.rootViewController = self;
    
    self.request = [GADRequest request];
    self.request.testDevices = @[ @"f2d702823400817844a80703be06886b" ,@"4f2b62a930ebbb22ac092b428fb74a67",@"4fb9829edac4b523686799880a3fea36",@"35cbf4628e8467f7c7bbb209f6a9b681",kGADSimulatorID];
    self.bannerView.delegate = self;
    
    [self.bannerView loadRequest:self.request];

    */
    
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
        [self.collectionView reloadData];
        
    } withFailueHandler:^(id  _Nonnull error) {
        [self hideLoader];
        
    }];
}
-(void)viewDidAppear:(BOOL)animated
{
    
    [super viewDidAppear:animated];
    
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    
    
    
    
    /*
    ThankYouViewController * destination  = [[ThankYouViewController alloc] initWithNibName:@"ThankYouViewController" bundle:nil];
    [self.navigationController showViewController:destination sender:nil];
    */
    
    
    
}


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
    
    ///[self.navigationController showViewController:destination sender:self];
    
    
}

-(void)quizTapped:(id)itemTapped
{
 
    
    QuestionViewController * destination = [[QuestionViewController alloc] initWithNibName:@"QuestionViewController" bundle:nil];
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
        destination.objectComing = self.dataSource[self.collectionView.indexPathsForSelectedItems[0].row];
        
        
    }

}


/// Tells the delegate an ad request loaded an ad.
- (void)adViewDidReceiveAd:(GADBannerView *)adView {
    NSLog(@"adViewDidReceiveAd");
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
    
    NSLog(@"adViewWillLeaveApplication");
}

@end
