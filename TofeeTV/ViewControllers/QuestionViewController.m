//
//  QuestionViewController.m
//  TofeeTV
//
//  Created by Tauqeer Ahmed on 23/02/2019.
//  Copyright © 2019 Tauqeer. All rights reserved.
//

#import "QuestionViewController.h"
#import "Song.h"
#import "Question.h"
#import "Quiz.h"
#import "ThankYouViewController.h"
#import "AudioController.h"

@interface QuestionViewController ()
@property (weak, nonatomic) IBOutlet UILabel *lblQuestionTextOne;
@property (weak, nonatomic) IBOutlet UILabel *lblQuestionTextTwo;

@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *answerButons;

@property (weak, nonatomic) IBOutlet UIButton *btnQuestion1;
@property (weak, nonatomic) IBOutlet UIButton *btnQuestion2;
@property (weak, nonatomic) IBOutlet UIButton *btnQuestion3;
@property (weak, nonatomic) IBOutlet UIButton *btnQuestion4;
@property (weak, nonatomic) IBOutlet UIView *viewReactionView;
@property (weak, nonatomic) IBOutlet UIImageView *yayImage;

@property (weak, nonatomic) IBOutlet UIImageView *viewNayImage;

@property (weak, nonatomic) IBOutlet UIImageView *hintImage;
@property (nonatomic,strong) UIColor * defaultButtonColor;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *topDistance;

@property (nonatomic,strong) UIImageView * gestureImageView;
@property (weak, nonatomic) IBOutlet UIView *questionContainer;
@end

@implementation QuestionViewController

-(void)enableAllButtons {

    for (UIButton * currentButton in self.answerButons)
    {
        [currentButton setEnabled:YES];
        currentButton.backgroundColor = self.defaultButtonColor;
        
    }
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.defaultButtonColor = self.btnQuestion1.backgroundColor;
    
    
    NSLog(@"%@",self.lblQuestionTextTwo.font.fontName);
    self.lblQuestionTextOne.font =  [UIFont fontWithName:FancyFont size:36];
    if (IS_IPad) {

        self.lblQuestionTextOne.font =  [UIFont fontWithName:FancyFont size:55];
        
    }
    NSLog(@"%@",self.lblQuestionTextTwo.font.fontName);
    
    self.title = @"Game";

    
    
    
    for (UIButton * currentButton in self.answerButons)
    {
        [currentButton.titleLabel setFont:[UIFont fontWithName:FancyFont size:24]];
        
        if (IS_IPad) {
            [currentButton.titleLabel setFont:[UIFont fontWithName:FancyFont size:36]];
            
        }
        currentButton.layer.borderColor = [UIColor whiteColor].CGColor ;
        currentButton.layer.borderWidth = 3.0;
        
    }
    [self setQuestionDataWithIndex];
   UIPanGestureRecognizer * panRecognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self
                                                                                     action:@selector(handlePanGesture:)];
    [self.hintImage addGestureRecognizer:panRecognizer];
    self.hintImage.userInteractionEnabled = YES;
    
    
}

- (void)handlePanGesture:(UIPanGestureRecognizer *)gestureRecognizer
{
    if (gestureRecognizer.state == UIGestureRecognizerStateBegan)
    {
     
        self.gestureImageView = [UIImageView new];
        [self.gestureImageView setImage:self.hintImage.image];
        [self.gestureImageView setFrame:CGRectMake(gestureRecognizer.view.frame.origin.x, gestureRecognizer.view.frame.origin.y, self.hintImage.frame.size.width/2, self.hintImage.frame.size.height/2)];
        
        [self.view addSubview:self.gestureImageView];
        
        
    }
    else if (gestureRecognizer.state == UIGestureRecognizerStateEnded){

        
        [self.gestureImageView removeFromSuperview];
        self.gestureImageView = nil;

        CGRect frame = self.gestureImageView.frame;
        frame.origin = [gestureRecognizer locationInView:self.gestureImageView.superview];
        
        self.gestureImageView.frame = frame;
        
        CGPoint draggingPoint = [gestureRecognizer locationInView:self.view];
        UIView *hitView = [self.view hitTest:draggingPoint withEvent:nil];
        
        if ([hitView isEqual:self.btnQuestion1]) {
            
            NSLog(@"its in the range");
            [self btnQuestionTapped:self.btnQuestion1];
            
        }
        else if([hitView isEqual:self.btnQuestion2]){
            NSLog(@"its in the range");
            [self btnQuestionTapped:self.btnQuestion2];
            
        }
        else if([hitView isEqual:self.btnQuestion3]){
            NSLog(@"its in the range");
            [self btnQuestionTapped:self.btnQuestion3];
            
        }
        else if([hitView isEqual:self.btnQuestion4]){
            NSLog(@"its in the range");
            
            [self btnQuestionTapped:self.btnQuestion4];
            
        }
        else
        {

            
        }
        
    }
    
    if (self.gestureImageView) {
        CGRect frame = self.gestureImageView.frame;
        frame.origin = [gestureRecognizer locationInView:self.gestureImageView.superview];
        
        self.gestureImageView.frame = frame;
     
        CGPoint draggingPoint = [gestureRecognizer locationInView:self.view];
        UIView *hitView = [self.view hitTest:draggingPoint withEvent:nil];
        
        if ([hitView isEqual:self.btnQuestion1]) {
            
            NSLog(@"its in the range");
            
            [self setAllButtonHightlightedNot];
            
            [self.btnQuestion1 setHighlighted:YES];
            
            
        }
        else if([hitView isEqual:self.btnQuestion2]){
            NSLog(@"its in the range");
            [self setAllButtonHightlightedNot];
            [self.btnQuestion2 setHighlighted:YES];
            
        }
        else if([hitView isEqual:self.btnQuestion3]){
                        NSLog(@"its in the range");
            [self setAllButtonHightlightedNot];
            [self.btnQuestion3 setHighlighted:YES];
            
            
        }
        else if([hitView isEqual:self.btnQuestion4]){
                        NSLog(@"its in the range");
        
            [self setAllButtonHightlightedNot];
            
            [self.btnQuestion4 setHighlighted:YES];
            
        }
        else
        {
            [self setAllButtonHightlightedNot];
            
        }
        
    }


}

