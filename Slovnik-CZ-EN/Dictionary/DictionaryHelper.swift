//
//  DictionaryHelper.swift
//  Slovnik-CZ-EN
//
//  Created by Martin Miksik on 15/08/2017.
//  Copyright © 2017 Martin Miksik. All rights reserved.
//

import Foundation

class DictionaryHelper {
    
    static var dictonaryInMemory: [Item] = [Item]()
    
    static func translate(serachedText: String) -> [Item] {
        
        if serachedText.isEmpty {
            return []
        }
        
        return DictionaryHelper.dictonaryInMemory.filter {  pair in pair.origin.lowercased().hasPrefix(serachedText.lowercased()) }
    }
    
    static func getByIds(ids: [String]) -> [Item] {
        return DictionaryHelper.dictonaryInMemory.filter { ids.contains($0.id) }
    }
    
    
    //TODO Redo
    static func load() {
        do {
            if let file = Bundle.main.url(forResource: "dict", withExtension: "json") {
                let data = try Data(contentsOf: file)
                let json = try JSONSerialization.jsonObject(with: data, options: [])
                
                if DictionaryHelper.dictonaryInMemory.isEmpty {
                    for jsonObject in json as! [Any] {
                        DictionaryHelper.dictonaryInMemory.append(Item(json: jsonObject as! [String: Any])!)
                    }
                }
                
            } else {
                print("no file")
            }
        } catch {
            print(error.localizedDescription)
        }
    }
}
