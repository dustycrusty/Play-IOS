# Uncomment the next line to define a global platform for your project
 platform :ios, '11.0'

inhibit_all_warnings!

target 'playBetaV1' do
  # Comment the next line if you're not using Swift and don't want to use dynamic frameworks
use_frameworks!

  # Pods for playBetaV1
  pod 'TPKeyboardAvoiding'
  pod 'CodableFirebase'
  pod 'Firebase'
  pod 'GeoFire', '>= 1.1'
  pod 'Firebase/Auth'
  pod 'ImageSlideshow', '~> 1.5'
  pod 'AMScrollingNavbar'
  pod 'Segmentio', '~> 3.0'
  pod 'GoogleMaps'
  pod 'M13Checkbox'
  pod 'RSKImageCropper'
  pod 'AvatarImageView', '~> 2.1.0'
  pod 'FirebaseUI/Storage'
  pod 'GooglePlaces'
  pod 'GoogleSignIn'
  pod 'FBSDKLoginKit'
  pod 'Kingfisher', '~> 4.0'
  pod 'Dropper'
  
target 'playBetaV1Tests' do
    inherit! :search_paths
    # Pods for testing
  end

  target 'playBetaV1UITests' do
    inherit! :search_paths
    # Pods for testing
  end

post_install do |installer|
    installer.pods_project.build_configurations.each do |config|
        config.build_settings.delete('CODE_SIGNING_ALLOWED')
        config.build_settings.delete('CODE_SIGNING_REQUIRED')
    end
end

end
