# Uncomment the next line to define a global platform for your project
# platform :ios, '9.0'
use_frameworks!
inhibit_all_warnings!

workspace 'Gaming'


target 'Gaming' do
  # Comment the next line if you don't want to use dynamic frameworks
 

  # Pods for Gaming
  pod 'Kingfisher'
  pod 'RealmSwift'
  pod 'Realm'
  pod 'Alamofire'
  pod 'Bond'
  pod 'RxSwift'
  pod 'Swinject'
  pod 'SwinjectAutoregistration'
  
  target 'GamingTests' do
       inherit! :search_paths
       pod 'RxSwift'
   end
 
end


 target 'Core' do
   project 'Modules/Core/Core.xcodeproj'
    pod 'RxSwift'
    pod 'RealmSwift'
 end 


 target 'Game' do
   project 'Modules/Game/Game.xcodeproj'
    pod 'RxSwift'
    pod 'Realm'
    pod 'Alamofire'
 end

 target 'Favorite' do
   project 'Modules/Favorite/Favorite.xcodeproj'
    pod 'RxSwift'
    pod 'Realm'
    pod 'RealmSwift'
 end 	  	

 	  	  
