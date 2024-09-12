//
//  MainTabBarController.swift
//  TodoAppUiKItWithSwiftui
//
//  Created by Sumit on 12/09/24.
//

import SwiftUI
import UIKit

class MainTabBarController: UITabBarController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Initialize UIKit view controller from a different storyboard
        let storyboard = UIStoryboard(name: "TasksTableViewController", bundle: nil)
        if let uiKitVC = storyboard.instantiateViewController(withIdentifier: "TasksTableViewController") as? TasksTableViewController {
            let uiKitNavController = UINavigationController(rootViewController: uiKitVC)
            
            // Set custom image for the tab bar item
            uiKitNavController.tabBarItem = UITabBarItem(
                title: "UIkit",
                image: UIImage(named: "uiKit"),
                selectedImage: UIImage(named: "uiKit")
            )
            
            // Initialize SwiftUI view controller
            let swiftUIVC = TaskListView()
            let swiftUIHostingController = UIHostingController(rootView: swiftUIVC)
            
            // Set custom image for the tab bar item
            swiftUIHostingController.tabBarItem = UITabBarItem(
                title: "SwiftUI",
                image: UIImage(named: "swiftui"),
                selectedImage: UIImage(named: "swiftui")
            )
            
            viewControllers = [uiKitNavController, swiftUIHostingController]
        }
    }
}
