//
//  WeatherAppTests.swift
//  WeatherAppTests
//
//  Created by Fahad Baig on 14/01/2022.
//

import XCTest
@testable import WeatherApp
@testable import Store

class WeatherAppTests: XCTestCase {

    func testLocationStatusUnAuthorizedState() {
        
    }
    
    func testLocationStatusAuthorizedState() {
        
    }
    
    func makeSut(location: CLLocation = CLLocation(), status: CLAuthorizationStatus = .unauthorized, city: String = "") -> WeatherForecastViewModel {
        let locationProvider = MockLocationProvider(location: location, status: status, city: city)
        let service =
        let sut = WeatherForecastViewModel()
        return sut
    }
}

class MockLocationProvider: LocationProvider {
    
    var location: Observable<CLLocation> {get}
    var status: Observable<CLAuthorizationStatus> {get}
    let city: String
    let locationValue: CLLocation
    let statusValue: CLAuthorizationStatus
    
    init(location: CLLocation, status: CLAuthorizationStatus, city: String) {
        self.locationValue = location
        self.status = status
    }
    
    func requestLocation(frequency: Frequency) {
        location = Observable.just(locationValue)
        status = Observable.just(status)
    }
    
    func getCity(location: CLLocation) -> Single<String> {
        return Observable.just(city).asSingle()
    }
}
