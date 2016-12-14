Pod::Spec.new do |s|
  s.name     = 'NSDate-Extensions'
  s.version  = '0.0.1'
  s.license  = 'MIT'
  s.summary  = 'Practical real-world dates.'
  s.homepage = 'http://ericasadun.com'
  s.author   = { 'Erica Sadun' => 'erica@ericasadun.com' }
  s.source   = { :git => 'https://github.com/erica/NSDate-Extensions.git' }
  s.platform = :ios  
  s.source_files = 'NSDate-Utilities.{h,m}'
  s.framework = 'Foundation'
end
