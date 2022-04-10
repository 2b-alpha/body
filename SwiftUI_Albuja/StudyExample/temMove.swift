//
//  NaverMap.swift
//  SwiftUI_Albuja
//
//  Created by Seongjun Kim on 26/2/22.
//

//import Combine
import NMapsMap
import SwiftUI
//import UIKit


struct MapView: UIViewRepresentable {
    
    var viewModel: MapSceneViewModel
    @Binding var testButton: Bool
    
    func makeUIView(context: Context) -> NMFNaverMapView {
        
        let view = NMFNaverMapView()
        
        view.mapView.touchDelegate = context.coordinator
        view.mapView.addCameraDelegate(delegate: context.coordinator)
        view.mapView.addOptionDelegate(delegate: context.coordinator)
        
        view.showZoomControls = false
        //        view.mapView.positionMode = .direction
        //        view.mapView.zoomLevel = 20
        view.mapView.zoomLevel = 14
        
        view.mapView.minZoomLevel = 4 // 줌 최소 레벨
        view.mapView.extent = NMGLatLngBounds(southWestLat: 31.43, southWestLng: 122.37, northEastLat: 44.35, northEastLng: 132) // 카메라 이동 제한
        
        //현 위치로 카메라 이동
        let cameraUpdate = NMFCameraUpdate(scrollTo: NMGLatLng(lat: 37.5670135, lng: 126.9783740))
        view.mapView.moveCamera(cameraUpdate)
        
        viewModel.sampleDB()
        print("makeUIView: 홀리쓋 몇 번 만드는지 보자@@@@")
        return view
    }
    
    func updateUIView(_ uiView: NMFNaverMapView, context: Context) {
        //        print("updateUIView1: \(uiView.mapView.coveringBounds.southWestLat)")
        //        print("updateUIView2: \(uiView.mapView.coveringBounds.southWestLng)")
        //        print("updateUIView3: \(uiView.mapView.coveringBounds.northEastLat)")
        //        print("updateUIView4: \(uiView.mapView.coveringBounds.northEastLng)")
        //
        //
        //        viewModel.remakeOptionMarker(mapView: uiView.mapView, swLat: uiView.mapView.coveringBounds.southWestLat, swLng: uiView.mapView.coveringBounds.southWestLng, neLat: uiView.mapView.coveringBounds.northEastLat, neLng: uiView.mapView.coveringBounds.northEastLng)
        
        
        
        
        
        if uiView.window != nil, !uiView.isFirstResponder {
            //This triggers attribute cycle if not dispatched
            DispatchQueue.main.async {
                uiView.becomeFirstResponder()
                
                if testButton {
                    print("updateUIView: 업데이트 뜰 때마다 뜨는거라는 말인데 ... 언제언제뜨나 보자22222")
                    viewModel.realMakeMarker(mapView: uiView.mapView, swLat: uiView.mapView.coveringBounds.southWestLat, swLng: uiView.mapView.coveringBounds.southWestLng, neLat: uiView.mapView.coveringBounds.northEastLat, neLng: uiView.mapView.coveringBounds.northEastLng, changedOption: viewModel.optionName)
                    testButton = false
                } else {
                    
                }
            }
        }
        
    }
    
    // Delegate를 쓰기 위한 Coordinator
    class Coordinator: NSObject, NMFMapViewTouchDelegate, NMFMapViewCameraDelegate, NMFMapViewOptionDelegate {
        
        var viewModel: MapSceneViewModel
        
        var checkGesture: Bool = false
        
        //        var cancellable = Set<AnyCancellable>()
        
        init(viewModel: MapSceneViewModel) {
            self.viewModel = viewModel
        }
        
        // 맵뷰 터치시
        func mapView(_ mapView: NMFMapView, didTapMap latlng: NMGLatLng, point: CGPoint) {
            
            print("카메라 터치시 뜨는것!")
        }
        
        // 맵 이동 중에
        func mapView(_ mapView: NMFMapView, cameraDidChangeByReason reason: Int, animated: Bool) {
            
            if reason == -1 {
                checkGesture = true
            }
        }
        
