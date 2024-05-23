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
                Button(action: {
                    
                }, label: {
                    HStack{
                        Rectangle()
                            .foregroundColor(importanceColor(i: currentdisplay.importance))
                            .frame(width: 20)
                           
                        VStack(alignment: .leading){
                            Text(currentdisplay.name)
                                .bold()
            
                            Text(currentdisplay.type)
                                .foregroundColor(.gray)
                        }
                        Spacer()
                        Image(systemName: "chevron.right")
                    }
                })
                
            }
        }.navigationBarTitle("Items", displayMode: .large)
    }
    
    //MARK: Function
    func importanceColor(i: Int) -> Color {
        if i==1 {
            return .red
        }else if i == 2{
            return .orange
        }else if i == 3{
            return .yellow
        }else if i == 4{
            return .green
        }
        return .gray
    }
}

#Preview {
    NavigationView{
        ItemListView()
    }
}
