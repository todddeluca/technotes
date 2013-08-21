
This file contains ideas and links for how to organize research projects, experiments, science.

# Patterns for research in machine learning.  other keywords:  research.  science experiments.  scientific.

Here are a smattering of links with suggestions for how to organize a research project:

- http://hunch.net/?p=2562
- http://arkitus.com/PRML/
- http://news.ycombinator.com/item?id=4384317
- http://www.theexclusive.org/2012/08/principles-of-research-code.html

8/24/2012
Patterns for research in machine learning
Tags: Code, Machine Learning, Teaching — smalieslami@ 2:30 pm

There are a handful of basic code patterns that I wish I was more aware of when
I started research in machine learning. Each on its own may seem pointless, but
collectively they go a long way towards making the typical research workflow
more efficient. Here they are:

- Separate code from data.
- Separate input data, working data and output data.
- Save everything to disk frequently.
- Separate options from parameters.
- Do not use global variables.
- Record the options used to generate each run of the algorithm.
- Make it easy to sweep options.
- Make it easy to execute only portions of the code.
- Use checkpointing.
- Write demos and tests.

Click here for discussion and examples for each item. Also see Charles Sutton’s
and HackerNews’ thoughts on the same topic.

My guess is that these patterns will not only be useful for machine learning,
but also any other computational work that involves either a) processing large
amounts of data, or b) algorithms that take a significant amount of time to
execute. Share this list with your students and colleagues. Trust me, they’ll
appreciate it.

# Project Template is R code that imposes an organization on a research project.  Rails:webapps::ProjectTemplate:research

- http://arkitus.com/PRML/
- http://www.theexclusive.org/2012/08/principles-of-research-code.html
- http://hilaryparker.com/2012/08/25/love-for-projecttemplate/
- http://projecttemplate.net/getting_started.html

