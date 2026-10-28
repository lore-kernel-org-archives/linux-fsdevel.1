Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=178.62.254.231
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793175644;
	b=LUuro+Nb+M9K0F4abxNGKplnRIPcpp6V9b19nnpSNL2eJquf2rAMhWtC93c3zbelKcf4
	 NZTkhF0dyT5vYOTiyTcnO/o7jZPcm+nmWjWf51szpOAAqRwVg3RApXGkmsHlnAGmlBzsp
	 DVCBhb/EgDL5tJyt6JGRqoNZUkld6LUv2YtjEiGFpgDlKYkx0VaNO7MPPM6ttp+aWFixu
	 QjXbwofPSKhXwcr25gUhFJD3GOV56EoAyGr1ctW4VLAKoX5Y7gcolEoQfMcugt0v9X3Mt
	 ukPe7E5xK0Pw2OQyQQpHqfTljBXwOkBvvOfma4OOmdBw0plkPnkCXYoGOBqiZQlE2gQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793175644;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=f3wDiNCwMmjyXbWSfqLqTJmF38wOioqFlsZp1JBWY8g=;
	b=QFhuZRit7qVu1GBGWOAazVfPX5eyd1xSSElMY3HZuN0J4/xjjCfXF7JphZs0MnTl0Rix
	 ZBMyB42q6O6+saB8Ih4WSM7gthf4toR8wc/dGIlpabgRCIfI46yjvpCWrWW/Hw6eOpY5E
	 C5rDvrlD0j0b0hm4rcvCxY2a7tYBNMb6YhLuzml8Be6bi77r9AfiX01if8Ct4j9j27omN
	 q5ornfJFckcA7eHZTIyT8eIcWGvaa/IY3W/O8pvaENngyu3nWkhnzkG9Mom2nHwQXBwKW
	 u4bn94Ykc/5029jNYpWIILwbQDkRe/2fPsuOK/Hs47SW2va4Qd4uVLFf+X2B+sUPJSA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=ilvokhin.com;
	spf=pass smtp.mailfrom=ilvokhin.com;
	dkim=pass header.d=ilvokhin.com header.i=@ilvokhin.com header.a=rsa-sha256 header.s=mail header.b=gY3XUXUz;
	arc=none smtp.remote-ip=178.62.254.231
Received: from mail.ilvokhin.com (mail.ilvokhin.com [178.62.254.231])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1E5F60A2619;
	Wed, 28 Oct 2026 08:20:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B1E5F60A2619
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ilvokhin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ilvokhin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=ilvokhin.com header.i=@ilvokhin.com header.a=rsa-sha256 header.s=mail header.b=gY3XUXUz
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ilvokhin.com;
	s=mail; t=1793175637;
	bh=f3wDiNCwMmjyXbWSfqLqTJmF38wOioqFlsZp1JBWY8g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=gY3XUXUzE59WwCVC4Qxuo4c1OjSPVasCM7D1wASmJouVr1JmoDvCR1fpvkN/NRule
	 x920S0FQBtza5BGKQpbvfVCzTkgENiiK4WcKdNZUluCqTy6kzWj7Aq537yU0sAAPsA
	 q2wy/d0fqfUd08AA2eVS24Chvy9WL59hmC+ynavA=
Received: from localhost.localdomain (shell.ilvokhin.com [138.68.190.75])
	(Authenticated sender: d@ilvokhin.com)
	by mail.ilvokhin.com (Postfix) with ESMTPSA id 0D880FBD0B;
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
Subject: [PATCH 08/10] leds: pwm: Switch to __nonnull_args() macro
Date: Wed, 28 Oct 2026 08:19:47 +0000
Message-ID: <ed2b0b67c306bb458ba389f16dc92904203a104b.1793027261.git.d@ilvokhin.com>
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
 drivers/leds/leds-pwm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/leds/leds-pwm.c b/drivers/leds/leds-pwm.c
index 6c1f2f50ff85..0363d370828b 100644
--- a/drivers/leds/leds-pwm.c
+++ b/drivers/leds/leds-pwm.c
@@ -80,7 +80,7 @@ static int led_pwm_default_brightness_get(struct fwnode_handle *fwnode,
 	return default_brightness;
 }
 
-__attribute__((nonnull))
+__nonnull_args()
 static int led_pwm_add(struct device *dev, struct led_pwm_priv *priv,
 		       struct led_pwm *led, struct fwnode_handle *fwnode)
 {
-- 
2.53.0-Meta

