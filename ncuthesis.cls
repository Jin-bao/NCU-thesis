%%
%% 这是 `ncuthesis.cls' 文件
%% 
%% 南昌大学非官方的学位 (毕业) 论文 LaTeX 模板
%%
%% 仓库在 https://github.com/Jin-bao/NCU-thesis
%%
%%
%% 模板结构:
%% ncuthesis.cls
%%   bachelor.clo
%%     *.def
%%   academic.clo
%%     *.def
%%   professional.clo
%%     *.def
%%
%%
\NeedsTeXFormat{LaTeX2e}[1995/12/01]
\ProvidesClass{ncuthesis}[2023/1/25 v0.1a Nanchang University LaTeX thesis template]
%%
%% 必要的开发包
\RequirePackage{iftex}
\RequireXeTeX
\RequirePackage{etoolbox}
\RequirePackage{kvoptions}
\SetupKeyvalOptions{family=ncu,prefix=ncu@,setkeys=\kvsetkeys}
\newcommand\ncu@kv[1]{\kvsetkeys{ncu}{#1}}
%%
%% 警告和报错
\newcommand\ncu@warning[1]{\ClassWarning{ncuthesis}{#1}{}}
\newcommand\ncu@error[1]{\ClassError{ncuthesis}{#1}{}}
%%
%% 选项声明
\DeclareStringOption[academic]{type}
\DeclareStringOption[adjusted]{format}
\DeclareStringOption[draft]{doc}
\DeclareStringOption[bibtex]{bib}
\DeclareVoidOption{bachelor}{\ncu@kv{type=bachelor}}
\DeclareVoidOption{academic}{\ncu@kv{type=academic}}
\DeclareVoidOption{professional}{\ncu@kv{type=professional}}
\DeclareVoidOption{adjusted}{\ncu@kv{format=adjusted}}
\DeclareVoidOption{ncu}{\ncu@kv{format=ncu}}
\DeclareVoidOption{draft}{\ncu@kv{doc=draft}}
\DeclareVoidOption{final}{\ncu@kv{doc=final}}
\DeclareVoidOption{bibtex}{\ncu@kv{bib=bibtex}}
\DeclareVoidOption{biblatex}{\ncu@kv{bib=biblatex}}
\DeclareDefaultOption{\PassOptionsToClass{\CurrentOption}{book}}
\ProcessKeyvalOptions*\relax
%%
%% 报错和警告处理
\ifdefstring{\ncu@type}{bachelor}{}
  {\ifdefstring{\ncu@type}{academic}{}
    {\ifdefstring{\ncu@type}{professional}{}
      {\ncu@error{option `type' can only be set to `bachelor', `academic' or `professional'}}}}
\ifdefstring{\ncu@format}{adjusted}{}
  {\ifdefstring{\ncu@format}{ncu}{}
    {\ncu@warning{option `format=\ncu@format' is invalid and will be set to `format=adjusted'}}}
\ifdefstring{\ncu@doc}{draft}{}
  {\ifdefstring{\ncu@doc}{final}{}
    {\ncu@warning{option `doc=\ncu@doc' is invalid and will be set to `doc=draft'}}}
\ifdefstring{\ncu@bib}{bibtex}{}
  {\ifdefstring{\ncu@bib}{biblatex}{}
    {\ncu@warning{option `bib=\ncu@bib' is invalid and will be set to `bib=bibtex'}}}
%%
\newcommand\@draft{%
  \PassOptionsToClass{draft}{book}%
  \PassOptionsToPackage{showframe}{geometry}%
  \PassOptionsToPackage{draft}{graphicx}}%
\newcommand\@final{%
  \PassOptionsToClass{final}{book}%
  \PassOptionsToPackage{final}{graphicx}}
\ifdefstring{\ncu@doc}{draft}
  {\@draft}
  {\ifdefstring{\ncu@doc}{final}
    {\@final}
    {\@draft}}
%%
\newcommand\@bachelor{\input{./resources/bachelor.clo}}
\newcommand\@academic{\input{./resources/academic.clo}}
\newcommand\@professional{\input{./resources/professional.clo}}
\ifdefstring{\ncu@type}{bachelor}
  {\@bachelor}
  {\ifdefstring{\ncu@type}{academic}
    {\@academic}
    {\ifdefstring{\ncu@type}{professional}
      {\@professional}
      {\@academic}}}
%%
%%
\endinput
%% `ncuthesis.cls' 文件结束
%%