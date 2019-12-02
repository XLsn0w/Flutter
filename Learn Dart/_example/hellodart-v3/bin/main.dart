// Copyright 2018 <chaishushan{AT}gmail.com>. All rights reserved.
// Use of this source code is governed by a BSD-style
// license that can be found in the LICENSE file.

// https://www.dartlang.org/tutorials/dart-vm/get-started

import 'package:helloworld/add.dart' as addpkg;
import 'package:helloworld/sub.dart' as subpkg;

void main(List<String> args) {
  for (int i = 0; i < args.length; i++) {
    print('${i + 1}: ${args[i]}');
  }

  print(addpkg.add(1, 2));
  print(subpkg.sub(1, 2));
}
