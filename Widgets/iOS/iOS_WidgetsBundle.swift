//
//  iOS_WidgetsBundle.swift
//  iOS Widgets
//
//  Created by Michael Wilkowski on 5/12/23.
//

import WidgetKit
import SwiftUI

@main
struct iOS_WidgetsBundle: WidgetBundle {
    var body: some Widget {
        StatusWidgets()
        #if os(iOS)
        iOS_WidgetsLiveActivity()
        #endif
    }
}
