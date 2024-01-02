//
//  SceneDelegate.swift
//  FindMyVehicle
//
//  Created by ndyyy on 26/12/23.
//

import UIKit
import SwiftUI

@Observable
class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    weak var windowScene: UIWindowScene?
    var tabWindow: UIWindow?
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        windowScene = scene as? UIWindowScene
    }
    
    func addTabBar(_ homeVM: HomeViewModel) {
        guard let scene = windowScene else { return }
        
        let tabBarController = UIHostingController(rootView:
            CustomTabBar()
            .environmentObject(homeVM)
            .frame(maxHeight: .infinity, alignment: .bottom)
            .ignoresSafeArea(.keyboard, edges: .bottom)
        )
        
        tabBarController.view.backgroundColor = .clear
        
        let tabWindow = PassThroughWindow(windowScene: scene)
        tabWindow.rootViewController = tabBarController
        tabWindow.isHidden = false
        
        self.tabWindow = tabWindow
    }
}

class PassThroughWindow: UIWindow {
    override func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
        guard let view = super.hitTest(point, with: event) else {return nil}
        return view == rootViewController?.view ? nil : view
    }
}
