#!/usr/bin/env dart
// Copyright 2018 <chaishushan{AT}gmail.com>. All rights reserved.
// Use of this source code is governed by a BSD-style
// license that can be found in the LICENSE file.

library helloworld_all_tests;

import 'example_test.dart' as example;
import 'example_async_test.dart' as example_async;

import 'add_test.dart' as add;
import 'sub_test.dart' as sub;

void main() {
  example.main();
  example_async.main();

  add.main();
  sub.main();
}
