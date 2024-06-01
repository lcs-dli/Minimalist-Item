//
//  ItemFormView.swift
//  MinimalistItem
//
//  Created by David Li on 2024-05-31.
//

import SwiftUI

struct ItemFormView: View {
    @Environment(\.presentationMode) var presentationMode
    @State var item: Item
    var isNew: Bool
    let importanceLevels = [1,2,3,4,5]
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Details")) {
                    TextField("Name", text: $item.name)
                    TextField("Description", text: Binding(
                        get: { item.description ?? "" },
                        set: { item.description = $0.isEmpty ? nil : $0 }
                    ))
                    Picker("Importance", selection: $item.importance) {
                        ForEach(importanceLevels, id: \.self) { level in
                                Text("\(level)").tag(level)
                                    }
                        }
                    TextField("Type", text: $item.type)
                }
                
                Button(action: {
                    if isNew {
                        if DatabaseHelper.shared.createItem(item: item) {
                            print("Item created successfully")
                        }
                    } else {
                        if DatabaseHelper.shared.updateItem(item: item) {
                            print("Item updated successfully")
                        }
                    }
                    presentationMode.wrappedValue.dismiss()
                }) {
                    Text(isNew ? "Add Item" : "Update Item")
                }
            }
            .navigationTitle(isNew ? "New Item" : "Edit Item")
        }
    }
}
