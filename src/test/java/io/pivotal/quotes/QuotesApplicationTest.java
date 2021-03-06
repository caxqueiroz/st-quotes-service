package io.pivotal.quotes;

import io.pivotal.quotes.configuration.IntegrationTests;
import io.pivotal.quotes.configuration.UnitTests;
import org.junit.Test;
import org.junit.experimental.categories.Category;
import org.junit.runner.RunWith;
import org.springframework.boot.test.SpringApplicationConfiguration;
import org.springframework.context.annotation.Profile;
import org.springframework.test.context.ActiveProfiles;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
/**
 * Tests for the Quotes Application.
 * @author David Ferreira Pinto
 *
 */
@RunWith(SpringJUnit4ClassRunner.class)
@SpringApplicationConfiguration(classes = QuotesApplication.class)
@ActiveProfiles("test")
@Category(IntegrationTests.class)
public class QuotesApplicationTest {
	/**
	 * test loading of spring context.
	 */
	@Test
	public void contextLoads() {
	}
}
