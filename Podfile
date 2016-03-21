# Uncomment this line to define a global platform for your project
# platform :ios, '8.0'
# Uncomment this line if you're using Swift
# use_frameworks!

use_frameworks!

target 'FindMyGoat' do
	pod 'RealmSwift'
	pod 'RealmMapView'
end

post_install do |installer|
    `rm -rf Pods/Headers`
end