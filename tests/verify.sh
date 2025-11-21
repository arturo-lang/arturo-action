#!/bin/bash

EXPECTED_OS=$1
EXPECTED_ARCH=$2
EXPECTED_RELEASE=$3

echo "Testing Arturo..."
arturo -v
arturo -e "print [{os:} sys\os]"
arturo -e "print [{release:} sys\release]"
arturo -e "print [{arch:} sys\cpu\arch]"

DETECTED_OS=$(arturo -e "print sys\os")
if [ "$DETECTED_OS" != "$EXPECTED_OS" ]; then
    echo "UNEXPECTED OS: Expected $EXPECTED_OS, got $DETECTED_OS"
    exit 1
fi

DETECTED_ARCH=$(arturo -e "print sys\cpu\arch")
if [ "$DETECTED_ARCH" != "$EXPECTED_ARCH" ]; then
    echo "UNEXPECTED ARCH: Expected $EXPECTED_ARCH, got $DETECTED_ARCH"
    exit 1
fi

DETECTED_RELEASE=$(arturo -e "print sys\release")
if [ "$DETECTED_RELEASE" != "$EXPECTED_RELEASE" ]; then
    echo "UNEXPECTED RELEASE: Expected $EXPECTED_RELEASE, got $DETECTED_RELEASE"
    exit 1
fi

echo "✓ All checks passed: $EXPECTED_OS / $EXPECTED_ARCH / $EXPECTED_RELEASE"