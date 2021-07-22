%% hacett-socsci-thesis.cls --- LaTeX class for HÜ Social Sciences Theses

% The MIT License (MIT)
% Copyright © 2021 Göktuğ Kayaalp <self at gkayaalp dot com>

% Permission is hereby granted, free of charge, to any person obtaining
% a copy of this software and associated documentation files (the
% “Software”), to deal in the Software without restriction, including
% without limitation the rights to use, copy, modify, merge, publish,
% distribute, sublicense, and/or sell copies of the Software, and to
% permit persons to whom the Software is furnished to do so, subject to
% the following conditions:

% The above copyright notice and this permission notice shall be
% included in all copies or substantial portions of the Software.

% THE SOFTWARE IS PROVIDED “AS IS”, WITHOUT WARRANTY OF ANY KIND,
% EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
% MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
% NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE
% LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION
% OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION
% WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

%%% Prelude:
\NeedsTeXFormat{LaTeX2e}

\ProvidesClass{hacett-socsci-thesis}[2021/05/19 LaTeX class for Hacettepe University Institute of Social Sciences Theses]

%% base class
\LoadClass[12pt]{report}

\RequirePackage{changepage}
\RequirePackage{enumitem}
\RequirePackage{etoolbox}
\RequirePackage{fancyhdr}
\RequirePackage{footmisc}
\RequirePackage{fontspec}
\RequirePackage{geometry}
\RequirePackage{graphicx}
\RequirePackage{hyperref}
\RequirePackage[utf8]{inputenc}
\RequirePackage{microtype}
\RequirePackage{pgffor}
\RequirePackage{setspace}
\RequirePackage[explicit]{titlesec}
\RequirePackage{titling}
\RequirePackage{titlecaps}

%%% Preamble:

%% do not capitalise these in headings
%% List based on: https://apastyle.apa.org/style-grammar-guidelines/capitalization/title-case
\Addlcwords{%
  and an as at a but by for if in nor off of on or per so%
  the to up via with yet%
}

%%% Definitions:

\fancypagestyle{main}{%
  \fancyhead{}
  \fancyfoot{}
  \renewcommand{\headrulewidth}{0pt}
  \renewcommand{\footrulewidth}{0pt}
  % TODO(2021-05-19): page number should be at 1.5cm down from top
  % edge of paper
  \fancyhead[R]{\thepage}
  \onehalfspacing
  \setlength{\parindent}{0em}
  \setlength{\parskip}{1em}
}

%% keep chapter etc. pages in line with ‘main’
\fancypagestyle{plain}{\thispagestyle{main}}

