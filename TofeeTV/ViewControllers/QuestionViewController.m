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

@interface QuestionViewController ()
@property (weak, nonatomic) IBOutlet UILabel *lblQuestionTextOne;
@property (weak, nonatomic) IBOutlet UILabel *lblQuestionTextTwo;

@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *answerButons;
@property (strong, nonatomic) IBOutletCollection(UIView) NSArray *pillarViews;

@property (weak, nonatomic) IBOutlet UIButton *btnQuestion1;
@property (weak, nonatomic) IBOutlet UIButton *btnQuestion2;
@property (weak, nonatomic) IBOutlet UIButton *btnQuestion3;
@property (weak, nonatomic) IBOutlet UIButton *btnQuestion4;

@end

@implementation QuestionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.lblQuestionTextOne.text = @"Question one part one";
    self.lblQuestionTextTwo.text = @"Question on part two";
    
    NSLog(@"%@",self.lblQuestionTextTwo.font.fontName);
    self.lblQuestionTextOne.font =  [UIFont fontWithName:FancyFont size:30];
    self.lblQuestionTextOne.font =  [UIFont fontWithName:FancyFont size:36];
    NSLog(@"%@",self.lblQuestionTextTwo.font.fontName);
    
    for (UIView * currentView in self.pillarViews) {
        
        [currentView setBackgroundColor:[UIColor clearColor]];
    
    }
    
    
    [self setQuestionDataWithIndex];
    
    
   // [self setQuestionDataWithIndex:self.questionIndex];
    
}
-(void)setQuestionDataWithIndex
{
 
    Question * currentQuestion = self.selectedSong.myQuestions[self.questionIndex];
    self.lblQuestionTextOne.text = currentQuestion.question;
    self.lblQuestionTextTwo.text = currentQuestion.subQuestion;
   
    
    if ([currentQuestion.questionType isEqualToString:@"four_options"])
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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