        // 맵 이동 끝났을 때에
        func mapViewCameraIdle(_ mapView: NMFMapView) {
            if checkGesture {
                
                viewModel.realMakeMarker(mapView: mapView, swLat: mapView.coveringBounds.southWestLat, swLng: mapView.coveringBounds.southWestLng, neLat: mapView.coveringBounds.northEastLat, neLng: mapView.coveringBounds.northEastLng, changedOption: viewModel.optionName)
                
                print("체크1: \(viewModel.isOption)")
                print("체크2: \(viewModel.optionName)")
                
            }
            
        }
    }
    
    // Coordinator 만들기
    func makeCoordinator() -> Coordinator {
        return Coordinator(viewModel: viewModel)
    }
}


//MARK: - class MapSceneViewModel
class MapSceneViewModel: ObservableObject {
    
    var locationManager:CLLocationManager?
    
    var markerCode: [Int:NMFMarker] = [:] // 마커 빈 딕셔너리 생성
    
    var normalMarkers: [Markers] = [] // 마커들 배열로
    
    @Published var optionName: String = "" // 지도 마커 옵션 볼 내용
    @Published var isOption: Bool = false // 지도 마커 옵션 상태
    
    func sampleDB() {
        DispatchQueue.main.async{
            self.normalMarkers.append(Markers(lat: 37.56620525540357, lng: 126.97930017480579, scale: "0번", price: "입니다", aa: "A1", bb: "B11", code: 0))
            self.normalMarkers.append(Markers(lat: 37.566123, lng: 126.979362, scale: "1번", price: "입메닷", aa: "A2", bb: "B10", code: 1))
            self.normalMarkers.append(Markers(lat: 37.565832, lng: 126.971373, scale: "2번", price: "안드로메닷", aa: "A3", bb: "B9", code: 2))
            self.normalMarkers.append(Markers(lat: 37.567832, lng: 126.975373, scale: "3번", price: "34억", aa: "A4", bb: "B8", code: 3))
            self.normalMarkers.append(Markers(lat: 37.564832, lng: 126.976373, scale: "4번", price: "11억", aa: "A5", bb: "B7", code: 4))
            self.normalMarkers.append(Markers(lat: 37.56362020465787, lng: 126.97474083056728, scale: "5번", price: "왼아", aa: "A6", bb: "B6", code: 5))
            self.normalMarkers.append(Markers(lat: 37.56615931864759, lng: 126.98215547361262, scale: "6번", price: "을지", aa: "A7", bb: "B5", code: 6))
            self.normalMarkers.append(Markers(lat: 37.567675909175705, lng: 126.97929168094828, scale: "7번", price: "추크", aa: "A8", bb: "B4", code: 7))
            self.normalMarkers.append(Markers(lat: 37.567990208119866, lng: 126.97463772041536, scale: "8번", price: "체크", aa: "A9", bb: "B3", code: 8))
            self.normalMarkers.append(Markers(lat: 37.56704313966548, lng: 126.97783303973549, scale: "9번", price: "재여", aa: "A10", bb: "B2", code: 9))
            self.normalMarkers.append(Markers(lat: 37.565117835910414, lng: 126.97779576693473, scale: "10번", price: "째엿", aa: "A11", bb: "B1", code: 10))
            
        }
        
    }
    
    
    // 마커 체크 & 만들기
    func checkAndMakeMarker(_ index: Int, _ mapView: NMFMapView, _ optionName: String) {
        
        // 처음에 option인지 아닌지 차이를 보고?
        //        if optionName == "" {
        //
        //        } else if optionName == "aa" {
        //
        //        } else if optionName == "bb" {
        //
        //        }
        print("checkAndMakeMarker: 옵션네임은? \(optionName)")
        
        // 맵 뷰가 이미 있다면?
        if self.markerCode[self.normalMarkers[index].code!]?.mapView == mapView {
            
            print("맵 뷰가 이미 있어서 뜨는것")
            
            //            print("checkAndMakeMarker: \(optionName)")
            //            print("checkAndMakeMarker: \(isOption)")
            
        } else {
            // 맵 뷰가 없다면?
            
            // 해당 아파트 코드가 갖고있는 마커가 nil이 아니라면?
            if self.markerCode[self.normalMarkers[index].code!] != nil {
                print("해당 아파트 코드가 갖고있는 마커가 이미 있기 때문에 뜨는 것! 그래서 다시 mapView를 마커에 넣어주는")
                self.markerCode[self.normalMarkers[index].code!]?.mapView = mapView
            } else {
                
                
                
                if optionName == "" { // option이 없을 때 이미지
                    
                    print("basic 마커 생성중...~")
                    
                    let makingBasicMarker = MarkerImageCell(scale: self.normalMarkers[index].scale, price: self.normalMarkers[index].price)
                    let image = makingBasicMarker.snapshot()
                    
                    let image2 = NMFOverlayImage(image: image)
                    
                    // 마커 생성
                    let marker = NMFMarker()
                    marker.position = NMGLatLng(lat: self.normalMarkers[index].lat!, lng: self.normalMarkers[index].lng!)
                    
                    marker.mapView = mapView
                    marker.iconImage = image2
                    
                    
                    
                    // 해당 마커 줌레벨 조절
                    marker.minZoom = 12
                    marker.isMinZoomInclusive = true
                    
                    
                    marker.touchHandler = { (overlay) -> Bool in
                        print("touch")
                        return true // 이벤트 소비, -mapView:didTapMap:point 이벤트는 발생하지 않음
                    }
                    
                    // 딕셔너리에 해당 아파트 코드를 Key 그리고 벨류를 해당 아파트의 마커로 insert
                    self.markerCode[self.normalMarkers[index].code!] = marker
                } else { // option이 있을 때 이미지
                    
                    if optionName == "A" {
                        
                        print("A 마커 생성중...~")
                        
                        let makingOptionMarker = MarkerOptionImageCell(scale: self.normalMarkers[index].scale, price: self.normalMarkers[index].price, pickedOption: self.normalMarkers[index].aa)

                        let image = makingOptionMarker.snapshot()

                        let image2 = NMFOverlayImage(image: image)

                        // 마커 생성
                        let marker = NMFMarker()
                        
                        marker.position = NMGLatLng(lat: self.normalMarkers[index].lat!, lng: self.normalMarkers[index].lng!)
                        
                        marker.mapView = mapView
                   
                        marker.iconImage = image2
                        
                     
                        // 해당 마커 줌레벨 조절
                        marker.minZoom = 12
                        marker.isMinZoomInclusive = true
                        
                        
                        marker.touchHandler = { (overlay) -> Bool in
                            print("touch")
                            return true // 이벤트 소비, -mapView:didTapMap:point 이벤트는 발생하지 않음
                        }
                        // 딕셔너리에 해당 아파트 코드를 Key 그리고 벨류를 해당 아파트의 마커로 insert
                        self.markerCode[self.normalMarkers[index].code!] = marker
                        
                    } else if optionName == "B" {
                        
                        print("B 마커 생성중...~")
                        
                        let makingOptionMarker = MarkerOptionImageCell(scale: self.normalMarkers[index].scale, price: self.normalMarkers[index].price, pickedOption: self.normalMarkers[index].bb)
                    
                        
                        let image = makingOptionMarker.snapshot()
                        let image2 = NMFOverlayImage(image: image)
                        // 마커 생성
                        let marker = NMFMarker()
                        marker.position = NMGLatLng(lat: self.normalMarkers[index].lat!, lng: self.normalMarkers[index].lng!)
                        
                        marker.mapView = mapView
                        marker.iconImage = image2
                        
                        // 해당 마커 줌레벨 조절
                        marker.minZoom = 12
                        marker.isMinZoomInclusive = true
                        
                        
                        marker.touchHandler = { (overlay) -> Bool in
                            print("\(self.normalMarkers[index].scale!)")
                            return true // 이벤트 소비, -mapView:didTapMap:point 이벤트는 발생하지 않음
                        }
                        // 딕셔너리에 해당 아파트 코드를 Key 그리고 벨류를 해당 아파트의 마커로 insert
                        self.markerCode[self.normalMarkers[index].code!] = marker
                    }
                    
                    
                }
                
                
            }
        }
    }
    
