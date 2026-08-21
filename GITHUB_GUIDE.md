# 🚀 GitHub 推送指南（含日常 git 小抄）

> 本文件是成长仪表盘项目的 git 使用手册。第一次推送照着做，之后日常就三句话。
> 记录了大量真实踩坑，都是从零开始推代码时最容易卡住的地方。

## 〇、先确认环境（新手必做）

打开 cmd，跑：
```bash
git --version
```
- ✅ 看到 `git version 2.x.x` → 继续看第一节
- ❌ 报"不是内部或外部命令" → **电脑没装 Git**。这台电脑的现成方案：WorkBuddy 自带 PortableGit，先把它加进 PATH（重开 cmd 生效）：
```bash
echo %PATH% > %USERPROFILE%\path_backup.txt
setx PATH "%PATH%;C:\Users\angus\.workbuddy\vendor\PortableGit\mingw64\bin"
```
  （第一条备份原 PATH 防 setx 截断；以后想装独立 Git for Windows 也可以：官网 https://git-scm.com 下载，或 `winget install --id Git.Git`）

## 一、第一次推送（3 步）

**第 1 步：GitHub 上建空仓库**
1. 打开 https://github.com/new
2. Repository name 填：`growth-dashboard`
3. **不要勾选** "Add a README file"（本地已有，勾了会冲突——这是今晚踩过的坑！）
4. 点 Create repository

**第 2 步：本地关联并推送**（在项目目录下执行）
```bash
cd C:/Users/angus/WorkBuddy/2026-08-20-23-27-48
git remote add origin https://github.com/angus-hu-gzy/growth-dashboard.git
git push -u origin main
```

**第 3 步：验证**
刷新 GitHub 仓库页面，能看到 dashboard.html / README.md / .gitignore 就成功了。

---

## 二、⚠️ 认证（重要，两种方式）

### 方式 A：OAuth 浏览器登录（首选！现代 git 默认）
Git 2.30+ 会自动弹出 **"Connect to GitHub"** 窗口 → 点 **Sign in with your browser** → 浏览器授权一次 → 凭证自动存进 Windows，**以后 push 永远不用再输任何东西**。
> 这是我们今晚实际用的方式，比 PAT 简单太多，强烈推荐。

### 方式 B：PAT token（老版本 git / 弹不出浏览器时用）
1. GitHub → 头像 → Settings → Developer settings → Personal access tokens → **Tokens (classic)** → Generate new token
2. 勾选 `repo`，生成后**复制**（只显示一次）
3. push 提示 Username 填 `angus-hu-gzy`，Password **粘贴 token**
4. 直达链接：https://github.com/settings/tokens/new

> ⚠️ **token 安全铁律**：token 等同你的钥匙——**绝不发到聊天/截图里**，只在终端粘贴；一旦暴露（哪怕只是出现在屏幕上），**立刻去 https://github.com/settings/tokens 撤销**，别心存侥幸。这是今晚实际踩的坑。

---

## 三、日常 git 三板斧（记住这三句就够）

```bash
# ① 改完东西 → 提交（先存快照）
git add -A
git commit -m "做了什么，一句话说清楚"

# ② 提交完 → 推到 GitHub
git push

# ③ 看历史 / 后悔药
git log --oneline            # 查看提交历史
git restore dashboard.html   # 撤销某个文件的改动（还没提交时）
```

> 习惯：**每完成一个功能就 commit 一次**，commit 信息写清楚（如 "添加暗色模式"）。
> 改坏了不可怕，`git log` 找到上一个正常版本就能回去。

---

## 四、🚨 踩坑记录（血泪经验，全是真事）

| 坑 | 现象 | 正确解法 |
|---|---|---|
| 电脑没装 git | cmd 报"不是内部或外部命令" | 加 PATH 或安装（见第〇节） |
| 建仓库勾了自动初始化 | push 报 `rejected (fetch first)` / README 冲突 | 见下方"冲突处理" |
| token 当命令参数拼进去 | token 暴露在命令行历史上 | **立即撤销 token** + 重新生成 |
| 以为必须用 PAT | 手忙脚乱 | 先试 OAuth 浏览器登录（方式 A） |
| push 卡在认证 | 输入密码没用 | 用户名+PAT，或直接 OAuth |

### 冲突处理：远端有内容时（`rejected ... (fetch first)`）
只有一种安全场景可以强推：**远端是刚建的空仓库、没人在意里面的内容**（如 GitHub 自动生成的 README）：
```bash
git pull --rebase origin main   # 如果远端有值得要的内容，先拉
# 若 rebase 撞冲突：git rebase --abort 退出
git push -u origin main -f      # -f 强推，覆盖远端（只在空仓库用！）
```
> ⚠️ **强推 `-f` 会删除远端历史**——真实协作项目里绝对禁止，会把别人的代码弄丢。

---

## 五、备选：GitHub 访问不畅 → 用 Gitee（码云）

1. 在 https://gitee.com 建同名空仓库 `growth-dashboard`
2. 换一下远程地址再推：
```bash
git remote set-url origin https://gitee.com/你的用户名/growth-dashboard.git
git push -u origin main
```

---

## 六、永久主页（GitHub Pages）

仓库 **Settings → Pages → Deploy from a branch → main / (root) → Save**，等 1-2 分钟得到永久链接：
**https://angus-hu-gzy.github.io/growth-dashboard/**

- 永久免费，简历/分享都用它
- 以后**每次 `git push` 自动更新**，改完即上线
- 注意：仓库根目录必须有 `index.html` 作为入口（本项目已配置，重定向到 dashboard.html）——没有它 Pages 打开是文件列表

---

## 七、临时预览（CloudStudio）

线上演示快照（如 https://6fb3b0f9a22b449098e35f4a0ad2b590.app.workbuddy.link）是临时预览环境，**不保证长期有效**，别写进简历。临时给朋友看两眼可以，长期门面一律用 GitHub Pages。
