//
//  RecordingSettingsView.swift
//  Reca
//
//  Created by Shuja on 11/11/2025.
//

import SwiftUI

// MARK: - Constants

private extension RecordingSettingsView {
    enum Constant {
        static let title = "Camera Settings"
        
        enum Size {
            static let cornerRadius: CGFloat = Global.CornerRadius.mediumHigh
            static let horizontalPadding: CGFloat = Global.Margin.large
            static let verticalPadding: CGFloat = Global.Margin.xlarge
            static let itemSpacing: CGFloat = Global.Margin.xlarge
            static let sectionSpacing: CGFloat = Global.Margin.xxlarge
        }
    }
}

// MARK: - RecordingSettingsView

struct RecordingSettingsView: View {
    @ObservedObject var viewModel: RecordingViewModel
    @Environment(\.dismiss) private var dismiss

    var body: some View {
        mainContent
            .background(backgroundGradient)
            .presentationDetents([.height(520)])
            .presentationDragIndicator(.visible)
            .presentationCornerRadius(Global.CornerRadius.mediumHigh)
            .presentationBackground(.thinMaterial)
            .ignoresSafeArea()
    }

    private var mainContent: some View {
        VStack {
            settingsSheet
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }

    private var backgroundGradient: some View {
        AppGradients.linear(colors: [Color(hex: "1F0E3E"), .black])
            .opacity(0.4)
    }

    private var settingsSheet: some View {
        VStack(alignment: .leading, spacing: Constant.Size.itemSpacing) {
            header
                .padding(.top, 20)
            settingsList
        }
        .padding(.horizontal, Constant.Size.horizontalPadding)
        .padding(.vertical, Constant.Size.verticalPadding)
        .padding(.bottom, Global.Margin.large)
    }

    private var header: some View {
        HStack {
            Button(action: { dismiss() }) {
                Image(systemName: "xmark")
                    .foregroundColor(.white)
                    .font(.system(size: 16, weight: .medium))
                    .frame(width: 40, height: 40)
                    .background(Circle().fill(Color(hex: "2C1C4A")))
            }
            Text(Constant.title)
                .font(RAFont.semiBold.with(FontSize.title4))
                .foregroundColor(.white)
            Spacer()
        }
    }
    
    private var settingsList: some View {
        VStack(alignment: .leading, spacing: Constant.Size.sectionSpacing) {
            oneHandedModeSetting
            autoSaveSetting
            preserveSettingsSetting
            defaultLensSetting
        }
    }
    
    private var oneHandedModeSetting: some View {
        SettingRow(
            title: "One Handed Mode",
            subtitle: "Change the position of Zoom Controls",
            toggle: $viewModel.isOneHandedMode
        )
    }
    
    private var autoSaveSetting: some View {
        SettingRow(
            title: "Auto Save to Device",
            subtitle: "Change if videos are saved to device by default",
            toggle: $viewModel.autoSaveToDevice
        )
    }
    
    private var preserveSettingsSetting: some View {
        SettingRow(
            title: "Preserve Settings",
            subtitle: "Change if Zoom Level and Lens changes persist",
            toggle: $viewModel.preserveSettings
        )
    }
    
    private var defaultLensSetting: some View {
        VStack(alignment: .leading, spacing: Global.Margin.small) {
            Text("Default Camera Lens")
                .font(RAFont.semiBold.with(FontSize.body))
                .foregroundColor(.white)
            Text("Pick from your available camera lenses to be used as default")
                .font(RAFont.regular.with(FontSize.footnote))
                .foregroundColor(.white.opacity(0.7))

            HStack(spacing: Global.Margin.xsmall) {
                ForEach(["13mm", "24mm", "48mm", "77mm"], id: \.self) { lens in
                    lensButton(lens: lens)
                }
            }
        }
    }

    func lensButton(lens: String) -> some View {
        Button(action: { viewModel.didSelectLens(lens) }) {
            Text(lens)
                .font(RAFont.medium.with(FontSize.footnote))
                .foregroundColor(.white)
                .padding(.horizontal, Global.Margin.large)
                .frame(height: 36)
                .background(
                    RoundedRectangle(cornerRadius: 18)
                        .fill(viewModel.selectedLens == lens ? .white.opacity(0.2) : Color(hex: "2C1C4A"))
                        .stroke(.white, style: viewModel.selectedLens == lens ? StrokeStyle(lineWidth: 2) : StrokeStyle(lineWidth: 0))
                )
        }
        .buttonStyle(.plain)
    }
}

// MARK: - Setting Row

private struct SettingRow: View {
    let title: String
    let subtitle: String
    @Binding var toggle: Bool
    
    var body: some View {
        HStack {
            VStack(alignment: .leading, spacing: Global.Margin.tiny) {
                Text(title)
                    .font(RAFont.semiBold.with(FontSize.body))
                    .foregroundColor(.white)
                Text(subtitle)
                    .font(RAFont.regular.with(FontSize.footnote))
                    .foregroundColor(.white.opacity(0.7))
            }
            Spacer()
            Toggle("", isOn: $toggle)
                .toggleStyle(SwitchToggleStyle(tint: .purple))
        }
    }
}

// MARK: - Preview

#Preview {
    RecordingSettingsView(viewModel: RecordingViewModel())
}

