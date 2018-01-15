#!/usr/bin/env python
import ast
import sys

download_marker = "downloads"


class FormatItem(object):
  def __init__(self, s, r):
    self.s = s
    self.r = r


def main(_args):
  if len(_args) != 4:
    raise ValueError("Invalid arguments passed, expecting [fpath] [version] [Platform] [archive type]")

  fpath, ver, platform, arch_type = args

  # download
  with open(fpath, "r") as f_ptr:
    download_list = [line.strip() for line in f_ptr if line[:len(download_marker)] == download_marker]

  re_format_list = [
    FormatItem("files: new Array()", "files: []"),
    FormatItem(";", ""),
    FormatItem(" title:", " \"title\":"),
    FormatItem("lictitle:", "\"lictitle\":"),
    FormatItem("licpath:", "\"licpath\":"),
    FormatItem("files:", "\"files\":"),
    FormatItem("downloads[", "["),
    FormatItem("'", "\"")
  ]

  values = []

  # re-format
  for line in download_list:
    line = str(line)
    for fmt in re_format_list:
      if fmt.s in line:
        line = line.replace(fmt.s, fmt.r)

    _, _, value = line.partition("=")

    values.append(ast.literal_eval(value.strip()))

  for value in values:
    if "filepath" in value and value["title"].lower() == platform.lower() \
            and "."+arch_type.lower() in value["filepath"].lower() \
            and ver in value["filepath"]:
      print(value["filepath"].strip())
      return


if __name__ == "__main__":
  args = list(sys.argv)
  args.pop(0)
  main(args)
