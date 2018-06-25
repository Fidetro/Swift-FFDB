
Pod::Spec.new do |s|



  s.name         = "SwiftFFDB"
  s.version      = "2.0.0.3"
  s.summary      = "a Object/Relational Mapping (ORM) support to iOS and Perfect-Server library."
  s.homepage     = "https://github.com/Fidetro/SwiftFFDB"
  s.license      = { :type => "MIT", :file => "LICENSE" }
  s.author             = { "fidetro" => "zykzzzz@hotmail.com" }
  s.platform     = :ios, "8.0"
  s.source       = { :git => "https://github.com/Fidetro/SwiftFFDB.git", :tag => "2.0.0.3" }
  s.source_files  = "Sources", "Sources/*.{swift}"
  s.library = 'sqlite3'
  s.dependency "FMDB","~> 2.7.2"


end
