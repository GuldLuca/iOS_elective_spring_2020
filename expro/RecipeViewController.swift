//
//  RecipeViewController.swift
//  exam_project
//
//  Created by admin on 27/06/2020.
//  Copyright © 2020 kea. All rights reserved.
//

import UIKit
import FirebaseStorage
import FirebaseFirestore

class RecipeViewController: UIViewController {
    
    
    @IBOutlet var tableView: UITableView!
    
    let db = Firestore.firestore()
    var recipes = [RevoRecipe]()
    
    var valToPass = ""

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        getCollection()
        // Do any additional setup after loading the view.
    }
    
    func getCollection() {
        
        db.collection("revorecipes")
            .addSnapshotListener { (querySnapshot, error) in
            
            self.recipes = []
            
            if let e = error {
                print("Something went wrong. Couldn't get data. \(e)")
            }
            else{
                if let snapshotDocuments = querySnapshot?.documents {
                    for doc in snapshotDocuments {
                        let data = doc.data()
                        if let recTitle = data["title"] as? String, let recIngredients = data["ingredients"] as? [String]{
                            let newRecipe = RevoRecipe(title: recTitle, ingredients: recIngredients)
                            self.recipes.append(newRecipe)
                            
                            DispatchQueue.main.async {
                                self.tableView.reloadData()
                                
                                let indexPath = IndexPath(row: self.recipes.count - 1, section: 0)
                                self.tableView.scrollToRow(at: indexPath, at: . top, animated: false)
                            }
                        }
                    }
            }
            }
        }
    }


}

extension RecipeViewController: UITableViewDataSource, UITableViewDelegate{
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if  segue.identifier == "detailSegue",
            let destination = segue.destination as? DetailVC,
            let recipeIndex = tableView.indexPathForSelectedRow?.row
        {
            destination.valPassed = recipes[recipeIndex].title
            
            let ingredients = recipes[recipeIndex].ingredients
            
            for ingredient in ingredients{
                
                destination.arrayValPassed.append(ingredient)
                
            }
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return recipes.count
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let recipe = recipes[indexPath.row]
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! RecipeTableViewCell
        
        cell.recipeLabel.text = recipe.title
        
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath){
        tableView.deselectRow(at: indexPath, animated: true)
        
        let row = indexPath.row
        print(recipes[row])
    }
    
}
