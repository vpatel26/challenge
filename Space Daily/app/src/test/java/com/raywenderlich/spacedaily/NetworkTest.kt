/*
 * Copyright (c) 2019 Razeware LLC
 *
 * Permission is hereby granted, free of charge, to any person obtaining a copy
 * of this software and associated documentation files (the "Software"), to deal
 * in the Software without restriction, including without limitation the rights
 * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 * copies of the Software, and to permit persons to whom the Software is
 * furnished to do so, subject to the following conditions:
 *
 * The above copyright notice and this permission notice shall be included in
 * all copies or substantial portions of the Software.
 *
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
 * THE SOFTWARE.
 */

package com.raywenderlich.spacedaily

import com.raywenderlich.spacedaily.di.networkModule
import com.raywenderlich.spacedaily.network.NASAAPIInterface
import com.squareup.moshi.Moshi
import junit.framework.Assert.assertNotNull
import junit.framework.Assert.assertTrue
import okhttp3.OkHttpClient
import org.junit.After
import org.junit.Before
import org.junit.Test
import org.koin.core.context.startKoin
import org.koin.core.context.stopKoin
import org.koin.core.qualifier.named
import org.koin.test.KoinTest
import org.koin.test.get
import org.koin.test.inject
import retrofit2.Retrofit

class NetworkTest : KoinTest {
  val api: NASAAPIInterface by inject()
  val moshi: Moshi by inject()
  val retrofit: Retrofit by inject()
  val okHttpClient: OkHttpClient by inject()
  val baseUrl: String by lazy { get(named("BASE_URL")) as String }

  @Before
  fun setup() {
    startKoin {
      modules(listOf(networkModule))
    }
  }

  @After
  fun tearDown() {
    stopKoin()
  }

  @Test
  fun `Test Retrofit Created`() {
    assertNotNull(retrofit)
    assert(baseUrl == "https://api.nasa.gov/planetary/")
  }

  @Test
  fun `Test Moshi Created`() {
    assertNotNull(moshi)
  }

  @Test
  fun `Test API Created`() {
    assertNotNull(api)
  }

  @Test
  fun `Test OKHttp`() {
    assertNotNull(okHttpClient)
    assertTrue(okHttpClient.connectTimeoutMillis == 30000)
    assertTrue(okHttpClient.writeTimeoutMillis == 30000)
    assertTrue(okHttpClient.readTimeoutMillis == 30000)
    assertTrue(okHttpClient.interceptors.size == 1)
  }

}