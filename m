Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=178.62.254.231
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793175642;
	b=H16WUMOihT8+sN0DkxIzlbz0A+hvAFOf0LKoQ6s6IjWSYW9+9BoBfuPOsQVgZjcMsckr
	 vTY2oqHHnKljQfZ0nSn/ePFVknWMMyjXHCgam0Bq9i4WFRNryEo0oTA2DZniXSkwq4h8C
	 HtPlJACMDaSfWbCn7I+fNRtfHlM/Z8uhmqUfk9/0tRF80oMAzOOo3SWVYUrBZ+p5PIwSJ
	 FrCfbE+0F6kbwltYfp4q48ArYjpsa3Z+hUi1bvFsMGjNptnHN7ffy/vVIaVXBrRQrj26b
	 AfypeYyhBDVYjAEYaxVoKt7MMJt5kIJ1M42Xv6Q4wMkgiRKf95AMq4tsiM1oKFw0ZyQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793175642;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=dWJJn/15+ghgzzIGKgM3IMULkpSh/eugDFHemmlBRb4=;
	b=TsWSCUWpSSpMrYiGkzS4az08umU0W1q3VwgNvgMLJdIo/B8G6vkTd4ZCw/hmiUut+Ogx
	 UUp4srkjbTdnMCS5vbmow3u4N8VFk1KEbRlgkYlbc7Tx9wOOufY7aSwP94Ls7/9jeA8q2
	 /dGSRzdfvK9D1i+YK+tKuf+o8JjwhSYQyj24sq6q/oykbL/tDRKM9uQHdMojWy/QqoWwz
	 kbEyPtgQkd38lmtrWf9E0a4hCCZckSu5YZYar03t1qJowJDoYKU84jVFaMH9nOLjGOYhn
	 enx/IGtQrdSal2jWZ1cHebJ1d2D8f92HV2u8uD+KVdvWzB2XIM41G69Tk5sfblYAY5g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=ilvokhin.com;
	spf=pass smtp.mailfrom=ilvokhin.com;
	dkim=pass header.d=ilvokhin.com header.i=@ilvokhin.com header.a=rsa-sha256 header.s=mail header.b=DeIiv9WX;
	arc=none smtp.remote-ip=178.62.254.231
Received: from mail.ilvokhin.com (mail.ilvokhin.com [178.62.254.231])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDB3D606A324;
	Wed, 28 Oct 2026 08:20:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DDB3D606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ilvokhin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ilvokhin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=ilvokhin.com header.i=@ilvokhin.com header.a=rsa-sha256 header.s=mail header.b=DeIiv9WX
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ilvokhin.com;
	s=mail; t=1793175634;
	bh=dWJJn/15+ghgzzIGKgM3IMULkpSh/eugDFHemmlBRb4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=DeIiv9WXQV3gD55AucY67CXV5GytqfXEJkOIlH/p1vvpmEBa02wb0CiZ7FetKO8kp
	 vKMP3WYwznobDJIR52jidVzMPZfhGDf6UWW8grvqXfGJ9aPtokciLL67F0nlp74wpP
	 VCbSuHZCHz4d69J6NRvoiFKB6uqBPcC0poA2OXFs=
Received: from localhost.localdomain (shell.ilvokhin.com [138.68.190.75])
	(Authenticated sender: d@ilvokhin.com)
	by mail.ilvokhin.com (Postfix) with ESMTPSA id DF86BFBCE8;
	Wed, 28 Oct 2026 08:20:33 +0000 (UTC)
From: Dmitry Ilvokhin <d@ilvokhin.com>
To: Alex Deucher <alexander.deucher@amd.com>,
	=?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	Jani Nikula <jani.nikula@linux.intel.com>,
	Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
	Rodrigo Vivi <rodrigo.vivi@intel.com>,
	Tvrtko Ursulin <tursulin@ursulin.net>,
	Lee Jones <lee@kernel.org>,
	Pavel Machek <pavel@kernel.org>,
	Joel Stanley <joel@jms.id.au>,
	Andrew Jeffery <andrew@codeconstruct.com.au>,
	Ryan Chen <ryan_chen@aspeedtech.com>,
	Billy Tsai <billy_tsai@aspeedtech.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	Kees Cook <kees@kernel.org>,
	Andy Shevchenko <andy@kernel.org>,
	Matthew Wilcox <willy@infradead.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Andy Whitcroft <apw@canonical.com>,
	Joe Perches <joe@perches.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Randy Dunlap <rdunlap@infradead.org>
Cc: amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	intel-gfx@lists.freedesktop.org,
	linux-leds@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-aspeed@lists.ozlabs.org,
	linux-hardening@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org,
	linux-doc@vger.kernel.org,
	Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
	Dmitry Ilvokhin <d@ilvokhin.com>
Subject: [PATCH 02/10] string: Switch to __nonnull_args() macro
Date: Wed, 28 Oct 2026 08:19:41 +0000
Message-ID: <f0d7b2f0dce916f4cde3dd466a5b51a4b88fbdd8.1793027261.git.d@ilvokhin.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <cover.1793027261.git.d@ilvokhin.com>
References: <cover.1793027261.git.d@ilvokhin.com>
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Commit 22302af28d3f ("cleanup: Annotate guard constructors with
nonnull") added the macro __nonnull_args() to wrap raw compiler
attribute.

Replace __attribute__((nonnull)) with __nonnull_args() to
standardize nonnull attribute usage across the tree and keep the
attribute's quirks in one place rather than open-coded at every call
site.

Suggested-by: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Signed-off-by: Dmitry Ilvokhin <d@ilvokhin.com>
---
 include/linux/string.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/string.h b/include/linux/string.h
index 6cb5cdd01158..1f1cb73514e1 100644
--- a/include/linux/string.h
+++ b/include/linux/string.h
@@ -587,7 +587,7 @@ static inline bool strstarts(const char *str, const char *prefix)
  * Returns:
  * True if @str ends with @suffix. False in all other cases.
  */
-static inline bool __attribute__((nonnull(1, 2)))
+static inline bool __nonnull_args(1, 2)
 strends(const char *str, const char *suffix)
 {
 	unsigned int str_len = strlen(str), suffix_len = strlen(suffix);
-- 
2.53.0-Meta

