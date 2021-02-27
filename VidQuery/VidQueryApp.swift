//
//  VidQueryApp.swift
//  VidQuery
//
//  Created by Zheng on 2/26/21.
//

import SwiftUI

@main
struct VidQueryApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
                .onAppear(perform: {
                    NSApp.appearance = NSAppearance(named: .aqua)
                })
        }
    }
}
