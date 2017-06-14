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
package org.ojalgo.matrix;

import java.math.BigDecimal;

import org.ojalgo.access.Access1D;
import org.ojalgo.access.Access2D;
import org.ojalgo.array.blas.AXPY;
import org.ojalgo.constant.PrimitiveMath;
import org.ojalgo.function.FunctionUtils;
import org.ojalgo.matrix.decomposition.*;
import org.ojalgo.matrix.store.ComplexDenseStore;
import org.ojalgo.matrix.store.ElementsConsumer;
import org.ojalgo.matrix.store.MatrixStore;
import org.ojalgo.matrix.store.PhysicalStore;
import org.ojalgo.matrix.store.PrimitiveDenseStore;
import org.ojalgo.matrix.store.operation.*;
import org.ojalgo.random.Uniform;
import org.ojalgo.scalar.ComplexNumber;
import org.ojalgo.scalar.PrimitiveScalar;
import org.ojalgo.type.TypeUtils;
import org.ojalgo.type.context.NumberContext;

public abstract class MatrixUtils {

    public static void copy(final Access2D<?> source, final int rows, final int columns, final double[][] destination) {
        for (int i = 0; i < rows; i++) {
            final double[] tmpRow = destination[i];
            for (int j = 0; j < columns; j++) {
                tmpRow[j] = source.doubleValue(i, j);
            }
        }
    }

    /**
     * Copies the argument of the ComplexNumber elements to the destination.
     */
    public static void copyComplexArgument(final Access2D<ComplexNumber> source, final ElementsConsumer<?> destination) {
        final long tmpCount = FunctionUtils.min(source.count(), destination.count());
        for (long i = 0L; i < tmpCount; i++) {
            destination.set(i, source.get(i).getArgument());
        }
    }

    /**
     * Copies the imaginary part of the ComplexNumber elements to the destination.
     */
    public static void copyComplexImaginary(final Access2D<ComplexNumber> source, final ElementsConsumer<?> destination) {
        final long tmpCount = FunctionUtils.min(source.count(), destination.count());
        for (long i = 0L; i < tmpCount; i++) {
            destination.set(i, source.get(i).getImaginary());
        }
    }

    /**
     * Copies the modulus of the ComplexNumber elements to the destination.
     */
    public static void copyComplexModulus(final Access2D<ComplexNumber> source, final ElementsConsumer<?> destination) {
        final long tmpCount = FunctionUtils.min(source.count(), destination.count());
        for (long i = 0L; i < tmpCount; i++) {
            destination.set(i, source.get(i).getModulus());
        }
    }

    /**
     * Simultaneously copies the modulus and argument of the ComplexNumber elements to the destinations.
     */
    public static void copyComplexModulusAndArgument(final Access2D<ComplexNumber> source, final ElementsConsumer<?> modDest,
            final ElementsConsumer<?> argDest) {
        final long tmpCount = FunctionUtils.min(source.count(), modDest.count(), argDest.count());
        ComplexNumber tmpComplexNumber;
        for (long i = 0L; i < tmpCount; i++) {
            tmpComplexNumber = source.get(i);
            modDest.set(i, tmpComplexNumber.getModulus());
            argDest.set(i, tmpComplexNumber.getArgument());
        }
    }

    /**
     * Copies the real part of the ComplexNumber elements to the destination.
     */
    public static void copyComplexReal(final Access2D<ComplexNumber> source, final ElementsConsumer<?> destination) {
        final long tmpCount = FunctionUtils.min(source.count(), destination.count());
        for (long i = 0L; i < tmpCount; i++) {
            destination.set(i, source.get(i).getReal());
        }
    }

    /**
     * Simultaneously copies the real and imaginary parts of the ComplexNumber elements to the destinations.
     */
    public static void copyComplexRealAndImaginary(final Access2D<ComplexNumber> source, final ElementsConsumer<?> realDest,
            final ElementsConsumer<?> imagDest) {
        final long tmpCount = FunctionUtils.min(source.count(), realDest.count(), imagDest.count());
        ComplexNumber tmpComplexNumber;
        for (long i = 0L; i < tmpCount; i++) {
            tmpComplexNumber = source.get(i);
            realDest.set(i, tmpComplexNumber.getReal());
            imagDest.set(i, tmpComplexNumber.getImaginary());
        }
    }

