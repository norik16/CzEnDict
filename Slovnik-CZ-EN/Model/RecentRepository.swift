//
//  FavoriteTranslation.swift
//  Slovnik-CZ-EN
//
//  Created by Martin Miksik on 17/08/2017.
//  Copyright © 2017 Martin Miksik. All rights reserved.
//

import Foundation

class RecentRepository: NSObject, NSCoding {
    
    private static var sharedInstance: RecentRepository? = nil
    private static let DocumentsDirectory = FileManager().urls(for: .documentDirectory, in: .userDomainMask).first!
    private static let ArchiveURL = DocumentsDirectory.appendingPathComponent("HistoryRepositoryV2")
    
    private let size: Int = 10
    private var records = [String: String]()
    
    init(records: [String: String]) {
        self.records = records
    }
    
    required convenience init?(coder decoder: NSCoder) {
        guard let records = decoder.decodeObject(forKey: "records") as? [String: String] else {
            return nil
        }
        
        self.init(records: records)
    }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(self.records, forKey: "records")
    }
    
    func addRecord(searchedWorld: String, firstResult: String){
        if records.count > 100 {
            _ = records.popFirst()
        }
        
        records[searchedWorld] = firstResult
    }
    
    func remove(key: String) {
        records.removeValue(forKey: key)
    }
    
    func getReversed() -> [String: String] {
        return records
    }
    
    static func getInstance() -> RecentRepository {
        if RecentRepository.sharedInstance == nil {
            if let cachedInstance = NSKeyedUnarchiver.unarchiveObject(withFile: RecentRepository.ArchiveURL.path) {
                RecentRepository.sharedInstance = cachedInstance as? RecentRepository
            } else {
                let emptyArray = [String: String]()
                RecentRepository.sharedInstance = RecentRepository(records: emptyArray)
            }
        }
        return RecentRepository.sharedInstance!
    }
    
    static func saveInstance() {
        NSKeyedArchiver.archiveRootObject(RecentRepository.sharedInstance as Any, toFile: RecentRepository.ArchiveURL.path)
    }
}

