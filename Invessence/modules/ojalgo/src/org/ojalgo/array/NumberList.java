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

import java.math.BigDecimal;
import java.util.Collection;
import java.util.Iterator;
import java.util.List;
import java.util.ListIterator;
import java.util.RandomAccess;
import java.util.function.BiConsumer;
import java.util.function.BinaryOperator;
import java.util.function.Function;
import java.util.function.Supplier;
import java.util.stream.Collector;

import org.ojalgo.ProgrammingError;
import org.ojalgo.access.Access1D;
import org.ojalgo.access.Iterator1D;
import org.ojalgo.access.Mutate1D;
import org.ojalgo.array.DenseArray.Factory;
import org.ojalgo.function.BinaryFunction;
import org.ojalgo.function.VoidFunction;
import org.ojalgo.scalar.ComplexNumber;
import org.ojalgo.scalar.Quaternion;
import org.ojalgo.scalar.RationalNumber;

public final class NumberList<N extends Number> implements List<N>, RandomAccess, Access1D<N>, Access1D.Visitable<N>, Mutate1D, Mutate1D.Mixable<N> {

    public static final class ListFactory<N extends Number> extends StrategyBuilder<N, NumberList<N>, ListFactory<N>> {

        ListFactory(final DenseArray.Factory<N> denseFactory) {
            super(denseFactory);
        }

        @Override
        public NumberList<N> make() {
            return new NumberList<>(this.getStrategy());
        }

    }

    public static <N extends Number> Collector<N, NumberList<N>, NumberList<N>> collector(final DenseArray.Factory<N> arrayFactory) {
        final Supplier<NumberList<N>> tmpSupplier = () -> NumberList.factory(arrayFactory).make();
        final BiConsumer<NumberList<N>, N> tmpAccumulator = (list, element) -> list.add(element);
        final BinaryOperator<NumberList<N>> tmpCombiner = (part1, part2) -> {
            part1.addAll(part2);
            return part1;
        };
        final Function<NumberList<N>, NumberList<N>> tmpIdentity = Function.identity();
        return Collector.of(tmpSupplier, tmpAccumulator, tmpCombiner, tmpIdentity, Collector.Characteristics.IDENTITY_FINISH);
    }

    public static <N extends Number> ListFactory<N> factory(final DenseArray.Factory<N> arrayFactory) {
        return new ListFactory<>(arrayFactory);
    }

    /**
     * @deprecated v43 Use {@link #factory(Factory)} instead.
     */
    @Deprecated
    public static <N extends Number> NumberList<N> make(final DenseArray.Factory<N> arrayFactory) {
        return NumberList.factory(arrayFactory).make();
    }

    /**
     * @deprecated v43 Use {@link #factory(Factory)} instead.
     */
    @Deprecated
    public static NumberList<BigDecimal> makeBig() {
        return NumberList.factory(BigArray.FACTORY).make();
    }

    /**
     * @deprecated v43 Use {@link #factory(Factory)} instead.
     */
    @Deprecated
    public static NumberList<ComplexNumber> makeComplex() {
        return NumberList.factory(ComplexArray.FACTORY).make();
    }

    /**
     * @deprecated v43 Use {@link #factory(Factory)} instead.
     */
    @Deprecated
    public static NumberList<Double> makePrimitive() {
        return NumberList.factory(Primitive64Array.FACTORY).make();
    }

    /**
     * @deprecated v43 Use {@link #factory(Factory)} instead.
     */
    @Deprecated
    public static NumberList<Quaternion> makeQuaternion() {
        return NumberList.factory(QuaternionArray.FACTORY).make();
    }

    /**
     * @deprecated v43 Use {@link #factory(Factory)} instead.
     */
    @Deprecated
    public static NumberList<RationalNumber> makeRational() {
        return NumberList.factory(RationalArray.FACTORY).make();
    }

    private long myActualCount;
    private BasicArray<N> myStorage;
    private final DenseStrategy<N> myStrategy;

