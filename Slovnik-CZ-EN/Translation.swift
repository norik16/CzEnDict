//
//  Translation.swift
//  Slovnik-CZ-EN
//
//  Created by Martin Miksik on 16/08/2017.
//  Copyright © 2017 Martin Miksik. All rights reserved.
//

import Foundation

struct Translation {
    let id: Int
    let origin: String
    let translations: [String]
    let originLanguage: DictionaryHelper.Language
    let classes: String
    
    init(id: Int, origin: String, originLanguage: DictionaryHelper.Language, translations: [String], classes: String? = nil) {
        self.id = id
        self.origin = origin
        self.originLanguage = originLanguage
        self.translations = translations
        
        if classes != nil {
            self.classes = classes!
        } else {
            self.classes = "Undefined"
        }
    }
}
