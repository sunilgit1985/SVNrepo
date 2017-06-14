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
package org.ojalgo.access;

import java.math.BigDecimal;
import java.util.Iterator;

import org.ojalgo.function.VoidFunction;
import org.ojalgo.function.aggregator.Aggregator;
import org.ojalgo.scalar.ComplexNumber;
import org.ojalgo.scalar.Quaternion;
import org.ojalgo.scalar.RationalNumber;
import org.ojalgo.scalar.Scalar;
import org.ojalgo.type.TypeUtils;
import org.ojalgo.type.context.NumberContext;

/**
 * 2-dimensional accessor methods
 *
 * @see Access1D
 * @author apete
 */
public interface Access2D<N extends Number> extends Structure2D, Access1D<N> {

    public interface Aggregatable<N extends Number> extends Structure2D, Access1D.Aggregatable<N> {

        default N aggregateColumn(final long col, final Aggregator aggregator) {
            return this.aggregateColumn(0L, col, aggregator);
        }

        N aggregateColumn(long row, long col, Aggregator aggregator);

        N aggregateDiagonal(long row, long col, Aggregator aggregator);

        default N aggregateRow(final long row, final Aggregator aggregator) {
            return this.aggregateRow(row, 0L, aggregator);
        }

        N aggregateRow(long row, long col, Aggregator aggregator);

    }

    public interface Collectable<N extends Number, R extends Mutate2D.Receiver<N>> extends Structure2D {

        default <I extends R> I collect(final Factory2D<I> factory) {

            final I retVal = factory.makeZero(this.countRows(), this.countColumns());

            this.supplyTo(retVal);

            return retVal;
        }

        void supplyTo(R receiver);

    }

    public interface Elements extends Structure2D, Access1D.Elements {

        default boolean isAbsolute(final long index) {
            final long tmpStructure = this.countRows();
            return this.isAbsolute(Structure2D.row(index, tmpStructure), Structure2D.column(index, tmpStructure));
        }

        /**
         * @see Scalar#isAbsolute()
         */
        boolean isAbsolute(long row, long col);

        /**
         * @see Scalar#isSmall(double)
         */
        default boolean isColumnSmall(final long col, final double comparedTo) {
            return this.isColumnSmall(0L, col, comparedTo);
        }

        /**
         * @see Scalar#isSmall(double)
         */
        default boolean isColumnSmall(final long row, final long col, final double comparedTo) {
            boolean retVal = true;
            final long tmpLimit = this.countRows();
            for (long i = row; retVal && (i < tmpLimit); i++) {
                retVal &= this.isSmall(i, col, comparedTo);
            }
            return retVal;
        }

        /**
         * @see Scalar#isSmall(double)
         */
        default boolean isRowSmall(final long row, final double comparedTo) {
            return this.isRowSmall(row, 0L, comparedTo);
        }

        /**
         * @see Scalar#isSmall(double)
         */
        default boolean isRowSmall(final long row, final long col, final double comparedTo) {
            boolean retVal = true;
            final long tmpLimit = this.countColumns();
            for (long j = col; retVal && (j < tmpLimit); j++) {
                retVal &= this.isSmall(row, j, comparedTo);
            }
            return retVal;
        }

        default boolean isSmall(final long index, final double comparedTo) {
            final long tmpStructure = this.countRows();
            return this.isSmall(Structure2D.row(index, tmpStructure), Structure2D.column(index, tmpStructure), comparedTo);
        }

        /**
         * @see Scalar#isSmall(double)
         */
        boolean isSmall(long row, long col, double comparedTo);

    }

    public static final class ElementView<N extends Number> implements ElementView2D<N, ElementView<N>> {

        private final ElementView1D<N, ?> myDelegate;
        private final long myStructure;

        public ElementView(final ElementView1D<N, ?> delegate, final long structure) {

            super();

            myDelegate = delegate;
            myStructure = structure;
        }

        public long column() {
            return Structure2D.column(myDelegate.index(), myStructure);
        }

        public double doubleValue() {
            return myDelegate.doubleValue();
        }

        public N getNumber() {
            return myDelegate.getNumber();
        }

        public boolean hasNext() {
            return myDelegate.hasNext();
        }

        public boolean hasPrevious() {
            return myDelegate.hasPrevious();
        }

        public long index() {
            return myDelegate.index();
        }

        public Iterator<ElementView<N>> iterator() {
            return this;
        }

        public ElementView<N> next() {
            myDelegate.next();
            return this;
        }

        public ElementView<N> previous() {
            myDelegate.previous();
            return this;
        }

        public long row() {
            return Structure2D.row(myDelegate.index(), myStructure);
        }

    }

