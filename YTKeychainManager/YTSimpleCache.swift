//
//  YTSimpleCache.swift
//  YTKeychainManager
//
//  Created by Yasin Turkdogan on 1/11/17.
//  Copyright © 2017 yasinturkdogan. All rights reserved.
//

import Foundation

public class YTSimpleCache {
    
    public static let shared = YTSimpleCache()
    
    private init() {}
    
    public func save(key:String,value:Int) {
        UserDefaults.standard.set(value, forKey: key);
        UserDefaults.standard.synchronize();
    }
    
    public func save(key:String,value:Data) {
        UserDefaults.standard.set(value, forKey: key);
        UserDefaults.standard.synchronize();
    }
    
    public func save(key:String, value:String) {
        UserDefaults.standard.set(value, forKey: key);
        UserDefaults.standard.synchronize();
    }
    
    public func save(key:String, value:Bool) {
        UserDefaults.standard.set(value, forKey: key);
        UserDefaults.standard.synchronize();
    }
    
    public func get(key:String, defaultValue:Bool? = nil)->Bool? {
        if let value:Bool = get(key:key)  {
            return value;
        }
        return defaultValue;
    }
    
    public func get(key:String, defaultValue:Int? = nil)->Int? {
        if let value:Int = get(key:key)  {
            return value;
        }
        return defaultValue;
    }
    
    public func get(key:String, defaultValue:String? = nil)->String? {
        if let value:String = get(key:key)  {
            return value;
        }
        return defaultValue;
    }
    
    public func get(key:String)->Bool? {
        return UserDefaults.standard.value(forKey: key) as? Bool;
    }
    
    
    public func get(key:String)->Int? {
        return UserDefaults.standard.value(forKey: key) as? Int;
    }
    
    public func get(key:String)->String? {
        return UserDefaults.standard.value(forKey: key) as? String;
    }
    
    public func get(key:String)->Data? {
        return UserDefaults.standard.value(forKey: key) as? Data;
    }
    
    public func delete(key:String) {
        UserDefaults.standard.removeObject(forKey: key);
    }
    
    public func isExists(key:String) -> Bool {
        return UserDefaults.standard.value(forKey: key) != nil;
    }
    
    public func archive(fileName:String, objectToSave:Any) {
        
        let fileURL = try! FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false).appendingPathComponent(fileName)
        let data:Data = NSKeyedArchiver.archivedData(withRootObject: objectToSave);

        do {
            try data.write(to: fileURL, options: .atomic)
        } catch {
            print(error)
        }
    }
    
    public func unarchive(fileName:String) -> Any? {
        let fileURL = try! FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false).appendingPathComponent(fileName);
        
        if (FileManager.default.fileExists(atPath: fileURL.path) ) {
            return NSKeyedUnarchiver.unarchiveObject(withFile: fileURL.path);
        }
        return nil;
    }
    
    public func delete(fileName:String) {
        let fileURL = try! FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false).appendingPathComponent(fileName);
        
        if (FileManager.default.fileExists(atPath: fileURL.path) ) {
            try? FileManager.default.removeItem(atPath: fileURL.path);
        }
    }
}
