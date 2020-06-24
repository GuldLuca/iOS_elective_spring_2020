//
//  StepsViewController.swift
//  KeaHealth
//
//  Created by admin on 18/06/2020.
//  Copyright © 2020 kea. All rights reserved.
//

import UIKit
import CoreLocation
import HealthKit

class StepsViewController: UIViewController {
    
    
    @IBOutlet weak var distanceLabel: UILabel!
    @IBOutlet weak var stepsLabel: UILabel!
    
    let healthStore = HKHealthStore()
    var travelDistance = 0.0
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    func getCurrentDaySteps(completion: @escaping (Double) -> Void) {
        let stepsQuantityType = HKQuantityType.quantityType(forIdentifier: .stepCount)!
        
        let currentTime = Date()
        let startTime = Calendar.current.startOfDay(for: currentTime)
        let totalTime = HKQuery.predicateForSamples(withStart: startTime, end: currentTime, options: .strictStartDate)
        
        let calculateSteps = HKStatisticsQuery(quantityType: stepsQuantityType, quantitySamplePredicate: totalTime, options: .cumulativeSum) {(_, result, error) in
            
            var counted = 0.0
            guard let result = result else{
                print("Failed to count steps")
                completion(counted)
                return
            }
            if let sum = result.sumQuantity() {
                counted = sum.doubleValue(for: HKUnit.count())
            }
            
            DispatchQueue.main.async {
                completion(counted)
            }
        }
        healthStore.execute(calculateSteps)
    }
    
    @IBAction func countSteps(_ sender: Any) {
        getCurrentDaySteps {(result) in
            print("Fetched steps: \(result)")
            DispatchQueue.main.async {
                self.stepsLabel.text = "\(result)"
            }
        }
    }
    
    func getDistance(tracked: Double, date: NSDate) {
        
        let distanceQuantityType = HKQuantityType.quantityType(forIdentifier: .distanceWalkingRunning)
        let distanceUnit = HKQuantity(unit: HKUnit.meter(), doubleValue: tracked)
        let distance = HKQuantitySample(type: distanceQuantityType!, quantity: distanceUnit, start: date as Date, end: date as Date)
        
        healthStore.save(distance, withCompletion: {(result, error) in
            if error != nil{
                print("Failed saving distance \(error.debugDescription)")
            }
            else{
                print("Distance saved \(result)")
            }
        })
    }
    
    @IBAction func getDistanceBtn(_ sender: Any) {
        getDistance(tracked: travelDistance, date: NSDate())
        self.distanceLabel.text = "\(travelDistance)"
    }
    
    
}
