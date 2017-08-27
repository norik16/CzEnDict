//
//  DictionaryHelper.swift
//  Slovnik-CZ-EN
//
//  Created by Martin Miksik on 15/08/2017.
//  Copyright © 2017 Martin Miksik. All rights reserved.
//

import Foundation
import SQLite

final class DictionaryRepository: BaseRepository{
    
    //Table
    let dicrionary = Table("dictonary")
    let resultLimit: Int = 500
    
    //Collums
    let id = Expression<String>("id")
    let origin = Expression<String>("origin")
    let originLanguage = Expression<String>("originLanguage")
    let translations = Expression<String>("translations")
    
    func translate(textToTranslate: String) -> [Item] {
        let query = dicrionary.filter(origin.lowercaseString.like("\(textToTranslate)%") == true).limit(resultLimit)
        print(query.asSQL())
        return run(query: query)
    }
    
    func getByIDs(ids: [String]) -> [Item] {
        let query = dicrionary.filter(ids.contains(id)).limit(resultLimit)
        return run(query: query)
    }
    
    private func run(query: Table) -> [Item]{
        var items = [Item]()
        do {
            for row in try db!.prepare(query) {
                let translations = row[self.translations].components(separatedBy: "=")
                //print(translations)
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