    func deleteMarkerMapView() {
        
        for index in 0..<self.normalMarkers.count {
            
            self.markerCode[index]?.mapView = nil
            
        }
        
        
    }
    
    func remakeOptionMarker (mapView: NMFMapView, swLat: Double, swLng: Double, neLat: Double, neLng: Double) {
        print("Before remakeOptionmarker: \(self.normalMarkers)")
        
        deleteMarkerMapView() // 기존 맵에있는 마커 지우기
        //        self.normalMarkers.removeAll() // 리스트 한 번 다 지우기
        self.markerCode.removeAll() // 마커 한 번 다 지우기
        
        //        self.sampleDB() // 다시 디비 넣기
        //        self.normalMarkers.append(Markers(lat: 37.565117835910414, lng: 126.97779576693473, scale: "10번", price: "째엿", aa: "A11", bb: "B1", code: 10))
        
        print("After remakeOptionmarker: \(self.normalMarkers)")
        
        for index in 0..<normalMarkers.count {
            
            
            if self.normalMarkers[index].lat! > swLat && self.normalMarkers[index].lat! < neLat && self.normalMarkers[index].lng! > swLng && self.normalMarkers[index].lng! < neLng {
                
                if optionName == "" { // 기본 마커
                    print("remakeOptionMarker의 option이 기본일때@")
                    checkAndMakeMarker(index, mapView, optionName) // 마커 체크 & 만들기
                } else { // 마커에 옵션이 있는
                    print("remakeOptionMarker의 option이 있을때@")
                    checkAndMakeMarker(index, mapView, optionName) // 마커 체크 & 만들기
                }
                
                
                
            } else { // 카메라 범위 밖에 있다면 ?
                
                self.markerCode[self.normalMarkers[index].code!]?.mapView = nil // 맵 밖에 있는 마커들을 안띄우게
                
            }
            
        }
    }
    
