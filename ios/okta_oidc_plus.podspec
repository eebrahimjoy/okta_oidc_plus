#
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html.
# Run `pod lib lint okta_oidc_plus.podspec` to validate before publishing.
#
Pod::Spec.new do |s|
  s.name             = 'okta_oidc_plus'
  s.version          = '1.0.2'
  s.summary          = 'A Flutter plugin for Okta OIDC authentication.'
  s.description      = <<-DESC
A modern Flutter plugin for Okta OIDC authentication enabling secure user login, token management, and identity integration using OpenID Connect with Okta services.
                       DESC
  s.homepage         = 'https://eebrahimjoy.com'
  s.license          = { :file => '../LICENSE' }
  s.author           = { 'Eebrahim Joy' => 'eebrahimjoy@gmail.com' }
  s.source           = { :path => '.' }
  s.source_files = 'Classes/**/*'
  s.dependency 'Flutter'
  s.dependency 'OktaOidc'
  s.platform = :ios, '13.0'

  # Flutter.framework does not contain a i386 slice.
  s.pod_target_xcconfig = { 'DEFINES_MODULE' => 'YES', 'EXCLUDED_ARCHS[sdk=iphonesimulator*]' => 'i386' }
  s.swift_version = '5.0'
end
