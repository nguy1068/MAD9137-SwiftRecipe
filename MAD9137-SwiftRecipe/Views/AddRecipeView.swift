//
//  AddRecipeView.swift
//  MAD9137-SwiftRecipe
//
//  Created by Dat Nguyen(Mike) on 2024-10-24.
//

import SwiftUI

struct AddRecipeView: View {
    
    @EnvironmentObject var recipeData: RecipeData
    @Environment(\.dismiss) var dismiss: DismissAction
    
    @State private var recipeTitle: String = ""
    @State private var recipeDescription: String = ""
    @State private var recipeIngredients: [String] = []
    @State private var recipeSteps: [String] = []
    @State private var recipePrepTime: Int = 0
    @State private var recipeCookTime: Int = 0
    @State private var showingImagePicker: Bool = false
    @State private var inputImage: UIImage?
    @State private var thumbnailImage: Image?


    var body: some View {
        NavigationStack {
            ScrollView {
                VStack {
                    // Recipe Title
                    TextInput(label: "Title", placeholder: "Enter recipe title", text: $recipeTitle)
                    // Recipe Description
                    TextInput(label: "Description", placeholder: "Enter a brief description", text: $recipeDescription)
                    // Ingredients
                    IngredientListView(ingredients: $recipeIngredients)
                    // Steps
                    StepsListView(steps: $recipeSteps)
                    // Times
                    VStack {
                        TimeInputView(timeValue: $recipePrepTime, label: "Prep Time (mins)")
                        TimeInputView(timeValue: $recipeCookTime, label: "Cook Time (mins)")
                    }
                }
            }
            .toolbar {
                ToolbarItem(placement: .automatic) {
                    Button("Save") {
                        let newRecipe = Recipe(
                            title: recipeTitle,
                            description: recipeDescription,
                            ingredients: recipeIngredients,
                            steps: recipeSteps,
                            prepTime: recipePrepTime,
                            cookTime: recipeCookTime
                        )
                        recipeData.addNewRecipe(recipe: newRecipe)
                        dismiss()
                    }
                    .font(.headline)
                    .foregroundColor(.blue)
                }
            }
        }
    }
}

struct AddRecipeView_Previews: PreviewProvider {
    static var previews: some View {
        AddRecipeView()
           
    }
}
