# Tessellate patch set: TeamOpenIndustry/ImmersiveRailroading
- Base: `ba11894cae7d1caf204901b768489a53d3271dba` (tag 1.11.0)
- Patches (apply in order): `0001-sim-state-handoff.patch` `0002-coupler-shared-fields.patch` `0003-region-local-entity-queries-and-dirty-queue.patch` `0004-definition-reload-swap.patch` 
- Apply: `bash tessellate/apply.sh <checkout at base>` = `git apply --3way` each, fail hard
- Build: `bash ./gradlew remapJar -Dtarget=release -x test --no-daemon` (JDK 25); `tessellate/finalize.py` appends "Patched for Tessellate async region ticking." to description, jar -> `<name>-tessellate.jar`; modId/version untouched
- Maven: `com.wf.tessellate:immersiverailroading-tessellate:<modVersion>-SNAPSHOT` @ https://repo.warfactory.co/snapshots (secrets WARFACTORY_MAVEN_USER/TOKEN)
- CI: `.github/workflows/tessellate-patched.yml`
