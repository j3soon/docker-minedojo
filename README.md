# Docker image for MineDojo

A quick reference for using MineDojo in docker container. This may be useful since MineDojo has limited examples and contain some unresolved bugs.

## Build the Docker Images

```sh
git clone https://github.com/j3soon/docker-minedojo.git
cd docker-minedojo
docker build -t j3soon/minedojo-example .
```

## Run the Docker Container

```sh
# stop and remove the container if exists
docker stop minedojo && docker rm minedojo
# launch the container
docker run --name minedojo -it --gpus all -p 8080:8080 -d \
    -v $PWD:/workspace \
    j3soon/minedojo-example tail -f /dev/null
# exec into the container
docker exec -it minedojo /bin/bash
```

In the container, run the followings to test the installation:

```sh
vglrun python /workspace/MineDojo/scripts/validate_install.py
vglrun python /workspace/MineCLIP/main/mineagent/run_single.py
vglrun python /workspace/MineCLIP/main/mineagent/run_env_in_loop.py
vglrun python /workspace/MineCLIP/main/dense_reward/animal_zoo/run.py
```

If you're going to use the host MineDojo and MineCLIP, run the following in the container:

```sh
pip uninstall -y minedojo mineclip
rm -r ~/MineDojo ~/MineCLIP
pip install -e /workspace/MineCLIP
pip install -e /workspace/MineDojo
```

or simply rebuild the image.

## Miscellaneous

The following commands should be ran in the container.

### Recording Video

```sh
vglrun python /workspace/MineCLIP/main/dense_reward/animal_zoo_dig_down/run.py
```

observe the video where the player is digging downwards.

### Adventure Mode

In the animal zoo example, destroying blocks might disrupt training. To prevent this, we can switch the game mode to Adventure, which disables player from destroying the terrain:

```sh
/workspace/scripts/set_adventure_mode.sh
```

and test it with the script:

```sh
vglrun python /workspace/MineCLIP/main/dense_reward/animal_zoo_dig_down/run.py
```

observe the video where the player is digging downwards but cannot due to Adventure mode.

You can revert this change by:

```sh
/workspace/scripts/set_survival_mode.sh
```

## References

- MineDojo documentation [Installation](https://docs.minedojo.org/sections/getting_started/install.html) section
- [j3soon/MineDojo](https://github.com/j3soon/MineDojo) (commit 8950d4e) forked from [MineDojo/MineDojo](https://github.com/MineDojo/MineDojo) (commit 2731bc2)
- [MineDojo/egl-docker](https://github.com/MineDojo/egl-docker) (commit 932155a)
- [MineDojo/MineCLIP](https://github.com/MineDojo/MineCLIP) (commit e6c06a0)
