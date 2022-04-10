//
//  SwiftUI_AlbujaApp.swift
//  SwiftUI_Albuja
//
//  Created by Seongjun Kim on 26/2/22.
//

import SwiftUI
import NMapsMap
import KakaoSDKCommon
import KakaoSDKAuth

class AppState: ObservableObject {
    @Published var hasOnboarded: Bool
    
    init(hasOnboarded: Bool) {
        self.hasOnboarded = hasOnboarded
    }
}

@main
struct SwiftUI_AlbujaApp: App {
    
    @ObservedObject var appState = AppState(hasOnboarded: true)
    
    init(){
        // 네이버 지도 초기화
        NMFAuthManager.shared().clientId = "esx5dqud5g"
        
        // Kakao SDK 초기화
        KakaoSDK.initSDK(appKey: "5f1153a44ea138b54b27925544bebbdf")

    }
    
    var body: some Scene {
        WindowGroup {
            
            if appState.hasOnboarded {
                KakaoLoginView().onOpenURL(perform: { url in
                    if (AuthApi.isKakaoTalkLoginUrl(url)) {
                        _ = AuthController.handleOpenUrl(url: url)
                    }
                }).environmentObject(appState)
            } else {
                Test2()
                    .environmentObject(appState)
            }
            
            
            ContentView()
            
            
            
        }
    }
}
