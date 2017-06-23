/*
 * Copyright 1997-2017 Optimatika (www.optimatika.se)
 *
 * Permission is hereby granted, free of charge, to any person obtaining a copy
 * of this software and associated documentation files (the "Software"), to deal
 * in the Software without restriction, including without limitation the rights
 * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 * copies of the Software, and to permit persons to whom the Software is
 * furnished to do so, subject to the following conditions:
 *
 * The above copyright notice and this permission notice shall be included in
 * all copies or substantial portions of the Software.
 *
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
 * SOFTWARE.
 */
package org.ojalgo.array;

import org.ojalgo.TestUtils;
import org.ojalgo.random.Uniform;

/**
 * AbstractArrayTest
 *
 * @author apete
 */
public class SegmentedArrayTest extends ArrayTests {

    public SegmentedArrayTest() {
        super();
    }

    public SegmentedArrayTest(final String aName) {
        super(aName);
    }

    public void testRandomGetSePrimitiveDenset() {

        final long tmpCount = 5000L;

        final SegmentedArray<Double> tmpArray = Primitive64Array.FACTORY.makeSegmented(tmpCount);

        this.doTestGetSet(tmpArray);

    }

    public void testRandomGetSetLargeBasicArray() {

        final long tmpCount = Long.MAX_VALUE;

        final BasicArray<Double> tmpArray = BasicArray.factory(Primitive64Array.FACTORY).makeZero(tmpCount);

        this.doTestGetSet(tmpArray);

    }

    private void doTestGetSet(final BasicArray<Double> array) {

        final long tmpCount = array.count();

        TestUtils.assertEquals(tmpCount, array.count());

        final Uniform tmpUniform = new Uniform();

        for (int i = 0; i < 100; i++) {

            final long tmpIndex = Uniform.randomInteger(tmpCount);

            final double tmpExpected = tmpUniform.doubleValue();

            array.set(tmpIndex, tmpExpected);

            final double tmpActual = array.doubleValue(tmpIndex);

            TestUtils.assertEquals(tmpExpected, tmpActual);
        }
    }

}
