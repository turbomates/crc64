defmodule CRC64Test do
  use ExUnit.Case
  doctest CRC64

  test "crc64" do
    # Test matrix from golang source https://golang.org/src/hash/crc64/crc64_test.go
    matrix = [
     {0x0, ""},
     {0x3420000000000000, "a"},
     {0x36c4200000000000, "ab"},
     {0x3776c42000000000, "abc"},
     {0x336776c420000000, "abcd"},
     {0x32d36776c4200000, "abcde"},
     {0x3002d36776c42000, "abcdef"},
     {0x31b002d36776c420, "abcdefg"},
     {0xe21b002d36776c4, "abcdefgh"},
     {0x8b6e21b002d36776, "abcdefghi"},
     {0x7f5b6e21b002d367, "abcdefghij"},
     {0x8ec0e7c835bf9cdf, "Discard medicine more than two years old."},
     {0xc7db1759e2be5ab4, "He who has a shady past knows that nice guys finish last."},
     {0xfbf9d9603a6fa020, "I wouldn't marry him with a ten foot pole."},
     {0xeafc4211a6daa0ef, "Free! Free!/A trip/to Mars/for 900/empty jars/Burma Shave"},
     {0x3e05b21c7a4dc4da, "The days of the digital watch are numbered.  -Tom Stoppard"},
     {0x5255866ad6ef28a6, "Nepal premier won't resign."},
     {0x8a79895be1e9c361, "For every action there is an equal and opposite government program."},
     {0x8878963a649d4916, "His money is twice tainted: 'taint yours and 'taint mine."},
     {0xa7b9d53ea87eb82f, "There is no reason for any individual to have a computer in their home. -Ken Olsen, 1977"},
     {0xdb6805c0966a2f9c, "It's a tiny change to the code and not completely disgusting. - Bob Manchek"},
     {0xf3553c65dacdadd2, "size:  a.out:  bad magic"},
     {0x9d5e034087a676b9, "The major problem is with sendmail.  -Mark Horton"},
     {0xa6db2d7f8da96417, "Give me a rock, paper and scissors and I will move the world.  CCFestoon"},
     {0x325e00cd2fe819f9, "If the enemy is within range, then so are you."},
     {0x88c6600ce58ae4c6, "It's well we cannot hear the screams/That we create in others' dreams."},
     {0x28c4a3f3b769e078, "You remind me of a TV show, but that's all right: I watch it anyway."},
     {0xa698a34c9d9f1dca, "C is as portable as Stonehedge!!"},
     {0xf6c1e2a8c26c5cfc, "Even if I could be Shakespeare, I think I should still choose to be Faraday. - A. Huxley"},
     {0xd402559dfe9b70c, "The fugacity of a constituent in a mixture of gases at a given temperature is proportional to its mole fraction.  Lewis-Randall Rule"},
     {0xdb6efff26aa94946, "How can you write a big system without C++?  -Paul Glick"}
    ]

    for {expectation, data} <- matrix do
      assert {CRC64.sum(data), data} == {expectation, data}
    end
  end

  test "update crc64" do
    crc = CRC64.sum("Hello")
    assert CRC64.update(crc, "World") == 12863625015634706158
  end

  test "crc64 for nil value" do
    assert CRC64.sum(nil) == 0
  end

  test "crc64 for any term" do
    assert CRC64.sum([]) == 4306918987393925120
  end

  test "crc64 signed" do
    assert CRC64.sum("Hello world", :signed) == -5057797506170508226
  end
end
