LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_ARITH.ALL;
USE IEEE.STD_LOGIC_UNSIGNED.ALL;

ENTITY bat_n_ball IS
    PORT (
        v_sync : IN STD_LOGIC;
        pixel_row : IN STD_LOGIC_VECTOR(10 DOWNTO 0);
        pixel_col : IN STD_LOGIC_VECTOR(10 DOWNTO 0);
        bat_x : IN STD_LOGIC_VECTOR (10 DOWNTO 0); -- current bat x position
        serve : IN STD_LOGIC; -- initiates serve
        red : OUT STD_LOGIC;
        green : OUT STD_LOGIC;
        blue : OUT STD_LOGIC
    );
END bat_n_ball;

ARCHITECTURE Behavioral OF bat_n_ball IS
    CONSTANT bsize : INTEGER := 8; -- ball size in pixels
    CONSTANT bat_w : INTEGER := 40; -- bat width in pixels
    CONSTANT bat_h : INTEGER := 3; -- bat height in pixels
    CONSTANT brick_w : INTEGER := 45; -- brick width in pixels
    CONSTANT brick_h : INTEGER := 15; -- brick height in pixels
    -- distance ball moves each frame
    CONSTANT ball_speed : STD_LOGIC_VECTOR (10 DOWNTO 0) := CONV_STD_LOGIC_VECTOR (6, 11);
    SIGNAL ball_on : STD_LOGIC; -- indicates whether ball is at current pixel position
    SIGNAL bat_on : STD_LOGIC; -- indicates whether bat at over current pixel position
    SIGNAL brick_on : STD_LOGIC; -- indicates whether brick is at current pixel position
    SIGNAL brick2_on : STD_LOGIC;
    SIGNAL brick3_on : STD_LOGIC;
    SIGNAL brick4_on : STD_LOGIC;
    SIGNAL brick5_on : STD_LOGIC;
    SIGNAL brick6_on : STD_LOGIC;
    SIGNAL brick7_on : STD_LOGIC;
    SIGNAL brick8_on : STD_LOGIC;
    SIGNAL brick9_on : STD_LOGIC;
    SIGNAL brick10_on : STD_LOGIC;
    SIGNAL brick11_on : STD_LOGIC;
    SIGNAL brick12_on : STD_LOGIC;
    SIGNAL brick13_on : STD_LOGIC;
    SIGNAL brick14_on : STD_LOGIC;
    SIGNAL brick15_on : STD_LOGIC;
    SIGNAL brick16_on : STD_LOGIC;
    SIGNAL brick17_on : STD_LOGIC;
    SIGNAL brick18_on : STD_LOGIC;
    SIGNAL brick19_on : STD_LOGIC;
    SIGNAL brick20_on : STD_LOGIC;
    SIGNAL brick21_on : STD_LOGIC;
    SIGNAL brick22_on : STD_LOGIC;
    SIGNAL brick23_on : STD_LOGIC;
    SIGNAL brick24_on : STD_LOGIC;
    SIGNAL game_on : STD_LOGIC := '0'; -- indicates whether ball is in play
    -- current ball position - intitialized to center of screen
    SIGNAL ball_x : STD_LOGIC_VECTOR(10 DOWNTO 0) := CONV_STD_LOGIC_VECTOR(400, 11);
    SIGNAL ball_y : STD_LOGIC_VECTOR(10 DOWNTO 0) := CONV_STD_LOGIC_VECTOR(300, 11);
    -- bat vertical position
    CONSTANT bat_y : STD_LOGIC_VECTOR(10 DOWNTO 0) := CONV_STD_LOGIC_VECTOR(500, 11);
    -- current brick horizontal position
    SIGNAL brick_x : STD_LOGIC_VECTOR(10 DOWNTO 0) := CONV_STD_LOGIC_VECTOR(45, 11);
    SIGNAL brick2_x : STD_LOGIC_VECTOR(10 DOWNTO 0) := CONV_STD_LOGIC_VECTOR(145, 11);
    SIGNAL brick3_x : STD_LOGIC_VECTOR(10 DOWNTO 0) := CONV_STD_LOGIC_VECTOR(245, 11);
    SIGNAL brick4_x : STD_LOGIC_VECTOR(10 DOWNTO 0) := CONV_STD_LOGIC_VECTOR(345, 11);
    SIGNAL brick5_x : STD_LOGIC_VECTOR(10 DOWNTO 0) := CONV_STD_LOGIC_VECTOR(445, 11);
    SIGNAL brick6_x : STD_LOGIC_VECTOR(10 DOWNTO 0) := CONV_STD_LOGIC_VECTOR(545, 11);
    SIGNAL brick7_x : STD_LOGIC_VECTOR(10 DOWNTO 0) := CONV_STD_LOGIC_VECTOR(645, 11);
    SIGNAL brick8_x : STD_LOGIC_VECTOR(10 DOWNTO 0) := CONV_STD_LOGIC_VECTOR(745, 11);
    SIGNAL brick9_x : STD_LOGIC_VECTOR(10 DOWNTO 0) := CONV_STD_LOGIC_VECTOR(45, 11);
    SIGNAL brick10_x : STD_LOGIC_VECTOR(10 DOWNTO 0) := CONV_STD_LOGIC_VECTOR(145, 11);
    SIGNAL brick11_x : STD_LOGIC_VECTOR(10 DOWNTO 0) := CONV_STD_LOGIC_VECTOR(245, 11);
    SIGNAL brick12_x : STD_LOGIC_VECTOR(10 DOWNTO 0) := CONV_STD_LOGIC_VECTOR(345, 11);
    SIGNAL brick13_x : STD_LOGIC_VECTOR(10 DOWNTO 0) := CONV_STD_LOGIC_VECTOR(445, 11);
    SIGNAL brick14_x : STD_LOGIC_VECTOR(10 DOWNTO 0) := CONV_STD_LOGIC_VECTOR(545, 11);
    SIGNAL brick15_x : STD_LOGIC_VECTOR(10 DOWNTO 0) := CONV_STD_LOGIC_VECTOR(645, 11);
    SIGNAL brick16_x : STD_LOGIC_VECTOR(10 DOWNTO 0) := CONV_STD_LOGIC_VECTOR(745, 11);
    SIGNAL brick17_x : STD_LOGIC_VECTOR(10 DOWNTO 0) := CONV_STD_LOGIC_VECTOR(45, 11);
    SIGNAL brick18_x : STD_LOGIC_VECTOR(10 DOWNTO 0) := CONV_STD_LOGIC_VECTOR(145, 11);
    SIGNAL brick19_x : STD_LOGIC_VECTOR(10 DOWNTO 0) := CONV_STD_LOGIC_VECTOR(245, 11);
    SIGNAL brick20_x : STD_LOGIC_VECTOR(10 DOWNTO 0) := CONV_STD_LOGIC_VECTOR(345, 11);
    SIGNAL brick21_x : STD_LOGIC_VECTOR(10 DOWNTO 0) := CONV_STD_LOGIC_VECTOR(445, 11);
    SIGNAL brick22_x : STD_LOGIC_VECTOR(10 DOWNTO 0) := CONV_STD_LOGIC_VECTOR(545, 11);
    SIGNAL brick23_x : STD_LOGIC_VECTOR(10 DOWNTO 0) := CONV_STD_LOGIC_VECTOR(645, 11);
    SIGNAL brick24_x : STD_LOGIC_VECTOR(10 DOWNTO 0) := CONV_STD_LOGIC_VECTOR(745, 11);
    -- bricks 1-8 vertical position
    CONSTANT brick_y : STD_LOGIC_VECTOR(10 DOWNTO 0) := CONV_STD_LOGIC_VECTOR(30, 11);
    -- bricks 9-16 vertical position
    CONSTANT brick9_y : STD_LOGIC_VECTOR(10 DOWNTO 0) := CONV_STD_LOGIC_VECTOR(70, 11);
    -- bricks 17-24 vertical position
    CONSTANT brick17_y : STD_LOGIC_VECTOR(10 DOWNTO 0) := CONV_STD_LOGIC_VECTOR(110, 11);
    -- current ball motion - initialized to (+ ball_speed) pixels/frame in both X and Y directions
    SIGNAL ball_x_motion, ball_y_motion : STD_LOGIC_VECTOR(10 DOWNTO 0) := ball_speed;
