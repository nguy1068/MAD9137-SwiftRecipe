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
    
    @State private var recipeTitle: String
    @State private var recipeDescription: String
    @State private var recipeIngredients: [String]
    @State private var recipeSteps: [String]
    @State private var recipePrepTime: Int
    @State private var recipeCookTime: Int
    @State private var thumbnailImage: Image?
    @State private var selectedItem: PhotosPickerItem?
    @State private var inputImage: UIImage?
    @State private var navigateToRecipeListView: Bool = false
    
    init(recipe: Recipe) {
        self.recipe = recipe
        
        // Initialize state variables with existing recipe data
        _recipeTitle = State(initialValue: recipe.title)
        _recipeDescription = State(initialValue: recipe.description)
        _recipeIngredients = State(initialValue: recipe.ingredients)
        _recipeSteps = State(initialValue: recipe.steps)
        _recipePrepTime = State(initialValue: recipe.prepTime)
        _recipeCookTime = State(initialValue: recipe.cookTime)
        
        // Load existing image if available
        if let imagePath = recipe.thumbnailImagePath,
           let uiImage = loadImage(for: recipe) ?? UIImage(named: recipe.thumbnailImagePath ?? "default_recipe")
        {
            _inputImage = State(initialValue: uiImage)
            _thumbnailImage = State(initialValue: Image(uiImage: uiImage))
        }
    }
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack {
                    // PhotoPicker
                    PhotosPicker(
                        selection: $selectedItem,
                        matching: .images,
                        photoLibrary: .shared()
                    ) {
                        VStack {
                            if let thumbnail = thumbnailImage {
                                thumbnail
                                    .resizable()
                                    .scaledToFit()
                                    .frame(height: 200)
                                    .cornerRadius(8)
                            } else {
                                Image(systemName: "photo")
                                    .font(.system(size: 44))
                            }
                            Spacer()
                            Text("Select a Recipe Image")
                                .font(.subheadline)
                                .foregroundColor(.blue)
                        }
                        .padding()
                        .frame(maxWidth: .infinity)
                        .overlay(
                            RoundedRectangle(cornerRadius: 8)
                                .stroke(style: StrokeStyle(lineWidth: 2, dash: [5]))
                                .foregroundColor(.blue)
                        )
                    }
                    .padding()
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
                        
                    // Title
                    TextInput(label: "Title", placeholder: "Enter recipe title", text: $recipeTitle).padding(.bottom)
                    
                    // Description
                    TextInput(label: "Description", placeholder: "Enter a brief description", text: $recipeDescription).padding(.bottom)
                    
                    // Ingredients
                    IngredientListView(ingredients: $recipeIngredients).padding(.bottom)
                
                    // Steps
                    StepsListView(steps: $recipeSteps).padding(.bottom)
    
                    // Time inpuy
                    VStack {
                        TimeInputView(timeValue: $recipePrepTime, label: "Prep Time (mins)")
                        TimeInputView(timeValue: $recipeCookTime, label: "Cook Time (mins)")
                    }
                    
                    Button(action: {
                        if let index = recipeData.recipes.firstIndex(where: { $0.title == recipe.title }) {
                            recipeData.recipes.remove(at: index)
                        }
                        navigateToRecipeListView = true
                    }) {
                        Text("Delete Recipe")
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color.red)
                            .cornerRadius(8)
                    }
                    .padding()
                    
                    NavigationLink(destination: RecipeListView(), isActive: $navigateToRecipeListView) {
                        EmptyView()
                    }
                }
            }
            .navigationTitle("Edit Recipe")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
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
                        
                        navigateToRecipeListView = true
                        
                    }) {
                        Text("Save")
                    }
                }
            }
        }
    }
}
