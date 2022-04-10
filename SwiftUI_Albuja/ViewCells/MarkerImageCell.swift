//
//  MarkerImage.swift
//  SwiftUI_Albuja
//
//  Created by Seongjun Kim on 26/2/22.
//

import SwiftUI

struct MarkerImageCell: View {
    
    var scale: String?
    var price: String?
    
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
               
            }
        }
    }
}


//
//struct LibraryContent2: LibraryContentProvider {
//
//    @LibraryContentBuilder
//    var views: [LibraryItem] {
//        LibraryItem(
//
//            MarkerImageCell(scale: "1평", price: "1억"),
//            title: "Marker Image Cell", category: .control
//
//        )
//    }
//
//}

struct MarkerImage_Previews: PreviewProvider {
    static var previews: some View {
        MarkerImageCell(scale: "test", price: "123").previewLayout(.sizeThatFits)
    }
}
