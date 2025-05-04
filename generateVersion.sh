#!/usr/bin/env bash

# Rules for generating semantic versioning
# major: breaking change
# minor: feat, style
# patch: build, fix, perf, refactor, revert

GENERATE_VERSION=$1
echo "Generate version: $GENERATE_VERSION"

PREVENT_REMOVE_FILE=$2

LAST_TAG=$(git describe --tags --abbrev=0 --always)
echo "Last tag: #$LAST_TAG#"
PATTERN="^[0-9]+\.[0-9]+\.[0-9]+$"

increment_version() {
    local version=$1
    local increment=$2
    local major=$(echo $version | cut -d. -f1)
    local minor=$(echo $version | cut -d. -f2)
    local patch=$(echo $version | cut -d. -f3)

    if [ "$increment" == "major" ]; then
        major=$((major + 1))
        minor=0
        patch=0
    elif [ "$increment" == "minor" ]; then
        minor=$((minor + 1))
        patch=0
    elif [ "$increment" == "patch" ]; then
        patch=$((patch + 1))
    fi

    echo "${major}.${minor}.${patch}"
}

push_newversion() {
    local new_version=$1
    if [ "$GENERATE_VERSION" == "true" ]; then
        echo "Generating new version..."
        git tag $new_version
        git push origin $new_version
    else
        echo "To generate a new version, you must send the argument \"true\""
    fi
}

create_file() {
    local with_range=$1
    if [ -s messages.txt ]; then
        return 1
    fi
    if [ "$with_range" == "true" ]; then
        git log $LAST_TAG..HEAD --no-decorate --pretty=format:"%s" > messages.txt
    else
        git log --no-decorate --pretty=format:"%s" > messages.txt
    fi
}

get_commit_range() {
    if [[ $LAST_TAG =~ $PATTERN ]]; then
        create_file true
    else
        create_file
        LAST_TAG="0.0.0"
    fi
    echo " " >> messages.txt
}

start() {
    get_commit_range
    new_version=$LAST_TAG
    increment_type=""

    while read message; do
        if [[ $message =~ (([a-z]+)(\(.+\))?\!:)|(BREAKING CHANGE:) ]]; then
            increment_type="major"
            break
        elif [[ $message =~ (^(feat|style)(\(.+\))?:) ]]; then
            if [ -z "$increment_type" ] || [ "$increment_type" == "patch" ]; then
                increment_type="minor"
            fi
        elif [[ $message =~ ^((fix|build|perf|refactor|revert)(\(.+\))?:) ]]; then
            if [ -z "$increment_type" ]; then
                increment_type="patch"
            fi
        fi
    done < messages.txt

    if [ -n "$increment_type" ]; then
        new_version=$(increment_version $LAST_TAG $increment_type)
        echo "New version: $new_version"
        push_newversion $new_version
    else
        echo "No changes requiring a version increment."
    fi
}

start

if [ -z "$PREVENT_REMOVE_FILE" ]; then
    rm -f messages.txt
fi