    NumberList(final BasicArray<N> storage, final DenseStrategy<N> strategy, final long actualCount) {

        super();

        myStrategy = strategy;

        myStorage = storage;
        myActualCount = actualCount;
    }

    NumberList(final DenseStrategy<N> strategy) {

        super();

        myStrategy = strategy;

        myStorage = strategy.makeInitial();
        myActualCount = 0L;
    }

    public boolean add(final double e) {

        this.ensureCapacity();

        myStorage.set(myActualCount++, e);

        return true;
    }

    public void add(final int index, final N element) {
        ProgrammingError.throwForUnsupportedOptionalOperation();
    }

    public void add(final long index, final double addend) {
        if (index >= myActualCount) {
            throw new ArrayIndexOutOfBoundsException();
        } else {
            myStorage.add(index, addend);
        }
    }

    public void add(final long index, final Number addend) {
        if (index >= myActualCount) {
            throw new ArrayIndexOutOfBoundsException();
        } else {
            myStorage.add(index, addend);
        }
    }

    public boolean add(final N e) {

        this.ensureCapacity();

        myStorage.set(myActualCount++, e);

        return true;
    }

    public boolean addAll(final Collection<? extends N> elements) {
        for (final N tmpElement : elements) {
            this.add(tmpElement);
        }
        return true;
    }

    public boolean addAll(final double[] elements) {
        for (final double tmpElement : elements) {
            this.add(tmpElement);
        }
        return true;
    }

    public boolean addAll(final int index, final Collection<? extends N> c) {
        ProgrammingError.throwForUnsupportedOptionalOperation();
        return false;
    }

    /**
     * The current capacity of the underlying data structure. The capacity is always greater than or equal to
     * the current number of items in the list. When you add items to the list the capacity may have to grow.
     */
    public long capacity() {
        return myStorage.count();
    }

    public void clear() {
        myActualCount = 0L;
        myStorage.reset();
    }

    public boolean contains(final Object object) {
        if (object instanceof Number) {
            return this.indexOf(object) >= 0;
        } else {
            return false;
        }
    }

    public boolean containsAll(final Collection<?> c) {
        for (final Object tmpObject : c) {
            if (!this.contains(tmpObject)) {
                return false;
            }
        }
        return true;
    }

    public long count() {
        return myActualCount;
    }

    public double doubleValue(final long index) {
        if (index >= myActualCount) {
            throw new ArrayIndexOutOfBoundsException();
        } else {
            return myStorage.doubleValue(index);
        }
    }

    public N get(final int index) {
        if (index >= myActualCount) {
            throw new ArrayIndexOutOfBoundsException();
        } else {
            return myStorage.get(index);
        }
    }

    public N get(final long index) {
        if (index >= myActualCount) {
            throw new ArrayIndexOutOfBoundsException();
        } else {
            return myStorage.get(index);
        }
    }

    public int indexOf(final Object object) {
        final ListIterator<N> tmpIterator = this.listIterator();
        if (object == null) {
            while (tmpIterator.hasNext()) {
                if (tmpIterator.next() == null) {
                    return tmpIterator.previousIndex();
                }
            }
        } else {
            while (tmpIterator.hasNext()) {
                if (object.equals(tmpIterator.next())) {
                    return tmpIterator.previousIndex();
                }
            }
        }
        return -1;
    }

    public boolean isEmpty() {
        return myActualCount == 0L;
    }

    public Iterator<N> iterator() {
        return Access1D.super.iterator();
    }

    public int lastIndexOf(final Object object) {
        final ListIterator<N> tmpIterator = this.listIterator(this.size());
        if (object == null) {
            while (tmpIterator.hasPrevious()) {
                if (tmpIterator.previous() == null) {
                    return tmpIterator.nextIndex();
                }
            }
        } else {
            while (tmpIterator.hasPrevious()) {
                if (object.equals(tmpIterator.previous())) {
                    return tmpIterator.nextIndex();
                }
            }
        }
        return -1;
    }

