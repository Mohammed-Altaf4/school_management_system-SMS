// Top-level build file where you can add configuration options common to all sub-projects/modules.

plugins {
    // Only apply plugins here if needed. Usually Flutter manages app plugin in app/build.gradle.kts
    id("com.android.application") apply false
    id("com.android.library") apply false
    id("org.jetbrains.kotlin.android") apply false
}

buildscript {
    repositories {
        google()
        mavenCentral()
    }
    dependencies {
        // This is required for Flutter projects
        classpath("com.android.tools.build:gradle:8.1.1")
        classpath("org.jetbrains.kotlin:kotlin-gradle-plugin:1.9.0")
    }
}

allprojects {
    repositories {
        google()
        mavenCentral()
    }
}

// --- Custom build directory setup ---
val newBuildDir: Directory = rootProject.layout.buildDirectory.dir("../../build").get()
rootProject.layout.buildDirectory.value(newBuildDir)

subprojects {
    val newSubprojectBuildDir: Directory = newBuildDir.dir(project.name)
    project.layout.buildDirectory.value(newSubprojectBuildDir)
}

subprojects {
    project.evaluationDependsOn(":app")
}

// --- Clean task ---
tasks.register<Delete>("clean") {
    delete(rootProject.layout.buildDirectory)
}