    public interface IndexOf extends Structure2D, Access1D.IndexOf {

        default long indexOfLargestInColumn(final long col) {
            return this.indexOfLargestInColumn(0L, col);
        }

        /**
         * @param row First row to investigate
         * @param col The column
         * @return The row-index of the largest absolute value in a column, starting at the specified row.
         */
        long indexOfLargestInColumn(final long row, final long col);

        default long indexOfLargestInRow(final long row) {
            return this.indexOfLargestInRow(row, 0L);
        }

        /**
         * @param row The row
         * @param col The first column to investigate
         * @return The column-index of the largest absolute value in a row, starting at the specified column.
         */
        long indexOfLargestInRow(final long row, final long col);

        default long indexOfLargestOnDiagonal() {
            return this.indexOfLargestOnDiagonal(0L);
        }

        /**
         * @param first The first row/column to investigate
         * @return The row/column-index of the largest absolute value on the main diagonal, starting at the
         *         specified row/column.
         */
        long indexOfLargestOnDiagonal(final long first);

    }

    public interface Sliceable<N extends Number> extends Structure2D, Access1D.Sliceable<N> {

        default Access1D<N> sliceColumn(final long col) {
            return this.sliceColumn(0L, col);
        }

        Access1D<N> sliceColumn(long row, long col);

        Access1D<N> sliceDiagonal(long row, long col);

        default Access1D<N> sliceRow(final long row) {
            return this.sliceRow(row, 0L);
        }

        Access1D<N> sliceRow(long row, long col);

    }

    public interface Visitable<N extends Number> extends Structure2D, Access1D.Visitable<N> {

        default void visitColumn(final long row, final long col, final VoidFunction<N> visitor) {
            this.loopColumn(row, col, (r, c) -> this.visitOne(r, c, visitor));
        }

        default void visitColumn(final long col, final VoidFunction<N> visitor) {
            this.visitColumn(0L, col, visitor);
        }

        default void visitDiagonal(final long row, final long col, final VoidFunction<N> visitor) {
            this.loopDiagonal(row, col, (r, c) -> this.visitOne(r, c, visitor));
        }

        void visitOne(long row, long col, VoidFunction<N> visitor);

        default void visitOne(final long index, final VoidFunction<N> visitor) {
            final long tmpStructure = this.countRows();
            this.visitOne(Structure2D.row(index, tmpStructure), Structure2D.column(index, tmpStructure), visitor);
        }

        default void visitRow(final long row, final long col, final VoidFunction<N> visitor) {
            this.loopRow(row, col, (r, c) -> this.visitOne(r, c, visitor));
        }

        default void visitRow(final long row, final VoidFunction<N> visitor) {
            this.visitRow(row, 0L, visitor);
        }

    }

    static Access2D<BigDecimal> asBig2D(final Access2D<?> access) {
        return new Access2D<BigDecimal>() {

            public long count() {
                return access.count();
            }

            public long countColumns() {
                return access.countColumns();
            }

            public long countRows() {
                return access.countRows();
            }

            public double doubleValue(final long index) {
                return access.doubleValue(index);
            }

            public double doubleValue(final long row, final long col) {
                return access.doubleValue(row, col);
            }

            public BigDecimal get(final long index) {
                return TypeUtils.toBigDecimal(access.get(index));
            }

            public BigDecimal get(final long row, final long col) {
                return TypeUtils.toBigDecimal(access.get(row, col));
            }

        };
    }

    static Access2D<ComplexNumber> asComplex2D(final Access2D<?> access) {
        return new Access2D<ComplexNumber>() {

            public long count() {
                return access.count();
            }

            public long countColumns() {
                return access.countColumns();
            }

            public long countRows() {
                return access.countRows();
            }

            public double doubleValue(final long index) {
                return access.doubleValue(index);
            }

            public double doubleValue(final long row, final long col) {
                return access.doubleValue(row, col);
            }

            public ComplexNumber get(final long index) {
                return ComplexNumber.valueOf(access.get(index));
            }

            public ComplexNumber get(final long row, final long col) {
                return ComplexNumber.valueOf(access.get(row, col));
            }

        };
    }

    static Access2D<Double> asPrimitive2D(final Access2D<?> access) {
        return new Access2D<Double>() {

            public long count() {
                return access.count();
            }

            public long countColumns() {
                return access.countColumns();
            }

            public long countRows() {
                return access.countRows();
            }

            public double doubleValue(final long index) {
                return access.doubleValue(index);
            }

            public double doubleValue(final long row, final long col) {
                return access.doubleValue(row, col);
            }

            public Double get(final long index) {
                return access.doubleValue(index);
            }

            public Double get(final long row, final long col) {
                return access.doubleValue(row, col);
            }

        };
    }

