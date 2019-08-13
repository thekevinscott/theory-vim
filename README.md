# Theory Machine

This sets up a Docker environment to do development under the Theory umbrella.

in `fish` shell:

```
docker build -t nvim -f Dockerfile .
docker run -ti -v (pwd):/src nvim
```

## Testing

Build locally and test:

```
./run.sh hitheory/vim:<TAG>
```

This will use the `dotfiles-deploy-key` ssh key to pull the dotfiles repo as an intermediate Docker container, and then build the actual repo.

## To push a new build

```
./push.sh hitheory/vim:<TAG>
```
