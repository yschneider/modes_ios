//
//  RemoteSettings.swift
//  modes-mobile-ios
//
//  Created by Chris Fletcher on 10/14/20.
//

import Foundation

protocol RemoteSettingsDelegate {
    func remoteSettingsReceived(_ remoteSettings: RemoteSettings?)
}

// struct to hold app update settings
struct AppUpdateSettings: Codable {
    let version: String
    let forceUpdate: Bool
    let updateMessage: String
    let forceDate: Date
    let database : Database
    
    
}

// top level object to hold remote settings
// add any new props here
// if prop is a complex type, add a struct for it above
struct RemoteSettings: Codable {
    let appUpdateSettings: AppUpdateSettings
}


// the database
struct Database : Codable{
    let version : String
    let largeFiles : [String]
    let smallFiles : [String]
}

