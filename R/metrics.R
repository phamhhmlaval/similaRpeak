# Created by Astrid Deschenes
# 2014-08-13

# Class representing a abstract Metric which is used to quantify the similarity 
# between two ChIP profiles covering the same range.
#
Metric <- R6Class("Metric",
    public = list(
        initialize = function() {  
        },
        getType = function() {
            return(private$type)
        },
        getMetric = function() {
            return(private$metric)
        },
        calculateMetric = function(profile1, profile2, threshold = NULL) {
        },
        getInfo = function() {
            cat(paste0("Metric type: ", private$type, ". Metric value: ", 
                    private$metric, "\n"))
        }
    ),  
    private = list(
        metric = NA,
        type = NA,
        setMetric = function(val){
            private$metric <<- val
        },
        setType = function(val){
            private$type <<- val
        }
    )
)


# Class representing a Max Max Ratio metric which is the ratio of profiles 
# maximal peaks between two ChIP profiles covering the same range
#
RatioMaxMax <- R6Class("RatioMaxMax",
    inherit = Metric,
    public = list(
        initialize = function(profile1, profile2, threshold = 1) {

            # Fix the type of metric
            super$setType("RATIO_MAX_MAX")
                                
            if (!missing(profile1) && !missing(profile2)) {
                self$calculateMetric(profile1, profile2, threshold)   
            }
        },
        calculateMetric = function(profile1, profile2, threshold = 1) {

            # Reset metric value to NA
            super$setMetric(as.numeric(NA))

            # Profile1 and profile2 are mandatory
            if (missing(profile1)) {
                stop(paste0("The 'profile1' argument is mandatory. ", 
                    "The metric value has been reset to NA."))
            }
            if (missing(profile2)) {
                stop(paste0("The 'profile2' argument is mandatory. ", 
                    "The metric value has been reset to NA."))
            }

            # The profile1 and profile2 arguments are 
            # numeric vectors where at least one element is greater than zero
            if (!is.vector(profile1) || !is.numeric(profile1)) {
                stop(paste0("The 'profile1' argument must be a numeric ",
                    "vector. The metric value has been reset to NA."))
            } 
            if (!is.vector(profile2) || !is.numeric(profile2)) {
                stop(paste0("The 'profile2' argument must be a numeric ",
                    "vector. The metric value has been reset to NA."))
            }

            # The length of profile1 is equal to the length of profile2
            if (length(profile1) != length(profile2)) {
                stop(paste0("Lengths of 'profile1' and 'profile2' vectors ", 
                    "aren't equals. The metric value has been reset to NA."))
            }

            # Calculate and assign the new max max ratio
            super$setMetric(ratioMaxMax(profile1, profile2, threshold))
        }
    )
)


# Class representing an Area Ratio metric which is the ratio of profiles
# total areas between two ChIP profiles covering the same range.
#
RatioArea <- R6Class("RatioArea",
    inherit = Metric,
    public = list(
        initialize = function(profile1, profile2, threshold = 1) {

            # Fix the type of metric
            super$setType("RATIO_AREA")
                               
            if (!missing(profile1) && !missing(profile2)) {
                self$calculateMetric(profile1, profile2, threshold)   
            }
        },
        calculateMetric = function(profile1, profile2, threshold = 1) {

            # Reset metric value to NA
            super$setMetric(as.numeric(NA))

            # Profile1 and profile2 are mandatory
            if (missing(profile1)) {
                stop(paste0("The 'profile1' argument is mandatory. The metric ",
                            "value has been reset to NA."))
            }
            if (missing(profile2)) {
                stop(paste0("The 'profile2' argument is mandatory. The metric ",
                            "value has been reset to NA."))
            }

            # The profile1 and profile2 arguments are numeric vectors where at 
            # least one element is greater than zero
            if (!is.vector(profile1) || !is.numeric(profile1)) {
                stop(paste0("The 'profile1' argument must be a numeric ", 
                            "vector. The metric value has been reset to NA."))
            }
            if (!is.vector(profile2) || !is.numeric(profile2)) {
                stop(paste0("The 'profile2' argument must be a numeric ", 
                            "vector. The metric value has been reset to NA."))
            }

            # The length of profile1 is equal to the length  of profile2
            if (length(profile1) != length(profile2)) {
                stop(paste0("Lengths of 'profile1' and 'profile2' vectors ", 
                            "aren't equals. The metric value has been reset ",
                            "to NA."))
            }

            # Calculate and assign the new max max ratio
            super$setMetric(ratioArea(profile1, profile2, threshold))
        }
    )
)  


