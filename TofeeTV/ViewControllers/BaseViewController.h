//
//
//

#import <UIKit/UIKit.h>
#import <AddressBook/AddressBook.h>
#import "AppDelegate.h"
#import "Config.h"
#import "RestCall.h"
#import "Validator.h"
#import "NSString+JS.h"
#import <CommonCrypto/CommonDigest.h>
#import "FileManager.h"
#import "NSDate+Utilities.h"
#import "NSString+HTML.h"
#import "Reachability.h"
#import "UIView+Toast.h"
#import "UITextField+MyTextField.h"
#import "User.h"
#import "RTSpinKitView.h"
#import "TitleViewLogin.h"
#import "TitleHeading.h"
#import "TextViewForSignUpform.h"
#import "IAPHelper.h"
#import "IAPShare.h"
#import "PFNavigationDropdownMenu.h"
#import "AudioController.h"

@import GoogleMobileAds;
@import AVKit;
@class AVAssetExportSession;

@class AppDelegate;
@class AVMutableVideoComposition;
@class BuyProductViewController;

@class CustomAddToListView;

@interface BaseViewController : UIViewController<UITextFieldDelegate,RestCallDelegates,UITextViewDelegate>
{

    float radius;
    float bubbleRadius;
}
-(void)addCollectionViewCellWithCollectionView:(UICollectionView *)collectionView withNibName:(NSString *)nibName withCellIdName:(NSString *)cellIdName;

-(void)setPlaceHolderColorWithTextFieldWith:(UITextField *)textField;

-(void)viewTouched;
@property (nonatomic,strong) UIImage *overLayImageUsing;
-(void)topImageViewTapped;
@property (nonatomic,strong) NSURL *videoUrlUploading;
@property (weak, nonatomic) IBOutlet UIView *viewTitleContainer;
-(void)showAlert:(NSString *)title message:(NSString *)currentMessage;
-(void)showAlert:(NSString *)title message:(NSString *)currentMessage customTag:(int)currentTag;
-(void)makeDropDownSelectionWithItemsArray:(NSArray *)items withCustomView:(UIView *)custom;

- (NSString *)MD5:(NSString *)forItem;
-(void)setTextFieldFont:(UITextField *)textField;
-(void)setupSignUPFormButtonsFont:(UIButton *)button;

-(void)stopLoader;
-(void)restartLaoder;
-(void)createNewLoaderForModal;
-(void)CallCreateNewChainView;

-(void)setMySegmentFont:(UISegmentedControl *)segment;
-(AppDelegate *)sharedDelegate;

@property (nonatomic, retain) NSManagedObjectContext *managedObjectContext;
@property (nonatomic,strong) NSUserDefaults *userDefaults;

@property (nonatomic, strong) UIRefreshControl *refreshControl;

@property (nonatomic) NSString *salt;

-(UIImage*)imageWithImageHeight: (UIImage*) sourceImage scaledToWidth: (float) height;

-(UIImage*)imageWithImageWithCheck: (UIImage*) sourceImage scaledToWidth: (float) i_width frameHeight:(float)frameHeight;
-(UIFont *)segmentFont;

-(void)addTableViewCellWithTableView:(UITableView *)tableView withNibName:(NSString *)nibName withCellIdName:(NSString *)cellIdName;




-(NSString *)myJid;

-(NSString *)myCountryCode;

- (void)makeViewRounded:(UIView *)view;

+(NSString *)giveServiceSalt;
+ (NSString *) makeMd5:(NSString *) input;

-(UIViewController *)viewControllerFromStoryBoard:(NSString *)storyboardName withViewControllerName:(NSString *)viewId;


@property (nonatomic,strong) RestCall *serviceCallObject;


-(void)slideUp:(int)scale;
-(void)slideBackToNormal;
-(void)itemSelectedWithItesPath:(int)index;


-(void)makeCallToNumber:(NSString *)number;

-(void)callNotificationWithTitle:(NSString *)title withInformation:(NSString *)info;

-(void)setWhenDidFilesWereDeletedLastTime;

-(int)whenDidFilesWereDeletedLastTime;

@property (nonatomic, strong) NSMutableArray *contactList;


@property (nonatomic,strong) id objectSharing;

-(BOOL)checkForAnonymous;

@property (nonatomic,strong) UISearchBar *searchBar;

@property (strong, nonatomic) NSString *viewTitle;


@property (nonatomic,strong) NSString *countryCodeForFeeds;


@property (nonatomic) BOOL isLocationErrorMessageSlidedUp;
- (BOOL) isInternetConnectionAvailable;



-(void)topBarButtonTapped;


@property (nonatomic,strong) UIButton *btnTopBarBUtton;




-(void)setMyMap;

@property (nonatomic) BOOL doSlideUpForLocationError;
@property (nonatomic) BOOL doSlidUpForNoInternetError;
-(void)useMyCurrentLocationUpdated;


@property (nonatomic,strong) UIView *viewSorryMessage;

-(void)addBackGroundViewForTableView:(UITableView *)tableView withText:(NSString *)text;

-(NSString *)myPhoneCode;
-(void)hideLoader;

-(void)showLoader;
-(int)groupId;
-(void)addSearchToTableView:(UITableView *)tableView isHiddenIneditally:(BOOL)isHidden;

@property (nonatomic,strong) NSMutableArray *filteredList;

@property (nonatomic) BOOL isSearching;

-(UIToolbar *)makeToolCarWithWithSelectorWith:(UIBarButtonItem *)barButtonDone;
@property (nonatomic,strong) UIToolbar *defaultFirstToolBar;

