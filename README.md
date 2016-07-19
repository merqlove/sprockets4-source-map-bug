## This repo illustrates Sprockets 4 SourceMap update bug.
[Link to issue](https://github.com/rails/sprockets/issues/344)

#### Steps to reproduce:

1. Clone this repo
2. Setup DB(`sqlite`): `$ bin/rails db:setup db:migrate`
2. Run Application with: `$ bin/rails s`
3. Go to `http://localhost:3000/pages`
4. Open `app/assets/javascripts/web/data/test/utils.coffee`
5. Change city
6. You will see changed city in the console.
7. But map still old. It is.

#### Thread from issues:

How to setup it right for guaranteed source-map refresh?

Added manifest file with source like this:

```javascript
// assets/config/manifest.js
//= link_tree ../images
//= link_directory ../javascripts .js
//= link_directory ../stylesheets .scss

//= link some.js
```

Also i have root `coffeescript` file:

```coffeescript
# assets/javascripts/some.coffee

#= require web/index
```

And web folder index file:

```coffeescript
# assets/javascripts/web/index.coffee

#= require ./shared
#= require_tree ./data
#= require_self
...
# some code with data methods
```

**First time SourceMap processor generates right version of the map.**
But, if i did some changes in the content, *for example its child file*,   
with `coffeescript` source in the `./data`, content of `some....js` is changing, but SourceMap no refreshes.   
Always same source-map file with the same fingerprint.

4 times i've looks to the end of `some....js`, and 4 times i found:
```
//# sourceMappingURL=some.js-64eb1dee0f03a6038c4dd3bd9f77a25f7b5c05095344c19b5800bba7289b443e.map
//# sourceMappingURL=some.js-64eb1dee0f03a6038c4dd3bd9f77a25f7b5c05095344c19b5800bba7289b443e.map
//# sourceMappingURL=some.js-64eb1dee0f03a6038c4dd3bd9f77a25f7b5c05095344c19b5800bba7289b443e.map
//# sourceMappingURL=some.js-64eb1dee0f03a6038c4dd3bd9f77a25f7b5c05095344c19b5800bba7289b443e.map
```

Same picture also i've seen with `master` branch of [rails/sprockets](https://github.com/rails/sprockets) repo.

Screenshots of current reproduce:

![Script works well, as it updated, look console.](https://cloud.githubusercontent.com/assets/18354/16966234/a9ecfa6a-4e14-11e6-9e52-2cbe7ff1f88d.png)
![Map is old](https://cloud.githubusercontent.com/assets/18354/16966237/b1649136-4e14-11e6-8bc0-97dcd9a0fd16.png)
