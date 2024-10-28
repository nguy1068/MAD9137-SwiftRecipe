//
//  AddRecipeView.swift
//  MAD9137-SwiftRecipe
//
//  Created by Dat Nguyen(Mike) on 2024-10-24.
//

import PhotosUI
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
    @State private var selectedItem: PhotosPickerItem?

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
                    // PhotoPicker
                    PhotosPicker(
                        selection: $selectedItem,
                        matching: .images,
                        photoLibrary: .shared()
                    ) {
                        Text("Select a Recipe Image")
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color.blue.opacity(0.2))
                            .cornerRadius(8)
                    }
                    .onChange(of: selectedItem) { newItem in
                        guard let newItem = newItem else { return }
                        Task {
                            if let data = try? await newItem.loadTransferable(type: Data.self),
                               let uiImage = UIImage(data: data)
                            {
                                inputImage = uiImage
                                thumbnailImage = Image(uiImage: uiImage)
                            }
                        }
                    }

                    // Display selected image
                    if let thumbnail = thumbnailImage {
                        thumbnail
                            .resizable()
                            .scaledToFit()
                            .frame(height: 200)
                            .cornerRadius(8)
                            .padding(.top)
                    }
                }
            }
            .toolbar {
                ToolbarItem(placement: .automatic) {
                    Button("Save") {
                        var newRecipe = Recipe(
                            thumbnailImagePath: nil,
                            title: recipeTitle,
                            description: recipeDescription,
                            ingredients: recipeIngredients,
                            steps: recipeSteps,
                            prepTime: recipePrepTime,
                            cookTime: recipeCookTime
                        )

                        if let image = inputImage {
                            let imagePath = saveImage(image: image, for: newRecipe) ?? "default_recipe"
                            newRecipe.thumbnailImagePath = imagePath
                        } else {
                            newRecipe.thumbnailImagePath = "default_recipe"
                        }

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
