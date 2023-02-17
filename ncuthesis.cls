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
\NeedsTeXFormat {LaTeX2e} [1995/12/01]
\ProvidesExplClass {ncuthesis} {2023/02/16} {0.2} {Nanchang University LaTeX thesis template}
\RequirePackage {l3keys2e}
%%
%% 引擎判断
\msg_new:nnn {ncuthesis} {unsupported-engine} {
  The~ncuthesis~class~requires~either~XeTeX~or~LuaTeX.~"#1"~is~not~supported~at~present.~You~must~change~your~typesetting~engine~to~"xelatex"~or~"lualatex".
}
\sys_if_engine_xetex:F {
  \sys_if_engine_luatex:F {
    \msg_fatal:nnx {ncuthesis} {unsupported-engine} {\c_sys_engine_str}
  }
}
%%
%% 前面的准备
\cs_new:Npn \__ncu_msg_new:nn  {\msg_new:nnn       {ncuthesis}}
\cs_new:Npn \__ncu_warning:n   {\msg_warning:nn    {ncuthesis}}
\cs_new:Npn \__ncu_warning:nn  {\msg_warning:nnn   {ncuthesis}}
\cs_new:Npn \__ncu_warning:nnn {\msg_warning:nnnn  {ncuthesis}}
\cs_new:Npn \__ncu_error:n     {\msg_error:nn      {ncuthesis}}
\cs_new:Npn \__ncu_error:nn    {\msg_error:nnn     {ncuthesis}}
\cs_new:Npn \__ncu_error:nnn   {\msg_error:nnnn    {ncuthesis}}
%%
% \cs_generate_variant:Nn \str_count_ignore_spaces:n {V}
\cs_new:Npn \__symbol:n #1 {\tex_char:D #1 \scan_stop:}
%%
\__ncu_msg_new:nn {unknown-option}
  {Unknown~option:~\l_keys_key_str.}
