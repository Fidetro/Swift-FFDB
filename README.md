
# SwiftFFDB

![image](https://github.com/Fidetro/SwiftFFDB/blob/master/src/logo.png)  
SwiftFFDB is a Object/Relational Mapping (ORM) support to iOS and Perfect-Server library.Since SwiftFFDB is build on top of FFDB.  
if you use Objective-C,you can use [FFDB](https://github.com/fidetro/ffdb)  

# Requirements
## iOS
* Build  Swift4.0 releases toolchain   
* Deployment on iOS 8 or above  
* depend [FMDB](https://github.com/ccgus/fmdb)

## Perfect-Swift-Server
* Build  Swift4.0 releases toolchain   
* Perfect-Server v3
* depend [PerfectMySQL](https://github.com/PerfectlySoft/Perfect-MySQL)

# Installing
## CocoaPod
SwiftFFDB can be installed using CocoaPod
```
vim Podfile
```
Then,edit the Podfile,add SwiftFFDB:
```
platform :ios, '8.0'
target 'YouApp' do
use_frameworks!
pod 'SwiftFFDB'
end
```
## Swift Package Manager
```
import PackageDescription

let package = Package(
    name: "PatchServer",
    dependencies: [
          .Package(url: "https://github.com/Fidetro/PerfectFFDB.git",versions: Version(0, 0, 0)..<Version(1, .max, .max))]
)

```
# Useage

## Setting
You can check out the [example project](https://github.com/Fidetro/SwiftFFDB)
if you use in iOS:
```
Person.registerTable() //create table
```
or Perfect-server:
```
    PerfectMySQLConnect(host: "", user: "", password: "", db: "").setup(complete: { (mysql) in
        Person.registerTable() //create table
    })
```

## Create
create table model would you look like this:
```
struct Person:FFObject {
    var primaryID: Int64?
    
    var name : String?
    
    static func memoryPropertys() -> [String]? {
        return nil
    }
    
    static func customColumnsType() -> [String : String]? {
        return nil
    }
    
    static func customColumns() -> [String : String]? {
        return nil
    }
}
```

## Insert
```
var person = Person()
person.name = "fidetro"
person.insert()
```
## Select
```
// find all Object
Person.select(where: nil)
// find name is 'fidetro' 
Person.select(where: "name = 'fidetro'")
```
## Delete
```
// find name is 'fidetro' 
let personList = Person.select(where: "name = 'fidetro'")

for (let person in personList){
    // delete this person in database
    person.delete()
}
```
also you can:
```
FFDBManager.delete(Person.self, where: "name = 'fidetro'")
```  


# Support
`SwiftFFDB` is a personal open source project,but I happy to answer questions in [Issues](https://github.com/Fidetro/SwiftFFDB/issues) or email to zykzzzz@hotmail.com

