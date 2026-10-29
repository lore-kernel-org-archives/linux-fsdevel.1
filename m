Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793254587;
	b=un8w2Sq2taHb19LJQhtHo16NXSuyzNWR492Dd/bcZRlYsVIFxOBJ0irG4yplCbqwfgBy
	 28A8nXp/n/t0sPF4tZcJ2SOwUBq/OzgxzC0z94K7ARnAzj5k37AIdmPhpu6je9xVAGXqY
	 vnsY1DskaaC6bxg/4lrJxBTg5oR9c43Al2dV7u4SZgB6K3gDoNPxGP2ScAeyHIrJbUGK6
	 4MP5InlS/+ERj3+FFQgxtACzimcu0fOpwfPxeonShc1+P477AVkG9G7I0P5Xg3o3bvHMK
	 RsqqXtsr9/lvJCHIcXE7/Qjhc4vcwCLe9C9J/G2r+KcyIFDteTsLwCoIyB4NBwAq3cA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793254587;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-Id:
	 In-Reply-To:References:X-Mailer:Mime-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=mcrljsIymRV5+ffp+HQjRncEcwBUUlAXl9/IaAP6MUo=;
	b=rnH96ljai+cgQ6N/6rm9KoX82fTj700qH4t6tqKpNn1mfRiklmdNwucwdsrPyiXQOhId
	 GjGSNtu2bN/dNp8Lcm/vRaa/cEumQHb/Cy4YGwp/DSnPZmyGQ2aLANHelWeZViSGGyDCi
	 a2sJw+ja9lCzY/3LBO+h2M3wWSy2Hyl4E85/xFtzQVAJvvn29f2E9oldgjhcpgI1PNA1G
	 RcOV0OhNPHMBSICx6889sGXsbOFSKLnmWRWJnhChGa8p1v5Xikd/JqUMG5/wzbFHiFfww
	 qpg1S4AW932c3FG9r4u+dJf25o3DxYQYLHNEaiTVRuX1OQ4JzfPZ2II72Om11iq/ImA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=linux-foundation.org header.i=@linux-foundation.org header.a=rsa-sha256 header.s=korg header.b=il82Uc+P;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03255606A31D;
	Thu, 29 Oct 2026 06:16:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux-foundation.org header.i=@linux-foundation.org header.a=rsa-sha256 header.s=korg header.b=il82Uc+P
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3355C1F01825;
	Thu, 29 Oct 2026 06:16:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux-foundation.org; s=korg; t=1793254586;
	bh=mcrljsIymRV5+ffp+HQjRncEcwBUUlAXl9/IaAP6MUo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=il82Uc+PYiujnvTAx8vOogC0gI21PjTlyoqALCkM4BKfou7PHEjfs5eXMVf6rQLmD
	 r7l0jWwU5dMM7C1QnjOOEd1RybLgmxLXiAi85uSi1QAkVaUa806EpdyEr5k/sSbrWD
	 lzOnoAH3WemowZUWDdb65jcZuha7B4Kgx0FVU36Y=
Date: Wed, 28 Oct 2026 23:16:24 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Dmitry Ilvokhin <d@ilvokhin.com>
Cc: Alex Deucher <alexander.deucher@amd.com>, Christian =?ISO-8859-1?Q?K?=
 =?ISO-8859-1?Q?=F6nig?= <christian.koenig@amd.com>, David Airlie
 <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, Jani Nikula
 <jani.nikula@linux.intel.com>, Joonas Lahtinen
 <joonas.lahtinen@linux.intel.com>, Rodrigo Vivi <rodrigo.vivi@intel.com>,
 Tvrtko Ursulin <tursulin@ursulin.net>, Lee Jones <lee@kernel.org>, Pavel
 Machek <pavel@kernel.org>, Joel Stanley <joel@jms.id.au>, Andrew Jeffery
 <andrew@codeconstruct.com.au>, Ryan Chen <ryan_chen@aspeedtech.com>, Billy
 Tsai <billy_tsai@aspeedtech.com>, Maarten Lankhorst
 <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, Kees Cook <kees@kernel.org>, Andy
 Shevchenko <andy@kernel.org>, Matthew Wilcox <willy@infradead.org>, Andy
 Whitcroft <apw@canonical.com>, Joe Perches <joe@perches.com>, Jonathan
 Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, Randy
 Dunlap <rdunlap@infradead.org>, amd-gfx@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 intel-gfx@lists.freedesktop.org, linux-leds@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-aspeed@lists.ozlabs.org,
 linux-hardening@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 linux-mm@kvack.org, linux-doc@vger.kernel.org, Miguel Ojeda
 <miguel.ojeda.sandonis@gmail.com>
Subject: Re: [PATCH 00/10] treewide: switch to __nonnull_args() macro
Message-Id: <20261028231624.ba38137c3ba142785c75de78@linux-foundation.org>
In-Reply-To: <cover.1793027261.git.d@ilvokhin.com>
References: <cover.1793027261.git.d@ilvokhin.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 28 Oct 2026 08:19:39 +0000 Dmitry Ilvokhin <d@ilvokhin.com> wrote:

> Commit 22302af28d3f ("cleanup: Annotate guard constructors with
> nonnull") added the __nonnull_args() macro to wrap the raw compiler
> attribute, keeping the attribute's quirks in one place rather than
> open-coded at every call site.
> 
> This series replaces the remaining open-coded __attribute__((nonnull))
> users with __nonnull_args() to standardize nonnull attribute usage
> across the tree.
> 
> Each patch can be applied separately by the respective maintainers.

Thanks.

Standard routine: I'll grab everything.  If maintainers send along an
ack then I'll add it (thinks).  If some of these patches later pop up
in linux-next then Mark will inform us and I'll drop the mm.git copy.

