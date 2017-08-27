//
//  BaseRepository.swift
//  Slovnik-CZ-EN
//
//  Created by Martin Miksik on 26/08/2017.
//  Copyright © 2017 Martin Miksik. All rights reserved.
//

import Foundation
import SQLite

class BaseRepository {
    
    //Database
    var db: Connection? = nil
    
    static var instances = [BaseRepository]()
    
    required init() {
        let fileManger = FileManager.default
        
        let doumentDirectoryPath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0] as NSString
        let destinationPath = doumentDirectoryPath.appendingPathComponent("dictV1.sqlite")

        let sourcePath = Bundle.main.path(forResource: "dict", ofType: "sqlite")
        
        
        do{
            if !fileManger.fileExists(atPath: destinationPath) {
                try fileManger.copyItem(atPath: sourcePath!, toPath: destinationPath)
            }
                
            db = try Connection(destinationPath)
            print("Connected ok")
                
        }catch {
            print(error.localizedDescription)
            print("Error in connecting to the database")
        }
    }
}

class RepositoryManager {
    
    static var instances = [BaseRepository]()
    
    static func getInstance<T: BaseRepository>() -> T {
        var object: T? = nil
        
        for instance in instances {
            if type(of: instance) == T.self {
                object = instance as? T
            }
        }
        
        if object == nil {
            object = T()
        }
        
        return object!
    }
}
