FROM docker:dind as docker

FROM ubuntu:noble

ENV WORKSPACE=/workspace
ENV BUILDAH_ISOLATION=chroot

# Install dependencies
RUN apt update
RUN apt install -y \
    curl \
    git \
    tmux \
    xclip \
    zsh \
    unzip \
    neovim

# Install buildah
RUN apt install -y \
    buildah \
    fuse-overlayfs \
    qemu-user-static

# Install taskfile
RUN sh -c "$(curl --location https://taskfile.dev/install.sh)" -- -d -b /usr/local/bin

# Copy docker binary
COPY --from=docker /usr/local/bin/docker /usr/local/bin/docker

# Install language tools
RUN apt install -y \
    python3 \
    pip \
    golang-go

# Config zsh
RUN touch $HOME/.zshrc && \
  sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" && \
  git clone --depth=1 https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/zsh-autosuggestions && \
  git clone --depth=1 https://github.com/zsh-users/zsh-syntax-highlighting ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting && \
  git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k && \
  chsh -s $(which zsh)

COPY zsh/custom /root/.oh-my-zsh/custom
COPY zsh/.p10k.zsh /root/.p10k.zsh
COPY zsh/.zshrc /root/.zshrc

# Config tmux
COPY tmux/tmux.conf /root/.tmux.conf

# Config neovim
RUN git clone https://github.com/empty21/lazyvim ~/.config/nvim

# Config taskfiles
COPY Taskfile.index.yaml /root/Taskfile.yaml
COPY taskfiles/ /root/taskfiles

WORKDIR $WORKSPACE
ENTRYPOINT ["/usr/bin/zsh"]
CMD ["-c", "sleep infinity"]
