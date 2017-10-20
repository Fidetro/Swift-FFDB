
Pod::Spec.new do |s|



  s.name         = "SwiftFFDB"
  s.version      = "0.0.1"
  s.summary      = "easy to use FMDB."
  s.homepage     = "https://github.com/Fidetro/SwiftFFDB"
  s.license      = { :type => "MIT", :file => "LICENSE" }
  s.author             = { "fidetro" => "zykzzzz@hotmail.com" }
  s.platform     = :ios, "8.0"
  s.source       = { :git => "https://github.com/Fidetro/SwiftFFDB.git", :tag => "0.0.1" }
s.source_files  = "Swift-FFDB", "Swift-FFDB/Classes/**/*.{swift}"
  s.library = 'sqlite3'
  s.dependency "FMDB","~> 2.7.2"


end
