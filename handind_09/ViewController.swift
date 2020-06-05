//
//  ViewController.swift
//  mandatory9
//
//  Created by admin on 03/06/2020.
//  Copyright © 2020 kea. All rights reserved.
//

import UIKit

import FirebaseCore
import FirebaseFirestore

class ViewController: UIViewController{
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var noteTextField: UITextField!
    @IBOutlet weak var noteTextView: UITextView!
    
    let db = Firestore.firestore()

    var notes: [Note] = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        title = C.appName
        navigationItem.hidesBackButton = true
        
        tableView.register(UINib(nibName: C.cellName, bundle: nil), forCellReuseIdentifier: C.cellIdentifier)
        
        getCollection()
    }
    
    func getCollection() {
        
        db.collection(C.FStore.collName)
            .addSnapshotListener { (querySnapshot, error) in
            
            self.notes = []
            
            if let e = error {
                print("Something went wrong. Couldn't get data. \(e)")
            }
            else{
                if let snapshotDocuments = querySnapshot?.documents {
                    for doc in snapshotDocuments {
                        let data = doc.data()
                        if let noteTitle = data[C.FStore.titleField] as? String, let noteContent = data[C.FStore.contentField] as? String {
                            let newNote = Note(title: noteTitle, content: noteContent)
                            self.notes.append(newNote)
                            
                            DispatchQueue.main.async {
                                self.tableView.reloadData()
                                
                                let indexPath = IndexPath(row: self.notes.count - 1, section: 0)
                                self.tableView.scrollToRow(at: indexPath, at: . top, animated: false)
                            }
                        }
                    }
            }
            }
        }
    }
    
    @IBAction func addNote(_ sender: Any) {
        if let noteTitle = noteTextField.text, let noteContent = noteTextView.text{
            db.collection(C.FStore.collName).addDocument(data:[
                C.FStore.titleField: noteTitle,
                C.FStore.contentField: noteContent
            ])
            { (error) in
                if let e = error{
                    print("Something went wrong. Could'nt save data in FireStore. \(e)")
                }
                else{
                    print("Success! Data saved in FireStore")
                    
                    DispatchQueue.main.async {
                        self.noteTextField.text = ""
                        self.noteTextView.text = ""
                    }
                }
            }
        }
    }
}
extension ViewController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return notes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let note = notes[indexPath.row]
        
        let cell = tableView.dequeueReusableCell(withIdentifier: C.cellIdentifier, for: indexPath) as! NoteCell
        
        cell.label.text = note.title
        cell.noteContent.text = note.content
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
        let noteToDelete = notes[indexPath.row]
        
        if (editingStyle == UITableViewCell.EditingStyle.delete){
            
            notes.remove(at: indexPath.row)
            
            tableView.deleteRows(at: [indexPath], with: UITableView.RowAnimation.automatic)
            
            let noteId = noteToDelete.title
            
            db.collection(C.FStore.collName).whereField("title", isEqualTo: noteId).getDocuments { (querySnapshot, error) in
                
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
