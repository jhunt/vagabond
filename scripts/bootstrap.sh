#!/bin/bash
set -e

echo "Installing Software"
apt-key adv \
	--keyserver hkp://p80.pool.sks-keyservers.net:80 \
	--recv-keys 58118E89F3A912897C070ADBF76221572C52609D \
	>/dev/null

cat >/etc/apt/sources.list.d/docker.list <<EOF
deb https://apt.dockerproject.org/repo ubuntu-vivid main
EOF

apt-get update >/dev/null
apt-get install -y \
	linux-image-extra-$(uname -r) \
	docker-engine \
	vim tmux tree \
	nmap
usermod -aG docker vagrant

curl -LSs https://storage.googleapis.com/golang/go1.7.3.linux-amd64.tar.gz | tar -C /usr/local -xz
cat > /home/vagrant/.bash_aliases <<'EOF'
export PATH=$PATH:/usr/local/go/bin
export GOPATH=$HOME/go
EOF

echo "Setting up User Environment"
cat > /tmp/user-setup.sh <<'EOF'
#!/bin/bash
source /home/vagrant/.bash_aliases

mkdir -p /home/vagrant/go
export GOPATH=/home/vagrant/go
go get github.com/tools/godep
go get github.com/golang/lint/golint
go get github.com/onsi/ginkgo
go get github.com/onsi/ginkgo/ginkgo
go get github.com/onsi/gomega

cat >/home/vagrant/.vimrc <<EOS
set bg=dark
set visualbell t_vb=
set novisualbell
filetype indent on
set autoindent
set backspace=start,eol,indent
set formatoptions=tcqo
set hlsearch
hi LineNr ctermfg=DarkGrey
set number
set ts=4 sts=4 sw=4
set noet
set laststatus=2
set stl=[%n]\ file:%-50F\ %y%r%m\ byte:0x%B%=line:%l:%c/%L\ %p%%
EOS

cat >/home/vagrant/.inputrc <<EOS
set bell-style none
set completion-ignore-case off
set mark-directories on
set mark-symlinked-directories on
set match-hidden-files off
set menu-complete-display-prefix on
set print-completions-horizontally on
set colored-stats on
EOS

cat >/home/vagrant/.tmux.conf <<EOS
set -g utf8
set-window-option -g utf8 on
set-window-option -g mode-key vi
set -g history-limit 50000
unbind C-b
set -g prefix 'C-a'
bind 'C-a' send-prefix
bind - split-window -v
bind + split-window -h
bind h select-pane -L
bind j select-pane -D
bind k select-pane -U
bind l select-pane -R
bind -r C-h select-window -t :-
bind -r C-l select-window -t :+
# screen ^C c
unbind ^C
unbind  c
bind ^C new-window
bind  c new-window
unbind ^D
bind ^D detach
unbind ^N
unbind  n
bind -r ^N next-window
unbind ^P
unbind  p
bind -r ^P previous-window
unbind K
unbind k
bind K confirm-before "kill-window"
bind k confirm-before "kill-window"
unbind ^L
unbind  l
bind ^L refresh-client
bind  l refresh-client
unbind |
bind | split-window
unbind '"'
bind '"' choose-window
set -g status-utf8 on
set -g status-bg black
set -g status-fg white
set -g status-left-length 70
set -g status-left "#[fg=colour192]#h:"
set -g status-right-length 60
set -g status-right "#[fg=yellow]%Z %z"
set-option -g pane-border-fg colour235
set-option -g pane-active-border-fg colour88
set-option -g default-terminal "screen"
set -g status-justify centre
set-window-option -g window-status-fg brightblue
set-window-option -g window-status-bg black
set-window-option -g window-status-attr dim
set-window-option -g window-status-current-fg brightgreen
set-window-option -g window-status-current-bg black
set-window-option -g window-status-current-attr bright
EOS

EOF
sudo -u vagrant bash /tmp/user-setup.sh
rm -f /tmp/user-setup.sh

echo "DONE"
