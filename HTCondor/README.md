# Example setup to submit jobs to HTCondor (e.g., at LXPLUS)

To submit HTCondor jobs with `weaver`, one needs to prepare two files:

- [run.sh](run.sh): bash script that activates the `conda` environment and executes the actual `weaver` command
  - There are a few paths to be set up in the file, e.g., the `condadir` that should point to the `miniconda3` installation.
  - Note that to get the best I/O stability/speed, one should copy files from EOS to the worker node. The can be achieved by adding ` --copy-inputs` to the `weaver` command, or by a manual transfer (e.g., using `rsync`).
- [submit.jdl](submit.jdl): the HTCondor job description file
  - for production jobs, adjust the [JobFlavour](https://batchdocs.web.cern.ch/tutorial/exercise6b.html) according to your need.

To test the setup, one can submit an **interactive** job:

```bash
condor_submit -interactive submit.jdl
```

And after logging into the worker node, run:

```bash
bash /full/path/to/run.sh
```

Once tested, a regular batch job can be submitted:

```bash
condor_submit submit.jdl
```

For more info about accessing GPUs via HTCondor at CERN:

- https://batchdocs.web.cern.ch/tutorial/exercise10.html
