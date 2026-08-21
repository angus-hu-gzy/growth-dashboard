# 🚀 GitHub 推送指南（含日常 git 小抄）

> 本文件是成长仪表盘项目的 git 使用手册。第一次推送照着做，之后日常就三句话。

## 一、第一次推送（3 步）

**第 1 步：GitHub 上建空仓库**
1. 打开 https://github.com/new
2. Repository name 填：`growth-dashboard`
3. **不要勾选** "Add a README file"（本地已有，勾了会冲突）
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

## 二、⚠️ 第一次 push 大概率会卡在这（认证）

2021 年起 GitHub **不支持用账号密码 push**，必须用 **Personal Access Token（PAT）**：

1. GitHub → 头像 → Settings → Developer settings → Personal access tokens → **Tokens (classic)** → Generate new token
2. 勾选 `repo` 权限，点生成，**复制 token**（只显示一次，关页就没了）
3. 回到终端 push 时：
   - 用户名：填 `angus-hu-gzy`
   - 密码：**粘贴 token**（不是你的账号密码）
4. 成功后 Windows 会记住凭证，以后 push 不用再输

**进阶省事法（可选）**：装 GitHub 官方命令行，登录一次以后免输：
```bash
winget install --id GitHub.cli
gh auth login
```

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

## 四、备选：GitHub 访问不畅 → 用 Gitee（码云）

1. 在 https://gitee.com 建同名空仓库 `growth-dashboard`
2. 换一下远程地址再推：
```bash
git remote set-url origin https://gitee.com/你的用户名/growth-dashboard.git
git push -u origin main
```

---

## 五、更新线上演示版

线上版（CloudStudio 链接）是发布快照，本地改完想更新时，说一声"重新部署"即可。
