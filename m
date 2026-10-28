Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793187863;
	b=BIlRx43U5mRLubqM9oiPRxCseC9DH64IhmQIIadgpQ8iPtqdiWJEFigOes9cm23cRYp/
	 ETZLiLjjjZmWG/ZMz8spOLUPrpE6VSitL+Cllf+hwEq0yanS5fLAk+PARsBtnn9xa1Ar7
	 P8lixtrGW+7gwfDhcnschAuNyq4NzqxUGYScWyBQRLmt+rF+wjnGMYmuojRbR5DOHWPOd
	 MtOnRmJLWZJls0BxHg+qCwW//Smks3kbJJ/Iu7hKPKrfn0YafqhkPGTKelrYiRMUPaibc
	 O67B1gN6s/fuRswoT+vwg2/0nO3dP6psE5nKxlsWHy9ds0Jvb4L/lyMwKEnhS2rOELA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793187863;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=DfqZSZZirg02/y7+Hu6+biXxEuviwtSJMX1/tfCGZ1E=;
	b=zW2iHVjFpXW0ROTVMIIhLM4uAr0WtUklRBIVbE6jJMRdn5Fo17Ad4RSrzWRK4ZqM1ft3
	 EujMlp1VImuDFWlXJimQuWINp/bT3XOjuo4RTL9KrukIpCrH+XybZsuGJtcMW9ilui5yj
	 JP/oUYkZMty29dPF3g4GYOQNtZGNjW0MN2fF4gc0v66yGuuKXsopLE7NIlJSXazR4FsQa
	 i3vrILdO5CUeW6eh7zt9EBQxyJeLi4fygPr9Y/Is9OVk2Q/JZvEoR3Fv7+ZhiGQONFfPF
	 6LrdVmnJLX5Eg/KDkEaB24RjdiEP3IoelWkolmfZI3zkXcb0+A2XBykP/nEBjXD1cCw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jRmzhIrh;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D80C5606A31C;
	Wed, 28 Oct 2026 11:44:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jRmzhIrh
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8767F1F01825;
	Wed, 28 Oct 2026 11:44:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793187862;
	bh=DfqZSZZirg02/y7+Hu6+biXxEuviwtSJMX1/tfCGZ1E=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=jRmzhIrhvjBYvVLWvF2JxCm33XYPEY+B4MrjzqXXXvADrFnSkcbsTJSj1MGwIIrNw
	 kWnTLeNPwAIyLJtJ9+tdjv+78v1kDot8qmeI/jSFN574FYwb0mRlc5drmbrKuPcITI
	 6FEhIHn8LraufNE/4d0Z/2AXNjo9H839co+kG/5xv740bKnWioo+cV4BJVLb2j3VTR
	 QyAxwrfZ8T8k1/xE4OmhivZaTmo2IG6MCOaltdGwsIaTczyLlCF7xdElyanabRWrN9
	 fzrY4h44LuGfWoyKWEoK4nCqnl3RBFNXiOdi+7T9W3f9T3De3jThVozlgpURldPRMR
	 pvVdbwZCrX23Q==
Date: Wed, 28 Oct 2026 12:44:18 +0100
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
Subject: Re: [PATCH 05/10] drm/i915: switch to __nonnull_args() macro
Message-ID: <auHf-pdvGkPibgTp@zenone.zhora.eu>
References: <cover.1793027261.git.d@ilvokhin.com>
 <33ec8080594f9f4ef1d50e36497339c9a6897393.1793027261.git.d@ilvokhin.com>
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
In-Reply-To: <33ec8080594f9f4ef1d50e36497339c9a6897393.1793027261.git.d@ilvokhin.com>

Hi Dmitry,

On Wed, Oct 28, 2026 at 08:19:44AM +0000, Dmitry Ilvokhin wrote:
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
