//
//  code-highlight.swift
//
//
//  Created by Fang Ling on 2023/3/18.
//

import Foundation

let CHL_CSS =
"""
.gist {
    /*!
     * GitHub Light v0.4.1
     * Copyright (c) 2012 - 2017 GitHub, Inc.
     * Licensed under MIT (https://github.com/primer/github-syntax-theme-generator/blob/master/LICENSE)
     */
    font-size: 16px;
    color: #333;
    text-align: left;
    direction:ltr
}

.gist {
    --color-canvas-default-transparent: rgba(255, 255, 255, 0);
    --color-page-header-bg: #f6f8fa;
    --color-marketing-icon-primary: #218bff;
    --color-marketing-icon-secondary: #54aeff;
    --color-diff-blob-addition-num-text: #24292f;
    --color-diff-blob-addition-fg: #24292f;
    --color-diff-blob-addition-num-bg: #ccffd8;
    --color-diff-blob-addition-line-bg: #e6ffec;
    --color-diff-blob-addition-word-bg: #abf2bc;
    --color-diff-blob-deletion-num-text: #24292f;
    --color-diff-blob-deletion-fg: #24292f;
    --color-diff-blob-deletion-num-bg: #ffd7d5;
    --color-diff-blob-deletion-line-bg: #ffebe9;
    --color-diff-blob-deletion-word-bg: rgba(255, 129, 130, 0.4);
    --color-diff-blob-hunk-num-bg: rgba(84, 174, 255, 0.4);
    --color-diff-blob-expander-icon: #57606a;
    --color-diff-blob-selected-line-highlight-mix-blend-mode: multiply;
    --color-diffstat-deletion-border: rgba(27, 31, 36, 0.15);
    --color-diffstat-addition-border: rgba(27, 31, 36, 0.15);
    --color-diffstat-addition-bg: #2da44e;
    --color-search-keyword-hl: #fff8c5;
    --color-prettylights-syntax-comment: #6e7781;
    --color-prettylights-syntax-constant: #0550ae;
    --color-prettylights-syntax-entity: #8250df;
    --color-prettylights-syntax-storage-modifier-import: #24292f;
    --color-prettylights-syntax-entity-tag: #116329;
    --color-prettylights-syntax-keyword: #cf222e;
    --color-prettylights-syntax-string: #0a3069;
    --color-prettylights-syntax-variable: #953800;
    --color-prettylights-syntax-brackethighlighter-unmatched: #82071e;
    --color-prettylights-syntax-invalid-illegal-text: #f6f8fa;
    --color-prettylights-syntax-invalid-illegal-bg: #82071e;
    --color-prettylights-syntax-carriage-return-text: #f6f8fa;
    --color-prettylights-syntax-carriage-return-bg: #cf222e;
    --color-prettylights-syntax-string-regexp: #116329;
    --color-prettylights-syntax-markup-list: #3b2300;
    --color-prettylights-syntax-markup-heading: #0550ae;
    --color-prettylights-syntax-markup-italic: #24292f;
    --color-prettylights-syntax-markup-bold: #24292f;
    --color-prettylights-syntax-markup-deleted-text: #82071e;
    --color-prettylights-syntax-markup-deleted-bg: #ffebe9;
    --color-prettylights-syntax-markup-inserted-text: #116329;
    --color-prettylights-syntax-markup-inserted-bg: #dafbe1;
    --color-prettylights-syntax-markup-changed-text: #953800;
    --color-prettylights-syntax-markup-changed-bg: #ffd8b5;
    --color-prettylights-syntax-markup-ignored-text: #eaeef2;
    --color-prettylights-syntax-markup-ignored-bg: #0550ae;
    --color-prettylights-syntax-meta-diff-range: #8250df;
    --color-prettylights-syntax-brackethighlighter-angle: #57606a;
    --color-prettylights-syntax-sublimelinter-gutter-mark: #8c959f;
    --color-prettylights-syntax-constant-other-reference-link: #0a3069;
    --color-codemirror-text: #24292f;
    --color-codemirror-bg: #ffffff;
    --color-codemirror-gutters-bg: #ffffff;
    --color-codemirror-guttermarker-text: #ffffff;
    --color-codemirror-guttermarker-subtle-text: #6e7781;
    --color-codemirror-linenumber-text: #57606a;
    --color-codemirror-cursor: #24292f;
    --color-codemirror-selection-bg: rgba(84, 174, 255, 0.4);
    --color-codemirror-activeline-bg: rgba(234, 238, 242, 0.5);
    --color-codemirror-matchingbracket-text: #24292f;
    --color-codemirror-lines-bg: #ffffff;
    --color-codemirror-syntax-comment: #24292f;
    --color-codemirror-syntax-constant: #0550ae;
    --color-codemirror-syntax-entity: #8250df;
    --color-codemirror-syntax-keyword: #cf222e;
    --color-codemirror-syntax-storage: #cf222e;
    --color-codemirror-syntax-string: #0a3069;
    --color-codemirror-syntax-support: #0550ae;
    --color-codemirror-syntax-variable: #953800;
    --color-checks-bg: #24292f;
    --color-checks-run-border-width: 0px;
    --color-checks-container-border-width: 0px;
    --color-checks-text-primary: #f6f8fa;
    --color-checks-text-secondary: #8c959f;
    --color-checks-text-link: #54aeff;
    --color-checks-btn-icon: #afb8c1;
    --color-checks-btn-hover-icon: #f6f8fa;
    --color-checks-btn-hover-bg: rgba(255, 255, 255, 0.125);
    --color-checks-input-text: #eaeef2;
    --color-checks-input-placeholder-text: #8c959f;
    --color-checks-input-focus-text: #8c959f;
    --color-checks-input-bg: #32383f;
    --color-checks-input-shadow: none;
    --color-checks-donut-error: #fa4549;
    --color-checks-donut-pending: #bf8700;
    --color-checks-donut-success: #2da44e;
    --color-checks-donut-neutral: #afb8c1;
    --color-checks-dropdown-text: #afb8c1;
    --color-checks-dropdown-bg: #32383f;
    --color-checks-dropdown-border: #424a53;
    --color-checks-dropdown-shadow: rgba(27, 31, 36, 0.3);
    --color-checks-dropdown-hover-text: #f6f8fa;
    --color-checks-dropdown-hover-bg: #424a53;
    --color-checks-dropdown-btn-hover-text: #f6f8fa;
    --color-checks-dropdown-btn-hover-bg: #32383f;
    --color-checks-scrollbar-thumb-bg: #57606a;
    --color-checks-header-label-text: #d0d7de;
    --color-checks-header-label-open-text: #f6f8fa;
    --color-checks-header-border: #32383f;
    --color-checks-header-icon: #8c959f;
    --color-checks-line-text: #d0d7de;
    --color-checks-line-num-text: rgba(140, 149, 159, 0.75);
    --color-checks-line-timestamp-text: #8c959f;
    --color-checks-line-hover-bg: #32383f;
    --color-checks-line-selected-bg: rgba(33, 139, 255, 0.15);
    --color-checks-line-selected-num-text: #54aeff;
    --color-checks-line-dt-fm-text: #24292f;
    --color-checks-line-dt-fm-bg: #9a6700;
    --color-checks-gate-bg: rgba(125, 78, 0, 0.15);
    --color-checks-gate-text: #d0d7de;
    --color-checks-gate-waiting-text: #d4a72c;
    --color-checks-step-header-open-bg: #32383f;
    --color-checks-step-error-text: #ff8182;
    --color-checks-step-warning-text: #d4a72c;
    --color-checks-logline-text: #8c959f;
    --color-checks-logline-num-text: rgba(140, 149, 159, 0.75);
    --color-checks-logline-debug-text: #c297ff;
    --color-checks-logline-error-text: #d0d7de;
    --color-checks-logline-error-num-text: #ff8182;
    --color-checks-logline-error-bg: rgba(164, 14, 38, 0.15);
    --color-checks-logline-warning-text: #d0d7de;
    --color-checks-logline-warning-num-text: #d4a72c;
    --color-checks-logline-warning-bg: rgba(125, 78, 0, 0.15);
    --color-checks-logline-command-text: #54aeff;
    --color-checks-logline-section-text: #4ac26b;
    --color-checks-ansi-black: #24292f;
    --color-checks-ansi-black-bright: #32383f;
    --color-checks-ansi-white: #d0d7de;
    --color-checks-ansi-white-bright: #d0d7de;
    --color-checks-ansi-gray: #8c959f;
    --color-checks-ansi-red: #ff8182;
    --color-checks-ansi-red-bright: #ffaba8;
    --color-checks-ansi-green: #4ac26b;
    --color-checks-ansi-green-bright: #6fdd8b;
    --color-checks-ansi-yellow: #d4a72c;
    --color-checks-ansi-yellow-bright: #eac54f;
    --color-checks-ansi-blue: #54aeff;
    --color-checks-ansi-blue-bright: #80ccff;
    --color-checks-ansi-magenta: #c297ff;
    --color-checks-ansi-magenta-bright: #d8b9ff;
    --color-checks-ansi-cyan: #76e3ea;
    --color-checks-ansi-cyan-bright: #b3f0ff;
    --color-project-header-bg: #24292f;
    --color-project-sidebar-bg: #ffffff;
    --color-project-gradient-in: #ffffff;
    --color-project-gradient-out: rgba(255, 255, 255, 0);
    --color-mktg-btn-bg: #1b1f23;
    --color-mktg-btn-shadow-outline: rgb(0 0 0 / 15%) 0 0 0 1px inset;
    --color-mktg-btn-shadow-focus: rgb(0 0 0 / 15%) 0 0 0 4px;
    --color-mktg-btn-shadow-hover: 0 3px 2px rgba(0, 0, 0, 0.07), 0 7px 5px rgba(0, 0, 0, 0.04), 0 12px 10px rgba(0, 0, 0, 0.03), 0 22px 18px rgba(0, 0, 0, 0.03), 0 42px 33px rgba(0, 0, 0, 0.02), 0 100px 80px rgba(0, 0, 0, 0.02);
    --color-mktg-btn-shadow-hover-muted: rgb(0 0 0 / 70%) 0 0 0 2px inset;
    --color-control-border-color-emphasis: #858F99;
    --color-avatar-bg: #ffffff;
    --color-avatar-border: rgba(27, 31, 36, 0.15);
    --color-avatar-stack-fade: #afb8c1;
    --color-avatar-stack-fade-more: #d0d7de;
    --color-avatar-child-shadow: -2px -2px 0 rgba(255, 255, 255, 0.8);
    --color-topic-tag-border: rgba(0, 0, 0, 0);
    --color-counter-border: rgba(0, 0, 0, 0);
    --color-select-menu-backdrop-border: rgba(0, 0, 0, 0);
    --color-select-menu-tap-highlight: rgba(175, 184, 193, 0.5);
    --color-select-menu-tap-focus-bg: #b6e3ff;
    --color-overlay-shadow: 0 1px 3px rgba(27, 31, 36, 0.12), 0 8px 24px rgba(66, 74, 83, 0.12);
    --color-header-text: rgba(255, 255, 255, 0.7);
    --color-header-bg: #24292f;
    --color-header-divider: #57606a;
    --color-header-logo: #ffffff;
    --color-header-search-bg: #24292f;
    --color-header-search-border: #57606a;
    --color-sidenav-selected-bg: #ffffff;
    --color-menu-bg-active: rgba(0, 0, 0, 0);
    --color-input-disabled-bg: rgba(175, 184, 193, 0.2);
    --color-timeline-badge-bg: #eaeef2;
    --color-ansi-black: #24292f;
    --color-ansi-black-bright: #57606a;
    --color-ansi-white: #6e7781;
    --color-ansi-white-bright: #8c959f;
    --color-ansi-gray: #6e7781;
    --color-ansi-red: #cf222e;
    --color-ansi-red-bright: #a40e26;
    --color-ansi-green: #116329;
    --color-ansi-green-bright: #1a7f37;
    --color-ansi-yellow: #4d2d00;
    --color-ansi-yellow-bright: #633c01;
    --color-ansi-blue: #0969da;
    --color-ansi-blue-bright: #218bff;
    --color-ansi-magenta: #8250df;
    --color-ansi-magenta-bright: #a475f9;
    --color-ansi-cyan: #1b7c83;
    --color-ansi-cyan-bright: #3192aa;
    --color-btn-text: #24292f;
    --color-btn-bg: #f6f8fa;
    --color-btn-border: rgba(27, 31, 36, 0.15);
    --color-btn-shadow: 0 1px 0 rgba(27, 31, 36, 0.04);
    --color-btn-inset-shadow: inset 0 1px 0 rgba(255, 255, 255, 0.25);
    --color-btn-hover-bg: #f3f4f6;
    --color-btn-hover-border: rgba(27, 31, 36, 0.15);
    --color-btn-active-bg: hsla(220, 14%, 93%, 1);
    --color-btn-active-border: rgba(27, 31, 36, 0.15);
    --color-btn-selected-bg: hsla(220, 14%, 94%, 1);
    --color-btn-counter-bg: rgba(27, 31, 36, 0.08);
    --color-btn-primary-text: #ffffff;
    --color-btn-primary-bg: #2da44e;
    --color-btn-primary-border: rgba(27, 31, 36, 0.15);
    --color-btn-primary-shadow: 0 1px 0 rgba(27, 31, 36, 0.1);
    --color-btn-primary-inset-shadow: inset 0 1px 0 rgba(255, 255, 255, 0.03);
    --color-btn-primary-hover-bg: #2c974b;
    --color-btn-primary-hover-border: rgba(27, 31, 36, 0.15);
    --color-btn-primary-selected-bg: hsla(137, 55%, 36%, 1);
    --color-btn-primary-selected-shadow: inset 0 1px 0 rgba(0, 45, 17, 0.2);
    --color-btn-primary-disabled-text: rgba(255, 255, 255, 0.8);
    --color-btn-primary-disabled-bg: #94d3a2;
    --color-btn-primary-disabled-border: rgba(27, 31, 36, 0.15);
    --color-btn-primary-icon: rgba(255, 255, 255, 0.8);
    --color-btn-primary-counter-bg: rgba(255, 255, 255, 0.2);
    --color-btn-outline-text: #0969da;
    --color-btn-outline-hover-text: #ffffff;
    --color-btn-outline-hover-bg: #0969da;
    --color-btn-outline-hover-border: rgba(27, 31, 36, 0.15);
    --color-btn-outline-hover-shadow: 0 1px 0 rgba(27, 31, 36, 0.1);
    --color-btn-outline-hover-inset-shadow: inset 0 1px 0 rgba(255, 255, 255, 0.03);
    --color-btn-outline-hover-counter-bg: rgba(255, 255, 255, 0.2);
    --color-btn-outline-selected-text: #ffffff;
    --color-btn-outline-selected-bg: hsla(212, 92%, 42%, 1);
    --color-btn-outline-selected-border: rgba(27, 31, 36, 0.15);
    --color-btn-outline-selected-shadow: inset 0 1px 0 rgba(0, 33, 85, 0.2);
    --color-btn-outline-disabled-text: rgba(9, 105, 218, 0.5);
    --color-btn-outline-disabled-bg: #f6f8fa;
    --color-btn-outline-disabled-counter-bg: rgba(9, 105, 218, 0.05);
    --color-btn-outline-counter-bg: rgba(9, 105, 218, 0.1);
    --color-btn-danger-text: #cf222e;
    --color-btn-danger-hover-text: #ffffff;
    --color-btn-danger-hover-bg: #a40e26;
    --color-btn-danger-hover-border: rgba(27, 31, 36, 0.15);
    --color-btn-danger-hover-shadow: 0 1px 0 rgba(27, 31, 36, 0.1);
    --color-btn-danger-hover-inset-shadow: inset 0 1px 0 rgba(255, 255, 255, 0.03);
    --color-btn-danger-hover-counter-bg: rgba(255, 255, 255, 0.2);
    --color-btn-danger-selected-text: #ffffff;
    --color-btn-danger-selected-bg: hsla(356, 72%, 44%, 1);
    --color-btn-danger-selected-border: rgba(27, 31, 36, 0.15);
    --color-btn-danger-selected-shadow: inset 0 1px 0 rgba(76, 0, 20, 0.2);
    --color-btn-danger-disabled-text: rgba(207, 34, 46, 0.5);
    --color-btn-danger-disabled-bg: #f6f8fa;
    --color-btn-danger-disabled-counter-bg: rgba(207, 34, 46, 0.05);
    --color-btn-danger-counter-bg: rgba(207, 34, 46, 0.1);
    --color-btn-danger-icon: #cf222e;
    --color-btn-danger-hover-icon: #ffffff;
    --color-underlinenav-icon: #6e7781;
    --color-underlinenav-border-hover: rgba(175, 184, 193, 0.2);
    --color-action-list-item-inline-divider: rgba(208, 215, 222, 0.48);
    --color-action-list-item-default-hover-bg: rgba(208, 215, 222, 0.32);
    --color-action-list-item-default-hover-border: rgba(0, 0, 0, 0);
    --color-action-list-item-default-active-bg: rgba(208, 215, 222, 0.48);
    --color-action-list-item-default-active-border: rgba(0, 0, 0, 0);
    --color-action-list-item-default-selected-bg: rgba(208, 215, 222, 0.24);
    --color-action-list-item-danger-hover-bg: rgba(255, 235, 233, 0.64);
    --color-action-list-item-danger-active-bg: #ffebe9;
    --color-action-list-item-danger-hover-text: #cf222e;
    --color-switch-track-bg: #eaeef2;
    --color-switch-track-hover-bg: hsla(210, 24%, 90%, 1);
    --color-switch-track-active-bg: hsla(210, 24%, 88%, 1);
    --color-switch-track-disabled-bg: #8c959f;
    --color-switch-track-fg: #57606a;
    --color-switch-track-disabled-fg: #ffffff;
    --color-switch-track-border: rgba(0, 0, 0, 0);
    --color-switch-track-checked-bg: #0969da;
    --color-switch-track-checked-hover-bg: #0860CA;
    --color-switch-track-checked-active-bg: #0757BA;
    --color-switch-track-checked-fg: #ffffff;
    --color-switch-track-checked-disabled-fg: #ffffff;
    --color-switch-track-checked-border: rgba(0, 0, 0, 0);
    --color-switch-knob-bg: #ffffff;
    --color-switch-knob-disabled-bg: #f6f8fa;
    --color-switch-knob-border: #858F99;
    --color-switch-knob-checked-bg: #ffffff;
    --color-switch-knob-checked-disabled-bg: #f6f8fa;
    --color-switch-knob-checked-border: #0969da;
    --color-segmented-control-bg: #eaeef2;
    --color-segmented-control-button-bg: #ffffff;
    --color-segmented-control-button-hover-bg: rgba(175, 184, 193, 0.2);
    --color-segmented-control-button-active-bg: rgba(175, 184, 193, 0.4);
    --color-segmented-control-button-selected-border: #8c959f;
    --color-tree-view-item-chevron-hover-bg: rgba(208, 215, 222, 0.32);
    --color-tree-view-item-directory-fill: #54aeff;
    //--color-fg-default: #24292f;
    --color-fg-muted: #57606a;
    --color-fg-subtle: #6e7781;
    --color-fg-on-emphasis: #ffffff;
    //--color-canvas-default: #ffffff;
    --color-canvas-overlay: #ffffff;
    --color-canvas-inset: #f6f8fa;
    --color-canvas-subtle: #f6f8fa;
    --color-border-default: #d0d7de;
    --color-border-muted: hsla(210, 18%, 87%, 1);
    --color-border-subtle: rgba(27, 31, 36, 0.15);
    --color-shadow-small: 0 1px 0 rgba(27, 31, 36, 0.04);
    --color-shadow-medium: 0 3px 6px rgba(140, 149, 159, 0.15);
    --color-shadow-large: 0 8px 24px rgba(140, 149, 159, 0.2);
    --color-shadow-extra-large: 0 12px 28px rgba(140, 149, 159, 0.3);
    --color-neutral-emphasis-plus: #24292f;
    --color-neutral-emphasis: #6e7781;
    --color-neutral-muted: rgba(175, 184, 193, 0.2);
    --color-neutral-subtle: rgba(234, 238, 242, 0.5);
    --color-accent-fg: #0969da;
    --color-accent-emphasis: #0969da;
    --color-accent-muted: rgba(84, 174, 255, 0.4);
    --color-accent-subtle: #ddf4ff;
    --color-success-fg: #1a7f37;
    --color-success-emphasis: #2da44e;
    --color-success-muted: rgba(74, 194, 107, 0.4);
    --color-success-subtle: #dafbe1;
    --color-attention-fg: #9a6700;
    --color-attention-emphasis: #bf8700;
    --color-attention-muted: rgba(212, 167, 44, 0.4);
    --color-attention-subtle: #fff8c5;
    --color-severe-fg: #bc4c00;
    --color-severe-emphasis: #bc4c00;
    --color-severe-muted: rgba(251, 143, 68, 0.4);
    --color-severe-subtle: #fff1e5;
    --color-danger-fg: #cf222e;
    --color-danger-emphasis: #cf222e;
    --color-danger-muted: rgba(255, 129, 130, 0.4);
    --color-danger-subtle: #ffebe9;
    --color-open-fg: #1a7f37;
    --color-open-emphasis: #2da44e;
    --color-open-muted: rgba(74, 194, 107, 0.4);
    --color-open-subtle: #dafbe1;
    --color-closed-fg: #cf222e;
    --color-closed-emphasis: #cf222e;
    --color-closed-muted: rgba(255, 129, 130, 0.4);
    --color-closed-subtle: #ffebe9;
    --color-done-fg: #8250df;
    --color-done-emphasis: #8250df;
    --color-done-muted: rgba(194, 151, 255, 0.4);
    --color-done-subtle: #fbefff;
    --color-sponsors-fg: #bf3989;
    --color-sponsors-emphasis: #bf3989;
    --color-sponsors-muted: rgba(255, 128, 200, 0.4);
    --color-sponsors-subtle: #ffeff7;
    --color-primer-fg-disabled: #8c959f;
    --color-primer-canvas-backdrop: rgba(27, 31, 36, 0.5);
    --color-primer-canvas-sticky: rgba(255, 255, 255, 0.95);
    --color-primer-border-active: #fd8c73;
    --color-primer-border-contrast: rgba(27, 31, 36, 0.1);
    --color-primer-shadow-highlight: inset 0 1px 0 rgba(255, 255, 255, 0.25);
    --color-primer-shadow-inset: inset 0 1px 0 rgba(208, 215, 222, 0.2);
    --color-scale-black: #1b1f24;
    --color-scale-white: #ffffff;
    --color-scale-gray-0: #f6f8fa;
    --color-scale-gray-1: #eaeef2;
    --color-scale-gray-2: #d0d7de;
    --color-scale-gray-3: #afb8c1;
    --color-scale-gray-4: #8c959f;
    --color-scale-gray-5: #6e7781;
    --color-scale-gray-6: #57606a;
    --color-scale-gray-7: #424a53;
    --color-scale-gray-8: #32383f;
    --color-scale-gray-9: #24292f;
    --color-scale-blue-0: #ddf4ff;
    --color-scale-blue-1: #b6e3ff;
    --color-scale-blue-2: #80ccff;
    --color-scale-blue-3: #54aeff;
    --color-scale-blue-4: #218bff;
    --color-scale-blue-5: #0969da;
    --color-scale-blue-6: #0550ae;
    --color-scale-blue-7: #033d8b;
    --color-scale-blue-8: #0a3069;
    --color-scale-blue-9: #002155;
    --color-scale-green-0: #dafbe1;
    --color-scale-green-1: #aceebb;
    --color-scale-green-2: #6fdd8b;
    --color-scale-green-3: #4ac26b;
    --color-scale-green-4: #2da44e;
    --color-scale-green-5: #1a7f37;
    --color-scale-green-6: #116329;
    --color-scale-green-7: #044f1e;
    --color-scale-green-8: #003d16;
    --color-scale-green-9: #002d11;
    --color-scale-yellow-0: #fff8c5;
    --color-scale-yellow-1: #fae17d;
    --color-scale-yellow-2: #eac54f;
    --color-scale-yellow-3: #d4a72c;
    --color-scale-yellow-4: #bf8700;
    --color-scale-yellow-5: #9a6700;
    --color-scale-yellow-6: #7d4e00;
    --color-scale-yellow-7: #633c01;
    --color-scale-yellow-8: #4d2d00;
    --color-scale-yellow-9: #3b2300;
    --color-scale-orange-0: #fff1e5;
    --color-scale-orange-1: #ffd8b5;
    --color-scale-orange-2: #ffb77c;
    --color-scale-orange-3: #fb8f44;
    --color-scale-orange-4: #e16f24;
    --color-scale-orange-5: #bc4c00;
    --color-scale-orange-6: #953800;
    --color-scale-orange-7: #762c00;
    --color-scale-orange-8: #5c2200;
    --color-scale-orange-9: #471700;
    --color-scale-red-0: #ffebe9;
    --color-scale-red-1: #ffcecb;
    --color-scale-red-2: #ffaba8;
    --color-scale-red-3: #ff8182;
    --color-scale-red-4: #fa4549;
    --color-scale-red-5: #cf222e;
    --color-scale-red-6: #a40e26;
    --color-scale-red-7: #82071e;
    --color-scale-red-8: #660018;
    --color-scale-red-9: #4c0014;
    --color-scale-purple-0: #fbefff;
    --color-scale-purple-1: #ecd8ff;
    --color-scale-purple-2: #d8b9ff;
    --color-scale-purple-3: #c297ff;
    --color-scale-purple-4: #a475f9;
    --color-scale-purple-5: #8250df;
    --color-scale-purple-6: #6639ba;
    --color-scale-purple-7: #512a97;
    --color-scale-purple-8: #3e1f79;
    --color-scale-purple-9: #2e1461;
    --color-scale-pink-0: #ffeff7;
    --color-scale-pink-1: #ffd3eb;
    --color-scale-pink-2: #ffadda;
    --color-scale-pink-3: #ff80c8;
    --color-scale-pink-4: #e85aad;
    --color-scale-pink-5: #bf3989;
    --color-scale-pink-6: #99286e;
    --color-scale-pink-7: #772057;
    --color-scale-pink-8: #611347;
    --color-scale-pink-9: #4d0336;
    --color-scale-coral-0: #fff0eb;
    --color-scale-coral-1: #ffd6cc;
    --color-scale-coral-2: #ffb4a1;
    --color-scale-coral-3: #fd8c73;
    --color-scale-coral-4: #ec6547;
    --color-scale-coral-5: #c4432b;
    --color-scale-coral-6: #9e2f1c;
    --color-scale-coral-7: #801f0f;
    --color-scale-coral-8: #691105;
    --color-scale-coral-9: #510901
}

.gist .markdown-body {
    font-family: -apple-system, BlinkMacSystemFont, "Segoe UI", "Noto Sans", Helvetica, Arial, sans-serif, "Apple Color Emoji", "Segoe UI Emoji";
    font-size: 16px;
    line-height: 1.5;
    word-wrap:break-word
}

.gist .markdown-body::before {
    display: table;
    content: ""
}

.gist .markdown-body::after {
    display: table;
    clear: both;
    content: ""
}

.gist .markdown-body > * :first-child {
    margin-top:0 !important
}

.gist .markdown-body > * :last-child {
    margin-bottom:0 !important
}

.gist .markdown-body a:not([href]) {
    color: inherit;
    text-decoration:none
}

.gist .markdown-body .absent {
    color:var(--color-danger-fg)
}

.gist .markdown-body .anchor {
    float: left;
    padding-right: 4px;
    margin-left: -20px;
    line-height:1
}

.gist .markdown-body .anchor:focus {
    outline:none
}

.gist .markdown-body p, .gist .markdown-body blockquote, .gist .markdown-body ul, .gist .markdown-body ol, .gist .markdown-body dl, .gist .markdown-body table, .gist .markdown-body pre, .gist .markdown-body details {
    margin-top: 0;
    margin-bottom:16px
}

.gist .markdown-body hr {
    height: .25em;
    padding: 0;
    margin: 24px 0;
    background-color: var(--color-border-default);
    border:0
}

.gist .markdown-body blockquote {
    padding: 0 1em;
    color: var(--color-fg-muted);
    border-left:.25em solid var(--color-border-default)
}

.gist .markdown-body blockquote > :first-child {
    margin-top:0
}

.gist .markdown-body blockquote > :last-child {
    margin-bottom:0
}

.gist .markdown-body h1, .gist .markdown-body h2, .gist .markdown-body h3, .gist .markdown-body h4, .gist .markdown-body h5, .gist .markdown-body h6 {
    margin-top: 24px;
    margin-bottom: 16px;
    font-weight: var(--base-text-weight-semibold, 600);
    line-height:1.25
}

.gist .markdown-body h1 .octicon-link, .gist .markdown-body h2 .octicon-link, .gist .markdown-body h3 .octicon-link, .gist .markdown-body h4 .octicon-link, .gist .markdown-body h5 .octicon-link, .gist .markdown-body h6 .octicon-link {
    color: var(--color-fg-default);
    vertical-align: middle;
    visibility:hidden
}

.gist .markdown-body h1:hover .anchor, .gist .markdown-body h2:hover .anchor, .gist .markdown-body h3:hover .anchor, .gist .markdown-body h4:hover .anchor, .gist .markdown-body h5:hover .anchor, .gist .markdown-body h6:hover .anchor {
    text-decoration:none
}

.gist .markdown-body h1:hover .anchor .octicon-link, .gist .markdown-body h2:hover .anchor .octicon-link, .gist .markdown-body h3:hover .anchor .octicon-link, .gist .markdown-body h4:hover .anchor .octicon-link, .gist .markdown-body h5:hover .anchor .octicon-link, .gist .markdown-body h6:hover .anchor .octicon-link {
    visibility:visible
}

.gist .markdown-body h1 tt, .gist .markdown-body h1 code, .gist .markdown-body h2 tt, .gist .markdown-body h2 code, .gist .markdown-body h3 tt, .gist .markdown-body h3 code, .gist .markdown-body h4 tt, .gist .markdown-body h4 code, .gist .markdown-body h5 tt, .gist .markdown-body h5 code, .gist .markdown-body h6 tt, .gist .markdown-body h6 code {
    padding: 0 .2em;
    font-size:inherit
}

.gist .markdown-body h1 {
    padding-bottom: .3em;
    font-size: 2em;
    border-bottom:1px solid var(--color-border-muted)
}

.gist .markdown-body h2 {
    padding-bottom: .3em;
    font-size: 1.5em;
    border-bottom:1px solid var(--color-border-muted)
}

.gist .markdown-body h3 {
    font-size:1.25em
}

.gist .markdown-body h4 {
    font-size:1em
}

.gist .markdown-body h5 {
    font-size:.875em
}

.gist .markdown-body h6 {
    font-size: .85em;
    color:var(--color-fg-muted)
}

.gist .markdown-body summary h1, .gist .markdown-body summary h2, .gist .markdown-body summary h3, .gist .markdown-body summary h4, .gist .markdown-body summary h5, .gist .markdown-body summary h6 {
    display:inline-block
}

.gist .markdown-body summary h1 .anchor, .gist .markdown-body summary h2 .anchor, .gist .markdown-body summary h3 .anchor, .gist .markdown-body summary h4 .anchor, .gist .markdown-body summary h5 .anchor, .gist .markdown-body summary h6 .anchor {
    margin-left:-40px
}

.gist .markdown-body summary h1, .gist .markdown-body summary h2 {
    padding-bottom: 0;
    border-bottom:0
}

.gist .markdown-body ul, .gist .markdown-body ol {
    padding-left:2em
}

.gist .markdown-body ul.no-list, .gist .markdown-body ol.no-list {
    padding: 0;
    list-style-type:none
}

.gist .markdown-body ol[type=a] {
    list-style-type:lower-alpha
}

.gist .markdown-body ol[type=A] {
    list-style-type:upper-alpha
}

.gist .markdown-body ol[type=i] {
    list-style-type:lower-roman
}

.gist .markdown-body ol[type=I] {
    list-style-type: upper-roman
}

.gist .markdown-body ol[type="1"] {
    list-style-type:decimal
}

.gist .markdown-body div > ol:not([type]) {
    list-style-type:decimal
}

.gist .markdown-body ul ul, .gist .markdown-body ul ol, .gist .markdown-body ol ol, .gist .markdown-body ol ul {
    margin-top: 0;
    margin-bottom:0
}

.gist .markdown-body li > p {
    margin-top:16px
}

.gist .markdown-body li + li {
    margin-top:.25em
}

.gist .markdown-body dl {
    padding:0
}

.gist .markdown-body dl dt {
    padding: 0;
    margin-top: 16px;
    font-size: 1em;
    font-style: italic;
    font-weight:var(--base-text-weight-semibold, 600)
}

.gist .markdown-body dl dd {
    padding: 0 16px;
    margin-bottom:16px
}

.gist .markdown-body table {
    display: block;
    width: 100%;
    width: max-content;
    max-width: 100%;
    overflow:auto
}

.gist .markdown-body table th {
    font-weight:var(--base-text-weight-semibold, 600)
}

.gist .markdown-body table th, .gist .markdown-body table td {
    padding: 6px 13px;
    border:1px solid var(--color-border-default)
}

.gist .markdown-body table td > :last-child {
    margin-bottom:0
}

.gist .markdown-body table tr {
    background-color: var(--color-canvas-default);
    border-top:1px solid var(--color-border-muted)
}

.gist .markdown-body table tr:nth-child(2n) {
    background-color:var(--color-canvas-subtle)
}

.gist .markdown-body table img {
    background-color:transparent
}

.gist .markdown-body img {
    max-width: 100%;
    box-sizing: content-box;
    background-color:var(--color-canvas-default)
}

.gist .markdown-body img[align=right] {
    padding-left:20px
}

.gist .markdown-body img[align=left] {
    padding-right:20px
}

.gist .markdown-body .emoji {
    max-width: none;
    vertical-align: text-top;
    background-color:transparent
}

.gist .markdown-body span.frame {
    display: block;
    overflow:hidden
}

.gist .markdown-body span.frame > span {
    display: block;
    float: left;
    width: auto;
    padding: 7px;
    margin: 13px 0 0;
    overflow: hidden;
    border:1px solid var(--color-border-default)
}

.gist .markdown-body span.frame span img {
    display: block;
    float:left
}

.gist .markdown-body span.frame span span {
    display: block;
    padding: 5px 0 0;
    clear: both;
    color:var(--color-fg-default)
}

.gist .markdown-body span.align-center {
    display: block;
    overflow: hidden;
    clear:both
}

.gist .markdown-body span.align-center > span {
    display: block;
    margin: 13px auto 0;
    overflow: hidden;
    text-align:center
}

.gist .markdown-body span.align-center span img {
    margin: 0 auto;
    text-align:center
}

.gist .markdown-body span.align-right {
    display: block;
    overflow: hidden;
    clear:both
}

.gist .markdown-body span.align-right > span {
    display: block;
    margin: 13px 0 0;
    overflow: hidden;
    text-align:right
}

.gist .markdown-body span.align-right span img {
    margin: 0;
    text-align:right
}

.gist .markdown-body span.float-left {
    display: block;
    float: left;
    margin-right: 13px;
    overflow:hidden
}

.gist .markdown-body span.float-left span {
    margin:13px 0 0
}

.gist .markdown-body span.float-right {
    display: block;
    float: right;
    margin-left: 13px;
    overflow:hidden
}

.gist .markdown-body span.float-right > span {
    display: block;
    margin: 13px auto 0;
    overflow: hidden;
    text-align:right
}

.gist .markdown-body code, .gist .markdown-body tt {
    padding: .2em .4em;
    margin: 0;
    font-size: 85%;
    white-space: break-spaces;
    background-color: var(--color-neutral-muted);
    border-radius:6px
}

.gist .markdown-body code br, .gist .markdown-body tt br {
    display:none
}

.gist .markdown-body del code {
    text-decoration:inherit
}

.gist .markdown-body samp {
    font-size:85%
}

.gist .markdown-body pre {
    word-wrap:normal
}

.gist .markdown-body pre code {
    font-size:100%
}

.gist .markdown-body pre > code {
    padding: 0;
    margin: 0;
    word-break: normal;
    white-space: pre;
    background: transparent;
    border:0
}

.gist .markdown-body .highlight {
    margin-bottom:16px
}

.gist .markdown-body .highlight pre {
    margin-bottom: 0;
    word-break:normal
}

.gist .markdown-body .highlight pre, .gist .markdown-body pre {
    padding: 16px;
    overflow: auto;
    font-size: 85%;
    line-height: 1.45;
    color: var(--color-fg-default);
    background-color: var(--color-canvas-subtle);
    border-radius:6px
}

.gist .markdown-body pre code, .gist .markdown-body pre tt {
    display: inline;
    max-width: auto;
    padding: 0;
    margin: 0;
    overflow: visible;
    line-height: inherit;
    word-wrap: normal;
    background-color: transparent;
    border:0
}

.gist .markdown-body .csv-data td, .gist .markdown-body .csv-data th {
    padding: 5px;
    overflow: hidden;
    font-size: 12px;
    line-height: 1;
    text-align: left;
    white-space:nowrap
}

.gist .markdown-body .csv-data .blob-num {
    padding: 10px 8px 9px;
    text-align: right;
    background: var(--color-canvas-default);
    border:0
}

.gist .markdown-body .csv-data tr {
    border-top:0
}

.gist .markdown-body .csv-data th {
    font-weight: var(--base-text-weight-semibold, 600);
    background: var(--color-canvas-subtle);
    border-top:0
}

.gist .markdown-body [data-footnote-ref]::before {
    content: "["
}

.gist .markdown-body [data-footnote-ref]::after {
    content: "]"
}

.gist .markdown-body .footnotes {
    font-size: 12px;
    color: var(--color-fg-muted);
    border-top:1px solid var(--color-border-default)
}

.gist .markdown-body .footnotes ol {
    padding-left:16px
}

.gist .markdown-body .footnotes ol ul {
    display: inline-block;
    padding-left: 16px;
    margin-top:16px
}

.gist .markdown-body .footnotes li {
    position:relative
}

.gist .markdown-body .footnotes li:target::before {
    position: absolute;
    top: -8px;
    right: -8px;
    bottom: -8px;
    left: -24px;
    pointer-events: none;
    content: "";
    border: 2px solid var(--color-accent-emphasis);
    border-radius:6px
}

.gist .markdown-body .footnotes li:target {
    color:var(--color-fg-default)
}

.gist .markdown-body .footnotes .data-footnote-backref g-emoji {
    font-family:monospace
}

.gist .pl-c {
    color:#5d6c79
}

.gist .pl-c1, .gist .pl-s .pl-v {
    color:#005cc5
}

.gist .pl-e, .gist .pl-en {
    color:#6f42c1
}

.gist .pl-smi, .gist .pl-s .pl-s1 {
    color:#24292e
}

.gist .pl-ent {
    color:#22863a
}

.gist .pl-k {
    font-weight:600;
    color:#9b2393
}

.gist .pl-s, .gist .pl-pds, .gist .pl-s .pl-pse .pl-s1, .gist .pl-sr, .gist .pl-sr .pl-cce, .gist .pl-sr .pl-sre, .gist .pl-sr .pl-sra {
    color:#032f62
}

.gist .pl-v, .gist .pl-smw {
    color:#e36209
}

.gist .pl-bu {
    color:#b31d28
}

.gist .pl-ii {
    color: #fafbfc;
    background-color:#b31d28
}

.gist .pl-c2 {
    color: #fafbfc;
    background-color:#d73a49
}

.gist .pl-c2::before {
    content: "^M"
}

.gist .pl-sr .pl-cce {
    font-weight: bold;
    color:#22863a
}

.gist .pl-ml {
    color:#735c0f
}

.gist .pl-mh, .gist .pl-mh .pl-en, .gist .pl-ms {
    font-weight: bold;
    color:#005cc5
}

.gist .pl-mi {
    font-style: italic;
    color:#24292e
}

.gist .pl-mb {
    font-weight: bold;
    color:#24292e
}

.gist .pl-md {
    color: #b31d28;
    background-color:#ffeef0
}

.gist .pl-mi1 {
    color: #22863a;
    background-color:#f0fff4
}

.gist .pl-mc {
    color: #e36209;
    background-color:#ffebda
}

.gist .pl-mi2 {
    color: #f6f8fa;
    background-color:#005cc5
}

.gist .pl-mdr {
    font-weight: bold;
    color:#6f42c1
}

.gist .pl-ba {
    color:#586069
}

.gist .pl-sg {
    color:#959da5
}

.gist .pl-corl {
    text-decoration: underline;
    color:#032f62
}

.gist .breadcrumb {
    font-size: 16px;
    color:var(--color-fg-muted)
}

.gist .breadcrumb .separator {
    white-space:pre-wrap
}

.gist .breadcrumb .separator::before, .gist .breadcrumb .separator::after {
    content: " "
}

.gist .breadcrumb strong.final-path {
    color:var(--color-fg-default)
}

.gist .blob-interaction-bar {
    position: relative;
    background-color: var(--color-canvas-subtle);
    border-bottom:1px solid var(--color-border-default)
}

.gist .blob-interaction-bar::before {
    display: table;
    content: ""
}

.gist .blob-interaction-bar::after {
    display: table;
    clear: both;
    content: ""
}

.gist .blob-interaction-bar .octicon-search {
    position: absolute;
    top: 6px;
    left: 10px;
    font-size: 12px;
    color:var(--color-fg-muted)
}

.gist .blob-filter {
    width: 100%;
    padding: 4px 16px 4px 32px;
    font-size: 12px;
    border: 0;
    border-radius: 0;
    outline:none
}

.gist .blob-filter:focus {
    outline:none
}

.gist .TagsearchPopover {
    width: inherit;
    max-width:600px
}

.gist .TagsearchPopover-content {
    max-height:300px
}

.gist .TagsearchPopover-list .TagsearchPopover-list-item:hover {
    background-color:var(--color-canvas-subtle)
}

.gist .TagsearchPopover-list .TagsearchPopover-list-item .TagsearchPopover-item:hover {
    text-decoration:none
}

.gist .TagsearchPopover-list .blob-code-inner {
    white-space:pre-wrap
}

.gist .diff-table .line-alert, .gist .blob-code-content .line-alert {
    position: absolute;
    left: 0;
    margin:-2px 2px
}

.gist .diff-table .codeowners-error, .gist .blob-code-content .codeowners-error {
    color:var(--color-danger-fg)
}

.gist .diff-table .error-highlight, .gist .blob-code-content .error-highlight {
    position: relative;
    cursor: help;
    font-style: italic;
    color:var(--color-danger-fg)
}

.gist .diff-table .error-highlight::before, .gist .blob-code-content .error-highlight::before {
    position: absolute;
    top: 101%;
    width: 100%;
    height: .25em;
    content: "";
    background: linear-gradient(135deg, transparent, transparent 45%, var(--color-danger-fg), transparent 55%, transparent 100%), linear-gradient(45deg, transparent, transparent 45%, var(--color-danger-fg), transparent 55%, transparent 100%);
    background-repeat: repeat-x, repeat-x;
    background-size:.5em .5em
}

.gist .blob-code-content .blob-num .line-alert {
    margin-top:1px
}

.gist .diff-table .blob-num .line-alert {
    margin:2px -2px
}

.gist .csv-data .line-alert {
    position: absolute;
    margin:2px 4px
}

.gist .CopyBlock {
    line-height: 20px;
    cursor:pointer
}

.gist .CopyBlock .octicon-copy {
    display:none
}

.gist .CopyBlock:hover, .gist .CopyBlock:focus, .gist .CopyBlock:active {
    background-color: var(--color-canvas-default);
    outline:none
}

.gist .CopyBlock:hover .octicon-copy, .gist .CopyBlock:focus .octicon-copy, .gist .CopyBlock:active .octicon-copy {
    display:inline-block
}

.gist .blob-header.is-stuck {
    border-top: 0;
    border-top-left-radius: 0;
    border-top-right-radius:0
}

.gist .blob-wrapper {
    overflow-x: auto;
    overflow-y:hidden
}

.gist .blob-wrapper table tr:nth-child(2n) {
    background-color:transparent
}

.gist .page-edit-blob.height-full .CodeMirror {
    height:300px
}

.gist .page-edit-blob.height-full .CodeMirror, .gist .page-edit-blob.height-full .CodeMirror-scroll {
    display: flex;
    flex-direction: column;
    flex:1 1 auto
}

.gist .blob-wrapper-embedded {
    max-height: 240px;
    overflow-y:auto
}

.gist .diff-table {
    width: 100%;
    border-collapse:separate
}

.gist .diff-table .blob-code.blob-code-inner {
    padding-left:22px
}

.gist .diff-table .line-comments {
    padding: 10px;
    vertical-align: top;
    border-top:1px solid var(--color-border-default)
}

.gist .diff-table .line-comments:first-child + .empty-cell {
    border-left-width:1px
}

.gist .diff-table tr:not(:last-child) .line-comments {
    border-top: 1px solid var(--color-border-default);
    border-bottom:1px solid var(--color-border-default)
}

.gist .diff-view .blob-code-marker-context::before, .gist .diff-view .blob-code-marker-injected_context::before, .gist .diff-view .blob-code-marker-addition::before, .gist .diff-view .blob-code-marker-deletion::before {
    top:4px
}

.gist .diff-view .line-alert, .gist .diff-table .line-alert {
    position: absolute;
    left: -60px;
    margin:2px
}

.gist .comment-body .diff-view .line-alert {
    left:0
}

.gist .blob-num {
    position: relative;
    width: 1%;
    min-width: 50px;
    padding-right: 10px;
    padding-left: 10px;
    font-family: ui-monospace, SFMono-Regular, SF Mono, Menlo, Consolas, Liberation Mono, monospace;
    font-size: 12px;
    line-height: 20px;
    color: var(--color-fg-subtle);
    text-align: right;
    white-space: nowrap;
    vertical-align: top;
    cursor: pointer;
    -webkit-user-select: none;
    user-select:none
}

.gist .blob-num:hover {
    color:var(--color-fg-default)
}

.gist .blob-num::before {
    content:attr(data-line-number)
}

.gist .blob-num.non-expandable {
    cursor:default
}

.gist .blob-num.non-expandable:hover {
    color:var(--color-fg-subtle)
}

.gist .blob-num-hidden::before {
    visibility:hidden
}

.gist .blob-code {
    position: relative;
    padding-right: 10px;
    padding-left: 10px;
    line-height: 20px;
    vertical-align:top
}

.gist .blob-code-inner {
    display: table-cell;
    overflow: visible;
    font-family: ui-monospace, SFMono-Regular, SF Mono, Menlo, Consolas, Liberation Mono, monospace;
    font-size: 12px;
    color: var(--color-fg-default);
    word-wrap: anywhere;
    white-space:pre
}

.gist .blob-code-inner .x-first {
    border-top-left-radius: .2em;
    border-bottom-left-radius:.2em
}

.gist .blob-code-inner .x-last {
    border-top-right-radius: .2em;
    border-bottom-right-radius:.2em
}

.gist .blob-code-inner.highlighted, .gist .blob-code-inner .highlighted {
    background-color: var(--color-attention-subtle);
    box-shadow:inset 2px 0 0 var(--color-attention-muted)
}

.gist .blob-code-inner::selection, .gist .blob-code-inner * ::selection {
    background-color:var(--color-accent-muted)
}

.gist .js-blob-wrapper .blob-code-inner {
    white-space:pre-wrap
}

.gist .blob-code-inner.blob-code-addition, .gist .blob-code-inner.blob-code-deletion {
    position: relative;
    padding-left:22px !important
}

.gist .blob-code-marker::before {
    position: absolute;
    top: 1px;
    left: 8px;
    padding-right: 8px;
    content:attr(data-code-marker)
}

.gist .blob-code-context, .gist .blob-code-addition, .gist .blob-code-deletion {
    padding-left:22px
}

.gist .blob-code-marker-addition::before {
    position: absolute;
    top: 1px;
    left: 8px;
    content: "+ "
}

.gist .blob-code-marker-deletion::before {
    position: absolute;
    top: 1px;
    left: 8px;
    content: "- "
}

.gist .blob-code-marker-context::before {
    position: absolute;
    top: 1px;
    left: 8px;
    content: "  "
}

.gist .blob-code-marker-injected_context::before {
    position: absolute;
    top: 1px;
    left: 8px;
    content: "  "
}

.gist .soft-wrap .diff-table {
    table-layout:fixed
}

.gist .soft-wrap .blob-code {
    padding-left: 18px;
    text-indent:0
}

.gist .soft-wrap .blob-code-inner {
    white-space:pre-wrap
}

.gist .soft-wrap .no-nl-marker {
    display:none
}

.gist .soft-wrap .add-line-comment {
    margin-top: 0;
    margin-left:-24px
}

.gist .soft-wrap .blob-code-context, .gist .soft-wrap .blob-code-addition, .gist .soft-wrap .blob-code-deletion {
    padding-left: 22px;
    text-indent:0
}

.gist .blob-num-hunk, .gist .blob-code-hunk, .gist .blob-num-expandable {
    color: var(--color-fg-muted);
    vertical-align:middle
}

.gist .blob-num-hunk, .gist .blob-num-expandable {
    background-color:var(--color-diff-blob-hunk-num-bg)
}

.gist .blob-code-hunk {
    padding-top: 4px;
    padding-bottom: 4px;
    background-color: var(--color-accent-subtle);
    border-width:1px 0
}

.gist .blob-expanded .blob-num:not(.blob-num-context-outside-diff), .gist .blob-expanded .blob-code:not(.blob-code-context) {
    background-color:var(--color-canvas-subtle)
}

.gist .blob-expanded + tr.show-top-border:not(.blob-expanded) .blob-num, .gist .blob-expanded + tr.show-top-border:not(.blob-expanded) .blob-code {
    border-top:1px solid var(--color-border-muted)
}

.gist .blob-expanded tr.show-top-border .blob-num-hunk, .gist .blob-expanded tr.show-top-border .blob-num {
    border-top:1px solid var(--color-border-muted)
}

.gist tr.show-top-border + .blob-expanded .blob-num, .gist tr.show-top-border + .blob-expanded .blob-code {
    border-top:1px solid var(--color-border-muted)
}

.gist .blob-num-expandable {
    width: auto;
    padding: 0;
    font-size: 12px;
    text-align:center
}

.gist .blob-num-expandable .directional-expander {
    display: block;
    width: auto;
    height: auto;
    margin-right: -1px;
    color: var(--color-diff-blob-expander-icon);
    cursor:pointer
}

.gist .blob-num-expandable .single-expander {
    padding-top: 4px;
    padding-bottom:4px
}

.gist .blob-num-expandable .directional-expander:hover {
    color: var(--color-fg-on-emphasis);
    text-shadow: none;
    background-color: var(--color-accent-emphasis);
    border-color:var(--color-accent-emphasis)
}

.gist .blob-code-addition {
    background-color: var(--color-diff-blob-addition-line-bg);
    outline:1px dotted transparent
}

.gist .blob-code-addition .x {
    color: var(--color-diff-blob-addition-fg);
    background-color:var(--color-diff-blob-addition-word-bg)
}

.gist .blob-num-addition {
    color: var(--color-diff-blob-addition-num-text);
    background-color: var(--color-diff-blob-addition-num-bg);
    border-color:var(--color-success-emphasis)
}

.gist .blob-num-addition:hover {
    color:var(--color-fg-default)
}

.gist .blob-code-deletion {
    background-color: var(--color-diff-blob-deletion-line-bg);
    outline:1px dashed transparent
}

.gist .blob-code-deletion .x {
    color: var(--color-diff-blob-deletion-fg);
    background-color:var(--color-diff-blob-deletion-word-bg)
}

.gist .blob-num-deletion {
    color: var(--color-diff-blob-deletion-num-text);
    background-color: var(--color-diff-blob-deletion-num-bg);
    border-color:var(--color-danger-emphasis)
}

.gist .blob-num-deletion:hover {
    color:var(--color-fg-default)
}

.gist .is-selecting {
    cursor:ns-resize !important
}

.gist .is-selecting .blob-num {
    cursor:ns-resize !important
}

.gist .is-selecting .add-line-comment, .gist .is-selecting a {
    pointer-events: none;
    cursor:ns-resize !important
}

.gist .is-selecting .is-hovered .add-line-comment {
    opacity:0
}

.gist .is-selecting.file-diff-split {
    cursor:nwse-resize !important
}

.gist .is-selecting.file-diff-split .blob-num {
    cursor:nwse-resize !important
}

.gist .is-selecting.file-diff-split .empty-cell, .gist .is-selecting.file-diff-split .add-line-comment, .gist .is-selecting.file-diff-split a {
    pointer-events: none;
    cursor:nwse-resize !important
}

.gist .selected-line {
    position:relative
}

.gist .selected-line::after {
    position: absolute;
    top: 0;
    left: 0;
    display: block;
    width: 100%;
    height: 100%;
    box-sizing: border-box;
    pointer-events: none;
    content: "";
    background: var(--color-attention-subtle);
    mix-blend-mode:var(--color-diff-blob-selected-line-highlight-mix-blend-mode)
}

.gist .selected-line.selected-line-top::after {
    border-top:1px solid var(--color-attention-muted)
}

.gist .selected-line.selected-line-bottom::after {
    border-bottom:1px solid var(--color-attention-muted)
}

.gist .selected-line:first-child::after, .gist .selected-line.selected-line-left::after {
    border-left:1px solid var(--color-attention-muted)
}

.gist .selected-line:last-child::after, .gist .selected-line.selected-line-right::after {
    border-right:1px solid var(--color-attention-muted)
}

.gist .is-commenting .selected-line.blob-code::before {
    position: absolute;
    top: 0;
    left: -1px;
    display: block;
    width: 4px;
    height: 100%;
    content: "";
    background:var(--color-accent-emphasis)
}

.gist .add-line-comment {
    position: relative;
    z-index: 1;
    float: left;
    width: 22px;
    height: 22px;
    margin: -2px -10px -2px -32px;
    line-height: 21px;
    color: var(--color-fg-on-emphasis);
    text-align: center;
    text-indent: 0;
    cursor: pointer;
    background-color: var(--color-accent-emphasis);
    border-radius: 6px;
    box-shadow: var(--color-shadow-medium);
    opacity: 0;
    transition: transform .1s ease-in-out;
    transform:scale(0.8, 0.8)
}

.gist .add-line-comment:hover {
    transform:scale(1, 1)
}

.is-hovered .gist .add-line-comment, .gist .add-line-comment:focus {
    opacity:1
}

.gist .add-line-comment .octicon {
    vertical-align: text-top;
    pointer-events:none
}

.gist .add-line-comment.octicon-check {
    background: #333;
    opacity:1
}

.gist .inline-comment-form {
    border: 1px solid #dfe2e5;
    border-radius:6px
}

.gist .timeline-inline-comments {
    width: 100%;
    table-layout:fixed
}

.gist .timeline-inline-comments .inline-comments, .gist .show-inline-notes .inline-comments {
    display:table-row
}

.gist .inline-comments {
    display:none
}

.gist .inline-comments .line-comments + .blob-num {
    border-left-width:1px
}

.gist .inline-comments .timeline-comment {
    margin-bottom:10px
}

.gist .inline-comments .inline-comment-form, .gist .inline-comments .inline-comment-form-container {
    max-width:780px
}

.gist .comment-holder {
    max-width:780px
}

.gist .comment-holder + .comment-holder {
    margin-top:16px
}

.gist .line-comments + .line-comments, .gist .empty-cell + .line-comments {
    border-left:1px solid var(--color-border-muted)
}

.gist .inline-comment-form-container .inline-comment-form-box, .gist .inline-comment-form-container.open .inline-comment-form-actions {
    display:none
}

.gist .inline-comment-form-container .inline-comment-form-actions, .gist .inline-comment-form-container.open .inline-comment-form-box {
    display:block
}

.gist body.full-width .container, .gist body.full-width .container-lg:not(.markdown-body), .gist body.full-width .container-xl {
    width: 100%;
    max-width: none;
    padding-right: 20px;
    padding-left:20px
}

.gist body.full-width .repository-content {
    width:100%
}

.gist body.full-width .new-pr-form {
    max-width:980px
}

.gist .file-diff-split {
    table-layout:fixed
}

.gist .file-diff-split .blob-code + .blob-num {
    border-left:1px solid var(--color-border-muted)
}

.gist .file-diff-split .blob-code-inner {
    white-space:pre-wrap
}

.gist .file-diff-split .empty-cell {
    cursor: default;
    background-color: var(--color-neutral-subtle);
    border-right-color:var(--color-border-muted)
}

@media (max-width: 1280px) {
    .gist .file-diff-split .write-selected .comment-form-head.tabnav:not(.CommentBox-header) {
        margin-bottom:80px !important
    }

    .gist .file-diff-split .tabnav:not(.CommentBox-header) markdown-toolbar {
        position: absolute;
        top: 47px;
        right: 0;
        left: 0;
        height: 64px;
        align-items:center !important
    }
}

@media (min-width: 1280px) {
    .gist .file-diff-split .write-selected .comment-form-head.tabnav:not(.CommentBox-header) .tabnav-tabs {
        align-self:end
    }
}

.gist .submodule-diff-stats .octicon-diff-removed {
    color:var(--color-danger-fg)
}

.gist .submodule-diff-stats .octicon-diff-renamed {
    color:var(--color-fg-muted)
}

.gist .submodule-diff-stats .octicon-diff-modified {
    color:var(--color-attention-fg)
}

.gist .submodule-diff-stats .octicon-diff-added {
    color:var(--color-success-fg)
}

.gist .BlobToolbar {
    left:-17px
}

.gist .BlobToolbar-dropdown {
    margin-left:-2px
}

.gist .pl-token:hover, .gist .pl-token.active {
    cursor: pointer;
    background:var(--color-attention-muted)
}

.gist .task-list-item {
    list-style-type:none
}

.gist .task-list-item label {
    font-weight:var(--base-text-weight-normal, 400)
}

.gist .task-list-item.enabled label {
    cursor:pointer
}

.gist .task-list-item + .task-list-item {
    margin-top:4px
}

.gist .task-list-item .handle {
    display:none
}

.gist .task-list-item-checkbox {
    margin: 0 .2em .25em -1.4em;
    vertical-align:middle
}

.gist .contains-task-list:dir(rtl) .task-list-item-checkbox {
    margin:0 -1.6em .25em .2em
}

.gist .convert-to-issue-button {
    top: 2px;
    right: 4px;
    padding: 0 2px;
    margin-right: 8px;
    -webkit-user-select: none;
    user-select: none;
    background-color:var(--color-canvas-subtle)
}

.gist .convert-to-issue-button .octicon {
    fill:var(--color-fg-default)
}

.gist .convert-to-issue-button:hover .octicon, .gist .convert-to-issue-button:focus .octicon {
    fill:var(--color-accent-fg)
}

.gist .reorderable-task-lists .markdown-body .contains-task-list {
    padding:0
}

.gist .reorderable-task-lists .markdown-body li:not(.task-list-item) {
    margin-left:24px
}

.gist .reorderable-task-lists .markdown-body ol:not(.contains-task-list) li, .gist .reorderable-task-lists .markdown-body ul:not(.contains-task-list) li {
    margin-left:0
}

.gist .reorderable-task-lists .markdown-body .task-list-item {
    padding: 2px 15px 2px 42px;
    margin-right: -15px;
    margin-left: -15px;
    line-height: 1.5;
    border:0
}

.gist .reorderable-task-lists .markdown-body .task-list-item + .task-list-item {
    margin-top:0
}

.gist .reorderable-task-lists .markdown-body .task-list-item .handle {
    display: block;
    float: left;
    width: 20px;
    padding: 2px 0 0 2px;
    margin-left: -43px;
    opacity:0
}

.gist .reorderable-task-lists .markdown-body .task-list-item .drag-handle {
    fill:var(--color-fg-default)
}

.gist .reorderable-task-lists .markdown-body .task-list-item.hovered > .handle {
    opacity:1
}

.gist .reorderable-task-lists .markdown-body .task-list-item.is-dragging {
    opacity:0
}

.gist .reorderable-task-lists .markdown-body .contains-task-list:dir(rtl) .task-list-item {
    margin-right:0
}

.gist .comment-body .reference {
    font-weight: var(--base-text-weight-semibold, 600);
    white-space:nowrap
}

.gist .comment-body .issue-link {
    white-space:normal
}

.gist .comment-body .issue-link .issue-shorthand {
    font-weight: var(--base-text-weight-normal, 400);
    color:var(--color-fg-muted)
}

.gist .comment-body .issue-link:hover .issue-shorthand, .gist .comment-body .issue-link:focus .issue-shorthand {
    color:var(--color-accent-fg)
}

.gist .review-comment-contents .markdown-body .task-list-item {
    padding-left: 42px;
    margin-right: -12px;
    margin-left: -12px;
    border-top-left-radius: 6px;
    border-bottom-left-radius:6px
}

.gist .convert-to-issue-enabled .task-list-item .contains-task-list {
    padding: 4px 15px 0 43px;
    margin:0 -15px 0 -42px
}

.gist .convert-to-issue-enabled .task-list-item.hovered {
    background-color:var(--color-canvas-subtle)
}

.gist .convert-to-issue-enabled .task-list-item.hovered .contains-task-list {
    background-color:var(--color-canvas-default)
}

.gist .convert-to-issue-enabled .task-list-item.hovered > .convert-to-issue-button {
    z-index: 20;
    width: auto;
    height: auto;
    overflow: visible;
    clip:auto
}

.gist .convert-to-issue-enabled .task-list-item.hovered > .convert-to-issue-button svg {
    overflow:visible
}

.gist .convert-to-issue-enabled .task-list-item.is-loading {
    color: var(--color-fg-muted);
    background-color: var(--color-accent-subtle);
    border-top: 1px solid var(--color-accent-subtle);
    border-bottom: 1px solid var(--color-canvas-default);
    border-left:1px solid var(--color-canvas-default)
}

.gist .convert-to-issue-enabled .task-list-item.is-loading ul {
    color: var(--color-fg-default);
    background-color:var(--color-canvas-default)
}

.gist .convert-to-issue-enabled .task-list-item.is-loading > .handle {
    opacity:0
}

.gist .task-list-item-convert-container {
    position: absolute !important;
    top: calc(100% - 4px);
    right: 0;
    left: 0;
    display: none;
    margin-top:0
}

.gist .task-list-item-convert-container:hover, .gist .task-list-item-convert-container:focus {
    display:block
}

.gist .task-list-item-convert-button-container {
    top: 4px;
    right: 0;
    left: auto;
    width:auto
}

.gist .contains-task-list {
    position:relative
}

.gist .contains-task-list:hover .task-list-item-convert-container, .gist .contains-task-list:focus-within .task-list-item-convert-container {
    display: block;
    width: auto;
    height: 24px;
    overflow: visible;
    clip:auto
}

.gist .convert-to-block-button {
    margin:0 4px
}

.gist .highlight {
    padding: 0;
    margin: 0;
    font-family: ui-monospace, SFMono-Regular, SF Mono, Menlo, Consolas, Liberation Mono, monospace;
    font-size: 12px;
    font-weight: var(--base-text-weight-normal, 400);
    line-height: 1.4;
    color: #333;
    background: var(--color-canvas-default);
    border:0
}

.gist .render-viewer-error, .gist .render-viewer-fatal, .gist .render-viewer-invalid, .gist .octospinner {
    display:none
}

.gist iframe.render-viewer {
    width: 100%;
    height: 480px;
    overflow: hidden;
    border:0
}

.gist pre, .gist code {
    font-family: ui-monospace, SFMono-Regular, SF Mono, Menlo, Consolas, Liberation Mono, monospace !important;
    white-space:pre
}

.gist .gist-meta {
    padding: 10px;
    overflow: hidden;
    font: 12px -apple-system, BlinkMacSystemFont, "Segoe UI", "Noto Sans", Helvetica, Arial, sans-serif, "Apple Color Emoji", "Segoe UI Emoji";
    color: var(--color-fg-muted);
    background-color: #f7f7f7;
    border-radius:0 0 6px 6px
}

.gist .gist-meta a {
    font-weight: var(--base-text-weight-semibold, 600);
    color: #666;
    text-decoration: none;
    border:0
}

.gist .gist-data {
    overflow: auto;
    word-wrap: normal;
    background-color: var(--color-canvas-default);
    border-bottom: 1px solid var(--gist-border-pcolor);
    border-radius:6px 6px 0 0
}

.gist .gist-file {
    margin-bottom: 1em;
    font-family: ui-monospace, SFMono-Regular, SF Mono, Menlo, Consolas, Liberation Mono, monospace;
    border: 1px solid var(--gist-border-pcolor);
    border-bottom: 1px solid var(--gist-border-scolor);
    border-radius:6px
}

.gist .gist-file article {
    padding:6px
}

.gist .gist-file .scroll .gist-data {
    position: absolute;
    top: 0;
    right: 0;
    bottom: 30px;
    left: 0;
    overflow:scroll
}

.gist .gist-file .scroll .gist-meta {
    position: absolute;
    right: 0;
    bottom: 0;
    left:0
}

.gist .blob-num {
    min-width: inherit;
    padding: 1px 10px !important;
    background:rgba(0, 0, 0, 0)
}

.gist .blob-code {
    padding: 1px 10px !important;
    text-align: left;
    background: rgba(0, 0, 0, 0);
    border:0
}

.gist .blob-code-inner::selection, .gist .blob-code-inner * ::selection {
    background-color:#c8e1ff
}

.gist .blob-wrapper table {
    border-collapse:collapse
}

.gist .blob-wrapper tr:first-child td {
    padding-top:4px
}

.gist .markdown-body .anchor {
    display: none
}
"""