-(void)setAllButtonHightlightedNot{
    
    [self.btnQuestion1 setHighlighted:NO];
    [self.btnQuestion2 setHighlighted:NO];
    [self.btnQuestion3 setHighlighted:NO];
    [self.btnQuestion4 setHighlighted:NO];
    
}
-(void)setQuestionDataWithIndex
{
 
    Question * currentQuestion = self.selectedSong.myQuestions[self.questionIndex];
    self.lblQuestionTextOne.text = currentQuestion.question;
   
    if ([currentQuestion.hintImage length] == 0) {
        
        [self.hintImage setHidden:YES];
        
        self.topDistance.constant = 120;
        
    }
    else {
        self.topDistance.constant = 72;
        
        // add the loading image logic here
        
        [self.hintImage setHidden:NO];
        
        [FileManager loadItemImage:self.hintImage url:currentQuestion.hintImage loader:nil withComplitionHandler:^(id value) {
        
            
            [self.hintImage setImage:value[1]];
            
            NSLog(@"");
            
        }];
        
    }
    
    if ([currentQuestion.questionType isEqualToString:@"four_options"] || [currentQuestion.questionType isEqualToString:@"images"])
    {
    
        NSArray * buttonsArray = @[self.btnQuestion1,self.btnQuestion2,self.btnQuestion3,self.btnQuestion4];
        
        
        [self.btnQuestion3 setHidden:NO];
        [self.btnQuestion4 setHidden:NO];
        
        for (int i = 0; i < 4; i++)
        {
        
            UIButton * currentButton = buttonsArray[i];
            [currentButton setTitle:currentQuestion.optionsArray[i] forState:UIControlStateNormal];
            
            
        }
        
    }//
    else if ([currentQuestion.questionType isEqualToString:@"two_options"])
    {//,self.btnQuestion4
        NSArray * buttonsArray = @[self.btnQuestion1,self.btnQuestion2];
       
        [self.btnQuestion3 setHidden:YES];
        [self.btnQuestion4 setHidden:YES];
        
        for (int i = 0; i < 2; i++)
        {
            
            UIButton * currentButton = buttonsArray[i];
            [currentButton setTitle:currentQuestion.optionsArray[i] forState:UIControlStateNormal];
            
            
        }
        
    }//two_options
    else
    {
        
    }
    
    
}

- (IBAction)btnQuestionTapped:(UIButton *)sender {
    

 
    int selectedAnswerIndex = sender.tag;
    
   Question * currentQuestion =  self.selectedSong.myQuestions[self.questionIndex];
    NSString * selectedAnswer = currentQuestion.optionsArray[selectedAnswerIndex];
    
    
    if (![selectedAnswer isEqualToString:currentQuestion.answer]) {
        
        [self inititateTheAudioFile:@"uh oh" withFileType:@"wav" withOneTimePlay:YES];
        

        [sender setEnabled:NO];
        sender.backgroundColor = [UIColor lightGrayColor];
        return;
    }
    
    
    [self enableAllButtons];
    
    
    //yay.
    [self inititateTheAudioFile:@"yay" withFileType:@"wav" withOneTimePlay:YES];
    
    [UIView transitionWithView:self.viewReactionView
                      duration:1.0
                       options:UIViewAnimationOptionTransitionCrossDissolve
                    animations:^{
                        
                        [self.view bringSubviewToFront:self.viewReactionView];
                        [self.viewReactionView setHidden:NO];
                        [self.yayImage setHidden:NO];
                        
                    }
                    completion:^(BOOL finished) {
                        
                        
                        
                        double delayInSeconds = 2.0;
                        dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds * NSEC_PER_SEC));
                        dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
                            
                            [UIView transitionWithView:self.viewReactionView
                                              duration:1.0
                                               options:UIViewAnimationOptionTransitionCrossDissolve
                                            animations:^{
                                                
                                                
                                                [self.yayImage setHidden:YES];
                                                
                                            }
                                            completion:^(BOOL finished) {
                                                
                                                
                                                [self.viewReactionView setHidden:YES];
                                                
                                                [self pauseTheMusic];
                                                
                                            }];
                            
                        });
                    }];
    
    
    [self showLoader];
    
    
    [Quiz callSubmitQuestionsWithQuestionId:currentQuestion.questionId
                         withAnswerSelected:selectedAnswer
                                 withSongId:self.selectedSong.itemId
                       withComiltionHandler:^(id  _Nonnull result) {
        
                           NSLog(@"");
                           
                           
                           [self hideLoader];
                           
                           
                           if (([self.selectedSong.myQuestions count]-1) == self.questionIndex)
                           {
                        
                               ThankYouViewController * destination  = [[ThankYouViewController alloc] initWithNibName:@"ThankYouViewController" bundle:nil];
                               
                               destination.currentQuestion = self.selectedSong;
                               
                               
                               [self.navigationController showViewController:destination sender:nil];
                               
                               

                           }
                           else
                           {
                               self.questionIndex++;
                               
                               [self setQuestionDataWithIndex];
                           
                           }
                           
    } withFailueHandler:^(id  _Nonnull error) {
        
    }];
    
    NSLog(@"");
    
    

    
    

}


@end
