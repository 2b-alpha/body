//
//  Test2.swift
//  SwiftUI_Albuja
//
//  Created by Seongjun Kim on 28/2/22.
//

import SwiftUI
import KakaoSDKCommon
import KakaoSDKAuth
import KakaoSDKUser

struct Test2: View {
    @EnvironmentObject var appState: AppState
    @ObservedObject var test = SwitchViewModel()
    
    var body: some View {
        
        
        NavigationView {
            
            VStack{
                Text(test.nickName)
                Text(test.email)
                AsyncImage(url: test.profileImgurl)
                
                
                HStack {
                    Button {
                        
                        print("체크체크 로그아웃 상태: \(appState.hasOnboarded)")
                        
                        UserApi.shared.logout {(error) in
                            if let error = error {
                                print(error)
                                
                            }
                            else {
                                print("logout() success.")
                                appState.hasOnboarded = true
                            }
                        }
                    } label: {
                        Text("로그아웃")
                    }
                    
                    NavigationLink {
                        ContentView()
                    } label: {
                        Text("지도로 가즈아")
                    }

                }
                
                
                
            }
            .onAppear {
                UserApi.shared.me() {(user, error) in
                    if let error = error {
                        print(error)
                    }
                    else {
    //                    print(String((user?.id)!))
                        test.nickName = (user?.kakaoAccount?.profile?.nickname)!
                        test.email = (user?.kakaoAccount?.email!)!
                        test.profileImgurl = ((user?.kakaoAccount?.profile?.profileImageUrl) as! URL)
    //                    AsyncImage(url: URL(string: "\(user?.kakaoAccount?.profile?.profileImageUrl)"))
                    }
                }
            }
        }
        
        
        
        
        
    }
}

struct Test2_Previews: PreviewProvider {
    static var previews: some View {
        Test2()
    }
}
