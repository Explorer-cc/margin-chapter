% mycls.cls
\ProvidesClass{mycls}[2026/03/27 My simple class]

\LoadClass{book}
\RequirePackage[fontset=fandol,heading=true]{ctex}

%%%%%%%%%
\RequirePackage{mypkg}
%%%%%%%%%

%%%%%%%%%%%%%%%

\usepackage{multicol}
\setlength{\columnsep}{20pt}
\setlength{\columnseprule}{.4pt}
% https://tex.stackexchange.com/a/761278
\AddToHook{cmd/chapter/before}{\ifnum\col@number>1\end{multicols}\fi\clearpage}
\AddToHook{cmd/@chapter/after}{\begin{multicols}{2}}
\AddToHook{cmd/@schapter/after}{\begin{multicols}{2}}
\AtEndDocument{\ifnum\col@number>1\end{multicols}\fi}

%%%%%%%%%%%%%%%%
\usepackage[
        a4paper,
        hmargin=1.75cm,
        vmargin=2.5cm,
        showframe,
    ]{geometry}

\usepackage{fancyhdr}
\fancypagestyle{fancy}{%
    \fancyhead[LE,RO]{\thepage}
    \fancyhead[LO,RE]{\textsl{\leftmark}}
    \fancyfoot[L,C,R]{} 
    % \renewcommand{\headrulewidth}{0.4pt} 
    % \renewcommand{\footrulewidth}{2pt}
}
\fancypagestyle{plain}[fancy]{} % set plain in \chapter style as faccy, to show the header
\pagestyle{fancy}

%%%%%%%%%%%%%%%%%%%%%




\endinput