////
////  FavoriteTranslation.swift
////  Slovnik-CZ-EN
////
////  Created by Martin Miksik on 16/08/2017.
////  Copyright © 2017 Martin Miksik. All rights reserved.
////
//
//import Foundation
//
//class FavoriteRepository: NSObject, NSCoding {
//    
//    private static var sharedInstance: FavoriteRepository? = nil
//    private static let DocumentsDirectory = FileManager().urls(for: .documentDirectory, in: .userDomainMask).first!
//    private static let ArchiveURL = DocumentsDirectory.appendingPathComponent("FavouriteRepository")
//    
//    private var keys = [String]()
//    
//    init(keys: [String]) {
//        self.keys = keys
//    }
//    
//    required convenience init?(coder decoder: NSCoder) {
//        guard let keys = decoder.decodeObject(forKey: "keys") as? [String] else {
//            return nil
//        }
//        
//        self.init(keys: keys)
//    }
//    
//    func encode(with aCoder: NSCoder) {
//         aCoder.encode(self.keys, forKey: "keys")
//    }
//    
//    func addKey(key: String){
//        if !keys.contains(key) {
//            keys.append(key)
//        }
//    }
//    
//    func removeKey(key: String) {
//        keys = keys.filter { $0 != key }
//    }
//    
//    func isFavourite(key: String) -> Bool {
//        return keys.contains(key)
//    }
//    
//    func getKeysReversed() -> [String] {
//        return keys.reversed()
//    }
//    
//    static func getInstance() -> FavoriteRepository {
//        if FavoriteRepository.sharedInstance == nil {
//            if let cachedInstance = NSKeyedUnarchiver.unarchiveObject(withFile: FavoriteRepository.ArchiveURL.path) {
//                FavoriteRepository.sharedInstance = cachedInstance as? FavoriteRepository
//            } else {
//                let emptyArray = [String]()
//                FavoriteRepository.sharedInstance = FavoriteRepository(keys: emptyArray)
//            }
//        }
//        return FavoriteRepository.sharedInstance!
//    }
//    
//    static func saveInstance() {
//        NSKeyedArchiver.archiveRootObject(FavoriteRepository.sharedInstance as Any, toFile: FavoriteRepository.ArchiveURL.path)
//    }
//}
