//
//  SkySearchView.swift
//  CelestialAbove
//
//  Created by Michael Wilkowski on 5/11/23.
//

import SwiftUI
import CoreData

extension View {
    func skySearchable() -> some View { modifier( SkySearchView() ) }
}
struct SkySearchView: ViewModifier {
    @Environment(\.managedObjectContext) private var context
    @Environment(\.isSearching) private var isSearching: Bool
    
    @StateObject var model = SearchResults()
    
    func body(content: Content) -> some View {
        content
        .searchable(text: $model.searchTerm, prompt: "Search for a city or coordinate") {
            if let location = model.location, model.validCoordinate {
                AsyncButton(action: {
                    await model.tapped(location)
                } ,actionOptions: [.disableButton]) {
                    Text("Coordinate: " + location.id)
                }
            } else if model.results.isEmpty {
                emptyResults
            } else {
                results
            }
        }
        .onChange(of: model.searchTerm) { value in
            if value.isEmpty && !isSearching {
                Task{@MainActor in
                    model.results = []
                }
            } else {
                model.searchAddress(value)
            }
        }
        .sheet(item: $model.tappedSky) { searchSky in
            NewSkyView(searchSky: searchSky)
                .environmentObject(model)
        }
    }
    
    var results: some View {
        ForEach(model.results, id: \.description) { result in
            AsyncButton(action: {
                await model.tapped(result)
            },actionOptions: [.disableButton]) {
                HighlightedText(result.title + " " + result.subtitle, matching: model.searchTerm)
            }
        }
    }
    
    var emptyResults: some View {
        HStack {
            Spacer()
            VStack {
                Image(systemName: "magnifyingglass")
                    .font(.largeTitle)
                    .foregroundStyle(.gray)
                Text("No Results")
                    .font(.title3.weight(.heavy))
                Text("No results found for '\(model.searchTerm)' ")
            }
            .padding(.top, 64)
            Spacer()
        }
    }
}

extension SkySearchView {
    
    struct HighlightedText: View {
        let text: String
        let matching: String
        let caseInsensitiv: Bool

        init(_ text: String, matching: String, caseInsensitiv: Bool = true) {
            self.text = text
            self.matching = matching
            self.caseInsensitiv = caseInsensitiv
        }

        var body: some View {
            guard  let regex = try? NSRegularExpression(pattern: NSRegularExpression.escapedPattern(for: matching).trimmingCharacters(in: .whitespacesAndNewlines).folding(options: .regularExpression, locale: .current), options: caseInsensitiv ? .caseInsensitive : .init()) else {
                return Text(text)
            }

            let range = NSRange(location: 0, length: text.count)
            let matches = regex.matches(in: text, options: .withTransparentBounds, range: range)

            return text.enumerated().map { (char) -> Text in
                guard matches.filter( {
                    $0.range.contains(char.offset)
                }).count == 0 else {
                    return Text( String(char.element) ).foregroundColor(.white)
                }
                return Text( String(char.element) ).foregroundColor(.gray)

            }.reduce(Text("")) { (a, b) -> Text in
                return a + b
            }
        }
    }    
}



struct SkySearchView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            List {
                Text("List")
            }
            .skySearchable()
        }
    }
}
