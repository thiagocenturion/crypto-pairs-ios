//
//  TickersListViewController.swift
//  CryptoPairs
//
//  Created by Thiago Centurion on 12/06/2022.
//

import UIKit
import RxSwift
import RxCocoa

final class TickersListViewController: UIViewController {

    enum Constants {

        static let margin: CGFloat = 16
        static let estimatedRowHeight: CGFloat = 80
        static let searchDebounceDueTime: RxTimeInterval = .milliseconds(500)
        static let toastAnimationDuration: TimeInterval = 0.5

        enum Insets {

            static let tableView = UIEdgeInsets(top: .zero, left: Constants.margin, bottom: .zero, right: -Constants.margin)
        }
    }

    // MARK: Properties

    private let viewModel: TickersListViewModel

    private var searchController: UISearchController = {
        let searchController = UISearchController(searchResultsController: nil)
        searchController.showsSearchResultsController = true
        searchController.obscuresBackgroundDuringPresentation = false
        return searchController
    }()

    private let tableView: UITableView = {

        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.backgroundColor = ColorPalette.tableViewBackground
        tableView.estimatedRowHeight = Constants.estimatedRowHeight
        tableView.rowHeight = UITableView.automaticDimension
        tableView.separatorStyle = .none
        tableView.register(TickerCell.self, forCellReuseIdentifier: String(describing: TickerCell.self))
        return tableView
    }()

    private weak var errorToastView: ErrorToastView?

    private let disposeBag = DisposeBag()

    // MARK: - Initialization

    init(viewModel: TickersListViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - View Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()

        configureView()
        bind()
    }
}

// MARK: - View

private extension TickersListViewController {

    func configureView() {
        title = viewModel.title
        view.backgroundColor = ColorPalette.tableViewBackground
        searchController.searchBar.placeholder = viewModel.searchBarPlaceholder

        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false

        addSubviews()
        configureConstraints()
    }

    func addSubviews() {
        view.addSubview(tableView)
    }

    func configureConstraints() {
        tableView.edge(insets: Constants.Insets.tableView, to: self.view, ignoringBottomSafeArea: true)
    }

    func addErrorToastView(with errorToastViewModel: ErrorToastViewModel) {
        let errorToastView = ErrorToastView()
        errorToastView.translatesAutoresizingMaskIntoConstraints = false
        errorToastView.configure(with: errorToastViewModel)
        errorToastView.alpha = 0

        view.addSubview(errorToastView)
        errorToastView.edge(top: Constants.margin, left: Constants.margin, right: -Constants.margin, to: view)

        self.errorToastView = errorToastView

        UIView.animate(withDuration: Constants.toastAnimationDuration) {
            errorToastView.alpha = 1
        }
    }

    func removeErrorToastView() {
        guard let errorToastView = errorToastView else { return }

        UIView.animate(withDuration: Constants.toastAnimationDuration) {
            errorToastView.alpha = 0
            errorToastView.removeFromSuperview()
        }
    }
}

// MARK: - Binding

private extension TickersListViewController {

    func bind() {
        // Binding tickers cell view models to the TableView
        self.viewModel.cellViewModels
            .asDriver()
            .drive(tableView.rx.items(cellIdentifier: String(describing: TickerCell.self), cellType: TickerCell.self)) { _, cellViewModel, cell in

                cell.configure(with: cellViewModel)
            }
            .disposed(by: disposeBag)

        // Binding entry search to the ViewModel
        self.searchController.searchBar.rx.text
            .orEmpty
            .debounce(Constants.searchDebounceDueTime, scheduler: MainScheduler.instance)
            .distinctUntilChanged()
            .bind(to: viewModel.query)
            .disposed(by: disposeBag)

        // Binding event when cancel button is tapped
        self.searchController.searchBar.rx
            .cancelButtonClicked
            .bind(to: viewModel.cancelFilter)
            .disposed(by: disposeBag)

        // Show error toast
        self.viewModel.errorToast
            .observe(on: MainScheduler.instance)
            .subscribe(onNext: { [weak self] errorToast in
                guard let errorToast = errorToast else {
                    self?.removeErrorToastView()
                    return
                }

                if self?.errorToastView == nil {
                    self?.addErrorToastView(with: errorToast)
                }
            })
            .disposed(by: disposeBag)

        // Starts requests in the view model
        self.viewModel.start()
    }
}
