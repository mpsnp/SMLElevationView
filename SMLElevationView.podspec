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
  s.version          = "0.1.3"
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
  s.screenshots      = "http://i57.fastpic.ru/big/2015/0504/cd/32ec673495aaba27bc6b3b74e40609cd.png", "http://i57.fastpic.ru/big/2015/0504/ed/a15997f92836aaf5f8212cbd7e4543ed.png"
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
end
