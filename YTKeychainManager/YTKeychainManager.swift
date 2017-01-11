//
//  YTKeychainManager.swift
//  YTKeychainManager
//
//  Created by Yasin Turkdogan on 1/11/17.
//  Copyright © 2017 yasinturkdogan. All rights reserved.
//

import Foundation
import UIKit
import Security

// Identifiers
let userAccount = "User"
let accessGroup = "Authentication"

// Arguments for the keychain queries
let kSecClassValue = NSString(format: kSecClass);
let kSecAttrAccountValue = NSString(format: kSecAttrAccount);
let kSecValueDataValue = NSString(format: kSecValueData);
let kSecClassGenericPasswordValue = NSString(format: kSecClassGenericPassword);
let kSecAttrServiceValue = NSString(format: kSecAttrService);
let kSecMatchLimitValue = NSString(format: kSecMatchLimit);
let kSecReturnDataValue = NSString(format: kSecReturnData);
let kSecMatchLimitOneValue = NSString(format: kSecMatchLimitOne);


public class YTKeychainManager {
    
    public static let shared = YTKeychainManager()
    
    private init() {}
    
    public func userId()->Int? {
        if let userId:String = get(key: "userId") {
            return userId.toInteger();
        }
        return nil;
    }
    
    public func username()->String? {
        if let username:String = get(key: "username") {
            return username;
        }
        return nil;
    }
    
    public func password()->String? {
        if let password:String = get(key: "password") {
            return password;
        }
        return nil;
    }
    
    public func userId(value:Int) {
        save(key: "userId", data: String(value));
    }
    
    public func username(value:String) {
        save(key: "username", data: value);
    }
    
    public func password(value:String) {
        save(key: "password", data: value);
    }
    
    public func uuid()->String {
        if let guid:String = get(key: "uuid") {
            return guid
        }
        
        let newGuid = NSUUID().uuidString
        save(key: "uuid", data: newGuid);
        return newGuid;
    }
    
    public func save(key: String, data: String) {
        let bundleKey = getBundleKey(key);
        let dataFromString: Data = data.data(using: String.Encoding.utf8, allowLossyConversion: false)!
        
        // Instantiate a new default keychain query
        let keychainQuery: NSMutableDictionary = NSMutableDictionary(
            objects: [kSecClassGenericPasswordValue, bundleKey, userAccount, dataFromString],
            forKeys: [kSecClassValue, kSecAttrServiceValue, kSecAttrAccountValue, kSecValueDataValue]
        )
        
        // Delete any existing items
        SecItemDelete(keychainQuery as CFDictionary)
        
        // Add the new keychain item
        let status = SecItemAdd(keychainQuery as CFDictionary, nil)
        
        if(status == -34018) {
            NSLog("Keychain error: -34018");
        }
        
        if(status < 0) {
            NSLog("Keychain error");
        }
        
        YTSimpleCache.shared.save(key:bundleKey, value: String(data));
    }
    
    public func delete(_ key: String) {
        
        let bundleKey = getBundleKey(key);
        
        // Instantiate a new default keychain query
        let keychainQuery: NSMutableDictionary = NSMutableDictionary(
            objects: [kSecClassGenericPasswordValue, bundleKey, userAccount],
            forKeys: [kSecClassValue, kSecAttrServiceValue, kSecAttrAccountValue]
        )
        
        // Delete any existing items
        let status = SecItemDelete(keychainQuery as CFDictionary);
        
        if(status == -34018) {
            NSLog("Keychain error: -34018");
        }
        
        if(status < 0) {
            NSLog("Keychain error");
        }
        
        YTSimpleCache.shared.delete(key: bundleKey);
    }
    
    public func get(key: String) -> String? {
        
        let bundleKey = getBundleKey(key);
        
        if(YTSimpleCache.shared.isExists(key:bundleKey)) {
            return YTSimpleCache.shared.get(key:bundleKey)!;
        }
        
        let keyChainQuery: NSMutableDictionary = NSMutableDictionary(
            objects: [kSecClassGenericPasswordValue, bundleKey, userAccount, kCFBooleanTrue, kSecMatchLimitOneValue],
            forKeys: [kSecClassValue, kSecAttrServiceValue, kSecAttrAccountValue, kSecReturnDataValue, kSecMatchLimitValue]
        )
        
        var extractedData: AnyObject?
        let status:OSStatus = SecItemCopyMatching(keyChainQuery, &extractedData)
        
        if (status == errSecSuccess) {
            if let retrievedData = extractedData as? Data {
                if let value = String(data: retrievedData, encoding: String.Encoding.utf8) {
                    YTSimpleCache.shared.save(key:bundleKey, value: value);
                    return value
                }
            }
        }
        if(status == -34018) {
            NSLog("Keychain error: -34018");
        }
        
        if(status < 0) {
            NSLog("Keychain error");
        }
        
        return nil;
    }
    
    public func reset() {
        save(key: "userId", data: "");
        save(key: "password", data: "");
    }
    
    private func getBundleKey(_ key:String)->String {
        return Bundle.main.bundleIdentifier! + "." + key;
    }
}


extension String {
    
    func toInteger()->Int {
        return Int(NSString(string: self).intValue);
    }
    
}

