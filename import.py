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
    for f in data.get('ignore', []):
        if f in files:
            files.remove(f)


    return map(lambda x: (os.path.join(srcdir, x), x), files)

def main():
    dirs, files = readYAML()
    for name, data in dirs.items():
        print(f"Config entry : Directory {name}")
        for src, base in getSubFiles(data):
            dst = os.path.join(data['dst'],base)
            print(f"copying {src} --> {dst}")
            shutil.copyfile(src,dst)
        print("----")

    for name, data in files.items():
        print(f"Config entry : File {name}")
        print(f"copying {os.path.expandvars(data['src'])} --> {data['dst']}")
        print("----")

main()
