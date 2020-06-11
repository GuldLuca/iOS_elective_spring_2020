//
//  ViewController.swift
//  mandatory9
//
//  Created by admin on 03/06/2020.
//  Copyright © 2020 kea. All rights reserved.
//

import UIKit

import Firebase
import FirebaseFirestore

class ViewController: UIViewController{
    
    @IBOutlet weak var tableView: UITableView!
        
    let db = Firestore.firestore()

    var notes = [Note]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        
        getCollection()
        syncCollection(name: "WithImg")
    }
    
//FireStore connection and functionality
    
   func getCollection() {
    
        
        
        db.collection("NotesNote")
            .addSnapshotListener { (querySnapshot, error) in
            
            self.notes = []
            
            if let e = error {
                print("Something went wrong. Couldn't get data. \(e)")
            }
            else{
                if let snapshotDocuments = querySnapshot?.documents {
                    for doc in snapshotDocuments {
                        print(doc)
                        print("Looking through database..")
                        let data = doc.data()
        
                        if let noteContent = data["content"] as? String, let noteImage = data["image"] as? String {
                                let newNote = Note(content: noteContent, image: noteImage)
                                self.notes.append(newNote)
                        }
                        else if let noteContent = data["content"] as? String {
                            let anotherNote = Note(content: noteContent, image: "")
                            self.notes.append(anotherNote)
                        }
                                
                                print(doc.data())
                            
                                DispatchQueue.main.async {
                                    self.tableView.reloadData()
                                
                                    let indexPath = IndexPath(row: self.notes.count - 1, section: 0)
                                    self.tableView.scrollToRow(at: indexPath, at: . top, animated: false)
                            }
                        }
                    }
                    print("Did finish looking through database. Cells updated with database documents.")
            }
            }
        }
    
    func syncCollection(name: String){
        let docRef = db.collection("NotesNote").document(name)
        docRef.updateData([
            "image": "images/babyyoda.jpeg"
        ]) { err in
            if let err = err{
                print("Couldn't find image with that name\(err)")
            }
            else{
                print("Database updated")
            }
        }
    }
}

//TableView functionality
extension ViewController: UITableViewDataSource, UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return notes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if notes[indexPath.row].hasImage() {
            if let cell = tableView.dequeueReusableCell(withIdentifier: "firstCell", for: indexPath) as? WithImgTableViewCell {
                
                cell.thisLabel.text = notes[indexPath.row].content
                cell.thisImageView.image = UIImage(named: notes[indexPath.row].image)
                return cell
            }
        }
        else{
            if let cell = tableView.dequeueReusableCell(withIdentifier: "secondCell", for: indexPath) as? WithoutImgTableViewCell{
                cell.thatLabel.text = notes[indexPath.row].content
                return cell
            }
        }
        return UITableViewCell()
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return notes[indexPath.row].hasImage() ? 200 : 80
    }
}
