//
//  DetailPageViewController.swift
//  Youfilx
//
//  Created by 삼인조 on 2023/09/04.
//

import UIKit

final class DetailPageViewController: UIViewController {
    
    private lazy var scrollView = UIScrollView()
    private lazy var stackView: UIStackView = {
       let stackView = UIStackView()
        stackView.distribution = .fill
        stackView.axis = .vertical
        stackView.spacing = 10
        stackView.layoutMargins = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        stackView.isLayoutMarginsRelativeArrangement = true
        return stackView
    }()
    private lazy var youtubeView = YoutubeView()
    private lazy var videoInformationStackView = BackgroundColorAlphaChangeLikeUIButtonWhenTappedUIStackView {
        //TODO: 자세한 정보 보여주는 뷰
    }.and {
        $0.backgroundColor = .black
        $0.distribution = .fill
        $0.alignment = .leading
        $0.axis = .vertical
        $0.spacing = 10
    }
    private lazy var videoTitleLabel: UILabel = {
        let uiLabel = UILabel()
        uiLabel.textColor = .white
        uiLabel.font = .systemFont(ofSize: 26, weight: .bold)
        return uiLabel
    }()
    private lazy var videoInformationsStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.distribution = .fillProportionally
        stackView.axis = .horizontal
        stackView.spacing = 10
        return stackView
    }()
    private lazy var videoInformationLabel: UILabel = {
        let uiLabel = UILabel()
        uiLabel.textColor = .white
        uiLabel.font = .systemFont(ofSize: 12, weight: .light)
        return uiLabel
    }()
    private lazy var videoMoreInformationLabel: UILabel = {
        let uiLabel = UILabel()
        uiLabel.text = "더보기"
        uiLabel.textColor = .white
        uiLabel.font = .systemFont(ofSize: 14, weight: .regular)
        return uiLabel
    }()
    private lazy var videoMakerStackView = UIStackView().and {
        $0.alignment = .center
        $0.distribution = .fill
        $0.axis = .horizontal
        $0.spacing = 10
        $0.backgroundColor = .black
    }
    private lazy var videoMakerImageView = UIImageView().and {
        $0.layer.cornerRadius = 15
    }
    private lazy var videoMakerInformationStackView = UIStackView().and {
        $0.distribution = .fillProportionally
        $0.axis = .horizontal
        $0.spacing = 10
    }
    private lazy var videoMakerNameLabel = UILabel().and {
        $0.textColor = .white
        $0.font = .systemFont(ofSize: 16, weight: .bold)
    }
    private lazy var videoMakerSubscriberCountLabel = UILabel().and {
        $0.textColor = .white
        $0.font = .systemFont(ofSize: 12, weight: .thin)
    }
    private lazy var videoLikeButton = ImageChangableWhenSelectedButton(
        normalImage: .checkmark,
        selectedImage: .add,
        checked: { checked in
        // 버튼 누르면 찜한 목록 추가 되도록
    }).and {
        $0.setTitle("1.6천", for: .normal)
        $0.setTitleColor(UIColor.white, for: .normal)
        $0.setTitleColor(UIColor.white.withAlphaComponent(0.5), for: .highlighted)
    }
    private lazy var videoCommentStackView = BackgroundColorAlphaChangeLikeUIButtonWhenTappedUIStackView {
        //TODO: 댓글 자세히 보기
    }.and {
        $0.axis = .vertical
        $0.distribution = .fill
        $0.alignment = .leading
        $0.backgroundColor = .black
    }
    private lazy var videoCommentTitleStackView = UIStackView().and {
        $0.axis = .horizontal
        $0.alignment = .center
        $0.distribution = .fillProportionally
        $0.spacing = 10
    }
    private lazy var videoCommentTitleLabel = UILabel().and {
        $0.text = "댓글"
        $0.textColor = .white
        $0.font = .systemFont(ofSize: 18, weight: .semibold)
    }
    private lazy var videoCommentCountLabel = UILabel().and {
        $0.textColor = .white
        $0.font = .systemFont(ofSize: 12, weight: .light)
    }
    private lazy var videoCommentContextStackView = UIStackView().and {
        $0.axis = .horizontal
        $0.alignment = .center
        $0.distribution = .fill
        $0.spacing = 10
    }
    private lazy var videoCommenterImageView = UIImageView().and {
        $0.layer.cornerRadius = 11
    }
    private lazy var videoCommentLabel = UILabel().and {
        $0.textColor = .white
        $0.numberOfLines = 2
    }
    private lazy var videoCommentSeeMore = UIButton().and {
        $0.setImage(UIImage(systemName: "chevron.down")?.withTintColor(.white, renderingMode: .alwaysOriginal), for: .normal)
    }
    private let videoId: String
    
    init(videoId: String) {
        self.videoId = videoId
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}

