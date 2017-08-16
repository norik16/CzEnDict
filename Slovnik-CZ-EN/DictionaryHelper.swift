//
//  DictionaryHelper.swift
//  Slovnik-CZ-EN
//
//  Created by Martin Miksik on 15/08/2017.
//  Copyright © 2017 Martin Miksik. All rights reserved.
//

import Foundation

class DictionaryHelper {
    
    enum Language: Int {
        case czech = 1,
        english
    }
    
//    static let file: String = "en-cs.txt"
    
    static let dictEnCs: [Translation] = [
        Translation(id: 1, origin: "Hello", originLanguage: Language.english, translations:["Ahoj", "Čau", "Čau", "Čau", "Čau", "Čau", "Čau", "Čau", "Čau", "Čau", "Čau", "Čau", "Čau", "Čau", "Čau", "Čau", "Čau", "Čau"]),
        Translation(id: 2, origin: "Hi", originLanguage: Language.english, translations:["Ahoj", "Čau"]),
        Translation(id: 3, origin: "Setting", originLanguage:  Language.english, translations:["Nastavení"]),
        Translation(id: 4, origin: "Perform", originLanguage:  Language.english, translations:["Vykonávat"])
    ]
    
    static let dictCsEn: [Translation] = [
        Translation(id: 5, origin: "Ahoj", originLanguage:  Language.czech, translations:["Hi", "Hello"]),
        Translation(id: 6, origin: "Čas", originLanguage:  Language.czech, translations:["Hi", "Hello"]),
        Translation(id: 7, origin: "Nastavení", originLanguage: Language.czech, translations:["Settings"]),
        Translation(id: 8, origin: "Vykonávat", originLanguage: Language.czech, translations:["Perform"])
    ]
    
    static func translate(serachedText: String, inLanguage: Language) -> [Translation] {
        
        if serachedText.isEmpty {
            return []
        }
        
        if inLanguage == Language.english {
            return self.dictEnCs.filter {  pair in pair.origin.lowercased().hasPrefix(serachedText.lowercased()) }
        } else {
            return self.dictCsEn.filter {  pair in pair.origin.lowercased().hasPrefix(serachedText.lowercased()) }
        }
    }
    
    static func getByIds(ids: [Int]) -> [Translation] {
        let dict = self.dictCsEn + self.dictEnCs
        var temp = dict.filter { ids.contains($0.id) }
        return temp
    }
}
