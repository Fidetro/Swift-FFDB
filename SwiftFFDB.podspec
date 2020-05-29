
Pod::Spec.new do |s|



  s.name         = "SwiftFFDB"
  s.version      = "2.0.1.4"
  s.summary      = "a Object/Relational Mapping (ORM) support to iOS."
  s.homepage     = "https://github.com/Fidetro/SwiftFFDB"
  s.license      = { :type => "MIT", :file => "LICENSE" }
  s.author             = { "fidetro" => "zykzzzz@hotmail.com" }
  s.platform     = :ios, "8.0"
  s.source       = { :git => "https://github.com/Fidetro/SwiftFFDB.git", :tag => "#{s.version}" }
  s.source_files  = "Sources", "Sources/*.{swift}"
  s.library = 'sqlite3'
  s.dependency "FMDB","~> 2.7.2"


end
