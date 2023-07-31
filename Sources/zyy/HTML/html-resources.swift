//
//  html-resources.swift
//
//
//  Created by Fang Ling on 2023/5/30.
//

let MAIN_STYLE_CSS : String =
"""
:root {
    --monospace: ui-monospace,SF Mono,Menlo,Consolas,Liberation Mono,monospace;
    /* <code> tag color */
    --color-neutral-muted: rgba(175, 184, 193, 0.2);
    --bg-color: #FFFBF5;
    --text-color: #1f0909;
    --text-font: 'Gentium Book Basic', 'LXGW WenKai TC', system-ui, serif;
    /* table child 2n bg color */
    --color-canvas-subtle: #e8e7e7;
    --color-canvas-head: #dadada;
    /* table border color */
    --color-border-default: #d0d7de; /* dark: #30363d */
    --color-border-muted: hsla(210,18%,87%,1); /* dark: #21262d */
    /* purple box color */
    --purple-box-color: #674188;
    /* purple box font color */
    --purple-box-font-color: #F7EFE5;
    /* purple box light purple */
    --purple-box-light-color: #C3ACD0;
    /* purple box link color */
    --purple-box-link-color: yellow;

    /* gist */
    --color-canvas-default: #ffffff;
    --color-fg-default: #24292f;
    --gist-border-pcolor: #ddd;
    --gist-border-scolor: #ccc;
}

html {
    background-color: var(--bg-color);
    color: var(--text-color);
    font-size: 16px;
}

body {
    margin: 0 auto;
    font-size: 1rem;
    padding-left: 30px;
    padding-right: 30px;
    font-family: var(--text-font);
    max-width: 50em;
    line-height: 1.5em;
}

blockquote {
    padding: 0 1em;
    border-left: .25em solid var(--purple-box-color);
}

img {
    vertical-align: middle;
}

.title-text {
    border-bottom: none;
    font-variant: small-caps;
    padding-bottom: 0em;
    text-shadow: 2px 2px 2px #aaa;
    font-size: 250%;
    text-align: center;
    margin-bottom: .5em;
}

code {
    font-family: var(--monospace);
    padding: .2em .4em;
    background-color: var(--color-neutral-muted);
    border-radius: 6px;
    font-size: 85%;
}

A:link, A:visited {
    text-decoration: none;
    color: var(--purple-box-color)
}

A:hover {
    background-color: var(--purple-box-color);
    color: var(--purple-box-light-color);
    text-decoration: none
}

.purplebox A:link, .purplebox A:visited {
    text-decoration: none;
    color: var(--purple-box-link-color);
}

.purplebox A:hover {
    background-color: var(--purple-box-link-color);
    color: var(--purple-box-color);
    text-decoration: none
}

.purplebox A:link, .purplebox A:visited {
    text-decoration: none;
    color: var(--purple-box-link-color);
}

.purplebox A:hover {
    background-color: var(--purple-box-link-color);
    color: var(--purple-box-color);
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
    background-color: var(--purple-box-light-color);
    vertical-align: top;
    width: 300px;
}

.stackpreview P {
    margin-top: 0;
    white-space: normal;
}

.stackpreview DIV+P,
.stackpreview P+P {
    margin-bottom: 0.5em
}

.image A IMG,
.image A TABLE {
    border: 4px solid var(--purple-box-color);
    position: relative;
    left: -4px;
    top: -4px
}

.image A:hover IMG,
.image A:hover TABLE {
    border-color: var(--purple-box-light-color);
    opacity: .5
}

.image A:hover {
    background-color: inherit
}

.heading {
    font-size: x-large;
    font-weight: bold;
}

.caption {
    font-style: italic
}

.purplebox, .section {
    background: var(--purple-box-color);
    color: var(--purple-box-font-color);
    padding: 1ex 1em;
    font-weight: bold;
    font-size: large;
}

.section {
    text-transform: uppercase;
    padding: 0.5ex 0.5em;
    font-size: 1.5em;
}

.head-box {
    text-align: center;
}

.foot-box {
    margin-top: 0.5em;
    text-align: right;
}

.footer {
    text-align: center;
}

.footer a, .footer span {
    margin-left: 4px;
    color: var(--purple-box-font-color) !important;
    text-decoration: none;
    font-size: 13px;
    padding: 4px 8px;
    border-radius: 3px;
    background: var(--purple-box-color) !important;
}

#reset-all {
    background-color: unset;
}

ol li {
    list-style-type: decimal;
}

ul li {
    list-style-type: disc;
}

li ol>li {
    list-style-type: lower-alpha
}

li li ol>li {
    list-style-type: lower-roman
}

table thead {
    background: var(--color-canvas-head);
    text-transform: uppercase;
}

table {
    border-spacing: 0;
    border-collapse: collapse;
}

table td, table th {
    padding: 6px 13px;
    /*border: 1px solid var(--color-border-default);*/
}

/*table tr {
    border-top: 1px solid var(--color-border-muted);
}*/

/*tr:nth-child(2n) {
    background: var(--color-canvas-subtle);
}*/

/* MathJax long formulas */
/*mjx-container {
  display: inline-grid;
  overflow-x: auto;
  overflow-y: hidden;
  max-width: 100%;
}*/

/* Images in blog posts, centered */
.page-container img {
    width: 61.8%;
    display: block;
    margin: 0 auto
}

/* iPhone OS */
@media screen and (max-width:500px) {
    body {
        padding-left: 20px;
        padding-right: 20px;
        /* fix gist font size bug on iPhone OS */
        -webkit-text-size-adjust: 100%;
    }
}

/* Dark mode */
@media (prefers-color-scheme: dark) {
    :root {
        --bg-color: #222831;
        --text-color: #fff4ff;
        --purple-box-light-color: #63496a;
        --dark-link-pcolor: #BC6FF1;
        --dark-link-scolor: #D9ACF5;
        /*--dark-page-bg: #393E46;*/

        /* gist */
        --color-canvas-default: #2a3134;
        --color-fg-default: #e4e8ec;
        --gist-border-pcolor: #555;
        --gist-border-scolor: #444;
    }

    body {
        max-width: 55em;
    }

    .gist .gist-meta {
        background-color: var(--color-canvas-default) !important;
        color: var(--color-fg-default) !important;
    }

    .gist .gist-meta a {
        color: var(--dark-link-pcolor) !important;
    }

    html {
        font-size: 15px;
    }

    img {
        filter: brightness(.8) contrast(1.2);
    }

    /*.page-container {
        background-color: var(--dark-page-bg);
        border-radius: 6px 6px;
        padding: 0.1em 1em 0.1em 1em;
        margin-top: 1em;
        margin-bottom: 1em;
    }*/

    .section {
        padding: 0.9ex 0.5em;
    }

    .title-text {
        color: var(--purple-box-font-color);
    }

    A:link, A:visited {
        text-decoration: none;
        color: var(--dark-link-pcolor)
    }

    A:hover {
        background-color: var(--dark-link-pcolor);
        color: var(--dark-link-scolor);
        text-decoration: none
    }

    /* gist */
    .gist .pl-k {
        color:#fc5fa3 !important
    }
    .gist .pl-c {
        color:#6c7986 !important
    }
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

let MATHJAX_JS =
"""
<script>
MathJax = {
  tex: {
    inlineMath: [['$', '$']],
    displayMath: [['$$', '$$']]
  }
};
</script>
<script src="https://polyfill.io/v3/polyfill.min.js?features=es6"></script>
<script id="MathJax-script" async src="https://cdn.jsdelivr.net/npm/mathjax@3/es5/tex-mml-chtml.js"></script>
"""
