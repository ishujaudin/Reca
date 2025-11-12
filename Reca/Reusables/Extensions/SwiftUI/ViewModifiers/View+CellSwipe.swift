//
//  View+CellSwipe.swift
//  Reca
//
//  Created by Shuja on 11/11/2025.
//

import SwiftUI

extension View {

    func onSwipe(swipedID: Binding<UUID?>,
                 isHidden: Bool,
                 uiModelList: [CellSwipeUIModel]) -> some View {
        modifier(CellSwipeViewModifier(view: eraseToAnyView(),
                                       isHidden: isHidden,
                                       uiModelList: uiModelList,
                                       swipedID: swipedID))
    }
}

struct CellSwipeUIModel: UUIDIdentifiable {

    var id = UUID()
    let presentation: CellSwipePresentation
    let style: CellSwipeStyle
}

struct CellSwipePresentation {

    let title: String
    let imageName: String?
    let action: () -> Void
}

struct CellSwipeStyle {

    static let `default` = CellSwipeStyle(
        textStyle: Style.Text(font: RAFont.bold.with(FontSize.smallBody),
                              color: Global.theme.primaryButtonTextColor.color)
    )

    static let destructive = CellSwipeStyle(
        // todo-ratealert: change color
        background:  Global.theme.flexiPendingAmountsBarBackgroundColor.color,
        textStyle: Style.Text(font: RAFont.bold.with(FontSize.smallBody),
                              color: Global.theme.primaryButtonTextColor.color)
    )

    /// Background color of cellSwipe. Default is banner background color.
    var background: Color = Global.theme.bannerBackgroundColor.color

    /// Image background color. Default is primary background color.
    var imageBackgroundColor: Color = Global.theme.primaryBackgroundColor.color

    /// Image tint color. Default is primary button color.
    var imageColor: Color = Global.theme.primaryButtonColor.color

    /// Text style
    var textStyle: Style.Text
}

private struct CellSwipeViewModifier: ViewModifier, Animatable {

    private enum Constant {

        static let dragVelocityThreshold: CGFloat = 50
        static let dragMinimumDistance: CGFloat = 30
        static let estimatedContentWidth: CGFloat = 375
        static let cellSwipeWidthContentWidthRatio: CGFloat = 0.37
        static let imageWidthRatio: CGFloat = 0.25
        static let imageWidthToBackgroundRatio: CGFloat = 0.45
    }

    let view: AnyView
    let isHidden: Bool
    let uiModelList: [CellSwipeUIModel]

    @Binding var swipedID: UUID?

    private let maximumOffset: CGFloat = .zero

    @State private var offset: CGFloat = .zero
    @State private var contentWidth: CGFloat = .zero
    @State private var isDragInProgress = false {
        didSet {
            if isDragInProgress {
                swipedID = nil
            }
        }
    }

    func body(content: Content) -> some View {
        if isHidden {
            view
        } else {
            ZStack(alignment: .trailing) {
                view
                    .notifyWidthChange($contentWidth)
                    .offset(x: currentTargetOffset)

                if isSwiped {
                    Rectangle()
                        .foregroundColor(.white)
                        .opacity(.leastNonzeroMagnitude)
                        .onTapGesture {
                            swipedID = nil
                        }
                }

                cellSwipeContainer
                    .offset(x: totalCellSwipeOffset)
            }
            .gesture(gesture)
            .animation(.interactiveSpring(), value: currentTargetOffset)
        }
    }

    private var cellSwipeContainer: some View {
        HStack(spacing: .zero) {
            ForEach(uiModelList) { uiModel in
                cellSwipe(uiModel: uiModel)
            }
        }
    }

    private var gesture: some Gesture {
        DragGesture(minimumDistance: Constant.dragMinimumDistance)
            .onChanged { value in
                let amount = value.translation.width
                let targetedOffset = desiredOffset + amount
                offset = min(max(targetedOffset, minimumOffset), maximumOffset)
                if !isDragInProgress, offset != maximumOffset, offset != minimumOffset {
                    isDragInProgress = true
                }
            }
            .onEnded { value in
                let differenceToMaxOffset = abs(offset)
                let differenceToMinOffset = totalCellSwipeWidth - abs(offset)
                let velocity = value.predictedEndLocation.x - value.location.x
                if velocity > Constant.dragVelocityThreshold, isSwiped {
                    swipedID = nil
                } else if velocity < -Constant.dragVelocityThreshold {
                    swipedID = id
                } else {
                    swipedID = differenceToMinOffset < differenceToMaxOffset ? id : nil
                }
                isDragInProgress = false
            }
    }
}

// MARK: - Private Methods

private extension CellSwipeViewModifier {

    func cellSwipe(uiModel: CellSwipeUIModel) -> some View {
        VStack(spacing: Global.Margin.xsmall) {
            Spacer()
            roundedImage(uiModel: uiModel)
            title(uiModel: uiModel)
            Spacer()
        }
        .frame(width: cellSwipeWidth)
        .background(uiModel.style.background)
        .onTapGesture {
            uiModel.presentation.action()
            swipedID = nil
        }
    }

    @ViewBuilder
    func roundedImage(uiModel: CellSwipeUIModel) -> some View {
        if uiModel.presentation.imageName != nil {
            ZStack {
                uiModel.style.imageBackgroundColor
                    .clipShape(Circle())

                Image(uiModel.presentation.imageName ?? "")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .foregroundColor(uiModel.style.imageColor)
                    .frame(width: imageWidth)
            }
            .frame(width: imageBackgroundWidth)
        }
    }

    func title(uiModel: CellSwipeUIModel) -> some View {
        Text(uiModel.presentation.title)
            .foregroundColor(uiModel.style.textStyle.color)
            .font(uiModel.style.textStyle.font)
    }
}

// MARK: - Computed Properties

private extension CellSwipeViewModifier {

    var desiredOffset: CGFloat { isSwiped ? -totalCellSwipeWidth : .zero }
    var minimumOffset: CGFloat { -totalCellSwipeWidth }
    var currentTargetOffset: CGFloat { isDragInProgress ? offset : desiredOffset }
    var totalCellSwipeWidth: CGFloat { cellSwipeWidth * CGFloat(uiModelList.count) }
    var totalCellSwipeOffset: CGFloat { totalCellSwipeWidth + currentTargetOffset }
    var cellSwipeWidth: CGFloat {
        (contentWidth > .zero ? contentWidth : Constant.estimatedContentWidth) *
        Constant.cellSwipeWidthContentWidthRatio
    }

    var imageBackgroundWidth: CGFloat { cellSwipeWidth * Constant.imageWidthRatio }
    var imageWidth: CGFloat { imageBackgroundWidth * Constant.imageWidthToBackgroundRatio }

    private var id: UUID? { uiModelList.first?.id }
    private var isSwiped: Bool { swipedID == id }
}