    public ListIterator<N> listIterator() {
        return new Iterator1D<>(this);
    }

    public ListIterator<N> listIterator(final int index) {
        return new Iterator1D<>(this, index);
    }

    public double mix(final long index, final BinaryFunction<N> mixer, final double addend) {
        ProgrammingError.throwIfNull(mixer);
        if (index >= myActualCount) {
            throw new ArrayIndexOutOfBoundsException();
        } else {
            synchronized (myStorage) {
                final double oldValue = myStorage.doubleValue(index);
                final double newValue = mixer.invoke(oldValue, addend);
                myStorage.set(index, newValue);
                return newValue;
            }
        }
    }

    public N mix(final long index, final BinaryFunction<N> mixer, final N addend) {
        ProgrammingError.throwIfNull(mixer);
        if (index >= myActualCount) {
            throw new ArrayIndexOutOfBoundsException();
        } else {
            synchronized (myStorage) {
                final N oldValue = myStorage.get(index);
                final N newValue = mixer.invoke(oldValue, addend);
                myStorage.set(index, newValue);
                return newValue;
            }
        }
    }

    public N remove(final int index) {
        ProgrammingError.throwForUnsupportedOptionalOperation();
        return null;
    }

    public boolean remove(final Object o) {
        ProgrammingError.throwForUnsupportedOptionalOperation();
        return false;
    }

    public boolean removeAll(final Collection<?> c) {
        ProgrammingError.throwForUnsupportedOptionalOperation();
        return false;
    }

    public boolean retainAll(final Collection<?> c) {
        ProgrammingError.throwForUnsupportedOptionalOperation();
        return false;
    }

    public N set(final int index, final N element) {
        ProgrammingError.throwForUnsupportedOptionalOperation();
        return null;
    }

    public void set(final long index, final double value) {
        if (index >= myActualCount) {
            throw new ArrayIndexOutOfBoundsException();
        } else {
            myStorage.set(index, value);
        }
    }

    public void set(final long index, final Number value) {
        if (index >= myActualCount) {
            throw new ArrayIndexOutOfBoundsException();
        } else {
            myStorage.set(index, value);
        }
    }

    public int size() {
        return (int) myActualCount;
    }

    public NumberList<N> subList(final int fromIndex, final int toIndex) {
        final NumberList<N> retVal = new NumberList<>(myStrategy);
        if (myStorage instanceof Primitive64Array) {
            for (int i = 0; i < toIndex; i++) {
                retVal.add(this.doubleValue(i));
            }
        } else {
            for (int i = 0; i < toIndex; i++) {
                retVal.add(this.get(i));
            }
        }
        return retVal;
    }

    public Object[] toArray() {
        return this.toArray(new Object[this.size()]);
    }

    @SuppressWarnings("unchecked")
    public <T> T[] toArray(final T[] array) {
        for (int i = 0; i < array.length; i++) {
            array[i] = (T) myStorage.get(i);
        }
        return array;
    }

    public void visitOne(final long index, final VoidFunction<N> visitor) {
        if (index >= myActualCount) {
            throw new ArrayIndexOutOfBoundsException();
        } else {
            myStorage.visitOne(index, visitor);
        }
    }

    private void ensureCapacity() {

        if (myStorage.count() > myActualCount) {
            // It fits, just add to the end

        } else if (myStrategy.isSegmented(myActualCount + 1L)) {
            // Doesn't fit, create or grow segment, then add

            if (myStorage instanceof SegmentedArray) {
                myStorage = ((SegmentedArray<N>) myStorage).grow();
            } else {
                myStorage = myStrategy.makeSegmented(myStorage);
            }
        } else {
            // Doesn't fit, grow, then add

            final long tmoNewTotalCount = myStrategy.grow(myActualCount);

            final BasicArray<N> tmpStorage = myStrategy.make(tmoNewTotalCount);
            tmpStorage.fillMatching(myStorage);
            myStorage = tmpStorage;
        }
    }

}