# Class representing a Positions Difference metric which is the difference 
# of profiles maximal peaks positions 
# between two ChIP profiles covering the same range.
#
DiffPosMax <- R6Class("DiffPosMax",
    inherit = Metric,
    public = list(
        initialize = function(profile1, profile2, threshold = 1, 
                            thresholdDiff = 100, tolerance = 0.01) {

            # Fix the type of metric
            super$setType("DIFF_POS_MAX")
                             
            if (!missing(profile1) && !missing(profile2)) {
                self$calculateMetric(profile1, profile2, threshold, 
                                        thresholdDiff, tolerance)   
            }
        },
        calculateMetric = function(profile1, profile2, threshold = 1, 
                            thresholdDiff = 100, tolerance = 0.01) {

            # Reset metric value to NA
            super$setMetric(NA)

            # Profile1 and profile2 are mandatory
            if (missing(profile1)) {
                stop(paste0("The 'profile1' argument is mandatory. ", 
                       "The metric value has been reset to NA."))
            }

            if (missing(profile2)) {
                stop(paste0("The 'profile2' argument is mandatory. ", 
                        "The metric value has been reset to NA."))
            }

            # The profile1 and profile2 arguments are numeric 
            # vectors where at least one element is greater than zero
            if (!is.vector(profile1) || !is.numeric(profile1)) {
                stop(paste0("The 'profile1' argument must be a numeric ",
                    "vector. The metric value has been reset to NA."))
            }

            if (!is.vector(profile2) || !is.numeric(profile2)) {
                stop(paste0("The 'profile2' argument must be a numeric ",
                    "vector. The metric value has been reset to NA."))
            }

            # The length of profile1 is equal to the length of profile2
            if (length(profile1) != length(profile2)) {
                stop(paste0("Lengths of 'profile1' and 'profile2' vectors ", 
                    "aren't equals. The metric value has been reset to NA."))
            }

            # Calculate and assign the new difference position maximum
            super$setMetric(diffPosMax(profile1, profile2, threshold, 
                            thresholdDiff, tolerance))
        }
    )
)  


# Class representing an Intersect Ratio metric which is the ratio of profiles 
# intersection area between two ChIP profiles covering the same range and 
# those profiles total areas.
#
RatioIntersect <- R6Class("RatioIntersect",
    inherit = Metric,
    public = list(
        initialize = function(profile1,profile2, threshold = 1) {
                             
            # Fix the type of metric
            super$setType("RATIO_INTERSECT")

            if (!missing(profile1) && !missing(profile2)) {
                self$calculateMetric(profile1, profile2, threshold)   
            }
        },
        calculateMetric = function(profile1, profile2, threshold = 1) {

            # Reset metric value to NA
            super$setMetric(as.numeric(NA))

            # Profile1 and profile2 are mandatory
            if (missing(profile1)) {
                stop(paste0("The 'profile1' argument is mandatory. The ",
                    "metric value has been reset to NA."))
            }
            if (missing(profile2)) {
                stop(paste0("The 'profile2' argument is mandatory. The ", 
                    "metric value has been reset to NA."))
            }

            # The profile1 and profile2 arguments are numeric 
            # vectors where at least one element is greater than zero
            if (!is.vector(profile1) || !is.numeric(profile1)) {
                stop(paste0("The 'profile1' argument must be a numeric ",
                    "vector. The metric value has been reset to NA."))
            }
            if (!is.vector(profile2) || !is.numeric(profile2)) {
                stop(paste0("The 'profile2' argument must be a numeric ",
                    "vector. The metric value has been reset to NA."))
            }

            # The length of profile1 is equal to the length of profile2
            if (length(profile1) != length(profile2)) {
                stop(paste0("Lengths of 'profile1' and 'profile2' vectors ", 
                    "aren't equals. The metric value has been reset to NA."))
            }

            # Calculate and assign the new intersect ratio
            super$setMetric(ratioIntersect(profile1, profile2, threshold))
        }
    )
)


