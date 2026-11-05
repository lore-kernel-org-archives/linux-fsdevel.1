Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793888066;
	b=i1a793zL/oX39Bk3mnaBjFiDDgZVAq17vz/zmvFidiRJEoOIxZaqNZNTMehf0ByckfBH
	 R8QMmP7yBmwyBXpEy2SM1LQ2C68BqX0bC9DByvz118ooDK8o3ESseMlJZmr71bsi5A3mf
	 36kor7cGYL5LXmsREPnlH9LylqBLfReBfm0DwBHmUYViVMTQl85ARSNUVBrb/A8d83pFC
	 hRNgSmxQJZTzTC0NQM+V2ij73XxcfVfHznukNmnWXYeKPGV2LocWDkbFr25lCzd/rOxWP
	 JMfMZYMoNMFwAxZPxCj5HUCbilWD8vwHoOxKBjFfBXxMiaqv/NVR0XkNmGr40TPa9Lw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793888066;
	h=Received:DKIM-Signature:From:To:Cc:In-Reply-To:References:Subject:
	 Message-Id:Date:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-Mailer;
	bh=4QpYJSS9gn8AjXi8jX/3Dtqw7BlVuFU8dH7dnogBVO0=;
	b=BgLohuSeZMZIaDr8O2VZ8kLrYts1KGUCH/tdFBMIa019RxnucZxV6jvsirfdEQZas3tw
	 PpVsF9YzvCRaKDlZgcEy428qWX/DqGDdMv1Y2EVzlb9WPsbRGqJ6rG9b3gpK3vpwkLbce
	 Uj26qMhDHXr9oeJxj3eOvsOa+WwrjofgqQoUSlbwex9GLxPQnUoc1Bht0iqYnCVb50+jI
	 14lFaJGWFf0xbqaZ7QuhNDPCHJznIFCccgpB5VNHmoBNtMQxfVUDREcySkCq45dnbRl6x
	 UgX95Bq2AxOsNLCx+CvJdeOq5TfXHjTtUR5v9CXtR5l1nlR2qBVLYALckvymvoZJn0Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ZHt7HSGu;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0B5E606D812;
	Thu,  5 Nov 2026 14:14:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ZHt7HSGu
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D2B311F00A1B;
	Thu,  5 Nov 2026 14:14:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793888065;
	bh=4QpYJSS9gn8AjXi8jX/3Dtqw7BlVuFU8dH7dnogBVO0=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=ZHt7HSGugybN5tt7aBm2DYpjLqmVSzGHPf+FbQmlOA5T4Nk5fCKWzCEZb+J82PHlw
	 l6AVe6kDbgKPpfD8/3R3rRcmmEPrg353sNwySWNZPUaC8eFmRslm5bIRcVZkF6IdyU
	 ruk1UXsR2KoKlIyaiX4m5Bt2MaupvTmPsJkjn50vKnSDxBeKsVV4bwubvy7qds1fXh
	 dHtWj4Z4lh+pj2d8Bkkjb5jAZcuLTyb0EPvvsrr0CO/XIRBV5F5Y3YmW39L6T82LYq
	 MDqcufEATybJTn1bGcMM2j64t0KtpUgUMcx8vhy/hXPFsBB7xQM1sVp6uE3gUGspMg
	 8BTqLnNf590eA==
From: Lee Jones <lee@kernel.org>
To: Alex Deucher <alexander.deucher@amd.com>, 
 =?utf-8?q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Jani Nikula <jani.nikula@linux.intel.com>, 
 Joonas Lahtinen <joonas.lahtinen@linux.intel.com>, 
 Rodrigo Vivi <rodrigo.vivi@intel.com>, 
 Tvrtko Ursulin <tursulin@ursulin.net>, Lee Jones <lee@kernel.org>, 
 Pavel Machek <pavel@kernel.org>, Joel Stanley <joel@jms.id.au>, 
 Andrew Jeffery <andrew@codeconstruct.com.au>, 
 Ryan Chen <ryan_chen@aspeedtech.com>, 
 Billy Tsai <billy_tsai@aspeedtech.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 Kees Cook <kees@kernel.org>, Andy Shevchenko <andy@kernel.org>, 
 Matthew Wilcox <willy@infradead.org>, 
 Andrew Morton <akpm@linux-foundation.org>, 
 Andy Whitcroft <apw@canonical.com>, Joe Perches <joe@perches.com>, 
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, 
 Randy Dunlap <rdunlap@infradead.org>, Dmitry Ilvokhin <d@ilvokhin.com>
Cc: amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, intel-gfx@lists.freedesktop.org, 
 linux-leds@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-aspeed@lists.ozlabs.org, linux-hardening@vger.kernel.org, 
 linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, 
 linux-doc@vger.kernel.org, Miguel Ojeda <ojeda@kernel.org>
In-Reply-To: <ed2b0b67c306bb458ba389f16dc92904203a104b.1793027261.git.d@ilvokhin.com>
References: <ed2b0b67c306bb458ba389f16dc92904203a104b.1793027261.git.d@ilvokhin.com>
Subject: Re: (subset) [PATCH 08/10] leds: pwm: Switch to __nonnull_args()
 macro
Message-Id: <179388805861.2575351.14283088205507759337.b4-ty@b4>
Date: Thu, 05 Nov 2026 14:14:18 +0000
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.16-dev-ad80c

On Wed, 28 Oct 2026 08:19:47 +0000, Dmitry Ilvokhin wrote:
> Commit 22302af28d3f ("cleanup: Annotate guard constructors with
> nonnull") added the macro __nonnull_args() to wrap raw compiler
> attribute.
> 
> Replace __attribute__((nonnull)) with __nonnull_args() to standardize
> nonnull attribute usage across the tree and keep the attribute's quirks
> in one place rather than open-coded at every call site.
> 
> [...]

Applied, thanks!

[08/10] leds: pwm: Switch to __nonnull_args() macro
        commit: 687615faae92e36a2b6c5ab0d007751e8e88a645

--
Lee Jones [李琼斯]

