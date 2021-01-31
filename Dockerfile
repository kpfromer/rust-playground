FROM jupyter/minimal-notebook

USER root

RUN apt-get -y update && \
  apt-get install -y curl cmake

# Switch back to jovyan to avoid accidental container runs as root
USER $NB_UID

# Install rustup
RUN curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y

# Add rust to path
ENV PATH="$HOME/.cargo/bin:${PATH}"

# Install evcxr_jupyter
# https://github.com/google/evcxr/blob/master/evcxr_jupyter/README.md
RUN rustup component add rust-src
RUN cargo install evcxr_jupyter
RUN evcxr_jupyter --install
