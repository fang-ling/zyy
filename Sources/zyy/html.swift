//
//  html.swift
//  
//
//  Created by Fang Ling on 2022/11/7.
//

import Foundation
import CMark

let MAIN_STYLE_CSS : String =
"""
html {
    overflow-x: initial !important
}

:root {
    --bg-color: #ffffff;
    --text-color: #333333;
    --select-text-bg-color: #B5D6FC;
    --select-text-font-color: auto;
    --monospace: "Lucida Console", Consolas, "Courier", monospace;
    --title-bar-height: 20px;
    --active-file-bg-color: #dadada;
    --active-file-bg-color: rgba(32, 43, 51, 0.63);
    --active-file-text-color: white;
    --bg-color: #FFFBF5;
    --text-color: #1f0909;
    --control-text-color: #444;
    --rawblock-edit-panel-bd: #e5e5e5;
    --select-text-bg-color: rgba(32, 43, 51, 0.63);
    --select-text-font-color: white
}

.mac-os-11 {
    --title-bar-height: 28px
}

body {
    margin: 0;
    padding: 0;
    height: auto;
    inset: 0px;
    font-size: 1rem;
    overflow-x: hidden;
    tab-size: 4;
    background: inherit
}

iframe {
    margin: auto
}

a.url {
    word-break: break-all
}

a:active,
a:hover {
    outline: 0
}

.in-text-selection,
::selection {
    text-shadow: none;
    background: var(--select-text-bg-color);
    color: var(--select-text-font-color)
}

#write {
    margin: 0 auto;
    height: auto;
    width: inherit;
    word-break: normal;
    overflow-wrap: break-word;
    position: relative;
    white-space: normal;
    overflow-x: visible;
    padding-top: 36px
}

#write.first-line-indent p {
    text-indent: 2em
}

#write.first-line-indent li p,
#write.first-line-indent p * {
    text-indent: 0
}

#write.first-line-indent li {
    margin-left: 2em
}

.for-image #write {
    padding-left: 8px;
    padding-right: 8px
}

body.typora-export {
    padding-left: 30px;
    padding-right: 30px
}

.typora-export .footnote-line,
.typora-export li,
.typora-export p {
    /*white-space: pre-wrap*/
}

.typora-export .task-list-item input {
    pointer-events: none
}

@media screen and (max-width:500px) {
    body.typora-export {
        padding-left: 0;
        padding-right: 0
    }

    #write {
        padding-left: 20px;
        padding-right: 20px
    }
}

#write li>figure:last-child {
    margin-bottom: .5rem
}

#write ol,
#write ul {
    position: relative
}

img {
    max-width: 100%;
    vertical-align: middle;
    image-orientation: from-image
}

button,
input,
select,
textarea {
    color: inherit;
    font-family: inherit;
    font-size: inherit;
    font-style: inherit;
    font-variant-caps: inherit;
    font-weight: inherit;
    font-stretch: inherit;
    line-height: inherit
}

input[type=checkbox],
input[type=radio] {
    line-height: normal;
    padding: 0
}

*,
::after,
::before {
    box-sizing: border-box
}

#write h1,
#write h2,
#write h3,
#write h4,
#write h5,
#write h6,
#write p,
#write pre {
    width: inherit
}

#write h1,
#write h2,
#write h3,
#write h4,
#write h5,
#write h6,
#write p {
    position: relative
}

p {
    line-height: inherit;
    orphans: 4
}

h1,
h2,
h3,
h4,
h5,
h6 {
    break-after: avoid-page;
    break-inside: avoid;
    orphans: 4;
    font-weight: 700
}

.md-math-block,
.md-rawblock,
h1,
h2,
h3,
h4,
h5,
h6,
p {
    margin-top: 1rem;
    margin-bottom: 1rem
}

.hidden {
    display: none
}

.md-blockmeta {
    color: #ccc;
    font-weight: 700;
    font-style: italic
}

a {
    cursor: pointer;
    text-decoration: none
    /*color: #065588*/
}

sup.md-footnote {
    padding: 2px 4px;
    background-color: rgba(238, 238, 238, .7);
    color: #555;
    border-radius: 4px;
    cursor: pointer
}

sup.md-footnote a,
sup.md-footnote a:hover {
    color: inherit;
    text-transform: inherit;
    text-decoration: inherit
}

#write input[type=checkbox] {
    cursor: pointer;
    width: inherit;
    height: inherit
}

figure {
    overflow-x: auto;
    margin: 1.2em 0;
    max-width: calc(100% + 16px);
    padding: 0
}

figure>table {
    margin: 0
}

thead,
tr {
    break-inside: avoid;
    break-after: auto
}

thead {
    display: table-header-group;
    background-color: #dadada
}

table {
    border-spacing: 0px;
    width: 100%;
    overflow: auto;
    break-inside: auto;
    text-align: left
}

table.md-table td {
    min-width: 32px
}

.CodeMirror-gutters {
    border-right-width: 0;
    background-color: inherit;
    margin-right: 4px
}

.CodeMirror {
    text-align: left
}

.CodeMirror-placeholder {
    opacity: .3
}

.CodeMirror pre {
    padding: 0 4px
}

.CodeMirror-lines {
    padding: 0
}

div.hr:focus {
    cursor: none
}

#write pre {
    white-space: pre-wrap
}

#write.fences-no-line-wrapping pre {
    white-space: pre
}

#write pre.ty-contain-cm {
    white-space: normal
}

.md-fences {
    font-size: .9rem;
    display: block;
    break-inside: avoid;
    text-align: left;
    overflow: visible;
    white-space: pre;
    position: relative !important;
    background: inherit
}

.md-fences-adv-panel {
    width: 100%;
    margin-top: 10px;
    text-align: center;
    padding-top: 0;
    padding-bottom: 8px;
    overflow-x: auto
}

#write .md-fences.mock-cm {
    white-space: pre-wrap
}

.md-fences.md-fences-with-lineno {
    padding-left: 0
}

#write.fences-no-line-wrapping .md-fences.mock-cm {
    white-space: pre;
    overflow-x: auto
}

.md-fences.mock-cm.md-fences-with-lineno {
    padding-left: 8px
}

.CodeMirror-line,
svg,
twitterwidget {
    break-inside: avoid
}

.footnotes {
    opacity: .8;
    font-size: .9rem;
    margin-top: 1em;
    margin-bottom: 1em
}

.footnotes+.footnotes {
    margin-top: 0
}

.md-reset {
    margin: 0;
    padding: 0;
    border: 0;
    outline: 0;
    vertical-align: top;
    text-decoration: none;
    text-shadow: none;
    float: none;
    position: static;
    width: auto;
    height: auto;
    white-space: nowrap;
    cursor: inherit;
    line-height: normal;
    font-weight: 400;
    text-align: left;
    box-sizing: content-box;
    direction: ltr;
    background-position: 0 0
}

li div {
    padding-top: 0
}

blockquote {
    margin: 1rem 0
}

li .mathjax-block,
li p {
    margin: .5rem 0
}

li blockquote {
    margin: 1rem 0
}

li {
    margin: 0;
    position: relative
}

blockquote>:last-child {
    margin-bottom: 0
}

blockquote>:first-child,
li>:first-child {
    margin-top: 0
}

.footnotes-area {
    color: #888;
    margin-top: .714rem;
    padding-bottom: .143rem;
    white-space: normal
}

#write .footnote-line {
    white-space: pre-wrap
}

@media print {

    body,
    html {
        border: 1px solid transparent;
        height: 99%;
        break-after: avoid;
        break-before: avoid;
        font-variant-ligatures: no-common-ligatures
    }

    #write {
        margin-top: 0;
        padding-top: 0;
        border-color: transparent !important;
        padding-bottom: 0 !important
    }

    .typora-export * {
        print-color-adjust: exact
    }

    .typora-export #write {
        break-after: avoid
    }

    .typora-export #write::after {
        height: 0
    }

    .is-mac table {
        break-inside: avoid
    }

    .typora-export-show-outline .typora-export-sidebar {
        display: none
    }

    .typora-export h1,
    .typora-export h2,
    .typora-export h3,
    .typora-export h4,
    .typora-export h5,
    .typora-export h6 {
        break-inside: avoid
    }
}

.footnote-line {
    margin-top: .714em;
    font-size: .7em
}

a img,
img a {
    cursor: pointer
}

pre.md-meta-block {
    font-size: .8rem;
    min-height: .8rem;
    white-space: pre-wrap;
    background-color: #ccc;
    display: block;
    overflow-x: hidden
}

p>.md-image:only-child:not(.md-img-error) img,
p>img:only-child {
    display: block;
    margin: auto
}

#write.first-line-indent p>.md-image:only-child:not(.md-img-error) img {
    left: -2em;
    position: relative
}

p>.md-image:only-child {
    display: inline-block;
    width: 100%
}

#write .MathJax_Display {
    margin: .8em 0 0
}

.md-math-block {
    width: 100%
}

.md-math-block:not(:empty)::after {
    display: none
}

.MathJax_ref {
    fill: currentcolor
}

[contenteditable=false]:active,
[contenteditable=false]:focus,
[contenteditable=true]:active,
[contenteditable=true]:focus {
    outline: 0;
    box-shadow: none
}

.task-list-item.md-task-list-item {
    padding-left: 0
}

.md-task-list-item>input {
    position: absolute;
    top: 0;
    left: 0;
    border: none
}

.math {
    font-size: 1rem
}

.md-toc {
    min-height: 3.58rem;
    position: relative;
    font-size: .9rem;
    border-radius: 10px
}

.md-toc-content {
    position: relative;
    margin-left: 0
}

.md-toc-content::after,
.md-toc::after {
    display: none
}

.md-toc-item {
    display: block
}

.md-toc-item a {
    text-decoration: none
}

.md-toc-inner:hover {
    text-decoration: underline
}

.md-toc-inner {
    display: inline-block;
    cursor: pointer
}

.md-toc-h1 .md-toc-inner {
    margin-left: 0;
    font-weight: 700
}

.md-toc-h2 .md-toc-inner {
    margin-left: 2em
}

.md-toc-h3 .md-toc-inner {
    margin-left: 4em
}

.md-toc-h4 .md-toc-inner {
    margin-left: 6em
}

.md-toc-h5 .md-toc-inner {
    margin-left: 8em
}

.md-toc-h6 .md-toc-inner {
    margin-left: 10em
}

@media screen and (max-width:48em) {
    .md-toc-h3 .md-toc-inner {
        margin-left: 3.5em
    }

    .md-toc-h4 .md-toc-inner {
        margin-left: 5em
    }

    .md-toc-h5 .md-toc-inner {
        margin-left: 6.5em
    }

    .md-toc-h6 .md-toc-inner {
        margin-left: 8em
    }
}

a.md-toc-inner {
    font-size: inherit;
    font-style: inherit;
    font-weight: inherit;
    line-height: inherit
}

.footnote-line a:not(.reversefootnote) {
    color: inherit
}

.reversefootnote {
    font-family: ui-monospace, sans-serif
}

.md-attr {
    display: none
}

.md-fn-count::after {
    content: "."
}

code,
pre,
samp,
tt {
    font-family: var(--monospace)
}

kbd {
    margin: 0 .1em;
    padding: .1em .6em;
    font-size: .8em;
    color: #242729;
    background-color: #fff;
    border: 1px solid #adb3b9;
    border-radius: 3px;
    box-shadow: rgba(12, 13, 14, .2) 0 1px 0, #fff 0 0 0 2px inset;
    white-space: nowrap;
    vertical-align: middle
}

.md-comment {
    color: #a27f03;
    opacity: .6;
    font-family: var(--monospace)
}

code {
    text-align: left;
    padding-left: 2px;
    padding-right: 2px
}

a.md-print-anchor {
    white-space: pre !important;
    border: none !important;
    display: inline-block !important;
    position: absolute !important;
    width: 1px !important;
    right: 0 !important;
    outline: 0 !important;
    text-shadow: initial !important;
    background-position: 0 0 !important
}

.os-windows.monocolor-emoji .md-emoji {
    font-family: "Segoe UI Symbol", sans-serif
}

.md-diagram-panel>svg {
    max-width: 100%
}

[lang=flow] svg,
[lang=mermaid] svg {
    max-width: 100%;
    height: auto
}

[lang=mermaid] .node text {
    font-size: 1rem
}

table tr th {
    border-bottom-width: 0
}

video {
    max-width: 100%;
    display: block;
    margin: 0 auto
}

iframe {
    max-width: 100%;
    width: 100%;
    border: none
}

.highlight td,
.highlight tr {
    border: 0
}

mark {
    background-color: #ff0;
    color: #000
}

.md-html-inline .md-plain,
.md-html-inline strong,
mark .md-inline-math,
mark strong {
    color: inherit
}

.md-expand mark .md-meta {
    opacity: .3 !important
}

mark .md-meta {
    color: #000
}

.md-diagram-panel .messageText {
    stroke: none !important
}

.md-diagram-panel .start-state {
    fill: var(--node-fill)
}

.md-diagram-panel .edgeLabel rect {
    opacity: 1 !important
}

.md-fences.md-fences-math {
    font-size: 1em
}

.md-fences-advanced:not(.md-focus) {
    padding: 0;
    white-space: nowrap;
    border: 0;
    background: inherit
}

.typora-export-show-outline .typora-export-content {
    max-width: 1440px;
    margin: auto;
    display: flex;
    flex-direction: row
}

.typora-export-sidebar {
    width: 300px;
    font-size: .8rem;
    margin-top: 80px;
    margin-right: 18px
}

.typora-export-show-outline #write {
    --webkit-flex: 2;
    flex: 2 1 0%
}

.typora-export-sidebar .outline-content {
    position: fixed;
    top: 0;
    max-height: 100%;
    overflow: hidden auto;
    padding-bottom: 30px;
    padding-top: 60px;
    width: 300px
}

@media screen and (max-width:1024px) {

    .typora-export-sidebar,
    .typora-export-sidebar .outline-content {
        width: 240px
    }
}

@media screen and (max-width:800px) {
    .typora-export-sidebar {
        display: none
    }
}

.outline-content li,
.outline-content ul {
    margin-left: 0;
    margin-right: 0;
    padding-left: 0;
    padding-right: 0;
    list-style: none
}

.outline-content ul {
    margin-top: 0;
    margin-bottom: 0
}

.outline-content strong {
    font-weight: 400
}

.outline-expander {
    width: 1rem;
    height: 1.428571rem;
    position: relative;
    display: table-cell;
    vertical-align: middle;
    cursor: pointer;
    padding-left: 4px
}

.outline-expander::before {
    content: "";
    position: relative;
    font-family: Ionicons;
    display: inline-block;
    font-size: 8px;
    vertical-align: middle
}

.outline-item {
    padding-top: 3px;
    padding-bottom: 3px;
    cursor: pointer
}

.outline-expander:hover::before {
    content: ""
}

.outline-h1>.outline-item {
    padding-left: 0
}

.outline-h2>.outline-item {
    padding-left: 1em
}

.outline-h3>.outline-item {
    padding-left: 2em
}

.outline-h4>.outline-item {
    padding-left: 3em
}

.outline-h5>.outline-item {
    padding-left: 4em
}

.outline-h6>.outline-item {
    padding-left: 5em
}

.outline-label {
    cursor: pointer;
    display: table-cell;
    vertical-align: middle;
    text-decoration: none;
    color: inherit
}

.outline-label:hover {
    text-decoration: underline
}

.outline-item:hover {
    border-color: #f5f5f5;
    background-color: var(--item-hover-bg-color);
    margin-left: -28px;
    margin-right: -28px
}

.outline-item-single .outline-expander::before,
.outline-item-single .outline-expander:hover::before {
    display: none
}

.outline-item-open>.outline-item>.outline-expander::before {
    content: ""
}

.info-panel-tab-wrapper,
.outline-children {
    display: none
}

.outline-item-open>.outline-children {
    display: block
}

.typora-export .outline-item {
    padding-top: 1px;
    padding-bottom: 1px
}

.typora-export .outline-item:hover {
    margin-right: -8px;
    border-right: 8px solid transparent
}

.typora-export .outline-expander::before {
    content: "+";
    font-family: inherit;
    top: -1px
}

.typora-export .outline-expander:hover::before,
.typora-export .outline-item-open>.outline-item>.outline-expander::before {
    content: "−"
}

.typora-export-collapse-outline .outline-children {
    display: none
}

.typora-export-collapse-outline .outline-item-open>.outline-children,
.typora-export-no-collapse-outline .outline-children {
    display: block
}

.typora-export-no-collapse-outline .outline-expander::before {
    content: "" !important
}

.typora-export-show-outline .outline-item-active>.outline-item .outline-label {
    font-weight: 700
}

.md-inline-math-container mjx-container {
    zoom: 0.95
}

mjx-container {
    break-inside: avoid
}

@include-when-export url(https://fonts.loli.net/css?family=PT+Serif:400,400italic,700,700italic&subset=latin,cyrillic-ext,cyrillic,latin-ext);

A:link, A:visited {
    text-decoration: none;
    color: #674188
}

A:hover {
    background-color: #674188;
    color: #C3ACD0;
    text-decoration: none
}

A:link, A:visited {
    text-decoration: none;
    color: #674188
}

A:hover {
    background-color: #674188;
    color: #C3ACD0;
    text-decoration: none
}

.purplebox A:link, .purplebox A:visited {
    text-decoration: none;
    color: yellow
}

.purplebox A:hover {
    background-color: yellow;
    color: #674188;
    text-decoration: none
}

.purplebox A:link, .purplebox A:visited {
    text-decoration: none;
    color: yellow
}

.purplebox A:hover {
    background-color: yellow;
    color: #674188;
    text-decoration: none
}

.stackpreview-container {
    text-align: center;
}

.stackpreview {
    display: inline-block;
    margin: 3ex 1em;
    padding: 4px;
    clear: both;
    text-align: center;
    background-color: #C3ACD0;
    vertical-align: top;
    width: 300px;
}

.stackpreview P {
    margin-top: 0;
    white-space: normal;
}

.stackpreview DIV+P,
.stackpreview P+P {
    margin-bottom: .5em
}

.image A IMG,
.image A TABLE {
    border: 4px solid #674188;
    position: relative;
    left: -4px;
    top: -4px
}

.image A:hover IMG,
.image A:hover TABLE {
    border-color: #C3ACD0;
    opacity: .5
}

.image A:hover {
    background-color: inherit
}

.heading {
    font-size: x-large;
    font-weight: 700
}

.caption {
    font-style: italic
}

pre {
    --select-text-bg-color: #36284e;
    --select-text-font-color: #fff
}

html {
    background-color: var(--bg-color);
    color: var(--text-color);
    -webkit-font-smoothing: antialiased;
    font-size: 16px;
    -webkit-font-smoothing: antialiased
}

body,
html {
    background-color: #FFFBF5;
    font-family: 'Gentium Book Basic', 'Times New Roman', Times, serif;
    color: #1f0909;
    line-height: 1.5em
}

ol li {
    list-style-type: decimal;
    list-style-position: outside
}

ul li {
    list-style-type: disc;
    list-style-position: outside
}

blockquote,
q {
    quotes: none
}

blockquote:after,
blockquote:before,
q:after,
q:before {
    content: '';
    content: none
}

h1 {
    font-size: 1.875em;
    margin-top: 2em;
    border-bottom: 1px solid;
    padding-bottom: .8125em
}

h2,
h3 {
    font-size: 1.3125em;
    line-height: 1.15;
    margin-top: 2.285714em
}

h3 {
    font-weight: 400
}

h4 {
    font-size: 1.125em;
    margin-top: 2.67em
}

h5,
h6 {
    font-size: 1em
}

.md-fences,
blockquote,
h1,
h2,
h3,
h4,
h5,
h6,
p {
    margin-bottom: 1.5em
}

blockquote {
    font-style: italic;
    border-left: 5px solid;
    margin-left: 2em;
    padding-left: 1em
}

ol,
ul {
    list-style: none;
    margin: 0 0 1.5em 1.5em
}

.md-after,
.md-before,
.md-meta {
    color: #999
}

table {
    border-collapse: collapse;
    border-spacing: 0;
    margin-bottom: 1.5em;
    font-size: 1em
}

tfoot th,
thead th {
    padding: .25em .25em .25em .4em;
    text-transform: uppercase
}

th {
    text-align: left
}

td {
    vertical-align: top;
    padding: .25em .25em .25em .4em
}

.md-fences,
code {
    background-color: #dadada
}

.md-fences {
    margin-left: 2em;
    margin-bottom: 3em;
    padding-left: 1ch;
    padding-right: 1ch
}

code,
pre,
tt {
    font-size: .875em;
    line-height: 1.714285em
}

h3+ol,
h3+ul,
h4+ol,
h4+ul,
h5+ol,
h5+ul,
h6+ol,
h6+ul,
p+ol,
p+ul {
    margin-top: .5em
}

li>ol,
li>ul {
    margin-top: inherit;
    margin-bottom: 0
}

li ol>li {
    list-style-type: lower-alpha
}

li li ol>li {
    list-style-type: lower-roman
}

h2,
h3 {
    margin-bottom: .75em
}

hr {
    border-top: none;
    border-right: none;
    border-bottom: 1px solid;
    border-left: none;
    border-color: #c5c5c5
}

h1 {
    line-height: 1.3em;
    font-weight: 400;
    margin-bottom: .5em;
    border-color: #c5c5c5
}

blockquote {
    border-color: #bababa;
    color: #656565
}

blockquote ol,
blockquote ul {
    margin-left: 0
}

.ty-table-edit {
    background-color: transparent
}

tr:nth-child(2n) {
    background: #e8e7e7
}

.task-list {
    padding-left: 1rem
}

.md-task-list-item {
    position: relative;
    padding-left: 1.5rem;
    list-style-type: none
}

.md-task-list-item>input:before {
    content: '\\221A';
    display: inline-block;
    width: 1.25rem;
    height: 1.6rem;
    vertical-align: middle;
    text-align: center;
    color: #ddd;
    background-color: #FFFBF5
}

.md-task-list-item>input:checked:before,
.md-task-list-item>input[checked]:before {
    color: inherit
}

#write pre.md-meta-block {
    min-height: 1.875rem;
    color: #555;
    border: 0;
    background: 0 0;
    margin-left: 1em;
    margin-top: 1em
}

.md-image>.md-meta {
    color: #9b5146;
    font-family: Menlo, 'Ubuntu Mono', Consolas, 'Courier New', 'Microsoft Yahei', 'Hiragino Sans GB', 'WenQuanYi Micro Hei', serif
}

#write>h3.md-focus:before {
    left: -1.5rem;
    color: #999;
    border-color: #999
}

#write>h4.md-focus:before {
    left: -1.5rem;
    top: .25rem;
    color: #999;
    border-color: #999
}

#write>h5.md-focus:before,
#write>h6.md-focus:before {
    left: -1.5rem;
    top: .3125rem;
    color: #999;
    border-color: #999
}

.md-toc:focus .md-toc-content {
    margin-top: 19px
}

.md-toc-content:empty:before,
.md-toc-item {
    color: #065588
}

#write div.md-toc-tooltip {
    background-color: #FFFBF5
}

#typora-sidebar {
    background-color: #FFFBF5;
    -webkit-box-shadow: 0 6px 12px rgba(0, 0, 0, .375);
    box-shadow: 0 6px 12px rgba(0, 0, 0, .375)
}

.pin-outline #typora-sidebar {
    background: inherit;
    box-shadow: none;
    border-right: 1px dashed
}

.pin-outline #typora-sidebar:hover .outline-title-wrapper {
    border-left: 1px dashed
}

.outline-item:hover {
    background-color: #dadada;
    border-left: 28px solid #dadada;
    border-right: 18px solid #dadada
}

.typora-node .outline-item:hover {
    border-right: 28px solid #dadada
}

.outline-expander:before {
    content: "\\f0da";
    font-family: FontAwesome;
    font-size: 14px;
    top: 1px
}

.outline-expander:hover:before,
.outline-item-open>.outline-item>.outline-expander:before {
    content: "\\f0d7"
}

.modal-content {
    background-color: #FFFBF5
}

.auto-suggest-container ul li {
    list-style-type: none
}

#top-titlebar,
#top-titlebar *,
.megamenu-content,
.megamenu-menu {
    background: #FFFBF5;
    color: #1f0909
}

.megamenu-menu-header {
    border-bottom: 1px dashed #202b33
}

.megamenu-menu {
    box-shadow: none;
    border-right: 1px dashed
}

.context-menu,
.megamenu-content,
footer,
header {
    font-family: 'Gentium Book Basic', 'Times New Roman', Times, serif;
    color: #1f0909
}

#megamenu-back-btn {
    color: #1f0909;
    border-color: #1f0909
}

.megamenu-menu-header #megamenu-menu-header-title:before {
    color: #1f0909
}

.megamenu-menu-list li a.active,
.megamenu-menu-list li a:hover {
    color: inherit;
    background-color: #e8e7df
}

.long-btn:hover {
    background-color: #e8e7df
}

#recent-file-panel tbody tr:nth-child(2n-1) {
    background-color: transparent !important
}

.megamenu-menu-panel tbody tr:hover td:nth-child(2) {
    color: inherit
}

.megamenu-menu-panel .btn {
    background-color: #d2d1d1
}

.btn-default {
    background-color: transparent
}

.ty-show-word-count #footer-word-count,
.typora-sourceview-on #toggle-sourceview-btn {
    background: #c7c5c5
}

#typora-quick-open {
    background-color: inherit
}

.md-diagram-panel {
    margin-top: 8px
}

.file-list-item-file-name {
    font-weight: initial
}

.file-list-item-summary {
    opacity: 1
}

.file-list-item {
    color: #777;
    opacity: 1 !important
}

.file-list-item.active {
    background-color: inherit;
    color: #000
}

.ty-side-sort-btn.active {
    background-color: inherit
}

.file-list-item.active .file-list-item-file-name {
    font-weight: 700
}

.file-library-node.active>.file-node-background {
    background-color: rgba(32, 43, 51, .63);
    background-color: var(--active-file-bg-color)
}

.file-tree-node.active>.file-node-content {
    color: #fff;
    color: var(--active-file-text-color)
}

.md-task-list-item>input {
    margin-left: -1.7em;
    margin-top: calc(1rem - 12px);
    -webkit-appearance: button
}

input {
    border: 1px solid #aaa
}

.megamenu-menu-header #megamenu-menu-header-title,
.megamenu-menu-header:focus,
.megamenu-menu-header:hover {
    color: inherit
}

.dropdown-menu .divider {
    border-color: #e5e5e5;
    opacity: 1
}

.os-windows-7 strong {
    font-weight: 760
}

.ty-preferences .btn-default {
    background: 0 0
}

.ty-preferences .window-header {
    border-bottom: 1px dashed #202b33;
    box-shadow: none
}

#sidebar-loading-template,
#sidebar-loading-template.file-list-item {
    color: #777
}

.searchpanel-search-option-btn.active {
    background: #777;
    color: #fff
}

.export-detail,
.light .export-detail,
.light .export-item.active,
.light .export-items-list-control {
    background: #e0e0e0;
    border-radius: 2px;
    font-weight: 700;
    color: inherit
}

@media print {
    @page {
        margin: 0
    }

    body.typora-export {
        padding-left: 0;
        padding-right: 0
    }

    #write {
        padding: 0
    }
}

.title-text {
    border-bottom: none;
    font-variant: small-caps;
    padding-bottom: 0em;
    text-shadow: 2px 2px 2px #aaa;
}

.head-box {
    text-align: center;
    background: #674188;
    color: #F7EFE5;
    padding: 1ex 1em;
    font-weight:bold;
}

.foot-box {
    text-align: right;
    background: #674188;
    color: #F7EFE5;
    padding: 1ex 1em;
    font-weight:bold;
}

.footer {
    text-align: center;
}

.footer a, .footer span {
    margin-left: 4px;
    color: #fbfbfb;
    text-decoration: none;
    font-size: 13px;
    padding: 4px 8px;
    border-radius: 3px;
    background: #674188;
}
"""

