# Uncomment the next line to define a global platform for your project
# platform :ios, '9.0'

platform :ios, '13.0'
use_frameworks!
workspace 'WeatherApp'

def reactivePods
	pod 'RxSwift', '6.2'
	pod 'RxCocoa', '6.2'
	pod 'RxFlow', '~> 2.12'
end

def storePods
	pod "Moya/RxSwift", '~> 15.0'
end

#Store
target 'Store' do
	project 'Components/Store/Store.xcodeproj'
	reactivePods
	storePods
end

#WeatherApp
target 'WeatherApp' do
	reactivePods
	storePods
	pod 'RxKingfisher', '~> 2.1'
	pod 'Reusable', '~> 4.1'
end

target 'WeatherAppTests' do
	reactivePods
end
