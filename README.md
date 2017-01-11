# YTKeychainManager

YTKeychainManager helps you to store data in KeyChain. Data stored in keychain remain even app is removed. If iCloud Keychain is enabled, it is also shared accross devices. Using user defaults as fallback.

It has built in getters for userid, username and password to simplify usage.

```
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
//Generates a unique id and stores in keychain
let uuid = YTKeychainManager.shared.uuid();       
```

# YTSimpleCache

YTSimpleCache simplifies your cache needs. It is possible to archive objects implements NSCoding protocol.

```
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
```
