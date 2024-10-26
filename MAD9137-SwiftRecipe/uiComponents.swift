//
//  uiComponents.swift
//  MAD9137-SwiftRecipe
//
//  Created by Dat Nguyen(Mike) on 2024-10-26.
//
import SwiftUI

// TextINPUT-----------------START
struct TextInput: View {
    var label: String
    var placeholder: String
    @Binding var text: String
    @FocusState private var isFocused: Bool

    var body: some View {
        VStack(alignment: .leading) {
            Text(label)
                .font(.caption)
                .foregroundColor(.gray)
                .padding(.bottom, 2)

            TextField(placeholder, text: $text)
                .focused($isFocused)
                .textFieldStyle(CustomTextFieldStyle(isFocused: isFocused))
                .padding(.vertical, 5)
                .frame(maxWidth: .infinity)
        }.padding().padding(.top, 0).padding(.bottom, 0)
    }
}

struct CustomTextFieldStyle: TextFieldStyle {
    var isFocused: Bool

    func _body(configuration: TextField<Self._Label>) -> some View {
        configuration
            .padding(10)
            .background(RoundedRectangle(cornerRadius: 5)
                .stroke(isFocused ? Color.black : Color.gray, lineWidth: 1))
    }
}

// TextINPUT-----------------END

struct IngredientListView: View {
    @Binding var ingredients: [String]
    @State private var newIngredient: String = ""

    var body: some View {
        VStack {
            HStack {
                TextInput(label: "Ingredients", placeholder: "Add ingredient", text: $newIngredient)
                Button(action: {
                    ingredients.append(newIngredient)
                    newIngredient = ""
                }) {
                    Image(systemName: "plus.circle.fill")
                }
            }.padding()
            ForEach(Array(ingredients.enumerated()), id: \.offset) { index, ingredient in
                Text("\(index + 1). \(ingredient)")
            }
        }
    }
}

struct StepsListView: View {
    @Binding var steps: [String]
    @State private var newStep: String = ""

    var body: some View {
        VStack {
            HStack {
                TextInput(label: "Step", placeholder: "Add a new step...", text: $newStep)
                Button(action: {
                    steps.append(newStep)
                    newStep = ""
                }) {
                    Image(systemName: "plus.circle.fill")
                }
            }
            .padding()

            ForEach(Array(steps.enumerated()), id: \.offset) { index, step in
                Text("\(index + 1). \(step)")
            }
        }
    }
}

struct TimeInputView: View {
    @Binding var timeValue: Int
    var label: String

    var body: some View {
        HStack {
            Text(label)
            Spacer()
            Stepper(value: $timeValue, in: 0 ... Int.max, step: 1) {
                Text("\(timeValue) mins")
            }
        }
        .padding(.horizontal)
    }
}
