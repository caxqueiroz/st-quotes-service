1.	import jenkins.model.*
import hudson.model.*

def getAllBuildNumbers(Job job) {
  def buildNumbers = []
  (job.getBuilds()).each { build ->
    buildNumbers.add(build.getDisplayName().substring(1))
  }
  return buildNumbers
}

def buildJob = Jenkins.instance.getItemByFullName('st-accounts-test');
return getAllBuildNumbers(buildJob)
