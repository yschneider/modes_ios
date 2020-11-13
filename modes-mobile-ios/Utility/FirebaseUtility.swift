//
//  FirebaseUtility.swift
//  modes-mobile-ios
//
//  Created by yada on 9/27/20.
//

import Foundation
import Firebase

class FirebaseUtility{
    
    
    
    // makes this a siglton
    static let shared = FirebaseUtility()
    private init(){}
    
    func logEvent(name : String, params : [String : Any]){
        
        Analytics.logEvent(name, parameters: params)
    }
    
    func AudienceTypSelected(audienceType: String){
        let params = [
        "screen_name": "SetAudience", // e.g., setup - audience
        "audienceType": audienceType
        ] as [String: Any]
        Analytics.logEvent("audienceTypeSelected", parameters:params)
    }
    
    func InstallationSelected(installationName : String){
        let params = [
        "screen_name": "SetInstallation", // e.g., setup - audience
        "installationName": installationName
        ] as [String: Any]
        Analytics.logEvent("installationSelected", parameters:params)
    }
    
    func BranchSelected(branchName : String){
        let params = [
        "screen_name": "SetBranch", // e.g., setup - branch
        "branchName": branchName
        ] as [String: Any]
        Analytics.logEvent("branchSelected", parameters:params)
    }
    
    func ScreenView(screenName : String, contentType : String, contentTitle : String, isFavorite : String){
        let params = [
        "screen_name": screenName, // e.g., moving in the military
        "isFavorite" : isFavorite,
        "contentType": contentType, // e.g., millife guides
        "contentTitle": contentTitle // e.g., moving in the military
        ] as [String: Any]
        Analytics.logEvent("screen_view", parameters:params)
    }
    
    func FavoriteAdded(screenName : String, contentType : String, contentTitle : String){
        let params = [
        "screen_name": screenName, // e.g., moving in the military
        "contentType": contentType,
        "contentTitle": contentTitle
        ] as [String: Any]
        Analytics.logEvent("favoriteAdded", parameters:params)

    }
    
    func ContentCardSelected(screenName: String, contentType : String, contentTitle : String, category : String,
                             displayFormat : String){
    
    
        let params = [
            "screen_name": screenName, // e.g., home
            "contentType": contentType,
            "contentTitle": contentTitle,
            "category": category,
            "displayFormat": displayFormat
        ] as [String: Any]
        Analytics.logEvent("contentCardSelected", parameters:params)
    }
    
    
    func skipSelected(screenName: String, personalizaionStep: String, skipType: String){
       let params = [
        "screen_name": screenName, // e.g., setup - audience
        "personalizationStep": personalizaionStep,
        "skipSelection": skipType
        ] as [String: Any]
        Analytics.logEvent("skipSelected", parameters:params)
    }
    
    func searchStarted(){
        let params = [
        "screen_name": "home" // e.g., home
        ] as [String: Any]
        Analytics.logEvent("searchStarted", parameters:params)
    }
    
    func searchTopicSelected(searchTerm: String, searchType: String){
       let params = [
       "screen_name": "search", // e.g., search
       "searchTerm": searchTerm,
       "category": searchTerm, // e.g., covid-19
       "searchType": searchType// e.g., suggested topic, related topic
       ] as [String: Any]
       Analytics.logEvent("searchTopicSelected", parameters:params)

    }
    
    func searchResultSelected(contentType: String, contentTitle: String, category: String){
        let params = [
        "screen_name": "search results", // e.g., search results
        "contentType": contentType,
        "contentTitle": contentTitle,
        "category": category // e.g., pcs
        ] as [String: Any]
        Analytics.logEvent("searchResultSelected", parameters:params)
    }
    
    func browseCategorySelected(screenName: String, contentType: String, category: String){
        let params = [
        "screen_name": screenName, // e.g., millife guides
        "contentType": contentType,
        "category": category
        ] as [String: Any]
        Analytics.logEvent("browseCategorySelected", parameters:params)

        
    }

    func guideContentSelected(screenName: String, guideContentType: String, guideContentTitle: String){
       let params = [
        "screen_name": screenName, // e.g., moving in the military
        "contentType": "",
        "contentTitle": "",
        "guideContentType": guideContentType,
        "guideContentTitle": guideContentTitle
       ] as [String: Any]
       Analytics.logEvent("guideContentSelected", parameters:params)

    }
    
    func benefitDetailsViewed(screenName: String){
        let params = [
        "screen_name": screenName, // e.g., temporary lodging allowance - tla
        "contentType": "",
        "category": "", // omit from event if parameter value is not available
        "benefitContentTitle": screenName
        ] as [String: Any]
        Analytics.logEvent("benefitDetailsViewed", parameters:params)
    }
    
    func installationInteraction(installationName: String, installationInteraction: String){
       let params = [
       "screen_name": "favorites", // e.g., favorites
        "installationName": installationName,
        "installationInteraction": installationInteraction
       ] as [String: Any]
       Analytics.logEvent("installationInteraction", parameters:params)
    }
    
    func connectInteraction(connectMethod: String){
        let params = [
        "screen_name": "connect", // e.g., connect
        "connectMethod": connectMethod
        ] as [String: Any]
        Analytics.logEvent("connectInteraction", parameters:params)
    }
    
    func menuItemSelected(menuItem: String){
        let params = [
        "screen_name": "side-menu", // e.g., menu
        "menuItemSelected": menuItem
        ] as [String: Any]
        Analytics.logEvent("menuItemSelected", parameters:params)
    }
    
}
