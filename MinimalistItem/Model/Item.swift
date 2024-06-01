//
//  Item.swift
//  MinimalistItem
//
//  Created by David Li on 2024-05-23.
//

import Foundation

struct Item: Identifiable{
    var id : Int?
    var name: String
    var description: String?
    var importance: Int
    var type: String
}

let testItems: [Item] = [
    Item(id: 0, name: "Macbook", description: "Study tool", importance: 1, type: "Study"),
    Item(id : 1, name: "Ipad", description: "for fun", importance: 2, type: "Leisure")
]
