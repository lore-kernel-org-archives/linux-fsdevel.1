Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=178.62.254.231
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793175643;
	b=nwzjqMXXUBm0qfTey84PcjnHI1eaxJirrY7K8NjSbYDPcOumcqlVs/xC+0hLDAExkbZQ
	 DxdjXPk627S+A9u1bGblssgV578ScC3a2RWMZPxcpsde/ICLQhBxAl/BDngQnx+El9z0y
	 GQLAGHSEl+eU3p5cBOXB+yqMyaUoAPUeuwGePvGx0cQn2u/EGZyYMt2Jd/dFvYXPhvxD1
	 qIWZotmv8H+H8XO5ATsUlieDenOu2EULYDV+/GcCITk0sYB1HtC+vIE9dAJVOaTEeC/GS
	 mwb5S3o9bWK7ut4tOIwaKxXwEUFLSQKGF6ehlFowlXh6qeKSF1a+ghWqEJwUCyydmJQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793175643;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=gVqyFTfbEx0Cy541rHtX1s3lHEBCWasBv5wrEWGFtiI=;
	b=W4Ah4puMYdRZ2njnkDCGJoXZMNBM173gpGZDf3hGq5ehJ5GWoEsAbC2FoHfp9QUY4dul
	 f8Dd0lNH6vW9gLwa1nZ0CO3LHzytdBrG5k+w2rNtEEGvmNFZ3ilZPEVKTBj4+aN0hOReI
	 pX4aduqMc+/987XLtxNkgXrPe6SDOO0DBoKYxCbE3Qm7xDTfjv5YIOZoPoRhlUn62ecFi
	 BD0d4q3x1VKYn0mwF7ENXZ3eSPC4aQwKq9KjLLpthWCrPcb5AVfNRJVwHm5BLRdq0Ky5i
	 uIOFwnThtoEjDY3TPWCa+gnbGAAu83+J/xJHl0iCJUQg1WnuFnkZQsYsTXzs8t64KvA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=ilvokhin.com;
	spf=pass smtp.mailfrom=ilvokhin.com;
	dkim=pass header.d=ilvokhin.com header.i=@ilvokhin.com header.a=rsa-sha256 header.s=mail header.b=zSnSDJrh;
	arc=none smtp.remote-ip=178.62.254.231
Received: from mail.ilvokhin.com (mail.ilvokhin.com [178.62.254.231])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A2E360A260A;
	Wed, 28 Oct 2026 08:20:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4A2E360A260A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ilvokhin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ilvokhin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=ilvokhin.com header.i=@ilvokhin.com header.a=rsa-sha256 header.s=mail header.b=zSnSDJrh
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ilvokhin.com;
	s=mail; t=1793175638;
	bh=gVqyFTfbEx0Cy541rHtX1s3lHEBCWasBv5wrEWGFtiI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=zSnSDJrh8lBPc+WJwkieuUvYZceHyW7Vo/Rgps/0sKKYfp+K8gQiq+VtATPCk1zcM
	 2R2y4VPojBg1miUzjCPiX1c/WXoMhA0i7UdNieYWkQzNjxxQaVUfA0XDy7P6CuqIG8
	 6OdZZd54748+SoGV6+XeC+xLbbD4RuBe2dmrjidY=
Received: from localhost.localdomain (shell.ilvokhin.com [138.68.190.75])
	(Authenticated sender: d@ilvokhin.com)
	by mail.ilvokhin.com (Postfix) with ESMTPSA id 232FBFBD1C;
	Wed, 28 Oct 2026 08:20:38 +0000 (UTC)
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
Subject: [PATCH 10/10] checkpatch: suggest nonnull attribute conversion
Date: Wed, 28 Oct 2026 08:19:49 +0000
Message-ID: <bc2cd702455e58feb777cdb230e3ba4f7e1db60f.1793027261.git.d@ilvokhin.com>
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

The kernel provides the __nonnull_args() macro as the preferred form for
marking pointer arguments as non-NULL. Add a check suggesting the macro
over the raw __attribute__((nonnull)) spelling, consistent with the
existing attribute conversion suggestions.

Examples:

  WARNING: Prefer __nonnull_args(1, 2) over __attribute__((nonnull(1, 2)))
  #11: FILE: drivers/soc/aspeed/aspeed-lpc-snoop.c:230:
  +__attribute__((nonnull(1, 2)))

  WARNING: Prefer __nonnull_args() over __attribute__((nonnull))
  #11: FILE: drivers/soc/aspeed/aspeed-lpc-snoop.c:283:
  +__attribute__((nonnull))

Signed-off-by: Dmitry Ilvokhin <d@ilvokhin.com>
---
 scripts/checkpatch.pl | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index c9840f5219c2..e696fcd02337 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -6856,6 +6856,7 @@ sub process {
 				"no_caller_saved_registers"	=> "__no_caller_saved_registers",
 				"noclone"			=> "__noclone",
 				"noinline"			=> "noinline",
+				"nonnull"			=> "__nonnull_args",
 				"nonstring"			=> "__nonstring",
 				"noreturn"			=> "__noreturn",
 				"packed"			=> "__packed",
@@ -6876,6 +6877,8 @@ sub process {
 					if ($curr_attr eq "format" && $params) {
 						$params =~ /^\s*\(\s*(\w+)\s*,\s*(.*)/;
 						$new = "__$1\($2";
+					} elsif ($curr_attr eq "nonnull" && $params eq "") {
+						$new = "$new()";
 					} else {
 						$new = "$new$params";
 					}
-- 
2.53.0-Meta

