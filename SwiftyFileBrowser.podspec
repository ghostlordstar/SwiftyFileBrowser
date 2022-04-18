#
# Be sure to run `pod lib lint SwiftyFileBrowser.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
    s.name             = 'SwiftyFileBrowser'
    s.version          = '0.3.2'
    s.summary          = 'A file browser lib of swift(icon type comming soon!).'
    
    # This description is used to generate tags and improve search results.
    #   * Think: What does it do? Why did you write it? What is the focus?
    #   * Try to keep it short, snappy and to the point.
    #   * Write the description between the DESC delimiters below.
    #   * Finally, don't worry about the indent, CocoaPods strips it!
    
    s.description      = <<-DESC
    A file browser lib of swift.
    DESC
    
    s.homepage         = 'https://github.com/ghostlordstar/SwiftyFileBrowser'
    s.screenshots      = 'https://raw.githubusercontent.com/ghostlordstar/SwiftyFileBrowser/main/ScreenShot/st_list.png'
    s.license          = { :type => 'MIT', :file => 'LICENSE' }
    s.author           = { 'Hansen' => 'heshanzhang@outlook.com' }
    s.source           = { :git => 'https://github.com/ghostlordstar/SwiftyFileBrowser.git', :tag => s.version.to_s }
    # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'
    
    s.ios.deployment_target = '14.0'
    
    s.swift_version = "5.0"
    
    s.source_files = 'SwiftyFileBrowser/Classes/**/*'
    
    s.resource_bundles = {
        'SwiftyFileBrowser' => ['SwiftyFileBrowser/Assets/*.*']
    }
    
    # s.public_header_files = 'Pod/Classes/**/*.h'
    # s.frameworks = 'UIKit', 'MapKit'
    s.dependency 'AppleDownloadButton'
end
