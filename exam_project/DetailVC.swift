//
//  DetailVC.swift
//  exam_project
//
//  Created by admin on 27/06/2020.
//  Copyright © 2020 kea. All rights reserved.
//

import UIKit
import FirebaseFirestore
import FirebaseStorage

class DetailVC: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet var tableView: UITableView!
    @IBOutlet var imgView: UIImageView!
    @IBOutlet var titleLabel: UILabel!
    
    var rowsChecked = [NSIndexPath]()

    var revoRecipes = [RevoRecipe]()
    let aRecipe = RevoRecipe()
    
    var valPassed = String()
    var arrayValPassed = [String]()
    
    var firebaseManager: FirebaseManager?
    
    let db = Firestore.firestore()
        
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        titleLabel.text = valPassed
        firebaseManager = FirebaseManager(parentVC: ViewController())
        firebaseManager?.getImg(name: valPassed, vc: self)
        tableView.allowsMultipleSelection = true
        styleTheDetail()
        tableView.tableFooterView = UIView(frame: CGRect.zero)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrayValPassed.count
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let ingredient = arrayValPassed[indexPath.row]
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "ingredientCell", for: indexPath) as! IngredientTableViewCell
        
       cell.ingredientLabel.text = ingredient
        
    
        let isRowChecked = rowsChecked.contains(indexPath as NSIndexPath)
        
        if(isRowChecked == true)
        {
            cell.checkbox.isChecked = true
            cell.checkbox.buttonClicked(sender: cell.checkbox)
        }else{
            cell.checkbox.isChecked = false
            cell.checkbox.buttonClicked(sender: cell.checkbox)
        }
        
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath as IndexPath) as! IngredientTableViewCell
        
        if(rowsChecked.contains(indexPath as NSIndexPath) == false){
            cell.checkbox.isChecked = true
            cell.checkbox.buttonClicked(sender: cell.checkbox)
            
        }
    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath as IndexPath) as! IngredientTableViewCell
        cell.checkbox.isChecked = false
        cell.checkbox.buttonClicked(sender: cell.checkbox)
        // remove the indexPath from rowsWhichAreCheckedArray
        if let checkedItemIndex = rowsChecked.firstIndex(of: indexPath as NSIndexPath){
            rowsChecked.remove(at: checkedItemIndex)
        }
        
    }
    
    func styleTheDetail(){
        
        imgView.layer.borderColor = UIColor.black.cgColor
        imgView.layer.borderWidth = 2
        imgView.layer.cornerRadius = 5
        tableView.layer.borderColor = UIColor.red.cgColor
        tableView.layer.borderWidth = 2
        tableView.layer.cornerRadius = 5
    }
}
