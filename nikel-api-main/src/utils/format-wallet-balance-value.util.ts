export const formatWalletBalanceValue = (value: number) => {
    const multiplicationFactor = Math.pow(10, 2);
    const valueRounded = Math.round(value * multiplicationFactor) / multiplicationFactor;
    return parseFloat(valueRounded.toFixed(2));
};