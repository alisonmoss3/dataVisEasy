\name{extractGaps}
\alias{extractGaps}
%- Also NEED an '\alias' for EACH other topic documented here.
\title{
Extract the Positions of Spacing from Clustered Groups
}
\description{
Very similar to \link[dataVisEasy]{extractClusters} but for the gaps that appear between the clusters when row.groups or col.groups are set in the heatmap functions. Useful in conjunction with \link[dataVisEasy]{ExtractMatrix} if spaces between the groups want to be maintained or widened without actually clustering the data. Output can be supplied to gaps.row and gaps.col in \link[dataVisEasy]{myHeatmap} or gaps.row.spec and gaps.col.spec in \link[dataVisEasy]{myHeatmapByAnnotation}
}
\usage{
extractGaps(data, heatmap, extractRows = FALSE, extractCols = TRUE,
  num_Rows = 5, num_Cols = 5)
}
%- maybe also 'usage' for other objects documented here.
\arguments{
  \item{data}{
numeric data matrix with samples/observations in the columns and genes/variables in the rows. Should be the same data supplied to the heatmap function
}
  \item{heatmap}{
Output of a heatmap generated from \link[dataVisEasy]{myHeatmap} or \link[dataVisEasy]{myHeatmapByAnnotation}.  The heatmap generated from these functions can be saved to a variable which should serve as the input here. IMPORTANT. The heatmap supplied here MUST have show.colnames and show.rownames = TRUE.
}
  \item{extractRows}{
logical. should gaps along clustered rows be extracted. At least one of extractRows and extractCols must be set to TRUE
}
  \item{extractCols}{
logical. should gaps along clustered columns be extracted. At least one of extractRows and extractCols must be set to TRUE
}
  \item{num_Rows}{
number of clusters along the rows for which the gaps should be extract. Default set to 5.
}
  \item{num_Cols}{
number of clusters along the columns for which the gaps should be extract. Default set to 5.
}
}
%\details{
%%  ~~ If necessary, more details than the description above ~~
%}
\value{
a numericvector or a list object of two numeric vectors (in a case where both rows and columns are extracted) where the positions of each gap along the rows/columns is indicated.
}
%\references{
%% ~put references to the literature/web site here ~
%}
\author{
~~Alison Moss~~
}
\note{
a similar output can be obtained from using \link[dataVisEasy]{extractClusters} where gaps would equal the cumulative sum of the frequency of each cluster from the output (cumsum(table(output)))
}

%% ~Make other sections like Warning with \section{Warning }{....} ~

\seealso{
See also \link[dataVisEasy]{extractClusters}, \link[dataVisEasy]{ExtractMatrix}
}
\examples{
##initate parameters
initiate_params()

##view heatmap with clusters separated
heatmap <- myHeatmap(RAGP_norm, row.groups = 7, col.groups = 6, show.colnames = TRUE)

##extract gaps for numeric vector of where gaps should be
gaps <- extractGaps(RAGP_norm, heatmap = heatmap, extractRows = TRUE, extractCols = TRUE,
  num_Rows = 7, num_Cols = 6)

##extract matrix, use matrix and gaps to plot heatmap with expanded space between gaps
mat <- ExtractMatrix(RAGP_norm, heatmap = heatmap)
myHeatmap(mat, clust.cols = FALSE, clust.rows = FALSE, gaps.row = gaps$Row_Groups,
  gaps.col = gaps$Col_Groups)
myHeatmap(mat, clust.cols = FALSE, clust.rows = FALSE, gaps.row = gaps$Row_Groups,
  gaps.col = gaps$Col_Groups, gap.width = 3)  ##expands all gaps by gap.width

myHeatmap(mat, clust.cols = FALSE, clust.rows = FALSE, gaps.row = sort(rep(gaps$Row_Groups,6)),
  gaps.col = sort(rep(gaps$Col_Groups,2)))  ##expands row gaps by 6 and column gaps by 2

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
