//
//  Translation.swift
//  Slovnik-CZ-EN
//
//  Created by Martin Miksik on 16/08/2017.
//  Copyright © 2017 Martin Miksik. All rights reserved.
//

import Foundation

struct Item {
    let id: String
    let origin: String
    let originLanguage: String
    let translations: [String]
    let classes: String
    
//    init?(json: [String: Any]) {
//        guard let id = json["id"] as? String,
//            let origin = json["origin"] as? String,
//            let originLanguage = json["originLanguage"] as? String,
//            let translationsJson = json["translations"] as? [String]
//            else {
//                return nil
//        }
//        
//        var translations: [String] = []
//        for translation in translationsJson {
//            translations.append(translation)
//        }
//        
//        self.id = id
//        self.origin = origin
//        self.originLanguage = originLanguage
//        self.translations = translations
//        
//        //TODO
//        self.classes = ""
//    }
    
    init(id: String, origin: String, originLanguage: String, translations: [String], classes: String) {
        self.id = id
        self.origin = origin
        self.originLanguage = originLanguage
        self.translations = translations
        self.classes = classes
    }
}
