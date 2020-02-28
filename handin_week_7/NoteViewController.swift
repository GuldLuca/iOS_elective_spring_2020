//
//  NoteViewController.swift
//  week_08
//
//  Created by admin on 27/02/2020.
//  Copyright © 2020 Rabotnik. All rights reserved.
//

import UIKit
import os.log

class NoteViewController: UIViewController, UITextViewDelegate, UITextFieldDelegate {
    var note: Note?
    @IBOutlet weak var text_view: UITextView!
    
    @IBOutlet weak var text_field: UITextField!
            
    @IBOutlet weak var saveButton: UIBarButtonItem!
    
    @IBAction func cancel(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        text_view.delegate = self
        text_field.delegate = self
        
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {

        super.prepare(for: segue, sender: sender)
        
        guard let button = sender as? UIBarButtonItem, button === saveButton else {
            os_log("The save button was not pressed, cancelling", log: OSLog.default, type: .debug)
            
                return
        }
        
        let name = text_field.text ?? ""
        let content = text_view.text ?? ""

        
        note = Note(name: name, content: content)

    }
    
    private func textViewShouldReturn(_ textView: UITextView) -> Bool {
        
        textView.resignFirstResponder()
        return true
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        // Disable the Save button while editing.
    }
    
    func textViewDidEndEditing(_ textView: UITextView){

        navigationItem.title = text_field.text

    }
    
}

