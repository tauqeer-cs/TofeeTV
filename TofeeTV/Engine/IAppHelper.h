//
//  IAppHelper.h
//  TofeeTV
//
//  Created by Tauqeer Ahmed on 07/07/2019.
//  Copyright © 2019 Tauqeer. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <StoreKit/StoreKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface IAppHelper : NSObject<SKProductsRequestDelegate,SKPaymentTransactionObserver>

@end

NS_ASSUME_NONNULL_END
