# Python Command Line Interfact Notes

These are my notes on how to build command line interfaces using Python,
argparse, etc.

Sources:

https://docs.python.org/3/library/argparse.html
http://click.pocoo.org/3/setuptools/


## Dispatching CLI Invocations to Functions/Methods

By following some naming conventions, we can reduce the boilerplate involved
with mapping argparse parsers/args to a function and its arguments. The
following example follows two conventions:

- the parser name matches a module function name
- the parser args match the function arg names.

Example:

    import argparse

    def echo(msg='Hello World'):
        print(msg)

    def main():

        parser = argparse.ArgumentParser()
        subparsers = parser.add_subparsers(dest='action') # destination stores subparser name
        # Configure echo subparser
        subparser = subparsers.add_parser('echo')
        subparser.add_argument('-m', '--msg', required=True, help='An example of a required "option"')

        # invoke a function whose name corresponds to action and
        # whose parameter names correspond with the cli arguments.
        args = parser.parse_args()
        if args.action is None:
            parser.print_help()
        else:
            kws = dict(vars(args))
            del kws['action']
            return globals()[args.action](**kws)

    if __name__ == '__main__':
        main()


Example of using `argparse` to map subcommands to functions using a default
'func' argument.  This allows dispatch to methods on objects or other calls
where the function name does not match the parser name.  The following example
follows one convention:

- the parser args match the function arg names:

Example:

    import argparse

    def echo(msg='Hello World'):
        print(msg)

    def main():
        parser = argparse.ArgumentParser(description='')
        subparsers = parser.add_subparsers(help='')

        # Configure echo subparser
        subparser = subparsers.add_parser('echo')
        subparser.add_argument('-m', '--msg', required=True, help='An example of a required "option"')
        subparser.set_defaults(func=echo) # store the function to invoke as a default argument

        # parse command line args and pass as keyword args to func.
        args = parser.parse_args()
        kws = dict(vars(args)) # convert argparse.Namespace to dict
        del kws['func'] # remove 'func' entry
        return args.func(**kws)

    if __name__ == '__main__':
        main()

Example of how to create subcommands nested within subcommands, like `myscript group cmd <msg>`:

    import argparse

    def echo(msg):
        print(msg)

    def main():
        parser = argparse.ArgumentParser()
        subparsers = parser.add_subparsers()
        
        a_parser = subparsers.add_parser('group')
        a_subparsers = a_parser.add_subparsers()

        subparser = a_subparsers.add_parser('cmd')
        subparser.add_argument('msg')
        subparser.set_defaults(func=echo) # store the function to invoke as a default argument

        # parse command line args and pass as keyword args to func.
        args = parser.parse_args()
        kws = dict(vars(args)) # convert argparse.Namespace to dict
        del kws['func'] # remove 'func' entry
        return args.func(**kws)

    if __name__ == '__main__':
        main()



## Setuptools Entrypoints

See http://click.pocoo.org/3/setuptools/