    /**
     * @deprecated v43 Use {@link Bidiagonal#equals(MatrixStore,Bidiagonal,NumberContext)} instead
     */
    @Deprecated
    public static <N extends Number> boolean equals(final MatrixStore<N> matrix, final Bidiagonal<N> decomposition, final NumberContext context) {
        return Bidiagonal.equals(matrix, decomposition, context);
    }

    /**
     * @deprecated v43 Use {@link Cholesky#equals(MatrixStore,Cholesky,NumberContext)} instead
     */
    @Deprecated
    public static <N extends Number> boolean equals(final MatrixStore<N> matrix, final Cholesky<N> decomposition, final NumberContext context) {
        return Cholesky.equals(matrix, decomposition, context);
    }

    /**
     * @deprecated v43 Use {@link Eigenvalue#equals(MatrixStore,Eigenvalue,NumberContext)} instead
     */
    @Deprecated
    public static <N extends Number> boolean equals(final MatrixStore<N> matrix, final Eigenvalue<N> decomposition, final NumberContext context) {
        return Eigenvalue.equals(matrix, decomposition, context);
    }

    /**
     * @deprecated v43 Use {@link Hessenberg#equals(MatrixStore,Hessenberg,NumberContext)} instead
     */
    @Deprecated
    public static <N extends Number> boolean equals(final MatrixStore<N> matrix, final Hessenberg<N> decomposition, final NumberContext context) {
        return Hessenberg.equals(matrix, decomposition, context);
    }

    /**
     * @deprecated v43 Use {@link LDL#equals(MatrixStore,LDL,NumberContext)} instead
     */
    @Deprecated
    public static <N extends Number> boolean equals(final MatrixStore<N> matrix, final LDL<N> decomposition, final NumberContext context) {
        return LDL.equals(matrix, decomposition, context);
    }

    /**
     * @deprecated v43 Use {@link LU#equals(MatrixStore,LU,NumberContext)} instead
     */
    @Deprecated
    public static <N extends Number> boolean equals(final MatrixStore<N> matrix, final LU<N> decomposition, final NumberContext context) {
        return LU.equals(matrix, decomposition, context);
    }

    /**
     * @deprecated v43 Use {@link QR#equals(MatrixStore,QR,NumberContext)} instead
     */
    @Deprecated
    public static <N extends Number> boolean equals(final MatrixStore<N> matrix, final QR<N> decomposition, final NumberContext context) {
        return QR.equals(matrix, decomposition, context);
    }

    /**
     * @deprecated v43 Use {@link Schur#equals(MatrixStore,Schur,NumberContext)} instead
     */
    @Deprecated
    public static <N extends Number> boolean equals(final MatrixStore<N> matrix, final Schur<N> decomposition, final NumberContext context) {
        return Schur.equals(matrix, decomposition, context);
    }

    /**
     * @deprecated v43 Use {@link SingularValue#equals(MatrixStore,SingularValue,NumberContext)} instead
     */
    @Deprecated
    public static <N extends Number> boolean equals(final MatrixStore<N> matrix, final SingularValue<N> decomposition, final NumberContext context) {
        return SingularValue.equals(matrix, decomposition, context);
    }

    /**
     * @deprecated v43 Use {@link Tridiagonal#equals(MatrixStore,Tridiagonal,NumberContext)} instead
     */
    @Deprecated
    public static <N extends Number> boolean equals(final MatrixStore<N> matrix, final Tridiagonal<N> decomposition, final NumberContext context) {
        return Tridiagonal.equals(matrix, decomposition, context);
    }

    public static final int firstInColumn(final Access1D<?> matrix, final int col, final int defaultAndMinimum) {
        return matrix instanceof MatrixStore<?> ? Math.max(((MatrixStore<?>) matrix).firstInColumn(col), defaultAndMinimum) : defaultAndMinimum;
    }