/// Convert code string to html with syntax highlight.
///
/// - Version: 0.0.1
/// - Note: Currently support language is plain text.
struct Code {
    static let SWIFT_KEYWORDS =
      [
        "associatedtype", "class", "deinit", "enum", "extension", "fileprivate",
        "func", "import", "init", "inout", "internal", "let", "open",
        "operator", "private", "precedencegroup", "protocol", "public",
        "rethrows", "static", "struct", "subscript", "typealias", "var",
        "break", "case", "catch", "continue", "default", "defer", "do", "else",
        "fallthrough", "for", "guard", "if", "in", "repeat", "return", "throw",
        "switch", "where", "while", "Any", "as", "await", "catch", "false",
        "is", "nil", "rethrows", "self", "Self", "super", "throw", "throws",
        "true", "try", "#available", "#colorLiteral", "#elseif", "#else",
        "#endif", "#if", "#imageLiteral", "#keyPath", "#selector",
        "#sourceLocation", "mutating"
      ]

    static func highlight_keywords(line : String, language : String) -> String {
        if language == "swift" {
            var line = line
            let words = Set(line.components(separatedBy: .whitespaces))
            for word in words {
                if SWIFT_KEYWORDS.contains(word) {
                    line = line.replacingOccurrences(
                      of: "\\b\(word)\\b",
                      with: "<span class=\"pl-k\">\(word)</span>",
                      options: .regularExpression
                    )
                }
            }
            return line
        }
        /* Not support */
        return line
    }

