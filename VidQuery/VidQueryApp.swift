//
//  VidQueryApp.swift
//  VidQuery
//
//  Created by Zheng on 2/26/21.
//

import SwiftUI

@main
struct VidQueryApp: App {
    
    #if os(macOS)
    @NSApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    #endif
    
    @AppStorage("appearance") var appearance: Appearance = .system

    var body: some Scene {
        WindowGroup {
            ContentView()
                .onAppear(perform: {
                    #if os(macOS)
                    switch appearance {
                        case .system: NSApp.appearance = nil
                        case .light: NSApp.appearance = NSAppearance(named: .aqua)
                        case .dark: NSApp.appearance = NSAppearance(named: .darkAqua)
                    }
                    #endif
                })
        }
        .commands {
            #if os(macOS)
            CommandGroup(replacing: CommandGroupPlacement.appInfo) {
                Button(action: {
                    appDelegate.showAboutPanel()
                }) {
                    Text("About VidQuery")
                }
            }

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
            #endif
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
