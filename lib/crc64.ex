defmodule CRC64 do
  @on_load :init

  def init do
    path = Application.app_dir(:crc64, "priv/crc64_nif") |> String.to_char_list
    :ok = :erlang.load_nif(path, 0)
  end

  def sum(data), do: sum(data, :unsigned)
  def sum(data, t), do: update(0, data, t)

  def update(crc, data), do: update(crc, data, :unsigned)
  def update(crc, nil, _) when is_integer(crc), do: 0
  def update(crc, data, :unsigned) when is_integer(crc) and is_binary(data), do: __uint64_crc__(crc, data)
  def update(crc, data, :signed) when is_integer(crc) and is_binary(data), do: __int64_crc__(crc, data)
  def update(crc, data, t) when is_integer(crc), do: update(crc, :erlang.term_to_binary(data), t)

  def __uint64_crc__(_crc, _bin) do
    raise "NIF is not loaded"
  end

  def __int64_crc__(_crc, _bin) do
    raise "NIF is not loaded"
  end
end
