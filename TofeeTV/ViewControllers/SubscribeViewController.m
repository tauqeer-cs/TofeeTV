//
//  SubscribeViewController.m
//  TofeeTV
//
//  Created by Tauqeer Ahmed on 09/07/2019.
//  Copyright © 2019 Tauqeer. All rights reserved.
//

#import "SubscribeViewController.h"
#import "InAppPaymentQueue.h"
#import "InAppProductRequester.h"
#import "InAppReceiptVerifier.h"
#import "InAppSubscriptionManager.h"
@import StoreKit;
#import "IAPHelper.h"
#import "IAPShare.h"
#import "MKStoreKit.h"

@interface SubscribeViewController ()<SKPaymentTransactionObserver>

@property (nonatomic) InAppProductRequester* productRequester;
@property (nonatomic) InAppReceiptVerifier* receiptVerifier;
@property (nonatomic) SKProduct* product;
@property (nonatomic) InAppSubscriptionManager* subManager;


@property (nonatomic,strong) SKPaymentQueue * paymentQue;

//    let paymentQueue = SKPaymentQueue.default()

@end

@implementation SubscribeViewController

#define PRODUCT_ID  @"com.tofee.adsRemove"
#define URL @"https://inapp-mediacom.rhcloud.com/verify"


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.subManager = [[InAppSubscriptionManager alloc]init];
    
    [self requestProduct];
 
    self.paymentQue = [SKPaymentQueue defaultQueue] ;
  [self.paymentQue addPayment:self];
    
    //SKPaymentQueue.default().add(self)
    
}
//maybe step 1

-(void)requestProduct{
  
    
    
    
    if(![IAPShare sharedHelper].iap) {
        //com.hashtaggospel
        //unlock123
        NSSet* dataSet = [[NSSet alloc] initWithObjects:PRODUCT_ID, nil];
        
        [IAPShare sharedHelper].iap = [[IAPHelper alloc] initWithProductIdentifiers:dataSet];
    }
    
    [IAPShare sharedHelper].iap.production = NO;
    
    
    [[IAPShare sharedHelper].iap requestProductsWithCompletion:^(SKProductsRequest* request,SKProductsResponse* response)
     {
         NSLog(@"%@",response);
         if(response > 0 ) {
             NSLog(@"%@",response);
             
             SKProduct* product =[[IAPShare sharedHelper].iap.products objectAtIndex:0];
             
             NSLog(@"Price: %@",[[IAPShare sharedHelper].iap getLocalePrice:product]);
             //NSLog(@"Title: %@",product.subscriptionPeriod.unit);
             
             
             
             [self makePayment];
             
             
             
             
             
         }
     }];
    
    
    return;
    
    
}

- (void)paymentQueue:(SKPaymentQueue *)queue updatedTransactions:(NSArray<SKPaymentTransaction *> *)transactions{
    
    NSLog(@"");
    
}


-(BOOL)canMakePayment {
    
    return SKPaymentQueue.canMakePayments;
    
    
}

-(void)makePayment{
    
    if (self.product != nil){
  
        
        
        SKMutablePayment *request = [SKMutablePayment new];
        request.productIdentifier = PRODUCT_ID;
       
        [[SKPaymentQueue defaultQueue] addPayment:request];
        
        //let paymentRequest = SKMutablePayment()
        //paymentRequest.productIdentifier = productID
        //SKPaymentQueue.default().add(paymentRequest)
        


            //SKPaymentQueue.default().add(self)

        

        //[[SKPaymentQueue defaultQueue] addPayment:[SKPayment paymentWithProduct:self.product]];
        
//        [[InAppPaymentQueue sharedInstance] addPayment:self.product];

        return;
        
        
        [[IAPShare sharedHelper].iap buyProduct:self.product
                                   onCompletion:^(SKPaymentTransaction* trans){
                                       if(trans.error)
                                       {
                                           
                                           NSLog(@"Fail %@",[trans.error localizedDescription]);
                                           
                                       }
                                       else if(trans.transactionState == SKPaymentTransactionStatePurchased) {
                                           
                                           [[IAPShare sharedHelper].iap checkReceipt:[NSData dataWithContentsOfURL:[[NSBundle mainBundle] appStoreReceiptURL]] AndSharedSecret:@"your sharesecret" onCompletion:^(NSString *response, NSError *error) {
                                               NSDictionary* rec = [IAPShare toJSON:response];
                                               if([rec[@"status"] integerValue]==0)
                                               {
                                                   [[IAPShare sharedHelper].iap provideContentWithTransaction:trans];
                                                   NSLog(@"SUCCESS %@",response);
                                                   NSLog(@"Pruchases %@",[IAPShare sharedHelper].iap.purchasedProducts);
                                                   //[self.userDefaults setValue:@"1" forKey:@"HasPurchasedTheItem"];
                                                   // [self hideLoader];
                                               }
                                               else {
                                                   NSLog(@"Fail");
                                               }
                                           }];
                                       }
                                       else if(trans.transactionState == SKPaymentTransactionStateFailed) {
                                           NSLog(@"Fail");
                                       }
                                   }];
        
    }
    
}

-(void)validateRecipt{
    
    NSData* receiptData = [NSData dataWithContentsOfURL:[[NSBundle mainBundle] appStoreReceiptURL]];
    if (receiptData != nil){
        NSString* receipt = [receiptData base64EncodedStringWithOptions:0];
        
        self.receiptVerifier = [[InAppReceiptVerifier alloc]initWithUrl:URL];
#if SANDBOX
        self.receiptVerifier.sandbox = YES;
#endif
        
        [self.receiptVerifier verifyReceipt:receipt complete:^(NSDictionary *items, NSError *error) {
            
        }];
    }
    
}

- (void)magClick {
    InAppSubscription* sub = self.subManager.mag;
    [self checkSubscription:sub name:@"Magazine"];
    
}
-(void)checkSubscription:(InAppSubscription*)sub name:(NSString*)name
{
    if (sub.isActive){
        [self showMessage:[NSString stringWithFormat:@"Subscription %@ active !!!", name]];
    }else{
        EVENT_ADD(sub, onPaymentSuccess:^,{
            EVENT_REMOVE_ALL();
            [self showMessage:[NSString stringWithFormat:@"Subscription %@ activated !!!", name]];
        });
        EVENT_ADD(sub, onPaymentFailed:^,{
            EVENT_REMOVE_ALL();
            [self showMessage:@"Paymnet failed"];
        });
        EVENT_ADD(sub, onPaymentCancelled:^,{
            EVENT_REMOVE_ALL();
        });
        
        [sub requestPayment];
    }
}



-(void)showMessage:(NSString*)mes
{
    [[[UIAlertView alloc]initWithTitle:@"" message:mes delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil] show];
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

