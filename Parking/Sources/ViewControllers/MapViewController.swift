//
//  MapViewController.swift
//  Parking
//
//  Created by 신동오 on 2023/05/19.
//

import UIKit
import NMapsMap
import CoreLocation

fileprivate enum LocalConstant {
    static let zoomLevelAtFirst = 12.0
}

class MapViewController: UIViewController {
    
    // MARK: - Private property
    private let locationManager = CLLocationManager()
    private let parkinglotManager = ParkinglotManager()
    
    private lazy var naverMapView = NMFNaverMapView(frame: view.frame)
    
    private var selectedMarker: NMFMarker? {
        didSet {
            oldValue?.fitSize(accordingTo: zoomlevel)
            oldValue?.iconImage = UIConstant.markerIconImage
        }
        willSet {
            newValue?.iconImage = UIConstant.markerSelectedIconImage
            newValue?.width *= 1.5
            newValue?.height *= 1.5
        }
    }
    private var markers: [NMFMarker] = []
    private var zoomlevel: Double = LocalConstant.zoomLevelAtFirst {
        didSet {
            markers.forEach { marker in
                marker.fitSize(accordingTo: zoomlevel)
                marker.changeIcon(accordingTo: zoomlevel)
            }
        }
    }
    
    // MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // MARK: - Configure
        configure()
        
        // MARK: - 처음 위치로 화면 이동
        
        moveCameraFirst()
        
        // MARK: - Marker 표시
        markAll()
    }
    
    // MARK: - Override Function
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
    
    // MARK: - Private function
    
    private func configure() {
        configureLocation()
        configureNaverMapView()
    }
    
    private func configureLocation() {
        locationManager.requestWhenInUseAuthorization()
    }
    
    private func configureNaverMapView() {
        view.addSubview(naverMapView)
        naverMapView.mapView.addCameraDelegate(delegate: self)
        naverMapView.showCompass = true
        naverMapView.showLocationButton = true
    }
    
    private func moveCameraFirst() {
        // 추후 사용자가 마지막으로 사용한 위치에 대해서 캐싱하기
        // locationManager가 위치를 받는게 더 느리면 어떻게 처리할까?
        guard let latitude = locationManager.location?.coordinate.latitude,
              let longitude = locationManager.location?.coordinate.longitude
        else {
            return
        }
        let location = NMGLatLng(lat: latitude, lng: longitude)
        moveCameraTo(location: location)
    }
    
    private func moveCameraTo(location: NMGLatLng) {
        let param = NMFCameraUpdateParams()
        param.scroll(to: location)
        param.zoom(to: LocalConstant.zoomLevelAtFirst)
        param.tilt(to: 0)
        param.rotate(to: 0)
        naverMapView.mapView.moveCamera(NMFCameraUpdate(params: param))
    }
    
    private func moveCamera(latitude: Double, longitude: Double) {
        
    }
    
    private func markAll() {
        let items = parkinglotManager.records
        items?.forEach {
            markLocation(of: $0)
        }
    }
    
    private func markLocation(of record: Record) {
        guard let marker = NMFMarker(record: record) else {
            return
        }
        marker.captionText = record.주차장명.contains("주차장") ? record.주차장명 : record.주차장명 + "주차장"
        marker.fitSize(accordingTo: naverMapView.mapView.zoomLevel)
        marker.touchHandler = { (overlay) in
            guard self.zoomlevel >= 12 else { return false}
            self.selectedMarker = marker
            self.presentModal(with: record)
            return true
        }
        marker.mapView = naverMapView.mapView
        markers.append(marker)
    }
    
    private func presentModal(with record: Record) {
        let modalVC = ModalViewController()
        modalVC.delegate = self
        modalVC.modalPresentationStyle = .overCurrentContext
        
        let randomInt = Int.random(in: 1...3)
        modalVC.photoImageView.image = UIImage(named: "parkinglot-image\(randomInt)")
        modalVC.nameLabel.text = record.주차장명.contains("주차장") ? record.주차장명 : record.주차장명 + "주차장"
        modalVC.addressLabel.text = record.소재지도로명주소 != "" ? record.소재지도로명주소 : record.소재지지번주소
        var informationText: String = ""
        if record.주차장구분 != "" {
            informationText += record.주차장구분
        }
        if record.요금정보 != "" {
            informationText += " / \(record.요금정보)"
        }
        if record.추가단위시간 != "" && record.추가단위시간 != "0" && record.추가단위요금 != "" && record.추가단위요금 != "0" {
            informationText += " / \(record.추가단위시간)분 \(record.추가단위요금)원"
        }
        modalVC.informationLabel.text = informationText
        modalVC.phoneNumberLabel.text = record.전화번호 != "" ? record.전화번호 : "전화번호가 없습니다"
        
        switch record.요금정보 {
        case "유료":
            modalVC.paidLabel.layer.backgroundColor = UIConstant.mainUIColor.cgColor
            modalVC.paidLabel.textColor = .white
        case "무료":
            modalVC.freeLabel.layer.backgroundColor = UIConstant.mainUIColor.cgColor
            modalVC.freeLabel.textColor = .white
        default:
            break
        }
        
        let favoriteRecord = parkinglotManager.favoriteRecords?.first(where: { item in
            item.주차장관리번호 == record.주차장관리번호
        })
        if let _ = favoriteRecord {
            modalVC.favoriteIamgeView.image = UIImage(named: "favorite-icon-fill")
        }
        
        self.present(modalVC, animated: false)
    }
    
}

