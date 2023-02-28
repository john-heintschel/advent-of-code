defmodule AdventOfCode.Directory do
  use GenServer

  def start_link(state \\ []) do
    GenServer.start_link(__MODULE__, state, name: __MODULE__)
  end

  def read_line(line) do
    # assumes lines come in order
    case String.starts_with?(line, "$ ") do
      true ->
        cmd = String.slice(line, 2..-1)

        case String.split(cmd) do
          ["cd", directory_name] ->
            GenServer.call(__MODULE__, {:change_dir, directory_name})

          # ignore ls
          _ ->
            nil
        end

      false ->
        case String.split(line) do
          ["dir", directory_name] ->
            GenServer.call(__MODULE__, {:add_directory, directory_name})

          [size, _size_name] ->
            GenServer.call(__MODULE__, {:add_file, size})

          [] ->
            nil
        end
    end
  end

  def all_dir_sizes() do
    GenServer.call(__MODULE__, {:get_dir_sizes})
  end

  @impl true
  def init(_) do
    root = initialize_dir()
    {:ok, %{:current_path => [], "/" => root}}
  end

  @impl true
  def handle_call({:change_dir, ".."}, _from, state) do
    [_ | temp] = Map.get(state, :current_path) |> Enum.reverse()
    [_ | rest] = temp

    {:reply, :ok, Map.put(state, :current_path, rest |> Enum.reverse())}
  end

  @impl true
  def handle_call({:change_dir, new_directory}, _from, state) do
    current_path = Map.get(state, :current_path)
    new_path = [:children | [new_directory | current_path |> Enum.reverse()]] |> Enum.reverse()

    {:reply, :ok, Map.put(state, :current_path, new_path)}
  end

  @impl true
  def handle_call({:add_file, size_str}, _from, state) do
    [_ | current_path] = Map.get(state, :current_path) |> Enum.reverse()

    path_from_root = Enum.reverse([:file_size | current_path])

    {size, _} = Integer.parse(size_str)

    current_size = get_in(state, path_from_root)

    new_state = put_in(state, path_from_root, current_size + size)

    {:reply, :ok, new_state}
  end

  @impl true
  def handle_call({:add_directory, directory_name}, _from, state) do
    current_path =
      [directory_name | Map.get(state, :current_path) |> Enum.reverse()]
      |> Enum.reverse()

    new_state = put_in(state, current_path, initialize_dir())
    # path = [:children | current_path |> Enum.reverse()] |> Enum.reverse()
    # new_state = Map.put(temp, :current_path, path)

    {:reply, :ok, new_state}
  end

  @impl true
  def handle_call({:get_dir_sizes}, _, state) do
    root = Map.get(state, "/")

    all_nodes = get_all_nodes(root)

    all_dir_sizes =
      all_nodes
      |> Enum.map(fn node -> get_size(node) end)

    {:reply, all_dir_sizes, state}
  end

  defp get_size(directory) do
    children_size =
      Map.get(directory, :children)
      |> Enum.map(fn {_key, child} -> get_size(child) end)
      |> Enum.sum()

    self_size = Map.get(directory, :file_size)

    self_size + children_size
  end

  defp get_all_nodes(root) do
    children = Map.get(root, :children)

    case map_size(children) do
      0 ->
        [root]

      _ ->
        descendants =
          children
          |> Enum.map(fn {_key, child} ->
            get_all_nodes(child)
          end)

        [root | descendants] |> List.flatten()
    end
  end

  defp initialize_dir() do
    %{
      :file_size => 0,
      :children => %{}
    }
  end
end

defmodule AdventOfCode.Day07 do
  def part1(input) do
    AdventOfCode.Directory.start_link()

    input
    |> String.split("\n")
    |> Enum.each(fn line -> AdventOfCode.Directory.read_line(line) end)

    AdventOfCode.Directory.all_dir_sizes()
    |> Enum.filter(fn x -> x <= 100_000 end)
    |> Enum.sum()
  end

  def part2(input) do
    system_total = 70_000_000
    AdventOfCode.Directory.start_link()

    input
    |> String.split("\n")
    |> Enum.each(fn line -> AdventOfCode.Directory.read_line(line) end)

    all_dir_sizes = AdventOfCode.Directory.all_dir_sizes()

    taken =
      all_dir_sizes
      |> Enum.max()

    available = system_total - taken
    minimum = 30_000_000 - available

    all_dir_sizes
    |> Enum.filter(fn x -> x >= minimum end)
    |> Enum.min()
  end
end
