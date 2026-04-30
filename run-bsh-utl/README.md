# run-bsh

A minimalist bash bootstrap for new software projects — a tiny, self-discovering `do_*` action runner you can clone into any project as the entry point.

## CLONE & USE

```bash
mkdir -p /opt/csi && cd /opt/csi
git clone git@github.com:csitea/run-bsh.git
cd run-bsh
./run --help
```

## PREREQUISTES

### Directory Structure

You MUST have the following relative directory structure:

```sh
# this could be also ~/opt or any dir your OS usr has rwx
BASE_PATH=/opt;
ORG=csi
APPLICATION=run-bsh

find $BASE_PATH/$ORG/$APPLICATION -maxdepth 1|sort

# the APPLICATION_PATH
/opt/csi/run-bsh

# the documentation project
/opt/csi/run-bsh/run-bsh-doc

# the utils project - where the local dev env utilities residue
/opt/csi/run-bsh/run-bsh-utl
```

Of course your BASE_PATH COULD be ( but probably shouldn't ) also anything like /var, ~/opt , ~/var etc...

### BINARIES

### OS user permissions

Your host OS user MUST have full ownership of the `<<BASE_PATH>>` dir on your host - if it does not, or you are not sure, use the `~/opt` dir.

### UID & GID

```sh
# Export UID and GID and set them in the current shell session
export UID=$(id -u) ; export GID=$(id -g);

# Permanently set UID and GID in .bashrc or .bash_profile
# Append them if they are not yet set
grep -q 'export UID=$(id -u)' ~/.bashrc || echo 'export UID=$(id -u)' >> ~/.bashrc ;
grep -q 'export GID=$(id -g)' ~/.bashrc || echo 'export GID=$(id -g)' >> ~/.bashrc ;
source ~/.bashrc ; # apply changes immediately

```

## BUILD

Build in this context means "syntax check, autoformat and build ( if applicable)"

## REPLICATION AND PROPAGATION FROM AND TO BASE PROJECT 

to replicate 
```bash
SRC_PATH=/opt/csi/run-bsh/run-bsh-utl/src/bash/ bash /opt/csi/run-bsh/run-bsh-utl/run -a do_clone_dir_to_bas
SRC_PATH=/opt/csi/run-bsh/run-bsh-wui/.github/ bash /opt/csi/run-bsh/run-bsh-utl/run -a do_clone_dir_to_bas
SRC_PATH=/opt/csi/run-bsh/run-bsh-utl/src/bash/run/run.sh bash /opt/csi/run-bsh/run-bsh-utl/run -a do_clone_file_to_bas
```

```bash
TGT_PATH=/opt/csi/run-bsh/run-bsh-utl/src/bash/run bash /opt/csi/run-bsh/run-bsh-utl/run -a do_clone_dir_from_bas
TGT_PATH=/opt/csi/run-bsh/run-bsh-utl/src/bash/run/run.sh bash /opt/csi/run-bsh/run-bsh-utl/run -a do_clone_file_from_bas
```

