#!/bin/bash

host=$(hostname)
if [[ $host == *"P67A"* ]]; then
    CI="/media/jb/145C91ED5C91CA3E/Workspace/Python/Classification/results"
    WORK="/media/jb/145C91ED5C91CA3E/Dokumenty/Praca"
    DATASETS="/media/jb/145C91ED5C91CA3E/Workspace/Python/Classification/datasets"
    MGR="/media/jb/145C91ED5C91CA3E/Dokumenty/Uczelnia/Praca magisterska"
    DOC="/media/jb/145C91ED5C91CA3E/Dokumenty/Uczelnia/Doktorat"
elif [[ $host == *"ThinkPad"* ]]; then
    CI="/home/jb/Workspace/Python/classifier-integration/datasets"
    WORK="/home/jb/Documents/Praca"
    DATASETS="/home/jb/Workspace/Python/classifier-integration/results"
    MGR="/home/jb/Documents/Praca magisterska"
    DOC="/home/jb/Documents/Doktorat"
else
    echo host not configured
    exit 1
fi

function syncCi {
    java -jar /opt/jdrivesync/jdrivesync.jar $2 -r CI -l "$CI"
}

function syncDocs {
    java -jar /opt/jdrivesync/jdrivesync.jar $2 -r praca -l "$WORK"
}

function syncDatasets {
    java -jar /opt/jdrivesync/jdrivesync.jar $2 -r datasets -l "$DATASETS"
}

function syncMgr {
    java -jar /opt/jdrivesync/jdrivesync.jar $2 -r mgr -l "$MGR"
}

function syncDoktorat {
    java -jar /opt/jdrivesync/jdrivesync.jar $2 -r doktorat -l "$DOC"
}

if [[ $1 = "ci" ]]; then
    syncCi
elif [[ $1 = "praca" ]]; then
    syncDocs
elif [[ $1 = "datasets" ]]; then
    syncDatasets
elif [[ $1 = "mgr" ]]; then
    syncMgr
elif [[ $1 = "doktorat" ]]; then
    syncDoktorat
else
    echo syntax: bash sync.sh catalog -d/u
    echo catalog is one of following:
    echo ci -       classifier integration results
    echo praca -    katalog z dokumentami do pracy
    echo datasets - bazy danych do klasyfikacji
    echo mgr -      praca magisterska
    echo doktorat - katalog z dokumentami do doktoratu
fi