    static Access2D<Quaternion> asQuaternion2D(final Access2D<?> access) {
        return new Access2D<Quaternion>() {

            public long count() {
                return access.count();
            }

            public long countColumns() {
                return access.countColumns();
            }

            public long countRows() {
                return access.countRows();
            }

            public double doubleValue(final long index) {
                return access.doubleValue(index);
            }

            public double doubleValue(final long row, final long col) {
                return access.doubleValue(row, col);
            }

            public Quaternion get(final long index) {
                return Quaternion.valueOf(access.get(index));
            }

            public Quaternion get(final long row, final long col) {
                return Quaternion.valueOf(access.get(row, col));
            }

        };
    }

    static Access2D<RationalNumber> asRational2D(final Access2D<?> access) {
        return new Access2D<RationalNumber>() {

            public long count() {
                return access.count();
            }

            public long countColumns() {
                return access.countColumns();
            }

            public long countRows() {
                return access.countRows();
            }

            public double doubleValue(final long index) {
                return access.doubleValue(index);
            }

            public double doubleValue(final long row, final long col) {
                return access.doubleValue(row, col);
            }

            public RationalNumber get(final long index) {
                return RationalNumber.valueOf(access.get(index));
            }

            public RationalNumber get(final long row, final long col) {
                return RationalNumber.valueOf(access.get(row, col));
            }

        };
    }

    static boolean equals(final Access2D<?> accessA, final Access2D<?> accessB, final NumberContext context) {
        return (accessA.countRows() == accessB.countRows()) && (accessA.countColumns() == accessB.countColumns()) && Access1D.equals(accessA, accessB, context);
    }

    static Access2D<Double> wrapAccess2D(final double[][] target) {
        return new Access2D<Double>() {

            public long count() {
                return target.length * target[0].length;
            }

            public long countColumns() {
                return target[0].length;
            }

            public long countRows() {
                return target.length;
            }

            public double doubleValue(final long row, final long col) {
                return target[(int) row][(int) col];
            }

            public Double get(final long row, final long col) {
                return target[(int) row][(int) col];
            }

        };
    }

    static <N extends Number> Access2D<N> wrapAccess2D(final N[][] target) {
        return new Access2D<N>() {

            public long count() {
                return target.length * target[0].length;
            }

            public long countColumns() {
                return target[0].length;
            }

            public long countRows() {
                return target.length;
            }

            public double doubleValue(final long index) {
                return this.get(index).doubleValue();
            }

            public double doubleValue(final long row, final long col) {
                return this.get(row, col).doubleValue();
            }

            public N get(final long row, final long col) {
                return target[(int) row][(int) col];
            }

        };
    }

    default <NN extends Number, R extends Mutate2D.Receiver<NN>> Collectable<NN, R> asCollectable2D() {
        return new Collectable<NN, R>() {

            public long countColumns() {
                return Access2D.this.countColumns();
            }

            public long countRows() {
                return Access2D.this.countRows();
            }

            public void supplyTo(final R receiver) {
                receiver.accept(Access2D.this);
            }

        };
    }

    default Iterable<ColumnView<N>> columns() {
        return ColumnView.makeIterable(this);
    }

    default double doubleValue(final long index) {
        final long tmpStructure = this.countRows();
        return this.doubleValue(Structure2D.row(index, tmpStructure), Structure2D.column(index, tmpStructure));
    }

    /**
     * Extracts one element of this matrix as a double.
     *
     * @param row A row index.
     * @param col A column index.
     * @return One matrix element
     */
    double doubleValue(long row, long col);

    default ElementView2D<N, ?> elements() {
        return new Access2D.ElementView<>(Access1D.super.elements(), this.countRows());
    }

    default N get(final long index) {
        final long tmpStructure = this.countRows();
        return this.get(Structure2D.row(index, tmpStructure), Structure2D.column(index, tmpStructure));
    }

    N get(long row, long col);

    default Iterable<RowView<N>> rows() {
        return RowView.makeIterable(this);
    }

    default double[][] toRawCopy2D() {

        final int tmpRowDim = (int) this.countRows();
        final int tmpColDim = (int) this.countColumns();

        final double[][] retVal = new double[tmpRowDim][tmpColDim];

        double[] tmpRow;
        for (int i = 0; i < tmpRowDim; i++) {
            tmpRow = retVal[i];
            for (int j = 0; j < tmpColDim; j++) {
                tmpRow[j] = this.doubleValue(i, j);
            }
        }

        return retVal;
    }

}
