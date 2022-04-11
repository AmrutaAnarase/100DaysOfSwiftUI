//
//  Bundle-Decodable.swift
//  Moonshot
//
//  Created by Amruta on 24/09/20.
//  Copyright © 2020 Amruta. All rights reserved.
//

import Foundation


extension Bundle {
    // here to make a method generic, we give it a placeholder for certain types <type>
    func decode<T: Codable>(_ file: String) -> T {
        
        guard let url = self.url(forResource:  file, withExtension: nil) else {
            fatalError("Failrd to locate \(file) in bundle")
        }
        
        guard let data = try? Data(contentsOf: url) else {
            fatalError("Failed to locate\(file) from bundle")
        }
        let decoder = JSONDecoder()
        //tells the decoder to parse dates in the exact format we expect.
        let formatter = DateFormatter()
        formatter.dateFormat = "y-MM-dd"
        decoder.dateDecodingStrategy = .formatted(formatter)
        
        
        guard let loaded = try? decoder.decode(T.self, from: data) else {
             fatalError("Failed to decode\(file) from bundle")
        }
        return loaded
    }
     
}
