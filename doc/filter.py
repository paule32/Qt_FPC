# ----------------------------------------------------------------------------
# File : filter.py
# Autor: (c) 2024 by Jens Kallup - paule32
#        all rights reserved.
#
# only for education, and non-profit !
# ----------------------------------------------------------------------------
import sys
import os
import re
import shutil

# ----------------------------------------------------------------------------
# cut ../ recursive from a given string "text" ...
# ----------------------------------------------------------------------------
def recursive_cut(text):
    # -------------------------------------------------
    # default: when text is empty, or dont contain ../
    # then result will be the text ...
    # -------------------------------------------------
    if not text or not text.startswith("../"):
        return text
    
    # -------------------------------------------------
    # recursive cut "../" ...
    # -------------------------------------------------
    return recursive_cut(text[3:])

# ----------------------------------------------------------------------------
# replace all custom tags from html file with the given content ...
# ----------------------------------------------------------------------------
def process_custom_tags(input_dir, output_dir):
    # -----------------------------------------------
    # create output directory, if it not exists...
    # -----------------------------------------------
    if not os.path.exists(output_dir):
        os.makedirs(output_dir)
    
    # -----------------------------------------------
    # iterate all files from input directory ...
    # -----------------------------------------------
    for root, dirs, files in os.walk(input_dir):
        for filename in files:
            input_file  = os.path.join(root, filename)
            output_file = os.path.join(output_dir, os.path.relpath(
            input_file, input_dir))
            
            # -------------------------------------------
            # ignore directories, and non HTML files...
            # -------------------------------------------
            if not filename.endswith(".html"):
                continue
            
            with open(input_file,"r", encoding="utf-8") as infile:
                content = infile.read()
            
            # -------------------------------------------
            # replace custom tags ...
            # -------------------------------------------
            content = re.sub(
            r'\\fcolor\{([^\{\}]*)\}\{([^\{\}]*)\}',
            r'<font color="\1">\2</font>', content )
            
            if re.search(r'\\dotimg\{datentypen\.png\}', content):
                match = re.search(r'\\dotimg\{(datentypen\.png)\}\{([^\{\}]*)\}\{([^\{\}]*)\}\{([^\{\}]*)\}', content)
                if match:
                    data1 = match.group(2)  # Super Box
                    data2 = match.group(3)  # left  Box
                    data3 = match.group(4)  # right Box
                    
                    href1 = re.search(r'<a\s+.*href="([^"]*)"', data1)
                    href2 = re.search(r'<a\s+.*href="([^"]*)"', data2)
                    href3 = re.search(r'<a\s+.*href="([^"]*)"', data3)
                    
                    link1 = href1.group(1)
                    link2 = href2.group(1)
                    link3 = href3.group(1)
                    
                    # ----------------------------------------------------
                    # replace scaned text parens ...
                    # ----------------------------------------------------
                    content = re.sub(
                    r'(\\dotimg\{(datentypen\.png)\})\{([^\{\}]*)\}\{([^\{\}]*)\}\{([^\{\}]*)\}',
                    r'\1', content)
                    
                    content = re.sub(
                    r'\\dotimg\{(datentypen\.png)\}',
                    r'<p><img src="datentypen.png" usemap="#image-map">'
                    + '<map name="image-map">'
                    + '<area href="' + link1 + '" target="" alt="Datentypen"      title="Datentypen"      coords="90,3,235,40"    shape="rect">'
                    + '<area href="' + link2 + '" target="" alt="ohne Vorzeichen" title="ohne Vorzeichen" coords="6,84,152,121"   shape="rect">'
                    + '<area href="' + link3 + '" target="" alt="mit Vorzeichen"  title="mit Vorzeichen"  coords="174,85,318,121" shape="rect">'
                    + '</map></p>', content )
            
            keywords = [
            "auto",
            "break",
            "case",
            "char",
            "class",
            "continue",
            "do",
            "double",
            "else",
            "float",
            "for",
            "friend",
            "goto",
            "if",
            "include",
            "int",
            "private",
            "protected",
            "public",
            "register",
            "return",
            "short",
            "signed",
            "struct",
            "switch",
            "template",
            "typedef",
            "unsigned",
            "virtual",
            "void",
            "while" ]
            
            for element in keywords:
                match = re.search(
                r'<tr class="memitem:"><td class="memItemLeft" align="right" ' +
                'valign="top">struct &#160;</td><td class="memItemRight" ' +
                'valign="bottom"><a class="el" href=(\".*\.html\")>' + element +
                '</a></td>\</tr>', content )
                
                if match:
                    data = match.group(1)
                    content = re.sub(
                    r'<tr class="memitem:"><td class="memItemLeft" align="right" ' +
                    'valign="top">struct &#160;</td><td class="memItemRight" ' +
                    'valign="bottom"><a class="el" href=(".*\.html")>' + element +
                    '</a></td>\</tr>',
                    r'<tr class="memitem:"><td class="memItemLeft" align="right" ' +
                    'valign="top">Schlüsselwort &#160;</td><td class="memItemRight" ' +
                    'valign="bottom"><a class="el" href="' + data + '">' + element +
                    '</a></td></tr>', content )
            
            # ----------------------------------------------------
            # create output directory, if it not exists ...
            # ----------------------------------------------------
            output_subdir = os.path.dirname(output_file)
            if not os.path.exists(output_subdir):
                os.makedirs(output_subdir)
            
            with open(output_file, "w", encoding="utf-8") as outfile:
                outfile.write(content)

# ----------------------------------------------------------------------------
# copy all files with the extension of "file_ext" from src to dst dir ...
# ----------------------------------------------------------------------------
def copy_ext_files(src_dir, dest_dir, file_ext):
    # ---------------------------------------------------------
    # iterate recursive all source directories, and files...
    # ---------------------------------------------------------
    for root, dirs, files in os.walk(src_dir):
        for file in files:
            # -------------------------------------------------
            # check the extension "file_ext" for the file ...
            # -------------------------------------------------
            if file.endswith(file_ext):
                # -------------------------------------------------
                # build the path name for source and dest. file ...
                # -------------------------------------------------
                src_file = os.path.join(root, file)
                dest_file = os.path.join(dest_dir, os.path.relpath(src_file, src_dir))
                
                # -------------------------------------------------
                # create destination directory, if it not exists...
                # -------------------------------------------------
                dest_subdir = os.path.dirname(dest_file)
                if not os.path.exists(dest_subdir):
                    os.makedirs(dest_subdir)
                
                # -------------------------------------------------
                # copy the file in the destination directory...
                # -------------------------------------------------
                shutil.copy2(src_file, dest_file)

# ----------------------------------------------------------------------------
# get command line arguments to pass the directory for doxygen output ...
# ----------------------------------------------------------------------------
if len(sys.argv) != 3:
    print("filter.py (c) 2024 by Jens Kallup - paule32")
    print("all rights reserved.")
    print("")
    print("Usage: python filter.py <input dir> <output dir>")
    sys.exit(1)

if not os.path.exists(sys.argv[1]):
    print("error: input dir does not exists.")
    print("abort.")
    sys.exit(1)

input_dir  = sys.argv[1]
output_dir = sys.argv[2]

# ----------------------------------------------------------------------------
# recursive process the output directories...
# ----------------------------------------------------------------------------
process_custom_tags(input_dir, output_dir)
copy_ext_files(input_dir, output_dir, ".png")
copy_ext_files(input_dir, output_dir, ".svg")

sys.exit(0)
