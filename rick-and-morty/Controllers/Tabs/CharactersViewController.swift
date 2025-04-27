import UIKit

final class CharactersViewController: UIViewController, CharacterListViewDelegate {
    private let dataSource = CharactersViewDataSource()
    
    private lazy var delegate = CharacterListDelegate(
        didSelectItem: { [weak self] index in
            guard let self = self,
                  let navigationController = self.navigationController else { return }
            
            let item = self.viewModel.characters[index]
            guard let id = item.id, let characterName = item.name else { return }
            
            let viewModel = CharacterDetailsViewModel(id: id, characterName: characterName)
            let characterDetailsViewController = CharacterDetailsViewController(viewModel: viewModel)
            navigationController.pushViewController(characterDetailsViewController, animated: true)
        }, loadMore: { [weak self] in
            guard let self = self else { return }
            
            self.viewModel.fetchCharactersByNextPage()
        }
    )
    
    private var viewModel: CharactersViewModel!
    
    private lazy var characterListView = CharacterListView(
        frame: .zero,
        delegate: delegate,
        dataSource: dataSource
    )
    
    required init?(coder: NSCoder) {
        fatalError("Unsupported")
    }
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        viewModel = CharactersViewModel(delegate: self)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Characters"
        setupView()
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        
        coordinator.animate { _ in
            self.characterListView.invalidateLayout()
        }
    }
    
    fileprivate func setupView() {
        addSearchButton()
        
        view.backgroundColor = .systemBackground
        view.addSubview(characterListView)
        
        NSLayoutConstraint.activate([
            characterListView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            characterListView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            characterListView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            characterListView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor)
        ])
    }
    
    private func addSearchButton() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            barButtonSystemItem: .search,
            target: self,
            action: #selector(didTapSearch)
        )
    }
    
    @objc private func didTapSearch() {
        let searchViewController = CharacterSearchViewController()
        
        navigationController?.pushViewController(searchViewController, animated: true)
    }
    
    func didLoadInitial(_ characters: [Character]) {
        dataSource.updateCharacters(characters)
        characterListView.collectionView.reloadData()
        characterListView.didLoadInitial()
    }
    
    func loadMoreInProgress(with value: Bool) {
        delegate.updateShouldShowLoader(with: value)
    }
    
    func didLoadMore(_ characters: [Character], _ indexPaths: [IndexPath]) {
        dataSource.appendCharacters(characters)
        
        characterListView.collectionView.performBatchUpdates {
            self.characterListView.collectionView.insertItems(at: indexPaths)
        }
    }
    
}

extension CharactersViewController: UINavigationData {
    var uiTabBarItem: UITabBarItem {
        get {
            return UITabBarItem(title: "Characters", image: UIImage(systemName: "person"), tag: 1)
        }
    }
}
