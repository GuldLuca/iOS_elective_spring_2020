//
//  FacebookManager.swift
//  week14
//
//  Created by admin on 17/06/2020.
//  Copyright © 2020 kea. All rights reserved.
//

import Foundation
import FacebookCore
import FacebookLogin

class FacebookManager{
    
    let parentVC: ViewController
    
    init(parentVC: ViewController) {
        self.parentVC = parentVC
    }
    
    func login(){
        print("Login via Facebook called")
        let manager = LoginManager()
        manager.logIn(permissions: [.publicProfile], viewController: parentVC) { (result) in
            
            switch result{
                case .cancelled :
                    print("Login cancelled")
                    break
            case .failed(let error):
                print("Failed to login \(error.localizedDescription)")
                break
            case .success(granted: _, declined: _, let token):
                    print("Successful login \(token.userID)")
                    self.parentVC.firebaseManager?.faceFireLogin(strToken: token.tokenString)
            }
        }
    }
    
    func graphReq(){
        if let strToken = AccessToken.current?.tokenString{
            let graphReq = GraphRequest(
                graphPath: "/me",
                parameters: ["fields" : "id, name, email, picture.width(400)"],
                tokenString: strToken,
                version: Settings.defaultGraphAPIVersion,
                httpMethod: .get
            )
            
            let connection = GraphRequestConnection()
            connection.add(graphReq) {(connection, result, error) in
                if error == nil {
                    
                    if let res = result as? [String:String] {
                        let name: String = res["name"]!
                        let email: String = res["email"]!
                        print("Data fetched from Facebook. Name: \(name) and email: \(email)")
                        print(res)
                    }
                }
                else{
                    print("Failed to fetch data from Facebook \(error.debugDescription)")
                }
            }
            connection.start()
        }
    }
}