    public static final long firstInColumn(final Access1D<?> matrix, final long col, final long defaultAndMinimum) {
        return matrix instanceof MatrixStore<?> ? Math.max(((MatrixStore<?>) matrix).firstInColumn((int) col), defaultAndMinimum) : defaultAndMinimum;
    }

    public static final int firstInRow(final Access1D<?> matrix, final int row, final int defaultAndMinimum) {
        return matrix instanceof MatrixStore<?> ? Math.max(((MatrixStore<?>) matrix).firstInRow(row), defaultAndMinimum) : defaultAndMinimum;
    }

    public static final long firstInRow(final Access1D<?> matrix, final long row, final long defaultAndMinimum) {
        return matrix instanceof MatrixStore<?> ? Math.max(((MatrixStore<?>) matrix).firstInRow((int) row), defaultAndMinimum) : defaultAndMinimum;
    }

    /**
     * Extracts the argument of the ComplexNumber elements to a new primitive double valued matrix.
     */
    public static PrimitiveDenseStore getComplexArgument(final Access2D<ComplexNumber> arg) {

        final long tmpRows = arg.countRows();
        final long tmpColumns = arg.countColumns();

        final PrimitiveDenseStore retVal = PrimitiveDenseStore.FACTORY.makeZero(tmpRows, tmpColumns);

        MatrixUtils.copyComplexArgument(arg, retVal);

        return retVal;
    }

    /**
     * Extracts the imaginary part of the ComplexNumber elements to a new primitive double valued matrix.
     */
    public static PrimitiveDenseStore getComplexImaginary(final Access2D<ComplexNumber> arg) {

        final long tmpRows = arg.countRows();
        final long tmpColumns = arg.countColumns();

        final PrimitiveDenseStore retVal = PrimitiveDenseStore.FACTORY.makeZero(tmpRows, tmpColumns);

        MatrixUtils.copyComplexImaginary(arg, retVal);

        return retVal;
    }

    /**
     * Extracts the modulus of the ComplexNumber elements to a new primitive double valued matrix.
     */
    public static PrimitiveDenseStore getComplexModulus(final Access2D<ComplexNumber> arg) {

        final long tmpRows = arg.countRows();
        final long tmpColumns = arg.countColumns();

        final PrimitiveDenseStore retVal = PrimitiveDenseStore.FACTORY.makeZero(tmpRows, tmpColumns);

        MatrixUtils.copyComplexModulus(arg, retVal);

        return retVal;
    }

    /**
     * Extracts the real part of the ComplexNumber elements to a new primitive double valued matrix.
     */
    public static PrimitiveDenseStore getComplexReal(final Access2D<ComplexNumber> arg) {

        final long tmpRows = arg.countRows();
        final long tmpColumns = arg.countColumns();

        final PrimitiveDenseStore retVal = PrimitiveDenseStore.FACTORY.makeZero(tmpRows, tmpColumns);

        MatrixUtils.copyComplexReal(arg, retVal);

        return retVal;
    }

    public static <N extends Number> int hashCode(final BasicMatrix matrix) {
        return Access1D.hashCode(matrix);
    }

    public static <N extends Number> int hashCode(final MatrixStore<N> matrix) {
        return Access1D.hashCode(matrix);
    }

