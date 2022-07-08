#!/usr/bin/env python
import setuptools

"""The setup script."""

from setuptools import setup, find_packages

with open('README.rst') as readme_file:
    readme = readme_file.read()

with open('HISTORY.rst') as history_file:
    history = history_file.read()

test_requirements = [ ]

setup(
    author="Jerome B.",
    author_email='audreyr@example.com',
    install_requires=[
        'hy>=1.0a4',
        'pygame'
    ],   
    python_requires='>=3.6',
    classifiers=[
        'Development Status :: 2 - Pre-Alpha',
        'Intended Audience :: Developers',
        'Natural Language :: English',
        'Programming Language :: Python :: 3.10',
    ],
    description="Python Boilerplate contains all the boilerplate you need to create a Python package.",
    entry_points={
        'console_scripts': [
            'limetime=limetime.cli:main',
        ],
    },
    long_description=readme + '\n\n' + history,
    include_package_data=True,
    keywords='limetime',
    name='limetime',
    packages=setuptools.find_packages(),
    test_suite='tests',
    tests_require=test_requirements,
    url='https://github.com/audreyr/limetime',
    version='0.1.0',
    zip_safe=False,
    package_data = {'': ['*.hy', '__pycache__/*']},
)
