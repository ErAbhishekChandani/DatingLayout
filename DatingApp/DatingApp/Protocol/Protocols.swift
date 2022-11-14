//
//  Protocols.swift
//  DatingApp
//
//  Created by Er. Abhishek Chandani on 12/11/22.
//

import Foundation


//Reusable Protocol
//Follow protocol on classes to get the class Name as reuseIdentifier string for collectionView, TableView etc.

protocol ReuseIdentifiable {
    static var reuseIdentifier: String { get }
}

extension ReuseIdentifiable {
    static var reuseIdentifier: String {
        return String(describing: self)
    }
}
