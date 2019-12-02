// Copyright 2018 <chaishushan{AT}gmail.com>. All rights reserved.
// Use of this source code is governed by a BSD-style
// license that can be found in the LICENSE file.

// https://www.dartlang.org/tutorials/dart-vm/get-started

void main(List<String> args) {
  for (int i = 0; i < args.length; i++) {
    print('${i + 1}: ${args[i]}');
  }
}