let STACK_PREVIEW_JS =
"""
/* Written by Erik Demaine <edemaine@mit.edu>, 2012.
 * Distributed under the MIT License
 * [http://www.opensource.org/licenses/mit-license.php]
 */
  var divs = document.getElementsByTagName ('div');
  var maxHeight = 0;
  for (var i = 0; i < divs.length; i++) {
    if ((' ' + divs[i].className + ' ').indexOf (' stackpreview ') >= 0) {
      maxHeight = Math.max (maxHeight, divs[i].offsetHeight);
    }
  }
  for (var i = 0; i < divs.length; i++) {
    if ((' ' + divs[i].className + ' ').indexOf (' stackpreview ') >= 0) {
      divs[i].style.height = maxHeight + 'px';
    }
  }
"""

/* Main index html:
 * <!doctype html>
 * <html>
 *   <head>
 *     <meta>
 *     <meta>
 *     <link>
 *     <style></style>
 *     <title></title>
 *   </head>
 * </html>
 */

struct HTML {
    private static let FONT_LINK = "https://fonts.googleapis.com/css?family=" +                                   "Gentium+Book+Basic:400,700italic,700,400italic:latin"
    private static let MAIN_STYLE_CSS_FILE_NAME = "style.css"
    /* The height of stack preview div is determined by javascript. */
    //private static let STACK_PREVIEW_STYLE = "width: 300px;"
    //private static let STACK_PREVIEW_P_STYLE = "white-space: normal;"
    //private static let STACK_PREVIEW_CONTAINER_STYLE = "text-align:center";
    
