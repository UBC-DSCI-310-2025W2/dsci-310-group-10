FROM rocker/rstudio:4.5.2

RUN apt-get update && apt-get install -y \
    libcurl4-openssl-dev \
    libssl-dev \
    libxml2-dev \
    build-essential \
    git \
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