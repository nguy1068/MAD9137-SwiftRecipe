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
                        return searchText.isEmpty || recipe.title.localizedStandardContains(searchText)
                    case .ingredients:
                        return searchText.isEmpty || recipe.ingredients.joined(separator: " ").localizedStandardContains(searchText)
                    }
                }) { recipe in
                    NavigationLink(destination: RecipeDetailView(recipe: recipe)) {
                        HStack(alignment: .top, spacing: 20) {
                            let uiImage = loadImage(for: recipe) ?? UIImage(named: "default_recipe")
                            Image(uiImage: uiImage!)
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .frame(width: 70, height: 70)
                                .cornerRadius(8)
                                .clipped()

                            VStack(alignment: .leading, spacing: 10) {
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
