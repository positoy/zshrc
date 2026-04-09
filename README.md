# macOS 개발환경 초기 설정

macOS를 초기화한 뒤, 아래 스크립트를 실행하면 개발환경 전체를 한 번에 구성할 수 있습니다.

## 설치 스크립트

```bash
#!/bin/bash
set -e

# ===========================================
# 1. Homebrew 설치
# ===========================================
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

# Apple Silicon Mac의 경우 brew PATH 등록
echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >> ~/.zprofile
eval "$(/opt/homebrew/bin/brew shellenv)"

# ===========================================
# 2. Oh My Zsh 설치 + Powerlevel10k 테마
# ===========================================
# Oh My Zsh 설치 (설치 후 자동으로 쉘이 바뀌지 않도록 RUNZSH=no 설정)
RUNZSH=no sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

# Powerlevel10k 테마 설치
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git "${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k"

# .zshrc에 테마 설정 적용
sed -i '' 's/^ZSH_THEME=.*/ZSH_THEME="powerlevel10k\/powerlevel10k"/' ~/.zshrc

# ===========================================
# 3. Zsh 플러그인 (git, zsh-autosuggestions, zsh-syntax-highlighting)
# ===========================================
# zsh-autosuggestions 플러그인 설치
git clone https://github.com/zsh-users/zsh-autosuggestions "${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/zsh-autosuggestions"

# zsh-syntax-highlighting 플러그인 설치
git clone https://github.com/zsh-users/zsh-syntax-highlighting "${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting"

# .zshrc에 플러그인 목록 설정 (git은 Oh My Zsh 기본 내장)
sed -i '' 's/^plugins=.*/plugins=(git zsh-autosuggestions zsh-syntax-highlighting)/' ~/.zshrc

# ===========================================
# 4. nvm 설치 + Node.js 22 기본 설정
# ===========================================
# nvm 설치
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.3/install.sh | bash

# nvm 즉시 로드
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"

# Node.js 22 설치 및 기본 버전 설정
nvm install 22
nvm alias default 22

# ===========================================
# 5. SDKMAN 설치 + Java 21 기본 설정
# ===========================================
# SDKMAN 설치
brew install bash
curl -s "https://get.sdkman.io" | bash

# SDKMAN 즉시 로드
source "$HOME/.sdkman/bin/sdkman-init.sh"

# Java 21 (Temurin) 설치 및 기본 버전 설정
sdk install java 21-tem
sdk default java 21-tem

# ===========================================
# 6. CLI 도구 (brew install)
# ===========================================
brew install git          # Git 버전 관리
brew install docker       # Docker CLI (컨테이너 관리)
brew install fd           # find 대체 (빠른 파일 검색)
brew install ripgrep      # grep 대체 (빠른 텍스트 검색)
brew install fzf          # 퍼지 파인더 (인터랙티브 검색)
brew install bat          # cat 대체 (구문 하이라이팅)
brew install btop         # top 대체 (시스템 모니터링)
brew install lazygit      # 터미널 Git UI
brew install git-delta    # Git diff 뷰어 (구문 하이라이팅)
brew install jq           # JSON 처리 도구
brew install tlrc         # tldr 커맨드 치트시트 (Rust 클라이언트)
brew install tree         # 디렉토리 트리 출력
brew install wget
brew install hey
brew install stern
brew install bruno
brew install mycli
# ===========================================
# 7. GUI 앱 (brew install --cask)
# ===========================================
brew install --cask intellij-idea     # IntelliJ IDEA (Java/Kotlin IDE)
brew install --cask ghostty           # Ghostty (GPU 가속 터미널)
brew install --cask obsidian          # Obsidian (마크다운 노트)
brew install --cask beekeeper-studio  # Beekeeper Studio (DB 클라이언트)
brew install --cask stats             # Stats (메뉴바 시스템 모니터)
brew install --cask maccy             # Maccy (클립보드 관리자)
brew install --cask alt-tab           # AltTab (윈도우 스위처)
brew install --cask cmux              # CMUX (터미널 멀티플렉서)
brew install --cask monitorcontrol    # MonitorControl (외장 모니터 밝기/볼륨 조절)

# ===========================================
# 8. AI CLI 도구 (npm install -g)
# ===========================================
npm install -g @anthropic-ai/claude-code  # Claude Code (AI 코딩 어시스턴트)
npm install -g @openai/codex              # Codex (OpenAI 코딩 어시스턴트)

# ===========================================
# 완료
# ===========================================
echo "설치가 완료되었습니다. 새 터미널을 열어주세요."
echo "Powerlevel10k 초기 설정: p10k configure"
```

## lazygit split diff 설정

```yaml
# ~/Library/Application\ Support/lazygit/config.yml
gui:
  sidePanelWidth: 0.2 # gives you more space to show things side-by-side
git:
  pagers:
     - colorArg: always
       pager: delta --dark --paging=never --syntax-theme base16-256 -s
```
