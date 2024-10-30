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
                .onChange(of: text) { newValue in
                    print("Current text input: \(newValue)")
                }
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

// IngredientListView-----------------START
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
            ForEach(ingredients.indices, id: \.self) { index in
                HStack {
                    Text(ingredients[index])
                    Spacer()
                    Button(action: {
                        ingredients.remove(at: index)
                    }) {
                        Image(systemName: "minus.circle.fill")
                            .foregroundColor(.red)
                    }
                }
                .padding(.horizontal)
            }
        }
    }
}

// IngredientListView-----------------END

// StepsListView-----------------START
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

            ForEach(steps.indices, id: \.self) { index in
                HStack {
                    Text(steps[index])
                    Spacer()
                    Button(action: {
                        steps.remove(at: index)
                    }) {
                        Image(systemName: "minus.circle.fill")
                            .foregroundColor(.red)
                    }
                }
                .padding(.horizontal)
            }
        }
    }
}

// StepsListView-----------------END

// TimeInputView-----------------START
struct TimeInputView: View {
    @Binding var timeValue: Int
    var label: String

    var body: some View {
        HStack {
            Text(label)
            Spacer()
            Stepper(value: $timeValue, in: 0 ... 1440, step: 1) {
                Text("\(timeValue) mins")
            }
        }
        .padding(.horizontal)
    }
}

// TimeInputView-----------------END

// ChipView-----------------START
struct ChipView: View {
    var label: String
    var body: some View {
        Text(label)
            .padding(.horizontal, 10)
            .padding(.vertical, 5)
            .background(
                Capsule()
                    .fill(Color.gray.opacity(0.2))
            )
    }
}

// ChipView-----------------END
