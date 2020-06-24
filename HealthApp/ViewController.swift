//
//  ViewController.swift
//  KeaHealth
//
//  Created by admin on 18/06/2020.
//  Copyright © 2020 kea. All rights reserved.
//

import UIKit
import CoreLocation
import HealthKit

class ViewController: UIViewController {
    
    let healthStore = HKHealthStore()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func getAuth(_ sender: Any) {
        let healthKitTypes: Set = [
            HKObjectType.quantityType(forIdentifier: HKQuantityTypeIdentifier.stepCount)!,
            HKObjectType.quantityType(forIdentifier: HKQuantityTypeIdentifier.distanceWalkingRunning)!
        ]
        
        healthStore.requestAuthorization(toShare: healthKitTypes, read: healthKitTypes) {(bool, error) in
            if let error = error {
                print("Authorisation failed \(error.localizedDescription)")
            }
            else{
                print("Authorisation successful")
            }
        }
    }
    
}

