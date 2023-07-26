// Input parameters
extern int fastSMA = 10;   // Fast SMA period
extern int slowSMA = 20;   // Slow SMA period

// Global variables
int maHandle;             // Moving Average handle

// Initialization function
int OnInit()
{
    // Create the fast and slow SMA lines
    maHandle = iMA(NULL, 0, fastSMA, 0, MODE_SMA, PRICE_CLOSE);
    maHandle = iMA(NULL, 0, slowSMA, 0, MODE_SMA, PRICE_CLOSE);
    
    return(INIT_SUCCEEDED);
}

// Execution function
void OnTick()
{
    // Check for crossover
    if (CrossedAbove(maHandle, 1))
    {
        // Generate buy signal
        Print("Buy signal generated at ", TimeToString(TimeCurrent(), TIME_DATE|TIME_MINUTES));
        // Add your trade execution code here for live trading
    }
    else if (CrossedBelow(maHandle, 1))
    {
        // Generate sell signal
        Print("Sell signal generated at ", TimeToString(TimeCurrent(), TIME_DATE|TIME_MINUTES));
        // Add your trade execution code here for live trading
    }
}

// Custom function to check for crossover
bool CrossedAbove(int handle, int shift)
{
    return (iMA(NULL, 0, fastSMA, shift, MODE_SMA, PRICE_CLOSE) > iMA(NULL, 0, slowSMA, shift, MODE_SMA, PRICE_CLOSE)
            && iMA(NULL, 0, fastSMA, shift-1, MODE_SMA, PRICE_CLOSE) <= iMA(NULL, 0, slowSMA, shift-1, MODE_SMA, PRICE_CLOSE));
}

bool CrossedBelow(int handle, int shift)
{
    return (iMA(NULL, 0, fastSMA, shift, MODE_SMA, PRICE_CLOSE) < iMA(NULL, 0, slowSMA, shift, MODE_SMA, PRICE_CLOSE)
            && iMA(NULL, 0, fastSMA, shift-1, MODE_SMA, PRICE_CLOSE) >= iMA(NULL, 0, slowSMA, shift-1, MODE_SMA, PRICE_CLOSE));
}
