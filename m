Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=178.62.254.231
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793175644;
	b=FNlgPL9Wj2zMR2F1aOkVfcCLF/Hf2jbWDTYCngVEftDxMzUEMl705+lMd6dcaRr97PKW
	 /uhJ7GQX1tXQWJeA2i7m6EHgDyW9igI3t8dVbfv2JNAlMAYbr7eCYmcwMszStdoCd4UCU
	 wkizojGw0Dxab4jRkp7LyfNikdImlzwOW7NFzy/dBTHOckJjapMBYM5Jg+5qRPQS6lZan
	 jtUdOhbiXbVndrMFc2PmbrJEqZzxzJZfkFHJax0nfFoDBxx0s1t6Yz7RFX4i1mWCqhnJ3
	 UQHNYoLoTOQxUGrRTSqs/hcc4I1+KjSlbiU+Gvj1sPUYcBWQV+MMknR5FMlYYo0or3Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793175644;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=DLae2gx4aGYIpiU/bvQJfKJhKs4nNCXiSW/qMDyeW24=;
	b=ucEHQRT0fTgl7yGeFxGhYtuvXS0nUIBQhlrcRbXVw+sGjYi8SgS5wSYu5a8pACUHQCpr
	 L5p9Jmz+uuFF7HjSqmHtMHj3CJ16k+kIyhSlANm+3RjvOVfsk9NunbF1Cy42GC4uPCgZg
	 7WQsIO4aBgcLd0I/rA5tl1/DdWdCPoIoQRSmFvhXNwnK8CNn7vmxmvK6+xfAW+yk25MxO
	 tEsNYYQvsOgzSuBiJHnIlNfVvDtNpwBda0Lbeum+Jm72nm/CxqAFKmfGOmo6Eu029V1rQ
	 nPTq/HlXWAfXINGVG6VijlcvI9IsDxfPU8owtDqxIJBXIILJsQyUW+w2UqtjUh62CGg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=ilvokhin.com;
	spf=pass smtp.mailfrom=ilvokhin.com;
	dkim=pass header.d=ilvokhin.com header.i=@ilvokhin.com header.a=rsa-sha256 header.s=mail header.b=s1G4iNj7;
	arc=none smtp.remote-ip=178.62.254.231
Received: from mail.ilvokhin.com (mail.ilvokhin.com [178.62.254.231])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0FA360A2618;
	Wed, 28 Oct 2026 08:20:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B0FA360A2618
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ilvokhin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ilvokhin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=ilvokhin.com header.i=@ilvokhin.com header.a=rsa-sha256 header.s=mail header.b=s1G4iNj7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ilvokhin.com;
	s=mail; t=1793175635;
	bh=DLae2gx4aGYIpiU/bvQJfKJhKs4nNCXiSW/qMDyeW24=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=s1G4iNj7/OxMe3QEsIAEnZ0bhFm524AJi+UtsiJDNZZkymmDz57s/cSBMC+SkARw3
	 i3VKwlDdDVQAtn3D0ok4bdXGCRiRr75QTXzaZRCjPUoxQd2Dwf/537SkAttNRm5m+i
	 dIZin/56CDIf1Rz1jHjqkNsZ3h7kYtj+ZQxQXxGI=
Received: from localhost.localdomain (shell.ilvokhin.com [138.68.190.75])
	(Authenticated sender: d@ilvokhin.com)
	by mail.ilvokhin.com (Postfix) with ESMTPSA id 67144FBCF7;
	Wed, 28 Oct 2026 08:20:35 +0000 (UTC)
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
Subject: [PATCH 05/10] drm/i915: switch to __nonnull_args() macro
Date: Wed, 28 Oct 2026 08:19:44 +0000
Message-ID: <33ec8080594f9f4ef1d50e36497339c9a6897393.1793027261.git.d@ilvokhin.com>
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

Replace __attribute__((nonnull)) with __nonnull_args() to standardize
nonnull attribute usage across the tree and keep the attribute's quirks
in one place rather than open-coded at every call site.

Suggested-by: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Signed-off-by: Dmitry Ilvokhin <d@ilvokhin.com>
---
 drivers/gpu/drm/i915/gem/i915_gem_object.h | 4 ++--
 drivers/gpu/drm/i915/i915_request.h        | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/i915/gem/i915_gem_object.h b/drivers/gpu/drm/i915/gem/i915_gem_object.h
index a2f4b6758a65..648d0b4139cf 100644
--- a/drivers/gpu/drm/i915/gem/i915_gem_object.h
+++ b/drivers/gpu/drm/i915/gem/i915_gem_object.h
@@ -127,7 +127,7 @@ __deprecated
 struct drm_gem_object *
 drm_gem_object_lookup(struct drm_file *file, u32 handle);
 
-__attribute__((nonnull))
+__nonnull_args()
 static inline struct drm_i915_gem_object *
 i915_gem_object_get(struct drm_i915_gem_object *obj)
 {
@@ -135,7 +135,7 @@ i915_gem_object_get(struct drm_i915_gem_object *obj)
 	return obj;
 }
 
-__attribute__((nonnull))
+__nonnull_args()
 static inline void
 i915_gem_object_put(struct drm_i915_gem_object *obj)
 {
diff --git a/drivers/gpu/drm/i915/i915_request.h b/drivers/gpu/drm/i915/i915_request.h
index b09135301f39..f559203c332d 100644
--- a/drivers/gpu/drm/i915/i915_request.h
+++ b/drivers/gpu/drm/i915/i915_request.h
@@ -437,12 +437,12 @@ void i915_request_cancel(struct i915_request *rq, int error);
 long i915_request_wait_timeout(struct i915_request *rq,
 			       unsigned int flags,
 			       long timeout)
-	__attribute__((nonnull(1)));
+	__nonnull_args(1);
 
 long i915_request_wait(struct i915_request *rq,
 		       unsigned int flags,
 		       long timeout)
-	__attribute__((nonnull(1)));
+	__nonnull_args(1);
 #define I915_WAIT_INTERRUPTIBLE	BIT(0)
 #define I915_WAIT_PRIORITY	BIT(1) /* small priority bump for the request */
 #define I915_WAIT_ALL		BIT(2) /* used by i915_gem_object_wait() */
-- 
2.53.0-Meta

