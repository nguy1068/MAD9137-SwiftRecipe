//
//  RecipeDetailView.swift
//  MAD9137-SwiftRecipe
//
//  Created by Dat Nguyen(Mike) on 2024-10-24.
//

import SwiftUI

struct RecipeDetailView: View {
    var recipe: Recipe

    var body: some View {
        VStack {
            Text(recipe.title)
                .font(.largeTitle)
            Text(recipe.description)
                .font(.body)
            // You can add more UI elements to display the recipe details
        }
        .navigationTitle(recipe.title)
    }
}

// TODO: Display the full title, ingredients, and steps of the selected recipe.

// TODO: Use a ScrollView to ensure all content is visible, even if the recipe is long.

// TODO: Make sure at least one of your sample recipes is long enough to demonstrate that ScrollView works.
