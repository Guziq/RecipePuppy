//
//  RecipeDetailViewController.swift
//  RecipePuppy
//
//  Created by Kuba Domaszewicz on 20.10.2017.
//  Copyright © 2017 kdomaszewicz. All rights reserved.
//

import UIKit
import Nuke

class RecipeDetailViewController: UIViewController {
    
    /// TODO: Encapsulate!
    var recipe: Recipe?
    
    override func viewDidLoad() {
        
        if let r = recipe {
            
            title_?.text = r.title
            ingredients?.text = r.ingredients
            href?.text = r.href
            print(r.thumbnail)
            if let url = URL(string: r.thumbnail) {
                Nuke.loadImage(with: url, into: thumbnail!)
            }
        }
    }
    
    //-- Private ----------------------------------------
    
    @IBOutlet private var thumbnail: UIImageView?
    @IBOutlet private var title_: UILabel?
    @IBOutlet private var ingredients: UITextView?
    @IBOutlet private var href: UITextView?
}
