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
        print(arrayValPassed)
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
        
        return cell
        
    }
    
    /*func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath){
        tableView.deselectRow(at: indexPath, animated: true)
        
        let row = indexPath.row
        print(revoRecipes[row])
    }*/
}
