//
//  ViewController.swift
//  YTKeychainManagerExample
//
//  Created by Yasin Turkdogan on 1/11/17.
//  Copyright © 2017 yasinturkdogan. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        YTKeychainManager.shared.userId(value: 1234567890);
        YTKeychainManager.shared.username(value: "yasinturkdogan");
        YTKeychainManager.shared.password(value: "mypassword");
        YTKeychainManager.shared.save(key: "myCustomParameter", data: "myCustomParameterValue");
        
        if let userId = YTKeychainManager.shared.userId() {
            print("userId : " + userId.description);
        }
        
        if let username = YTKeychainManager.shared.username() {
            print("username : " + username);
        }
        
        if let password = YTKeychainManager.shared.password() {
            print("password : " + password);
        }
        
        if let myCustomParameter = YTKeychainManager.shared.get(key: "myCustomParameter") {
            print("myCustomParameter : " + myCustomParameter);
        }
        
        print("UUID" + YTKeychainManager.shared.uuid());
        
        YTSimpleCache.shared.save(key: "mySecondString", value: "mySecondString value");
        YTSimpleCache.shared.archive(fileName: "mySampleObject", objectToSave: SampleObject(field1: "field1Value", field2: 1));
        
        let myInt:Int = YTSimpleCache.shared.get(key: "myInt", defaultValue: 0)!;
        let myBool:Bool = YTSimpleCache.shared.get(key: "myBool", defaultValue: true)!;
        let myString:String = YTSimpleCache.shared.get(key: "myString", defaultValue: "myString default value")!;
        let mySecondString:String? = YTSimpleCache.shared.get(key: "mySecondString");
        let mySampleObject:SampleObject? = YTSimpleCache.shared.unarchive(fileName: "mySampleObject") as? SampleObject;
        
        print("myInt : " + myInt.description);
        print("myBool : " + myBool.description);
        print("myString : " + myString);
        print("mySecondString : \(mySecondString)");
        print("mySampleObject : \(mySampleObject)");
        
    }
}

class SampleObject : NSObject, NSCoding {
    let field1:String;
    let field2:Int;

    init(field1:String, field2:Int) {
        
        self.field1 = field1;
        self.field2 = field2;
    }
    
    required init?(coder aDecoder: NSCoder) {
        self.field1 = aDecoder.decodeObject(forKey: "field1") as! String
        self.field2 = aDecoder.decodeInteger(forKey: "field2")
    }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(self.field1, forKey: "field1");
        aCoder.encode(self.field2, forKey: "field2");
    }
    
    override var description: String {
        get {
            return "field1 : \(field1), field2 : \(field2), "
        }
    }
}
