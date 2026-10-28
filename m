Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793187893;
	b=5QQxnFpgVW8wjmRPtq7OehpJ8tzidzfSrWLA/l/Rafk9sD1Mf1no8gatso7B3YRmRYzl
	 5SQpVhXXOfoy2O8CO7UeHrCXNeES/mh6zxTsqY8zPcfq3gldRhm08jvTJoV4tkgxnoJDO
	 HraiPTIR0tMSPQ91UJhqRke1/o1Yw087btvLpOnujzBahim0XaVvbYNY6LforcQV8nBdY
	 GBG99By/paqbSDfencIaj+Yl65ai/OdqlX/adLAgo5uy65AtoxD4Gc2ZTsJMYmDrzJE3c
	 rTnMsUT9pTTzFxbxPKhJ78qFdW8DD7BkwxA8fqYkiBV33Gca3Yx2ZVQAU5bjXkxajfA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793187893;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=AzxsreGIazEGHNZ+Tlba7bzQuuS0/SXodByMLbgqMaI=;
	b=ynDV06ewaWsOqp7ResbKt6zx7/rr8SEcUcS5znagb4Loc0x9owzPLTP7bLlWsCY0IGwf
	 p4dgyn7ceDzx6eVFP0nQBL0I5W4RmY0d0WWF/lQfdVBN7P7vq+QmHpffNlTEtFvAujf3f
	 /fyqRLQnlM5bRSmUsjfM+wxF1azSgagNt0eIZmHhIEldrokmVLUMKB3PSr9jZGBeRLRYF
	 G1N7UtuicIO103V5y/6e8u8IaAasnvCrJ1YqR0Sh1a4vzhWgrQO2C/oqX66zA+nK87F2a
	 YGPMb19FJPmtQaszA2MfQH8FBDRkspyU0gBtbx5s7UVDZGhhU7qgRjXRqGzH+2JCn+Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=JW4NmbXM;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17F52606A31A;
	Wed, 28 Oct 2026 11:44:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=JW4NmbXM
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7167F1F01825;
	Wed, 28 Oct 2026 11:44:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793187892;
	bh=AzxsreGIazEGHNZ+Tlba7bzQuuS0/SXodByMLbgqMaI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=JW4NmbXMV9NgnBU1HlqkVlN+rre+4AqJtfnOYsCrZ1r+jx0JuneNnyHXtAgbJhcCm
	 oGoH7Sf0QLhsPHYJ4VS3tj9kTxIwtUgUtfQrlW3PBdn2exn76z9iW9PGXPGM7wzI9x
	 At4s0hoSb59+TSET152LixjqCST6NybH81zHXNXle6qHlbYtt+3P9F/grboN9LPDNx
	 xzflTm1Ec4mh4z9eI8VLirREUz5LLnYViE+P42WUDgoR0QejsFy2B/B+DLWbjrllQj
	 91G7GnwWDaZoA9reF7WmdaYzo1PUQd8JuF3UHtJOxu/4CYIjVpedfBJtBtUN0pf7S9
	 lIU5MaIshhDuA==
Date: Wed, 28 Oct 2026 12:44:48 +0100
From: Andi Shyti <andi.shyti@kernel.org>
To: Dmitry Ilvokhin <d@ilvokhin.com>
Cc: Alex Deucher <alexander.deucher@amd.com>, 
	Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>, David Airlie <airlied@gmail.com>, 
	Simona Vetter <simona@ffwll.ch>, Jani Nikula <jani.nikula@linux.intel.com>, 
	Joonas Lahtinen <joonas.lahtinen@linux.intel.com>, Rodrigo Vivi <rodrigo.vivi@intel.com>, 
	Tvrtko Ursulin <tursulin@ursulin.net>, Lee Jones <lee@kernel.org>, Pavel Machek <pavel@kernel.org>, 
	Joel Stanley <joel@jms.id.au>, Andrew Jeffery <andrew@codeconstruct.com.au>, 
	Ryan Chen <ryan_chen@aspeedtech.com>, Billy Tsai <billy_tsai@aspeedtech.com>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, Kees Cook <kees@kernel.org>, Andy Shevchenko <andy@kernel.org>, 
	Matthew Wilcox <willy@infradead.org>, Andrew Morton <akpm@linux-foundation.org>, 
	Andy Whitcroft <apw@canonical.com>, Joe Perches <joe@perches.com>, Jonathan Corbet <corbet@lwn.net>, 
	Shuah Khan <skhan@linuxfoundation.org>, Randy Dunlap <rdunlap@infradead.org>, 
	amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
	intel-gfx@lists.freedesktop.org, linux-leds@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-aspeed@lists.ozlabs.org, linux-hardening@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-mm@kvack.org, linux-doc@vger.kernel.org, 
	Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Subject: Re: [PATCH 07/10] drm/gem: Switch to __nonnull_args() macro
Message-ID: <auHgHcU4fYauP_eD@zenone.zhora.eu>
References: <cover.1793027261.git.d@ilvokhin.com>
 <5bfdc1491d297b5e98cf42322c790f06481c28c7.1793027261.git.d@ilvokhin.com>
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5bfdc1491d297b5e98cf42322c790f06481c28c7.1793027261.git.d@ilvokhin.com>

Hi Dmitry,

On Wed, Oct 28, 2026 at 08:19:46AM +0000, Dmitry Ilvokhin wrote:
> Commit 22302af28d3f ("cleanup: Annotate guard constructors with
> nonnull") added the macro __nonnull_args() to wrap raw compiler
> attribute.
> 
> Replace __attribute__((nonnull)) with __nonnull_args() to standardize
> nonnull attribute usage across the tree and keep the attribute's quirks
> in one place rather than open-coded at every call site.
> 
> Suggested-by: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
> Signed-off-by: Dmitry Ilvokhin <d@ilvokhin.com>

Reviewed-by: Andi Shyti <andi.shyti@linux.intel.com>

Thanks,
Andi
