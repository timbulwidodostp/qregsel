{smcl}
{* *! version 1.2 March 2021}{...}
{cmd:help qregsel}{right: ({browse "https://doi.org/10.1177/1536867X211063148":SJ21-4: st0657})}
{hline}

{marker title}{...}
{title:Title}

{p2colset 5 16 18 2}{...}
{p2col:{cmd:qregsel} {hline 2}}Quantile regression corrected for sample
selection{p_end}
{p2colreset}{...}


{title:Syntax}

{p 8 17 2}
{cmd:qregsel}
{it:depvar} {it:indepvars}
{ifin}{cmd:,}
{cmdab:sel:ect(}[{it:depvar_s} {cmd:=}] {it:varlist_s}{cmd:)}
{cmd:quantile(}{it:#} [{it:#} [{it:#} ...]]{cmd:)}
[{it:options}]

{synoptset 32 tabbed}{...}
{synopthdr}
{synoptline}
{p2coldent:* {cmdab:sel:ect(}[{it:depvar_s} {cmd:=}] {it:varlist_s}{cmd:)}}specify a selection equation{p_end}
{p2coldent:* {opt quantile(# [# [# ...]])}}specify the quantiles to be estimated{p_end}
{synopt:{opt copula(copula)}}specify a copula; default is {cmd:copula(gaussian)}{p_end}
{synopt:{opt nocons:tant}}suppress a constant term in the outcome equation{p_end}
{synopt:{opt finergrid}}find the value of the copula parameter using a grid of 199 values instead of 100, as done by default{p_end}
{synopt:{opt coarsergrid}}find the value of the copula parameter using a grid of 50 values instead of 100, as done by default{p_end}
{synopt:{opt rescale}}rescale the regressors in the outcome equation{p_end}
{synopt:{opt nodots}}suppress progress dots{p_end}
{synoptline}
{pstd}
* {cmd:select()} and {cmd:quantile()} are required.


{title:Description}

{pstd}
{cmd:qregsel} estimates a copula-based sample-selection model for quantile
regression.  Available copulas are {cmd:gaussian} and {cmd:frank}.  (Note that
the name of the copula is case sensitive.) 


{title:Options}

{phang}
{cmd:select(}[{it:depvar_s} {cmd:=}] {it:varlist_s}{cmd:)} specifies a
selection equation.  If {it:depvar_s} is specified, it should be coded as 0 or
1, with 0 indicating an outcome not observed for an observation and 1
indicating an outcome observed for an observation.  {cmd:select()} is
required.

{phang} 
{opt quantile(# [# [# ...]])} specifies the quantiles to be estimated and
should contain numbers between 0 and 1, exclusive.  Numbers larger than 1 are
interpreted as percentages.  {cmd:quantile()} is required.

{phang}
{opt copula(copula)} specifies a copula function governing the dependence
between the errors in the outcome equation and the selection equation.
{it:copula} may be {cmd:gaussian} or {cmd:frank}.  The default is
{cmd:copula(gaussian)}.

{phang}
{opt noconstant} suppresses the constant term in the outcome equation.

{phang}
{opt finergrid} finds the value of the copula parameter by using a grid of 199
values (values such that the Spearman rank correlation is approximately
[-0.99, -0.985, ..., 0.985, 0.99]) instead of 100 (values such that the
Spearman rank correlation is approximately [-0.99, -0.98, ..., 0.98, 0.99]),
as done by default.

{phang}
{opt coarsergrid} finds the value of the copula parameter by using a grid of
50 values (values such that the Spearman rank correlation is approximately
[-0.99, -0.95, ..., 0.93, 0.97]) instead of 100 (values such that the Spearman
rank correlation is approximately [-0.99, -0.98, ..., 0.98, 0.99]), as done by
default.

{phang}
{opt rescale} transforms the independent variables in the outcome equation by
subtracting from each its sample mean and dividing each by its standard
deviation.

{phang}
{cmd:nodots} suppresses progress dots that indicate status over the grid
search.


{title:Postestimation}

{pstd}
After the execution of {cmd:qregsel}, the {cmd:predict} command is available
to compute a counterfactual of the outcome variable corrected for sample
selection.  The syntax is

{p 8 15 2}
{cmd:predict} {it:newvarlist}

{pstd}
where {it:newvarlist} must contain two new variable names: the first one for
the counterfactual outcome variable and the second one for a binary indicator
of selection.


{title:Example}

{phang}
{cmd:. webuse womenwk}{p_end}
{phang}
{cmd:. qregsel wage educ age, select(married children educ age) quantile(.1 .5 .9)}{p_end}
{phang}
{cmd:. ereturn list}{p_end}
{phang}
{cmd:. predict wage_hat participation}


{title:Stored results}

{pstd}
{cmd:qregsel} stores the following in {cmd:e()}:

{synoptset 20 tabbed}{...}
{p2col 5 20 24 2: Scalars}{p_end}
{synopt:{cmd:e(N)}}number of observations{p_end}
{synopt:{cmd:e(N_selected)}}number of selected observations{p_end}
{synopt:{cmd:e(rho)}}copula parameter{p_end}
{synopt:{cmd:e(kendall)}}Kendall's tau{p_end}
{synopt:{cmd:e(spearman)}}Spearman's rank correlation{p_end}

{synoptset 20 tabbed}{...}
{p2col 5 20 24 2: Macros}{p_end}
{synopt:{cmd:e(cmd)}}{cmd:qregsel}{p_end}
{synopt:{cmd:e(cmdline)}}command as typed{p_end}
{synopt:{cmd:e(depvar)}}name of dependent variable{p_end}
{synopt:{cmd:e(indepvar)}}independent variables{p_end}
{synopt:{cmd:e(title)}}title in estimation output{p_end}
{synopt:{cmd:e(copula)}}specified {cmd:copula()}{p_end}
{synopt:{cmd:e(outcome_eq)}}outcome equation{p_end}
{synopt:{cmd:e(select_eq)}}selection equation{p_end}
{synopt:{cmd:e(rescale)}}use of the {cmd:rescale} option{p_end}
{synopt:{cmd:e(properties)}}{cmd:b}{p_end}
{synopt:{cmd:e(predict)}}program used to implement {cmd:predict}{p_end}

{synoptset 20 tabbed}{...}
{p2col 5 20 24 2: Matrices}{p_end}
{synopt:{cmd:e(b)}}coefficient vector{p_end}
{synopt:{cmd:e(grid)}}matrix with the values of the objective function for each value of rho and its respective Spearman rank correlation and Kendall's tau{p_end}
{synopt:{cmd:e(coefs)}}coefficient matrix; each column corresponds to the coefficients for a quantile{p_end}

{synoptset 20 tabbed}{...}
{p2col 5 20 24 2: Functions}{p_end}
{synopt:{cmd:e(sample)}}marks estimation sample{p_end}
{p2colreset}{...}


{title:Authors}

{pstd}
Ercio Mu{c n~}oz{break}
CUNY Graduate Center{break}
New York, NY{break}
{browse "mailto:emunozsaavedra@gc.cuny.edu":emunozsaavedra@gc.cuny.edu}

{pstd}
Mariel Siravegna{break}
Georgetown University{break}
Washington, DC{break}
{browse "mailto:mcs92@georgetown.edu":mcs92@georgetown.edu}


{title:Also see}

{p 4 14 2}
Article:  {it:Stata Journal}, volume 21, number 4: {browse "https://doi.org/10.1177/1536867X211063148":st0657}{p_end}

{p 7 14 2}
Help:  {manhelp heckman R}, {manhelp qreg R},
{helpb heckmancopula} (if installed){p_end}
