//
//  KakaoLoginView.swift
//  SwiftUI_Albuja
//
//  Created by Seongjun Kim on 28/2/22.
//

import SwiftUI
import KakaoSDKCommon
import KakaoSDKAuth
import KakaoSDKUser

struct KakaoLoginView: View {
    
    @EnvironmentObject var appState: AppState
    
    @State var containedViewType: SwitchViewModel.State2?
    
    @State private var check: Bool = true
    
    
    var body: some View {
        
        VStack {
            
            // 절취선
            Image("mainLogo")
                .resizable()
                .frame(width: 130,  height: 126)
                .padding()
            Image("mainLogo2")
                .padding()
            Image("mainLogo3")
            Spacer()
                .frame(width: .infinity, height: 100)
            
            VStack {
                
                Button {
                    
                    kakaoLogin()
                    
                } label : {
                    Image("kakaoLogin")
                    
                }
                
                Image("loginotherMethod")
            }
            .offset(x: 0, y: 100)
            
        }
        .onAppear {
            print("토큰 체크 하고 시작한다~ \(AuthApi.hasToken())")
            
            kakaoTokenCheck()
        }
        
        
    }
    
    // View Builders
    @ViewBuilder
    func view(for view: SwitchViewModel.State2) -> some View {
        switch view {
        case .kakaoLoginView:
            KakaoLoginView()
            
        case .testView:
            Test2()
        }
    }
    
    
    func kakaoLogin() {
        if (UserApi.isKakaoTalkLoginAvailable()) {
            UserApi.shared.loginWithKakaoTalk {(oauthToken, error) in
                print(oauthToken)
                print(error)
                kakaoTokenCheck()
            }
            
            
            
        } else {
            UserApi.shared.loginWithKakaoAccount {(oauthToken, error) in
                print(oauthToken)
                print(error)
                kakaoTokenCheck()
            }
            
        }
    }
    
    
    func kakaoTokenCheck() {
        if (AuthApi.hasToken()) {
            
            
            UserApi.shared.accessTokenInfo { (_, error) in
                if let error = error {
                    if let sdkError = error as? SdkError, sdkError.isInvalidTokenError() == true  {
                        //로그인 필요
                        
                        //                            appState.hasOnboarded = false
                    }
                    else {
                        //기타 에러
                    }
                }
                else {
                    //토큰 유효성 체크 성공(필요 시 토큰 갱신됨)
                    //                    TestContentView(containedViewType: self.containedViewType)
                    print("토큰 유효성 체크 성공!")
                    
                    appState.hasOnboarded = false
                    //                    self.check = false
                    
                }
            }
        }
        else {
            //로그인 필요
            
            //                appState.hasOnboarded = false
        }
    }
}





struct KakaoLoginView_Previews: PreviewProvider {
    
    
    
    static var previews: some View {
        KakaoLoginView()
    }
}