    public static boolean isHermitian(final Access2D<?> matrix) {

        final long tmpRowDim = matrix.countRows();
        final long tmpColDim = matrix.countColumns();

        final Number tmpElement = matrix.get(0L);

        boolean retVal = tmpRowDim == tmpColDim;

        if (tmpElement instanceof ComplexNumber) {

            ComplexNumber tmpLowerLeft;
            ComplexNumber tmpUpperRight;

            for (int j = 0; retVal && (j < tmpColDim); j++) {
                retVal &= PrimitiveScalar.isSmall(PrimitiveMath.ONE, ComplexNumber.valueOf(matrix.get(j, j)).i);
                for (int i = j + 1; retVal && (i < tmpRowDim); i++) {
                    tmpLowerLeft = ComplexNumber.valueOf(matrix.get(i, j)).conjugate();
                    tmpUpperRight = ComplexNumber.valueOf(matrix.get(j, i));
                    retVal &= PrimitiveScalar.isSmall(PrimitiveMath.ONE, tmpLowerLeft.subtract(tmpUpperRight).norm());
                }
            }

        } else {

            for (int j = 0; retVal && (j < tmpColDim); j++) {
                for (int i = j + 1; retVal && (i < tmpRowDim); i++) {
                    retVal &= PrimitiveScalar.isSmall(PrimitiveMath.ONE, matrix.doubleValue(i, j) - matrix.doubleValue(j, i));
                }
            }
        }

        return retVal;
    }

    public static <N extends Number> boolean isNormal(final MatrixStore<N> matrix) {

        final MatrixStore<N> tmpConjugate = matrix.conjugate();

        return tmpConjugate.multiply(matrix).equals(matrix.multiply(tmpConjugate));
    }

    public static final int limitOfColumn(final Access1D<?> matrix, final int col, final int defaultAndMaximum) {
        return matrix instanceof MatrixStore<?> ? Math.min(((MatrixStore<?>) matrix).limitOfColumn(col), defaultAndMaximum) : defaultAndMaximum;
    }

    public static final long limitOfColumn(final Access1D<?> matrix, final long col, final long defaultAndMaximum) {
        return matrix instanceof MatrixStore<?> ? Math.min(((MatrixStore<?>) matrix).limitOfColumn((int) col), defaultAndMaximum) : defaultAndMaximum;
    }

    public static final int limitOfRow(final Access1D<?> matrix, final int row, final int defaultAndMaximum) {
        return matrix instanceof MatrixStore<?> ? Math.min(((MatrixStore<?>) matrix).limitOfRow(row), defaultAndMaximum) : defaultAndMaximum;
    }

    public static final long limitOfRow(final Access1D<?> matrix, final long row, final long defaultAndMaximum) {
        return matrix instanceof MatrixStore<?> ? Math.min(((MatrixStore<?>) matrix).limitOfRow((int) row), defaultAndMaximum) : defaultAndMaximum;
    }

    public static PhysicalStore<ComplexNumber> makeRandomComplexStore(final int aRowDim, final int aColDim) {

        final PhysicalStore<ComplexNumber> retVal = ComplexDenseStore.FACTORY.makeZero(aRowDim, aColDim);

        final Uniform tmpArgGen = new Uniform(PrimitiveMath.ZERO, PrimitiveMath.TWO_PI);

        for (int j = 0; j < aColDim; j++) {
            for (int i = 0; i < aRowDim; i++) {
                retVal.set(i, j, ComplexNumber.makePolar(PrimitiveMath.E, tmpArgGen.doubleValue()).add(PrimitiveMath.PI));
            }
        }

        return retVal;
    }

    /**
     * Make a random symmetric positive definite matrix
     */
    public static PrimitiveDenseStore makeSPD(final int dim) {

        final double[] tmpRandom = new double[dim];

        final PrimitiveDenseStore retVal = PrimitiveDenseStore.FACTORY.makeZero(dim, dim);

        for (int i = 0; i < dim; i++) {

            tmpRandom[i] = Math.random();

            for (int j = 0; j < i; j++) {
                retVal.set(i, j, tmpRandom[i] * tmpRandom[j]);
                retVal.set(j, i, tmpRandom[j] * tmpRandom[i]);
            }
            retVal.set(i, i, tmpRandom[i] + 1.0);
        }

        return retVal;
    }

    /**
     * @deprecated v43 Use {@link Bidiagonal#reconstruct(Bidiagonal)} instead
     */
    @Deprecated
    public static <N extends Number> MatrixStore<N> reconstruct(final Bidiagonal<N> decomposition) {
        return Bidiagonal.reconstruct(decomposition);
    }

