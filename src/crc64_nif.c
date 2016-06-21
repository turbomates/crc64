#include <stdint.h>
#include <erl_nif.h>

extern uint64_t crc64(uint64_t crc, unsigned char *data, uint64_t l);

ERL_NIF_TERM __uint64_crc__(ErlNifEnv* env, int arc, const ERL_NIF_TERM argv[])
{
  ErlNifBinary binary;
  int data_size = 0;
  unsigned char* data = NULL;
  unsigned long crc = 0;

  if (!enif_get_ulong(env, argv[0], &crc)) {
    return enif_make_badarg(env);
  }

  if (!enif_inspect_binary(env, argv[1], &binary)) {
    return enif_make_badarg(env);
  }

  data_size = binary.size;
  data = binary.data;

  crc = (unsigned long long) crc64(crc, data, data_size);

  return enif_make_ulong(env, crc);
}

ERL_NIF_TERM __int64_crc__(ErlNifEnv* env, int arc, const ERL_NIF_TERM argv[])
{
  ErlNifBinary binary;
  int data_size = 0;
  unsigned char* data = NULL;
  unsigned long crc = 0;

  if (!enif_get_ulong(env, argv[0], &crc)) {
    return enif_make_badarg(env);
  }

  if (!enif_inspect_binary(env, argv[1], &binary)) {
    return enif_make_badarg(env);
  }

  data_size = binary.size;
  data = binary.data;

  crc = (unsigned long long) crc64(crc, data, data_size);

  return enif_make_long(env, crc);
}

static ErlNifFunc nif_funcs[] = {
  { "__uint64_crc__", 2, __uint64_crc__ },
  { "__int64_crc__", 2, __int64_crc__ },
};

static int
load(ErlNifEnv* env, void** priv, ERL_NIF_TERM info) {
  return 0;
}

static int
reload(ErlNifEnv* env, void** priv, ERL_NIF_TERM info) {
  return 0;
}

static int
upgrade(ErlNifEnv* env, void** priv, void** old_priv, ERL_NIF_TERM info) {
  return load(env, priv, info);
}

static void
unload(ErlNifEnv* env, void* priv) {
  enif_free(priv);
}

ERL_NIF_INIT(Elixir.CRC64, nif_funcs, &load, &reload, &upgrade, &unload)
