# simple example of using drake

library(drake)

plan <- drake_plan(
  size =  20,
  long = rnorm(size),
  result = target(length(long))
)

make(plan)
readd(result)
loadd(result)
vis_drake_graph(plan)

planB <- drake_plan(
  size =  20,
  sd = 2,
  long = rnorm(size, sd),
  resultB = length(long)
)

make(planB)
readd(resultB)
vis_drake_graph(planB)
outdated(planB)

drake_history()

planC <- drake_plan(
  data = read.csv(file_in('example.csv')),
  model = lm(y ~ x, data),
  results = summary(model)
  )

make(planC)
vis_drake_graph(planC)
readd(results)
summary(readd(model))

# following needs the fst library installed

n <- 1e8  # each is ca 1.6 Gb in memory

large <- drake_plan(
  data_fst = target(
    data.frame(x = runif(n), y = runif(n)),
    format = "fst"
    ),
  data_old = data.frame(x = runif(n), y = runif(n))
  )
make(large)    # Warning: This takes ca 3.5 minutes
build_times()
