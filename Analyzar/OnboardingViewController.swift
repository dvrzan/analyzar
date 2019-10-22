//
//  ViewController.swift
//  Analyzar
//
//  Created by Danijela Vrzan on 2019-08-29.
//  Copyright © 2019 Danijela Vrzan. All rights reserved.
//

import UIKit

class OnboardingViewController: UIViewController, UIScrollViewDelegate {
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var pageControl: UIPageControl!
    
    var slides: [Slide] = [];
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        scrollView.delegate = self
        
        slides = createSlides()
        setupSlideScrollView(slides: slides)
        
        pageControl.numberOfPages = slides.count
        pageControl.currentPage = 0
        view.bringSubviewToFront(pageControl)
    }
    
    func createSlides() -> [Slide] {
        
        let slide1:Slide = Bundle.main.loadNibNamed("Slide", owner: self, options: nil)?.first as! Slide
        slide1.imageView.image = UIImage(named: "onboard1")
        slide1.labelTitle.text = "Analyze"
        slide1.labelDescription.text = "Analyze opinions from people all around the globe in a matter of seconds."
        
        let slide2:Slide = Bundle.main.loadNibNamed("Slide", owner: self, options: nil)?.first as! Slide
        slide2.imageView.image = UIImage(named: "onboard2")
        slide2.labelTitle.text = "Topic or Person"
        slide2.labelDescription.text = "Use #topic or @person to search Twitter for opinions."
        
        let slide3:Slide = Bundle.main.loadNibNamed("Slide", owner: self, options: nil)?.first as! Slide
        slide3.imageView.image = UIImage(named: "onboard3")
        slide3.labelTitle.text = "Keep track"
        slide3.labelDescription.text = "Search history shows you how fast opinions change."
        
        let slide4:Slide = Bundle.main.loadNibNamed("Slide", owner: self, options: nil)?.first as! Slide
        slide4.imageView.image = UIImage(named: "onboard4")
        slide4.labelTitle.text = "Learn"
        slide4.labelDescription.text = "All while having fun! Ever wondered how machines learn?"
        
        return [slide1, slide2, slide3, slide4]
    }
    
    func setupSlideScrollView(slides : [Slide]) {
        scrollView.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: scrollView.frame.height)
        scrollView.contentSize = CGSize(width: view.frame.width * CGFloat(slides.count), height: scrollView.frame.height)
        scrollView.isPagingEnabled = true
        
        for i in 0 ..< slides.count {
            slides[i].frame = CGRect(x: view.frame.width * CGFloat(i), y: 0, width: view.frame.width, height: scrollView.frame.height)
            scrollView.addSubview(slides[i])
        }
        
        alignScrollToPageBoundary()
    }
    
    /*
     * Default function called when view is scrolled. In order to enable callback
     * when scrollview is scrolled, the below code needs to be called:
     * slideScrollView.delegate = self or
     */
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let pageIndex = round(scrollView.contentOffset.x/view.frame.width)
        pageControl.currentPage = Int(pageIndex)
        
        let maximumHorizontalOffset: CGFloat = scrollView.contentSize.width - scrollView.frame.width
        let currentHorizontalOffset: CGFloat = scrollView.contentOffset.x
        
        // vertical
        let maximumVerticalOffset: CGFloat = scrollView.contentSize.height - scrollView.frame.height
        let currentVerticalOffset: CGFloat = scrollView.contentOffset.y
        
        let percentageHorizontalOffset: CGFloat = currentHorizontalOffset / maximumHorizontalOffset
        let percentageVerticalOffset: CGFloat = currentVerticalOffset / maximumVerticalOffset
        
        
        /*
         * Change the background color of view on paging the scrollView
         */
        //        self.scrollView(scrollView, didScrollToPercentageOffset: percentageHorizontalOffset)
        
        
        /*
         * Scale the imageView on paging the scrollView
         */
        let percentOffset: CGPoint = CGPoint(x: percentageHorizontalOffset, y: percentageVerticalOffset)
        let factor:CGFloat = 1.0/( CGFloat(slides.count) - 1.0)
        for i in 0 ..< (slides.count - 1)
        {
            if(percentOffset.x > (CGFloat(i) * factor) && percentOffset.x <= (CGFloat(i+1) * factor))
            {
                let scalePrev = ((factor * ( CGFloat(i) + 1)) - (percentOffset.x))/factor
                slides[i].imageView?.transform = CGAffineTransform(scaleX: scalePrev, y: scalePrev)
                let scaleNext = percentOffset.x/(factor * ( CGFloat(i) + 1))
                slides[i+1].imageView?.transform = CGAffineTransform(scaleX: scaleNext, y: scaleNext)
                break;
            }
        }
    }
    
    func alignScrollToPageBoundary() {
        // Truncate to nearest whole page
        let frameWidth : CGFloat = scrollView.frame.size.width
        let page : Int = Int((scrollView.contentOffset.x + (0.5 * frameWidth)) / frameWidth)
        let visibleRect : CGRect = CGRect(
            origin: CGPoint.init(x: frameWidth * CGFloat(page), y: 0.0),
            size: scrollView.frame.size
        )
        scrollView.scrollRectToVisible(visibleRect, animated: true)
    }
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        setupSlideScrollView(slides: slides)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        setupSlideScrollView(slides: slides)
    }


}
