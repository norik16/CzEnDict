//
//  FavoriteRepository.swift
//  Slovnik-CZ-EN
//
//  Created by Martin Miksik on 27/08/2017.
//  Copyright © 2017 Martin Miksik. All rights reserved.
//

import Foundation
import SQLite

class FavoriteRepository: BaseRepository {
    
    
    //Table
    //TODO Export table name
    let table = Table("favorite")
    
    //Collums
    let id = Expression<Int>("id")
    let translationId = Expression<String>("translationid")
    
    
    let dictionaryRepository: DictionaryRepository = RepositoryManager.getInstance()

    
    func add(translationId: String) {
        let insert = table.insert(self.translationId <- translationId)
        do {
            print(insert.asSQL())
            let id = try db!.run(insert)
            print(id)
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func remove(translationId: String) {
        let row = self.table.filter(self.translationId == translationId)
        do {
            try db!.run(row.delete())
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func getFavorites() -> [Item] {
        var ids = [String]()
        
        do {
            for row in try db!.prepare(table) {
                ids.append(row[translationId])
            }
        } catch {
            print(error.localizedDescription)
        }
        
        return dictionaryRepository.getByIDs(ids: ids)
    }

}
