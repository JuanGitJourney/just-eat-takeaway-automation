import os
import argparse
import subprocess


def run_robot_tests(args):
    tests_dir = os.path.join(os.path.dirname(__file__), "src/tests/careers")
    test_suites = [os.path.join(tests_dir, f) for f in os.listdir(tests_dir) if f.endswith(".robot")]

    if args.test_case == "all":
        suites_to_run = test_suites
    else:
        if f"{args.test_case}.robot" not in test_suites:
            raise Exception(f"Test case '{args.test_case}' not found!")
        suites_to_run = [f"{args.test_case}.robot"]

    for suite in suites_to_run:
        command = f"robot --outputdir {args.output} {suite}"
        subprocess.run(command.split(), check=True)


if __name__ == "__main__":
    parser = argparse.ArgumentParser(description="Execute Robot Framework tests")
    parser.add_argument(
        "-t", "--test-case", help="Name of the test case to run (or 'all')", default="all"
    )
    parser.add_argument("-o", "--output", help="Output directory to store logs", required=True)
    args = parser.parse_args()

    run_robot_tests(args)