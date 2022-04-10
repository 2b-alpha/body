//
//  MarkerOptionImageCell.swift
//  SwiftUI_Albuja
//
//  Created by Seongjun Kim on 1/3/22.
//

import SwiftUI

struct MarkerOptionImageCell: View {
    var scale: String?
    var price: String?
    var pickedOption: String?
    
    var body: some View {
        
        ZStack(alignment: .top) {
            Image("marker")
                .frame(width: 66, height: 75)
            
            VStack {
                Text("\(scale!)")
                    .foregroundColor(.white)
                    .offset(x: 0, y: 8)
                
                Text("\(price!)")
                    .foregroundColor(.white)
                    .offset(x: 0, y: 8)
                
                ZStack {
                    Image("cellOption")
                        .resizable()
                        .frame(width: 70, height: 20)
                        .offset(x: 0, y: -3)
                    Text("\(pickedOption!)")
                        .offset(x: 0, y: -3)
                        .foregroundColor(.black)
                }
                
            }
        }
    }
}

struct MarkerOptionImageCell_Previews: PreviewProvider {
    static var previews: some View {
        MarkerOptionImageCell(scale: "scale", price: "price", pickedOption: "option").previewLayout(.sizeThatFits)
    }
}
