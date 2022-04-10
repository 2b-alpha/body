//
//  SwitchViewModel.swift
//  SwiftUI_Albuja
//
//  Created by Seongjun Kim on 28/2/22.
//

import Foundation

class SwitchViewModel: ObservableObject {
    
    @Published var nickName: String = ""
    @Published var email: String = ""
    @Published var profileImgurl: URL?
    
    enum State2  {
        case kakaoLoginView
        case testView
        
    }
    
    //    init(){
    //
    //    }
    
}
