//
//  Data.swift
//  MAD9137-SwiftRecipe
//
//  Created by Dat Nguyen(Mike) on 2024-10-24.
//

import SwiftUI

class RecipeData: ObservableObject {
    @Published var recipes: [Recipe] = [defaultRecipe]

    // Function to add a new recipe
    func addNewRecipe(recipe: Recipe) {
        recipes.append(recipe)
    }

    // Function to edit an existing recipe
    func editRecipe(at index: Int, with updatedRecipe: Recipe) {
        recipes[index] = updatedRecipe
    }

    // Function to delete a recipe
    func deleteRecipe(at index: Int) {
        recipes.remove(at: index)
    }
}
