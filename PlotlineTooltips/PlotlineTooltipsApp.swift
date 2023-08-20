//
//  TooltipShape.swift
//  PlotlineTooltips
//
//  Created by Agrim Srivastava on 19/08/23.
//

import SwiftUI
import Firebase


class AppDelegate: NSObject, UIApplicationDelegate {
  func application(_ application: UIApplication,
                   didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
    FirebaseApp.configure()

    return true
  }
}

@main
struct PlotlineAssignemnt: App {
    @StateObject var appState = AppState()
    @StateObject var tooltipData = TooltipData()
    
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    
    var body: some Scene {
        WindowGroup {
            if appState.isTooltipViewActive {
                TooltipView(data: tooltipData)
            } else {
                InitialConfigurationView(data: tooltipData, appState: appState)
            }
        }
    }
}

public class AppState: ObservableObject {
    @Published var isTooltipViewActive: Bool = false
}
