//
//  TestingAgainViewController.swift
//  TofeeTV
//
//  Created by Tauqeer Ahmed on 10/07/2019.
//  Copyright © 2019 Tauqeer. All rights reserved.
//

import UIKit
import StoreKit

class TestingAgainViewController: UIViewController , SKPaymentTransactionObserver {

    
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
        } else {
            print("User unable to make payments")
        }
    }
    func paymentQueue(_ queue: SKPaymentQueue, updatedTransactions transactions: [SKPaymentTransaction]) {
        for transaction in transactions {
            if transaction.transactionState == .purchased {
                //if item has been purchased
                print("Transaction Successful")
                //purchaseLabel.text = "Purchase Completed!"
            } else if transaction.transactionState == .failed {
                
                print(transaction.error)
            } else if transaction.transactionState == .restored {
                print("restored")
               // purchaseLabel.text = "Purchase Restored!"
            }
        }
    }
    
    @IBAction func restorePressed(_ sender: Any) {
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
