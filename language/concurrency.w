// This file will discuss the language primitives around concurrency.
// This is inherently related to the proposal on parallelism.
// Key concepts: low overhead & high fault tolerance. pre-emptive vs cooperative scheduling.

// Potential keywords: go, spawn, async, await, execute

// Background - A quick look at concurrency in other languages:

// Go - like many other languages has very lightweight concurrency primitives,
// but unlike many languages, it has a simple syntax to create goroutines with the go keyword.
// Goroutines require cooperative scheduling.

// Elixir - also has simple syntax to create processes with the spawn keyword, but unlike
// many languages, it has great communication principles and great fault tolerance.

// Rust - uses async/await built on top of futures which generate a state machine that requires
// no runtime.

// Thoughts: Rust builds off of the C principle of zero-cost features, we would like to do
// the same here. Alternatively, we would like to simplify the syntax for a more comfortable
// and readable way like Go or Elixir. However, async is not a very accurate keyword for
// Rust's "lazy" evaluation since they don't actually do anything until used with an executor.
// Additionally, the syntax in the caller provides no context that a future is being returned,
// or other information about the desired behavior.

// Idea: The caller is the one that wraps the functions in a future and all code is written
// in a synchronous manner. In this case, the go keyword indicates that the called function
// will be called (or better explained as 'scheduled' due to lazy evaluation) asynchronously
// and return a future, rather than the normally expected return value. When you've built the
// callback chain, you simply call the top of the chain without the go keyword.

// Let's take an example from Rust and translate it.
async fn learn_song() -> Song { /* ... */ }
async fn sing_song(song: Song) { /* ... */ }
async fn dance() { /* ... */ }

async fn learn_and_sing() {
  // Wait until the song has been learned before singing it.
  // We use `.await` here rather than `block_on` to prevent blocking the
  // thread, which makes it possible to `dance` at the same time.
  let song = learn_song().await;
  sing_song(song).await;
}

async fn async_main() {
  let f1 = learn_and_sing();
  let f2 = dance();

  // `join!` is like `.await` but can wait for multiple futures concurrently.
  // If we're temporarily blocked in the `learn_and_sing` future, the `dance`
  // future will take over the current thread. If `dance` becomes blocked,
  // `learn_and_sing` can take back over. If both futures are blocked, then
  // `async_main` is blocked and will yield to the executor.
  futures::join!(f1, f2);
}

fn main() {
    block_on(async_main());
}

// The Tungsten equivalent would be:
func ()learn_song => Song { /* ... */ }
func (song Song)sing_song { /* ... */ }
func ()dance { /* ... */ }

func ()learn_and_sing {
  // there is no need to call await here because the go keyword indicates that everything in
  // the subsequent chain will be treated as a future (you can think of it as implicitly
  // calling await or go on every function in the chain). If you do need to block, simply call
  // it without the go keyword.
  go ()learn_song -> ()sing_song
}

func ()async_main {
  go ()learn_and_sing -> f1
  go ()dance -> f2

  f1, f2 -> ()join
}

func ()main {
  // There is no need to call await here because without the go keyword it is implicity implied.
  ()async_main;
}
