


Example of using ArgParse to map subcommands to functions with less boilerplate:


    def echo(msg='Hello World'):
        print(msg)


    def echo_command(cmd, args):
        print('Pretending to run command:', cmd, ' '.join(args))


    def main():

        parser = argparse.ArgumentParser()
        subparsers = parser.add_subparsers(dest='action')
        # Configure echo subparser
        subparser = subparsers.add_parser('echo')
        subparser.add_argument('-m', '--msg', required=True, help='An example of a required "option"')
        subparser = subparsers.add_parser('echo_command')
        subparser.add_argument('cmd', help='A positional argument example.')
        subparser.add_argument('args', nargs='*', help='An example of collecting multiple arguments.')

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
