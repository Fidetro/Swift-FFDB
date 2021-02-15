
Pod::Spec.new do |s|



  s.name         = "SwiftFFDB"
  s.version      = "2.3"
  s.summary      = "a Object/Relational Mapping (ORM) support to iOS."
  s.homepage     = "https://github.com/Fidetro/SwiftFFDB"
  s.license      = { :type => "MIT", :file => "LICENSE" }
  s.author             = { "fidetro" => "zykzzzz@hotmail.com" }
  s.ios.deployment_target  = '9.0'
  s.osx.deployment_target  = '10.9'
  s.source       = { :git => "https://github.com/Fidetro/SwiftFFDB.git", :tag => "#{s.version}" }
  s.source_files  = "Sources", "Sources/*.{swift}"
  s.library = 'sqlite3'
  s.dependency "FMDB","~> 2.7.2"


end