\__ncu_msg_new:nn {unknown-option-value}
  {Option~`\l_keys_key_str=\l_keys_value_tl'~is~unknown~and~will~be~set~to~`#1'.}
\__ncu_msg_new:nn {no-info} {No~#1~(#2)~given.}
\__ncu_msg_new:nn {unknown-info}
  {Unknown~information~key:~\l_keys_key_str.}
\__ncu_msg_new:nn {unknown-info-value}
  {Info~`\l_keys_key_str=\l_keys_value_tl'~is~unknown~and~will~be~set~to~`#1'.}
\__ncu_msg_new:nn {unknown-style}
  {Unknown~style~key:~\l_keys_key_str.}
\__ncu_msg_new:nn {unknown-style-value}
  {Style~`\l_keys_key_str=\l_keys_value_tl'~is~unknown~and~will~be~set~to~`#1'.}
\__ncu_msg_new:nn {unknown-key}
  {Unknown~key:~\l_keys_key_str.}
%%
%% 模板选项
%% 学位类型
\str_new:N \g__ncu_type_str
%% 稿件状态
\tl_new:N \g__ncu_doc_tl
\tl_new:N \g__ncu_doc_draft_tl
\tl_new:N \g__ncu_doc_final_tl
\tl_gset:Nn \g__ncu_doc_draft_tl {draft}
\tl_gset:Nn \g__ncu_doc_final_tl {final}
%% 论文格式
\tl_new:N \g__ncu_format_tl
\tl_new:N \g__ncu_format_adjusted_tl
\tl_new:N \g__ncu_format_ncu_tl
\tl_gset:Nn \g__ncu_format_adjusted_tl {adjusted}
\tl_gset:Nn \g__ncu_format_ncu_tl {ncu}
%% 参考文献
\tl_new:N \g__ncu_bib_tl
\tl_new:N \g__ncu_bib_bibtex_tl
\tl_new:N \g__ncu_bib_biblatex_tl
\tl_gset:Nn \g__ncu_bib_bibtex_tl {bibtex}
\tl_gset:Nn \g__ncu_bib_biblatex_tl {biblatex}
%% 新环境和新命令
\bool_new:N \g__ncu_newenv_bool
\bool_new:N \g__ncu_newcmd_bool
\bool_gset_false:N \g__ncu_newenv_bool
\bool_gset_false:N \g__ncu_newcmd_bool
%% 键值定义
\keys_define:nn {ncu/option} {
  type .choice:,
  type .value_required:n = true,
  type .choices:nn =
    {academic, professional, bachelor}
    {\str_gset:NV \g__ncu_type_str \l_keys_choice_tl},
  type .initial:n = {academic},
  type/unknown .code:n = 
    {\__ncu_warning:nn {unknown-option-value}{type=bachelor}},
  academic .code:n = {\str_gset:Nn \g__ncu_type_str {academic}},
  academic .value_forbidden:n = true,
  professional .code:n = {\str_gset:Nn \g__ncu_type_str {professional}},
  professional .value_forbidden:n = true,
  bachelor .code:n = {\str_gset:Nn \g__ncu_type_str {bachelor}},
  bachelor .value_forbidden:n = true,
  doc .choice:,
  doc .value_required:n = true,
  doc .choices:nn =
    {draft, final}
    {\tl_gset:NV \g__ncu_doc_tl \l_keys_choice_tl},
  doc .initial:n = {draft},
  doc/unknown .code:n = {\__ncu_warning:nn {unknown-option-value}{doc=draft}},
  draft .code:n = {\tl_gset:Nn \g__ncu_doc_tl {draft}},
  final .code:n = {\tl_gset:Nn \g__ncu_doc_tl {final}},
  format .choice:,
  format .value_required:n = true,
  format .choices:nn =
    {adjusted, ncu}
    {\tl_gset:NV \g__ncu_format_tl \l_keys_choice_tl},
  format .initial:n = {adjusted},
  format/unknown .code:n = 
    {\__ncu_warning:nn {unknown-option-value}{format=adjusted}},
  adjusted .code:n = {\tl_gset:Nn \g__ncu_format_tl {adjusted}},
  ncu .code:n = {\tl_gset:Nn \g__ncu_format_tl {ncu}},
  bib .choice:,
  bib .value_required:n = true,
  bib .choices:nn =
    {bibtex, biblatex}
    {\tl_gset:NV \g__ncu_bib_tl \l_keys_choice_tl},
  bib .initial:n = {bibtex},
  bib/unknown .code:n = {\__ncu_warning:nn {unknown-option-value}{bib=bibtex}},
  bibtex .code:n = {\tl_gset:NV \g__ncu_bib_tl {bibtex}},
  biblatex .code:n = {\tl_gset:NV \g__ncu_bib_tl {biblatex}},
  newenv .choice:,
  newenv/true  .code:n = {\bool_gset_true:N  \g__ncu_newenv_bool},
  newenv/false .code:n = {\bool_gset_false:N \g__ncu_newenv_bool},
  newenv .default:n = true,
  newenv .initial:n = false,
  newenv/unknown .code:n = {
    \bool_gset_true:N \g__ncu_newenv_bool
    \__ncu_warning:nn {unknown-option-value} {newenv=true}
  },
  newcmd .choice:,
  newcmd/true .code:n  = {\bool_gset_true:N  \g__ncu_newcmd_bool},
  newcmd/false .code:n = {\bool_gset_false:N \g__ncu_newcmd_bool},
  newcmd .default:n = true,
  newcmd .initial:n = false,
  newcmd/unknown .code:n = {
    \bool_gset_true:N \g__ncu_newcmd_bool
    \__ncu_warning:nn {unknown-option-value} {newcmd=true}
  },
  unknown .code:n = {\__ncu_warning:n {unknown-option}}
}
%%
%% 键值处理
\ProcessKeysOptions {ncu/option}
%% 稿件状态
\tl_if_eq:NNT \g__ncu_doc_tl \g__ncu_doc_draft_tl {
  \PassOptionsToClass   {draft}     {book}
  \PassOptionsToPackage {showframe} {geometry}
  \PassOptionsToPackage {draft}     {graphicx}
}
\tl_if_eq:NNT \g__ncu_doc_tl \g__ncu_doc_final_tl {
  \PassOptionsToClass   {final} {book}
  \PassOptionsToPackage {final} {graphicx}
}
%% 导入选项设置文件
\input{./resources/\g__ncu_type_str.clo}
%%
%% 后面一些处理
\keys_define:nn {ncu} {
  info   .meta:nn = {ncu/info}  {#1},
  style  .meta:nn = {ncu/style} {#1},
  unknown .code:n = \__ncu_warning:n {unknown-key}
}
\keys_define:nn {ncu/style} {
  unknown .code:n = \__ncu_warning:n {unknown-style}
}
\keys_define:nn {ncu/info} {
  unknown .code:n = \__ncu_warning:n {unknown-info}
}
%% 定义接口
\NewDocumentCommand \ncusetup {m} {
  \keys_set:nn {ncu} {#1}
}
%%
%%
\endinput
%% `ncuthesis.cls' 文件结束
%%