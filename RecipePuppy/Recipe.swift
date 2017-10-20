//
//  Recipe.swift
//  RecipePuppy
//
//  Created by Kuba Domaszewicz on 20.10.2017.
//  Copyright © 2017 kdomaszewicz. All rights reserved.
//

import Foundation

import Moya_Argo
import Argo
import Curry
import Runes

struct Recipe: Decodable {
    
    let title: String
    let href: String
    let ingredients: String
    let thumbnail: String
    
    static func decode(_ json: JSON) -> Decoded<Recipe> {
        return curry(Recipe.init)
            <^> json <| "title"
            <*> json <| "href"
            <*> json <| "ingredients"
            <*> json <| "thumbnail"
    } 
}
