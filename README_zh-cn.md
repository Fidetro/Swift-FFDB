
# SwiftFFDB

![image](https://github.com/Fidetro/SwiftFFDB/blob/master/src/logo.png)  

SwiftFFDB是一个ORM数据库，它支持在iOS和Perfect-Server上使用，SwiftFFDB是基于`FMDB`构建的。  
如果你使用的是`Objective-C`,你可以尝试使用[FFDB](https://github.com/fidetro/ffdb)    

# Wiki
[Wiki](https://github.com/Fidetro/Swift-FFDB/wiki)中有更多使用的例子(还没完成)  

# 依赖
## iOS
* 基于Swift 4.0使用   
* 支持在iOS8.0之后  
* 依赖 [FMDB](https://github.com/ccgus/fmdb)  

## Perfect-Swift-Server
* 基于Swift 4.0.3工具链使用   
* 在Perfect-Server v3中使用
* 依赖 [PerfectMySQL](https://github.com/PerfectlySoft/Perfect-MySQL)  

# 安装
## CocoaPod
SwiftFFDB 可以通过Cocoapod集成到你的工程中：
```
$ vim Podfile
```
在podfile中增加下面的内容:
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
# 用法

## 初始化
你可以下载[示例工程](https://github.com/Fidetro/SwiftFFDB)
如果你打算在iOS上使用:
```
Person.registerTable() //create table
```
或者Perfect-server:
```
    PerfectMySQLConnect(host: "", user: "", password: "", db: "").setup(complete: { (mysql) in
        Person.registerTable() //create table
    })
```

## Create
创建一个表的模型:
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
将数据插入到表中：
```
var person = Person()
person.name = "fidetro"
person.insert()
```
## Select  
查询表中的数据：
```
// find all Object
Person.select(where: nil)
// find name is 'fidetro' 
Person.select(where: "name = 'fidetro'")
```
## Delete  
删除表中的数据：
```
// find name is 'fidetro' 
let personList = Person.select(where: "name = 'fidetro'")

for (let person in personList){
    // delete this person in database
    person.delete()
}
```
你也可以使用底层的`FFDBManager`进行删除:
```
FFDBManager.delete(Person.self, where: "name = 'fidetro'")
```  


# Support
`SwiftFFDB`是我个人的开源项目，如果有什么问题，可以在[Issues](https://github.com/Fidetro/SwiftFFDB/issues)提问或者邮件给我zykzzzz@hotmail.com