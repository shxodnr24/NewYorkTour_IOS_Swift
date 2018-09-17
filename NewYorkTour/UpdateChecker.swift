//
//  updateChecker.swift
//  NewYorkTour
//
//  Created by Taewook Noh on 2018. 7. 17..
//  Copyright © 2018년 taewook. All rights reserved.
//

import UIKit

private let appId = "1397832552"
private let title = "App Update"
private let message = "Ready to install new version"
private let okBtnTitle = "Install now"
private let cancelBtnTitle = "Later"


private var topViewController: UIViewController? {
    guard var topViewController = UIApplication.shared.keyWindow?.rootViewController else { return nil }
    while let presentedViewController = topViewController.presentedViewController {
        topViewController = presentedViewController
    }
    return topViewController
}

enum UpdateType {
    case normal
    case force
}

class UpdateChecker {
    
    static func run(updateType: UpdateType) {
        guard let url = URL(string: "https://itunes.apple.com/kr/lookup?id=\(appId)") else { return }
        let request = URLRequest(url: url)
        let session = URLSession(configuration: .default)
        
        let task = session.dataTask(with: request, completionHandler: {
            (data, _, _) in
            guard let d = data else { return }
            do {
                guard let results = try JSONSerialization.jsonObject(with: d, options: .allowFragments) as? NSDictionary else { return }
                guard let resultsArray = results.value(forKey: "results") as? NSArray else { return }
                guard let storeVersion = (resultsArray[0] as? NSDictionary)?.value(forKey: "version") as? String else { return }
                guard let installVersion = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String else { return }
                guard installVersion.compare(storeVersion) == .orderedAscending else { return }
                showAlert(updateType: updateType)
            } catch {
                print("Serialization error")
            }
        })
        task.resume()
    }
    
    private static func showAlert(updateType: UpdateType) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: okBtnTitle, style: .default, handler: { Void in
            guard let url = URL(string: "itms-apps://itunes.apple.com/app/id\(appId)") else { return }
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        })
        alert.addAction(okAction)
        
        if updateType == .normal {
            let cancelAction = UIAlertAction(title: cancelBtnTitle, style: .cancel, handler: nil)
            alert.addAction(cancelAction)
        }
        
        topViewController?.present(alert, animated: true, completion: nil)
    }
}
