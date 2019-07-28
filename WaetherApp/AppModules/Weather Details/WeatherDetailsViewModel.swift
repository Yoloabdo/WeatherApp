//
//  WeatherDetailsViewModel.swift
//  WaetherApp
//
//  Created by Abdoelrhman Eaita on 7/28/19.
//  Copyright © 2019 Abdoelrhman Eaita. All rights reserved.
//

import Foundation


protocol WeatherDetailsViewModelDelegate: AnyObject {
    func startActivityIndicator()
    func stopActivityIndicator()
    func fillViewData(data: WeatherCuratedData)
    func animateLabels()
}


class WeatherDetailsViewModel {
    private var request: WeatherRequest?
    var cityId: Int?
    
    weak var delegate: WeatherDetailsViewModelDelegate?
    
    func loadData() {
        delegate?.startActivityIndicator()
        request = WeatherRequest.weather(id: cityId ?? 0)
        request?.send(WeatherResponse.self) {[weak self] (response) in
            self?.handleResponse(response)
        }
    }
    
    func cancelDataLoading() {
        request?.cancelRequest()
    }
    
    
    fileprivate func handleResponse(_ response: ServerResponse<WeatherResponse>) {
        delegate?.stopActivityIndicator()
        switch response {
        case .success(let value) :
            
            let toViewData = prepareDataToView(value)
            delegate?.fillViewData(data: toViewData)
            delegate?.animateLabels()
            
        case .failure(let error):
            print(error)
        }
    }
    
    private func prepareDataToView(_ value: WeatherResponse) -> WeatherCuratedData {
        guard let temp = value.main?.temp,
            let max = value.main?.tempMax,
            let min = value.main?.tempMin else {
                return WeatherCuratedData(description: nil,
                                          currentDegree: nil,
                                          maxDegree: nil,
                                          minDegree: nil)
        }
        
        return WeatherCuratedData(description: value.sys?.country,
                                  currentDegree: Converter.fahrenheitToCelsius(tempInF: temp).rounded().string, maxDegree: Converter.fahrenheitToCelsius(tempInF: max).rounded().string,
                                  minDegree: Converter.fahrenheitToCelsius(tempInF: min).rounded().string)
    }
    
}
