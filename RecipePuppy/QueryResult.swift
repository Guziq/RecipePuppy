//
//  QueryResult.swift
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

struct QueryResult: Decodable {
    
    let title: String
    let version: Float
    let href: String
    let results: [Recipe]
    
    static func decode(_ json: JSON) -> Decoded<QueryResult> {
        return curry(self.init)
            <^> json <| "title"
            <*> json <| "version"
            <*> json <| "href"
            <*> json <|| "results"
    }
}
