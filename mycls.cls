% mycls.cls
\ProvidesClass{mycls}[2026/03/27 My simple class]

\LoadClass{book}
\RequirePackage[fontset=fandol,heading=true]{ctex}

%%%%%%%%%
\RequirePackage{mypkg}
%%%%%%%%%

%%%%%%%%%%%%%%%

\RequirePackage{multicol}
\setlength{\columnsep}{20pt}
\setlength{\columnseprule}{.4pt}
% https://tex.stackexchange.com/a/761278
\AddToHook{cmd/chapter/before}{\ifnum\col@number>1\end{multicols}\fi\clearpage}
\AddToHook{cmd/@chapter/after}{\begin{multicols}{2}}
\AddToHook{cmd/@schapter/after}{\begin{multicols}{2}}
\AtEndDocument{\ifnum\col@number>1\end{multicols}\fi}

%%%%%%%%%%%%%%%%
\RequirePackage[
        a4paper,
        hmargin=1.75cm,
        vmargin=2.5cm,
        showframe,
    ]{geometry}

\RequirePackage{fancyhdr}
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

\usetikzlibrary{shapes.geometric,shadows,positioning}
\tikzset{line cap=round,line join=round,circlewidget/.style={circle,draw,fill=gray!75,inner sep=1.5pt}}
\newcommand\chaptertitleformat[1]{%
    \begin{tikzpicture}[
        orbit/.pic={
            \draw[line width=1pt,gray] (0,2) 
                arc[start angle=90,delta angle=360,x radius=.85cm,y radius=2cm]
                node[pos=.6,circle,fill=white,inner sep=0pt,minimum size=15pt] {}
                node[pos=.6,circle,fill=gray,inner sep=0pt,minimum size=10pt] {}
            ;
        },
        atom/.pic={\fill[##1] circle[radius=7.5pt];},
        nuclear/.pic={
            \pic{orbit};\pic[rotate=120] {orbit};\pic[rotate=-120] {orbit};
            \foreach \i in {30,150,270}{ \pic at (\i:.45) {atom=gray};}
            \foreach \i in {90,210,330}{ \pic at (\i:.45) {atom=cyan};}
            \pic {atom=gray};
        }
    ]
        \fill[rotate=45,gray!50] (1.75,0) 
            arc[start angle=0,delta angle=360,x radius=1.75cm,y radius=.7cm]
            node[circle,pos=.075,fill=white,inner sep=0pt,minimum size=15pt] {}
            node[circle,pos=.075,fill=gray!50,inner sep=0pt,minimum size=10pt] {}
            node[circle,pos=.575,fill=white,inner sep=0pt,minimum size=15pt] {}
            node[circle,pos=.575,fill=gray!50,inner sep=0pt,minimum size=10pt] {}
            ;
        \fill (-1.5,1.5) -- ++(1,0) -- ++(2,-2) -- ++(0,-1) -- ++(-1,0) -- ++(-2,2) --cycle;
        \path[every node/.style={font=\sffamily\huge,text=white}] 
              (0,0) node {\thechapter}
              (-.75,.75) node[scale=.8] {第}
              (.75,-.75) node[scale=.8] {章};
        \draw[thick] 
        (2,-.75) node[circlewidget,anchor=west] {}
        -- 
        node[pos=.01,above=10pt,outer sep=0pt,inner sep=0pt,anchor=south west,font=\sffamily\huge,scale=1.25] {#1} 
        % https://tex.stackexchange.com/a/761324
        % https://tex.stackexchange.com/a/761357
        pic[pos=.85,yshift=.75cm,scale=.75,transform shape] {nuclear}
        ++(.75\linewidth,0) node[circlewidget,anchor=west] {}
        ;
    \end{tikzpicture}%
}
\newcommand\sectiontitleformat[1]{%
    \begin{tikzpicture}[line join=round]
    \node[
        fill,rounded corners=.3cm,
        font=\sffamily\Large,text=white,
        inner sep=5pt, 
        minimum width=1.5cm, 
        minimum height=.75cm,
        general shadow={fill=gray!25,shadow scale=1.15}
    ] (sec) {\thesection};
    \coordinate (start) at ([xshift=.35cm,yshift=.35cm]sec.east);
    \draw[ultra thick,gray!75] ([xshift=-.15cm]start) -- ++(.35,-.7);
    \draw[ultra thick] (start) -- ++(.35,-.7) coordinate (tmp);
    \draw[ultra thick,gray!75] (tmp) -- 
    node[xshift=-.4cm,pos=.01,above=3pt,outer sep=0pt,inner sep=0pt,anchor=south west,font=\sffamily\large,text=black,scale=1.25] {#1} 
    ++(.725\linewidth,0) node[circlewidget,draw=black,line width=.8pt] (end) {};
    \draw[gray!25,ultra thick] ([yshift=.4cm]end.center) -- ++(-1cm,0);
    \draw[gray!75,ultra thick] ([yshift=.6cm]end.center) -- ++(-1.75cm,0);
    \draw[ultra thick] ([yshift=.8cm]end.center) -- ++(-2.5cm,0);
    \end{tikzpicture}
}
\newcommand\subsectiontitleformat[1]{%
    \begin{tikzpicture}[line join=round]
    \node[fill=black!90,rounded corners,
        font=\sffamily\Large,text=white,
        inner sep=5pt, 
    ] (subsec) {\thesubsection};
    \draw[ultra thick] (subsec) -- node[draw,pos=.05,anchor=west,font=\sffamily\large] {#1} ++(.9\linewidth,0) node[circlewidget,line width=.8pt] {};
    \end{tikzpicture}
}
\ctexset{
    chapter = {
        name = {}, 
        number = {},%这里不可用 numbering=false,将导致缺少\thechapter的定义
        format = \centering\chaptertitleformat
    },
    section = {
        name = {}, 
        number = {},
        format = \centering\sectiontitleformat
    },
    subsection = {
        name = {}, 
        number = {},
        format = \centering\subsectiontitleformat
    },
}

\newcounter{SectionPart}[chapter]
% https://tex.stackexchange.com/a/761359/322482
\newcommand\SectionPart[1]{%
    \refstepcounter{SectionPart}%
    \par\noindent\begin{tikzpicture}
    \node[shape=ellipse,fill=gray!75,font=\sffamily\huge,text=white,inner sep=5pt, minimum width=2cm, minimum height=1.25cm, circular glow={fill=gray!50,shadow scale=1.15}] at (-1,0) (ell) {\S\;\theSectionPart};
    \node[right=.75cm of ell,anchor=west,font=\sffamily\huge] {#1};
    \coordinate (ellstart) at ([xshift=.5cm,yshift=.75cm]ell.east);
    \coordinate (ellend) at ([xshift=.1cm,yshift=-.75cm]ell.east);
    \path (ellstart) 
        ++(.7\linewidth,0) coordinate (doublestart) 
        ++(-.5,-1.5) coordinate (doubleend);
    \scoped{
        \clip ([xshift=5pt]doublestart) rectangle ([xshift=-5pt]doubleend);% clip the double path
        \draw[gray!75,line width=1pt,double,double distance=2.5pt,shorten >=-2pt,shorten <=-2pt] (doublestart) .. controls ++(.25,-.75) and ++(-.3,1) .. (doubleend);
    }
    \draw[line width=1pt,gray!75] 
        (ellstart) node[circlewidget,anchor=west] {} -- ([xshift=2pt]doublestart) % details not perfect here ;-(
        ([xshift=2pt]doubleend) -- (ellend) node[circlewidget,anchor=west] {}
    ;
    \end{tikzpicture}
}

\endinput