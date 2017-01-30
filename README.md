# SlimeConverter

Converts Slime to EEx templates and beautify output. Currently is launched on free Heroku dyno.

## API

The site has an API for converting:

```bash
curl -d "slime=html" https://slime-converter.herokuapp.com/api/slime2html
# {"html":"<html>\n</html>"}
```
