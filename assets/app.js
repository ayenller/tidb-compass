const frame = document.querySelector("#content-frame");
const reloadButton = document.querySelector("#reload-page");
const languageButtons = document.querySelectorAll(".language-pill");
const deviceButtons = document.querySelectorAll("[data-device]");
const orientationButtons = document.querySelectorAll("[data-orientation]");
const deviceShell = document.querySelector("#device-shell");
const deviceLanguage = document.querySelector("#device-language");
const previewStatus = document.querySelector("#preview-status");

const previewState = {
  language: localStorage.getItem("tidb-compass-lang") || "zh-CN",
  device: localStorage.getItem("tidb-compass-device") || "iphone",
  orientation: localStorage.getItem("tidb-compass-orientation") || "portrait"
};

const shellMessages = {
  "zh-CN": {
    langLabel: "中文",
    deviceNames: { iphone: "iPhone", ipad: "iPad", portrait: "竖版", landscape: "横版" },
    strings: {
      "shell.badge": "iOS 预览工作台",
      "shell.languageLabel": "语言",
      "shell.deviceLabel": "设备",
      "shell.orientationLabel": "方向",
      "shell.portrait": "竖版",
      "shell.landscape": "横版",
      "shell.previewLabel": "预览重点",
      "shell.useCase1": "Overview 重点展示客户需求筛选与核心价值。",
      "shell.useCase2": "Compare 和 Scenarios 优先服务现场讲解。",
      "shell.useCase3": "页面在 iPhone、iPad 的横竖屏下自适应排版。",
      "shell.updateLabel": "原型说明",
      "shell.updateBody": "这一版用于评审 iOS 应用排版、横竖屏和设备适配，不是最终开发代码。",
      "shell.modeLabel": "设计评审模式",
      "shell.title": "一版支持 iPhone 与 iPad 的 TiDB Compass iOS 预览",
      "shell.status": "iPhone 竖版",
      "shell.reload": "刷新"
    }
  },
  "ja-JP": {
    langLabel: "日本語",
    deviceNames: { iphone: "iPhone", ipad: "iPad", portrait: "縦向き", landscape: "横向き" },
    strings: {
      "shell.badge": "iOS プレビュースタジオ",
      "shell.languageLabel": "言語",
      "shell.deviceLabel": "デバイス",
      "shell.orientationLabel": "向き",
      "shell.portrait": "縦向き",
      "shell.landscape": "横向き",
      "shell.previewLabel": "プレビューの焦点",
      "shell.useCase1": "Overview は顧客要件フィルタと価値訴求を中心に表示します。",
      "shell.useCase2": "Compare と Scenarios は商談デモ向けに最適化しています。",
      "shell.useCase3": "iPhone と iPad の縦横に応じてレイアウトが変化します。",
      "shell.updateLabel": "プロトタイプメモ",
      "shell.updateBody": "この版は iOS アプリのレイアウト、向き、端末適応の確認用です。",
      "shell.modeLabel": "デザインレビュー",
      "shell.title": "iPhone と iPad に対応した TiDB Compass の iOS プレビュー",
      "shell.status": "iPhone 縦向き",
      "shell.reload": "再読み込み"
    }
  },
  "en-US": {
    langLabel: "English",
    deviceNames: { iphone: "iPhone", ipad: "iPad", portrait: "Portrait", landscape: "Landscape" },
    strings: {
      "shell.badge": "iOS Preview Studio",
      "shell.languageLabel": "Language",
      "shell.deviceLabel": "Device",
      "shell.orientationLabel": "Orientation",
      "shell.portrait": "Portrait",
      "shell.landscape": "Landscape",
      "shell.previewLabel": "Preview Focus",
      "shell.useCase1": "Overview highlights customer-need filtering and value framing.",
      "shell.useCase2": "Compare and Scenarios are tuned for live conversations.",
      "shell.useCase3": "Layouts adapt across iPhone and iPad in both orientations.",
      "shell.updateLabel": "Prototype Notes",
      "shell.updateBody": "This version is for reviewing iOS layout, orientation, and device adaptation.",
      "shell.modeLabel": "Design Review Mode",
      "shell.title": "A TiDB Compass iOS preview for iPhone and iPad",
      "shell.status": "iPhone Portrait",
      "shell.reload": "Reload"
    }
  },
  "pt-BR": {
    langLabel: "Português",
    deviceNames: { iphone: "iPhone", ipad: "iPad", portrait: "Retrato", landscape: "Paisagem" },
    strings: {
      "shell.badge": "Estúdio de preview iOS",
      "shell.languageLabel": "Idioma",
      "shell.deviceLabel": "Dispositivo",
      "shell.orientationLabel": "Orientação",
      "shell.portrait": "Retrato",
      "shell.landscape": "Paisagem",
      "shell.previewLabel": "Foco do preview",
      "shell.useCase1": "Overview destaca filtro por necessidade e proposta de valor.",
      "shell.useCase2": "Compare e Scenarios foram ajustados para conversas ao vivo.",
      "shell.useCase3": "Os layouts se adaptam a iPhone e iPad nas duas orientações.",
      "shell.updateLabel": "Notas do protótipo",
      "shell.updateBody": "Esta versão serve para revisar layout iOS, orientação e adaptação entre dispositivos.",
      "shell.modeLabel": "Modo de revisão de design",
      "shell.title": "Um preview iOS do TiDB Compass para iPhone e iPad",
      "shell.status": "iPhone Retrato",
      "shell.reload": "Recarregar"
    }
  },
  "es-ES": {
    langLabel: "Español",
    deviceNames: { iphone: "iPhone", ipad: "iPad", portrait: "Vertical", landscape: "Horizontal" },
    strings: {
      "shell.badge": "Estudio de preview iOS",
      "shell.languageLabel": "Idioma",
      "shell.deviceLabel": "Dispositivo",
      "shell.orientationLabel": "Orientación",
      "shell.portrait": "Vertical",
      "shell.landscape": "Horizontal",
      "shell.previewLabel": "Foco del preview",
      "shell.useCase1": "Overview resalta filtro por necesidad y propuesta de valor.",
      "shell.useCase2": "Compare y Scenarios están pensados para demos en vivo.",
      "shell.useCase3": "Los layouts se adaptan a iPhone y iPad en ambas orientaciones.",
      "shell.updateLabel": "Notas del prototipo",
      "shell.updateBody": "Esta versión sirve para revisar layout iOS, orientación y adaptación entre dispositivos.",
      "shell.modeLabel": "Modo de revisión de diseño",
      "shell.title": "Un preview iOS de TiDB Compass para iPhone y iPad",
      "shell.status": "iPhone Vertical",
      "shell.reload": "Recargar"
    }
  }
};

