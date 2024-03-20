//
//  RemoteConfigManager.swift
//  wheel
//
//  Created by admin on 20/03/2024.
//

import FirebaseCore
import FirebaseRemoteConfig

class RemoteConfigManager {
    static func setupRemoteConfig() {
        FirebaseApp.configure()
        let remoteConfig = RemoteConfig.remoteConfig()
        let remoteConfigSettings = RemoteConfigSettings()
        remoteConfigSettings.minimumFetchInterval = 0
        remoteConfig.configSettings = remoteConfigSettings
        remoteConfig.setDefaults(fromPlist: "RemoteConfigKeys")
    }
    
    static func checkRequireUpdate(completion: @escaping (RemoteConfigModel) -> Void) {
        let remoteConfig = RemoteConfig.remoteConfig()

        // Set default values for the app version
        let defaultConfig: [String: Any] = [
            "app_version": "1.0.0", // Default app version
            "app_store_url": "" // Default App Store URL
        ]
        remoteConfig.setDefaults(defaultConfig as? [String: NSObject])

        // Fetch values from Remote Config
        remoteConfig.fetch { (status, error) in
            if status == .success {
                remoteConfig.activate { (changed, error) in
                    let remoteVersion = remoteConfig["app_version"].stringValue ?? "1.0.0"
                    let currentVersion = Bundle.main.object(forInfoDictionaryKey: "CFBundleShortVersionString") as? String ?? ""

                    print("---RemoteConfig--- app_version : \(remoteVersion)")

                    // Compare the current version with the version from Remote Config
                    if remoteVersion.compare(currentVersion, options: .numeric) == .orderedDescending {
                        let appStoreURLString = remoteConfig["app_store_url"].stringValue ?? ""
                        if let appStoreURL = URL(string: appStoreURLString) {
                            let remoteConfigModel = RemoteConfigModel(version: remoteVersion, appStoreURL: appStoreURL)
                            completion(remoteConfigModel)
                            print("---RemoteConfig--- appStoreURL : \(appStoreURL)")
                        } else {
                            let remoteConfigModel = RemoteConfigModel(version: remoteVersion, appStoreURL: nil)
                            completion(remoteConfigModel)
                        }
                    } else {
                        let remoteConfigModel = RemoteConfigModel(version: remoteVersion, appStoreURL: nil)
                        completion(remoteConfigModel)
                    }
                }
            } else {
                let remoteConfigModel = RemoteConfigModel(version: "1.0.0", appStoreURL: nil)
                completion(remoteConfigModel)
            }
        }
    }
}

struct RemoteConfigModel {
    let version: String
    let appStoreURL: URL?
}
