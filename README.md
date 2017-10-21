
# SwiftFFDB

SwiftFFDB is a Object/Relational Mapping (ORM) support to iOS and Perfect-Server library.Since SwiftFFDB is build on top of FFDB.  
if you use Objective-C,you can use [FFDB](https://github.com/fidetro/ffdb)  

# Requirements
* Build  Swift4.0 releases toolchain   
* Deployment on iOS 8 or above  
* Perfect-Server v3(linking your project with PerfectMySQL)

# Installing
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

# Useage

## Setting
You can check out the [example project](https://github.com/Fidetro/SwiftFFDB-Example)  
if you use in iOS:
```
FFDB.setup(.FMDB) //select database type
Person.registerTable() //create table
```
or Perfect-server:
```
   FFDB.setup(.PerfectMySQL)
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
// find name is 'fidetro' object
Person.select(where: "name = 'fidetro'")
```
## Delete
