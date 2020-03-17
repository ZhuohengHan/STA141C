x1 = nycflights13::flights$dep_delay
x2 = nycflights13::flights$arr_delay
y = nycflights13::flights$arr_time

data = data.frame(y,x1,x2)
newdata = data.frame(x1 = c(1,3), x2 = c(2,4))
