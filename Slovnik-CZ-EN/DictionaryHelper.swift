//
//  DictionaryHelper.swift
//  Slovnik-CZ-EN
//
//  Created by Martin Miksik on 15/08/2017.
//  Copyright © 2017 Martin Miksik. All rights reserved.
//

import Foundation

struct Translation {
    let origin: String
    let translations: [String]
    let originLanguage: DictionaryHelper.Language
    
    init(origin: String, originLanguage: DictionaryHelper.Language, translations: [String]) {
        self.origin = origin
        self.originLanguage = originLanguage
        self.translations = translations
    }
}

class DictionaryHelper {
    
    enum Language: Int {
        case czech = 1,
        english
    }
    
//    static let file: String = "en-cs.txt"
    
    static let dictEnCs: [Translation] = [
        Translation(origin: "Hello", originLanguage: Language.english, translations:["Ahoj", "Čau", "Čau", "Čau", "Čau", "Čau", "Čau", "Čau", "Čau", "Čau", "Čau", "Čau", "Čau", "Čau", "Čau", "Čau", "Čau", "Čau"]),
        Translation(origin: "Hi", originLanguage: Language.english, translations:["Ahoj", "Čau"]),
        Translation(origin: "Setting", originLanguage:  Language.english, translations:["Nastavení"]),
        Translation(origin: "Perform", originLanguage:  Language.english, translations:["Vykonávat"])
    ]
    
    static let dictCsEn: [Translation] = [
        Translation(origin: "Ahoj", originLanguage:  Language.czech, translations:["Hi", "Hello"]),
        Translation(origin: "Čas", originLanguage:  Language.czech, translations:["Hi", "Hello"]),
        Translation(origin: "Nastavení", originLanguage: Language.czech, translations:["Settings"]),
        Translation(origin: "Vykonávat", originLanguage: Language.czech, translations:["Perform"])
    ]
    
    static func translate(serachedText: String, inLanguage: Language) -> [Translation]? {
        if inLanguage == Language.english {
            return self.dictEnCs.filter {  pair in pair.origin.contains(serachedText) }
        } else {
            return self.dictCsEn.filter {  pair in pair.origin.contains(serachedText) }
        }
        
        return nil
    }
}