# Class representing a Normalized Intersect Ratio metric which is the ratio of 
# profiles intersection area between two normalized ChIP profiles covering 
# the same range and those profiles total areas. The ChIP profiles are 
# normalized by multiplying the profile values with the length 
# of the profile and dividind it by the area of the profile.
# normalized values = profile values * length(profile)/area(profile)
#
RatioNormalizedIntersect <- R6Class("RatioNormalizedIntersect",
    inherit = Metric,
    public = list(
        initialize = function(profile1, profile2, threshold = 1) {

            # Fix the type of metric
            super$setType("RATIO_NORMALIZED_INTERSECT")

            if (!missing(profile1) && !missing(profile2)) {
                    self$calculateMetric(profile1, profile2, threshold)
            }
        },
        calculateMetric = function(profile1, profile2, threshold = 1) {

            # Reset metric value to NA
            super$setMetric(as.numeric(NA))

            # Profile1 and profile2 are mandatory
            if (missing(profile1)) {
                stop(paste0("The 'profile1' argument is mandatory. The ",
                    "metric value has been reset to NA."))
            }
            if (missing(profile2)) {
                stop(paste0("The 'profile2' argument is mandatory. The ", 
                    "metric value has been reset to NA."))
            }

            # The profile1 and profile2 arguments are numeric 
            # vectors where at least one element is greater than zero
            if (!is.vector(profile1) || !is.numeric(profile1)) {
                stop(paste0("The 'profile1' argument must be a numeric ", 
                    "vector. The metric value has been reset to NA."))
            }
            if (!is.vector(profile2) || !is.numeric(profile2)) {
                stop(paste0("The 'profile2' argument must be a numeric ",
                    "vector. The metric value has been reset to NA."))
            }

            # The length of profile1 is equal to the length of profile2
            if (length(profile1) != length(profile2)) {
                stop(paste0("Lengths of 'profile1' and 'profile2' vectors ", 
                    "aren't equals. The metric value has been reset to NA."))
            }

            # Normalized profiles values
            normProfile1 <- profile1*(length(profile1)/sum(profile1, 
                                            na.rm=TRUE))
            normProfile2 <- profile2*(length(profile2)/sum(profile2, 
                                            na.rm=TRUE))

            # Calculate and assign the normalized intersect ratio
            super$setMetric(ratioIntersect(normProfile1, normProfile2, 
                                            threshold))
        }
    )
)

# Class representing a Spearman correlation metric which is the Spearman's  
# rank correlation coefficient of the two profiles.
#
SpearmanCorrelation <- R6Class("SpearmanCorrelation",
    inherit = Metric,
    public = list(
        initialize = function(profile1, profile2, threshold = NULL) {

            # Fix the type of metric
            super$setType("SPEARMAN_CORRELATION")

            if (!missing(profile1) && !missing(profile2)) {
                self$calculateMetric(profile1, profile2, threshold)   
            }
        },
        calculateMetric = function(profile1, profile2, threshold = 1e-8) {

            # Reset metric value to NA
            super$setMetric(as.numeric(NA))

            # Profile1 and profile2 are mandatory
            if (missing(profile1)) {
                stop(paste0("The 'profile1' argument is mandatory. ", 
                    "The metric value has been reset to NA."))
            }
            if (missing(profile2)) {
                stop(paste0("The 'profile2' argument is mandatory. The ",
                    "metric value has been reset to NA."))
            }

            # The profile1 and profile2 arguments are numeric 
            # vectors where at least one element is greater than zero
            if (!is.vector(profile1) || !is.numeric(profile1)) {
                stop(paste0("The 'profile1' argument must be a numeric ", 
                            "vector. The metric value has been reset to NA."))
            }
            if (!is.vector(profile2) || !is.numeric(profile2)) {
                stop(paste0("The 'profile2' argument must be a numeric ", 
                            "vector. The metric value has been reset to NA."))
            }

            # The length of profile1 is equal to the length of profile2
            if (length(profile1) != length(profile2)) {
                stop(paste0("Lengths of 'profile1' and 'profile2' vectors ", 
                    "aren't equals. The metric value has been reset to NA."))
            }

            # Calculate and assign the spearman correlation
            super$setMetric(spearmanCorr(profile1, profile2, threshold))
        }
    )
)

