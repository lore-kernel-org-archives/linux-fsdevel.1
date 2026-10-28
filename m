Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=178.62.254.231
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793175644;
	b=joYgVMr8w1Bto+C6mAoEzjqi25dKuYgO3amzVzBEUHbY9ainQphg5WZwHimtK5yTkVXp
	 FHrNd8+UssO0GTwL3Wg0KtBILLTKk4TK29eG6BEy/qiqww1zOG83mODR8Nh2yovHEIvF7
	 s7bt+lnQ7qPQTO9vj4GDjfnh6gv5JqIqQI8iZ+hjK+tFPyHD0eA7PMBGeP7KYZMcS9ahz
	 zrNxQvwpJBV+uxikJUQGPHhL02R0vx/UX6dzOcbE/M3twxciXXL07CpY6h0Cjc8O6HDtp
	 xxsyTx3nKkP1Z5w0fKV4weW1GK/7qp3J3qL6RvbT+VMFV8V8SOLnfZonlQETnzUVc7g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793175644;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=FiKV5NXJkUgnsMcI+sXb0n0HNmp3jB2cH055fflH0Yk=;
	b=eTGyYWlqVG2x2z3Q4dud94hH1jE74YsNJnPZZSLq5A1wOWNp76f7Ex4KHrzhFvwad/o8
	 lKTm1ZyMjp3xDXjVAegBiyc7JdL9h4oCRsRwAQcw+e5udH1B//ddRcnQXxEwyUhg9v+1K
	 we5JOKHKEgUxeqJMeB5BGaICrn7J/rT09qotwagg3F8VhiiBqHSQL15km3/8xpTGkChtp
	 eqGIMPf1ey+bllPj+HNpJ8ihfE/O+cLrWhQ/+DjMowgvrlZcLraIs1pCGf5t0WldzvPMC
	 r5LFmUU+VDUByTL2DMxtMO5i/Y1SXbPhFy1epp2Km6BNiXXA/IIikIcZXtmpEmQETnw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=ilvokhin.com;
	spf=pass smtp.mailfrom=ilvokhin.com;
	dkim=pass header.d=ilvokhin.com header.i=@ilvokhin.com header.a=rsa-sha256 header.s=mail header.b=VVlo1g2c;
	arc=none smtp.remote-ip=178.62.254.231
Received: from mail.ilvokhin.com (mail.ilvokhin.com [178.62.254.231])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1D9360A2617;
	Wed, 28 Oct 2026 08:20:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A1D9360A2617
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ilvokhin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ilvokhin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=ilvokhin.com header.i=@ilvokhin.com header.a=rsa-sha256 header.s=mail header.b=VVlo1g2c
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ilvokhin.com;
	s=mail; t=1793175636;
	bh=FiKV5NXJkUgnsMcI+sXb0n0HNmp3jB2cH055fflH0Yk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=VVlo1g2cdt+56K8mWNs+kTnpuMnj6v1NqMXFWNclXmipKK5Opz7hXWMThpTbOSgyj
	 eOL9BeLA9artebTwUe3aomW3AQpvt1PlkLxI2lRkk5FAhY0kJkXeOLwyoZBdm+iTWu
	 I8Pef11LheXSvHn1Q8Fn9g/yAIYYO1mDlqVjQ0aw=
Received: from localhost.localdomain (shell.ilvokhin.com [138.68.190.75])
	(Authenticated sender: d@ilvokhin.com)
	by mail.ilvokhin.com (Postfix) with ESMTPSA id E3709FBCFD;
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
Subject: [PATCH 06/10] drm/amdgpu: switch to __nonnull_args() macro
Date: Wed, 28 Oct 2026 08:19:45 +0000
Message-ID: <d57489b8bec240794a7a8aaac6e1e3e0d78ea331.1793027261.git.d@ilvokhin.com>
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
 drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
index 8f0720a77520..c238564b4a31 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
@@ -307,7 +307,7 @@ static int amdgpu_ttm_map_buffer(struct amdgpu_ttm_buffer_entity *entity,
  * move and different for a BO to BO copy.
  *
  */
-__attribute__((nonnull))
+__nonnull_args()
 static int amdgpu_ttm_copy_mem_to_mem(struct amdgpu_device *adev,
 				      struct amdgpu_ttm_buffer_entity *entity,
 				      const struct amdgpu_copy_mem *src,
-- 
2.53.0-Meta

