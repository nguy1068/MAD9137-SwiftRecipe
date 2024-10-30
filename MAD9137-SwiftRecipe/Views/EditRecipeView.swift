//
//  EditRecipeView.swift
//  MAD9137-SwiftRecipe
//
//  Created by Dat Nguyen(Mike) on 2024-10-24.
//

import PhotosUI
import SwiftUI

struct EditRecipeView: View {
    var recipe: Recipe
    @EnvironmentObject var recipeData: RecipeData
    @Environment(\.dismiss) var dismiss
    
    @State private var recipeTitle: String
    @State private var recipeDescription: String
    @State private var recipeIngredients: [String]
    @State private var recipeSteps: [String]
    @State private var recipePrepTime: Int
    @State private var recipeCookTime: Int
    @State private var thumbnailImage: Image?
    @State private var selectedItem: PhotosPickerItem?
    @State private var inputImage: UIImage?
    
    init(recipe: Recipe) {
        self.recipe = recipe
        _recipeTitle = State(initialValue: recipe.title)
        _recipeDescription = State(initialValue: recipe.description)
        _recipeIngredients = State(initialValue: recipe.ingredients)
        _recipeSteps = State(initialValue: recipe.steps)
        _recipePrepTime = State(initialValue: recipe.prepTime)
        _recipeCookTime = State(initialValue: recipe.cookTime)
        
        if let imagePath = recipe.thumbnailImagePath,
           let uiImage = loadImage(for: recipe)
        {
            _inputImage = State(initialValue: uiImage)
            _thumbnailImage = State(initialValue: Image(uiImage: uiImage))
        }
    }
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack {
                    TextInput(label: "Title", placeholder: "Enter recipe title", text: $recipeTitle)
                    
                    TextInput(label: "Description", placeholder: "Enter a brief description", text: $recipeDescription)
                    
                    IngredientListView(ingredients: $recipeIngredients)
                    
                    StepsListView(steps: $recipeSteps)
                    
                    VStack {
                        TimeInputView(timeValue: $recipePrepTime, label: "Prep Time (mins)")
                        TimeInputView(timeValue: $recipeCookTime, label: "Cook Time (mins)")
                    }
                    
                    PhotosPicker(
                        selection: $selectedItem,
                        matching: .images,
                        photoLibrary: .shared()
                    ) {
                        if let thumbnailImage {
                            thumbnailImage
                                .resizable()
                                .scaledToFit()
                                .frame(height: 200)
                        } else {
                            Text("Select a Recipe Image")
                                .frame(maxWidth: .infinity)
                                .padding()
                                .background(Color.blue.opacity(0.2))
                                .cornerRadius(8)
                        }
                    }
                    .onChange(of: selectedItem) { newItem in
                        Task {
                            if let data = try? await newItem?.loadTransferable(type: Data.self),
                               let uiImage = UIImage(data: data)
                            {
                                inputImage = uiImage
                                thumbnailImage = Image(uiImage: uiImage)
                            }
                        }
                    }
                    
                    Button(action: {
                        // Create updated recipe
                        var updatedRecipe = Recipe(
                            thumbnailImagePath: recipe.thumbnailImagePath,
                            title: recipeTitle,
                            description: recipeDescription,
                            ingredients: recipeIngredients,
                            steps: recipeSteps,
                            prepTime: recipePrepTime,
                            cookTime: recipeCookTime
                        )
                        
                        // Save new image if selected
                        if let inputImage = inputImage {
                            if let imagePath = saveImage(image: inputImage, for: updatedRecipe) {
                                updatedRecipe.thumbnailImagePath = imagePath
                            }
                        }
                        
                        // Find index of recipe to update
                        if let index = recipeData.recipes.firstIndex(where: { $0.title == recipe.title }) {
                            recipeData.editRecipe(at: index, with: updatedRecipe)
                        }
                        
                        dismiss()
                    }) {
                        Text("Save Changes")
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color.blue)
                            .foregroundColor(.white)
                            .cornerRadius(8)
                    }
                    .padding(.top)
                }
                .padding()
            }
            .navigationTitle("Edit Recipe")
        }
    }
}
