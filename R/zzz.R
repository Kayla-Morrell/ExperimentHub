.CACHE_ROOT <- "ExperimentHub"

.onLoad <- function(libname, pkgname, ...) {
    ## options from getOption or Sys.env or default, in that order
    if (is.null(getExperimentHubOption("MAX_DOWNLOADS"))) {
        opt <- getOption("EXPERIMENT_HUB_MAX_DOWNLOADS", 10L)
        opt <- Sys.getenv("EXPERIMENT_HUB_MAX_DOWNLOADS", opt)
        opt <- as.integer(opt)
        setExperimentHubOption("MAX_DOWNLOADS", opt)
    }
    if (is.null(getExperimentHubOption("URL"))) {
        opt <- getOption("EXPERIMENT_HUB_URL",
                         "https://experimenthub.bioconductor.org")
        opt <- Sys.getenv("EXPERIMENT_HUB_URL", opt)
        setExperimentHubOption("URL", opt)
    }
    if (is.null(getExperimentHubOption("CACHE"))) {
        path <- user_cache_dir(appname=.CACHE_ROOT)
        opt <- getOption("EXPERIMENT_HUB_CACHE", path)
        opt <- Sys.getenv("EXPERIMENT_HUB_CACHE", opt)
        setExperimentHubOption("CACHE", opt)
    }
    if (is.null(getExperimentHubOption("PROXY"))) {
        opt <- getOption("EXPERIMENT_HUB_PROXY", "")
        opt <- Sys.getenv("EXPERIMENT_HUB_PROXY", opt)
        if (nzchar(opt))
            setExperimentHubOption("PROXY", opt)
    }
    if (is.null(getExperimentHubOption("LOCAL"))) {
        opt <- getOption("EXPERIMENT_HUB_LOCAL", FALSE)
        opt <- Sys.getenv("EXPERIMENT_HUB_LOCAL", opt)
        opt <- as.logical(opt)
        setExperimentHubOption("LOCAL", opt)
    }
    if (is.null(getExperimentHubOption("ASK"))) {
        opt <- getOption("EXPERIMENT_HUB_ASK", TRUE)
        opt <- Sys.getenv("EXPERIMENT_HUB_ASK", opt)
        opt <- as.logical(opt)
        setExperimentHubOption("ASK", opt)
    }

}
