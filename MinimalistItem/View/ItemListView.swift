//
//  ItemListView.swift
//  MinimalistItem
//
//  Created by David Li on 2024-05-23.
//

import SwiftUI

struct ItemListView: View {
    //MARK: Storing property
    @State var Items = DatabaseHelper.shared.readUsers()
    
    //MARK: Computing property
    var body: some View {
        VStack{
            HStack{
                Button(action: {
                    
                }, label: {
                    Image(systemName: "plus")
                })
                .padding()
                Spacer()
                Text("Items")
                    .bold()
                    .font(.largeTitle)
                Spacer()
                Button(action: {
                    
                }, label: {
                    Text("Edit")
                })
                .padding()
            }
            List(Items){currentdisplay in
                Button(action: {
                    
                }, label: {
                   ItemView(currentdisplay: currentdisplay)
                })
                
            }
        }
            
    }
    
    
}

#Preview {
    TabView{
        ItemListView()
            .tabItem {
                VStack{
                    Image(systemName: "list.dash")
                    Text("Items")
                }
            }
            .tag(1)
        
        Text("Stat")
        
        Text("Graph")
    }
}
