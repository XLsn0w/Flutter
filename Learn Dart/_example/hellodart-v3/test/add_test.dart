// Copyright 2018 <chaishushan{AT}gmail.com>. All rights reserved.
// Use of this source code is governed by a BSD-style
// license that can be found in the LICENSE file.

// https://pub.dartlang.org/packages/test

import "package:test/test.dart";
import 'package:helloworld/add.dart' as pkg;

void main() {
  test("add", () {
    expect(pkg.add(1, 1), 2);
  });
  test("add", () {
    expect(pkg.add(1, 2), 3);
  });
}
