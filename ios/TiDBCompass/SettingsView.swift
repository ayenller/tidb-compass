import SwiftUI

struct SettingsView: View {
    @Binding var selectedLanguage: String
    let reloadAction: () -> Void
    let currentContext: PreviewContext

    @Environment(\.dismiss) private var dismiss

    var body: some View {
        NavigationStack {
            List {
                Section(copy.languageSection) {
                    Picker(copy.languageLabel, selection: $selectedLanguage) {
                        ForEach(LanguageOption.allCases) { option in
                            Text(option.label).tag(option.rawValue)
                        }
                    }
                    .pickerStyle(.inline)
                }

                Section(copy.previewSection) {
                    infoRow(title: copy.deviceLabel, value: currentContext.deviceLabel)
                    infoRow(title: copy.orientationLabel, value: currentContext.orientationLabel)
                    infoRow(title: copy.languageLabel, value: languageOption.label)
                }

                Section(copy.actionsSection) {
                    Button(copy.reloadLabel, action: reloadAction)
                    Button(copy.closeLabel) {
                        dismiss()
                    }
                }
            }
            .navigationTitle(copy.title)
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button(copy.doneLabel) {
                        dismiss()
                    }
                }
            }
        }
    }

    private func infoRow(title: String, value: String) -> some View {
        HStack {
            Text(title)
            Spacer()
            Text(value)
                .foregroundStyle(.secondary)
        }
    }

    private var languageOption: LanguageOption {
        LanguageOption(rawValue: selectedLanguage) ?? .simplifiedChinese
    }

    private var copy: SettingsCopy {
        switch languageOption {
        case .simplifiedChinese:
            return .init(
                title: "设置",
                doneLabel: "完成",
                languageSection: "语言",
                languageLabel: "当前语言",
                previewSection: "预览上下文",
                deviceLabel: "设备",
                orientationLabel: "方向",
                actionsSection: "操作",
                reloadLabel: "重新加载页面",
                closeLabel: "关闭"
            )
        case .japanese:
            return .init(
                title: "設定",
                doneLabel: "完了",
                languageSection: "言語",
                languageLabel: "現在の言語",
                previewSection: "プレビュー状態",
                deviceLabel: "デバイス",
                orientationLabel: "向き",
                actionsSection: "操作",
                reloadLabel: "ページを再読み込み",
                closeLabel: "閉じる"
            )
        case .english:
            return .init(
                title: "Settings",
                doneLabel: "Done",
                languageSection: "Language",
                languageLabel: "Current language",
                previewSection: "Preview context",
                deviceLabel: "Device",
                orientationLabel: "Orientation",
                actionsSection: "Actions",
                reloadLabel: "Reload page",
                closeLabel: "Close"
            )
        case .portuguese:
            return .init(
                title: "Ajustes",
                doneLabel: "Concluir",
                languageSection: "Idioma",
                languageLabel: "Idioma atual",
                previewSection: "Contexto do preview",
                deviceLabel: "Dispositivo",
                orientationLabel: "Orientação",
                actionsSection: "Ações",
                reloadLabel: "Recarregar página",
                closeLabel: "Fechar"
            )
        case .spanish:
            return .init(
                title: "Ajustes",
                doneLabel: "Listo",
                languageSection: "Idioma",
                languageLabel: "Idioma actual",
                previewSection: "Contexto del preview",
                deviceLabel: "Dispositivo",
                orientationLabel: "Orientación",
                actionsSection: "Acciones",
                reloadLabel: "Recargar página",
                closeLabel: "Cerrar"
            )
        }
    }
}

private struct SettingsCopy {
    let title: String
    let doneLabel: String
    let languageSection: String
    let languageLabel: String
    let previewSection: String
    let deviceLabel: String
    let orientationLabel: String
    let actionsSection: String
    let reloadLabel: String
    let closeLabel: String
}