extension DetailPageViewController {
    override func viewDidLoad() {
        super.viewDidLoad()

        configure()

        // 테스트 코드 추후에 삭제 요망
        videoTitleLabel.text = "타이틀"
        videoInformationLabel.text = "조회수 4.8만회 1년 전 #Lovely #Haruy"
        
        videoMakerImageView.image = .actions
        videoMakerNameLabel.text = "Maker"
        videoMakerSubscriberCountLabel.text = "3.2천"
        
        videoCommentCountLabel.text = "228"
        videoCommenterImageView.image = .actions
        videoCommentLabel.text = "weataewtteawawetewaaefwawefewfwefaewfaewafefetawetwettweatweattewae"
        
    }
}

extension DetailPageViewController {
    
    private func configure() {
        view.backgroundColor = .white
        view.addSubview(scrollView)
        scrollView.addSubview(stackView)

        [youtubeView, videoInformationStackView, videoMakerStackView, videoCommentStackView].forEach {
            stackView.addArrangedSubview($0)
        }
        [videoInformationLabel, videoMoreInformationLabel].forEach {
            videoInformationsStackView.addArrangedSubview($0)
        }
        [videoTitleLabel, videoInformationsStackView].forEach {
            videoInformationStackView.addArrangedSubview($0)
        }
        [videoMakerNameLabel, videoMakerSubscriberCountLabel].forEach {
            videoMakerInformationStackView.addArrangedSubview($0)
        }
        [videoMakerImageView, videoMakerInformationStackView, videoLikeButton].forEach {
            videoMakerStackView.addArrangedSubview($0)
        }
        [videoCommentTitleStackView, videoCommentContextStackView].forEach {
            videoCommentStackView.addArrangedSubview($0)
        }
        [videoCommentTitleLabel, videoCommentCountLabel].forEach {
            videoCommentTitleStackView.addArrangedSubview($0)
        }
        [videoCommenterImageView, videoCommentLabel, videoCommentSeeMore].forEach {
            videoCommentContextStackView.addArrangedSubview($0)
        }
        
        layout()
        prepareView(videoId: videoId)
    }
    
    private func layout() {
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        stackView.translatesAutoresizingMaskIntoConstraints = false
        youtubeView.translatesAutoresizingMaskIntoConstraints = false
        
        videoMakerImageView.translatesAutoresizingMaskIntoConstraints = false
        videoMakerNameLabel.translatesAutoresizingMaskIntoConstraints = false
        
        videoCommenterImageView.translatesAutoresizingMaskIntoConstraints = false
        videoCommentSeeMore.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor),
            scrollView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            
            stackView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            stackView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
            stackView.leftAnchor.constraint(equalTo: scrollView.leftAnchor),
            stackView.rightAnchor.constraint(equalTo: scrollView.rightAnchor),
            stackView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
    
            youtubeView.heightAnchor.constraint(equalToConstant: 300),
            
            videoMakerImageView.heightAnchor.constraint(equalToConstant: 30),
            videoMakerImageView.widthAnchor.constraint(equalToConstant: 30),
            
            videoCommenterImageView.heightAnchor.constraint(equalToConstant: 22),
            videoCommenterImageView.widthAnchor.constraint(equalToConstant: 22),
            videoCommentSeeMore.trailingAnchor.constraint(equalTo: videoCommentStackView.trailingAnchor, constant: -10),
            videoCommentSeeMore.widthAnchor.constraint(equalToConstant: 15)
        ])
    }
    
    private func prepareView(videoId: String) {
        youtubeView.loadYoutube(videoId: videoId)
    }
 
}

