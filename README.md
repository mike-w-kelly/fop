Apache FOP with Saxon HE (XSLT 3.0)
===================================



Build FOP with Saxon
--------------------

```bash
docker build -t fop .      
```

Run simple FOP no XSLT
----------------------

```bash
docker run --user $(id -u):$(id -g) -v $(pwd):/src -w /src -it --rm fop helloworld.fo -pdf helloworld.pdf
```

Run FOP with XSLT transform
---------------------------

```bash
docker run --user $(id -u):$(id -g) -v $(pwd):/src -w /src -it --rm fop -xml source.xml -xsl style.xsl -pdf document.pdf
```

```bash
docker run -v $(pwd):/src -w /src -it --rm fop -xml source.xml -xsl style.xsl -pdf document.pdf
```
