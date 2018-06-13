#!/bin/bash

CI="/media/jb/145C91ED5C91CA3E/Workspace/Python/Classification/results"
WORK="/media/jb/145C91ED5C91CA3E/Dokumenty/Praca"
DATASETS="/media/jb/145C91ED5C91CA3E/Workspace/Python/Classification/datasets"
MGR="/media/jb/145C91ED5C91CA3E/Dokumenty/Uczelnia/Praca magisterska"

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

if [[ $1 = "ci" ]]; then
    syncCi
elif [[ $1 = "praca" ]]; then
    syncDocs
elif [[ $1 = "datasets" ]]; then
    syncDatasets
elif [[ $1 = "mgr" ]]; then
    syncMgr
else
    echo syntax: bash syncdown.sh catalog -d/u
    echo catalog is one of following:
    echo ci - classifier integration results
    echo praca - katalog z dokumentami do pracy
    echo datasets - bazy danych do klasyfikacji
    echo mgr - praca magisterska
fi