BEGIN
    -- color setup for green ball and blue bat on black background
    -- bricks 1-8 are red, bricks 9-16 are magenta, bricks 17-24 are yellow
    red <= brick_on OR brick2_on OR brick3_on OR brick4_on OR brick5_on OR brick6_on OR brick7_on OR brick8_on OR brick9_on OR brick10_on OR brick11_on OR brick12_on OR brick13_on OR brick14_on OR brick15_on OR brick16_on OR brick17_on OR brick18_on OR brick19_on OR brick20_on OR brick21_on OR brick22_on OR brick23_on OR brick24_on;
    green <= ball_on OR brick17_on OR brick18_on OR brick19_on OR brick20_on OR brick21_on OR brick22_on OR brick23_on OR brick24_on;
    blue <= bat_on OR brick9_on OR brick10_on OR brick11_on OR brick12_on OR brick13_on OR brick14_on OR brick15_on OR brick16_on;
    -- process to draw round ball
    -- set ball_on if current pixel address is covered by ball position
    balldraw : PROCESS (ball_x, ball_y, pixel_row, pixel_col) IS
        VARIABLE vx, vy : STD_LOGIC_VECTOR (10 DOWNTO 0); -- 9 downto 0
    BEGIN
        IF pixel_col <= ball_x THEN -- vx = |ball_x - pixel_col|
            vx := ball_x - pixel_col;
        ELSE
            vx := pixel_col - ball_x;
        END IF;
        IF pixel_row <= ball_y THEN -- vy = |ball_y - pixel_row|
            vy := ball_y - pixel_row;
        ELSE
            vy := pixel_row - ball_y;
        END IF;
        IF ((vx * vx) + (vy * vy)) < (bsize * bsize) THEN -- test if radial distance < bsize
            ball_on <= game_on;
        ELSE
            ball_on <= '0';
        END IF;
    END PROCESS;
    -- process to draw bat
    -- set bat_on if current pixel address is covered by bat position
    batdraw : PROCESS (bat_x, pixel_row, pixel_col) IS
        VARIABLE vx, vy : STD_LOGIC_VECTOR (10 DOWNTO 0); -- 9 downto 0
    BEGIN
        IF ((pixel_col >= bat_x - bat_w) OR (bat_x <= bat_w)) AND
         pixel_col <= bat_x + bat_w AND
             pixel_row >= bat_y - bat_h AND
             pixel_row <= bat_y + bat_h THEN
                bat_on <= '1';
        ELSE
            bat_on <= '0';
        END IF;
    END PROCESS;
    -- process to draw brick
    -- set brick_on if current pixel address is covered by brick position
    brickdraw : PROCESS (pixel_row, pixel_col) IS
        VARIABLE vx, vy : STD_LOGIC_VECTOR (10 DOWNTO 0); -- 9 downto 0
    BEGIN
        IF ((pixel_col >= brick_x - brick_w) OR (brick_x <= brick_w)) AND
         pixel_col <= brick_x + brick_w AND
             pixel_row >= brick_y - brick_h AND
             pixel_row <= brick_y + brick_h THEN
                brick_on <= '1';
        ELSE
            brick_on <= '0';
        END IF;
    END PROCESS;
    brick2draw : PROCESS (pixel_row, pixel_col) IS
        VARIABLE vx, vy : STD_LOGIC_VECTOR (10 DOWNTO 0); -- 9 downto 0
    BEGIN
        IF ((pixel_col >= brick2_x - brick_w) OR (brick2_x <= brick_w)) AND
         pixel_col <= brick2_x + brick_w AND
             pixel_row >= brick_y - brick_h AND
             pixel_row <= brick_y + brick_h THEN
                brick2_on <= '1';
        ELSE
            brick2_on <= '0';
        END IF;
    END PROCESS;
    brick3draw : PROCESS (pixel_row, pixel_col) IS
        VARIABLE vx, vy : STD_LOGIC_VECTOR (10 DOWNTO 0); -- 9 downto 0
    BEGIN
        IF ((pixel_col >= brick3_x - brick_w) OR (brick3_x <= brick_w)) AND
         pixel_col <= brick3_x + brick_w AND
             pixel_row >= brick_y - brick_h AND
             pixel_row <= brick_y + brick_h THEN
                brick3_on <= '1';
        ELSE
            brick3_on <= '0';
        END IF;
    END PROCESS;
    brick4draw : PROCESS (pixel_row, pixel_col) IS
        VARIABLE vx, vy : STD_LOGIC_VECTOR (10 DOWNTO 0); -- 9 downto 0
    BEGIN
        IF ((pixel_col >= brick4_x - brick_w) OR (brick4_x <= brick_w)) AND
         pixel_col <= brick4_x + brick_w AND
             pixel_row >= brick_y - brick_h AND
             pixel_row <= brick_y + brick_h THEN
                brick4_on <= '1';
        ELSE
            brick4_on <= '0';
        END IF;
    END PROCESS;
    brick5draw : PROCESS (pixel_row, pixel_col) IS
        VARIABLE vx, vy : STD_LOGIC_VECTOR (10 DOWNTO 0); -- 9 downto 0
    BEGIN
        IF ((pixel_col >= brick5_x - brick_w) OR (brick5_x <= brick_w)) AND
         pixel_col <= brick5_x + brick_w AND
             pixel_row >= brick_y - brick_h AND
             pixel_row <= brick_y + brick_h THEN
                brick5_on <= '1';
        ELSE
            brick5_on <= '0';
        END IF;
    END PROCESS;
    brick6draw : PROCESS (pixel_row, pixel_col) IS
        VARIABLE vx, vy : STD_LOGIC_VECTOR (10 DOWNTO 0); -- 9 downto 0
    BEGIN
        IF ((pixel_col >= brick6_x - brick_w) OR (brick6_x <= brick_w)) AND
         pixel_col <= brick6_x + brick_w AND
             pixel_row >= brick_y - brick_h AND
             pixel_row <= brick_y + brick_h THEN
                brick6_on <= '1';
        ELSE
            brick6_on <= '0';
        END IF;
    END PROCESS;
    brick7draw : PROCESS (pixel_row, pixel_col) IS
        VARIABLE vx, vy : STD_LOGIC_VECTOR (10 DOWNTO 0); -- 9 downto 0
    BEGIN
        IF ((pixel_col >= brick7_x - brick_w) OR (brick7_x <= brick_w)) AND
         pixel_col <= brick7_x + brick_w AND
             pixel_row >= brick_y - brick_h AND
             pixel_row <= brick_y + brick_h THEN
                brick7_on <= '1';
        ELSE
            brick7_on <= '0';
        END IF;
    END PROCESS;
    brick8draw : PROCESS (pixel_row, pixel_col) IS
        VARIABLE vx, vy : STD_LOGIC_VECTOR (10 DOWNTO 0); -- 9 downto 0
    BEGIN
        IF ((pixel_col >= brick8_x - brick_w) OR (brick8_x <= brick_w)) AND
         pixel_col <= brick8_x + brick_w AND
             pixel_row >= brick_y - brick_h AND
             pixel_row <= brick_y + brick_h THEN
                brick8_on <= '1';
        ELSE
            brick8_on <= '0';
        END IF;
    END PROCESS;
    brick9draw : PROCESS (pixel_row, pixel_col) IS
        VARIABLE vx, vy : STD_LOGIC_VECTOR (10 DOWNTO 0); -- 9 downto 0
    BEGIN
        IF ((pixel_col >= brick9_x - brick_w) OR (brick9_x <= brick_w)) AND
         pixel_col <= brick9_x + brick_w AND
             pixel_row >= brick9_y - brick_h AND
             pixel_row <= brick9_y + brick_h THEN
                brick9_on <= '1';
        ELSE
            brick9_on <= '0';
        END IF;
    END PROCESS;
    brick10draw : PROCESS (pixel_row, pixel_col) IS
        VARIABLE vx, vy : STD_LOGIC_VECTOR (10 DOWNTO 0); -- 9 downto 0
    BEGIN
        IF ((pixel_col >= brick10_x - brick_w) OR (brick10_x <= brick_w)) AND
         pixel_col <= brick10_x + brick_w AND
             pixel_row >= brick9_y - brick_h AND
             pixel_row <= brick9_y + brick_h THEN
                brick10_on <= '1';
        ELSE
            brick10_on <= '0';
        END IF;
    END PROCESS;
    brick11draw : PROCESS (pixel_row, pixel_col) IS
        VARIABLE vx, vy : STD_LOGIC_VECTOR (10 DOWNTO 0); -- 9 downto 0
    BEGIN
        IF ((pixel_col >= brick11_x - brick_w) OR (brick11_x <= brick_w)) AND
         pixel_col <= brick11_x + brick_w AND
             pixel_row >= brick9_y - brick_h AND
             pixel_row <= brick9_y + brick_h THEN
                brick11_on <= '1';
        ELSE
            brick11_on <= '0';
        END IF;
    END PROCESS;
    brick12draw : PROCESS (pixel_row, pixel_col) IS
        VARIABLE vx, vy : STD_LOGIC_VECTOR (10 DOWNTO 0); -- 9 downto 0
    BEGIN
        IF ((pixel_col >= brick12_x - brick_w) OR (brick12_x <= brick_w)) AND
         pixel_col <= brick12_x + brick_w AND
             pixel_row >= brick9_y - brick_h AND
             pixel_row <= brick9_y + brick_h THEN
                brick12_on <= '1';
        ELSE
            brick12_on <= '0';
        END IF;
    END PROCESS;
    brick13draw : PROCESS (pixel_row, pixel_col) IS
        VARIABLE vx, vy : STD_LOGIC_VECTOR (10 DOWNTO 0); -- 9 downto 0
    BEGIN
        IF ((pixel_col >= brick13_x - brick_w) OR (brick13_x <= brick_w)) AND
         pixel_col <= brick13_x + brick_w AND
             pixel_row >= brick9_y - brick_h AND
             pixel_row <= brick9_y + brick_h THEN
                brick13_on <= '1';
        ELSE
            brick13_on <= '0';
        END IF;
    END PROCESS;
    brick14draw : PROCESS (pixel_row, pixel_col) IS
        VARIABLE vx, vy : STD_LOGIC_VECTOR (10 DOWNTO 0); -- 9 downto 0
    BEGIN
        IF ((pixel_col >= brick14_x - brick_w) OR (brick14_x <= brick_w)) AND
         pixel_col <= brick14_x + brick_w AND
             pixel_row >= brick9_y - brick_h AND
             pixel_row <= brick9_y + brick_h THEN
                brick14_on <= '1';
        ELSE
            brick14_on <= '0';
        END IF;
    END PROCESS;
    brick15draw : PROCESS (pixel_row, pixel_col) IS
        VARIABLE vx, vy : STD_LOGIC_VECTOR (10 DOWNTO 0); -- 9 downto 0
    BEGIN
        IF ((pixel_col >= brick15_x - brick_w) OR (brick15_x <= brick_w)) AND
         pixel_col <= brick15_x + brick_w AND
             pixel_row >= brick9_y - brick_h AND
             pixel_row <= brick9_y + brick_h THEN
                brick15_on <= '1';
        ELSE
            brick15_on <= '0';
        END IF;
    END PROCESS;
    brick16draw : PROCESS (pixel_row, pixel_col) IS
        VARIABLE vx, vy : STD_LOGIC_VECTOR (10 DOWNTO 0); -- 9 downto 0
    BEGIN
        IF ((pixel_col >= brick16_x - brick_w) OR (brick16_x <= brick_w)) AND
         pixel_col <= brick16_x + brick_w AND
             pixel_row >= brick9_y - brick_h AND
             pixel_row <= brick9_y + brick_h THEN
                brick16_on <= '1';
        ELSE
            brick16_on <= '0';
        END IF;
    END PROCESS;
    brick17draw : PROCESS (pixel_row, pixel_col) IS
        VARIABLE vx, vy : STD_LOGIC_VECTOR (10 DOWNTO 0); -- 9 downto 0
    BEGIN
        IF ((pixel_col >= brick17_x - brick_w) OR (brick17_x <= brick_w)) AND
         pixel_col <= brick17_x + brick_w AND
             pixel_row >= brick17_y - brick_h AND
             pixel_row <= brick17_y + brick_h THEN
                brick17_on <= '1';
        ELSE
            brick17_on <= '0';
        END IF;
    END PROCESS;
    brick18draw : PROCESS (pixel_row, pixel_col) IS
        VARIABLE vx, vy : STD_LOGIC_VECTOR (10 DOWNTO 0); -- 9 downto 0
    BEGIN
        IF ((pixel_col >= brick18_x - brick_w) OR (brick18_x <= brick_w)) AND
         pixel_col <= brick18_x + brick_w AND
             pixel_row >= brick17_y - brick_h AND
             pixel_row <= brick17_y + brick_h THEN
                brick18_on <= '1';
        ELSE
            brick18_on <= '0';
        END IF;
    END PROCESS;
    brick19draw : PROCESS (pixel_row, pixel_col) IS
        VARIABLE vx, vy : STD_LOGIC_VECTOR (10 DOWNTO 0); -- 9 downto 0
    BEGIN
        IF ((pixel_col >= brick19_x - brick_w) OR (brick19_x <= brick_w)) AND
         pixel_col <= brick19_x + brick_w AND
             pixel_row >= brick17_y - brick_h AND
             pixel_row <= brick17_y + brick_h THEN
                brick19_on <= '1';
        ELSE
            brick19_on <= '0';
        END IF;
    END PROCESS;
    brick20draw : PROCESS (pixel_row, pixel_col) IS
        VARIABLE vx, vy : STD_LOGIC_VECTOR (10 DOWNTO 0); -- 9 downto 0
    BEGIN
        IF ((pixel_col >= brick20_x - brick_w) OR (brick20_x <= brick_w)) AND
         pixel_col <= brick20_x + brick_w AND
             pixel_row >= brick17_y - brick_h AND
             pixel_row <= brick17_y + brick_h THEN
                brick20_on <= '1';
        ELSE
            brick20_on <= '0';
        END IF;
    END PROCESS;
    brick21draw : PROCESS (pixel_row, pixel_col) IS
        VARIABLE vx, vy : STD_LOGIC_VECTOR (10 DOWNTO 0); -- 9 downto 0
    BEGIN
        IF ((pixel_col >= brick21_x - brick_w) OR (brick21_x <= brick_w)) AND
         pixel_col <= brick21_x + brick_w AND
             pixel_row >= brick17_y - brick_h AND
             pixel_row <= brick17_y + brick_h THEN
                brick21_on <= '1';
        ELSE
            brick21_on <= '0';
        END IF;
    END PROCESS;
    brick22draw : PROCESS (pixel_row, pixel_col) IS
        VARIABLE vx, vy : STD_LOGIC_VECTOR (10 DOWNTO 0); -- 9 downto 0
    BEGIN
        IF ((pixel_col >= brick22_x - brick_w) OR (brick22_x <= brick_w)) AND
         pixel_col <= brick22_x + brick_w AND
             pixel_row >= brick17_y - brick_h AND
             pixel_row <= brick17_y + brick_h THEN
                brick22_on <= '1';
        ELSE
            brick22_on <= '0';
        END IF;
    END PROCESS;
    brick23draw : PROCESS (pixel_row, pixel_col) IS
        VARIABLE vx, vy : STD_LOGIC_VECTOR (10 DOWNTO 0); -- 9 downto 0
    BEGIN
        IF ((pixel_col >= brick23_x - brick_w) OR (brick23_x <= brick_w)) AND
         pixel_col <= brick23_x + brick_w AND
             pixel_row >= brick17_y - brick_h AND
             pixel_row <= brick17_y + brick_h THEN
                brick23_on <= '1';
        ELSE
            brick23_on <= '0';
        END IF;
    END PROCESS;
    brick24draw : PROCESS (pixel_row, pixel_col) IS
        VARIABLE vx, vy : STD_LOGIC_VECTOR (10 DOWNTO 0); -- 9 downto 0
    BEGIN
        IF ((pixel_col >= brick24_x - brick_w) OR (brick24_x <= brick_w)) AND
         pixel_col <= brick24_x + brick_w AND
             pixel_row >= brick17_y - brick_h AND
             pixel_row <= brick17_y + brick_h THEN
                brick24_on <= '1';
        ELSE
            brick24_on <= '0';
        END IF;
    END PROCESS;
    -- process to move ball once every frame (i.e. once every vsync pulse)
    mball : PROCESS
        VARIABLE temp : STD_LOGIC_VECTOR (11 DOWNTO 0);
    BEGIN
        WAIT UNTIL rising_edge(v_sync);
        IF serve = '1' AND game_on = '0' THEN -- test for new serve
            game_on <= '1';
            ball_y_motion <= (NOT ball_speed) + 1; -- set vspeed to (- ball_speed) pixels
        ELSIF ball_y <= bsize THEN -- bounce off top wall
            ball_y_motion <= ball_speed; -- set vspeed to (+ ball_speed) pixels
        ELSIF ball_y + bsize >= 600 THEN -- if ball meets bottom wall
            ball_y_motion <= (NOT ball_speed) + 1; -- set vspeed to (- ball_speed) pixels
            game_on <= '0'; -- and make ball disappear
        END IF;
        -- allow for bounce off left or right of screen
        IF ball_x + bsize >= 800 THEN -- bounce off right wall
            ball_x_motion <= (NOT ball_speed) + 1; -- set hspeed to (- ball_speed) pixels
        ELSIF ball_x <= bsize THEN -- bounce off left wall
            ball_x_motion <= ball_speed; -- set hspeed to (+ ball_speed) pixels
        END IF;
        -- allow for bounce off bat
        IF (ball_x + bsize/2) >= (bat_x - bat_w) AND
         (ball_x - bsize/2) <= (bat_x + bat_w) AND
             (ball_y + bsize/2) >= (bat_y - bat_h) AND
             (ball_y - bsize/2) <= (bat_y + bat_h) THEN
                ball_y_motion <= (NOT ball_speed) + 1; -- set vspeed to (- ball_speed) pixels
        END IF;
        -- allow for bounce off brick
        IF (ball_x + bsize/2) >= (brick_x - brick_w) AND
         (ball_x - bsize/2) <= (brick_x + brick_w) AND
             (ball_y + bsize/2) >= (brick_y - brick_h) AND
             (ball_y - bsize/2) <= (brick_y + brick_h) THEN
                ball_y_motion <= ball_speed;
                brick_x <= CONV_STD_LOGIC_VECTOR(-100, 11);
        END IF;
        IF (ball_x + bsize/2) >= (brick2_x - brick_w) AND
         (ball_x - bsize/2) <= (brick2_x + brick_w) AND
             (ball_y + bsize/2) >= (brick_y - brick_h) AND
             (ball_y - bsize/2) <= (brick_y + brick_h) THEN
                ball_y_motion <= ball_speed;
                brick2_x <= CONV_STD_LOGIC_VECTOR(-100, 11);
        END IF;
        IF (ball_x + bsize/2) >= (brick3_x - brick_w) AND
         (ball_x - bsize/2) <= (brick3_x + brick_w) AND
             (ball_y + bsize/2) >= (brick_y - brick_h) AND
             (ball_y - bsize/2) <= (brick_y + brick_h) THEN
                ball_y_motion <= ball_speed;
                brick3_x <= CONV_STD_LOGIC_VECTOR(-100, 11);
        END IF;
        IF (ball_x + bsize/2) >= (brick4_x - brick_w) AND
         (ball_x - bsize/2) <= (brick4_x + brick_w) AND
             (ball_y + bsize/2) >= (brick_y - brick_h) AND
             (ball_y - bsize/2) <= (brick_y + brick_h) THEN
                ball_y_motion <= ball_speed;
                brick4_x <= CONV_STD_LOGIC_VECTOR(-100, 11);
        END IF;
        IF (ball_x + bsize/2) >= (brick5_x - brick_w) AND
         (ball_x - bsize/2) <= (brick5_x + brick_w) AND
             (ball_y + bsize/2) >= (brick_y - brick_h) AND
             (ball_y - bsize/2) <= (brick_y + brick_h) THEN
                ball_y_motion <= ball_speed;
                brick5_x <= CONV_STD_LOGIC_VECTOR(-100, 11);
        END IF;
        IF (ball_x + bsize/2) >= (brick6_x - brick_w) AND
         (ball_x - bsize/2) <= (brick6_x + brick_w) AND
             (ball_y + bsize/2) >= (brick_y - brick_h) AND
             (ball_y - bsize/2) <= (brick_y + brick_h) THEN
                ball_y_motion <= ball_speed;
                brick6_x <= CONV_STD_LOGIC_VECTOR(-100, 11);
        END IF;
        IF (ball_x + bsize/2) >= (brick7_x - brick_w) AND
         (ball_x - bsize/2) <= (brick7_x + brick_w) AND
             (ball_y + bsize/2) >= (brick_y - brick_h) AND
             (ball_y - bsize/2) <= (brick_y + brick_h) THEN
                ball_y_motion <= ball_speed;
                brick7_x <= CONV_STD_LOGIC_VECTOR(-100, 11);
        END IF;
        IF (ball_x + bsize/2) >= (brick8_x - brick_w) AND
         (ball_x - bsize/2) <= (brick8_x + brick_w) AND
             (ball_y + bsize/2) >= (brick_y - brick_h) AND
             (ball_y - bsize/2) <= (brick_y + brick_h) THEN
                ball_y_motion <= ball_speed;
                brick8_x <= CONV_STD_LOGIC_VECTOR(-100, 11);
        END IF;
        IF (ball_x + bsize/2) >= (brick9_x - brick_w) AND
         (ball_x - bsize/2) <= (brick9_x + brick_w) AND
             (ball_y + bsize/2) >= (brick9_y - brick_h) AND
             (ball_y - bsize/2) <= (brick9_y + brick_h) THEN
                ball_y_motion <= ball_speed;
                brick9_x <= CONV_STD_LOGIC_VECTOR(-100, 11);
        END IF;
        IF (ball_x + bsize/2) >= (brick10_x - brick_w) AND
         (ball_x - bsize/2) <= (brick10_x + brick_w) AND
             (ball_y + bsize/2) >= (brick9_y - brick_h) AND
             (ball_y - bsize/2) <= (brick9_y + brick_h) THEN
                ball_y_motion <= ball_speed;
                brick10_x <= CONV_STD_LOGIC_VECTOR(-100, 11);
        END IF;
        IF (ball_x + bsize/2) >= (brick11_x - brick_w) AND
         (ball_x - bsize/2) <= (brick11_x + brick_w) AND
             (ball_y + bsize/2) >= (brick9_y - brick_h) AND
             (ball_y - bsize/2) <= (brick9_y + brick_h) THEN
                ball_y_motion <= ball_speed;
                brick11_x <= CONV_STD_LOGIC_VECTOR(-100, 11);
        END IF;
        IF (ball_x + bsize/2) >= (brick12_x - brick_w) AND
         (ball_x - bsize/2) <= (brick12_x + brick_w) AND
             (ball_y + bsize/2) >= (brick9_y - brick_h) AND
             (ball_y - bsize/2) <= (brick9_y + brick_h) THEN
                ball_y_motion <= ball_speed;
                brick12_x <= CONV_STD_LOGIC_VECTOR(-100, 11);
        END IF;
        IF (ball_x + bsize/2) >= (brick13_x - brick_w) AND
         (ball_x - bsize/2) <= (brick13_x + brick_w) AND
             (ball_y + bsize/2) >= (brick9_y - brick_h) AND
             (ball_y - bsize/2) <= (brick9_y + brick_h) THEN
                ball_y_motion <= ball_speed;
                brick13_x <= CONV_STD_LOGIC_VECTOR(-100, 11);
        END IF;
        IF (ball_x + bsize/2) >= (brick14_x - brick_w) AND
         (ball_x - bsize/2) <= (brick14_x + brick_w) AND
             (ball_y + bsize/2) >= (brick9_y - brick_h) AND
             (ball_y - bsize/2) <= (brick9_y + brick_h) THEN
                ball_y_motion <= ball_speed;
                brick14_x <= CONV_STD_LOGIC_VECTOR(-100, 11);
        END IF;
        IF (ball_x + bsize/2) >= (brick15_x - brick_w) AND
         (ball_x - bsize/2) <= (brick15_x + brick_w) AND
             (ball_y + bsize/2) >= (brick9_y - brick_h) AND
             (ball_y - bsize/2) <= (brick9_y + brick_h) THEN
                ball_y_motion <= ball_speed;
                brick15_x <= CONV_STD_LOGIC_VECTOR(-100, 11);
        END IF;
        IF (ball_x + bsize/2) >= (brick16_x - brick_w) AND
         (ball_x - bsize/2) <= (brick16_x + brick_w) AND
             (ball_y + bsize/2) >= (brick9_y - brick_h) AND
             (ball_y - bsize/2) <= (brick9_y + brick_h) THEN
                ball_y_motion <= ball_speed;
                brick16_x <= CONV_STD_LOGIC_VECTOR(-100, 11);
        END IF;
        IF (ball_x + bsize/2) >= (brick17_x - brick_w) AND
         (ball_x - bsize/2) <= (brick17_x + brick_w) AND
             (ball_y + bsize/2) >= (brick17_y - brick_h) AND
             (ball_y - bsize/2) <= (brick17_y + brick_h) THEN
                ball_y_motion <= ball_speed;
                brick17_x <= CONV_STD_LOGIC_VECTOR(-100, 11);
        END IF;
        IF (ball_x + bsize/2) >= (brick18_x - brick_w) AND
         (ball_x - bsize/2) <= (brick18_x + brick_w) AND
             (ball_y + bsize/2) >= (brick17_y - brick_h) AND
             (ball_y - bsize/2) <= (brick17_y + brick_h) THEN
                ball_y_motion <= ball_speed;
                brick18_x <= CONV_STD_LOGIC_VECTOR(-100, 11);
        END IF;
        IF (ball_x + bsize/2) >= (brick19_x - brick_w) AND
         (ball_x - bsize/2) <= (brick19_x + brick_w) AND
             (ball_y + bsize/2) >= (brick17_y - brick_h) AND
             (ball_y - bsize/2) <= (brick17_y + brick_h) THEN
                ball_y_motion <= ball_speed;
                brick19_x <= CONV_STD_LOGIC_VECTOR(-100, 11);
        END IF;
        IF (ball_x + bsize/2) >= (brick20_x - brick_w) AND
         (ball_x - bsize/2) <= (brick20_x + brick_w) AND
             (ball_y + bsize/2) >= (brick17_y - brick_h) AND
             (ball_y - bsize/2) <= (brick17_y + brick_h) THEN
                ball_y_motion <= ball_speed;
                brick20_x <= CONV_STD_LOGIC_VECTOR(-100, 11);
        END IF;
        IF (ball_x + bsize/2) >= (brick21_x - brick_w) AND
         (ball_x - bsize/2) <= (brick21_x + brick_w) AND
             (ball_y + bsize/2) >= (brick17_y - brick_h) AND
             (ball_y - bsize/2) <= (brick17_y + brick_h) THEN
                ball_y_motion <= ball_speed;
                brick21_x <= CONV_STD_LOGIC_VECTOR(-100, 11);
        END IF;
        IF (ball_x + bsize/2) >= (brick22_x - brick_w) AND
         (ball_x - bsize/2) <= (brick22_x + brick_w) AND
             (ball_y + bsize/2) >= (brick17_y - brick_h) AND
             (ball_y - bsize/2) <= (brick17_y + brick_h) THEN
                ball_y_motion <= ball_speed;
                brick22_x <= CONV_STD_LOGIC_VECTOR(-100, 11);
        END IF;
        IF (ball_x + bsize/2) >= (brick23_x - brick_w) AND
         (ball_x - bsize/2) <= (brick23_x + brick_w) AND
             (ball_y + bsize/2) >= (brick17_y - brick_h) AND
             (ball_y - bsize/2) <= (brick17_y + brick_h) THEN
                ball_y_motion <= ball_speed;
                brick23_x <= CONV_STD_LOGIC_VECTOR(-100, 11);
        END IF;
        IF (ball_x + bsize/2) >= (brick24_x - brick_w) AND
         (ball_x - bsize/2) <= (brick24_x + brick_w) AND
             (ball_y + bsize/2) >= (brick17_y - brick_h) AND
             (ball_y - bsize/2) <= (brick17_y + brick_h) THEN
                ball_y_motion <= ball_speed;
                brick24_x <= CONV_STD_LOGIC_VECTOR(-100, 11);
        END IF;
        -- compute next ball vertical position
        -- variable temp adds one more bit to calculation to fix unsigned underflow problems
        -- when ball_y is close to zero and ball_y_motion is negative
        temp := ('0' & ball_y) + (ball_y_motion(10) & ball_y_motion);
        IF game_on = '0' THEN
            ball_y <= CONV_STD_LOGIC_VECTOR(440, 11);
        ELSIF temp(11) = '1' THEN
            ball_y <= (OTHERS => '0');
        ELSE ball_y <= temp(10 DOWNTO 0); -- 9 downto 0
        END IF;
        -- compute next ball horizontal position
        -- variable temp adds one more bit to calculation to fix unsigned underflow problems
        -- when ball_x is close to zero and ball_x_motion is negative
        temp := ('0' & ball_x) + (ball_x_motion(10) & ball_x_motion);
        IF temp(11) = '1' THEN
            ball_x <= (OTHERS => '0');
        ELSE ball_x <= temp(10 DOWNTO 0);
        END IF;
    END PROCESS;
END Behavioral;
