//
//  ViewController.swift
//  WeatherApp
//
//  Created by Fahad Baig on 12/01/2022.
//

import UIKit
import RxSwift
import CoreLocation
import Alamofire
import Reusable

class WeatherForecastViewController: UIViewController, StoryboardSceneBased {
	static var sceneStoryboard: UIStoryboard = UIStoryboard(name: "Main", bundle: .main)

    @IBOutlet weak var currentWeatherView: CurrentWeatherView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
	var viewModel: WeatherViewModel?
    private let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()

		//configure tableView
        tableView.rowHeight = 80

		//bind view model
		guard let viewModel = self.viewModel else { return }
		bind(viewModel: viewModel)

		//load weather
		viewModel.loadWeather.onNext(())
    }

	//bind weather view model to view
	private func bind(viewModel: WeatherViewModel) {
		viewModel.showLoading.bind(to: activityIndicator.rx.isAnimating).disposed(by: disposeBag)
		currentWeatherView.bindViewModel(viewModel: viewModel.currentWeatherViewModel)
		bind(dailyWeather: viewModel.dailyWeather)
	}

	//bind daily weather list to tableView
	private func bind(dailyWeather: Observable<[DailyWeatherCellViewModelOutput]>) {
		dailyWeather.bind(to: tableView.rx.items(cellIdentifier: DailyWeatherCell.reuseIdentifier, cellType: DailyWeatherCell.self)) { _, viewModel, cell in
			cell.bind(viewModel: viewModel)
		}.disposed(by: disposeBag)
	}
}

