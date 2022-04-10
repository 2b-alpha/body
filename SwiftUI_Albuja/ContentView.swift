//
//  ContentView.swift
//  SwiftUI_Albuja
//
//  Created by Seongjun Kim on 26/2/22.
//

import SwiftUI
import KakaoSDKCommon
import KakaoSDKAuth
import KakaoSDKUser

struct ContentView: View {
    
    @StateObject var mapViewModel: MapSceneViewModel = MapSceneViewModel()
    
    @State private var testButton = false
    
    var body: some View {
        
        NavigationView {
            
            TabView {
                // 네이버 지도
                MapView(viewModel: mapViewModel, testButton: $testButton)
                    .overlay{
                        Button(action: {
                            mapViewModel.isOption = true
                            mapViewModel.optionName = "A"
                            testButton = true
                            
                        }, label: {
                            
                            Image("testButton")
                                .overlay{
                                    Text("A")
                                        .foregroundColor(.white)
                                }
                            
                            
                        })
                            .offset(x: -150, y: 210)
                        
                        //B 버튼
                        Button(action: {
                            mapViewModel.isOption = true
                            mapViewModel.optionName = "B"
                            testButton = true
                        }, label: {
                            
                            Image("testButton")
                                .overlay{
                                    Text("B")
                                        .foregroundColor(.white)
                                }
                            
                            
                            
                        })
                            .offset(x: -80, y: 210)
                        
                        
                        // 기본마커 버튼
                        Button(action: {
                            // 기본 마커로
                            mapViewModel.isOption = true
                            mapViewModel.optionName = ""
                            
                            testButton = true
                        }, label: {
                            
                            Image("testButton")
                                .resizable()
                                .frame(width: 90, height: 40)
                                .overlay{
                                    Text("기본 마커")
                                        .foregroundColor(.white)
                                }
                            
                            
                            
                        })
                            .offset(x: 130, y: 210)
                    }
                    .tabItem {
                        Image(systemName: "phone.fill")
                        Text("지도")
                    }
                    .onDisappear {
                        print("지도가 사라짐!")
                    }
                
                LoginView()
                    .tabItem {
                        Image(systemName: "tv.fill")
                        Text("테스트")
                    }
                    .onDisappear {
                        print("테스트가 사라짐!")
                    }
            }
            
            VStack {
                
                
            }
        }
        
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
