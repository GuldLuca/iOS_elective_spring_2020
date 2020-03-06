//
//  DetailViewController.swift
//  week_08
//
//  Created by admin on 28/02/2020.
//  Copyright © 2020 Rabotnik. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController  {

    @IBOutlet weak var name: UITextField!
    
    @IBOutlet weak var content: UITextView!
    
    @IBOutlet weak var testContent: UILabel!
    
    @IBAction func cancel(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }
    
   var noteName = ""
   var noteContent = ""
    
   override func viewWillAppear(_ animated: Bool) {
    testContent.text = noteContent
   }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
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
