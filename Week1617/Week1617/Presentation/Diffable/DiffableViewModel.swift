//
//  DiffableViewModel.swift
//  Week1617
//
//  Created by 소연 on 2022/10/20.
//

import Foundation

import RxCocoa
import RxSwift

enum SearchError: Error {
    case noPhoto
    case serverError
}


class DiffableViewModel {
    
//    var photoList: CObservable<SearchPhoto> = CObservable(SearchPhoto(total: 0, totalPages: 0, results: []))
    var photoList = PublishSubject<SearchPhoto>()
    
    func requestSearchPhoto(query: String) {
        APIService.searchPhoto(query: query) { [weak self] photo, statusCode, error in
            guard let self = self else { return }
            
            guard let statusCode = statusCode, statusCode == 500 else {
                self.photoList.onError(SearchError.serverError)
                return
            }

            guard let photo = photo else {
                self.photoList.onError(SearchError.noPhoto)
                return
            }
            
//            self.photoList.value = photo
            self.photoList.onNext(photo)
        }
    }
}
