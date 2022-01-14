//
//  WeatherCell.swift
//  WeatherApp
//
//  Created by Fahad Baig on 12/01/2022.
//

import UIKit
import RxSwift
import RxKingfisher

class DailyWeatherCell: UITableViewCell, Reusable {

    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var temperature: UILabel!
    @IBOutlet weak var feelsLike: UILabel!
    @IBOutlet weak var humidity: UILabel!
    @IBOutlet weak var icon: UIImageView!

	private var disposeBag = DisposeBag()

	func bind(viewModel: DailyWeatherCellViewModelOutput) {
		disposeBag = DisposeBag()
		viewModel.icon.map{$0}.bind(to: icon.kf.rx.image()).disposed(by: disposeBag)
		viewModel.title.bind(to: title.rx.text).disposed(by: disposeBag)
		viewModel.temperature.bind(to: temperature.rx.text).disposed(by: disposeBag)
		viewModel.feelsLike.bind(to: feelsLike.rx.text).disposed(by: disposeBag)
		viewModel.humidity.bind(to: humidity.rx.text).disposed(by: disposeBag)
	}

	override func prepareForReuse() {
		super.prepareForReuse()
		disposeBag = DisposeBag()
	}

}