    /**
     * @deprecated v43 Use {@link Cholesky#reconstruct(Cholesky)} instead
     */
    @Deprecated
    public static <N extends Number> MatrixStore<N> reconstruct(final Cholesky<N> decomposition) {
        return Cholesky.reconstruct(decomposition);
    }

    /**
     * @deprecated v43 Use {@link Eigenvalue#reconstruct(Eigenvalue)} instead
     */
    @Deprecated
    public static <N extends Number> MatrixStore<N> reconstruct(final Eigenvalue<N> decomposition) {
        return Eigenvalue.reconstruct(decomposition);
    }

    /**
     * @deprecated v43 Use {@link Hessenberg#reconstruct(Hessenberg)} instead
     */
    @Deprecated
    public static <N extends Number> MatrixStore<N> reconstruct(final Hessenberg<N> decomposition) {
        return Hessenberg.reconstruct(decomposition);
    }

    /**
     * @deprecated v43 Use {@link LDL#reconstruct(LDL)} instead
     */
    @Deprecated
    public static <N extends Number> MatrixStore<N> reconstruct(final LDL<N> decomposition) {
        return LDL.reconstruct(decomposition);
    }

    /**
     * @deprecated v43 Use {@link LU#reconstruct(LU)} instead
     */
    @Deprecated
    public static <N extends Number> MatrixStore<N> reconstruct(final LU<N> decomposition) {
        return LU.reconstruct(decomposition);
    }

    /**
     * @deprecated v43 Use {@link QR#reconstruct(QR)} instead
     */
    @Deprecated
    public static <N extends Number> MatrixStore<N> reconstruct(final QR<N> decomposition) {
        return QR.reconstruct(decomposition);
    }

    /**
     * @deprecated v43 Use {@link Schur#reconstruct(Schur)} instead
     */
    @Deprecated
    public static <N extends Number> MatrixStore<N> reconstruct(final Schur<N> decomposition) {
        return Schur.reconstruct(decomposition);
    }

    /**
     * @deprecated v43 Use {@link SingularValue#reconstruct(SingularValue)} instead
     */
    @Deprecated
    public static <N extends Number> MatrixStore<N> reconstruct(final SingularValue<N> decomposition) {
        return SingularValue.reconstruct(decomposition);
    }

    /**
     * @deprecated v43 Use {@link Tridiagonal#reconstruct(Tridiagonal)} instead
     */
    @Deprecated
    public static <N extends Number> MatrixStore<N> reconstruct(final Tridiagonal<N> decomposition) {
        return Tridiagonal.reconstruct(decomposition);
    }

    public static void setAllOperationThresholds(final int value) {
        MatrixUtils.setThresholdsMaxValue(value);
        MatrixUtils.setThresholdsMinValue(value);
    }

