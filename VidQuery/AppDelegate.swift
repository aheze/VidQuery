//
//  AppDelegate.swift
//  VidQuery
//
//  Created by H. Kamran on 2/27/21.
//

import Foundation
import SwiftUI

class AppDelegate: NSObject, NSApplicationDelegate {
    private var aboutBoxWindowController: NSWindowController?

    func showAboutPanel() {
        if aboutBoxWindowController == nil {
            let styleMask: NSWindow.StyleMask = [.closable, .miniaturizable, .resizable, .titled]
            let window = NSWindow()
            window.styleMask = styleMask
            window.title = "About VidQuery"
            window.contentView = NSHostingView(rootView: AboutView())
            aboutBoxWindowController = NSWindowController(window: window)
        }

        aboutBoxWindowController?.showWindow(aboutBoxWindowController?.window)
    }
}
