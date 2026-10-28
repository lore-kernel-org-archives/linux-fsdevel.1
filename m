Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=178.62.254.231
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793175643;
	b=XKt32pVhuODC68gQS4MI7NL/BEjQqC7zz9RjlJDOlGuf54YgPDrej8SsSaqGB1wv6Nc9
	 XXcR7AWSe6Yb0eeADlJmhjK8HouEte+0cD9FxJFAoFVKXMD3bkGd0XrhFHmW8gR8iPrU0
	 H4FKrr8ltlkm/QRpM1rJecBAEHeDeW90VQI1jiOihM5fbdMepQuKjO56kcoLKYyc8G6+3
	 W2KRBl5rEQxEVRE1M4aFNzGqML7E3CpDEEnxDsL6Sg/4bMEFRrWjsEY6C0PWg+HPhMvB6
	 h8qyPXI6KWqidpxsELp38GrBNkDKy9W/zbtZdRjOgUOX7iGLKNlJLtkeGCn/O0mbYsw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793175643;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=7iGwC/zgOWLrxX4ANiv2xF58zogBn71EZM14tRgOJbE=;
	b=GMGmF/cKeefpBxH3garKwCaLnumP0BwHtejzBe4nQOLOpcL0TNYK257xl1hBwoBoqKuP
	 PpfmxxJoQJk+2akfJv147EVN5bqJWzjjk+xhlHAfhUncPTBMkV0Te2mlAzciA+c90QIDc
	 WhueBxBJHmHtXOViOrDQOw6185omivxsSSiPyTBaeLP3MkQOeXIoXlr5eWgEHa9Q8846I
	 XdMNUGkgb7usCcooAE07OcglA6WTiqYazMpVpCj/a8wuhfE/805FzTTcTrHYuKB+2SAEm
	 dwlCj0jIWZqZjEJQ/RhrvTMJK+ZqpHpoBZFrRBd123sRpLNlOjVHiL/GwsYOWzkpAZg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=ilvokhin.com;
	spf=pass smtp.mailfrom=ilvokhin.com;
	dkim=pass header.d=ilvokhin.com header.i=@ilvokhin.com header.a=rsa-sha256 header.s=mail header.b=csUWtQzw;
	arc=none smtp.remote-ip=178.62.254.231
Received: from mail.ilvokhin.com (mail.ilvokhin.com [178.62.254.231])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5229D60A260D;
	Wed, 28 Oct 2026 08:20:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5229D60A260D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ilvokhin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ilvokhin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=ilvokhin.com header.i=@ilvokhin.com header.a=rsa-sha256 header.s=mail header.b=csUWtQzw
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ilvokhin.com;
	s=mail; t=1793175638;
	bh=7iGwC/zgOWLrxX4ANiv2xF58zogBn71EZM14tRgOJbE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=csUWtQzwD2E/XlWZClH8qe1DSNmkf/BxgxVrI21nciRCwiVBnNkgR/QmWPWiXgOFf
	 r7hvwbXh1TI+dwN3mfeJxPnh+wv9MNKw/OzT9SWuYLztFyR/10iP2qfxQuy6XpjkYc
	 swD9LFS71C2gJ4LZM8Rqw6CkTpFxgtqHX1iTdRcg=
Received: from localhost.localdomain (shell.ilvokhin.com [138.68.190.75])
	(Authenticated sender: d@ilvokhin.com)
	by mail.ilvokhin.com (Postfix) with ESMTPSA id 91086FBD11;
	Wed, 28 Oct 2026 08:20:37 +0000 (UTC)
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
Subject: [PATCH 09/10] soc: aspeed: lpc-snoop: Switch to __nonnull_args() macro
Date: Wed, 28 Oct 2026 08:19:48 +0000
Message-ID: <6b82201d601c23bf8545f8d581fd6632c36cd208.1793027261.git.d@ilvokhin.com>
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
 drivers/soc/aspeed/aspeed-lpc-snoop.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/soc/aspeed/aspeed-lpc-snoop.c b/drivers/soc/aspeed/aspeed-lpc-snoop.c
index b09dca34099f..ee84a06a035e 100644
--- a/drivers/soc/aspeed/aspeed-lpc-snoop.c
+++ b/drivers/soc/aspeed/aspeed-lpc-snoop.c
@@ -226,7 +226,7 @@ static int aspeed_lpc_snoop_config_irq(struct aspeed_lpc_snoop *lpc_snoop,
 	return 0;
 }
 
-__attribute__((nonnull))
+__nonnull_args()
 static int aspeed_lpc_enable_snoop(struct device *dev,
 				    struct aspeed_lpc_snoop *lpc_snoop,
 				    struct aspeed_lpc_snoop_channel *channel,
@@ -279,7 +279,7 @@ static int aspeed_lpc_enable_snoop(struct device *dev,
 	return rc;
 }
 
-__attribute__((nonnull))
+__nonnull_args()
 static void aspeed_lpc_disable_snoop(struct aspeed_lpc_snoop *lpc_snoop,
 				     struct aspeed_lpc_snoop_channel *channel)
 {
-- 
2.53.0-Meta