function updatePreviewStatus() {
  const pack = shellMessages[previewState.language] || shellMessages["en-US"];
  const { deviceNames } = pack;
  previewStatus.textContent = `${deviceNames[previewState.device]} ${deviceNames[previewState.orientation]}`;
}

function updateFrameSource() {
  frame.src = `./content/tidb-sales-kit.html?lang=${encodeURIComponent(
    previewState.language
  )}&device=${encodeURIComponent(previewState.device)}&orientation=${encodeURIComponent(
    previewState.orientation
  )}`;
}

function applyShellLanguage() {
  const pack = shellMessages[previewState.language] || shellMessages["en-US"];
  document.documentElement.lang = previewState.language;
  deviceLanguage.textContent = pack.langLabel;

  document.querySelectorAll("[data-i18n]").forEach((node) => {
    const key = node.dataset.i18n;
    const value = pack.strings[key];
    if (value) {
      node.textContent = value;
    }
  });
}

function applyPreviewState() {
  languageButtons.forEach((button) => {
    button.classList.toggle("is-active", button.dataset.lang === previewState.language);
  });

  deviceButtons.forEach((button) => {
    button.classList.toggle("is-active", button.dataset.device === previewState.device);
  });

  orientationButtons.forEach((button) => {
    button.classList.toggle("is-active", button.dataset.orientation === previewState.orientation);
  });

  deviceShell.classList.toggle("is-iphone", previewState.device === "iphone");
  deviceShell.classList.toggle("is-ipad", previewState.device === "ipad");
  deviceShell.classList.toggle("is-portrait", previewState.orientation === "portrait");
  deviceShell.classList.toggle("is-landscape", previewState.orientation === "landscape");

  applyShellLanguage();
  updatePreviewStatus();
  updateFrameSource();
}

languageButtons.forEach((button) => {
  button.addEventListener("click", () => {
    previewState.language = button.dataset.lang;
    localStorage.setItem("tidb-compass-lang", previewState.language);
    applyPreviewState();
  });
});

deviceButtons.forEach((button) => {
  button.addEventListener("click", () => {
    previewState.device = button.dataset.device;
    localStorage.setItem("tidb-compass-device", previewState.device);
    applyPreviewState();
  });
});

orientationButtons.forEach((button) => {
  button.addEventListener("click", () => {
    previewState.orientation = button.dataset.orientation;
    localStorage.setItem("tidb-compass-orientation", previewState.orientation);
    applyPreviewState();
  });
});

reloadButton.addEventListener("click", () => {
  updateFrameSource();
});

applyPreviewState();
