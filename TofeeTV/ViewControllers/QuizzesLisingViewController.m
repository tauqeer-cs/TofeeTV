//
//  QuizzesLisingViewController.m
//  TofeeTV
//
//  Created by Tauqeer Ahmed on 06/02/2019.
//  Copyright © 2019 Tauqeer. All rights reserved.
//

#import "QuizzesLisingViewController.h"
#import "Question.h"
#import "Quiz.h"
#import "SongsCollectionViewCell.h"
#import "QuestionViewController.h"




@interface QuizzesLisingViewController ()
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
//@property (nonatomic,strong) NSArray <Song *>* dataSource;
@property (nonatomic,strong) NSArray *dataSource;

@end

@implementation QuizzesLisingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    self.collectionView.dataSource = self;
    self.collectionView.delegate = self;
    
    [self addCollectionViewCellWithCollectionView:self.collectionView withNibName:@"SongsCollectionViewCell" withCellIdName:@"cellSongs"];
    
        [self showLoader];
    
    [Quiz callQuiztionsListingWithComiltionHandler:^(id result) {
        
        [self hideLoader];
        self.dataSource = result;
        [self.collectionView reloadData];
        
        NSLog(@"");
        
    } withFailueHandler:^(id error) {
        
        [self hideLoader];
        
        
    }];
    
    //
  //  [self inititateTheAudioFile:@"App background loop" withFileType:@"wav" withOneTimePlay:NO];
    
    
}
-(void)viewDidAppear:(BOOL)animated
{
    
    [super viewDidAppear:animated];
    
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    
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
    
    Quiz * currentItmSelected = self.dataSource[indexPath.row];
    currentCell.backgroundColor = currentItmSelected.itemColor;
    
    currentCell.lblTitle.text = currentItmSelected.name;
    
    
    if (currentItmSelected.fileOwned) {
        [currentCell.lockedImage setHidden:YES];
        
        
    }
    else
    {
        [currentCell.lockedImage setHidden:NO];
        
    }
    
    
    [FileManager
     loadImageFromurl:currentItmSelected.thumbNailUrl
     withComplitionHandler:^(id result) {
         [currentCell.imageShowing setImage:result];
         
     } withFailHander:^(int item) {
     
         
     }];
    
    
    return currentCell;
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    Quiz * currentItmSelected = self.dataSource[indexPath.row];
    
    if (!currentItmSelected.fileOwned) {
        
        
        [self showAlert:@"Locked Quiz" message:@"Please unlock the quiz by view songs first"];
        
        
    }
    else
    {
        QuestionViewController * destination = [[QuestionViewController alloc] initWithNibName:self.questionViewControllerName bundle:nil];
        destination.questionIndex = 0;
        
        destination.selectedSong = currentItmSelected;
        [self.navigationController showViewController:destination sender:nil];        
    }
    
    
    
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