    public static func write_to_file() {
        do {
            /* style.css */
            try MAIN_STYLE_CSS.write(toFile: MAIN_STYLE_CSS_FILE_NAME,
                                     atomically: true,
                                     encoding: .utf8)
            let index_t =
                zyy.get_setting(field: zyy.DB_SETTING_FIELD_INDEX_UPDATE_TIME)
            /* index.html */
            try HTML.render_index(date: index_t).write(toFile: "index.html",
                                                       atomically: true,
                                                       encoding: .utf8)
            // TO-DO: add file hierarch
            for page in zyy.list_pages() {
                try HTML.render_page(page: page)
                .write(toFile: page.link.components(separatedBy: "/").last!,
                       atomically: true,
                       encoding: .utf8)
            }
        } catch {
            print(error.localizedDescription)
        }
    }
    
    private static func render_head(titleText : String) -> DOMTreeNode {
        let head = DOMTreeNode(name: "head", attr: [:])
        head.add(DOMTreeNode(name: "meta", attr: ["charset" : "UTF-8"]))
        head.add(DOMTreeNode(
            name: "meta",
            attr: ["name" : "viewport",
                   "content" : "width=device-width initial-scale=1"]))
        head.add(DOMTreeNode(name: "link", attr: ["href" : FONT_LINK,
                                                  "rel" : "stylesheet",
                                                  "type" : "text/css"]))
        head.add(DOMTreeNode(name: "link",
                             attr: ["href" : MAIN_STYLE_CSS_FILE_NAME,
                                    "rel" : "stylesheet",
                                    "type" : "text/css"]))
        let title = DOMTreeNode(name: "title", attr: [:])
        title.add(titleText)
        head.add(title)
        return head
    }
    
