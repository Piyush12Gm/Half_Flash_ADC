# Half_Flash_ADC
- `It has less complexity in circuit to Flash ADC. 
- `Number of Comparators in Half Flash ADC is very less compared to Flash ADC.
- `Speed of Half Flash ADC is less than Flash ADC.
- `In Flash ADC of 8 Bits We need((2^n-1) ,Here n =8) = 255 Comparators.
- `In Half Flash ADC of 8 Bits , we need (using 2 for Bits ADC 2*(2^n-1), Here n =4) = 30 Comparators.
- `But we compromise speed of Flash ADC by Half Flash ADC.

### Explanation
1. **Input/Output**:
   - `clk`: Clock signal.
   - `reset`: Reset signal.
   - `analog_in`: 8-bit analog input signal.
   - `digital_out`: 8-bit digital output signal.
2. **Intermediate Signals**:
   - `msb`: Holds the most significant 4 bits.
   - `lsb`: Holds the least significant 4 bits.
   - `msb_compare` and `lsb_compare`: Comparator outputs for MSB and LSB, respectively.
3. **Flash Comparators**:
   - Two sets of flash comparators are generated using `generate` blocks.
   - The first set determines the MSB by comparing the `analog_in` to thresholds shifted by 4 bits.
   - The second set determines the LSB by comparing the `analog_in` to thresholds formed by combining the MSB and the lower 4 bits.
4. **Always Block**:
   - On each clock cycle, if reset is high, it resets the `msb`, `lsb`, and `digital_out`.
   - Otherwise, it updates `msb` and `lsb` based on the comparator results and combines them to form the final `digital_out`.
  
     
### Block Diagram Description
 ![half_Flash](https://github.com/user-attachments/assets/77647e9e-b802-4079-bcb4-329dd3e0e69d)
1. **Analog Input**   - Single input signal: `analog_in` (8 bits).
2. **MSB Flash Comparators**  - 16 comparators (`msb_compare[15:0]`) compare `analog_in` against 16 different threshold levels (0 to 15, each shifted left by 4 bits).
3. **MSB Encoder**   - Encodes the results of the MSB comparators into a 4-bit `msb` value, which represents the most significant 4 bits of the digital output.
4. **LSB Flash Comparators**   - 16 comparators (`lsb_compare[15:0]`) compare `analog_in` against 16 different threshold levels based on the `msb` value and the lower 4 bits (0 to 15).
5. **LSB Encoder**   - Encodes the results of the LSB comparators into a 4-bit `lsb` value, which represents the least significant 4 bits of the digital output.
6. **Digital Output**   - Combines the `msb` and `lsb` to form the final 8-bit `digital_out`.
![Screenshot (178)](https://github.com/user-attachments/assets/6b3caaef-dc08-4b49-9cf8-3c62f82855a8)

###  TEST BENCH Explanation:
1. **Clock Generation**: - A clock signal `clk` is generated with a period of 10 ns (100 MHz).
2. **Reset Signal**:  - The `reset` signal is asserted at the beginning to initialize the ADC module.
3. **Analog Input Test Vectors**:
   - A series of test vectors are applied to the `analog_in` signal to test different analog values.
4. **Instantiate the ADC Module**:
   - The half-flash ADC module `uut` (unit under test) is instantiated with the test bench signals connected to the module ports.
5. **Monitor the Output**:
   - The output `digital_out` is monitored and printed at each simulation time step to observe the conversion results.
     ![Screenshot (179)](https://github.com/user-attachments/assets/43d5ca4b-7ffb-485c-9c32-5383d09d87d2)


### Running the Simulation:
1. Save the test bench code to a file named `tb.v`.
2. Save the half-flash ADC Verilog code to a file named `half_flash_adc.v`.
3. Use a Verilog simulator (Vivado) to compile and run the test bench.
4. Observe the printed results in the simulation console to verify the correct operation of the ADC module.
EXPECTED WAVEFORM=>
Time (ns) | clk | reset | analog_in | digital_out
------------------------------------------------
   0      |  0  |   1   | 00000000  | 00000000 (reset)
   5      |  1  |   1   | 00000000  | 00000000 (reset)
  10      |  0  |   0   | 00000000  | 00000000 (reset released)
  20      |  1  |   0   | 00001111  | XXXXXXXX (to be determined)
  30      |  0  |   0   | 00001111  | 00001111 (after conversion)
  40      |  1  |   0   | 00111100  | XXXXXXXX (to be determined)
  50      |  0  |   0   | 00111100  | 00111100 (after conversion)
  60      |  1  |   0   | 01111111  | XXXXXXXX (to be determined)
  70      |  0  |   0   | 01111111  | 01111111 (after conversion)
  80      |  1  |   0   | 10101010  | XXXXXXXX (to be determined)
  90      |  0  |   0   | 10101010  | 10101010 (after conversion)
 100      |  1  |   0   | 11110000  | XXXXXXXX (to be determined)
 110      |  0  |   0   | 11110000  | 11110000 (after conversion)
 120      |  1  |   0   | 11111111  | XXXXXXXX (to be determined)
 130      |  0  |   0   | 11111111  | 11111111 (after conversion)
 140      |  1  |   0   | 11111111  | 11111111

