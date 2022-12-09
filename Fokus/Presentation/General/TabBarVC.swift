//
//  TabBarVC.swift
//  Fokus
//
//  Created by Tb. Daffa Amadeo Zhafrana on 16/11/22.
//

import UIKit

class TabBarVC: UITabBarController, UITabBarControllerDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Assign self for delegate for that ViewController can respond toUITabBarControllerDelegate methods
        self.delegate = self

        let tabBarAppearance = UITabBarAppearance()
        tabBarAppearance.configureWithOpaqueBackground()
        
        let tabBarItemAppearance = UITabBarItemAppearance()
        let normalTA = [NSAttributedString.Key.foregroundColor : UIColor(red: 224/255, green: 224/255, blue: 224/255, alpha: 1), NSAttributedString.Key.font: UIFont(name: "AtkinsonHyperlegible-Regular", size: 13)!]
        let selectedTA = [NSAttributedString.Key.foregroundColor : UIColor(red: 0, green: 172/255, blue: 141/255, alpha: 1), NSAttributedString.Key.font: UIFont(name: "AtkinsonHyperlegible-Bold", size: 13)!]
        
        tabBarItemAppearance.normal.titleTextAttributes = normalTA
        tabBarItemAppearance.selected.titleTextAttributes = selectedTA

        tabBarAppearance.inlineLayoutAppearance = tabBarItemAppearance
        tabBarAppearance.stackedLayoutAppearance = tabBarItemAppearance
        tabBarAppearance.compactInlineLayoutAppearance = tabBarItemAppearance

        
        self.tabBar.standardAppearance = tabBarAppearance
        self.tabBar.clipsToBounds = true

        let lineView = UIView(frame: CGRect(x: 0, y: 0, width: tabBar.frame.size.width, height: 2))
        lineView.backgroundColor = .turq
        
        let background = UIView(frame: CGRect(x: 0, y: 0, width: tabBar.frame.size.width, height: tabBar.frame.size.height+100))
        background.backgroundColor = .blackFokus
        
        tabBar.addSubview(background)
        tabBar.addSubview(lineView)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        UITabBarItem.appearance().setTitleTextAttributes([NSAttributedString.Key.foregroundColor : UIColor(red: 0, green: 172/255, blue: 141/255, alpha: 1), NSAttributedString.Key.font: UIFont(name: "AtkinsonHyperlegible-Regular", size: 13)!], for: .selected)
        
        // Home tab
        let tabOne = UINavigationController(rootViewController: HomeVC())
        let tabOneBarItem = UITabBarItem(title: "Home", image: UIImage(named:"Home"), selectedImage: UIImage(named: "HomeFilled"))
        tabOne.tabBarItem = tabOneBarItem
        
        
        // Stats tab
        let tabTwo = UINavigationController(rootViewController: DummyVC())
        let tabTwoBarItem = UITabBarItem(title: "Statistics", image: UIImage(named:"Stats"), selectedImage: UIImage(named: "StatsFilled"))
        
        tabTwo.tabBarItem = tabTwoBarItem
        
        
        let tabBars = [tabOne, tabTwo]
        tabBars.forEach { vc in
            vc.tabBarItem.image = vc.tabBarItem.image?.withRenderingMode(.alwaysTemplate)
            vc.tabBarItem.selectedImage = vc.tabBarItem.selectedImage?.withRenderingMode(.alwaysOriginal)
        }
        
        self.viewControllers = [tabOne, tabTwo]
    }
    
    // UITabBarControllerDelegate method
    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController:UIViewController) {
        print("Selected tab")
    }

}
