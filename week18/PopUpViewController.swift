//
//  PopUpViewController.swift
//  mandatory18
//
//  Created by admin on 27/06/2020.
//  Copyright © 2020 kea. All rights reserved.
//

import UIKit

class PopUpViewController: UIViewController {

    @IBOutlet weak var popTitle: UILabel!
    @IBOutlet weak var popDate: UILabel!
    @IBOutlet weak var popDescription: UILabel!
    @IBOutlet weak var popAllowed: UILabel!
    
    var pTitle = ""
    var pDate = ""
    var pDesc = ""
    var pAllowed = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        showAnimate()
        getValues()
    }

    @IBAction func closeThePop(_ sender: Any) {
        removeAnimate()
    }
    
    func showAnimate()
    {
        self.view.transform = CGAffineTransform(scaleX: 1.3, y: 1.3)
        self.view.alpha = 0.0
        UIView.animate(withDuration: 0.25, animations: {
            self.view.alpha = 1.0
            self.view.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
        })
    }
    
    func getValues(){
        popTitle.text = pTitle
        popDate.text = pDate
        popDescription.text = pDesc
        popAllowed.text = pAllowed
    }

    func removeAnimate()
    {
        UIView.animate(withDuration: 0.25, animations: {
            self.view.transform = CGAffineTransform(scaleX: 1.3, y: 1.3)
            self.view.alpha = 0.0
        }, completion: {(finished : Bool) in
            if(finished)
            {
                self.willMove(toParent: nil)
                self.view.removeFromSuperview()
                self.removeFromParent()
            }
        })
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