    func realMakeMarker (mapView: NMFMapView, swLat: Double, swLng: Double, neLat: Double, neLng: Double, changedOption: String) {
        
        if isOption { // true면 다 지우고
            deleteMarkerMapView() // 기존 맵에있는 마커 지우기
            //        self.normalMarkers.removeAll() // 리스트 한 번 다 지우기
            self.markerCode.removeAll() // 마커 한 번 다 지우기
            isOption = false // 지우고 나서 다시 false로 만들어주기
        } else {
            
        }
        
        print("Before realMakeMarker: \(self.normalMarkers)")
        
        //        print("swLat:  \(swLat)")
        //        print("swLng: \(swLng)")
        //        print("neLat: \(neLat)")
        //        print("neLng: \(neLng)")
        
        // 맵뷰에 마커를 띄우는
        
        for index in 0..<self.normalMarkers.count {
            
            if self.normalMarkers[index].lat! > swLat && self.normalMarkers[index].lat! < neLat && self.normalMarkers[index].lng! > swLng && self.normalMarkers[index].lng! < neLng {
                
                if changedOption == "" { // 기본 마커
                    print("realMakeMarker의 option이 기본일때")
                    checkAndMakeMarker(index, mapView, changedOption) // 마커 체크 & 만들기
                } else { // 마커에 옵션이 있는
                    print("realMakeMarker의 option이 있을 때")
                    checkAndMakeMarker(index, mapView, changedOption) // 마커 체크 & 만들기
                }
                
                
                
            } else { // 카메라 범위 밖에 있다면 ?
                
                self.markerCode[self.normalMarkers[index].code!]?.mapView = nil // 맵 밖에 있는 마커들을 안띄우게
                
            }
            
        }
    }
    
    struct Markers {
        
        var lat: Double?
        var lng: Double?
        var scale: String?
        var price: String?
        var aa: String?
        var bb: String?
        var C: String?
        var code: Int?
        
    }
}

class Markers2: ObservableObject {
    var lat: Double?
    var lng: Double?
    var scale: String?
    var price: String?
    var option: String?
    var code: Int?
}


// 뷰를 이미지로 스냅샷
extension View {
    func snapshot() -> UIImage {
        let controller = UIHostingController(rootView: self.edgesIgnoringSafeArea(.all))
        let view = controller.view
        
        let targetSize = controller.view.intrinsicContentSize
        
        view?.bounds = CGRect(origin: .zero, size: targetSize)
        view?.backgroundColor = .clear
        
        let renderer = UIGraphicsImageRenderer(size: targetSize)
        
        return renderer.image { _ in
            view?.drawHierarchy(in: controller.view.bounds, afterScreenUpdates: true)
        }
    }
}
