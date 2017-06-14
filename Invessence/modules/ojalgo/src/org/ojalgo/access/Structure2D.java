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

/**
 * A (fixed size) 2-dimensional data structure.
 *
 * @author apete
 */
public interface Structure2D extends Structure1D {

    @FunctionalInterface
    public interface RowColumnCallback {

        /**
         * @param row Row
         * @param col Column
         */
        void call(final long row, final long col);

    }

    static int column(final int index, final int structure) {
        return index / structure;
    }

    static int column(final int index, final int[] structure) {
        return Structure2D.column(index, structure[0]);
    }

    static int column(final long index, final int structure) {
        return (int) (index / structure);
    }

    static long column(final long index, final long structure) {
        return index / structure;
    }

    static long column(final long index, final long[] structure) {
        return Structure2D.column(index, structure[0]);
    }

    static int index(final int structure, final int row, final int column) {
        return row + (column * structure);
    }

    static long index(final long structure, final long row, final long column) {
        return row + (column * structure);
    }

    static void loopMatching(final Structure2D structureA, final Structure2D structureB, final RowColumnCallback callback) {
        final long tmpCountRows = Math.min(structureA.countRows(), structureB.countRows());
        final long tmpCountColumns = Math.min(structureA.countColumns(), structureB.countColumns());
        for (long j = 0L; j < tmpCountColumns; j++) {
            for (long i = 0L; i < tmpCountRows; i++) {
                callback.call(i, j);
            }
        }
    }

    static int row(final int index, final int structure) {
        return index % structure;
    }

    static int row(final int index, final int[] structure) {
        return Structure2D.row(index, structure[0]);
    }

    static int row(final long index, final int structure) {
        return (int) (index % structure);
    }

    static long row(final long index, final long structure) {
        return index % structure;
    }

    static long row(final long index, final long[] structure) {
        return Structure2D.row(index, structure[0]);
    }

    /**
     * count() == countRows() * countColumns()
     */
    default long count() {
        return this.countRows() * this.countColumns();
    }

    /**
     * @return The number of columns
     */
    long countColumns();

    /**
     * @return The number of rows
     */
    long countRows();

    /**
     * 2D data structures are either square, tall, fat or empty.
     * <p>
     * m &lt;= 0 or n &lt;= 0
     * </p>
     * Historically some ojAlgo data structures did allow to create "empty" instances. Currently this is not
     * encouraged, but still possible in some instances.
     *
     * @return true if matrix is empty
     */
    default boolean isEmpty() {
        return ((this.countRows() <= 0L) || (this.countColumns() <= 0L));
    }

    /**
     * 2D data structures are either square, tall, fat or empty.
     * <p>
     * 1 &lt;= m &lt; n
     * </p>
     *
     * @return true if matrix is fat
     */
    default boolean isFat() {
        final long tmpCountRows = this.countRows();
        return ((tmpCountRows > 0L) && (tmpCountRows < this.countColumns()));
    }

    /**
     * @return true if both the row and column dimensions are equal to 1.
     */
    default boolean isScalar() {
        return (this.countRows() == 1L) && (this.countColumns() == 1L);
    }

    /**
     * 2D data structures are either square, tall, fat or empty.
     * <p>
     * m = n &lt;&gt; 0
     * </p>
     *
     * @return true if matrix is square
     */
    default boolean isSquare() {
        final long tmpCountRows = this.countRows();
        return ((tmpCountRows > 0L) && (tmpCountRows == this.countColumns()));
    }

    /**
     * 2D data structures are either square, tall, fat or empty.
     * <p>
     * m &lt; n &gt;= 1
     * </p>
     *
     * @return true if matrix is tall
     */
    default boolean isTall() {
        final long tmpCountColumns = this.countColumns();
        return ((tmpCountColumns > 0L) && (this.countRows() > tmpCountColumns));
    }

    /**
     * @return true if either the row or column dimensions are equal to 1.
     */
    default boolean isVector() {
        return ((this.countColumns() == 1L) || (this.countRows() == 1L));
    }

    default void loopAll(final RowColumnCallback callback) {
        final long tmpCountRows = this.countRows();
        final long tmpCountColumns = this.countColumns();
        for (long j = 0L; j < tmpCountColumns; j++) {
            for (long i = 0L; i < tmpCountRows; i++) {
                callback.call(i, j);
            }
        }
    }

    default void loopColumn(final long row, final long col, final RowColumnCallback callback) {
        final long tmpCountRows = this.countRows();
        for (long i = row; i < tmpCountRows; i++) {
            callback.call(i, col);
        }
    }

    default void loopColumn(final long col, final RowColumnCallback callback) {
        this.loopColumn(0L, col, callback);
    }

    default void loopDiagonal(final long row, final long col, final RowColumnCallback callback) {
        final long tmpLimit = Math.min(this.countRows() - row, this.countColumns() - col);
        for (long ij = 0L; ij < tmpLimit; ij++) {
            callback.call(row + ij, col + ij);
        }
    }

    default void loopRow(final long row, final long col, final RowColumnCallback callback) {
        final long tmpCountColumns = this.countColumns();
        for (long j = col; j < tmpCountColumns; j++) {
            callback.call(row, j);
        }
    }

    default void loopRow(final long row, final RowColumnCallback callback) {
        this.loopRow(row, 0L, callback);
    }

}
