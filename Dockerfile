FROM nvidia/cuda:11.7.1-runtime-ubuntu20.04

RUN apt-get update -y \
 && apt-get install -y python3 python3-pip python3-dev

# Enable PEP 660 support
RUN pip install --upgrade pip

# Create a non-root user and set permissions
RUN useradd --create-home fastchat
WORKDIR /home/fastchat
RUN chown fastchat:fastchat /home/fastchat
USER fastchat
ENV PATH="$PATH::/home/fastchat/.local/bin"

# Copy the pyproject.toml file and install the requirements
COPY --chown=fastchat:fastchat pyproject.toml .
RUN pip install -e .

# Copy the application files
COPY --chown=fastchat:fastchat fastchat/ ./fastchat
