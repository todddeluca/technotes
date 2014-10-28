



## __repr__

https://mail.python.org/pipermail/python-ideas/2012-February/014002.html:

    def get_attributes(o):
        attributes = [(a, getattr(o, a)) for a in
    set(dir(o)).difference(dir(object)) if a[0] != "_"]
        return {a[0]: a[1] for a in attributes if not callable(a[1])}

    class ReprMixin(object):

        def _format(self, v):
            if isinstance(v, (basestring, date, time, datetime)):
                v = "'%s'" % v
                return v.encode("utf-8", errors="ignore")
            else:
                return v

        def __repr__(self):
            attribute_string = ", ".join("%s=%s" % (k[0],
    self._format(k[1])) for k in get_attributes(self).items())
            return "%s(%s)" % (type(self).__name__, attribute_string)

http://stackoverflow.com/questions/7072938/including-a-formatted-iterable-as-part-of-a-larger-formatted-string:

    # this is a staticmethod or module level function
    def argrepr(name, *args):
        return '{}({})'.format(name, ', '.join(repr(arg) for arg in args))

    def __repr__(self): 
        return argrepr(self.__name__, self.arg1, self.arg2, self.arg3)

As a one liner:

    def __repr__(self):
        return '{}({})'.format(self.__name__, ', '.join(repr(a) for a in [self.arg1, self.arg2, self.arg3]))


## XML


ElementTree helper functions:

    def _nspath(path):
        '''
        Element Tree hideously changes tag names like 'version' into '{http://maven.apache.org/POM/4.0.0}version'.
        This function takes a path, like './parent/version' and adds the horrid
        namespace prefix to the tag names in the path, while leaving "special"
        path elements, like '.' and '*' untouched.
        '''
        wildcards = ['', '.', '*']
        ns = '{http://maven.apache.org/POM/4.0.0}'
        # add namespaces prefixes to tags in the path
        nspath = '/'.join((p if p in wildcards else ns + p) for p in path.split('/'))
        return nspath


    def _findtext(pom, path):
        '''
        Find the text of the first element matching the tags given.
        path: e.g. './/dependency/version'
        tags: a list of element tags.  Do not include the root tag, 'project'

        Example:
            pom = '<project><parent><version>1.0.0</version></parent></project>'
            _findtext(pom, './parent/version') == '1.0.0'
        '''
        root = et.fromstring(pom)
        return root.findtext(_nspath(path))


### xml.dom.minidom

I/O Functions:

    def read_str(text):
        return xml.dom.minidom.parseString(text)


    def write_str(doc):
        # Tweak the header and whitespace surrounding the newline element to be more consistent with our poms
        xml_header = '<?xml version="1.0" encoding="UTF-8"?>\n'
        return re.sub(r'^<\?xml[^>]*>\n?', xml_header, doc.toxml() + '\n')


    def read_file(path):
        with open(path) as fh:
            return read_str(fh.read())


    def write_file(doc, path):
        with open(path, 'w') as fh:
            fh.write(write_str(doc))


DOM Manipulation Functions:

    def update_elem_with_text(doc, elem, text):
        '''
        Replace all the children of elem (if any) with a single text node containing `text`.
        :param doc:
        :param elem:
        :param text:
        :return:
        '''
        for kid in elem.childNodes:
            elem.removeChild(kid)
            kid.unlink()

        elem.appendChild(doc.createTextNode(text))


    def find_elem(elem, path):
        '''
        Find and return the first child of `elem` that is an element with the tag `path`.  If no child matches, None is returned.
        :param elem:
        :param path: a string that should be the name of a child element tag
        :return: an element node matching `path` or None
        '''
        for child in elem.childNodes:
            if child.nodeType == child.ELEMENT_NODE and child.tagName == path:
                return child


    def get_node_text(node):
        return ''.join(kid.data for kid in node.childNodes if kid.nodeType == kid.TEXT_NODE)




