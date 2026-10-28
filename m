Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=178.62.254.231
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793175643;
	b=1ZtMPMKA4O9Z/oJGUT5gg5cOE8WGaAE7ytfoPmt60kQ0kHAYmPEnoDKyedm2qxrcqFT5
	 85ecb5/6g/49ZPRoAmu5vbp+SzX/q6i1HFQHFzqDrq6PWtlCUm+oDMSDrw8u+eNkNK8CT
	 RnLXykIe9UxdkE/AgVB2+kyXEMHPaw12fzgYyrbja8aHL7T3U3/K6HfHwd/e0nlWxA+rI
	 t4cQMLKTkpYLElcX+a9VC7F7I6+TFvjvyvg7b1kxAO6yBgMHZRtmZn5ya75U0h7PSOYyO
	 eI1ws2bvpkSj9RXZ9vJOLoLg9F+VcMIhWlBYxg7o+4yGnAfByxXqNiRDjh4J0wO90gQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793175643;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=ceexsp2t6/v12ItyH2pSPyV+syh2rxnTHvgHk3Ni1dE=;
	b=rCtmF1yDdCDQNWYHustVfCn30dg5J1LjgtVhDLpUnsDstdUKJxdjHGyKOuV14xB008ew
	 XE5RsJi1UAv/jYlbwm7niJnlZPVi91RBmmVdsAfeAhbauNV+vYdRuKmzpAnYDZjf/f6qE
	 wo09eDpZfaQwuRmyYa664A5pg7TThRqvKsioFwlH80jMieIsM9237XWwajcqdT+HlkBJ0
	 bPdDNGkb7XyUStb2Ah6TssxUysofFbflEQuN+eHOF6g0uZiw8MpHHTlt3ARI12YshQ8qh
	 OCgYgkUV+LjpvGoVSzEhlIoMvbvxPFh1ELq1/vXkkOJ9+xGrrD5oDhiQQqL0/MveSJw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=ilvokhin.com;
	spf=pass smtp.mailfrom=ilvokhin.com;
	dkim=pass header.d=ilvokhin.com header.i=@ilvokhin.com header.a=rsa-sha256 header.s=mail header.b=Jg8BLE8I;
	arc=none smtp.remote-ip=178.62.254.231
Received: from mail.ilvokhin.com (mail.ilvokhin.com [178.62.254.231])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A32860A2607;
	Wed, 28 Oct 2026 08:20:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2A32860A2607
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ilvokhin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ilvokhin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=ilvokhin.com header.i=@ilvokhin.com header.a=rsa-sha256 header.s=mail header.b=Jg8BLE8I
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ilvokhin.com;
	s=mail; t=1793175635;
	bh=ceexsp2t6/v12ItyH2pSPyV+syh2rxnTHvgHk3Ni1dE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Jg8BLE8IZCB+yObRAAqiVmVgU9sigg/nFDUGFqQXhWnSUadRZwDKyR4LY8EpthVle
	 pA/bIha5skUWK4mVY8+AIkx6NRdoOUTSd/zD45eghCBSekWpPyZ52q6p9FUlikkAVg
	 i5iCn86ahK5MOiZH/P0BO+c07/rkr7dgAwZrsWjg=
Received: from localhost.localdomain (shell.ilvokhin.com [138.68.190.75])
	(Authenticated sender: d@ilvokhin.com)
	by mail.ilvokhin.com (Postfix) with ESMTPSA id E1323FBCF2;
	Wed, 28 Oct 2026 08:20:34 +0000 (UTC)
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
Subject: [PATCH 04/10] xarray: switch to __nonnull_args() macro
Date: Wed, 28 Oct 2026 08:19:43 +0000
Message-ID: <e2660c4c9f5e6f97be2ef7bd3752d259bce77d81.1793027261.git.d@ilvokhin.com>
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

tools/testing/shared/linux/xarray.h directly includes the kernel's
include/linux/xarray.h, which now uses __nonnull_args(). The macro is
not defined under tools/, breaking test builds.

Define __nonnull_args() in tools/include/linux/compiler.h.

Suggested-by: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Signed-off-by: Dmitry Ilvokhin <d@ilvokhin.com>
---
 include/linux/xarray.h         | 4 ++--
 tools/include/linux/compiler.h | 4 ++++
 2 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/include/linux/xarray.h b/include/linux/xarray.h
index be850174e802..cf7f8802da5b 100644
--- a/include/linux/xarray.h
+++ b/include/linux/xarray.h
@@ -361,9 +361,9 @@ bool xa_get_mark(struct xarray *, unsigned long index, xa_mark_t);
 void xa_set_mark(struct xarray *, unsigned long index, xa_mark_t);
 void xa_clear_mark(struct xarray *, unsigned long index, xa_mark_t);
 void *xa_find(struct xarray *xa, unsigned long *index,
-		unsigned long max, xa_mark_t) __attribute__((nonnull(2)));
+		unsigned long max, xa_mark_t) __nonnull_args(2);
 void *xa_find_after(struct xarray *xa, unsigned long *index,
-		unsigned long max, xa_mark_t) __attribute__((nonnull(2)));
+		unsigned long max, xa_mark_t) __nonnull_args(2);
 unsigned int xa_extract(struct xarray *, void **dst, unsigned long start,
 		unsigned long max, unsigned int n, xa_mark_t);
 void xa_destroy(struct xarray *);
diff --git a/tools/include/linux/compiler.h b/tools/include/linux/compiler.h
index 03ecf9086643..fad2c6131a80 100644
--- a/tools/include/linux/compiler.h
+++ b/tools/include/linux/compiler.h
@@ -68,6 +68,10 @@
 #define __naked __attribute__((__naked__))
 #endif
 
+#ifndef __nonnull_args
+#define __nonnull_args(x...) __attribute__((__nonnull__(x)))
+#endif
+
 /* Are two types/vars the same type (ignoring qualifiers)? */
 #ifndef __same_type
 # define __same_type(a, b) __builtin_types_compatible_p(typeof(a), typeof(b))
-- 
2.53.0-Meta

