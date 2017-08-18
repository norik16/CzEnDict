//
//  DictionaryHelper.swift
//  Slovnik-CZ-EN
//
//  Created by Martin Miksik on 15/08/2017.
//  Copyright © 2017 Martin Miksik. All rights reserved.
//

import Foundation
import SQLite

class DictionaryRepository {
    
    static var sharedInstance: DictionaryRepository? = nil
    
    //Database
    let path: String = "dict"
    var db: Connection? = nil
    
    //Table
    //TODO Export table name
    let dicrionary = Table("dictonary")
    let resultLimit: Int = 500
    
    //Collums
    let id = Expression<String>("id")
    let origin = Expression<String>("origin")
    let originLanguage = Expression<String>("originLanguage")
    let translations = Expression<String>("translations")
    //let translations = Expression<Array<String>>("translations")
    
    init() {
        let path = Bundle.main.path(forResource: self.path, ofType: "sqlite")!
        do {
            db = try Connection(path)
            print("Connected ok")
            
        } catch  {
           print("Error in connecting to the database")
        }
    }
    
    func translate(textToTranslate: String) -> [Item] {
        let query = dicrionary.filter(origin.lowercaseString.like("\(textToTranslate)%") == true).limit(resultLimit)
        print(query.asSQL())
        return run(query: query)
    }
    
    func getByIDs(ids: [String]) -> [Item] {
        let query = dicrionary.filter(ids.contains(id)).limit(resultLimit)
        //print(query)
        return run(query: query)
    }
    
    static func getInstance() -> DictionaryRepository {
        if DictionaryRepository.sharedInstance == nil {
            DictionaryRepository.sharedInstance = DictionaryRepository()
        }
        
        return DictionaryRepository.sharedInstance!
    }
    
    private func run(query: Table) -> [Item]{
        var items = [Item]()
        do {
            for row in try db!.prepare(query) {
                let translations = row[self.translations].components(separatedBy: "=")
                print(translations)
                items.append(Item(
                    id: row[id],
                    origin: row[origin],
                    originLanguage: row[originLanguage],
                    translations: translations,
                    classes: ""
                ))
            }
        } catch {
            print(error.localizedDescription)
            print("Error in reading the database")
        }
        
        return items
    }

}

//extension Array where Element: Value {
//    public static var declaredDatatype: String {
//        return Array.declaredDatatype
//    }
//    
//    static func fromDatatypeValue(stringValue: String) -> [String] {
//        return stringValue.components(separatedBy: "=")
//    }
//    
//    public var datatypeValue: String {
//        let temp = self as! [String]
//        return temp.joined(separator: "=")
//    }
//}