% optional arg: a combination of abbrevs, tables, figs
%   keep the order
%
% mandatory args: abstract, keywords
\newcommand\HSTfrontmatter[3][]{%
  \pagenumbering{roman}
  \HSTcover
  \HSTaccept
  \HSTyay
  \HSTetik
  \HSTabstract{#2}{#3}
  \HSTtoc
  \foreach \optionalfeature in {#1} {%
    \makeatletter
    \@nameuse{HST\optionalfeature}
    \makeatother
  }
}

\newcommand\HSTmainmatter{%
  \newpage
  \pagenumbering{arabic}
}

% args: department, programme, thesis type, defense date
\newcommand\HSTinfo[4]{%
  \newcommand\HSTdept{#1}
  \newcommand\HSTprog{#2}
  \newcommand\HSTtype{#3}
  \newcommand\HSTdefdate{#4}
}

\newcommand\HSTgraddir[1]{%
  \newcommand\HSTgraddirector{#1}
}

\newcounter{HSTnumadvisors}
%args: english title, turkish title, full name
% generates \HSTadvisorsENi, \HSTadvisorsENii, ..., and
% \HSTadvisorsTRi, \HSTadvisorsTRii, ..., etc.
\newcommand\HSTaddadvisor[3]{
  \stepcounter{HSTnumadvisors}
  \makeatletter
  \@namedef{HSTadvisorsEN\roman{HSTnumadvisors}}{#1\ #3}
  \@namedef{HSTadvisorsTR\roman{HSTnumadvisors}}{#2\ #3}
  \makeatother
}

\newcounter{HSTnumjury}
%args: english title, turkish title, full name
% generates \HSTmembersENi, \HSTmemberssENii, ..., and
% \HSTmembersTRi, \HSTmembersTRii, ..., etc.
\newcommand\HSTaddjury[3]{
  \stepcounter{HSTnumjury}
  \makeatletter
  \@namedef{HSTmembersEN\roman{HSTnumjury}}{#1\ #3}
  \@namedef{HSTmembersTR\roman{HSTnumjury}}{#2\ #3}
  \makeatother
}

\newcommand\HSTcover{%
  \thispagestyle{empty}
  \setcounter{page}{0}
  \begin{center}
    \includegraphics[width=1cm]{geyik.png}\\
    Hacettepe University Graduate School Of Social Sciences\\
    Department of \HSTdept\\
    \HSTprog\ Programme
    \vfill
    {\bfseries\MakeUppercase{\thetitle}}
    \vfill
    \theauthor
    \vfill
    \HSTtype\ Thesis
    \vfill
    Ankara, \thedate
  \end{center}
  \newpage
  %% the inner cover
  \thispagestyle{empty}
  \setcounter{page}{0}
  \begin{center}
    \vspace*{10em}
    \theauthor
    \vfill
    Hacettepe University Graduate School Of Social Sciences\\
    Department of \HSTdept\\
    \HSTprog\ Programme
    \vfill
    {\bfseries\MakeUppercase{\thetitle}}
    \vfill
    \theauthor
    \vfill
    \HSTtype\ Thesis
    \vfill
    Ankara, \thedate
  \end{center}
}

% args: phantom chapter title
%
% do not use for content chapters, this is a helper for front matter
% and end matter.
\newcommand\HSTphantomchapter[1]{%
  \newpage
  \phantomsection
  \begin{center}
    {\bfseries\large #1}
  \end{center}
  \addcontentsline{toc}{chapter}{#1}
}

\newcommand\HSTaccept{%
  \HSTphantomchapter{ACCEPTANCE AND APPROVAL}

  The jury finds that \theauthor\ has on the date of
  \HSTdefdate\ successfully passed the defense examination and
  approves his/her \HSTtype\ Thesis titled ``\thetitle''.
  \vfill
  \begin{adjustwidth}{5cm}{}
    \par\noindent\rule{\linewidth}{0.4pt}
    \HSTmembersENi\ (Jury President)
    \vfill
    \par\noindent\rule{\linewidth}{0.4pt}
    \HSTadvisorsENi\ (Main Advisor)
    \makeatletter
    \newcounter{nummems}
    \stepcounter{nummems} % first one is president, skip
    \@whilenum\value{nummems}<\value{HSTnumjury}\do{%
      \vfill
      \par\noindent\rule{\linewidth}{0.4pt}
      \stepcounter{nummems}
      \@nameuse{HSTmembersEN\roman{nummems}}
    }
    \makeatother
  \end{adjustwidth}
  \vfill
  I agree that the signatures above belong to the faculty members listed.
  \vfill
  \begin{center}
    \HSTgraddirector\\
    Graduate School Director
  \end{center}
}

\newcommand\HSTyay{%
  \singlespacing
  \HSTphantomchapter{YAYIMLAMA VE FİKRİ MÜLKİYET HAKLARI BEYANI}

  Enstitü tarafından onaylanan lisansüstü tezimin/raporumun tamamını
  veya herhangi bir kısmını, basılı (kağıt) ve elektronik formatta
  arşivleme ve aşağıda verilen koşullarla kullanıma açma iznini
  Hacettepe Üniversitesine verdiğimi bildiririm. Bu izinle
  Üniversiteye verilen kullanım hakları dışındaki tüm fikri mülkiyet
  haklarım bende kalacak, tezimin tamamının ya da bir bölümünün
  gelecekteki çalışmalarda (makale, kitap, lisans ve patent vb.)
  kullanım hakları bana ait olacaktır.

  Tezin kendi orijinal çalışmam olduğunu, başkalarının haklarını ihlal
  etmediğimi ve tezimin tek yetkili sahibi olduğumu beyan ve taahhüt
  ederim. Tezimde yer alan telif hakkı bulunan ve sahiplerinden yazılı
  izin alınarak kullanılması zorunlu metinlerin yazılı izin alınarak
  kullandığımı ve istenildiğinde suretlerini Üniversiteye teslim
  etmeyi taahhüt ederim.

  Yükseköğretim Kurulu tarafından yayınlanan {\it\bf “Lisansüstü
    Tezlerin Elektronik Ortamda Toplanması, Düzenlenmesi ve Erişime
    Açılmasına İlişkin Yönerge”} kapsamında tezim aşağıda belirtilen
  koşullar haricince YÖK Ulusal Tez Merkezi / H.Ü. Kütüphaneleri Açık
  Erişim Sisteminde erişime açılır.

  \begin{itemize}[leftmargin=2.5cm]

  \item[o] Enstitü / Fakülte yönetim kurulu kararı ile tezimin erişime
    açılması mezuniyet tarihimden itibaren 2 yıl
    ertelenmiştir. \textsuperscript{(1)}

  \item[o] Enstitü / Fakülte yönetim kurulunun gerekçeli kararı ile
    tezimin erişime açılması mezuniyet tarihimden itibaren ... ay
    ertelenmiştir. \textsuperscript{(2)}

  \item[o] Tezimle ilgili gizlilik kararı
    verilmiştir. \textsuperscript{(3)}

  \end{itemize}

  \begin{adjustwidth}{10cm}{}
    \begin{center}
      ……/………/…… \\
      \vspace*{1em}
      {[İmza]}\\
      \vspace*{1em}
      {\bf\theauthor}
    \end{center}
  \end{adjustwidth}

  {\scriptsize\it\singlespacing “Lisansüstü Tezlerin Elektronik Ortamda
    Toplanması, Düzenlenmesi ve Erişime Açılmasına İlişkin Yönerge”

    \begin{adjustwidth}{0.5cm}{}
      \begin{itemize}
      \item[(1)] Madde 6. 1. Lisansüstü tezle ilgili patent başvurusu
        yapılması veya patent alma sürecinin devam etmesi durumunda,
        tez {\bf danışmanının} önerisi ve {\bf enstitü anabilim
          dalının} uygun görüşü üzerine {\bf enstitü} veya {\bf
          fakülte yönetim kurulu} iki yıl süre ile tezin erişime
        açılmasının ertelenmesine karar verebilir.
      \item[(2)] Madde 6. 2. Yeni teknik, materyal ve metotların
        kullanıldığı, henüz makaleye dönüşmemiş veya patent gibi
        yöntemlerle korunmamış ve internetten paylaşılması durumunda
        3. şahıslara veya kurumlara haksız kazanç imkanı
        oluşturabilecek bilgi ve bulguları içeren tezler hakkında tez
        {\bf danışmanının} önerisi ve {\bf enstitü anabilim dalının}
        uygun görüşü üzerine {\bf enstitü} veya {\bf fakülte yönetim
          kurulunun} gerekçeli kararı ile altı ayı aşmamak üzere tezin
        erişime açılması engellenebilir.
      \item[(3)] Madde 7. 1. Ulusal çıkarları veya güvenliği
        ilgilendiren, emniyet, istihbarat, savunma ve güvenlik, sağlık
        vb. konulara ilişkin lisansüstü tezlerle ilgili gizlilik
        kararı, {\bf tezin yapıldığı kurum} tarafından
        verilir\textsuperscript{*}. Kurum ve kuruluşlarla yapılan
        işbirliği protokolü çerçevesinde hazırlanan lisansüstü tezlere
        ilişkin gizlilik kararı ise, {\bf ilgili kurum ve kuruluşun
          önerisi ile enstitü} veya {\bf fakültenin} uygun görüşü
        üzerine {\bf üniversite yönetim kurulu} tarafından
        verilir. Gizlilik kararı verilen tezler Yükseköğretim Kuruluna
        bildirilir.  Madde 7.2. Gizlilik kararı verilen tezler
        gizlilik süresince enstitü veya fakülte tarafından gizlilik
        kuralları çerçevesinde muhafaza edilir, gizlilik kararının
        kaldırılması halinde Tez Otomasyon Sistemine yüklenir
        \begin{itemize}
        \item[*] Tez {\bf danışmanının} önerisi ve {\bf enstitü
            anabilim dalının} uygun görüşü üzerine {\bf enstitü} veya
          {\bf fakülte yönetim kurulu tarafından karar verilir}.
        \end{itemize}
      \end{itemize}
    \end{adjustwidth}
  }
  \onehalfspacing
}

\newcommand\HSTetik{%
  \HSTphantomchapter{ETİK BEYAN}

  Bu çalışmadaki bütün bilgi ve belgeleri akademik kurallar
  çerçevesinde elde ettiğimi, görsel, işitsel ve yazılı tüm bilgi ve
  sonuçları bilimsel ahlak kurallarına uygun olarak sunduğumu,
  kullandığım verilerde herhangi bir tahrifat yapmadığımı,
  yararlandığım kaynaklara bilimsel normlara uygun olarak atıfta
  bulunduğumu, tezimin kaynak gösterilen durumlar dışında özgün
  olduğunu, {\bf \HSTadvisorsTRi} danışmanlığında tarafımdan
  üretildiğini ve Hacettepe Üniversitesi Sosyal Bilimler Enstitüsü Tez
  Yazım Yönergesine göre yazıldığını beyan ederim.

  \vspace*{3em}

  \hspace*{\fill}{[İmza]}

  \hspace*{\fill}{\bf \theauthor}
}

% args: name, surname (will be capitalised}
\newcommand\HSTauthor[2]{%
  \newcommand\HSTauthorfirstname{#1}
  \newcommand\HSTauthorlastname{\MakeUppercase{#2}}
  \author{#1 #2}
}

% args: abstract in English, keywords
\newcommand\HSTabstract[2]{%
  \HSTphantomchapter{ABSTRACT}

  \HSTauthorlastname, \HSTauthorfirstname. {\it \thetitle}, \HSTtype\
  Thesis, Ankara, \thedate.

  #1

  {\bf Keywords}

  #2
}

\newcommand\HSTtoc{%
  \HSTphantomchapter{CONTENTS}
  \singlespacing
  \renewcommand{\contentsname}{}
  \patchcmd{\tableofcontents}{\chapter*}{}{}{}
  \tableofcontents
  \onehalfspacing
}

\newcommand\HSTabbrevs{%
  \HSTphantomchapter{ABBREVIATIONS}
}
\newcommand\HSTtables{%
  \HSTphantomchapter{TABLES}
}
\newcommand\HSTfigs{%
  \HSTphantomchapter{FIGURES}
}

\newcommand\HSTpreface{
  \HSTphantomchapter{PREFACE}
}

\newcommand\HSTintro{
  \HSTphantomchapter{INTRODUCTION}
}

\newcommand\HSTconcl{
  \HSTphantomchapter{CONCLUSION}
}


\newcommand\HSTbib{%
  \singlespacing
  \HSTphantomchapter{BIBLIOGRAPHY}
  \defbibheading{bibliography}{} %% override
  \printbibliography
  \onehalfspacing
}

%%% Modify environments:

\AtBeginEnvironment{quote}{%
  \singlespacing
  \footnotesize
}

%% «Long quotes must be indented 1cm from the main text both from the
%% left and right margins.»
\patchcmd{\quote}{\rightmargin}{\leftmargin 1cm \rightmargin}{}{}

%%% Titling:

\titleformat{\chapter}[display]
  {\large\bfseries}{\filcenter\MakeUppercase\chaptertitlename\ \thechapter}
  {14pt}{\filcenter\large\MakeUppercase{#1}}

\titleformat{\section}[block]
  {\bfseries}{\thesection\ \MakeUppercase{#1}}
  {1.5em}{}
\titlespacing*{\section}{1cm}{2em}{1.5em}{}

\titleformat{\subsection}[block]
  {\bfseries}{\thesubsection\ \titlecap{#1}}
  {1.5em}{}
\titlespacing*{\subsection}{1cm}{2em}{1.5em}{}

\titleformat{\subsubsection}[block]
  {}{\thesubsubsection\ \titlecap{#1}}
  {1.5em}{}
\titlespacing*{\subsubsection}{0cm}{2em}{1.5em}{}

%%% Setup:

\geometry{a4paper,left=4cm,right=2cm,top=3cm,bottom=3cm}
\pagestyle{main}

\setromanfont{TeX Gyre Termes}
\setsansfont{TeX Gyre Heros}
\setmonofont{TeX Gyre Cursor}

% include subsubsection in numbering and ToC
\setcounter{secnumdepth}{3}
\setcounter{tocdepth}{3}
