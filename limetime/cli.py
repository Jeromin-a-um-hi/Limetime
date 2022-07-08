"""Console script for limetime."""
import sys
from limetime.hi import hello

def main():
    hello()
    print("hi!!")
    return 0


if __name__ == "__main__":
    sys.exit(main())  # pragma: no cover
