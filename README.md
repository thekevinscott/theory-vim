# Theory Machine

This sets up a Docker environment to do development under the Theory umbrella.

in `fish` shell:

```
docker build -t nvim -f Dockerfile .
docker run -ti -v (pwd):/src nvim
```

## To push a new build

```
./push.sh hitheory/vim:<TAG>
```

Then you can use it with:

```
docker run -ti --rm -v (pwd):/src <TAG>
```
