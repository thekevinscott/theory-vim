# Theory Machine

This sets up a Docker environment to do development under the Theory umbrella.

in `fish` shell:

```
docker build -t nvim -f Dockerfile .
docker run -ti -v (pwd):/src nvim
```
