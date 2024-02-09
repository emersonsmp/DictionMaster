//
//  DictionMasterApp.swift
//  DictionMaster
//
//  Created by Emerson Sampaio on 04/02/24.
//

import SwiftUI
import AlamofireNetworkActivityLogger

@main
struct DictionMasterApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}

class AppDelegate: NSObject, UIApplicationDelegate {
    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions:
                     [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
#if DEBUG
        NetworkActivityLogger.shared.level = .debug
        NetworkActivityLogger.shared.startLogging()
#endif
        return true
    }
}

