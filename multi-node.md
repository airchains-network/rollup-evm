# Setting Up Multi-Node Ethermint Network

## On Computer 1 (Seed Node):

### Get Node ID and Chain ID

1. Run the following command to get the Node ID:

    ```bash
    ethermintd tendermint show-node-id
    ```

2. Locate `genesis.json` at `~/.ethermintd/config/genesis.json` and find the `chain_id`:

    ```json
    {
      "chain_id": "your_chain_id_here",
      ...
    }
    ```

---

## On Computer 2 (New Node):

### Initialize Node with Chain ID

1. Initialize the new node using the `chain_id` from the seed node's `genesis.json`:

    ```bash
    ethermintd init Your-Node-Name-Here --chain-id=your_chain_id_here
    ```

### Copy Genesis File

2. Transfer the `genesis.json` file from Computer 1 to Computer 2:

    ```bash
    scp username@computer_1_ip:~/.ethermintd/config/genesis.json ~/.ethermintd/config/genesis.json
    ```

### Update Configuration

3. Edit `~/.ethermintd/config/config.toml` on Computer 2 to set `persistent_peers`:

    ```toml
    persistent_peers = "node_id@computer_1_ip:26656"
    ```

### Start Node

4. Start the new node:

    ```bash
    ethermintd start
    ```

---

## Validation

- Use `ethermintd status` to verify if the new node is syncing correctly with the seed node.

---

Feel free to ask further questions or reach out for more details.



