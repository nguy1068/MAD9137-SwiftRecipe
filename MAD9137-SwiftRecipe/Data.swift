//
//  Data.swift
//  MAD9137-SwiftRecipe
//
//  Created by Dat Nguyen(Mike) on 2024-10-24.
//

import SwiftUI

class RecipeData: ObservableObject {
    @Published var recipes: [Recipe] = []
    init() {
        let defaultRecipe = Recipe(
            thumbnailImagePath: nil,
            title: "Pancakes",
            description: "Fluffy and delicious pancakes for breakfast.",
            ingredients: ["1 cup flour", "2 tablespoons sugar", "1 tablespoon baking powder", "1/2 teaspoon salt", "1 cup milk", "1 egg", "2 tablespoons melted butter"],
            steps: [
                "In a bowl, mix flour, sugar, baking powder, and salt.",
                "In another bowl, whisk together milk, egg, and melted butter.",
                "Pour the wet ingredients into the dry ingredients and stir until just combined.",
                "Heat a skillet over medium heat and pour 1/4 cup of batter for each pancake.",
                "Cook until bubbles form on the surface, then flip and cook until golden brown."
            ],
            prepTime: 10,
            cookTime: 60
        )
        recipes.append(defaultRecipe)
    }

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
