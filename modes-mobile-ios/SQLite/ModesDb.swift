//
//  ModesDb.swift
//  modes-mobile-ios
//
//  Created by yada on 8/31/20.
//

import Foundation

class ModesDb{
    
    
    
    // makes this a siglton
    static let shared = ModesDb()
    private init(){
   
        
    }
    
    private var benefit_categories : [[String:Any?]]?
    private var guides_categories : [[String:Any?]]?
    
    private var all_guides : [[String:Any?]]?
    private var all_benefits : [[String:Any?]]?
    
    
  
    private var db : OpaquePointer?
    
    func showDbVersion(){
        print("db version = 1")
    }
    
    
    func getDbVersion()->String{
        let db = SQLiteDB.shared
        db.open()
        
        let data = db.query(sql:"SELECT * FROM version")
        db.closeDB()
        
        if(data.count == 0){
            return ""
        }
        else
        {
            let version  = data[0]["version"] as? String
            return version ?? ""
        }
        
    }
    
    func getBenefitsByAudience(audience : String)->[[String:Any?]]{
        
        var list = [String]()
        // DB Testing for SQLlite
        let db = SQLiteDB.shared
        db.open()
        //let data = db.query(sql:"SELECT * FROM benefits WHERE audience LIKE '%" + audience + "%'")
        let data = db.query(sql:"SELECT * FROM benefits WHERE audience LIKE '%" + audience + "%' ORDER BY RANDOM() LIMIT 4")
  
        db.closeDB()
        return data
    }
    
    func getGuidesByAudience(audience : String)->[[String:Any?]]{
        
       
        // DB Testing for SQLlite
        let db = SQLiteDB.shared
        db.open()
        //let data = db.query(sql:"SELECT * FROM GUIDES WHERE audience LIKE '%" + audience + "%'")
        let data = db.query(sql:"SELECT * FROM GUIDES WHERE audience LIKE '%" + audience + "%' ORDER BY RANDOM() LIMIT 4")
        //let row = data[0]
        //print(row)
        
        //for item in data{
            
        //    list.append(item["Benefit"] as! String)
        //}
        db.closeDB()
        
        return data
    }
    
    
    
    
    
    func  getBenefitsByKeyWordSearch(searchTerm : String)->[[String:Any?]]{
        
        if(searchTerm == ""){
            return [[String:Any?]]()
        }

        let db = SQLiteDB.shared
        db.open()
       
        let data =  db.query(sql:"SELECT * FROM benefits WHERE keywords LIKE '%" + searchTerm + "%' COLLATE NOCASE")
        db.closeDB()
        return data
    }
    
    func  getGuidesByKeyWordSearch(searchTerm : String)->[[String:Any?]]{

        
        if(searchTerm  == ""){
           return  [[String:Any?]]()
        }
        let db = SQLiteDB.shared
        db.open()
        let data =  db.query(sql:"SELECT * FROM guides WHERE [MilLife Guide Topic Keywords] LIKE '%" + searchTerm + "%' COLLATE NOCASE")
    
        db.closeDB()
        return data
    }
    
    
    func getAllGuiides()->[[String:Any?]]{

        if(all_guides == nil){
            let db = SQLiteDB.shared
             db.open()
            let data = db.query(sql: "SELECT * FROM guides ORDER BY Guide COLLATE NOCASE ASC")
            all_guides = data
            return data
        }
        else{
            return all_guides!
        }
    }

    func getGuidesByCategory(category : String)->[[String:Any?]]{

        let db = SQLiteDB.shared
        db.open()
        let data = db.query(sql: "SELECT * FROM guides WHERE category LIKE '%" + category + "%' ORDER BY Guide COLLATE NOCASE ASC")
        return data
    }



    func getGuideByName(guide : String)->[[String:Any?]]{

        let db = SQLiteDB.shared
        db.open()
        let data = db.query(sql: "SELECT * FROM guides WHERE guide LIKE '%" + guide + "%'")
        return data
    }
    
