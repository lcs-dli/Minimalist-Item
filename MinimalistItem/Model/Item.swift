//
//  Item.swift
//  MinimalistItem
//
//  Created by David Li on 2024-05-23.
//

import Foundation

struct Item: Identifiable{
    let id = UUID()
    var name: String
    var description: String?
    var importance: Int
    var type: String
}

let testItems: [Item] = [
    Item(name: "Macbook", description: "Study tool", importance: 1, type: "Study"),
    Item(name: "Ipad", description: "for fun", importance: 2, type: "Leisure")
]
