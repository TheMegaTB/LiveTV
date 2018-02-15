//
//  StreamsViewController.swift
//  LiveTV
//
//  Created by Til Blechschmidt on 13.02.18.
//  Copyright © 2018 Til Blechschmidt. All rights reserved.
//

import UIKit
import AVKit

let focussedColor = #colorLiteral(red: 0.6419365523, green: 0.6419365523, blue: 0.6419365523, alpha: 0.8042198504)
let highlightedColor = #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)

class StreamsViewController: UICollectionViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        print(installsStandardGestureForInteractiveMovement)
        self.installsStandardGestureForInteractiveMovement = true
//        self.collectionView(<#T##collectionView: UICollectionView##UICollectionView#>, targetIndexPathForMoveFromItemAt: <#T##IndexPath#>, toProposedIndexPath: <#T##IndexPath#>)
//        self.collectionView(<#T##collectionView: UICollectionView##UICollectionView#>, moveItemAt: <#T##IndexPath#>, to: <#T##IndexPath#>)

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */

    // MARK: UICollectionViewDataSource

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return StreamsManager.default.getCategories().count
    }

    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let cell = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "StreamsCategory", for: indexPath) as! StreamsCategoryView

        cell.titleLabel.text = StreamsManager.default.getCategories()[indexPath.section]

        return cell
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return StreamsManager.default.getStreams(forCategory: section).count
    }


    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "StreamCell", for: indexPath) as! StreamCell
    
        // Configure the cell
        let stream = StreamsManager.default.getStreams(forCategory: indexPath.section)[indexPath.item]
        cell.iconView.image = stream.image
        cell.iconWrapper.layer.cornerRadius = 20
        cell.iconLabel.text = stream.name
        cell.iconLabel.alpha = 0
    
        return cell
    }

    override func collectionView(_ collectionView: UICollectionView, didUpdateFocusIn context: UICollectionViewFocusUpdateContext, with coordinator: UIFocusAnimationCoordinator) {
        if let next = context.nextFocusedView as? StreamCell {
            UIView.animate(withDuration: 0.2) {
                next.iconWrapper.backgroundColor = focussedColor
                next.iconWrapper.transform = CGAffineTransform(scaleX: 1.1, y: 1.1)
                next.iconLabel.alpha = 1
            }
        }
        if let previous = context.previouslyFocusedView as? StreamCell  {
            UIView.animate(withDuration: 0.2) {
                previous.iconWrapper.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 0)
                previous.iconWrapper.transform = CGAffineTransform(scaleX: 1, y: 1)
                previous.iconLabel.alpha = 0
            }
        }
    }

    override func collectionView(_ collectionView: UICollectionView, didHighlightItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath) as! StreamCell
        cell.iconWrapper.backgroundColor = highlightedColor
    }

    override func collectionView(_ collectionView: UICollectionView, didUnhighlightItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath) as! StreamCell
        cell.iconWrapper.backgroundColor = focussedColor
    }

    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let stream = StreamsManager.default.getStreams(forCategory: indexPath.section)[indexPath.item]

        play(stream: stream)
//        super.setEditing(true, animated: true)
//        collectionView.beginInteractiveMovementForItem(at: indexPath)
    }

    func play(stream: Stream) {
        let playerController = AVPlayerViewController()
        let player = AVPlayer(url: URL(string: stream.getSelectedStream().getSelectedQuality()!)!)

        playerController.player = player
        playerController.customInfoViewController = storyboard!.instantiateViewController(withIdentifier: "StreamDetailView")

        present(playerController, animated: true) {
            player.play()
        }
    }

    override func collectionView(_ collectionView: UICollectionView, canMoveItemAt indexPath: IndexPath) -> Bool {
        print(indexPath)
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, moveItemAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        print("HELLO WORLD")
    }

    // MARK: UICollectionViewDelegate

    /*
    // Uncomment this method to specify if the specified item should be highlighted during tracking
    override func collectionView(_ collectionView: UICollectionView, shouldHighlightItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment this method to specify if the specified item should be selected
    override func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
    override func collectionView(_ collectionView: UICollectionView, shouldShowMenuForItemAt indexPath: IndexPath) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, canPerformAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, performAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) {
    
    }
    */

}
