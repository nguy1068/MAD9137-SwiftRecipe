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
            VStack(spacing: 0) {
                HStack {
                    Spacer()
                    Menu {
                        Picker("Search Mode", selection: $searchMode) {
                            ForEach(SearchMode.allCases, id: \.self) { mode in
                                Text("Search by \(mode.rawValue)").tag(mode)
                            }
                        }
                    } label: {
                        HStack {
                            Text("Search by \(searchMode.rawValue)")
                                .font(.caption)
                            Image(systemName: "chevron.down")
                                .font(.caption)
                        }
                        .foregroundColor(.gray)
                    }
                    .padding(.trailing)
                }
                .padding(.bottom, 12)
                List {
                    ForEach(recipeData.recipes.filter { recipe in
                        if searchText.isEmpty {
                            return true
                        }

                        switch searchMode {
                        case .title:
                            return recipe.title.localizedStandardContains(searchText)
                        case .ingredients:
                            let searchWords = searchText.components(separatedBy: .whitespaces)
                            return searchWords.allSatisfy { searchWord in
                                recipe.ingredients.contains { ingredient in
                                    ingredient.localizedStandardContains(searchWord)
                                }
                            }
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
            }
            .navigationTitle("Recipes")
            .navigationBarTitleDisplayMode(.large)
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    NavigationLink(destination: AddRecipeView()) {
                        Text("Add Recipe")
                        Image(systemName: "plus")
                            .font(.headline)
                    }
                }
            }
            .searchable(text: $searchText, prompt: "Search by \(searchMode.rawValue.lowercased())...")
        }
    }
}

struct RecipeListView_Previews: PreviewProvider {
    static var previews: some View {
        RecipeListView()
    }
}
