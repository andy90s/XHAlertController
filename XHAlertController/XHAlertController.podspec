Pod::Spec.new do |s|
  # 1. 基本信息
  s.name             = "XHAlertController"
  s.version          = "1.0.0"
  s.summary          = "A customizable and easy-to-use alert controller for iOS."
  s.description      = <<-DESC
                       XHAlertController is a modern, highly customizable, and declarative alert controller library for iOS. It provides a simple API to create alerts and action sheets with custom views and actions.
                       DESC
  s.homepage         = "https://github.com/your_username/XHAlertController"
  s.license          = { :type => "MIT", :file => "LICENSE" }
  s.author           = { "Your Name" => "your_email@example.com" }
  s.social_media_url = "http://twitter.com/your_twitter"

  # 2. 源代码配置
  s.ios.deployment_target = "12.0"
  s.source           = { :git => "https://github.com/your_username/XHAlertController.git", :tag => "#{s.version}" }
  s.source_files     = "Sources/**/*.{swift}"
  
  # 3. 依赖项配置 (可选)
  # s.dependency "Alamofire", "~> 5.4"
  
  # 4. 资源文件配置 (可选)
  # s.resource_bundles = {
  #   'XHAlertControllerResources' => ['Sources/XHAlertController/Assets/*.{png,json}']
  # }
  
  # 5. 设置库的构建配置 (可选)
  # s.swift_versions = ['5.0', '5.1', '5.2', '5.3', '5.4', '5.5']
end