\name{volcano}
\alias{volcano}
%- Also NEED an '\alias' for EACH other topic documented here.
\title{
Volcano Plot Comparing Two Groups of Data
}
\description{
Creates a volcano plot for the data provided showing up and downregulation of genes between the groups specified.
}
\usage{
volcano(data, groups, levels = NULL, is.log2 = TRUE, pval.cut = 0.05,
  FC.cut = 2, return.summary = FALSE, downreg.color = "green",
  upreg.color = "red", nosig.color = "gray", show.genes = NULL,
  point.size = 2, transparency = 1, legend.position = "right",
  return.ggplot.input = FALSE)
}
%- maybe also 'usage' for other objects documented here.
\arguments{
  \item{data}{
numeric data matrix with samples/observations in the columns and genes/variables in the rows
}
  \item{groups}{
The annotations for the samples in question. There are two options in how to specify this annotation. One option is to provide a string pointing to an annotation in the annotations dataframe stored in the params list object. The other option is to provide a vector the same length as the number of samples in the input data where the annotations of the vector correspond to the colnames of the data in that order.
}
  \item{levels}{
levels of the comparison. A character vector of length 2. The first item will be considered the baseline level and values in the volcano plot will reflect expression of samples in level 2 with respect to level 1. If input vector of groups (whether it be a custom vector or pointing to the annotations dataframe stored in the params list object) has more than 2 levels, data will be subset for the levels provided.
}
  \item{is.log2}{
logical: Is the data already in log2 space? If FALSE, will take adjust accordingly when calculating Fold Change
}
  \item{pval.cut}{
pvalue below which genes will be considered statistically significant
}
  \item{FC.cut}{
absolute value of the fold change threshold (will be converted to log2 space within the function), above which genes will be considered to have a significant fold change.
}
  \item{return.summary}{
logial: If true will return a summary of the results, see 'value' for more details
}
  \item{downreg.color}{
color for downregulated genes whole p values are below the pval.cut and whose fold changes are below -FC.cut
}
  \item{upreg.color}{
color for upregulated genes whole p values are below the pval.cut and whose fold changes are above FC.cut
}
  \item{nosig.color}{
color for genes with no significance according to the pval.cut and FC.cut thresholds specified
}
  \item{show.genes}{
a list of specific gene names that can optionally be added as text to the plot (see value and examples)
}
  \item{point.size}{
size of points to be plotted
}
  \item{transparency}{
transparency or alpha value of the points
}
  \item{legend.position}{
should the legend be shown and if so where should it be placed
}
  \item{return.ggplot.input}{
logical. If true, will return the input dataframe to the ggplot object. Useful if more customization is required.
}
}
\details{
A standard volcano plot where the pvalues between levels of groups are calculated using a ttest and the fold changes are calculated using the differences of the estimates
}
\value{
if return.summary == FALSE
  A ggplot object. Within the ggplot object are additional options that allow the user to add the text of gene names to the plot (see examples, these are specifically designed to be added outside the function itself for proper positioning). These options include all genes, significant genes, or a custom set of genes specified using show.genes. Additional layers can be added to the returned ggplot object to further customize theme and aesthetics.

if return.summary == TRUE
  A dataframe with genes in the rows and four columns

\item{'LFC'}{the log2 fold change(the x axis of the volcano plot)}
\item{'FoldChange'}{the fold change}
\item{'pvals'}{pvalues}
\item{'-log10pvals'}{-log10 of the p values (y axis of the volcano plot)}

If return.ggplot.input is set to TRUE, will return a list with the dataframe and call to ggplot for plotting.
\item{'input_data'}{the dataframe used for plotting which will contain the expression levels of the chosen genes (if values are squished to fit the plot the values will be similarly squished) as well as the annotations if available.}
\item{plot_call}{the call to ggplot that generated the plot. Note that simply accessing it by $plot_call will include escape characters. The full call can be accessed by cat(plot$plot_call). Please note that many of the parameters (those in lowercase) in the call are input parameters to the original function and must be input to properly recreate the plot.}
}
%\references{
%% ~put references to the literature/web site here ~
%}
\author{
~~Alison Moss~~
}
\note{
the returned ggplot object also contains the names of the genes for each point. If printing the names of the genes is desired, add '+ geom_text(aes(label=Gene))' at the end of the function argument. See \link[ggplot2]{geom_text} for more information on the position of the text sing nudge_x and nudge_y (see examples). Additionally, lines may be added to the plot using geom_hline and geom_vline (see examples)
}

%% ~Make other sections like Warning with \section{Warning }{....} ~

\seealso{
For more information on customizing the returned ggplot object, please see ggplot2 helpfiles, specifically those related to setting the theme.

See \link[dataVisEasy]{params}, \link[dataVisEasy]{set_annotations}, and \link[dataVisEasy]{set_annot_cols} for more information on setting up annotations and associated colors.
}
\examples{
##initiate parameters and annotations
initiate_params()
set_annotations(RAGP_annots)


####Volcano Plot
volcano(RAGP_norm, "Sex")
volcano(RAGP_norm, "Connectivity", levels = c("Non-SAN-Projecting","SAN-Projecting"))
volcano(RAGP_norm, "Connectivity", levels = c("Non-SAN-Projecting","SAN-Projecting"),
  pval.cut = 0.1, FC.cut = 1.5,upreg.color = "yellow", downreg.color = "blue",
  nosig.color = "grey90")

###add things to ggplot object
volcano(RAGP_norm, "Connectivity", levels = c("Non-SAN-Projecting","SAN-Projecting")) +
  geom_text(aes(label=Gene),nudge_x = 0.1, nudge_y = -.1)

volcano(RAGP_norm, "Connectivity", levels = c("Non-SAN-Projecting","SAN-Projecting")) +
  geom_text(aes(label=Sig.Genes),nudge_x = 0.5, nudge_y = -.5)

##if show.genes is specified
volcano(RAGP_norm, "Connectivity", levels = c("Non-SAN-Projecting","SAN-Projecting"),
  show.genes = c("Th","Chat","NeuN","Gal","Sst")) + geom_text(aes(label=My.Genes),
  nudge_x = 0.1, nudge_y = -.1)

##add lines
horiz.lines <- c(0.05)
vert.lines <- c(2,3)

volcano(RAGP_norm, "Connectivity", levels = c("Non-SAN-Projecting","SAN-Projecting")) +
  geom_hline(yintercept = c(-log10(horiz.lines))) +
  geom_vline(xintercept = c(log2(vert.lines), -log2(vert.lines)))

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
