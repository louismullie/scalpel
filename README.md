[![Build Status](https://secure.travis-ci.org/louismullie/scalpel.png)](http://travis-ci.org/#!/louismullie/scalpel)

**What?**

Scalpel is the result of my unability to find a simple and elegant solution to sentence segmentation in Ruby. Machine learning approaches - both unsupervised ([punkt-segmenter](https://github.com/lfcipriani/punkt-segmenter)) and supervised ( [tactful_tokenizer](https://github.com/SlyShy/Tactful_Tokenizer)) - depend on proper domain-specific training to work well. Stanford's tokenize-first group-later method ([stanford-core-nlp](https://github.com/louismullie/stanford-core-nlp)) do not work so well in the face of ill-formatted content. Finally, extensive rule-based methods ([srx-english](https://github.com/apohllo/srx-english)) are very accurate but suffer from poor performance. 

Scalpel is based on a very simple principle that reduces the complexity of performing sentence segmentation. The idea is that it is simpler and more efficient to find occurrences of periods that do __not__ indicate the end of a sentence, rather than those who do. These occurrences are temporarily replaced by "placeholder" characters, and sentence splitting is subsequently performed. The placeholder characters are then replaced by the original characters.

**How?**

    gem install scalpel

```ruby
require 'scalpel'
Scalpel.cut("some text")
```

**Why?**

![Benchmark](http://www.louismullie.com/ruby/scalpel/comparison.png)

* Scalpel is 80x faster than the only other method with 100% accuracy.
* Scalpel is 5x faster than the next fastest-running segmentation tool.
* Scalpel loads twice as fast as the next fastest-loading segmentation tool.

A few notes on the benchmark: 

* As with any benchmark, your mileage may vary, take it with a grain of salt, etc.
* Loading time for the Punkt segmenter is dependent on the size of the model.
* Stanford segmenter that was used is the one in DocumentPreprocessor, via Rjb.

The text that was used is the following:

```ruby
"For years, people in the U.A.E.R. have accepted murky air, tainted waters and scarred landscapes as the unavoidable price of the country’s meteoric economic growth. But public dissent over environmental issues has been growing steadily in the communist nation, and now seems to be building the foundations of a fledgling green movement! In July alone, two separate demonstrations made international news when they turned violent after about 1.5 minutes... These recent successes come after a slew of ever-larger and more violent green protests over the past few years, as the environmentalist Dr. Jeung of China’s growth becomes harder to ignore.Some ask: “Are demonstrations are evidence of the public anger and frustration at opaque environmental management and decision-making?” Others yet say: \"Should we be scared about these 'protests'?\""
```

**Contributing**

Feel free to fork the project and send me a pull request!