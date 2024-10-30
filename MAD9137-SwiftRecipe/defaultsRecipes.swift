//
//  defaultsRecipes.swift
//  MAD9137-SwiftRecipe
//
//  Created by Dat Nguyen(Mike) on 2024-10-30.
//

import Foundation

struct DefaultRecipes {
    static let all: [Recipe] = [
        
        Recipe(
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
            cookTime: 15
        ),
        
        Recipe(
            thumbnailImagePath: nil,
            title: "Spaghetti Carbonara",
            description: "Classic Italian pasta dish with eggs, cheese, pancetta, and black pepper.",
            ingredients: ["1 pound spaghetti", "4 oz pancetta", "4 eggs", "1 cup Pecorino Romano", "1 cup Parmigiano-Reggiano", "Black pepper", "Salt"],
            steps: [
                "Cook pasta in salted water according to package instructions.",
                "Crisp pancetta in a large pan.",
                "Whisk eggs and cheese in a bowl.",
                "Toss hot pasta with pancetta, then quickly stir in egg mixture.",
                "Season with black pepper and serve immediately."
            ],
            prepTime: 15,
            cookTime: 20
        ),
        
        Recipe(
        thumbnailImagePath: nil,
        title: "Chicken Alfredo",
        description: "Creamy pasta dish made with fettuccine, chicken, and a rich Alfredo sauce.",
        ingredients: ["1 pound fettuccine", "2 chicken breasts", "1 cup heavy cream", "1 cup Parmesan cheese", "2 tablespoons butter", "Garlic", "Salt", "Black pepper"],
        steps: [
        "Cook fettuccine according to package instructions.",
        "Sauté garlic in butter, then add chicken until cooked through.",
        "Stir in heavy cream and Parmesan cheese until smooth.",
        "Combine pasta with sauce and chicken.",
        "Season with salt and pepper before serving."
        ],
        prepTime: 10,
        cookTime: 20
        ),
        
        Recipe(
        thumbnailImagePath: nil,
        title: "Vegetable Stir-Fry",
        description: "Quick and colorful stir-fry with a variety of fresh vegetables.",
        ingredients: ["2 cups mixed vegetables (bell peppers, broccoli, carrots)", "2 tablespoons soy sauce", "1 tablespoon sesame oil", "1 teaspoon ginger", "1 teaspoon garlic", "Cooked rice or noodles"],
        steps: [
        "Heat sesame oil in a pan.",
        "Add garlic and ginger, sauté for 1 minute.",
        "Add mixed vegetables and stir-fry until tender.",
        "Pour in soy sauce and mix well.",
        "Serve over cooked rice or noodles."
        ],
        prepTime: 10,
        cookTime: 10
        ),
        
        Recipe(
        thumbnailImagePath: nil,
        title: "Beef Tacos",
        description: "Flavorful tacos filled with seasoned ground beef and fresh toppings.",
        ingredients: ["1 pound ground beef", "Taco seasoning", "Taco shells", "Lettuce", "Tomato", "Cheese", "Sour cream"],
        steps: [
        "Cook ground beef in a skillet until browned.",
        "Add taco seasoning and water; simmer until thickened.",
        "Fill taco shells with beef mixture.",
        "Top with lettuce, tomato, cheese, and sour cream.",
        "Serve immediately."
        ],
        prepTime: 10,
        cookTime: 15
        ),
        
        Recipe(
        thumbnailImagePath: nil,
        title: "Caprese Salad",
        description: "Fresh salad with mozzarella, tomatoes, basil, and a drizzle of balsamic vinegar.",
        ingredients: ["Fresh mozzarella", "Tomatoes", "Fresh basil", "Olive oil", "Balsamic vinegar", "Salt", "Pepper"],
        steps: [
        "Slice mozzarella and tomatoes.",
        "Layer mozzarella, tomatoes, and basil on a plate.",
        "Drizzle with olive oil and balsamic vinegar.",
        "Season with salt and pepper.",
        "Serve chilled."
        ],
        prepTime: 10,
        cookTime: 0
        ),
        
        Recipe(
        thumbnailImagePath: nil,
        title: "Shrimp Scampi",
        description: "Succulent shrimp sautéed in garlic, butter, and white wine served over pasta.",
        ingredients: ["1 pound shrimp", "8 oz linguine", "4 cloves garlic", "1/2 cup white wine", "1/4 cup butter", "Parsley", "Lemon juice", "Salt", "Pepper"],
        steps: [
        "Cook linguine according to package instructions.",
        "Sauté garlic in butter until fragrant.",
        "Add shrimp and cook until pink.",
        "Pour in white wine and simmer for 2 minutes.",
        "Toss with linguine, parsley, and lemon juice before serving."
        ],
        prepTime: 10,
        cookTime: 10
        ),
        
        Recipe(
        thumbnailImagePath: nil,
        title: "Chili Con Carne",
        description: "Hearty stew made with ground beef, beans, and spices.",
        ingredients: ["1 pound ground beef", "1 can kidney beans", "1 can diced tomatoes", "1 onion", "Chili powder", "Cumin", "Salt", "Pepper"],
        steps: [
        "Cook onion and ground beef in a pot until browned.",
        "Add kidney beans, diced tomatoes, and spices.",
        "Simmer for 30 minutes.",
        "Serve hot with cornbread or rice."
        ],
        prepTime: 10,
        cookTime: 30
        ),
        
        Recipe(
        thumbnailImagePath: nil,
        title: "Pancakes",
        description: "Fluffy pancakes served with syrup and fresh fruit.",
        ingredients: ["1 cup flour", "2 tablespoons sugar", "1 tablespoon baking powder", "1 cup milk", "1 egg", "2 tablespoons melted butter", "Salt"],
        steps: [
        "Mix flour, sugar, baking powder, and salt in a bowl.",
        "In another bowl, whisk milk, egg, and melted butter.",
        "Combine wet and dry ingredients until just mixed.",
        "Pour batter onto a hot griddle and cook until bubbles form.",
        "Flip and cook until golden brown. Serve with syrup."
        ],
        prepTime: 10,
        cookTime: 15
        ),
        Recipe(
        thumbnailImagePath: nil,
        title: "Chocolate Chip Cookies",
        description: "Classic cookies loaded with chocolate chips.",
        ingredients: ["1 cup butter", "1 cup sugar", "1 cup brown sugar", "2 eggs", "2 cups flour", "1 teaspoon baking soda", "2 cups chocolate chips", "Salt"],
        steps: [
        "Preheat oven to 350°F (175°C).",
        "Cream together butter, sugar, and brown sugar.",
        "Add eggs and mix well.",
        "Stir in flour, baking soda, and salt.",
        "Fold in chocolate chips.",
        "Drop spoonfuls onto a baking sheet and bake for 10-12 minutes."
        ],
        prepTime: 15,
        cookTime: 12
        )
    ]
}