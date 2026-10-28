Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=178.62.254.231
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793175642;
	b=zGj2Lj8DVacl0kxbP1fg01XPqIf+wESd7lMY3jWkZHU7p909J0LjWDY7qMSUZKlZFNBe
	 eLRW20Icbuj3T3OJu/vNZ6N0QWU/eckdQErCx5j94MZR0GF1y7W3bFlcG15yptlcZAinB
	 HhcENOOQtvLrZmPMmuU3fbnNgu4t+klA02ShVo4k7zzRSSac4E1sDVWcJALO8iXjocrKS
	 phuKLT/atWW9Aeij53QsFkQGiL6xGlfOdn5YZNZIvOQ4jm/Z/6/OuTXADU83BMfdxHC4u
	 jps7Y4regoIbjgL0fJA5W3+GMntphj8a3pu2dLeuhdfli88RpNKoMeD0J1+DcH2zYNQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793175642;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=SMf0dV4x3xb+DslLmuw7FBFheVT29/cwuNdKSpo2QkE=;
	b=hTTcoCDID99rcsAHk7+nfhTtBpISZJib3mqSA6QO4wN4LKglRSuMrO0gkbDjiGKlO9WH
	 EnA1LbZ05KVT301CwrMS+qFQNhgQLxHiZnLCIshGB3+QQHQt31TKYVX4dSleFGlMTQMOL
	 tzYVhVeyhnfZXeEqSE+yjE4A0hwT3BRRNTJAT7OjYbLYSe0tXQLPnJv0j4TFvBA64biCY
	 74REikzsYVGpbIxbKLlNGvNPWuZdgTj5JLJmiIvn6PEE/pKbGb2Wi5GXDa2aFbdrl47SM
	 YtESztRNipfhJVNrxReVRsJH7grrYwQwxTulkQSJRz9lSfzFP6IynDsUQIsIbaiK+MQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=ilvokhin.com;
	spf=pass smtp.mailfrom=ilvokhin.com;
	dkim=pass header.d=ilvokhin.com header.i=@ilvokhin.com header.a=rsa-sha256 header.s=mail header.b=iyuSnZld;
	arc=none smtp.remote-ip=178.62.254.231
Received: from mail.ilvokhin.com (mail.ilvokhin.com [178.62.254.231])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2F7C606A325;
	Wed, 28 Oct 2026 08:20:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E2F7C606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ilvokhin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ilvokhin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=ilvokhin.com header.i=@ilvokhin.com header.a=rsa-sha256 header.s=mail header.b=iyuSnZld
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ilvokhin.com;
	s=mail; t=1793175633;
	bh=SMf0dV4x3xb+DslLmuw7FBFheVT29/cwuNdKSpo2QkE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=iyuSnZldpZjUpO/QwNk+P5YouZek0N2mycnUxbkQccvDC4YJ19S4/mULi0aeehza5
	 68UlH00B7Uiw50tvUL0mmPirCWsysK2dNqpdy84iHfp+1EmJSSkCPH4nrPYKSc8ftb
	 VX/gnIntc+RIw7VOplejxDi+mip28Hr6aXN6ETg8=
Received: from localhost.localdomain (shell.ilvokhin.com [138.68.190.75])
	(Authenticated sender: d@ilvokhin.com)
	by mail.ilvokhin.com (Postfix) with ESMTPSA id 65638FBCE4;
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
Subject: [PATCH 01/10] docs: xforms_lists: support __nonnull_args()
Date: Wed, 28 Oct 2026 08:19:40 +0000
Message-ID: <fd33c32bb1f1cf80721887b6e9bfa49749e03d20.1793027261.git.d@ilvokhin.com>
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

Avoid kernel-doc warnings by supporting __nonnull_args()
as a function transform.

This is a preparatory change for the treewide migration from
__attribute__((nonnull)) to __nonnull_args() macro.

Signed-off-by: Dmitry Ilvokhin <d@ilvokhin.com>
---
 tools/lib/python/kdoc/xforms_lists.py | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/lib/python/kdoc/xforms_lists.py b/tools/lib/python/kdoc/xforms_lists.py
index 320f977c5bac..a8c47ede8637 100644
--- a/tools/lib/python/kdoc/xforms_lists.py
+++ b/tools/lib/python/kdoc/xforms_lists.py
@@ -108,6 +108,7 @@ class CTransforms:
         (CMatch("__attribute__"), ""),
         (CMatch("STATIC_IFN_KUNIT"), ""),
         (CMatch("INLINE_IFN_KUNIT"), ""),
+        (CMatch("__nonnull_args"), ""),
 
         #
         # HACK: this is similar to process_export() hack. It is meant to
-- 
2.53.0-Meta

