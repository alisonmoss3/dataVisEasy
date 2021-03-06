\name{reportGenes}
\alias{reportGenes}
%- Also NEED an '\alias' for EACH other topic documented here.
\title{
Report Expression Information for a given set of genes
}
\description{
Based on supplied expression data set, will return a report detailing expression information for the list of genes supplied to the function. Will report the percent of samples with detectable expression (non-missing data), Percent Samples NA (missing data), and percent of samples high, mid-range, and low expression with respect to the median of each gene to detail the range of expression of the genes in question.
}
\usage{
reportGenes(data, list,exact = T, ranges = "fixed", fixed.range = 2, weight = 1.25)
}
%- maybe also 'usage' for other objects documented here.
\arguments{
  \item{data}{
numeric data matrix with samples/observations in the columns and genes/variables in the rows
}
  \item{list}{
character vector of genes/variables to be pulled out of the data matrix for report of expression ranges
}
  \item{exact}{
whether or not to search for exact or inexact matches of 'list' in 'data'. If exact = T (default) heatmap will plot genes/variables that exactly match the list supplied. If set to FALSE, will search for inexact matches.
}
  \item{ranges}{
option dictating how the range the ranges of expression are determined. The default, "fixed" sets the threshold for high and low expression a fixed value away from the median. Will also accept "mad" which sets these thresholds as a function of the median average deviation from the median.
}
  \item{fixed.range}{
if ranges = "fixed". Indicates the threshold away from the median where expression is considered high or low. For the default case where fixed.range = 2, expression > median() + 2 will be considered high expression while expression < median() - 2 will be considered low expression with all values in between considered mid range.
}
  \item{weight}{
if ranges = "mad". Indicates the weight applied to the mad that sets the threshold away from the median where expression is considered high or low. For the default case where weight = 1.25, expression > median() + mad*1.25 will be considered high expression while expression < median() - mad*1.25 will be considered low expression with all values in between considered mid range.
}
}
%\details{
%%  ~~ If necessary, more details than the description above ~~
%}
\value{
a data frame with six columns: Gene, Percent Samples Detected, Percent Samples NA, Percent High Expressing, Percent Mid-Range Expression, and Percent Low Expressing
}
%\references{
%% ~put references to the literature/web site here ~
%}
\author{
~~Alison Moss~~
}
%\note{
%%  ~~further notes~~
%}

%% ~Make other sections like Warning with \section{Warning }{....} ~

%\seealso{
%% ~~objects to See Also as \code{\link{help}}, ~~~
%}
\examples{

##assess percentage of samples detected and distribution of expression for select genes
reportGenes(RAGP_norm, list = c("Th","Chat","Npy","PGP9.5","NeuN"))

##fixed range above/below median
reportGenes(RAGP_norm, list = c("Th","Chat","Npy","PGP9.5","NeuN"),
  ranges = "fixed", fixed.range = 1)

##based on fraction (weight) of median average deviation (mad) from median
reportGenes(RAGP_norm, list = c("Th","Chat","Npy","PGP9.5","NeuN"),
  ranges = "mad", weight = 0.5)
reportGenes(RAGP_norm, list = c("Th","Chat","Npy","PGP9.5","NeuN"),
  ranges = "mad", weight = 1)

}
% Add one or more standard keywords, see file 'KEYWORDS' in the
% R documentation directory (show via RShowDoc("KEYWORDS")):
% \keyword{ ~kwd1 }
% \keyword{ ~kwd2 }
% Use only one keyword per line.
% For non-standard keywords, use \concept instead of \keyword:
% \concept{ ~cpt1 }
% \concept{ ~cpt2 }
% Use only one concept per line.
