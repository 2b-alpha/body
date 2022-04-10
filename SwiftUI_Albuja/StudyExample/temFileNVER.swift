////
////  NaverMap.swift
////  SwiftUI_Albuja
////
////  Created by Seongjun Kim on 26/2/22.
////
//
////import Combine
//import NMapsMap
//import SwiftUI
//import UIKit
//
//struct MapScene: View {
//    var body: some View {
//        MapView()
//    }
//}
//
//
//struct MapView: UIViewRepresentable {
//
//    @ObservedObject var viewModel = MapSceneViewModel()
//
//    func makeUIView(context: Context) -> NMFNaverMapView {
//
//        let view = NMFNaverMapView()
//
//        view.mapView.touchDelegate = context.coordinator
//        view.mapView.addCameraDelegate(delegate: context.coordinator)
//        view.mapView.addOptionDelegate(delegate: context.coordinator)
//
//        view.showZoomControls = false
////        view.mapView.positionMode = .direction
//        view.mapView.zoomLevel = 20
//
//        view.mapView.minZoomLevel = 4 // 줌 최소 레벨
//        view.mapView.extent = NMGLatLngBounds(southWestLat: 31.43, southWestLng: 122.37, northEastLat: 44.35, northEastLng: 132) // 카메라 이동 제한
//
//
//
//        //현 위치로 카메라 이동
//        let cameraUpdate = NMFCameraUpdate(scrollTo: NMGLatLng(lat: 37.5670135, lng: 126.9783740))
//        view.mapView.moveCamera(cameraUpdate)
//
//
//
//
//        viewModel.sampleDB()
//
//        return view
//    }
//
//    func updateUIView(_ uiView: NMFNaverMapView, context: Context) {
//
//    }
//
//    // Delegate를 쓰기 위한!
//    class Coordinator: NSObject, NMFMapViewTouchDelegate, NMFMapViewCameraDelegate, NMFMapViewOptionDelegate {
//
//        @ObservedObject var viewModel: MapSceneViewModel
//
//
//        //        var cancellable = Set<AnyCancellable>()
//
//        init(viewModel: MapSceneViewModel) {
//            self.viewModel = viewModel
//        }
//
//        // 맵뷰 터치시
//        func mapView(_ mapView: NMFMapView, didTapMap latlng: NMGLatLng, point: CGPoint) {
//
//            print("카메라 터치시 뜨는것!")
//        }
//
//        // 맵 이동 끝났을 때에
//        func mapViewCameraIdle(_ mapView: NMFMapView) {
//            viewModel.realMakeMarker(mapView: mapView, swLat: mapView.coveringBounds.southWestLat, swLng: mapView.coveringBounds.southWestLng, neLat: mapView.coveringBounds.northEastLat, neLng: mapView.coveringBounds.northEastLng)
//        }
//    }
//
//    func makeCoordinator() -> Coordinator {
//        return Coordinator(viewModel: viewModel)
//    }
//
//}
//
//class MapSceneViewModel: ObservableObject {
//
//    var locationManager:CLLocationManager?
//
//
//
//
//    var markerCode: [Int:NMFMarker] = [:] // 마커 빈 딕셔너리 생성
//
//    var normalMarkers: [Markers] = [] // 마커들 배열로
//
//    func sampleDB() {
//        normalMarkers.append(Markers(lat: 37.56620525540357, lng: 126.97930017480579, scale: "0번", price: "입니다", code: 0))
//        normalMarkers.append(Markers(lat: 37.566123, lng: 126.979362, scale: "1번", price: "입메닷", code: 1))
//        normalMarkers.append(Markers(lat: 37.565832, lng: 126.971373, scale: "2번", price: "안드로메닷", code: 2))
//        normalMarkers.append(Markers(lat: 37.567832, lng: 126.975373, scale: "3번", price: "34억", code: 3))
//        normalMarkers.append(Markers(lat: 37.564832, lng: 126.976373, scale: "4번", price: "11억", code: 4))
//        normalMarkers.append(Markers(lat: 37.56362020465787, lng: 126.97474083056728, scale: "5번", price: "왼아", code: 5))
//        normalMarkers.append(Markers(lat: 37.56615931864759, lng: 126.98215547361262, scale: "6번", price: "을지", code: 6))
//        normalMarkers.append(Markers(lat: 37.567675909175705, lng: 126.97929168094828, scale: "7번", price: "추크", code: 7))
//        normalMarkers.append(Markers(lat: 37.567990208119866, lng: 126.97463772041536, scale: "8번", price: "체크", code: 8))
//        normalMarkers.append(Markers(lat: 37.56704313966548, lng: 126.97783303973549, scale: "9번", price: "재여", code: 9))
//        normalMarkers.append(Markers(lat: 37.565117835910414, lng: 126.97779576693473, scale: "10번", price: "째엿", code: 10))
//    }
//
//
//    func realMakeMarker (mapView: NMFMapView, swLat: Double, swLng: Double, neLat: Double, neLng: Double) {
//
//
//        print("swLat:  \(swLat)")
//        print("swLng: \(swLng)")
//        print("neLat: \(neLat)")
//        print("neLng: \(neLng)")
//
//        // 맵뷰에 마커를 띄우는
//        for index in 0...normalMarkers.count-1 {
//
//
//
//            if normalMarkers[index].lat! > swLat && normalMarkers[index].lat! < neLat && normalMarkers[index].lng! > swLng && normalMarkers[index].lng! < neLng {
//
//                // 맵 뷰가 이미 있다면?
//                if markerCode[normalMarkers[index].code!]?.mapView == mapView {
//                    print("맵 뷰가 이미 있어서 뜨는것")
//                } else {
//                    // 맵 뷰가 없다면?
//
//                    // 해당 아파트 코드가 갖고있는 마커가 nil이 아니라면?
//                    if markerCode[normalMarkers[index].code!] != nil {
//                        print("해당 아파트 코드가 갖고있는 마커가 이미 있기 때문에 뜨는 것! 그래서 다시 mapView를 마커에 넣어주는")
//                        markerCode[normalMarkers[index].code!]?.mapView = mapView
//                    } else {
//                        print("마커 생성중...~")
//
//                        let makingMarker = MarkerImageCell(scale: normalMarkers[index].scale, price: normalMarkers[index].price)
//
//
//
//                        let image = makingMarker.snapshot()
//                        let image2 = NMFOverlayImage(image: image)
//
//                        // 마커 생성
//                        let marker = NMFMarker()
//                        marker.position = NMGLatLng(lat: normalMarkers[index].lat!, lng: normalMarkers[index].lng!)
//
//                        marker.mapView = mapView
//                        marker.iconImage = image2
//
//
//
//                        // 해당 마커 줌레벨 조절
//                        marker.minZoom = 12
//                        marker.isMinZoomInclusive = true
//
//
//                        marker.touchHandler = { (overlay) -> Bool in
//                            print("touch")
//                            return true // 이벤트 소비, -mapView:didTapMap:point 이벤트는 발생하지 않음
//                        }
//
//                        // 딕셔너리에 해당 아파트 코드를 Key 그리고 벨류를 해당 아파트의 마커로 insert
//                        markerCode[normalMarkers[index].code!] = marker
//                    }
//                }
//            } else { // 카메라 범위 밖에 있다면 ?
//
//                markerCode[normalMarkers[index].code!]?.mapView = nil // 맵 밖에 있는 마커들을 안띄우게
//
//            }
//
//        }
//    }
//
//    struct Markers {
//
//        var lat: Double?
//        var lng: Double?
//        var scale: String?
//        var price: String?
//        var code: Int?
//
//    }
//}
//
//
//// 뷰를 이미지로 스냅샷
//extension View {
//    func snapshot() -> UIImage {
//        let controller = UIHostingController(rootView: self)
//        let view = controller.view
//
////        let targetSize = controller.view.intrinsicContentSize
//        let targetSize = controller.view.sizeThatFits(CGSize(width: 150, height: 150))
//        view?.bounds = CGRect(origin: .zero, size: targetSize)
//        view?.backgroundColor = .clear
//
//        let renderer = UIGraphicsImageRenderer(size: targetSize)
//
//        return renderer.image { _ in
//            view?.drawHierarchy(in: controller.view.bounds, afterScreenUpdates: true)
//        }
//    }
//}