    static func highlight_comment(comment : String) -> String {
        let pl_c_b = #"<span class="pl-c">"#
        let pl_c_e = #"</span>"#
        return pl_c_b + comment + pl_c_e
    }

    /* Assume that `code` is line by line. */
    static func toHTML(code: String, language: String) -> DOMTreeNode {
        let gist = DOMTreeNode(name: "div", attr: ["class" : "gist"])
        let gist_file = DOMTreeNode(name: "div", attr: ["class" : "gist-file",
                                                        "translate" : "no"])
        let gist_data = DOMTreeNode(name: "div", attr: ["class" : "gist-data"])
        let gist_file_box = DOMTreeNode(name: "div", attr: [:])
        let file = DOMTreeNode(name: "div", attr: ["class" : "file my-2"])
        let box_body = DOMTreeNode(name: "div",
                                   attr: ["itemprop" : "text",
                                          "class" : "Box-body p-0 " +
                                                    "blob-wrapper data"])
        let blob = DOMTreeNode(name: "div",
                               attr: ["class" : "js-check-bidi " +
                                                "js-blob-code-container " +
                                                "blob-code-content"])
        let table = DOMTreeNode(name: "table",
                                attr: ["class" : "highlight " +
                                                 "tab-size " +
                                                 "js-file-line-container " +
                                                 "js-code-nav-container " +
                                                 "js-tagsearch-file"])
        let tbody = DOMTreeNode(name: "tbody", attr: [:])
        // - TODO: Add code highlight
        var line_num = 1
        var code = code.trimmingCharacters(in: .newlines)
        /* Match all / * * / comment */
        let mul_comment = #/(\/\*.*?\*\/)/#
        //#/(\/\/)(.*?)(?=[\n\r]|\*\))/#
        var comment2uuid : [String : String] = [:]
        var uuid2comment : [String : String] = [:]
        for match in code.matches(of: mul_comment) {
            let uuid = UUID().uuidString
            let comment = String(match.output.0)
            comment2uuid[comment] = uuid
        }
        /* Replace comment with corresponding uuid */
        for i in comment2uuid {
            let new_comment = highlight_comment(comment: i.key)
            uuid2comment[i.value] = new_comment
            code = code.replacingOccurrences(of: i.key, with: i.value)
        }
        for line in code.components(separatedBy: .newlines) {
            let tr = DOMTreeNode(name: "tr", attr: [:])
            let col1 = DOMTreeNode(name: "td",
                                   attr: ["class" : "blob-num " +
                                                    "js-line-number " +
                                                    "js-code-nav-line-number " +
                                                    "js-blob-rnum",
                                          "data-line-number" : "\(line_num)"])
            let col2 = DOMTreeNode(name: "td",
                                   attr: ["class" : "blob-code " +
                                                    "blob-code-inner " +
                                                    "js-file-line"])
            // - TODO: lexcial analysic here
            var wrap_line = line.replacingOccurrences(of: "<", with: "&lt;")
            wrap_line = wrap_line.replacingOccurrences(of: ">", with: "&gt;")
            wrap_line = highlight_keywords(line: wrap_line, language: language)
            /* Restore comment */
            for i in uuid2comment {
                wrap_line = wrap_line.replacingOccurrences(
                  of: i.key,
                  with: i.value
                )
            }
            col2.add(wrap_line)

            tr.add(col1)
            tr.add(col2)
            tbody.add(tr)
            line_num += 1
        }

        table.add(tbody)
        blob.add(table)
        box_body.add(blob)
        file.add(box_body)
        gist_file_box.add(file)
        gist_data.add(gist_file_box)
        gist_file.add(gist_data)

        let gist_meta = DOMTreeNode(name: "div", attr: ["class" : "gist-meta"])
        gist_meta.add("Rendered with ♡ by ")
        let a = DOMTreeNode(name: "a", attr: ["href" : zyy.GITHUB_REPO])
        a.add("zyy")
        gist_meta.add(a)

        gist.add(gist_file)
        gist_file.add(gist_meta)

        return gist
    }
}
