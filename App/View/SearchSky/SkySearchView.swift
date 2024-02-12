//
//  SkySearchView.swift
//  CelestialAbove
//
//  Created by Michael Wilkowski on 5/11/23.
//

import SwiftUI
import CoreData

extension View {
    func skySearchable(add: @escaping (SkyKey) -> Void) -> some View {
        modifier( SkySearchView(add: add) )
    }
}
struct SkySearchView: ViewModifier {
    @Environment(\.isSearching) private var isSearching: Bool
    
    @StateObject var model = SearchResults()
    
    var add: (SkyKey) -> Void
    
    func body(content: Content) -> some View {
        content
        .searchable(text: $model.searchTerm, prompt: "Search for a city or coordinate") {
            if model.results.isEmpty {
                if let location = model.location {
                    Button {
                        Task {
                            await model.tapped(location)
                        }
                    } label: {
                        Text("Coordinate: " + location.id)
                    }
                } else {
                    ContentUnavailableView("No Results", 
                        systemImage: "magnifyingglass",
                        description: Text("No results matching '\(model.searchTerm)'")
                    )
                }
            } else {
                ForEach(model.results, id: \.description) { result in
                    Button {
                        Task {
                            await model.tapped(result)
                        }
                    } label: {
                        HighlightedText(result.title + " " + result.subtitle, matching: model.searchTerm)
                    }
                }
            }
        }
        .onChange(of: model.searchTerm) { _, value in
            if value.isEmpty && !isSearching {
                Task{@MainActor in
                    model.results = []
                }
            } else {
                model.searchAddress(value)
            }
        }
        .sheet(item: $model.tappedSky,
            onDismiss: { model.tappedSky = nil },
            content: { tappedSky in
                NewSkyView(searchSky: tappedSky, add: add)
            }
        )

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

#Preview {
    NavigationStack {
        List {
            Text("List")
        }
        .skySearchable{ key in}
    }
}
