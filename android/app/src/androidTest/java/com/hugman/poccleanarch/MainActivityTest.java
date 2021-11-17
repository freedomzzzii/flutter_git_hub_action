// Create an instrumentation test file in your application (Firebase test lab)
// see more in https://github.com/flutter/flutter/tree/master/packages/integration_test#android-device-testing
package com.hugeman.flutterstarterkit;

import androidx.test.rule.ActivityTestRule;
import dev.flutter.plugins.integration_test.FlutterTestRunner;
import org.junit.Rule;
import org.junit.runner.RunWith;

@RunWith(FlutterTestRunner.class)
public class MainActivityTest {
    @Rule
    public ActivityTestRule<MainActivity> rule = new ActivityTestRule<>(MainActivity.class, true, false);
}