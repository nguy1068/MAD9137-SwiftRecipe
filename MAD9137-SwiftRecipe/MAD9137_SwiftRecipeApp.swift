//
//  MAD9137_SwiftRecipeApp.swift
//  MAD9137-SwiftRecipe
//
//  Created by Dat Nguyen(Mike) on 2024-10-24.
//

import SwiftUI

@main
struct MAD9137_SwiftRecipeApp: App {
    @StateObject private var recipeData = RecipeData()
    var body: some Scene {
        WindowGroup {
            RecipeListView()
                .environmentObject(recipeData)
        }
    }
}
