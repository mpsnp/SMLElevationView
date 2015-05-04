#
# Be sure to run `pod lib lint SMLElevationView.podspec' to ensure this is a
# valid spec and remove all comments before submitting the spec.
#
# Any lines starting with a # are optional, but encouraged
#
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = "SMLElevationView"
  s.version          = "0.1.2"
  s.summary          = "View for display elevation profile of trip."
  s.description      = <<-DESC

View was designed for displaying elevation profile of trip. It is fully configurable, you can:

- Change colors of
	- Labels'
	- Grid
	- Stroke of profile
	- Fill of profile
- Change widths of
	- Grid lines
	- Profile line
- Switch between metric and imperial units.
- Specify how many horisontal and vertical lines of grid you need

View is `IB_DESIGNABLE` and all of its key properties are `IBInspectable`.

View supports resizing and was designed for use with autolayout.

                       DESC
  s.homepage         = "https://github.com/mpsnp/SMLElevationView"
  s.screenshots      = "http://i58.fastpic.ru/big/2015/0504/15/744f7335aa266abaae4dee3dab4a5d15.png", "http://i58.fastpic.ru/big/2015/0504/26/cd94a2690841b4e7c83aee5f784c8f26.png"
  s.license          = 'MIT'
  s.author           = { "George Kiriy" => "gkiriy@smedialink.com" }
  s.source           = { :git => "https://github.com/mpsnp/SMLElevationView.git", :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.platform     = :ios, '7.0'
  s.requires_arc = true

  s.source_files = 'Pod/Classes/**/*'
  # s.resource_bundles = {
  #   'SMLElevationView' => ['Pod/Assets/*.png']
  # }

  s.public_header_files = 'Pod/Classes/**/*.h'
  s.frameworks = 'CoreLocation'
  # s.dependency 'AFNetworking', '~> 2.3'
end
