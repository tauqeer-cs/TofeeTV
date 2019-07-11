//
//  TestingAgainViewController.swift
//  TofeeTV
//
//  Created by Tauqeer Ahmed on 10/07/2019.
//  Copyright © 2019 Tauqeer. All rights reserved.
//

import UIKit
import StoreKit

class TestingAgainViewController: BaseViewController , SKPaymentTransactionObserver {

    
    let productID = "com.tofee.adsRemove"
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
          SKPaymentQueue.default().add(self)
        

    }


    @IBAction func purchasePressed(_ sender: Any) {
        
        if SKPaymentQueue.canMakePayments() {
            let paymentRequest = SKMutablePayment()
            paymentRequest.productIdentifier = productID
            paymentRequest.simulatesAskToBuyInSandbox = true
            
            SKPaymentQueue.default().add(paymentRequest)
            self.showLoader()
        } else {
            
            self.showAlert("", message: "You can purchase this subscribtion")
            print("User unable to make payments")
        }
    }
    func paymentQueue(_ queue: SKPaymentQueue, updatedTransactions transactions: [SKPaymentTransaction]) {
        for transaction in transactions {
            if transaction.transactionState == .purchased {
                //if item has been purchased
                print("Transaction Successful")
                self.hideLoader()
              

            self.setAds(true)
                
            //self.setAds(true)
                
            } else if transaction.transactionState == .failed {
                
                print(transaction.error)
                self.hideLoader()
                self.showAlert("", message: "Can process your request")
            } else if transaction.transactionState == .restored {
                print("restored")
               // purchaseLabel.text = "Purchase Restored!"
                self.hideLoader()
                self.setAds(true)
            }
        }
    }
    
    @IBAction func restorePressed(_ sender: Any) {
        self.showLoader()
        
        SKPaymentQueue.default().restoreCompletedTransactions()
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
