//
//  NaviTest.swift
//  SwiftUI_Albuja
//
//  Created by Seongjun Kim on 28/2/22.
//

import SwiftUI

struct NaviTest: View {
    var body: some View {
        
        NavigationView {
            
            VStack {
                Text("하이연").frame(width: 100, height: 100)
                
                NavigationLink(destination: Test2()) {
                    Text("hihi")
                }
            }
            
        }
        
    }
}

struct NaviTest_Previews: PreviewProvider {
    static var previews: some View {
        NaviTest()
    }
}
