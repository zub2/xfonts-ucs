#!/bin/bash

# This repacks the original tar.gz into a .tar.xz because
# the upstream tarball does not contain a top-level directory.

ORIG_NAME="ucs-fonts.tar.gz"

# The package doesn't use a per-release versioning, each font is
# versioned separately. This is the highest version number I found
# in http://www.cl.cam.ac.uk/~mgk25/download/ucs-fonts.changes
# at time of creating this script.
ORIG_VERSION="1.115"

REPACKED_BASE_NAME="xfonts-ucs"
REPACKED_TOP_DIR="$REPACKED_BASE_NAME-${ORIG_VERSION}"
REPACKED_NAME="${REPACKED_BASE_NAME}_${ORIG_VERSION}.orig.tar.xz"

# re-pack the orignal tar.gz into a tar.xz
# repack_upstream_tar path_to_orig_tar_gz
# creates ./$REPACKED_NAME that would extract into $REPACKED_BASE_NAME-${ORIG_VERSION}
repack_upstream_tar() {
	PATH_TO_ORIG="$1"
	mkdir "$REPACKED_TOP_DIR"
	(
		cd "$REPACKED_TOP_DIR"
		tar xzvf "../$PATH_TO_ORIG/$ORIG_NAME"
	)
	tar cJvf "$PATH_TO_ORIG/$REPACKED_NAME" "$REPACKED_TOP_DIR"
	rm -rf "$REPACKED_TOP_DIR"
}

mkdir repack
(
	cd repack
	repack_upstream_tar ".."
)
rm -rf repack
