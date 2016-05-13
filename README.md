Swift Sentiment
===============

A simple sentiment NLP tool for Swift. It's based on the AFINN dictionary.

Usage:

```
import Sentiment

Sentiment.analyze("this, sucks").matches // 1
Sentiment.analyze("this, sucks").total  // -3
```

`matches` is the total number of matching words.

`total` is the raw sentiment number.

For the average just divide total by the the number of matches.
