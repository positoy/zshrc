# Skip theme initialization for better compatibility
if [[ -n "$CURSOR_AGENT" ]]; then
  PS1='\u@\h \W \$ '
  exit 0;
else
  [[ -r ~/.p10k.zsh ]] && source ~/.p10k.zsh
fi

# tmux 자동 실행: 터미널을 점유하므로 반드시 p10k instant prompt 블록보다 위에 둬야 한다.
# (instant prompt 가 터미널 I/O 를 가로채면 tmux 가 "open terminal failed: not a terminal" 로 실패)
# 대화형 쉘이고, tmux가 설치돼 있고, 아직 tmux 안이 아닐 때만 실행
if command -v tmux >/dev/null 2>&1 && [[ -z "$TMUX" ]] && [[ -o interactive ]]; then
  tmux new-session -A -s default
fi

