//
//  AppCoordinator.swift
//  BudTechnicalTask
//
//  Created by Kristina Nenkova on 23/09/2018.
//  Copyright © 2018 Kristina Nenkova. All rights reserved.
//

import UIKit

protocol Coordinator {
    func start()
}

final class AppCoordinator: Coordinator {
    let window: UIWindow
    
    init(window: UIWindow) {
        self.window = window
    }
    
    func start() {
        let server = Server(baseURL: URL(string: "https://www.mocky.io/v2/5b33bdb43200008f0ad1e256")!)
        let apiManager: TransactionManager = { TransactionsAPIManager(server: server) }()
        let viewModel = TransactionsListViewModel(apiManager: apiManager)
        let transactionsListViewController = ТransactionsListViewController(viewModel: viewModel)
        let rootViewController = UINavigationController(rootViewController: transactionsListViewController)
        
        self.window.rootViewController = rootViewController
        self.window.makeKeyAndVisible()
    }
}
