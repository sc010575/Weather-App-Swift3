//
//  NotificationRepresentable.swift
//  Weather-App
//
//  Created by Suman Chatterjee on 28/03/2017.
//  Copyright © 2017 Suman Chatterjee. All rights reserved.
//

import Foundation

///The conforming type provide Notification.Name representation
protocol NotificationNameRepresentable {
    
    var name: Notification.Name { get }
}

extension NotificationNameRepresentable where Self: RawRepresentable, Self.RawValue == String {
    
    var name: Notification.Name {
        
        let value = String(reflecting: type(of: self)) + "." + self.rawValue
        return .init(rawValue: value)
    }
}

