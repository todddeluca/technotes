

# Linked Open Data Collections

http://stats.lod2.eu/

> LODStats is a statement-stream-based approach for gathering comprehensive
> statistics about datasets adhering to the Resource Description Framework
> (RDF). LODStats is based on the declarative description of statistical
> dataset characteristics. Its main advantages over other approaches are a
> smaller memory footprint and significantly better performance and
> scalability. We integrated LODStats into the CKAN dataset metadata registry
> and obtained a comprehensive picture of the current state of the Data Web.


# SPARQL and RDF Database Server Scalability and Performance

RDF Store Benchmarking
This page collects references to RDF benchmarks, benchmarking results and papers about RDF benchmarking.
http://www.w3.org/wiki/RdfStoreBenchmarking

2013 Berlin SPARQL Benchmark Results for Virtuoso, Jena TDB, BigData, and BigOWLIM
http://wifo5-03.informatik.uni-mannheim.de/bizer/berlinsparqlbenchmark/results/V7/


# SPARQL Federated Queries

The SERVICE keyword can be used in SPARQL 1.1 queries to access multiple SPARQL endpoints.

https://groups.google.com/forum/?fromgroups#!topic/thosch/beRPXXfY\_m8
As far as I know Jena ARQ supports the SERVICE clause of SPARQL 1.1 http://jena.sourceforge.net/ARQ/service.html
Sesame is Sparql 1.1 compliant from version 2.4 but honestly I did not try so far if the service clause is supported.

http://sesame-general.435816.n3.nabble.com/Example-of-SPARQL-subquery-where-the-subquery-queries-another-repository-td3894260.html
For example, here's a simple federated query that looks in a remote
SPARQL endpoint (in this case a Sesame repository called 'people' on our
own server) for persons called "Bob" and then looks in our local
repository for any hobbies of Bob:

SELECT ?person ?hobby
WHERE {
 ?person ex:hasHobby ?hobby .
 SERVICE <http://localhost:8080/openrdf-sesame/repositories/people> {
    ?person a ex:Person ;
            ex:name "Bob" .
 }
}


# Python RDF Tools

- http://www.michelepasin.org/blog/2011/02/24/survey-of-pythonic-tools-for-rdf-and-linked-data-programming/
- http://stackoverflow.com/questions/13823746/django-rdf-support
- http://stackoverflow.com/questions/11365796/djangonic-way-to-deal-with-rdf


# Representing CSV as RDF

http://jenit.github.io/linked-csv/

https://github.com/theodi/linked-csv-browser/

http://www.biointerchange.org/


# RDFization tools

http://www.biointerchange.org/

Interchange data using the Resource Description Framework (RDF) and let
BioInterchange automagically create RDF triples from your TSV, XML, GFF3, GVF,
Newick and other files. BioInterchange helps you transform your data sets into
linked data for sharing and data integration via command line, web-service, or
API.


http://www.rdb2rdf.org/



# RDF, Semantic Web, and Linked Data Tools and Technology


## SPARQL Endpoints

Expose your relational database as a sparql endpoint using a tool such as http://d2rq.org/

## Servers with SPARQL Query Web Interfaces

Webservers which provide a web interface to a SPARQL endpoint, so users make queries and see results.

Pubby.  Pubby can be used to add Linked Data interfaces to SPARQL endpoints.
Take an existing sparql endpoint, pubby queries the endpoint for triples about a resource, so when someone tries to dereference the resource (as html or rdf) pubby can serve them content.
http://wifo5-03.informatik.uni-mannheim.de/pubby/
https://github.com/cygri/pubby

Djubby.  A django knockoff of pubby.
https://code.google.com/p/djubby/
Last modified April 2010.  Boo.  Pubby is still active.

http://www.ontotext.com/owlim/editions
OntoText OWLIM

http://virtuoso.openlinksw.com/
OpenLink Virtuoso

http://virtuoso.openlinksw.com/dataspace/doc/dav/wiki/Main/VirtDeployingLinkedDataGuide_Introduction

http://openrdf.callimachus.net/
OpenRDF Sesame

http://jena.apache.org/
Apache Jena

http://mulgara.org/
Mulgara is a scalable RDF database written entirely in Java.

## Ontology Editors and IDEs

Protege
Free Open Source
http://protege.stanford.edu/

TopBraid Composer
http://www.topquadrant.com/products/TB_Composer.html
Free Edition



# Querying a SPARQL endpoint

