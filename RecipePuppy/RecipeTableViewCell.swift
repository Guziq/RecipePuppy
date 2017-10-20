//
//  RecipeTableViewCell.swift
//  RecipePuppy
//
//  Created by Kuba Domaszewicz on 20.10.2017.
//  Copyright © 2017 kdomaszewicz. All rights reserved.
//

import UIKit

class RecipeTableViewCell: UITableViewCell {
    
    static let identifier = "recipeCell"
    
    @IBOutlet var title: UILabel?
    @IBOutlet var href: UILabel?
    @IBOutlet var ingredients: UILabel?
    @IBOutlet var thumbnail: UIImageView?
}
