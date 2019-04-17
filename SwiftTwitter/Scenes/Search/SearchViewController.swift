//
//  SearchViewController.swift
//  SwiftTwitter
//
//  Created by Matheus Lima on 11/04/19.
//  Copyright (c) 2019 Matheus Lima. All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates so
//  you can apply clean architecture to your iOS and Mac projects,
//  see http://clean-swift.com
//

import UIKit
import Kingfisher

protocol SearchDisplayLogic: class {
    func displaySearchedTweets(viewModel: Search.SearchTweets.ViewModel)
    func displaySearchedTweetsError(viewModel: Search.SearchTweets.ViewModel)
    func startLoading()
    func stopLoading()
}

class SearchViewController: UIViewController {
    
    // MARK: - Outlets
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var hintLabel: UILabel!
    
    // MARK: - Properties
    
    private var interactor: SearchBusinessLogic?
    private var displayedTweets: [Search.SearchTweets.ViewModel.DisplayedTweet] = []
    private var searchBar: UISearchBar?
    private let refreshControl = UIRefreshControl()
    
    var router: (NSObjectProtocol & SearchRoutingLogic & SearchDataPassing)?
    
    // MARK: - Object lifecycle
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    // MARK: - Setup
    
    private func setup() {
        let viewController = self
        let interactor = SearchInteractor()
        let presenter = SearchPresenter()
        let router = SearchRouter()
        viewController.interactor = interactor
        viewController.router = router
        interactor.presenter = presenter
        presenter.viewController = viewController
        router.viewController = viewController
        router.dataStore = interactor
    }
    
    private func setupSearchBar() {
        searchBar = UISearchBar()
        searchBar?.placeholder = "Search Twitter"
        
        if let searchBarTextField = searchBar?.value(forKey: "searchField") as? UITextField {
            searchBarTextField.backgroundColor = UIColor(named: "ExtraLightGray")
            searchBarTextField.layer.cornerRadius = 20
            searchBarTextField.clipsToBounds = true
        }
        
        searchBar?.delegate = self
        navigationItem.titleView = searchBar
    }
    
    private func setupRefreshControl() {
        refreshControl.backgroundColor = UIColor(named: "ExtraLightGray")
        refreshControl.addTarget(self, action: #selector(refresh(_:)), for: .valueChanged)
        
        if #available(iOS 10.0, *) {
            tableView.refreshControl = refreshControl
        } else {
            tableView.backgroundView = refreshControl
        }
    }
    
    private func prepareUI() {
        setupSearchBar()
        setupRefreshControl()
        
        interactor?.searchTweets(request: Search.SearchTweets.Request(searchText: "Twitch"))
    }
    
    // MARK: - Routing
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let scene = segue.identifier else { return }
        
        let selector = NSSelectorFromString("routeTo\(scene)WithSegue:")
        if let router = router, router.responds(to: selector) {
            router.perform(selector, with: segue)
        }
    }
    
    // MARK: - View lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        prepareUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if let selected = tableView.indexPathForSelectedRow {
            tableView.deselectRow(at: selected, animated: false)
        }
    }
    
    private func loadUI() {
        tableView.reloadData()
        // Scroll to top
        let topIndex = IndexPath(row: 0, section: 0)
        tableView.scrollToRow(at: topIndex, at: .top, animated: true)
        tableView.isHidden = false
    }
    
    // MARK: - Search Tweets Logic
    
    private func searchTweets() {
        guard let searchText = searchBar?.text, !searchText.isEmpty else { return }
        
        let request = Search.SearchTweets.Request(searchText: searchText)
        interactor?.searchTweets(request: request)
    }
    
    @objc func refresh(_ refreshControl: UIRefreshControl) {
       interactor?.refreshTweets()
    }
}

// MARK: - SearchDisplayLogic

extension SearchViewController: SearchDisplayLogic {
    func displaySearchedTweets(viewModel: Search.SearchTweets.ViewModel) {
        guard let displayedTweets = viewModel.displayedTweets else { return }
        
        self.displayedTweets = displayedTweets
        loadUI()
    }
    
    func displaySearchedTweetsError(viewModel: Search.SearchTweets.ViewModel) {
        guard let errorMessage = viewModel.error else { return }
        showInfo(withTitle: "Ops!", withMessage: errorMessage)
    }
    
    func startLoading() {
        tableView.isHidden
            ? activityIndicator.startAnimating()
            : tableView.startAnimating()
    }
    
    func stopLoading() {
        tableView.isHidden
            ? activityIndicator.stopAnimating()
            : tableView.stopAnimating()
    }
}

// MARK: - UITableViewDataSource

extension SearchViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return displayedTweets.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let displayedTweet = displayedTweets[indexPath.row]
        let cell = Bundle.main.loadNibNamed("TweetTableViewCell", owner: self, options: nil)?.first as! TweetTableViewCell
        
        cell.profileImageView.kf.setImage(with: displayedTweet.authorProfileImageUrl)
        cell.profileImageView.kf.indicatorType = .activity
        cell.nameLabel.text = displayedTweet.authorName
        cell.usernameLabel.text = displayedTweet.authorUsername
        cell.dateLabel.text = displayedTweet.date
        cell.replyToUsernameLabel.attributedText = displayedTweet.replyToUsername
        cell.fullTextLabel.text = displayedTweet.text
        cell.replyCountLabel.text = displayedTweet.replyCount
        cell.retweetCountLabel.text = displayedTweet.retweetCount
        cell.favoriteCountLabel.text = displayedTweet.favoriteCount
        
        return cell
    }
}

// MARK: - UITableviewDelegate

extension SearchViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        router?.routeToTimeline(segue: nil)
    }
}

// MARK: - UISearchBarDelegate

extension SearchViewController: UISearchBarDelegate {
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        searchBar.setShowsCancelButton(true, animated: true)
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        searchBar.setShowsCancelButton(false, animated: true)
        searchBar.text = nil
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        searchBar.setShowsCancelButton(false, animated: true)
        
        // Make the request
        self.searchTweets()
    }
}
