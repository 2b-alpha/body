//
//  ContentView.swift
//  adding-list-state
//
//  Created by Seongjun Kim on 21/2/22.
//

import SwiftUI

struct ContentView: View {
    
    var model = Task.all()
    
    @State private var isSpicy = false
    
    var body: some View {
        
        List {
            
            Toggle(isOn: $isSpicy) {
                Text("Spicy")
                    .font(.title)
            }
            
            ForEach(model.filter { $0.isSpicy == self.isSpicy}) { task in
                
                HStack {
                
                    Image(task.imageURL)
                        .resizable()
                        .frame(width: 100, height: 100)
                    
                    Text(task.name)
                        .font(.title)
                        .lineLimit(nil)
                    
                    Spacer()
                    
                    if(task.isSpicy) {
                        Image("1")
                            .resizable()
                            .frame(width: 35, height: 35)
                    }
                    
                }
                
                
                
            }
            
        }
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