// MARK: - Extenstion: NMFMapViewCameraDelegate

extension MapViewController: NMFMapViewCameraDelegate {
    
    func mapView(_ mapView: NMFMapView, cameraDidChangeByReason reason: Int, animated: Bool) {
        if mapView.zoomLevel != zoomlevel {
            zoomlevel = mapView.zoomLevel
        }
    }
    
}

// MARK: - Fileprivate

fileprivate extension NMFMarker {
    
    // MARK: - Init
    
    convenience init?(record: Record) {
        if let 위도 = Double(record.위도), let 경도 = Double(record.경도) {
            self.init(position: NMGLatLng(lat: 위도, lng: 경도))
            configureAttributes()
        }
        else {
            return nil
        }
    }
    
    // MARK: - Public Function
    
    func fitSize(accordingTo zoomLevel: Double) {
        switch zoomLevel {
        case ..<10:
            self.width = 2
            self.height = 2 * 1.3
        case ..<12:
            self.width = 5
            self.height = 5 * 1.3
        case 12..<13:
            self.width = 14
            self.height = 14 * 1.3
        case 13..<14:
            self.width = 16
            self.height = 16 * 1.3
        case 14..<15:
            self.width = 18
            self.height = 18 * 1.3
        case 15...16:
            self.width = 21
            self.height = 21 * 1.3
        case 16...:
            self.width = 24
            self.height = 24 * 1.3
        default:
            self.width = 5
            self.height = 5
        }
    }
    
    func changeIcon(accordingTo zoomLevel: Double) {
        switch zoomLevel {
        case ..<12:
            self.iconImage = NMF_MARKER_IMAGE_GRAY
        default:
            self.iconImage = UIConstant.markerIconImage
        }
    }
    
    // MARK: - Private Function
    
    private func configureAttributes() {
        isHideCollidedCaptions = true
        isHideCollidedSymbols = true
        
        iconTintColor = UIConstant.mainUIColor
        iconImage = UIConstant.markerIconImage
        
        captionMinZoom = LocalConstant.zoomLevelAtFirst
    }
    
}

extension MapViewController: FavoriteViewControllerDelegate {
    
    func favoriteViewController(favoriteViewController: FavoriteViewController,willDisplay record: Record) {
        let 위도 = Double(record.위도)!
        let 경도 = Double(record.경도)!
        moveCameraTo(location: NMGLatLng(lat: 위도, lng: 경도))
        naverMapView.mapView.zoomLevel = 12
        
        let marker = markers.first { marker in
            marker.position == NMGLatLng(lat: 위도, lng: 경도)
        }
        self.selectedMarker = marker
        presentModal(with: record)
    }
    
}

extension MapViewController: ModalViewControllerProtocol {
    
    func modalWillDismiss(modalViewController: ModalViewController) {
        self.selectedMarker = nil
    }
    
}
