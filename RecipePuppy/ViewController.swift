//
//  ViewController.swift
//  RecipePuppy
//
//  Created by Kuba Domaszewicz on 20.10.2017.
//  Copyright © 2017 kdomaszewicz. All rights reserved.
//

import UIKit
import Nuke

class ViewController: UIViewController, UISearchBarDelegate, UITableViewDelegate, UITableViewDataSource, ModelDelegate {
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        model = Model(delegate: self)
        
        let nib = UINib(nibName: "RecipeTableViewCell", bundle: nil)
        tableView?.register(nib, forCellReuseIdentifier: RecipeTableViewCell.identifier)
    }
    
    //-- ModelDelegate ----------------------------------------
    
    func didReceiveNewRecipes() {
        
        tableView?.reloadData()
        
        noResultsLabel?.isHidden = (model.recipes.count != 0)
    }
    
    //-- UISearchBarDelegate ----------------------------------------
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        model.loadRecipe(recipeName: searchText)
    }
    
    //-- UITableViewDelegate ----------------------------------------
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 88
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return model.recipes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: RecipeTableViewCell.identifier, for: indexPath) as! RecipeTableViewCell
        
        let recipe = model.recipes[indexPath.row]
        cell.title?.text = recipe.title
        cell.ingredients?.text = recipe.ingredients
        cell.href?.text = recipe.href
        cell.thumbnail?.image = nil
        if let url = URL(string: recipe.thumbnail) {
            Nuke.loadImage(with: url, into: cell.thumbnail!)
        }
        
        if indexPath.row == model.recipes.count - 1 {
            
            model.loadNextRecipes()
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let controller = storyboard.instantiateViewController(withIdentifier: "RecipeDetailViewController") as! RecipeDetailViewController
 
        controller.recipe = model.recipes[indexPath.row]
        
        navigationController?.pushViewController(controller, animated: true)
    }
    
    //-- Private ----------------------------------------
    
    private var model: Model!
    
    @IBOutlet private var noResultsLabel: UILabel?
    @IBOutlet private var tableView: UITableView?
}

