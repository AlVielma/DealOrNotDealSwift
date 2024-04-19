//
//  UserData.swift
//  dealornotdeal
//
//  Created by imac on 18/04/24.
//

import UIKit

class UserData: NSObject {
        var nombre: String
        var record: Float
        static var shared: UserData!
        
        override init() {
            nombre = ""
            record = 0
        }
        
        static func sharedUserData() -> UserData {
            if shared == nil {
                shared = UserData()
            }
            return shared
        }
}
