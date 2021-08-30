# skelbinembedshellscript
Skeleton to embed binary files in shell scripts.

## Usage
Copy the skeleton to a new script:
```console
shell $ cp skelembedshellscript.sh myinstaller.sh
```

Add payload binary file to the script:
```console
shell $ base64 /path/to/file/originalfile.bin >> myinstaller.sh
```

Add execution permissions:
```console
shell $ chmod a+x myinstaller.sh
```

Modify the **EDIT SECTION** script.
