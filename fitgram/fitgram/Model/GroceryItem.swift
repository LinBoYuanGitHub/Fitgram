//
//  GroceryItem.swift
//  PhotoAlbumFullAnalysis
//
//  Created by boyuan lin on 11/10/19.
//  Copyright © 2019 boyuan lin. All rights reserved.
//

import Foundation

struct GroceryItem {
    public var groceryItemId = 0
    public var dishImageUrl = ""
    public var dishTitle = ""
    public var ingredientList = [IngredientModel]()
    public var isChecked  = true
}
