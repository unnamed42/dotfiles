# DSH 配置的 git 管理方式

本目录（仓库里的 `.dsh/`）是 `~/.dsh`（`$DSH_HOME`）的一份**内容镜像**，
由 [`bin/dsh-config`](../bin/dsh-config) 按 [`dsh-manifest.txt`](../dsh-manifest.txt) 的白名单做内容同步。

## 日常用法

```sh
dsh-config list          # 看哪些文件有漂移
dsh-config diff          # 看具体改了什么（repo 与线上文件的差异）
dsh-config save          # 线上 -> 仓库，然后 git diff / git commit
dsh-config apply         # 仓库 -> 线上（换机器 / 恢复配置），会先备份旧文件
dsh-config apply -n      # 只演练，不写
```

把脚本放到 PATH 里：

```sh
ln -s ~/projects/dotfiles/bin/dsh-config ~/.local/bin/dsh-config
```

建议的节奏：**改完插件/配置后跑一次 `save` 再 commit**；换机器时 `git clone` 后 `apply`，
再让 DSH 自己跑一次 `pnpm install`（`package.json` + `pnpm-lock.yaml` 已入库）。

## 为什么不用 hard link / 软链接

DSH 自己和 DSH Market 都会重写这些文件，而且写入方式混用两种：

| 方式 | 位置 | 对链接的影响 |
| --- | --- | --- |
| 原地写 `writeFileSync` | `dshmarket/lib/patch.js` 写 `cordis.patch.yml` | 保住 inode，链接还在 |
| 临时文件 + `rename` | `dshmarket/lib/profile.js` 写 `package.json` | **换 inode，硬链接被静默切断** |
| 临时文件 + `rename` | `dshmarket/lib/order.js`（manifest 重排） | 同上 |
| `rm` + `rename` | `dshmarket/lib/backup.js` 恢复备份 | 同上 |

`rename` 替换的是目录项，所以：硬链接会无声失效（仓库那份文件停止更新，`git status` 干净但内容是旧的）；
文件级软链接会被替换成普通文件。反方向也一样，`git checkout` / `restore` / `stash` 都会重写工作区文件从而切断链接。

文件级软链接还有额外风险：`restoreProfileBackup()` 会 `lstatSync(target).isFile()`，
`package.json` 若是软链接会直接被判成 `backup path is not a file`，**装/回滚插件时报错**。

内容同步没有 inode 可断：无论 DSH 怎么写，`save` 都是把字节读出来，`diff` 如实报告。

## 入库 vs 不入库

入库（见 `dsh-manifest.txt`）：profile 的 `cordis.yml` / `cordis.patch.yml` /
`package.json` / `pnpm-workspace.yaml` / `pnpm-lock.yaml` / `.dsh/rules.yaml`、
插件配置 `plugins/*/config.yaml`、`dsh-auto-memory.json`。

**永不入库**（见仓库根的 `.gitignore`）：

- 凭据：`.credentials.yaml`、`openrouter-providers.json`、`.anonymous-user-id`
- 运行态：`sessions/` `storages/` `cache/` `attachments/` `rewind-snapshots/`
  `profiles/*/node_modules/` `profiles/*/.dsh-market/` `*.log`
- 插件私有数据：`plugins/*/runtime/`（按项目的缓存/DB）、`plugins/dsh-git-worktree/`
- 自己开发的插件（`dsh-openrouter-live` 等）：放在各自仓库，这里只记 `package.json` 里的引用

## 注意

- `cordis.patch.yml` 里有绝对路径（`rules.yaml`、`gopls` 路径）和多机差异项；多机/多用户场景
  再考虑上 chezmoi 的模板（`~`、主机名变量）。
- 顶层 `~/.config/@deepseek-ai/dsh-desktop`（Electron userData、缓存/日志）和
  `~/.config/deepseek/deepseek-harness-desktop.conf`（只是窗口几何）不需要管理。
