// Copyright 2018 <chaishushan{AT}gmail.com>. All rights reserved.
// Use of this source code is governed by a BSD-style
// license that can be found in the LICENSE file.

// https://pub.dartlang.org/packages/test

import "dart:async";

import "package:test/test.dart";

void main() {
  test("new Future.value() returns the value", () async {
    var value = await new Future.value(10);
    expect(value, equals(10));
  });

  test("new Future.value() returns the value", () {
    expect(new Future.value(10), completion(equals(10)));
  });

  test("new Future.error() throws the error", () {
    expect(new Future.error("oh no"), throwsA(equals("oh no")));
    expect(new Future.error(new StateError("bad state")), throwsStateError);
  });

  test("Stream.fromIterable() emits the values in the iterable", () {
    var stream = new Stream.fromIterable([1, 2, 3]);

    stream.listen(expectAsync1(
      (number) {
        expect(number, inInclusiveRange(1, 3));
      },
      count: 3,
    ));
  });
}
