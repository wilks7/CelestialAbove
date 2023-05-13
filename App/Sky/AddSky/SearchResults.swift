//
//  SearchResults.swift
//  CelestialAbove
//
//  Created by Michael Wilkowski on 5/11/23.
//


import SwiftUI
import Combine
import MapKit
import CoreLocation
import CoreData


class SearchResults: NSObject, ObservableObject {
    
    struct Sky: Identifiable {
        let id = UUID()
        let title: String
        let location: CLLocation
        let timezone: TimeZone
    }
    
    @Published var results: [MKLocalSearchCompletion] = []
    @Published var tappedSky: Sky?
    @Published var searchTerm = ""
    
    var location: CLLocation? {
        guard searchTerm.contains(",") else {return nil}
        let seperated = searchTerm.components(separatedBy: ",")
        guard let first = seperated.first, let last = seperated.last
            else {return nil}
        guard let latitude = Double(first), let longitude = Double(last)
            else {return nil}
        return CLLocation(latitude: latitude, longitude: longitude)
    }
    
    var validCoordinate: Bool {
        if let location {
            return CLLocationCoordinate2DIsValid(location.coordinate)
        } else {return false}
    }

    private var searchCompleter = MKLocalSearchCompleter()

    override init(){
        super.init()
        searchCompleter.delegate = self
        searchCompleter.resultTypes = [.address]
    }
    
//    private lazy var localSearchCompleter: MKLocalSearchCompleter = {
//        let completer = MKLocalSearchCompleter()
//
//        return completer
//    }()
    
    func searchAddress(_ text: String) {
        guard text.isEmpty == false else { return }
        searchCompleter.queryFragment = text
    }
    
    func clear(){
        Task{@MainActor in
            self.results = []
            self.searchTerm = ""
        }
    }
}

extension SearchResults: MKLocalSearchCompleterDelegate {
    func completerDidUpdateResults(_ completer: MKLocalSearchCompleter) {
        Task { @MainActor in
            self.results = completer.results.filter{!$0.subtitle.isEmpty}
        }
    }
    
    func completer(_ completer: MKLocalSearchCompleter, didFailWithError error: Error) {
        print(error)
    }
    
    func tapped(_ result: MKLocalSearchCompletion) async -> Void {
        
        let searchRequest = MKLocalSearch.Request(completion: result)
        let response = try? await MKLocalSearch(request: searchRequest).start()
        
        let placemark = response?.mapItems.first?.placemark
        let timezone = response?.mapItems.first?.timeZone
        
        guard let placemark, let timezone, let location = placemark.location
        else { print("[SearchResults] Could Not Find Timezone or Location");return }
            
        let title = result.title.components(separatedBy: ",").first ?? placemark.administrativeArea ?? location.id
        Task{@MainActor in
            let sky = Sky(title: title, location: location, timezone: timezone)
            self.tappedSky = sky
        }

    }
    
    #warning("show error")
    func tapped(_ location: CLLocation) async -> Void {
        let placemarks = try? await CLGeocoder().reverseGeocodeLocation(location)
        guard let placemark = placemarks?.first,let timezone = placemark.timeZone
            else { return }

        Task{@MainActor in
            let sky = Sky(title: location.id, location: location, timezone: timezone)
            self.tappedSky = sky
        }

    }
}






//
//class SearchResults: NSObject, ObservableObject {
//
//    @Published var results : [MKLocalSearchCompletion] = []
//    @Published var searchTerm = ""
//    @Published var tappedSky: SkyKey?
//
//    private var cancellables : Set<AnyCancellable> = []
//
//    private var searchCompleter = MKLocalSearchCompleter()
//    private var currentPromise : ((Result<[MKLocalSearchCompletion], Error>) -> Void)?
//
//    override init(){
//        super.init()
//
//        searchCompleter.delegate = self
//        searchCompleter.resultTypes = MKLocalSearchCompleter.ResultType([.address])
//
//        $searchTerm
//            .debounce(for: .seconds(0.2), scheduler: RunLoop.main)
//            .removeDuplicates()
//            .flatMap({ (currentSearchTerm) in
//                self.searchTermToResults(searchTerm: currentSearchTerm)
//            })
//            .sink(receiveCompletion: { (completion) in
//                //handle error
//            }, receiveValue: { (results) in
//                self.results = results//.filter { $0.subtitle.contains("United States") }
//            })
//            .store(in: &cancellables)
//
//    }
//
//    @MainActor
//    func tapped(_ location: MKLocalSearchCompletion) async -> Void {
//
//        let searchRequest = MKLocalSearch.Request(completion: location)
//        let response = try? await MKLocalSearch(request: searchRequest).start()
//        let placemark = response?.mapItems.first?.placemark
//        let timezone = response?.mapItems.first?.timeZone
//
//        if let placemark, let timezone, let location = placemark.location {
//            let title = placemark.locality ?? placemark.postalCode ?? location.id
//            self.tappedSky = .init(title: title, location: location, timezone: timezone)
//        } else {
//            print("[SearchResults] Could Not Add Location")
//        }
//    }
//
//    func clear() {
//        Task {@MainActor in
//            withAnimation {
//                self.searchTerm = ""
//                self.results = []
//                self.tappedSky = nil
//            }
//        }
//    }
//}
//
//extension SearchResults: MKLocalSearchCompleterDelegate {
//
//    func searchTermToResults(searchTerm: String) -> Future<[MKLocalSearchCompletion], Error> {
//        Future { promise in
//            self.searchCompleter.queryFragment = searchTerm
//            self.currentPromise = promise
//        }
//    }
//
//    func completerDidUpdateResults(_ completer: MKLocalSearchCompleter) {
//        currentPromise?(.success(completer.results))
//    }
//}




