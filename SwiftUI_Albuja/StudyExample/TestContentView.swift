////
////  TestContentView.swift
////  SwiftUI_Albuja
////
////  Created by Seongjun Kim on 26/2/22.
////
//
//import SwiftUI
//import KakaoSDKCommon
//import KakaoSDKAuth
//import KakaoSDKUser
//
//struct TestContentView: View {
//
//    @State private var rating: Int?
//    //    @StateObject private var viewState: Bool?
//    @State var containedViewType: SwitchViewModel.State2?
//
//    var body: some View {
//
//
//        view(for: containedViewType!)
//
//
//        //        VStack {
//        //
//        //
//        //
//        ////            Button {
//        ////                UserApi.shared.me() {(user, error) in
//        ////                    if let error = error {
//        ////                        print(error)
//        ////                    }
//        ////                    else {
//        ////                       print(String((user?.id)!))
//        ////                       print((user?.kakaoAccount?.email)!)
//        ////                    }
//        ////                }
//        ////            } label: {
//        ////                Text("hihi")
//        ////            }
//        //
//        //
//        //
//        //        }
//        //        containedView() // 뷰 이동 할 때 쓰는
//    }
//
//    // View Builders
//    @ViewBuilder
//    func view(for view: SwitchViewModel.State2) -> some View {
//        switch view {
//        case .kakaoLoginView:
//            KakaoLoginView(containedViewType: $containedViewType)
//
//        case .testView:
//             Test2()
//        }
//    }
//
//    struct TestContentView_Previews: PreviewProvider {
//        static var previews: some View {
//            TestContentView()
//        }
//    }
//}
//
//
