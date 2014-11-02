# Ruby - "Aho-Corasick" Algorithm API

This repository is a **WORK IN PROGRESS** project. The aim of this project is
implementing a Ruby API in order to efficiently perform strings matching.
The implementation behind the scenes uses the [Aho-Corasick](http://en.wikipedia.org/wiki/Aho%E2%80%93Corasick_string_matching_algorithm)
string matching algorithm. However, the full functionality of this algorithm
is not yet implemented.

## Getting the sources

    $ git clone https://github.com/Nallo/aho-corasick.git

    # clone the repo into the aho-corasick folder

## Usage

In the `src` folder you find the `example.rb` script. You can run the script
by typing:

    $ cd aho-corasick
    $ ruby -I src/lib src/example.rb

The `example.rb` script requires the files from the `src/lib` folder.
This is the reason why you need to specify the `-I` flag when you run
the script.

For those of you that are supposed to be *brave* you can copy the content of
the `lib` folder into the Ruby's `lib` folder and you will not need to
specify the `-I` flag.

The `example.rb` script will produce an output similar to this

    Processing he...
    Processing she...
    Processing his...
    Processing hers...
    Haystack has "he"
    Haystack has "she"
    Haystack has "hers"
    Haystack has NOT "him"
    Haystack has "his"
    Haystack has NOT "blablabla"
    Haystack has NOT "does not exists"

It says that the script is generating the Aho-Corasick graph for
*he, she, his, hers* and than is performing some queries to answer
the questions if the Haystack contains those keywords or not.

As you can see, when searching for *him* the query returns
*Haystack has NOT "him"*. COOL!!! :)

If you want to play a bit with this API you can have a look at the
file `Haystack.rb` in the `src/lib` folder. The file is pretty straightforward

* `add_all` receives a list of keywords and generated the Aho-Corasick graph
* `has?` returns true or false whether or not the keyword is contained in the haystack
* `query` does the same as `has?` except that it prints out a small message
* `find_all` **will** use the real power of the Aho-Corasick algorithm (sorry for that, weekends are too short)

## Custom Usage

If you want to play around with this API you can write a small Ruby script that
follows this skeleton

    # Create a new Haystack object
    my_haystack = Haystack.new()

    # Get the list of keywords to build the graph
    keywords = get_keywords_from_somewhere()

    # Add keywords to the Haystack
    my_haystack.add_all( keywords )

    # You can use both 'has?'' and 'query' to query the Haystack
    my_haystack.has?("this keyword") # => false I guess

## Unittests

Let's have some fun. If you what to contribute to this project you are
welcome. You can play with **pull requests** and whatever you want but.
I will strongly advice, once you have done any patch, to run the tests
that you find the the `src/test` folder. If you brake some of them, we
can discuss what we should modify on the API.

To run the tests

    $ ruby -vI src/lib test/GraphBaseUnittest.rb
    $ ruby -vI src/lib test/AhoCorasickGraphUnittest.rb