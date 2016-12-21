//
//  SaveClass.swift
//  Task-1
//
//  Created by user on 21.12.16.
//  Copyright © 2016 user. All rights reserved.
//

import Foundation

class SaveClass {
    static var arrayOfStrings = [[String: String]]()
    
    static func writeToFile() {
        if JSONSerialization.isValidJSONObject(arrayOfStrings) { // True
            do {
                let rawData = try JSONSerialization.data(withJSONObject: arrayOfStrings, options: .prettyPrinted)
                let file = "someFile.json" //this is the file. we will write to and read from it
                if let dir = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first {
                    let path = dir.appendingPathComponent(file)
                    //print(path)
                    //writing
                    do {
                        try rawData.write(to: path, options: .atomic)
                    }
                    catch {print(error)}
                }
            } catch {print(error)}
        }
    }
    
    static func readFromFile() {
        do {
            let file = "someFile.json" //this is the file. we will write to and read from it
            if let dir = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first {
                let url = dir.appendingPathComponent(file)
                let data = NSData(contentsOf: url)
                if data != nil {
                    do {
                        let object = try JSONSerialization.jsonObject(with: data! as Data, options: .allowFragments)
                        if let dictionary = object as? [[String: String]] {
                            arrayOfStrings = dictionary
                        }
                    } catch {print(error)}
                }
            }
        } catch {print(error)}
    }

}
