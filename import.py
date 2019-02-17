#!/bin/env python3
import yaml, os, shutil

def readYAML():
    """Gets the data needed from the YAML config file"""

    with open("dots.yaml", 'r') as stream:
        try:
            load = yaml.load(stream)
        except yaml.YAMLError as exc:
            print(exc)

    return load['directories'], load['files']

def getSubFiles(data):
    """Returns an iterable of files to copy based on config values"""

    srcdir = os.path.expandvars(data['src'])
    files = os.listdir(srcdir)
    pathNameTuple = lambda x : (os.path.join(srcdir, x), x)
    ignoreFile = lambda x : (data.get('ignore', []).count(x) == 0)

    return [pathNameTuple(f) for f in files if ignoreFile(f)]

def main():

    dirs, files = readYAML()

    for name, data in dirs.items():
        print(f"Config entry : Directory {name}")
        getSubFiles(data)
        for src, base in getSubFiles(data):
            dst = os.path.join(data['dst'],base)
            print(f"copying {src} --> {dst}")
            shutil.copyfile(src,dst)
        print("----")

    for name, data in files.items():
        print(f"Config entry : File {name}")
        src = os.path.expandvars(data['src'])
        print(f"copying {src} --> {data['dst']}")
        shutil.copyfile(src,data['dst'])
        print("----")

main()
