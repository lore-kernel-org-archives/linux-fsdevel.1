Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=178.62.254.231
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793175644;
	b=eiaUIdo3R+CuD+96FmI7Z5bf5oYmkhqmMxgqmPW13t9LcZA72p5/PAPxNg0/HDq1NSMN
	 ypqVTgvq1JCd8EoOL5aBw41DlR0uQBmK8l8eazVw9R6NAW5XN2WG8dkktjZh9UYpxUEjr
	 Up0q9PhmPlMWFVcWmI9cHeNJWjv7S42JxrIbM4Ak4V3zQNmVFwQlcozkAP8yNufB/AMoU
	 8w1qbOF/pDs5WlvGxF4dYb6suJVAqgZaWFWy8Dtdlp8yygvW3VYpqzvCnaEIfLlnShn1T
	 QbuxPsI1EsneFDYOvHBu8hfKyiN3xC8u0f04GYwDVzcEUMp1p7IdYC0IXnVub5T69Tw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793175644;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=vb2YQU4qe6RImWUZBE+u9ZEB8G8V69bXRBRkb+fLOpk=;
	b=nCbCHdBOC5NU7XnCpEuAIMySMc5LciQ44OtIUzZkvXu5JuaoBoh1CSpShiMmQThwjVVK
	 p1KNsbjZA1z0VeX+NjqNsPdLPW+uLf6X+zxhymFWDUuXzJlDySSEjrG21KwEO3BWDcKxT
	 FCIENsV5A0ipY0lA1+lhj4UTsGmUBfDkTAKkcx/HNmfvkaTNRLZmaUPyLL9uBVusL9E2J
	 3lbC6kxKpObzmv198Oryg8ZZASSQB4p2hb14YDpkHTvrjyCyQwOQIjopRHMYUpYEqX2Te
	 4wXJxxdeUeXRXUmhgdW+aFolpxSTrNPCnujnC2b5M7f2MTjYA5/Qi+/rqBk49DiEa3g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=ilvokhin.com;
	spf=pass smtp.mailfrom=ilvokhin.com;
	dkim=pass header.d=ilvokhin.com header.i=@ilvokhin.com header.a=rsa-sha256 header.s=mail header.b=wWjFM+hS;
	arc=none smtp.remote-ip=178.62.254.231
Received: from mail.ilvokhin.com (mail.ilvokhin.com [178.62.254.231])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1D2760A2616;
	Wed, 28 Oct 2026 08:20:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A1D2760A2616
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ilvokhin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ilvokhin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=ilvokhin.com header.i=@ilvokhin.com header.a=rsa-sha256 header.s=mail header.b=wWjFM+hS
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ilvokhin.com;
	s=mail; t=1793175636;
	bh=vb2YQU4qe6RImWUZBE+u9ZEB8G8V69bXRBRkb+fLOpk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=wWjFM+hSTX3U8gdI2PDKi0wYk083s1rAoIucjog4b51AlSk0W2rJkgCKL+Evcl1K4
	 At9r43JjYcrWS5tKi0AYK2ha19HMAuni4cqUY2nx1yH++BKUGrmpWP+YV3sBEzZllO
	 r22BvFE5Ff0AYARkeLMplF+npotdwEUvo/Wg0P2c=
Received: from localhost.localdomain (shell.ilvokhin.com [138.68.190.75])
	(Authenticated sender: d@ilvokhin.com)
	by mail.ilvokhin.com (Postfix) with ESMTPSA id 7B5ECFBD05;
	Wed, 28 Oct 2026 08:20:36 +0000 (UTC)
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
Subject: [PATCH 07/10] drm/gem: Switch to __nonnull_args() macro
Date: Wed, 28 Oct 2026 08:19:46 +0000
Message-ID: <5bfdc1491d297b5e98cf42322c790f06481c28c7.1793027261.git.d@ilvokhin.com>
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
 include/drm/drm_gem.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/drm/drm_gem.h b/include/drm/drm_gem.h
index ed329408acbe..56dd15921c7a 100644
--- a/include/drm/drm_gem.h
+++ b/include/drm/drm_gem.h
@@ -566,7 +566,7 @@ static inline void drm_gem_object_get(struct drm_gem_object *obj)
 	kref_get(&obj->refcount);
 }
 
-__attribute__((nonnull))
+__nonnull_args()
 static inline void
 __drm_gem_object_put(struct drm_gem_object *obj)
 {
-- 
2.53.0-Meta

