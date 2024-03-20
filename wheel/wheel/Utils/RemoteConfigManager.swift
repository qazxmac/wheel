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
    
    static func checkRequireUpdate(completion: @escaping (URL?) -> Void) {
        let remoteConfig = RemoteConfig.remoteConfig()
        
        // Thiết lập giá trị mặc định cho phiên bản ứng dụng
        let defaultConfig: [String: Any] = [
            "app_version": "1.0.0", // Phiên bản mặc định của ứng dụng
            "app_store_url": "" // URL App Store mặc định
        ]
        remoteConfig.setDefaults(defaultConfig as? [String: NSObject])
        
        // Lấy giá trị từ Remote Config
        remoteConfig.fetch { (status, error) in
            if status == .success {
                remoteConfig.activate { (changed, error) in
                    let remoteVersion = remoteConfig["app_version"].stringValue ?? ""
                    let currentVersion = Bundle.main.object(forInfoDictionaryKey: "CFBundleShortVersionString") as? String ?? ""
                    
                    print("---RemoteConfig--- app_version : \(remoteVersion)")
                    // So sánh phiên bản hiện tại với phiên bản từ Remote Config
                    if remoteVersion.compare(currentVersion, options: .numeric) == .orderedDescending {
                        let appStoreURLString = remoteConfig["app_store_url"].stringValue ?? ""
                        if let appStoreURL = URL(string: appStoreURLString) {
                            completion(appStoreURL)
                            print("---RemoteConfig--- appStoreURL : \(appStoreURL)")
                        } else {
                            completion(nil)
                        }
                    } else {
                        completion(nil)
                    }
                }
            } else {
                completion(nil)
            }
        }
    }
}
