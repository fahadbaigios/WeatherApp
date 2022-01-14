//
//  LocationManager.swift
//  WeatherApp
//
//  Created by Fahad Baig on 13/01/2022.
//

import Foundation
import CoreLocation
import RxSwift

protocol LocationProvider: AnyObject {
	var location: Observable<CLLocation> {get}
	var status: Observable<CLAuthorizationStatus> {get}
	func requestLocation(frequency: Frequency)
	func getCity(location: CLLocation) -> Single<String>
}

enum Frequency {
	case once
	case `repeat`
}

class CoreLocationProvider : NSObject, LocationProvider {

	private let locationManager = CLLocationManager()
	private var frequency: Frequency = .once
	let location: Observable<CLLocation>
	let status: Observable<CLAuthorizationStatus>
	private let _location = ReplaySubject<CLLocation>.create(bufferSize: 1)
	private let _status = ReplaySubject<CLAuthorizationStatus>.create(bufferSize: 1)

	override init() {
		self.location = _location
		self.status = _status
		super.init()
		locationManager.delegate = self
	}

	func requestLocation(frequency: Frequency) {
		self.frequency = frequency
		locationManager.requestWhenInUseAuthorization()
	}

	func stopLocationUpdate() {
		locationManager.stopUpdatingLocation()
	}

	func getCity(location: CLLocation) -> Single<String> {
		let geocoder = CLGeocoder()
		return Observable.create({ observer in
			geocoder.reverseGeocodeLocation(location) { (placemarks, error) in
                defer {observer.onCompleted()}
				guard let placemarks = placemarks, let placemark = placemarks.first else { return }
				observer.onNext(placemark.locality ?? "")
			}
			return Disposables.create()
		}).asSingle()
	}
}

//MARK: - CLLocationManagerDelegate
extension CoreLocationProvider: CLLocationManagerDelegate {

	func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
		let status = manager.getAuthorizationStatus()
		if status == .authorizedWhenInUse {
			locationManager.requestLocation()
		}
		_status.onNext(status)
	}

	func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
		switch frequency {
		case .once:
			locationManager.stopUpdatingLocation()
		case .repeat: break
		}
		guard let location = locations.first else { return }
		self._location.onNext(location)
	}

	func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
		
	}
}

extension CLLocationManager {
	func getAuthorizationStatus() -> CLAuthorizationStatus {
		let status: CLAuthorizationStatus
		if #available(iOS 14.0, *) {
			status = self.authorizationStatus
		} else {
			status = CLLocationManager.authorizationStatus()
		}
		return status
	}
}
