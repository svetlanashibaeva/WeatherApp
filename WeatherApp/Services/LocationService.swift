//
//  LocationService.swift
//  WeatherApp
//
//  Created by Светлана Шибаева on 19.07.2024.
//

import Foundation
import CoreLocation

protocol LocationServiceProtocol {
    func start(delegate: LocationServiceDelegate)
}

protocol LocationServiceDelegate: AnyObject {
    typealias Location = (cityName: String, coordinates: CLLocation)
    
    func didChangeAuthorizationStatus(status: CLAuthorizationStatus)
    func didChangeLocation(location: Location)
}

final class LocationService: NSObject, LocationServiceProtocol {
    
    private let locationManager: CLLocationManager
    private weak var delegate: LocationServiceDelegate?
    
    override init() {
        locationManager = CLLocationManager()
        super.init()
        locationManager.delegate = self
        locationManager.distanceFilter = 100
    }
    
    func start(delegate: LocationServiceDelegate) {
        self.delegate = delegate
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
    }
}

private extension LocationService {
    
    func setCityName(from location: CLLocation) {
        
        let geocoder = CLGeocoder()
        geocoder.reverseGeocodeLocation(location) { [weak self] placemarks, error in
            guard let placemark = placemarks?.first,
                  let cityName = placemark.locality
            else { return }
            self?.delegate?.didChangeLocation(location: (cityName: cityName, coordinates: location))
        }
    }
}

extension LocationService: CLLocationManagerDelegate {
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        delegate?.didChangeAuthorizationStatus(status: manager.authorizationStatus)
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else { return }
        
        setCityName(from: location)
    }
}
