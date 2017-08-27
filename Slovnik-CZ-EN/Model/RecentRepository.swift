//
//  RecentRepository.swift
//  Slovnik-CZ-EN
//
//  Created by Martin Miksik on 26/08/2017.
//  Copyright © 2017 Martin Miksik. All rights reserved.
//

import Foundation
import SQLite

class RecentRepository: BaseRepository {
    
    //Table
    //TODO Export table name
    let recent = Table("recent")
    
    //Collums
    let id = Expression<Int>("id")
    let origin = Expression<String>("origin")
    let translation = Expression<String>("translation")
    //let date = Expression<Date>("date")

    
    
    func add(originT: String, translationT: String) {
        let insert = recent.insert(self.origin <- originT, self.translation <- translationT)
        do {
            print(insert.asSQL())
            let id = try db!.run(insert)
            print(id)
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func remove(origin: String) {
        let row = self.recent.filter(self.origin == origin)
        do {
            try db!.run(row.delete())
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func getAll() -> [(String, String)]{
        var rows = [(String, String)]()
        do {
            for row in try db!.prepare(recent) {
                rows.append((row[origin], row[translation]))
            }
        } catch {
            print(error.localizedDescription)
        }
        
        return rows.reversed()
    }
    
}

