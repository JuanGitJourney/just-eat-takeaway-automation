import os
import argparse


def run_robot_tests(args):
    tests_directory = os.path.join(os.path.dirname(__file__), 'src/tests/careers')
    path_to_execute = tests_directory if args.test_case == 'all' else f'{tests_directory}/{args.test_case}.robot'
    print(path_to_execute)

    if os.path.exists(path_to_execute):
        os.system(f'robot --outputdir {args.output} {path_to_execute}')
    else:
        raise Exception(f"Could not find '{path_to_execute}'")


if __name__ == '__main__':
    parser = argparse.ArgumentParser(description='Execute Robot Framework tests')
    parser.add_argument('-t', '--test-case', help='Name of the test case to run', default='all')
    parser.add_argument('-o', '--output', help='Output dir to store the logs', required=True)
    args = parser.parse_args()

    run_robot_tests(args)
