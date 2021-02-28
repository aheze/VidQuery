//
//  VidQueryApp.swift
//  VidQuery
//
//  Created by Zheng on 2/26/21.
//

import SwiftUI

@main
struct VidQueryApp: App {
    @AppStorage("appearance") var appearance: Appearance = .system

    var body: some Scene {
        WindowGroup {
            ContentView()
                .onAppear(perform: {
                    NSApp.appearance = NSAppearance(named: .aqua)
                })
        }
        .commands {
            CommandGroup(before: .sidebar) {
                Menu("Theme") {
                    Button(action: {
                        NSApp.appearance = NSAppearance(named: .aqua)
                        appearance = .light
                    }) {
                        Text("Light mode")
                            .fontWeight(.medium)
                    }
                    .modifier(MenuButtonStyling())

                    Button(action: {
                        NSApp.appearance = NSAppearance(named: .darkAqua)
                        appearance = .dark
                    }) {
                        Text("Dark mode")
                            .fontWeight(.medium)
                    }
                    .modifier(MenuButtonStyling())

                    Button(action: {
                        NSApp.appearance = nil
                        appearance = .system
                    }) {
                        Text("System mode")
                            .fontWeight(.medium)
                    }
                    .modifier(MenuButtonStyling())
                }
            }
        }
    }
}

struct MenuButtonStyling: ViewModifier {
    func body(content: Content) -> some View {
        content
            .foregroundColor(.primary)
            .padding(.bottom, 2)
            .padding(.top, 1)
    }
}
