//
//  HomeScreen.swift
//  Reca
//
//  Created by Shuja on 11/11/2025.
//

import SwiftUI

// MARK: - Constants

extension HomeScreen {
    enum Constant {
        static let instructionalText = "Keep uploading - You still get points for every video"

        enum Size {
            static let topPadding: CGFloat = Global.Margin.xlarge
            static let horizontalPadding: CGFloat = Global.Margin.xxxxxlarge
            static let badgeButtonHorizontalPadding: CGFloat = Global.Margin.medium
            static let bottomSectionSpacing: CGFloat = Global.Margin.huge
            static let bottomSectionSpacingLandscape: CGFloat = Global.Margin.xlarge
            static let recordButtonWidth: CGFloat = 310
        }
    }
}

// MARK: - HomeScreen

struct HomeScreen: View {
    @ObservedObject var viewModel: HomeViewModel

    var body: some View {
        mainContent
        .navigate(
            route: viewModel.route,
            shouldPush: $viewModel.shouldPush,
            shouldPresent: $viewModel.shouldPresent,
            shouldPresentFullscreen: $viewModel.shouldPresentFullscreen
        )
    }

    private var mainContent: some View {
        content
            .background(Global.theme.primaryBackgroundColor.color)
            .onRotate { newOrientation in
                viewModel.orientation = newOrientation
            }
    }

    private var content: some View {
        VStack(spacing: .zero) {
            topSection
            Spacer()
            bottomSection
            Spacer()
        }
        .padding(.top, Constant.Size.topPadding)
    }
}

// MARK: - View Components

private extension HomeScreen {

    var topSection: some View {
        HStack {
            uploadersBadge
            Spacer()
        }
        .padding(.horizontal, Constant.Size.badgeButtonHorizontalPadding)
    }

    var bottomSection: some View {
        VStack(spacing: bottomSectionSpacing) {
            instructionalText
            recordButtonSection
        }
        .padding(.horizontal, Constant.Size.horizontalPadding)
    }

    private var bottomSectionSpacing: CGFloat {
        viewModel.orientation.isLandscape
            ? Constant.Size.bottomSectionSpacingLandscape 
            : Constant.Size.bottomSectionSpacing
    }

    var uploadersBadge: some View {
        UploadersBadge(count: viewModel.uploaderCount)
    }

    var instructionalText: some View {
        Text(Constant.instructionalText)
            .font(RAFont.regular.with(FontSize.subtitle))
            .foregroundColor(.white)
            .multilineTextAlignment(.center)
    }

    var recordButtonSection: some View {
        RecordButton(action: viewModel.didTapRecord)
            .frame(width: Constant.Size.recordButtonWidth)
    }
}

// MARK: - Preview

#Preview {
    HomeScreen(viewModel: HomeViewModel())
} 
