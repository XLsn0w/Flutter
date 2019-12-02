// Copyright 2018 <chaishushan{AT}gmail.com>. All rights reserved.
// Use of this source code is governed by a BSD-style
// license that can be found in the LICENSE file.

// https://pub.dartlang.org/packages/test

import "package:test/test.dart";
import 'package:helloworld/sub.dart' as pkg;

void main() {
  test("sub", () {
    expect(pkg.sub(5, 3), 2);
  });
}
