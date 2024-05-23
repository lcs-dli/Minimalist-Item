//
//  ItemListView.swift
//  MinimalistItem
//
//  Created by David Li on 2024-05-23.
//

import SwiftUI

struct ItemListView: View {
    //MARK: Computing property
    var body: some View {
        NavigationView{
            List(testItems){currentdisplay in
                HStack{
                    
                    VStack{
                        Text(currentdisplay.name)
                            .bold()
        
                        Text(currentdisplay.type)
                            .foregroundColor(.gray)
                    }
                }
            }
        }.navigationBarTitle("Items", displayMode: .large)
    }
    
    //MARK: Function
}

#Preview {
    NavigationView{
        ItemListView()
    }
}
