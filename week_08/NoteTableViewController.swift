//
//  NoteTableViewController.swift
//  week_08
//
//  Created by admin on 27/02/2020.
//  Copyright © 2020 Rabotnik. All rights reserved.
//

import UIKit
import os.log

class NoteTableViewController: UITableViewController {

    var notes = [Note]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let savedNotes = loadNotes() {
            notes += savedNotes
        }
        else{
        loadSampleNotes()
        }
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return notes.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
     
        let cellIdentifier = "NoteTableViewCell"
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? NoteTableViewCell else{
            fatalError("The dequeued cell is not an instance of NoteTableViewCell.")
        }
        
        let note = notes[indexPath.row]
        
        cell.name_label.text = note.name

        return cell
    }

    @IBAction func unwindToNoteList(sender: UIStoryboardSegue) {

        if let sourceViewController = sender.source as? NoteViewController, let note = sourceViewController.note {
            
            let newIndexPath = IndexPath(row: notes.count, section: 0)
            
            notes.append(note)
            
            tableView.insertRows(at: [newIndexPath], with: .automatic)
            saveNotes()
        }
        


    }



    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let selectedPath = tableView.indexPathForSelectedRow else { return }
        if let target = segue.destination as? DetailViewController {
            let note = notes[selectedPath.row]
            target.noteContent = note.content
        }
    }
    
    
    private func loadSampleNotes() {

        guard let note_1 = Note(name: "First Note", content: "First Note") else {
            fatalError("Unable to instantiate note_1")
        }
         
        guard let note_2 = Note(name: "Second Note", content: "Second Note") else {
            fatalError("Unable to instantiate note_2")
        }
         
        guard let note_3 = Note(name: "Third Note", content: "Third Note") else {
            fatalError("Unable to instantiate note_3")
        }
        
        notes += [note_1, note_2, note_3]

    }
    
    

    private func saveNotes() {
        let fullPath = getDocumentsDirectory().appendingPathComponent("notes")
        do{
            let data = try NSKeyedArchiver.archivedData(withRootObject: notes, requiringSecureCoding: false)
            try data.write(to: fullPath)
            os_log("Notes succesfully saved", log: OSLog.default, type: .debug)
        } catch {
            os_log("Failed to save notes", log: OSLog.default, type: .error)
        }
    }
    
    func getDocumentsDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }
    
    private func loadNotes() -> [Note]? {
        let fullPath = getDocumentsDirectory().appendingPathComponent("notes")
        if let nsData = NSData(contentsOf: fullPath){
        do {
            let data = Data(referencing: nsData)
            if let loadedNotes = try NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(data) as? Array<Note> {
                return loadedNotes
            }
            
        }catch {
                print("Couldn't read file")
                return nil
            }
        }
        return nil
    }
    }
