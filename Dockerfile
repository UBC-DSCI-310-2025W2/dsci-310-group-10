FROM rocker/rstudio:4.5.2

RUN RUN apt-get update && apt-get install -y \
    build-essential \
    git \
    libcurl4-openssl-dev \
    libssl-dev \
    libxml2-dev \
    libgit2-dev \
    libharfbuzz-dev \
    libfribidi-dev \
    libfreetype6-dev \
    libpng-dev \
    libjpeg-dev \
    libtiff5-dev \
    zlib1g-dev \
    libbz2-dev \
    liblzma-dev \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /home/rstudio/project

# Copy lockfile first for Docker layer caching
COPY renv.lock renv.lock

# Install renv
RUN R -e "install.packages('renv', repos='https://cloud.r-project.org')"

# Restore packages
RUN R -e "renv::restore(lockfile = 'renv.lock', prompt = FALSE)"

# Now copy the rest of the project (including .Rmd)
COPY . .

EXPOSE 8787