# Class used to create metrics. 
#
MetricFactory <- R6Class("MetricFactory",
    public = list(
        initialize = function(ratioAreaThreshold = 1, 
                                ratioMaxMaxThreshold = 1, 
                                ratioIntersectThreshold = 1,
                                ratioNormalizedIntersectThreshold = 1,
                                diffPosMaxThresholdMinValue = 1, 
                                diffPosMaxThresholdMaxDiff = 100, 
                                diffPosMaxTolerance = 0.01,
                                spearmanCorrSDThreashold = 1e-8) {

            private$ratioAreaThreshold <<- ratioAreaThreshold
            private$ratioMaxMaxThreshold <<- ratioMaxMaxThreshold
            private$ratioIntersectThreshold <<- ratioIntersectThreshold
            private$ratioNormalizedIntersectThreshold <<- 
                ratioNormalizedIntersectThreshold
            private$diffPosMaxThresholdMinValue <<- diffPosMaxThresholdMinValue
            private$diffPosMaxThresholdMaxDiff <<- diffPosMaxThresholdMaxDiff
            private$diffPosMaxTolerance <<- diffPosMaxTolerance
            private$spearmanCorrSDThreashold <<- spearmanCorrSDThreashold
        },
        createMetric = function(metricType, profile1, profile2) {

            # Metric, profile1 and profile2 are mandatory
            if (missing(metricType)) {
                stop(paste0("The 'metricType' argument is mandatory."))
            }

            if (missing(profile1)) {
                stop(paste0("The 'profile1' argument is mandatory."))
            }

            if (missing(profile2)) {
                stop(paste0("The 'profile2' argument is mandatory."))
            }

            # The profile1 and profile2 arguments are numeric vectors 
            if (!is.vector(profile1) || !is.numeric(profile1)) {
                stop(paste0("The 'profile1' argument must be a numeric ", 
                            "vector."))
            }

            if (!is.vector(profile2) || !is.numeric(profile2)) {
                stop(paste0("The 'profile2' argument must be a numeric ", 
                            "vector."))
            }

            # The length of profile1 is equal to the length of profile2
            if (length(profile1) != length(profile2)) {
                stop(paste0("Lengths of 'profile1' and 'profile2' vectors ", 
                    "aren't equals."))
            }

            # Metric type must exist
            if (!metricType %in% private$metricVector) {
                stop(paste0("The metricType must be one of those choices: ", 
                    paste(private$metricVector, collapse = ", "))) 
            }

            result_name = list()
            result =list()

            if (metricType == "ALL" ||  metricType == "RATIO_AREA") {
                metric <- RatioArea$new(profile1, profile2, 
                                    private$ratioAreaThreshold)

                result_name <- c(result_name, metric$getType())
                result <- c(result, metric$getMetric())
            }

            if (metricType == "ALL" || metricType == "DIFF_POS_MAX") {
                metric <- DiffPosMax$new(profile1,  profile2, 
                                    private$diffPosMaxThresholdMinValue, 
                                    private$diffPosMaxThresholdMaxDiff, 
                                    private$diffPosMaxTolerance)

                result_name <- c(result_name, metric$getType())
                result <- c(result, metric$getMetric())
            }

            if (metricType == "ALL" || metricType == "RATIO_MAX_MAX") {
                metric <- RatioMaxMax$new(profile1, profile2, 
                                    private$ratioMaxMaxThreshold)
                
                result_name <- c(result_name, metric$getType())
                result <- c(result, metric$getMetric())
            }

            if (metricType == "ALL" || metricType == "RATIO_INTERSECT") {
                metric <- RatioIntersect$new(profile1, profile2, 
                                    private$ratioIntersectThreshold)

                result_name <- c(result_name, metric$getType())
                result <- c(result, metric$getMetric())
            }

            if (metricType == "ALL" || 
                    metricType == "RATIO_NORMALIZED_INTERSECT") {
                metric <- RatioNormalizedIntersect$new(profile1, profile2, 
                                    private$ratioNormalizedIntersectThreshold)

                result_name <- c(result_name,metric$getType())
                result <- c(result, metric$getMetric())
            }

            if (metricType == "ALL" || 
                    metricType == "SPEARMAN_CORRELATION") {
                metric <- SpearmanCorrelation$new(profile1, profile2, 
                                            private$spearmanCorrSDThreashold)

                result_name <- c(result_name,metric$getType())
                result <- c(result, metric$getMetric())
            }

            names(result) <- result_name

            return(result)

        }
    ), private = list(
        # Vector of all existing types of metrics
        metricVector = c("ALL",
                            "RATIO_AREA", 
                            "DIFF_POS_MAX", 
                            "RATIO_MAX_MAX", 
                            "RATIO_INTERSECT",
                            "RATIO_NORMALIZED_INTERSECT",
                            "SPEARMAN_CORRELATION"),
            # Threshold values
            ratioAreaThreshold = NA,
            ratioMaxMaxThreshold = NA,
            ratioIntersectThreshold = NA,
            ratioNormalizedIntersectThreshold = NA,
            diffPosMaxThresholdMinValue = NA,
            diffPosMaxThresholdMaxDiff = NA,
            diffPosMaxTolerance = NA,
            spearmanCorrSDThreashold = NA
    )
)
