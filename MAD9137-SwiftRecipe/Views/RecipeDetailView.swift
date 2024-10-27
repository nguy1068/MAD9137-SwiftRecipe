//
//  RecipeDetailView.swift
//  MAD9137-SwiftRecipe
//
//  Created by Dat Nguyen(Mike) on 2024-10-24.
//

import SwiftUI

struct RecipeDetailView: View {
    var recipe: Recipe
    @State private var completedSteps: [Bool] = [] // State for checked steps
    init(recipe: Recipe) {
        self.recipe = recipe
        _completedSteps = State(initialValue: Array(repeating: false, count: recipe.steps.count))
    }

    var body: some View {
        ScrollView {
            VStack(alignment: .leading) {
                // Prep and Cook Time Chips
                HStack {
                    ChipView(label: "\(recipe.prepTime) mins", systemImage: "hourglass")
                    ChipView(label: "\(recipe.cookTime) mins", systemImage: "flame")
                }
                .padding(.bottom)

                // Image with 16:9 ratio
                Image(recipe.thumbnailImagePath ?? "default_recipe")
                    .resizable()
                    .aspectRatio(16 / 9, contentMode: .fit)
                    .padding(.bottom)

                Text(recipe.description)
                    .font(.body)
                    .padding(.bottom)

                // Ingredients
                Text("Ingredients:")
                    .font(.title2)
                    .padding(.bottom)

                ForEach(recipe.ingredients, id: \.self) { ingredient in
                    Text("• \(ingredient)")
                        .padding(.bottom, 2)
                }

                // Steps with Checkboxes
                Text("Steps:")
                    .font(.title2)
                    .padding(.bottom)

                ForEach(Array(recipe.steps.enumerated()), id: \.offset) { index, step in
                    HStack {
                        Button(action: {
                            completedSteps[index].toggle()
                        }) {
                            Image(systemName: completedSteps[index]
                                ? "checkmark.square.fill"
                                : "checkmark.square")
                        }
                        Text(step)
                    }
                    .padding(.bottom, 2)
                }
            }
            .padding()
        }
        .navigationTitle(recipe.title)
        .onAppear {
            completedSteps = Array(repeating: false, count: recipe.steps.count)
        }
    }
}

