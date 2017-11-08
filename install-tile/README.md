# Install Tile Pipeline

Install-tile uses externalised configuration to configure a tile install (and upgrade). Currenlty this is a POC
to determine how complex this is to do.

You need to have a second repository that stores the configuration.  In this example I have used 
https://github.com/haydonryan/tile-templates to store that configuration.



## Usage

1. Download the upgrade-tile pipeline from [Pivnet](https://network.pivotal.io/products/pcf-automation).

2. (Optional) Configure Schedule.

   In the `pipeline.yml` there is a `schedule` resource preconfigured to trigger
   the pipeline in 30 minute intervals every day.

   There are five parameters that can be modified to provide more fine grain
   control over when the pipeline upgrades tiles.

   * `interval`: This controls how often the pipeline is triggered. Defaults to
   `30m`.

   * `start` and `stop`: This controls what times of the day the resource is
   allowed to trigger the pipeline. For example, if the pipeline should only
   run in the middle of the night this could be set to:

      ```
      start: "11:00 PM"
      stop: "1:00 AM"
      ```

      The above configuration would give a two hour window for the pipeline to
      check for new versions.

      Defaults to:

      ```
      start: "12:00 AM"
      stop: "11:59 PM"
      ```

   * `location`: This is the timezone for `start`, `stop`, and `days`. Defaults
   to `America/Los_Angeles`.

   * `days`: This controls what days of the week the resource is allowed to trigger
   the pipeline. Defaults to every day.

3. Configure your `params.yml` file.

   This file contains parameters for the pipeline and the secrets necessary to
   communicate with PivNet and OpsMan. Fill it out with the necessary values and
   store it in a safe place.

4. [Set the pipeline](http://concourse.ci/single-page.html#fly-set-pipeline), using your updated params.yml:

   ```
   fly -t lite set-pipeline -p upgrade-your-tile -c pipeline.yml -l params.yml
   ```

5. Unpause the pipeline. The pipeline should then start triggering automatically.
