.EH_hub_options <- new.env(parent=emptyenv())

getExperimentHubOption <- function(arg) {
    stopifnot(is.character(arg), length(arg) == 1L)
    arg <- toupper(arg)
    key <- c("URL", "CACHE", "PROXY", "MAX_DOWNLOADS", "LOCAL", "ASK")
    if (!arg %in% key)
        stop("'arg' must be one of 'URL', 'CACHE', 'PROXY', ",
             "'LOCAL', 'ASK' or 'MAXDOWNLOADS'")
    .EH_hub_options[[arg]]
}

setExperimentHubOption <- function(arg, value)
{
    stopifnot(is.character(arg), length(arg) == 1L)
    key <- .hub_option_key(toupper(trimws(arg)))

    .EH_hub_options[[key]] <- switch(key, URL=, CACHE={
        value <- as.character(value)
        stopifnot(isSingleString(value))
        value
    }, MAX_DOWNLOADS={
        value <- as.integer(value)
        stopifnot(isSingleInteger(value))
        value
    }, PROXY={
        if (is.null(value) | inherits(value, "request"))
            value
        else if (isSingleString(value)) {
            .httr_proxy(value)
        } else {
            txt <- "'value' must be an httr proxy request (use_proxy()),
                    character(1), or NULL"
            stop(paste(strwrap(txt, exdent=2), collapse="\n"))
        }
    }, LOCAL={
        stopifnot(isTRUE(value) | isFALSE(value))
        value
    }, ASK={
        stopifnot(isTRUE(value) || isFALSE(value))
        value
    })
}