    /*
     *  <center>
     *      <h1>
     *          <strong>...</strong>
     *      </h1>
     *  </center>
     */
    private static func render_title(title_text : String) -> DOMTreeNode {
        let strong = DOMTreeNode(name: "strong", attr: [:])
        strong.add(title_text)
        let h1 = DOMTreeNode(name: "h1", attr: ["class" : "title-text"])
        h1.add(strong)
        let center = DOMTreeNode(name: "center", attr: [:])
        center.add(h1)
        return center
    }
    
    /*
     *  <div>
     *      Plain text or <a> separated by dots.
     *  </div>
     */
    private static func render_head_box() -> DOMTreeNode {
        let fields = zyy.getAllHeadBoxCustomFields()
        let div = DOMTreeNode(name: "div",
                              attr: ["class" : "purplebox head-box"])
        for i in fields[0].indices {
            if (fields[1][i] == "") { /* Plain text node */
                div.add(fields[0][i])
            } else {
                let a = DOMTreeNode(name: "a", attr: ["href" : fields[1][i]])
                a.add(fields[0][i])
                div.add(a)
            }
            if (i != fields[0].count - 1) { /* Add separater */
                div.add("&nbsp;&bull;&nbsp;");
            }
        }
        return div
    }
    
    private static
    func render_stack_preview(by section : Section) -> DOMTreeNode {
        let stack_preview = DOMTreeNode(name: "div",
                                        attr: ["class" : "stackpreview"])
        /* Image */
        let img_p = DOMTreeNode(name: "p",
                                attr: ["class" : "image"])
        let img_p_a = DOMTreeNode(name: "a", attr: ["href" : section.hlink])
        img_p_a.add(DOMTreeNode(name: "img", attr: ["width" : "300",
                                                    "height" : "300",
                                                    "src" : section.cover]))
        img_p.add(img_p_a)
        /* Heading */
        let heading_p = DOMTreeNode(name: "p",
                                    attr: ["class" : "heading"])
        let heading_p_a = DOMTreeNode(name: "a", attr: ["href" : section.hlink])
        heading_p_a.add(section.heading)
        heading_p.add(heading_p_a)
        /* Caption */
        let caption_p = DOMTreeNode(name: "p",
                                    attr: ["class" : "caption"])
        caption_p.add(section.caption)
        stack_preview.add(img_p)
        stack_preview.add(heading_p)
        stack_preview.add(caption_p)
        return stack_preview
    }
    
