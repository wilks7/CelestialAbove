//
//  NavigationManager.swift
//  CelestialAbove
//
//  Created by Michael Wilkowski on 5/12/23.
//

import SwiftUI

class NavigationManager: ObservableObject {
    static let shared = NavigationManager()
    @Published var selected: Sky?
    @Published var showSettings = false
    @Published var path = NavigationPath()
    
    @MainActor
    func navigate(to sky: Sky) {
        withAnimation {
            self.selected = sky
        }
    }
    
    @MainActor
    func navigateList() {
        withAnimation {
            self.selected = nil
        }
    }
}