    func getBenefitById(id : String)->[[String:Any?]]{
        
        let db = SQLiteDB.shared
        db.open()
        let data =  db.query(sql: "SELECT * FROM benefits where ID=" + id)
        return data
    }
    
    
    func getGuidesFavorites()->[[String:Any?]]{
        
        let db = SQLiteDB.shared
        db.open()
        let data =  db.query(sql: "SELECT * FROM guides where favorite = 1 ORDER BY Guide COLLATE NOCASE ASC")
        return data
    }
    
    func getBenefitsFavorites()->[[String:Any?]]{
        
        let db = SQLiteDB.shared
        db.open()
        let data =  db.query(sql: "SELECT * FROM benefits where favorite = 1 ORDER BY Benefit COLLATE NOCASE ASC")
        return data
    }
    
    
    
    func setGuideFavorite(favorite : Bool, name: String){

            var value = ""
            if(favorite){
              value = "1"
            }
            else{
              value = "0"
            }

            let db = SQLiteDB.shared
            db.open()
        db.execute(sql: "UPDATE guides set favorite = " + value + " where guide = '" + name  + "'")
      }
    func setBenefitavorite(favorite : Bool, name: String){

        var value = ""
        if(favorite){
        value = "1"
        }
        else{
        value = "0"
        }

        let db = SQLiteDB.shared
        db.open()
        db.execute(sql: "UPDATE benefits set favorite = " + value + " where benefit = '" + name  + "'")
    }

      

    func setBenefitsFavorite(favorite : Bool, id: Int){

        var value = ""
        if(favorite){
          value = "1"
        }
        else{
          value = "0"
        }
        let db = SQLiteDB.shared
        db.open()
        db.execute(sql: "UPDATE benefits set favorite = " + value + " where id = " + String(id) )
    }
    
    func setGuidesFavorite(favorite : Bool, id: Int){

        var value = ""
        if(favorite){
          value = "1"
        }
        else{
          value = "0"
        }
        let db = SQLiteDB.shared
        db.open()
        db.execute(sql: "UPDATE guides set favorite = " + value + " where id = " + String(id) )
    }

      

    func getBenefitCategories()->[[String:Any?]]{
        
        if(benefit_categories == nil){
            
            let db = SQLiteDB.shared
            db.open()
            let data = db.query(sql: "SELECT DISTINCT \"Categories (Primary First)\" from benefits ORDER BY Category COLLATE NOCASE ASC")
            benefit_categories = data
            return data
            
        }
        else{
            return (benefit_categories)!
        }
    }
    
    func getGuideCategories()->[[String:Any?]]{
        
        if(guides_categories == nil){
            let db = SQLiteDB.shared
            db.open()
            let data = db.query(sql: "SELECT DISTINCT category from guides ORDER BY Category COLLATE NOCASE ASC")
            guides_categories = data
            return data
        }
        else{
            return guides_categories!
        }
    }

    func getBenefitByCategory(category : String)->[[String:Any?]]{

        let db = SQLiteDB.shared
        db.open()
        let data = db.query(sql: "SELECT * from benefits WHERE \"Categories (Primary First)\" LIKE '%" + category + "%' ORDER BY Benefit COLLATE NOCASE ASC")
        return data
    }

    func getBenefitByName(name : String)->[[String:Any?]]{

        let db = SQLiteDB.shared
        db.open()
        let data = db.query(sql: "SELECT * from benefits WHERE benefit LIKE '%" + name + "%'")
        return data
    }
    
    func getAllBenefits()->[[String:Any?]]{

        if(all_benefits == nil){
            let db = SQLiteDB.shared
            db.open()
            let data = db.query(sql: "SELECT * FROM benefits ORDER BY Benefit COLLATE NOCASE ASC")
            all_benefits = data
            return data
        }
        else{
            return all_benefits!
        }
        
    }
    
    
    
    
    private func openDb(){
        
        let documentsURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first
        let dbUrl = documentsURL!.appendingPathComponent("modes").appendingPathExtension("db")
        
        if sqlite3_open(dbUrl.path, &db) != SQLITE_OK {
            print("error opening database")
        }
        else{
            print("db opened")
        }
    }
    
}