    private static func render_stack_preview_container() -> DOMTreeNode {
        let div = DOMTreeNode(name: "div",
                              attr: ["class" : "stackpreview-container"])
        for section in zyy.list_sections() {
            div.add(render_stack_preview(by: section))
        }
        return div
    }
    
    private static func render_foot_box(date: String) -> DOMTreeNode {
        let author = zyy.get_setting(field: zyy.DB_SETTING_FIELD_AUTHOR)
        let site_url = zyy.get_setting(field: zyy.DB_SETTING_FIELD_SITEURL)
        let div = DOMTreeNode(name: "div",
                              attr: ["class" : "purplebox foot-box"])
        let i = DOMTreeNode(name: "i", attr: [:])
        let a = DOMTreeNode(name: "a", attr: ["href" : site_url])
        a.add(author)
        i.add("Last updated \(date) by ")
        i.add(a)
        i.add(".")
        div.add(i)
        return div
    }
    
    private static func render_footer() -> DOMTreeNode {
        let site_url = zyy.get_setting(field: zyy.DB_SETTING_FIELD_SITEURL)
        let author = zyy.get_setting(field: zyy.DB_SETTING_FIELD_AUTHOR)
        let st_year = zyy.get_setting(field: zyy.DB_SETTING_FIELD_START_YEAR)
        var cr_year = 1970
        if let year = Calendar(identifier: .gregorian)
                            .dateComponents([.year], from: Date()).year {
            cr_year = year
        }
        let div = DOMTreeNode(name: "div", attr: ["class" : "footer"])
        div.add("Made with ❤️")
        let a = DOMTreeNode(name: "a", attr: ["href" : site_url])
        a.add("by \(author)")
        div.add(a)
        let a2 = DOMTreeNode(name: "a", attr: ["href" : zyy.GITHUB_REPO])
        a2.add("zyy v\(zyy.VERSION)")
        div.add(a2)
        let span = DOMTreeNode(name: "span",
                               attr: [:])
        let count = zyy.get_setting(field:zyy.DB_SETTING_FIELD_BUILD_COUNT)
        span.add("Build: \(count)")
        div.add(span)
        let p = DOMTreeNode(name: "p", attr: ["class" : "copyright"])
        p.add("© \(st_year)-\(cr_year) \(author)")
        div.add(p)
        return div
    }
    