The SPARQL Protocol is described in
http://www.w3.org/TR/2013/REC-sparql11-protocol-20130321/.  It can be used to
directly access a SPARQL endpoint.

In the docs (at
http://www.w3.org/TR/2013/REC-sparql11-protocol-20130321/#query-operation)
there is a useful table detailing the method, query string parameters, request
content type, and request body for various ways of qeurying a SPARQL endpoint.
Here it is:

<table style="margin-left: auto; margin-right:                     auto; border-color: rgb(0, 0, 0); border-collapse: collapse;" border="1" cellpadding="5"><tr><th> </th><th>HTTP Method</th><th>Query String Parameters</th><th>Request Content Type</th><th>Request Message Body</th></tr><tr><th>query via GET</th><td>GET</td><td><code>query</code> (exactly 1)<br />
                            <code>default-graph-uri</code> (0 or more)<br />
                            <code>named-graph-uri</code> (0 or more)</td><td>None</td><td>None</td></tr><tr><th>query via URL-encoded POST</th><td>POST</td><td>None</td><td><code>application/x-www-form-urlencoded</code></td><td>URL-encoded, ampersand-separated query parameters.<br />
                            <code>query</code> (exactly 1)<br />
                            <code>default-graph-uri</code> (0 or more)<br />
                            <code>named-graph-uri</code> (0 or more)</td></tr><tr><th>query via POST directly</th><td>POST</td><td><code>default-graph-uri</code> (0 or more)<br />
                            <code>named-graph-uri</code> (0 or more)</td><td><code>application/sparql-query</code></td><td>Unencoded SPARQL query string</td></tr></table>


## Using Python Requests to send an HTTP request


You can access a sparql service directly using the sparql protocol:
http://www.w3.org/TR/2013/REC-sparql11-protocol-20130321/

This is an example of making a GET request to the uniprot sparql endpoint.  The
query must be "percent" quoted for the URL.  Some endpoints are finicky about
which `Accept` headers are, um, acceptable.  For example, UniProt will accept
`application/json` or `application/sparql-results+json`, whereas StarDog will
only accept the latter.

    python -c "import requests
    query = '''
    PREFIX up:<http://purl.uniprot.org/core/>
    SELECT ?protein
    WHERE
    {
      ?protein a up:Protein .
      ?protein up:mnemonic 'A4_HUMAN'
    }
    '''
    params = {'query': query}
    headers = {'accept': 'application/json'}
    headers = {'accept': 'application/sparql-results+json'}
    r = requests.get('http://beta.sparql.uniprot.org', params=params, headers=headers)
    print 'url:', r.url
    print 'headers:', r.headers
    print 'text:', r.text
    print 'json:', r.json()
    "

Here are the results:

    url: http://beta.sparql.uniprot.org/?query=%0APREFIX+up%3A%3Chttp%3A%2F%2Fpurl.uniprot.org%2Fcore%2F%3E+%0ASELECT+%3Fprotein%0AWHERE%0A%7B%0A++%3Fprotein+a+up%3AProtein+.%0A++%3Fprotein+up%3Amnemonic+%27A4_HUMAN%27%0A%7D%0A
    headers: {'x-uniprot-release': '2013_06', 'transfer-encoding': 'chunked', 'vary': 'User-Agent', 'server': 'Apache-Coyote/1.1', 'connection': 'close', 'cache-control': 'no-cache', 'date': 'Sat, 08 Jun 2013 18:51:20 GMT', 'access-control-allow-origin': '*', 'access-control-allow-headers': 'origin, x-requested-with, content-type', 'content-type': 'application/sparql-results+json'}
    text: {
      "head": {
        "vars": [ "protein" ]
      },
      "results": {
        "bindings": [
          {
            "protein": { "type": "uri", "value": "http:\/\/purl.uniprot.org\/uniprot\/P05067" }
          }
        ]
      }
    }
    json: {u'head': {u'vars': [u'protein']}, u'results': {u'bindings': [{u'protein': {u'type': u'uri', u'value': u'http://purl.uniprot.org/uniprot/P05067'}}]}}

Here is a list of StarDog Accept Headers for Queries (from http://stardog.com/docs/network/#http):

> When issuing a SELECT query the Accept header should be set to one of the valid MIME types for SELECT results:
>
> SPARQL XML Results Format
> application/sparql-results+xml
> SPARQL JSON Results Format
> application/sparql-results+json
> SPARQL Boolean Results
> text/boolean
> SPARQL Binary Results
> application/x-binary-rdf-results-table

The StarDog SPARQL query endpoint is http://<host>[:<port]/<db>/query.  The
docs (http://www.stardog.com/docs/admin/) tell us that the default port for
HTTP is 5822.  Therefore, for the `mirna` database on my laptop, the URL for
the SPARQL query endpoint is `http://localhost:5822/mirna/query`.

Here is an example of querying my local StarDog endpoint.  Notice the user
and password authentication:

    python -c "import requests
    query = '''
    PREFIX mb:<http://purl.mirbase.org/owl/>
    PREFIX ts:<http://purl.targetscan.org/owl/>
    PREFIX ex:<http://purl.example.com/owl/>
    PREFIX obo:<http://purl.obolibrary.org/obo/>
    PREFIX rdf:<http://www.w3.org/1999/02/22-rdf-syntax-ns#>
    PREFIX rdfs:<http://www.w3.org/2000/01/rdf-schema#>
    PREFIX up:<http://purl.uniprot.org/core/>
    PREFIX taxon:<http://purl.uniprot.org/taxonomy/>
    PREFIX db:<http://purl.example.com/database/>
    SELECT ?macc ?mid
    WHERE {
      VALUES ?macc { <http://purl.mirbase.org/mirna_acc/MIMAT0000406> <http://purl.mirbase.org/mirna_acc/MIMAT0000105> }
      ?macc mb:current_id ?mid .
      ?mid up:database db:mirbase_id .
      ?mid up:organism taxon:7227 .
    }'''
    params = {'query': query}
    headers = {'accept': 'application/sparql-results+json'}
    r = requests.get('http://localhost:5822/mirna/query', params=params,
                    headers=headers, auth=('admin', 'admin'))
    print 'url:', r.url
    print 'code:', r.status_code
    print 'headers:', r.headers
    print 'text:', r.text
    print 'json:', r.json()
    "

# Problems with RDF and Linked Data

This is an interesting series of posts covering blank nodes, multiple syntaxes,
the conflation of RDF and Linked Open Data, and many more things.  Good
comments too:

- http://milicicvuk.com/blog/2011/07/14/problems-of-the-rdf-model-blank-nodes/
- http://milicicvuk.com/blog/2011/07/16/problems-of-the-rdf-model-literals/
- http://milicicvuk.com/blog/2011/07/19/ultimate-problem-of-rdf-and-semantic-web/
- http://milicicvuk.com/blog/2011/07/21/problems-of-the-rdf-syntax/
- http://milicicvuk.com/blog/2011/07/26/problems-of-linked-data-14-identity/
- http://milicicvuk.com/blog/2011/07/28/problems-of-linked-data-24-concept/
- http://milicicvuk.com/blog/2011/08/02/problems-of-linked-data-34-publishing-data/
- http://milicicvuk.com/blog/2011/08/04/problems-of-linked-data-44-consuming-data/

Some of my concerns with RDF:

- Verbose: It seems expansive to say a lot of little things.  Maybe internal representations can be more efficient.
- Performance: database querying and loading seems very slow and hard to scale, still.
- Reification: it is difficult to make statements, yet making statements about statements is an interesting and important part of information.  When was a statement made?  Who made the statement?  What version is a statement or is there a more recent statement?  A primary function of RDF is to express statements.

#

Some RDFLib docs that have some examples of how to create a "dataset" and named
graphs within the dataset:

- http://rdflib.readthedocs.org/en/latest/modules/graphs/dataset.html
- http://rdflib.readthedocs.org/en/latest/_modules/rdflib/graph.html#Dataset
- http://rdflib.readthedocs.org/en/latest/modules/graphs/index.html

Example python code for creating and serializing a tiny dataset.  The format 'trix' is the only built in format that supports named graphs (i.e. datasets):

python -c "
import rdflib
ds = rdflib.Dataset()
ex = rdflib.Namespace('http://example.com/')
g1 = ds.graph(ex.likes_graph)
g2 = ds.graph(ex.eats_graph)
g3 = ds.graph(ex.jj_graph)
g1.add((ex.todd, ex.likes, ex.mms))
g1.add((ex.todd, ex.likes, ex.coffee))
g2.add((ex.todd, ex.eats, ex.coffee))
g2.add((ex.todd, ex.eats, ex.salad))
g3.add((ex.jj, ex.eats, ex.mms))
g3.add((ex.jj, ex.likes, ex.mms))
ds.add((ex.todd, ex.types, ex.slowly))
ds.add((ex.likes_graph, ex.version, rdflib.Literal(1)))
serialization_formats = ['xml', 'n3', 'turtle', 'nt', 'pretty-xml', 'trix']
for f in serialization_formats:
    print '#' * 20, f, '#' * 20
    print ds.serialize(format=f)
with open('foo.trix', 'w') as fh:
    fh.write(ds.serialize(format='trix'))
"

Load the example dataset into stardog in a new database:

    time stardog-admin db drop test
    time stardog-admin db create -n test foo.trix

Alternatively, if you only had triples, you can load data into a named graph in
stardog, using the -g or --named-graph option.  For example:

    time stardog data add --named-graph http://example.com/ibanez_graph test ~/deploy/vanvactor_mirna/data/ibanez/2008/ibanez-2008-mir-homologs.nt

Note that if you use this method, even if the files you are loading have named
graphs, all triples are put into the named graph you specify on the command
line.  For example, `foo.trix` has 8 triples stored in 3 named graphs and one
default graph.  Loading it into the graph `foo_graph`, puts all 8 triples into `foo_graph`:

    time stardog data add --named-graph http://example.com/foo_graph test foo.trix

    # Select all triples in foo_graph.
    time stardog query "test;reasoning=QL" "
        PREFIX ex:<http://example.com/>
        SELECT ?s ?p ?o
        WHERE {
          GRAPH ex:foo_graph {
            ?s ?p ?o .
          }
        }
    "
    +--------------------------------+----------------------------+---------------------------+
    |               s                |             p              |             o             |
    +--------------------------------+----------------------------+---------------------------+
    | http://example.com/todd        | http://example.com/eats    | http://example.com/salad  |
    | http://example.com/todd        | http://example.com/eats    | http://example.com/coffee |
    | http://example.com/todd        | http://example.com/likes   | http://example.com/coffee |
    | http://example.com/todd        | http://example.com/likes   | http://example.com/mms    |
    | http://example.com/todd        | http://example.com/types   | http://example.com/slowly |
    | http://example.com/jj          | http://example.com/eats    | http://example.com/mms    |
    | http://example.com/jj          | http://example.com/likes   | http://example.com/mms    |
    | http://example.com/likes_graph | http://example.com/version | 1                         |
    +--------------------------------+----------------------------+---------------------------+


Now here are some example queries which show how to specify what graphs are
available for querying in the default graph and named graphs of the SPARQL
dataset.  The default configuration in stardog makes every graph is available,
I think, unless you use a `FROM` or `FROM NAME` to change it.

    # select from the default graph
    time stardog query "test;reasoning=QL" "
        PREFIX ex:<http://example.com/>
        SELECT ?s ?p ?o
        WHERE {
        ?s ?p ?o .
        }
    "

    # select triples from a named graph
    time stardog query "test;reasoning=QL" "
        PREFIX ex:<http://example.com/>
        SELECT ?s ?p ?o
        WHERE {
          GRAPH ex:likes_graph {
            ?s ?p ?o .
          }
        }
    "

    # select triples from all named graphs
    time stardog query "test;reasoning=QL" "
        PREFIX ex:<http://example.com/>
        SELECT ?s ?p ?o ?g
        WHERE {
          GRAPH ?g {
            ?s ?p ?o .
          }
        }
    "

    # select triples from a limited list of named graphs
    time stardog query "test;reasoning=QL" "
        PREFIX ex:<http://example.com/>
        SELECT ?s ?p ?o ?g
        FROM NAMED ex:likes_graph
        FROM NAMED ex:jj_graph
        WHERE {
          GRAPH ?g {
            ?s ?p ?o .
          }
        }
    "

    # make a new default graph out of the two named graphs
    time stardog query "test;reasoning=QL" "
        PREFIX ex:<http://example.com/>
        SELECT ?s ?p ?o
        FROM ex:likes_graph
        FROM ex:eats_graph
        WHERE {
          ?s ?p ?o .
        }
    "


# Ontologies of Note

## Science, Physics and Statistics Ontologies

http://qudt.org/
QUDT - Quantities, Units, Dimensions and Data Types in OWL and XML
The goals of the QUDT ontology are twofold:

- to provide a unified model of, measurable quantities, units for measuring
  different kinds of quantities, the numerical values of quantities in
  different units of measure and the data structures and data types used to
  store and manipulate these objects in software;
- to populate the model with the instance data (quantities, units, quantity
  values, etc.) required to meet the life-cycle needs of the Constellation
  Program engineering community.


## Provenance Ontologies

The Open Provenance Model Vocabulary (OPMV) defines basic classes and properties that can be used to describe the provenance of something, be it a document, a particular statistical observation, or a section in an item of legislation.
https://code.google.com/p/opmv/


## Dataset Ontologies

http://www.w3.org/TR/void/

VoID is an RDF Schema vocabulary for expressing metadata about RDF datasets. It
is intended as a bridge between the publishers and users of RDF data, with
applications ranging from data discovery to cataloging and archiving of
datasets.


http://dublincore.org/documents/dcmi-terms/

The Dublin Core metadata terms are a set of vocabulary terms which can be used
to describe resources for the purposes of discovery. The terms can be used to
describe a full range of web resources (video, images, web pages, etc.),
physical resources such as books and objects like artworks.  Dublin Core
Metadata can be used for multiple purposes, from simple resource description,
to combining metadata vocabularies of different metadata standards, to
providing interoperability for metadata vocabularies in the Linked data cloud
and Semantic web implementations.


## Biological Ontologies



# Tracking Provenance With Contexts / Named Graphs

These N-Quads docs (http://sw.deri.org/2008/07/n-quads/) contain some
discussion of quads, contexts, and provenance tracking:

> The notion of provenance is essential when integrating data from different
> sources or on the Web. Therefore, state-of-the-art RDF repositories store
> subject-predicate-object-context quadruples, where the context typically
> denotes the provenance of a given statement. The SPARQL query language can
> query RDF datasets, entire collections of RDF graphs. The context element is
> also sometimes used to track a dimension such as time or geographic location.

The W3C TriX page (http://www.w3.org/2004/03/trix/) provides an overview about
the Named Graphs work being conducted by some participants of the Semantic Web
Interest Group.

> Named Graphs aim at more complex RDF application areas like:
>
> - data syndication and lineage tracing
> - ontology versioning
> - modelling context
> - modelling access control
> - expressing privacy preferences
> - scoping assertions

The paper "Modelling Context using Named Graphs" (http://lists.w3.org/Archives/Public/www-archive/2004Feb/att-0072/swig-bizer-carroll.pdf) has some enlightening examples of how one might ACTUALLY represent provenance using named graphs:

> Example: Provenance and Signing
>
>     G1 (Monica ex:hasStatus Admin.
>         Monica rdf:type ex:Person.
>         G1 ex:author Andy.
>         G1 dc:date “2/10/2004”)
>     G2 (G1 ex:hasSignature “xd2shfl22k4jdsre…”.
>         G1 ex:Signer Andy)
>     G3 (Andy ex:publicKeyURL http://bla.bla.bla)
>
> Example: Simple Provenance Tracking
>
>     G1 (Monica ex:name “Monica Murphy“.
>         Monica rdf:type ex:Person)
>     G2 (G1 dc:author Chris.
>         G1 dc:date “2/10/2004”)
>     G3 (Monica ex:hasSkill ex:Programming)
>     G4 (G3 dc:author Peter.
>         G3 dc:date “2/3/2004”)
>
> Example: Provenance Chains
> Peter states, that Chris said that Andy said, that Monica Murphy is a person.
>
>     G1 (Monica ex:name “Monica Murphy“.
>         Monica rdf:type ex:Person)
>     G2 (G1 ex:saidby Andy.
>         G1 ex:SourceURL Doc1.trix.
>         G1 dc:date “2/10/2004”)
>     G3 (G2 ex:saidby Chris.
>         G2 ex:SourceURL Doc2.trix.
>         G2 dc:date “2/10/2004”)
>     G4 (G1 dc:author Peter.
>         G2 dc:author Peter.
>         G3 dc:author Peter)
>     G5 (G4 dc:author Peter.
>         G4 dc:date “2/10/2004”)


# What are PURL URLs and why should they be preferred over WWW URLs?

From the horse's mouth (http://purl.org/docs/index.html):

> PURLs (Persistent Uniform Resource Locators) are Web addresses that act as
> permanent identifiers in the face of a dynamic and changing Web infrastructure.
> Instead of resolving directly to Web resources, PURLs provide a level of
> indirection that allows the underlying Web addresses of resources to change
> over time without negatively affecting systems that depend on them. This
> capability provides continuity of references to network resources that may
> migrate from machine to machine for business, social or technical reasons.


A partial explanation at http://thing-described-by.org/:

> Name Versus Location.  HTTP URIs -- URIs that begin with "http://" -- are
> increasingly used as globally unambiguous names of things other than web pages.
> For example, you could make up a URI to act as a globally unique name for
> yourself, or your car, or a particular concept in an ontology.  The nice thing
> about using HTTP URIs for this purpose is that the URI can double as a document
> locator, so you can easily place authoritative data about that URI where others
> will know to find it ("follow your nose").  For example, if you mint an HTTP
> URI to name a concept in an ontology, it is helpful to provide a document,
> accessible via that URI, that tells others what concept the URI is intended to
> name.
>
> Resource Ambiguity.  However, using the same URI both as the name of the
> concept and the location of a web page describing that concept creates an
> ambiguity: Does the URI name the concept or the web page describing the
> concept?  To avoid such ambiguity, the W3C TAG recommends that the URI
> describing the concept should forward (using an HTTP 303 See Other status code)
> to a related URI for retrieving the descriptive document.  

More explanation can be found at "Best Practice Recipes for Publishing RDF
Vocabularies" (http://www.w3.org/TR/swbp-vocab-pub/), which provides
implementation recipes for serving HTML and RDF representations and doing
content negotiation using Apache.

> When an HTTP client attempts to dereference a URI, it can specify which type
> (or types) of content it would prefer to receive in response. It does this by
> including an 'Accept:' field in the header of the request message, the value of
> which gives MIME types corresponding to preferred content types. For example,
> an HTTP client that prefers RDF/XML content might include the following field
> in the header of each request:
>
>     Accept: application/rdf+xml
>
> Similarly, an HTTP client that prefers HTML content, such as a Web browser,
> might include something like the following field in the header of each request:
>
>     Accept: application/xhtml+xml,text/html
>
> Uniprot provides an example of purl urls in the wild that provide a level of
> indirection to a url that handles content negotiation (RDF or HTML) by
> redirecting to urls that serve RDF or HTML content.

The purl url redirects to the content-negotiation URL.  It serves the same
content (a 303 redirect) whether or not an RDF Accept header is provided:

    curl -I http://purl.uniprot.org/taxonomy/9606
    HTTP/1.1 303 See Other
    Date: Fri, 31 May 2013 19:57:52 GMT
    Server: Apache/2.2.3 (CentOS)
    Location: http://www.uniprot.org/?query=purl:taxonomy/9606
    Connection: close
    Content-Type: text/html; charset=iso-8859-1

    curl -I --header "Accept: application/rdf+xml" http://purl.uniprot.org/taxonomy/9606
    HTTP/1.1 303 See Other
    Content-Type: text/html
    Date: Fri, 31 May 2013 20:02:06 GMT
    Location: http://www.uniprot.org/?query=purl:taxonomy/9606
    Connection: Keep-Alive
    Content-Length: 0

The content-negotiation URL it redirects to
(http://www.uniprot.org/?query=purl:taxonomy/9606) does
do content negotiation, redirecting to an html or an rdf url depending on the
Accept header it receives:

    curl --include --header "Accept: application/rdf+xml" http://www.uniprot.org/?query=purl:taxonomy/9606
    HTTP/1.1 302 Found
    Date: Fri, 31 May 2013 19:39:34 GMT
    X-Hosted-By: Protein Information Resource
    Access-Control-Allow-Origin: *
    Access-Control-Allow-Headers: origin, x-requested-with, content-type
    X-UniProt-Release: 2013_06
    Location: http://www.uniprot.org/taxonomy/9606.rdf
    Content-Type: text/html
    Content-Length: 0
    Vary: User-Agent,Accept-Encoding

    curl --include http://www.uniprot.org/?query=purl:taxonomy/9606
    HTTP/1.1 302 Moved Temporarily
    Server: Apache-Coyote/1.1
    Vary: User-Agent
    X-Hosted-By: European Bioinformatics Institute
    Content-Type: text/html
    Date: Fri, 31 May 2013 19:59:25 GMT
    X-UniProt-Release: 2013_06
    Location: http://www.uniprot.org/taxonomy/9606
    Access-Control-Allow-Origin: *
    Access-Control-Allow-Headers: origin, x-requested-with, content-type
    Content-Length: 0
