# TiDB Compass

TiDB Compass 是一个面向销售、售前和伙伴介绍场景的 iOS 风格多语言 APP 壳示例。

当前支持语言：

- 中文
- 日文
- 英文
- 葡萄牙语
- 西班牙语

## 文件结构

- `index.html`：TiDB Compass iOS APP 壳
- `assets/app.css`：APP 壳样式
- `assets/app.js`：APP 壳交互与语言切换
- `content/tidb-sales-kit.html`：内嵌静态介绍页，按语言参数动态渲染

## 使用方式

直接在浏览器打开 `index.html` 即可预览。

## 更新内容

后续如果需要由后台持续更新介绍内容，优先更新 `content/tidb-sales-kit.html` 的语言内容数据。
这样可以保持 APP 壳稳定，同时持续迭代页面文案与模块。
