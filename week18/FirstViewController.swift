//
//  FirstViewController.swift
//  mandatory18
//
//  Created by admin on 27/06/2020.
//  Copyright © 2020 kea. All rights reserved.
//

import UIKit
import FirebaseFirestore
import FirebaseCore

class FirstViewController: UIViewController, UIPopoverPresentationControllerDelegate {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var descTextView: UITextView!
    @IBOutlet weak var allowTextField: UITextField!
    
    let db = Firestore.firestore()
    
    var elements: [Element] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        getCollection()
        // Do any additional setup after loading the view.
    }
    
    func getCollection() {
        
        db.collection("to_do_list")
            .addSnapshotListener { (querySnapshot, error) in
            
            self.elements = []
            
            if let e = error {
                print("Something went wrong. Couldn't get data. \(e)")
            }
            else{
                if let snapshotDocuments = querySnapshot?.documents {
                    for doc in snapshotDocuments {
                        let data = doc.data()
                        if let elementTitle = data["title"] as? String, let elementDescription = data["description"] as? String, let elementAllowed = data["isAllowed"] as? String, let elementDate = data["date"] as? String {
                            let newElement = Element(title: elementTitle, description: elementDescription, isAllowed: elementAllowed, date: elementDate)
                            self.elements.append(newElement)
                            
                            DispatchQueue.main.async {
                                self.tableView.reloadData()
                                
                                let indexPath = IndexPath(row: self.elements.count - 1, section: 0)
                                self.tableView.scrollToRow(at: indexPath, at: . top, animated: false)
                            }
                        }
                    }
            }
            }
        }
    }
    
    @IBAction func changeDate(_ sender: Any) {
        let formatter = DateFormatter()

        formatter.dateStyle = DateFormatter.Style.short
        formatter.timeStyle = DateFormatter.Style.short

        let strDate = formatter.string(from: datePicker.date)
        dateLabel.text = strDate
    }
    
    @IBAction func addElementBtn(_ sender: Any) {
        if let elementTitle = titleTextField.text, let elementDescription = descTextView.text, let elementAllowed = allowTextField.text, let elementDate = dateLabel.text{
            db.collection("to_do_list").addDocument(data:[
                "title" : elementTitle,
                "description" : elementDescription,
                "isAllowed" : elementAllowed,
                "date" : elementDate
            ])
            { (error) in
                if let e = error{
                    print("Something went wrong. Could'nt save data in FireStore. \(e)")
                }
                else{
                    print("Success! Data saved in FireStore")
                    
                    DispatchQueue.main.async {
                        self.titleTextField.text = ""
                        self.descTextView.text = ""
                        self.allowTextField.text = ""
                        self.dateLabel.text = "Date"
                    }
                }
            }
        }
        allowedConf()
    }
    
    func allowedConf(){
        if allowTextField.text == "Allowed"{
            allowTextField.textColor = UIColor.green
        }
        else if allowTextField.text == "Not allowed"{
            allowTextField.textColor = UIColor.red

        }
        else{
            let alert = UIAlertController(title: "Please type in [Allowed] or [Not allowed]. Make sure to spell it right. Cause I'm lazy.", message: nil, preferredStyle: .alert)
            let action = UIAlertAction(title: "Ok", style: .default, handler: nil)
            alert.addAction(action)
            present(alert, animated: true, completion: nil)
        }
    }
}

extension FirstViewController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return elements.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let element = elements[indexPath.row]
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! TableViewCell
        
        cell.tiltlLabel.text = element.title
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath){
        
        func prepare(for segue: UIStoryboardSegue, sender: Any?) {
            if segue.identifier == "popUp"{
                let popPop = segue.destination as! PopUpViewController
                popPop.pTitle = elements[indexPath.row].title
                popPop.pDate = elements[indexPath.row].date
                popPop.pDesc = elements[indexPath.row].description
                popPop.pAllowed = elements[indexPath.row].isAllowed
            }
        }
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
        let elementToDelete = elements[indexPath.row]
        
        if (editingStyle == UITableViewCell.EditingStyle.delete){
            
            elements.remove(at: indexPath.row)
            
            tableView.deleteRows(at: [indexPath], with: UITableView.RowAnimation.automatic)
            
            let elementId = elementToDelete.title
            
            db.collection("to_do_list").whereField("title", isEqualTo: elementId).getDocuments { (querySnapshot, error) in
                
                if let error = error {
                    print(error)
                }
                else{
                    for document in querySnapshot!.documents {
                        document.reference.delete()
                        print("Doc deleted")
                    }
                }
                
            }
            
        }
        
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
        
        
    }
        
}
