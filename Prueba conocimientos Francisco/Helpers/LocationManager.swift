//
//  LocationManager.swift
//  Prueba conocimientos Francisco
//
//  Created by Francisco Guerrero Escamilla on 22/02/21.
//

import Foundation
import CoreLocation

protocol LocationUpdateProtocol: class {
    func locationDidUpdate(to location: CLLocation)
}

let kLocationDidChangeNotification = "LocationDidChangeNotification"
let kLocationDidChangeAuthorization = "LocationDidChangeAuthorization"

class LocationManager: NSObject {
    
    // MARK: - Properties
    
    static let shared = LocationManager()
    
    private var locationManager = CLLocationManager()
    
    var currentLocation: CLLocation? {
        return locationManager.location
    }
    
    weak var delegate: LocationUpdateProtocol?
    
    private var timerUser: Timer?
    
    private static let minute = 60.0
    
    // MARK: - Init
    
    private override init() {
        super.init()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.distanceFilter = kCLLocationAccuracyHundredMeters
        locationManager.requestAlwaysAuthorization()
        locationManager.startUpdatingLocation()
    }
    
    // MARK: - Public functions
    
    func startSignificantLocationChanges() {
        if !CLLocationManager.significantLocationChangeMonitoringAvailable() {
            print("Significant location change monitoring not available.")
            return
        }
        print("Significant location change monitoring not available")
        locationManager.startMonitoringSignificantLocationChanges()
    }
    
    func getPlacemark(from location: CLLocation, completion: @escaping(_ placemark: CLPlacemark) -> Void) {
        let geocoder = CLGeocoder()
        geocoder.reverseGeocodeLocation(location) { (placemarks, error) in
            if let placemark = placemarks?.first {
                completion(placemark)
            }
        }
    }
    
    func getLocationPerMinute() {
        timerUser = Timer.scheduledTimer(withTimeInterval: 60.0, repeats: true, block: { [weak self] (_) in
            if let location = self?.currentLocation {
                let userInfo = ["location": location]
                NotificationCenter.default.post(name: NSNotification.Name.init(kLocationDidChangeNotification), object: self, userInfo: userInfo)
            }
        })
    }
    
    func stopUserLocation() {
        timerUser?.invalidate()
    }
    
}

// MARK: - CLLocationManagerDelegate

extension LocationManager: CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if status != .authorizedAlways {
            print("Location not authorized")
            NotificationCenter.default.post(name: NSNotification.Name.init(kLocationDidChangeAuthorization), object: self)
        }
        print("Location authorized")
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let currentLocation = locations.last {
            delegate?.locationDidUpdate(to: currentLocation)
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        if let error = error as? CLError, error.code == .denied {
            print("ERROR: Location updates are not authorized")
            manager.stopMonitoringSignificantLocationChanges()
            return
        }
    }
}

