//
//  WorkoutTimerBundle.swift
//  WorkoutTimer
//

import WidgetKit
import SwiftUI

@main
struct WorkoutTimerBundle: WidgetBundle {
    var body: some Widget {
        if #available(iOS 16.1, *) {
            WorkoutTimerLiveActivity()
        }
    }
}
