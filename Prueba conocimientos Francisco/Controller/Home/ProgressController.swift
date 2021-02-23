//
//  ProgressController.swift
//  Prueba conocimientos Francisco
//
//  Created by Francisco Guerrero Escamilla on 21/02/21.
//

import UIKit
import JGProgressHUD
import Mapbox
import MapKit

class ProgressController: UIViewController {
    
    //MARK: - Properties
    let url = URL(string: "mapbox://styles/mapbox/streets-v10")
    var mapView: MGLMapView?
    
    lazy var downloadButton = UIButton(title: "Descargar mapa", titleColor: .red, target: self, action: #selector(downloadTapped))
    
    let locationManager = LocationManager.shared
    //MARK: - Init
    
    //MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        resetMap()
        LocationManager.shared.getLocationPerMinute()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        LocationManager.shared.stopUserLocation()
    }
    
    //MARK: - Helpers
    
    private func setupView() {
        
        view.backgroundColor = .white
        mapView = MGLMapView(frame: CGRect.zero, styleURL: url)
        mapView?.styleURL = MGLStyle.lightStyleURL
        mapView?.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        mapView?.tintColor = .darkGray
        mapView?.zoomLevel = 1
        mapView?.delegate = self
        mapView?.automaticallyAdjustsContentInset = true
        mapView?.showsUserLocation = true
        mapView?.showsHeading = true
        
        downloadButton.roundedButton(cornerRadius: 25, color: .red)
        setupMapCenter()
        
        view.addSubview(mapView!)
        view.addSubview(downloadButton)
        
        mapView?.anchor(top: view.safeAreaLayoutGuide.topAnchor, leading: view.leadingAnchor, bottom: nil, trailing: view.trailingAnchor, padding: .init(top: 18, left: 12, bottom: 0, right: 12))
        mapView?.withHeight(view.frame.height / 2)
        
        downloadButton.anchor(top: mapView!.bottomAnchor, leading: mapView!.leadingAnchor, bottom: nil, trailing: nil, padding: .init(top: 18, left: 18, bottom: 0, right: 0), size: .init(width: 150, height: 50))
    }
    
    private func setupMapCenter() {
        let coordinates = locationManager.currentLocation?.coordinate
        let centerCoordinate = CLLocationCoordinate2D(latitude: coordinates?.latitude ?? 0.00, longitude: coordinates?.longitude ?? 0.00)
        mapView?.setCenter(centerCoordinate, zoomLevel: 15, animated: false)
    }
    
    private func resetMap() {
        MGLOfflineStorage.shared.resetDatabase { [unowned self] (error) in
            if let error = error {
                print(error)
                
            } else {
                MGLOfflineStorage.shared.reloadPacks()
            }
        }
    }
    
    func setupOfflinePackHandler() {
        NotificationCenter.default.addObserver(self,
        selector: #selector(offlinePackProgressDidChange),
        name: NSNotification.Name.MGLOfflinePackProgressChanged,
        object: nil)
    }
    
    //MARK: - Selectors
    
    @objc private func downloadTapped() {
        setupOfflinePackHandler()
         
        let region = MGLTilePyramidOfflineRegion(styleURL: mapView!.styleURL, bounds: mapView!.visibleCoordinateBounds, fromZoomLevel: mapView!.zoomLevel, toZoomLevel: mapView!.zoomLevel + 2)
        
        let userInfo = ["name": "\(region.bounds)"]
        do {
            let context =  try NSKeyedArchiver.archivedData(withRootObject: userInfo, requiringSecureCoding: false)
            MGLOfflineStorage.shared.addPack(for: region, withContext: context) { (pack, error) in
                guard error == nil else {
                    print("Error: \(error?.localizedDescription ?? "unknown error")")
                    return
                }
                pack!.resume()
            }
        } catch {
            print("Debug error \(error)")
        }
    }
    
    @objc func offlinePackProgressDidChange(notification: NSNotification) {
    
        if let pack = notification.object as? MGLOfflinePack,
           let userInfo = NSKeyedUnarchiver.unarchiveObject(with: pack.context) as? [String: String] {
         
            if pack.state == .complete {
                let _ = ByteCountFormatter.string(fromByteCount: Int64(pack.progress.countOfBytesCompleted), countStyle: ByteCountFormatter.CountStyle.memory)
                let _ = userInfo["name"] ?? "unknown"
             
                NotificationCenter.default.removeObserver(self, name: NSNotification.Name.MGLOfflinePackProgressChanged, object: nil)
            }
        }
    }
}

//MARK: - Extensions

extension ProgressController: MGLMapViewDelegate {
    func mapView(_ mapView: MGLMapView, didFinishLoading style: MGLStyle) {
     
        let point = MGLPointAnnotation()
        point.coordinate = mapView.centerCoordinate
     
        let shapeSource = MGLShapeSource(identifier: "marker-source", shape: point, options: nil)
     
    
        let shapeLayer = MGLSymbolStyleLayer(identifier: "marker-style", source: shapeSource)
     
        if let image = UIImage(named: "house-icon") {
            style.setImage(image, forName: "home-symbol")
        }
     
    
        shapeLayer.iconImageName = NSExpression(forConstantValue: "home-symbol")
     
        style.addSource(shapeSource)
        style.addLayer(shapeLayer)
    }
    
    
}
