Pod::Spec.new do |s|
  s.name             = 'faketooth_flutter_ios'
  s.version          = '0.1.2'
  s.summary          = 'Faketooth - BLE emulator'
  s.description      = <<-DESC
A flutter plugin for emulating BLE device
                       DESC
  s.homepage         = 'https://github.com/rozd/faketooth-flutter'
  s.license          = { :file => '../LICENSE' }
  s.author           = { 'Max Rozdobudko' => 'max.rozdobudko@gmail.com' }
  s.source           = { :path => '.' }
  s.source_files     = ['Classes/**/*', 'Vendor/Faketooth/Sources/Faketooth-ObjC/*']
  s.dependency 'Flutter'
  s.platform = :ios, '10.0'

  # Flutter.framework does not contain a i386 slice. Only x86_64 simulators are supported.
  s.pod_target_xcconfig = { 'DEFINES_MODULE' => 'YES', 'VALID_ARCHS[sdk=iphonesimulator*]' => 'x86_64' }
  s.swift_version = '5.0'
end
