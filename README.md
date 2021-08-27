# skelbinembedshellscript
Skeleton to embed binary files in shell scripts.

## Usage
Copy the skeleton to a new script:
```console
shell $ cp skelbinembed.sh myinstaller.sh
```

Add payload binary file to the script:
```console
shell $ base64 /tmp/originalfile.bin >> myinstaller.sh
```

Add execution permissions:
```console
shell $ chmod a+x myinstaller.sh
```

Get SHA1 from original file and copy to add to the script in the next section.
```console
shell $ sha1sum /tmp/originalfile.bin | cut -d " " -f 1
```

Modify the **EDIT SECTION** script.