    private static func render_index_body(date: String) -> DOMTreeNode {
        let sitename = zyy.get_setting(field: zyy.DB_SETTING_FIELD_SITENAME)
        let body = DOMTreeNode(name: "body", attr: ["class" : "typora-export"])
        let typora_export_content = DOMTreeNode(name: "div",
                                                attr: ["class" :
                                                       "typora-export-content"])
        let write = DOMTreeNode(name: "div", attr: ["id" : "write"])
        write.add(render_title(title_text: sitename))
        write.add(render_head_box())
        write.add(render_stack_preview_container())
        write.add(render_foot_box(date: date))
        write.add(DOMTreeNode(name: "br", attr: [:]))
        write.add(render_footer())
        let js = DOMTreeNode(name: "script", attr: ["type" : "text/javascript"])
        js.add(STACK_PREVIEW_JS)
        write.add(js)
        typora_export_content.add(write)
        body.add(typora_export_content)
        return body
    }
    
    public static func render_index(date: String) -> String {
        let sitename = zyy.get_setting(field: zyy.DB_SETTING_FIELD_SITENAME)
        let html = DOMTreeNode(name: "html", attr: [:])
        html.add(render_head(titleText: sitename))
        html.add(render_index_body(date: date))
        var string = ""
        DOMTreeNode.inorder_tree_traversal(html, &string)
        return "<!DOCTYPE html>\n" + string
    }
    
    private static func render_page(page : Page) -> String {
        let html = DOMTreeNode(name: "html", attr: [:])
        html.add(render_head(titleText: page.title))
        /* Body */
        let body = DOMTreeNode(name: "body", attr: ["class" : "typora-export"])
        let typora_export_content = DOMTreeNode(name: "div",
                                                attr: ["class" :
                                                       "typora-export-content"])
        let write = DOMTreeNode(name: "div", attr: ["id" : "write"])
        write.add(render_title(title_text: page.title))
        write.add(render_head_box())
        write.add(cmark_markdown_to_html_with_ext(page.content,
                                                  CMARK_OPT_DEFAULT))
        write.add(render_foot_box(date: page.date))
        write.add(DOMTreeNode(name: "br", attr: [:]))
        write.add(render_footer())
        typora_export_content.add(write)
        body.add(typora_export_content)
        
        html.add(body)
        var string = ""
        DOMTreeNode.inorder_tree_traversal(html, &string)
        return "<!DOCTYPE html>\n" + string
    }
}
