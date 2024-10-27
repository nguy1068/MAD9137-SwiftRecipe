//
//  RecipeListView.swift
//  MAD9137-SwiftRecipe
//
//  Created by Dat Nguyen(Mike) on 2024-10-24.
//

import SwiftUI

struct RecipeListView: View {
    @EnvironmentObject var recipeData: RecipeData
    @State private var searchText = ""
    @State private var searchMode: SearchMode = .title

    enum SearchMode: String, CaseIterable {
        case title = "Title"
        case ingredients = "Ingredients"
    }

    var body: some View {
        NavigationStack {
            List {
                ForEach(recipeData.recipes.filter { recipe in
                    switch searchMode {
                    case .title:
                        // Filter by title
                        return searchText.isEmpty || recipe.title.localizedStandardContains(searchText)
                    case .ingredients:
                        // Filter by ingredients
                        return searchText.isEmpty || recipe.ingredients.joined(separator: " ").localizedStandardContains(searchText)
                    }
                }) { recipe in NavigationLink(destination: RecipeDetailView(recipe: recipe)) {
                    HStack(alignment: .top , spacing: 20) {
                        GeometryReader { geometry in
                            Image(recipe.thumbnailImagePath ?? "default_recipe")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: geometry.size.height, height: geometry.size.height)
                        }
                        .frame(width: 70, height: 70)

                        VStack(alignment: .leading , spacing: 10) {
                            Text(recipe.title)
                                .font(.headline)
                            Text(recipe.description.count > 50
                                ? String(recipe.description.prefix(50)) + "..."
                                : recipe.description)
                                .font(.subheadline)
                        }
                    }
                }
                }
            }
            .navigationTitle("Recipes")
            .navigationBarTitleDisplayMode(.large)
            .searchable(text: $searchText)
            .toolbar {
                ToolbarItem(placement: .automatic) {
                    NavigationLink(destination: AddRecipeView()) {
                        Text("Add Recipe")
                        Image(systemName: "plus")
                            .font(.headline)
                    }
                }
            }
        }
    }
}

struct RecipeListView_Previews: PreviewProvider {
    static var previews: some View {
        RecipeListView()
    }
}

// TODO: Default recipe
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
