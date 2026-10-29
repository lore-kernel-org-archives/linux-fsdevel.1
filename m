Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=178.62.254.231
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793275757;
	b=kZx22IW4AxkqyNrXhpMFbn5UeK5zUE4KMjUqAFPvmbAgF7OPKW05Q1FUNCdrSRKh6Wd2
	 bpdJNRWHB1BXN8VYMY1iALPmKlQ2YUNBuPnaNF02lUA13a32NDaiPJjQj0+o/VsYe8xqb
	 2p7z0TjcUd27tLd5u4OSFJr7zdGzYZxF9o8JIfqYn5h24GqMcyzg+Q1LyqcLMvi7olyKd
	 hd8KjGIVixmK1hjRjYk+I2PSz7KulQMrNmb6AyZuM/V4Eks1HRPYXmmdsJtpjtUC5PEJp
	 WFZNXnWovRUV3/+qyMYO4HhDjgzIv5mvdDsmh2G/oYbuHF8HIbQjNfr1lAWHNjE3A6w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793275757;
	h=DMARC-Filter:DKIM-Signature:Received:Date:From:To:Cc:Subject:
	 Message-ID:References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To;
	bh=RocjA1LFJ8nCgW+tO2y+Fh4wXXWjfdPFo024IhF5Wq8=;
	b=DMDKybJTkp3TKOA2SxTMYcpjmDFGNQdS0ASQGkojHhjM6iyIYgD9Okk7ioH+TLxrvdYf
	 rduAXJ9XOTv6t2RXNO2RZj8o4o45VQijn5g1bjGVg3f2kvBjFwKRavmFIlcxZhK3F4qKO
	 lbX1vCgnzcqA4ff3+h+mADgcD5KF2FV2JPr6r6zjWmjy+XtdGmE5jzugoKWSfIyNa1mQy
	 1fLzhmCWJVj+KXjiSd2AyeUxE0b3GJIN6rBnOxektPx6PJZDQa9LHlnKkARo35wI5l6nl
	 buazOnVXps52x+9sabekRoef2M6rF7hUE3yOneIIpCvvK3D3jOMNoDTJsusYj+DEG4Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=ilvokhin.com;
	spf=pass smtp.mailfrom=ilvokhin.com;
	dkim=pass header.d=ilvokhin.com header.i=@ilvokhin.com header.a=rsa-sha256 header.s=mail header.b=WUo05cr+;
	arc=none smtp.remote-ip=178.62.254.231
Received: from mail.ilvokhin.com (mail.ilvokhin.com [178.62.254.231])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40669606A31A;
	Thu, 29 Oct 2026 12:09:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 40669606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ilvokhin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ilvokhin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=ilvokhin.com header.i=@ilvokhin.com header.a=rsa-sha256 header.s=mail header.b=WUo05cr+
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ilvokhin.com;
	s=mail; t=1793275747;
	bh=RocjA1LFJ8nCgW+tO2y+Fh4wXXWjfdPFo024IhF5Wq8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=WUo05cr+foO7RPlP7534YSiBgZ8CQPkwQY40XhGkYZY6+6/4j3XkS/IFDfGv+Pkoh
	 y9zJIn2BFoMmtdWooRjNBcjjjJtArbTwyJLsxt66JLoWE/gVCnnA7sNVi3UolL8xve
	 VDmnu4pCCOxy8JC/MQlwNqsBS6P1OvE3N85vIIf8=
Received: from shell.ilvokhin.com (shell.ilvokhin.com [138.68.190.75])
	(Authenticated sender: d@ilvokhin.com)
	by mail.ilvokhin.com (Postfix) with ESMTPSA id 2E446101220;
	Thu, 29 Oct 2026 12:09:07 +0000 (UTC)
Date: Thu, 29 Oct 2026 12:09:03 +0000
From: Dmitry Ilvokhin <d@ilvokhin.com>
To: Randy Dunlap <rdunlap@infradead.org>
Cc: Alex Deucher <alexander.deucher@amd.com>,
	Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
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
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	Kees Cook <kees@kernel.org>, Andy Shevchenko <andy@kernel.org>,
	Matthew Wilcox <willy@infradead.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Andy Whitcroft <apw@canonical.com>, Joe Perches <joe@perches.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org, intel-gfx@lists.freedesktop.org,
	linux-leds@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-aspeed@lists.ozlabs.org, linux-hardening@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
	linux-doc@vger.kernel.org,
	Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Subject: Re: [PATCH 00/10] treewide: switch to __nonnull_args() macro
Message-ID: <auM3XwWPnMHcPptM@shell.ilvokhin.com>
References: <cover.1793027261.git.d@ilvokhin.com>
 <cce30180-c1c4-4b10-b681-8944057bc698@infradead.org>
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
In-Reply-To: <cce30180-c1c4-4b10-b681-8944057bc698@infradead.org>

On Wed, Oct 28, 2026 at 01:44:59PM -0700, Randy Dunlap wrote:
> 
> 
> On 10/28/26 1:19 AM, Dmitry Ilvokhin wrote:
> > Commit 22302af28d3f ("cleanup: Annotate guard constructors with
> > nonnull") added the __nonnull_args() macro to wrap the raw compiler
> > attribute, keeping the attribute's quirks in one place rather than
> > open-coded at every call site.
> > 
> > This series replaces the remaining open-coded __attribute__((nonnull))
> > users with __nonnull_args() to standardize nonnull attribute usage
> > across the tree.
> > 
> > Each patch can be applied separately by the respective maintainers. The
> > only dependency is kernel-doc: the string and lib/list_sort patches need
> > patch 1 ("docs: xforms_lists: support __nonnull_args()") in the same
> > release, otherwise strends() and list_sort() drop out of the generated
> > documentation.
> > 
> > Latest Sparse release could not properly parse __nonnull_args() without
> > arguments. Fix was proposed [1] and merged, but until updated version of
> > Sparse will reach wide masses it might trip on __nonnull_args() without
> > arguments.
> > 
> > There are few more instances of __attribute__((nonnull)) usages left in
> > the tools subdirectory, they are perf related copied files and can
> > (should?) be updated separately after this patchset lands.
> > 
> > Build-tested allmodconfig with GCC 11.5.0 and clang 22.1.8.
> 
> What ARCH(es)?

Fair point, I should have mentioned that I run this on x86_64 and
aarch64.

> 
> Did you mean to use such an "old" version of GCC?

There is no grand plan behind that to be honest, I used it, because this
is a version of GCC that comes with CentOS Stream 9 on the box I tested
the change.

To be on the safe side, I checked patchset still builds on GCC 16.2.1 on
allmodconfig x86_64.