@property (nonatomic,strong) NSString *myName;
@property (nonatomic,strong) NSString *myLastName;
@property (nonatomic,strong) NSString *myFullName;
@property (nonatomic,strong) NSString *myEmail;

@property (nonatomic,strong) NSString *myPhoneNumber;
@property (nonatomic,strong) NSString *myProfileImageUrl;
@property (nonatomic,strong) NSString *myGender;

@property (nonatomic,strong) NSString *myDob;
@property (nonatomic,strong) NSString *myRStatus;


@property (nonatomic, strong) AVPlayerViewController *moviePlayer;

- (void)btnPlayIntroVideoTapped:(NSString *)sender;
- (BOOL)isAlphanumeric:(NSString *)string;

-(BOOL) validateStringContainsNumbersOnly:(NSString*)strng;
@property (nonatomic,strong) NSMutableArray *allPhones;
@property (nonatomic,strong) NSMutableArray *allEmail;
-(NSString*)stringByCleaningPhoneNumber: (NSString*) countryPrefix;

-(NSString *)converRawPhoneNumberToInternational:(NSString *)givenNumber currentCountryCode:(NSString *)countryCode;



@property (nonatomic,strong) NSString *commaSeperatedEmail;
@property (nonatomic,strong) NSString *commaSeperatedPhone;

-(void)showImageFromHttpUrl:(NSString *)urlToShow;

-(void)callAlertViewControllerWithTitle:(NSString *)title withMessage:(NSString *)message withOkButtonTitle:(NSString *)okTitle withCancleTitle:(NSString *)cancleTitle withOKHandler:(void(^)(void))okHandler withCancelHandler:(void(^)(void))CancelHandler;

@property (nonatomic,strong) NSDictionary *completedAssetLink;
- (UIImage*)previewFromFileAtPath:(NSString*)path ratio:(CGFloat)ratio;

- (void)applyVideoEffectsToComposition:(AVMutableVideoComposition *)composition size:(CGSize)size;

- (void)videoOutput;

- (void)exportDidFinish:(AVAssetExportSession*)session;

-(void)SetTextFieldBorder :(UITextField *)textField;

-(void)SetTextFieldBorder :(UITextField *)textField withBorderColor:(UIColor *)borderColor;


-(void)changeMyRootViewWithStoryBoardName:(NSString *)storyBoardName withViewControllerName:(NSString *)viewControllerName;


//@property (nonatomic,strong) UILabel *topBarTitleTabel;

-(void)decreaseFontBySize:(int)size withButton:(UILabel *)label;
@property (nonatomic,strong) RTSpinKitView *spinner;

@property (nonatomic,strong) UIView *panel;
-(UIImage*)imageWithImage: (UIImage*) sourceImage scaledToWidth: (float) i_width;
-(NSString *)authToken;

-(void)showErrorMessage;

- (void)styleWithButton:(UIButton *)currentButton;

- (void)unlerLineTheLabelWithText:(NSString *)text  withLabel:(UILabel *)label;




@property (nonatomic,strong) NSString * titleToShow;

- (NSDictionary *)getChapterDataWithChapterNo:(int)chapterNo;
-(BuyProductViewController *)buyProdutsView;
-(BOOL)hasMadeAnyPurchased;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *bubbleHeight;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *bubbleWidth;


@property (weak, nonatomic) IBOutlet NSLayoutConstraint *buttonTopSpace;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *bubbleLEadingSpace;
-(void)setUpButtubleView;

@property (nonatomic,strong) TitleHeading * titleHeadingView;

@property (nonatomic) BOOL showingTitleInCenter;

@property (nonatomic) BOOL addLoginButton;

@property (nonatomic) BOOL isFirstiView;
- (void)makeButtonRounded:(UIButton *)btnFeedback;
-(void)setTouchMethodWithLabel:(UIView *)currentLabel withSelector:(SEL)selector;
-(void)showAllFonts;

-(NSString *)giveNewStyledHTML:(UIWebView *)currentWebView withHtml:(NSString *)html;

-(void)makeWebViewRounded:(UIWebView *)webView;


-(int)sizeWithImage: (UIImage*) sourceImage scaledToWidth: (float) i_width;

- (void)btnBackTapped;

@property (nonatomic) BOOL dontRunbackDont;

-(void)closeButtonTapped;

@property (nonatomic,strong) UILabel * spinnerLabel;

-(UIImage*)imageWithHeightImage: (UIImage*) sourceImage scaledToWidth: (float) i_height;
-(void)settingTextDoneButtonWithTextBox:(UITextView *)textFeild withSelector:(SEL)selector;

-(BOOL)hasPushTokenAlreadySet;

-(void)shareAppWithText:(NSString *)textSharing andWithUrlSharing:(NSString *)urlSharing;

@property (nonatomic) BOOL isWhiteColor;

@property (nonatomic,strong) UIColor * customTestColorForTitle;
@property (nonatomic,strong) CustomAddToListView * customAddView;
@property (nonatomic,strong) NSMutableArray * currentCategories;
@property (nonatomic,strong) NSMutableDictionary * categoriesIds;

-(void)changeTheViewRootControlletWithStoryBoardName:(NSString *)storyname withRootName:(NSString *)rootViewName;
-(void)showExternalUrl:(NSString *)externalUrl;
@property (strong, nonatomic) AudioController *audioController;
-(void)inititateTheAudioFile:(NSString *)fileName withFileType:(NSString *)fileType withOneTimePlay:(BOOL)oneTime;


@property (nonatomic) BOOL isPaused;
-(void)resumeFromPausedState;

-(void)pauseTheMusic;
@property(nonatomic, strong) GADInterstitial *interstitial;


@end