    /**
     * @param maxValue The max allowed/required value
     */
    public static void setThresholdsMaxValue(final int maxValue) {
        AggregateAll.THRESHOLD = Math.min(maxValue, AggregateAll.THRESHOLD);
        ApplyCholesky.THRESHOLD = Math.min(maxValue, ApplyCholesky.THRESHOLD);
        ApplyLU.THRESHOLD = Math.min(maxValue, ApplyLU.THRESHOLD);
        FillMatchingBoth.THRESHOLD = Math.min(maxValue, FillMatchingBoth.THRESHOLD);
        FillConjugated.THRESHOLD = Math.min(maxValue, FillConjugated.THRESHOLD);
        FillMatchingLeft.THRESHOLD = Math.min(maxValue, FillMatchingLeft.THRESHOLD);
        FillMatchingRight.THRESHOLD = Math.min(maxValue, FillMatchingRight.THRESHOLD);
        FillMatchingSingle.THRESHOLD = Math.min(maxValue, FillMatchingSingle.THRESHOLD);
        FillTransposed.THRESHOLD = Math.min(maxValue, FillTransposed.THRESHOLD);
        GenerateApplyAndCopyHouseholderColumn.THRESHOLD = Math.min(maxValue, GenerateApplyAndCopyHouseholderColumn.THRESHOLD);
        GenerateApplyAndCopyHouseholderRow.THRESHOLD = Math.min(maxValue, GenerateApplyAndCopyHouseholderRow.THRESHOLD);
        HermitianRank2Update.THRESHOLD = Math.min(maxValue, HermitianRank2Update.THRESHOLD);
        HouseholderLeft.THRESHOLD = Math.min(maxValue, HouseholderLeft.THRESHOLD);
        HouseholderRight.THRESHOLD = Math.min(maxValue, HouseholderRight.THRESHOLD);
        AXPY.THRESHOLD = Math.min(maxValue, AXPY.THRESHOLD);
        ModifyAll.THRESHOLD = Math.min(maxValue, ModifyAll.THRESHOLD);
        MultiplyBoth.THRESHOLD = Math.min(maxValue, MultiplyBoth.THRESHOLD);
        MultiplyHermitianAndVector.THRESHOLD = Math.min(maxValue, MultiplyHermitianAndVector.THRESHOLD);
        MultiplyLeft.THRESHOLD = Math.min(maxValue, MultiplyLeft.THRESHOLD);
        MultiplyRight.THRESHOLD = Math.min(maxValue, MultiplyRight.THRESHOLD);
        RotateLeft.THRESHOLD = Math.min(maxValue, RotateLeft.THRESHOLD);
        RotateRight.THRESHOLD = Math.min(maxValue, RotateRight.THRESHOLD);
        SubstituteBackwards.THRESHOLD = Math.min(maxValue, SubstituteBackwards.THRESHOLD);
        SubstituteForwards.THRESHOLD = Math.min(maxValue, SubstituteForwards.THRESHOLD);
    }

    /**
     * @param minValue The min allowed/required value
     */
    public static void setThresholdsMinValue(final int minValue) {
        AggregateAll.THRESHOLD = Math.max(minValue, AggregateAll.THRESHOLD);
        ApplyCholesky.THRESHOLD = Math.max(minValue, ApplyCholesky.THRESHOLD);
        ApplyLU.THRESHOLD = Math.max(minValue, ApplyLU.THRESHOLD);
        FillMatchingBoth.THRESHOLD = Math.max(minValue, FillMatchingBoth.THRESHOLD);
        FillConjugated.THRESHOLD = Math.max(minValue, FillConjugated.THRESHOLD);
        FillMatchingLeft.THRESHOLD = Math.max(minValue, FillMatchingLeft.THRESHOLD);
        FillMatchingRight.THRESHOLD = Math.max(minValue, FillMatchingRight.THRESHOLD);
        FillMatchingSingle.THRESHOLD = Math.max(minValue, FillMatchingSingle.THRESHOLD);
        FillTransposed.THRESHOLD = Math.max(minValue, FillTransposed.THRESHOLD);
        GenerateApplyAndCopyHouseholderColumn.THRESHOLD = Math.max(minValue, GenerateApplyAndCopyHouseholderColumn.THRESHOLD);
        GenerateApplyAndCopyHouseholderRow.THRESHOLD = Math.max(minValue, GenerateApplyAndCopyHouseholderRow.THRESHOLD);
        HermitianRank2Update.THRESHOLD = Math.max(minValue, HermitianRank2Update.THRESHOLD);
        HouseholderLeft.THRESHOLD = Math.max(minValue, HouseholderLeft.THRESHOLD);
        HouseholderRight.THRESHOLD = Math.max(minValue, HouseholderRight.THRESHOLD);
        AXPY.THRESHOLD = Math.max(minValue, AXPY.THRESHOLD);
        ModifyAll.THRESHOLD = Math.max(minValue, ModifyAll.THRESHOLD);
        MultiplyBoth.THRESHOLD = Math.max(minValue, MultiplyBoth.THRESHOLD);
        MultiplyHermitianAndVector.THRESHOLD = Math.max(minValue, MultiplyHermitianAndVector.THRESHOLD);
        MultiplyLeft.THRESHOLD = Math.max(minValue, MultiplyLeft.THRESHOLD);
        MultiplyRight.THRESHOLD = Math.max(minValue, MultiplyRight.THRESHOLD);
        RotateLeft.THRESHOLD = Math.max(minValue, RotateLeft.THRESHOLD);
        RotateRight.THRESHOLD = Math.max(minValue, RotateRight.THRESHOLD);
        SubstituteBackwards.THRESHOLD = Math.max(minValue, SubstituteBackwards.THRESHOLD);
        SubstituteForwards.THRESHOLD = Math.max(minValue, SubstituteForwards.THRESHOLD);
    }

