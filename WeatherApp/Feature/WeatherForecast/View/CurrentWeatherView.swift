//
//  CurrentWeatherView.swift
//  WeatherApp
//
//  Created by Fahad Baig on 14/01/2022.
//

import UIKit
import RxSwift
import RxKingfisher

class CurrentWeatherView: UIView, NibOwnerLoadable {

	@IBOutlet weak var icon: UIImageView!
	@IBOutlet weak var city: UILabel!
	@IBOutlet weak var temperature: UILabel!
	@IBOutlet weak var feelsLike: UILabel!
	@IBOutlet weak var humidity: UILabel!

	private let disposeBag = DisposeBag()

	required init?(coder: NSCoder) {
		super.init(coder: coder)
		loadNibContent()
	}

	func bindViewModel(viewModel: Observable<CurrentWeatherViewModelOutput>) {
		viewModel.flatMap{$0.icon}.map{$0}.bind(to: icon.kf.rx.image()).disposed(by: disposeBag)
		viewModel.flatMap{$0.city}.bind(to: city.rx.text).disposed(by: disposeBag)
		viewModel.flatMap{$0.temperature}.bind(to: temperature.rx.text).disposed(by: disposeBag)
		viewModel.flatMap{$0.feelsLike}.bind(to: feelsLike.rx.text).disposed(by: disposeBag)
		viewModel.flatMap{$0.humidity}.bind(to: humidity.rx.text).disposed(by: disposeBag)
	}
}
