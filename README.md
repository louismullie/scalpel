**About**

Scalpel is the result of my inability to find a simple and elegant solution to sentence segmentation in Ruby. Machine learning approaches - both unsupervised ([punkt-segmenter](https://github.com/lfcipriani/punkt-segmenter)) and supervised ( [tactful_tokenizer](https://github.com/SlyShy/Tactful_Tokenizer)) - depend on proper domain-specific training to work well. Stanford's tokenize-first group-later method ([stanford-core-nlp](https://github.com/louismullie/stanford-core-nlp)) does not work so well in the face of ill-formatted content. Finally, extensive rule-based methods ([srx-english](https://github.com/apohllo/srx-english)) are very accurate but suffer from poor performance. 

Scalpel is based on a very simple principle that reduces the complexity of performing sentence segmentation. The idea is that it is simpler and more efficient to find occurrences of periods that do __not__ indicate the end of a sentence, rather than those who do. These occurrences are temporarily replaced by "placeholder" characters (sequences assumed not to exist), and sentence splitting is subsequently performed. The placeholder characters are then replaced by the original characters. This sentence segmentation algorithm is extremely hacky, but surprisingly robust in a variety of settings.

**Usage**

    gem install scalpel

```ruby
require 'scalpel'
Scalpel.cut("some text")
```

**Contributing**

Feel free to fork the project and send me a pull request!
