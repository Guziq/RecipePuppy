//
//  ViewControllerModel.swift
//  RecipePuppy
//
//  Created by Kuba Domaszewicz on 20.10.2017.
//  Copyright © 2017 kdomaszewicz. All rights reserved.
//

import Foundation
import Moya

protocol ModelDelegate {
    
    func didReceiveNewRecipes()
}

class Model {
    
    //-- Public ----------------------------------------
    
    private(set) var recipes: [Recipe] = []
    
    init( delegate: ModelDelegate ) {
        
        self.delegate = delegate
    }
    
    func loadRecipe( recipeName: String ) {
        
        request?.cancel()
        recipes = []
        self.recipeName = recipeName
        currentPage = 0
        
        if recipeName != "" { downloadRecipes(page: currentPage) }
        else { delegate.didReceiveNewRecipes() }
    }
    
    func loadNextRecipes() {
        
        currentPage += 1
        downloadRecipes(page: currentPage)
    }
    
    //-- Private ----------------------------------------
    
    private var delegate: ModelDelegate
    
    private var request: Moya.Cancellable?
    
    private var recipeName: String = ""
    
    private var currentPage = 0
    
    private func downloadRecipes(page: Int) {
        
        request = defaultRequest(recipePuppy: .GetRecipe(query: recipeName, page: page+1), completion: { result in
            
            if case let .success(response) = result {
                
                let queryResult: QueryResult = try! response.mapObject()
                
                if( queryResult.results.count > 0 ) {
                    
                    self.recipes += queryResult.results
                    
                    self.delegate.didReceiveNewRecipes()
                }
                
            } else if case .failure(_) = result {
                
                /// TODO: Handle failure
            }
        })
    }
}
