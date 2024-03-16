//
//  AppDelegate.swift
//  wheel
//
//  Created by admin on 29/02/2024.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {



    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        if !UserDefaults.standard.bool(forKey: "opened") {
            loadDefault()
        }
        UserDefaults.standard.setValue(true, forKey: "opened")

        return true
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }
    
    private func loadDefault() {
        var lunch: [CircleDetailModel] = []
        
        let whatsForLunch = CircleModel()
        whatsForLunch.content = "What's for lunch?"
        UserDefaults.standard.setValue(whatsForLunch.id, forKey: "selected.id")
        
        let lunch0 = CircleDetailModel()
        lunch0.idQuestion = whatsForLunch.id
        lunch0.content = "Sandwich"
        
        let lunch1 = CircleDetailModel()
        lunch1.idQuestion = whatsForLunch.id
        lunch1.content = "Burger"
        
        let lunch2 = CircleDetailModel()
        lunch2.idQuestion = whatsForLunch.id
        lunch2.content = "Pizza"
        
        let lunch3 = CircleDetailModel()
        lunch3.idQuestion = whatsForLunch.id
        lunch3.content = "Salad"
        
        let lunch4 = CircleDetailModel()
        lunch4.idQuestion = whatsForLunch.id
        lunch4.content = "Soup"
        
        let lunch5 = CircleDetailModel()
        lunch5.idQuestion = whatsForLunch.id
        lunch5.content = "Pasta"
        
        lunch.append(lunch0)
        lunch.append(lunch1)
        lunch.append(lunch2)
        lunch.append(lunch3)
        lunch.append(lunch4)
        lunch.append(lunch5)
        
        
        var name: [CircleDetailModel] = []
        
        let who = CircleModel()
        who.content = "Who?"
        
        let name0 = CircleDetailModel()
        name0.idQuestion = who.id
        name0.content = "James"
        
        let name1 = CircleDetailModel()
        name1.idQuestion = who.id
        name1.content = "Lisa"
        
        let name2 = CircleDetailModel()
        name2.idQuestion = who.id
        name2.content = "Michelle"
        
        let name3 = CircleDetailModel()
        name3.idQuestion = who.id
        name3.content = "Andrew"
        
        let name4 = CircleDetailModel()
        name4.idQuestion = who.id
        name4.content = "Anthony"
        
        let name5 = CircleDetailModel()
        name5.idQuestion = who.id
        name5.content = "Jessica"
        
        let name6 = CircleDetailModel()
        name6.idQuestion = who.id
        name6.content = "Susan"
        
        let name7 = CircleDetailModel()
        name7.idQuestion = who.id
        name7.content = "Paul"
        
        let name8 = CircleDetailModel()
        name8.idQuestion = who.id
        name8.content = "Daniel"
        
        let name9 = CircleDetailModel()
        name9.idQuestion = who.id
        name9.content = "Linda"
        
        let name10 = CircleDetailModel()
        name10.idQuestion = who.id
        name10.content = "Kimberly"
        
        name.append(name0)
        name.append(name1)
        name.append(name2)
        name.append(name3)
        name.append(name4)
        name.append(name5)
        name.append(name6)
        name.append(name7)
        name.append(name8)
        name.append(name9)
        name.append(name10)
        
        
        do {
            let repository = try RealmRepository()
            
            try repository.addCircle(circle: whatsForLunch)
            try lunch.forEach { item in
                try repository.addCircleDetail(itemOption: item)
            }
            
            try repository.addCircle(circle: who)
            try name.forEach { item in
                try repository.addCircleDetail(itemOption: item)
            }
        } catch {}
    }


}