    public static String toString(final Access2D<?> matrix) {

        final StringBuilder retVal = new StringBuilder();

        final int tmpRowDim = (int) matrix.countRows();
        final int tmpColDim = (int) matrix.countColumns();

        retVal.append(matrix.getClass().getName());
        retVal.append(' ').append('<').append(' ').append(tmpRowDim).append(' ').append('x').append(' ').append(tmpColDim).append(' ').append('>');

        if ((tmpRowDim > 0) && (tmpColDim > 0) && (tmpRowDim <= 50) && (tmpColDim <= 50) && ((tmpRowDim * tmpColDim) <= 200)) {

            // First element
            retVal.append("\n{ { ").append(matrix.get(0, 0));

            // Rest of the first row
            for (int j = 1; j < tmpColDim; j++) {
                retVal.append(",\t").append(matrix.get(0, j));
            }

            // For each of the remaining rows
            for (int i = 1; i < tmpRowDim; i++) {

                // First column
                retVal.append(" },\n{ ").append(matrix.get(i, 0));

                // Remaining columns
                for (int j = 1; j < tmpColDim; j++) {
                    retVal.append(",\t").append(matrix.get(i, j));
                }
            }

            // Finish
            retVal.append(" } }");
        }

        return retVal.toString();
    }

    public static Access2D<BigDecimal> wrapBigAccess2D(final BasicMatrix matrix) {
        return new Access2D<BigDecimal>() {

            public long count() {
                return this.size();
            }

            public long countColumns() {
                return matrix.countColumns();
            }

            public long countRows() {
                return matrix.countRows();
            }

            public double doubleValue(final long index) {
                return matrix.doubleValue(index);
            }

            public double doubleValue(final long row, final long col) {
                return matrix.doubleValue(row, col);
            }

            public BigDecimal get(final long row, final long col) {
                return TypeUtils.toBigDecimal(matrix.get((int) row, (int) col));
            }

            public int size() {
                return (int) matrix.count();
            }

        };
    }

    public static Access2D<ComplexNumber> wrapComplexAccess2D(final BasicMatrix matrix) {
        return new Access2D<ComplexNumber>() {

            public long count() {
                return this.size();
            }

            public long countColumns() {
                return matrix.countColumns();
            }

            public long countRows() {
                return matrix.countRows();
            }

            public double doubleValue(final long index) {
                return matrix.doubleValue(index);
            }

            public double doubleValue(final long row, final long col) {
                return matrix.doubleValue(row, col);
            }

            public ComplexNumber get(final long row, final long col) {
                return ComplexNumber.valueOf(matrix.get((int) row, (int) col));
            }

            public int size() {
                return (int) matrix.count();
            }

        };
    }

    public static Access2D<Double> wrapPrimitiveAccess2D(final BasicMatrix matrix) {
        return new Access2D<Double>() {

            public long count() {
                return this.size();
            }

            public long countColumns() {
                return matrix.countColumns();
            }

            public long countRows() {
                return matrix.countRows();
            }

            public double doubleValue(final long index) {
                return matrix.doubleValue(index);
            }

            public double doubleValue(final long row, final long col) {
                return matrix.doubleValue(row, col);
            }

            public Double get(final long row, final long col) {
                return matrix.doubleValue(row, col);
            }

            public int size() {
                return (int) matrix.count();
            }

        };
    }

    private MatrixUtils() {
        super();
    }
}
