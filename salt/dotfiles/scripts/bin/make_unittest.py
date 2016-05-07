#!/usr/bin/env python3
"""
This program is designed to facilitate generating stubs for test case development
"""

import argparse
import datetime
import os
import re

GPL3_HEADER = """Copyright (C) <year>  <author>

This program is free software: you can redistribute it and/or modify
it under the terms of the GNU General Public License as published by
the Free Software Foundation, either version 3 of the License, or
(at your option) any later version.

This program is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU General Public License for more details.

You should have received a copy of the GNU General Public License
along with this program.  If not, see <http://www.gnu.org/licenses/>.
"""

BSD_HEADER = """Copyright (c) <year>, <author>
All rights reserved.

Redistribution and use in source and binary forms, with or without
modification, are permitted provided that the following conditions are met:

* Redistributions of source code must retain the above copyright notice, this
  list of conditions and the following disclaimer.

* Redistributions in binary form must reproduce the above copyright notice,
  this list of conditions and the following disclaimer in the documentation
  and/or other materials provided with the distribution.

THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS"
AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE
FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL
DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR
SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER
CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY,
OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
"""

LICENCES = {
    "gpl3": GPL3_HEADER,
    "bsd": BSD_HEADER
}
def format_filename(filename):
    """
    formats "module_name.py" -> "test_module_name.py"
    """

    return "test_" + os.path.basename(filename)

def format_classname(filename):
    """
    formats "module_name.py" -> "TestModuleName"
    """
    basename = filename.split('.')[0]
    return "".join([word.capitalize() for word in ["test"] + basename.split('_')])

def format_modulename(filename):
    """
    formats "module_name.py" -> "test_module_name"
    """
    basename = filename.split('.')[0]
    return "test_" + basename

def format_functionname(function_name):
    """
    formats "function_name" -> "test_module_name"
    """
    return "test_" + function_name

def generate_file_info(filename):
    """
    creates a generic file info statement
    """
    functionality = filename.split(".")[0].replace("_", " ")
    return ("This module contains the functions related to {functionality}"
            "".format(functionality=functionality))

def generate_functions(function_name):
    """
    generates a test functions
    """
    name = format_functionname(function_name)
    return ('\t@unittest.skip("Unimplemented")\n'
            '\tdef {function_name} (self):\n'
            '\t\t"""\n'
            '\t\tA function to test the {functionality} functionality\n'
            '\t\t"""\n'
            '\t\tpass\n\n'
            ''.format(function_name=name, functionality=function_name))

def generate_class(name, functions):
    '''
    generates a TestCase object
    '''
    classname = format_classname(name)
    modulename = format_modulename(name)
    class_header = ('class {classname}(unittest.TestCase):\n'
                    '\t"""\n'
                    '\tTest cases for {modulename}\n'
                    '\t"""\n\n'.format(classname=classname, modulename=modulename))
    function_definitions = "".join([generate_functions(function) for function in functions])
    return class_header + function_definitions

def generate_fileheader(filename, module_info=None, copyright_statement=None):
    """
    generate the header that goes at the top of the file
    """
    file_info = module_info or generate_file_info(filename)

    return ('#!/usr/bin/env python3\n'
            '"""\n'
            '{module_info}\n\n'
            '{copyright}\n'
            '{file_info}\n'
            '"""\n'
            ''.format(copyright=copyright_statement, module_info=module_info, file_info=file_info))

def find_functions(name):
    """
    returns a list of functions in the file to test
    """
    function_expr = re.compile(r'\s*def (\S*)\s*\(')
    with open(name) as infile:
        functions = function_expr.findall(infile.read())
    return functions

def generate_test_file(name, module_info, copyright_statement):
    """
    Generate a testing file
    """
    functions = find_functions(name)
    name = os.path.basename(name)
    with open(format_filename(name), "w") as outfile:
        outfile.write(generate_fileheader(name, module_info, copyright_statement))
        outfile.write(generate_class(name, functions))
        outfile.write("\n") #be nice and put newline at end of file

def get_licence_text(licence, author):
    """
    dynamically get license text
    """
    year = datetime.date.today().year

    licence_text = LICENCES.get(licence, "")
    licence_text = licence_text.replace("<year>", str(year))
    licence_text = licence_text.replace("<author>", author)
    return licence_text

def parse_args():
    """
    Parse Arguments passed on the command line
    """
    parser = argparse.ArgumentParser(description="generates python unittest testcases")
    parser.add_argument("-c", "--copyright", default="", help="choose a license [bsd,gpl]")
    parser.add_argument("-m", "--module_info", help="module info")
    parser.add_argument("-a", "--author", help="Author's full name")
    parser.add_argument("filename", help="file to generate cases for")

    return parser.parse_args()

def main():
    """
    Main method for the Python Unittest TestCase genrerator
    """
    args = parse_args()
    prog_copyright = get_licence_text(args.copyright, args.author)
    filename = os.path.abspath(args.filename)
    generate_test_file(filename, args.module_info, prog_copyright)


if __name__ == '__main__':
    main()
