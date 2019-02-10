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
@interface SongsListingViewController ()<UICollectionViewDelegate,UICollectionViewDataSource>

@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
//    //

@property (nonatomic,strong) NSArray <Song *>* dataSource;

@end

@implementation SongsListingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"Songs Listing";
    
 
    self.collectionView.dataSource = self;
    self.collectionView.delegate = self;
    
    [self addCollectionViewCellWithCollectionView:self.collectionView withNibName:@"SongsCollectionViewCell" withCellIdName:@"cellSongs"];
    
    
    
    [Song callGiveMeSongsListWithComiltionHandler:^(id  _Nonnull result) {
        
        self.dataSource = result;
        [self.collectionView reloadData];
        
    } withFailueHandler:^(id  _Nonnull error) {
        
    }];
    
    
}

-(NSInteger)collectionView:(UICollectionView *)collectionView
    numberOfItemsInSection:(NSInteger)section{
    
    return [self.dataSource count];
    
}

- (CGSize)collectionView:(UICollectionView *)collectionView
                  layout:(UICollectionViewLayout*)collectionViewLayout
  sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    
    
    return CGSizeMake([[UIScreen mainScreen ] bounds].size.width-32, 98);
    
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView
                  cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    SongsCollectionViewCell *currentCell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cellSongs" forIndexPath:indexPath];
    currentCell.backgroundColor = self.dataSource[indexPath.row].itemColor;
    return currentCell;
}


- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    
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
