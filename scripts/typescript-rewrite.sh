#!/bin/bash

##
# Copyright 2017 Google Inc.
#
# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:
#
# The above copyright notice and this permission notice shall be included in
# all copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
# THE SOFTWARE.
#

set -e

function log() {
  echo -e "\033[36m[typescript-rewrite]\033[0m" "$@"
}

TYPESCRIPT_TMP=.typescript-tmp
TYPESCRIPT_PKGDIR=$TYPESCRIPT_TMP/packages
declare -a TYPESCRIPT_PKGS=(
  "mdc-animation"
  "mdc-base"
  "mdc-card"
  "mdc-checkbox"
  "mdc-chips"
  "mdc-dialog"
  "mdc-dom"
  "mdc-drawer"
  "mdc-elevation"
  "mdc-fab"
  "mdc-floating-label"
  "mdc-form-field"
  "mdc-icon-button"
  "mdc-icon-toggle"
  "mdc-line-ripple"
  "mdc-list"
  "mdc-menu"
  "mdc-menu-surface"
  "mdc-notched-outline"
  "mdc-radio"
  "mdc-ripple"
  "mdc-rtl"
  "mdc-selection-control"
  "mdc-shape"
  "mdc-slider"
  "mdc-switch"
  "mdc-tab"
  "mdc-tab-bar"
  "mdc-tab-indicator"
  "mdc-tab-scroller"
  "mdc-textfield"
  "mdc-theme"
  "mdc-typography"
)

if [ -z "$TYPESCRIPT_PKGS" ]; then
  echo "No typescript packages to rewrite!"
  exit 0
fi

log "Prepping whitelisted packages for JS rewrite"

rm -fr $TYPESCRIPT_TMP/**
mkdir -p $TYPESCRIPT_PKGDIR
for pkg in "${TYPESCRIPT_PKGS[@]}"; do
  cp -r "packages/$pkg" $TYPESCRIPT_PKGDIR
done
rm -fr $TYPESCRIPT_PKGDIR/**/{node_modules,dist}
 
log "Rewriting all import statements to be internal typescript compatible"
node scripts/rewrite-declation-statements-for-typescript.js $TYPESCRIPT_PKGDIR
