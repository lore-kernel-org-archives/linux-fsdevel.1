Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=178.62.254.231
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793279531;
	b=ci/4bk8RrhcajPRoF8cIqyR+HY4wC2DELLWPvb+33Z7yj2Z81a4l6yTvzXuqWA2p5Mn3
	 r4Rvyp81z6UasvWTjz9Sm6Q60h5oobZutipTFf3kBEEYSOPMSr8Z1/QGqHLBX/5w+fgz/
	 Mot4Fo/nvcAERMIDvAZzNw/dnfwYbY2VihkLoxXmBa5LVv3n9Q8OpaTttTh2WweREYY/u
	 aEa9/YD+33apekwQ5Csw7Gu5I7e/ZmBJVkpjC0UbFhhvXd6g2dsgxlBTyBn+YChXmhCO9
	 s8xJwi6JPs9hXxX1GBH7hZHLO38vERF/oIjMEO9ceUKWty/h1VD9etQsnmy3kjNFkVQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793279531;
	h=DMARC-Filter:DKIM-Signature:Received:Date:From:To:Cc:Subject:
	 Message-ID:References:MIME-Version:Content-Type:Content-Disposition:
	 Content-Transfer-Encoding:In-Reply-To;
	bh=4cruogtXfNCOrJCvoodcyrTOzahFlsASVgaus3wd4bs=;
	b=eJnPDP45fnF2qA72UoJgn1/S7WQaiqnE61IMycmxojiKnygf+8WeT7yJxFq8CU/jnDyI
	 CnPGdfYKbQmmi2PZDpNoF6KT4ACVumUiMTDh1ihfYQNrF612ctfqCaoL5/wFK05i/B+LD
	 B/MygM5cUE1Prx+gPlduSDjreHTAi9tGTlZ8CsBfRfA/u4IjmbpboAs03Hb1eQbFLPbsW
	 a5ktox7X/gULTt2u3eIMplTRimv8VXT9lwo41dR1GrO/BP5XCiAalSZ3vQn58huolgx+I
	 sw9hmN4MznFSUKapPbvu8Am42fzhlaYsWTPffeYojAoQwc2VsbqXknSL9UJAmMxQEyQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=ilvokhin.com;
	spf=pass smtp.mailfrom=ilvokhin.com;
	dkim=pass header.d=ilvokhin.com header.i=@ilvokhin.com header.a=rsa-sha256 header.s=mail header.b=vALBjl5t;
	arc=none smtp.remote-ip=178.62.254.231
Received: from mail.ilvokhin.com (mail.ilvokhin.com [178.62.254.231])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B701D606A31A;
	Thu, 29 Oct 2026 13:12:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B701D606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ilvokhin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ilvokhin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=ilvokhin.com header.i=@ilvokhin.com header.a=rsa-sha256 header.s=mail header.b=vALBjl5t
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ilvokhin.com;
	s=mail; t=1793279528;
	bh=4cruogtXfNCOrJCvoodcyrTOzahFlsASVgaus3wd4bs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=vALBjl5tg/HLHwAe5LnWN0I+FZe/ilBHT2lZAbbXATHMbz98KZlNi97W3j84M5MIm
	 EgXRxUJW0KRszvy4pqxbaKoourAWAFiwAZJY+Ct2Jbwg3k04WPlzyGUItH+c8SnyYr
	 SQLCcctV6enovEyNRJB4QlV0k1lXcskW58pkHYoY=
Received: from shell.ilvokhin.com (shell.ilvokhin.com [138.68.190.75])
	(Authenticated sender: d@ilvokhin.com)
	by mail.ilvokhin.com (Postfix) with ESMTPSA id D6809101233;
	Thu, 29 Oct 2026 13:12:07 +0000 (UTC)
Date: Thu, 29 Oct 2026 13:12:06 +0000
From: Dmitry Ilvokhin <d@ilvokhin.com>
To: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc: Thomas Zimmermann <tzimmermann@suse.de>,
	Alex Deucher <alexander.deucher@amd.com>,
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
	Maxime Ripard <mripard@kernel.org>, Kees Cook <kees@kernel.org>,
	Andy Shevchenko <andy@kernel.org>,
	Matthew Wilcox <willy@infradead.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Andy Whitcroft <apw@canonical.com>, Joe Perches <joe@perches.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Randy Dunlap <rdunlap@infradead.org>, amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
	intel-gfx@lists.freedesktop.org, linux-leds@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-aspeed@lists.ozlabs.org,
	linux-hardening@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org, linux-doc@vger.kernel.org
Subject: Re: [PATCH 07/10] drm/gem: Switch to __nonnull_args() macro
Message-ID: <auNGJhSe3tVi7rDy@shell.ilvokhin.com>
References: <cover.1793027261.git.d@ilvokhin.com>
 <5bfdc1491d297b5e98cf42322c790f06481c28c7.1793027261.git.d@ilvokhin.com>
 <fb3b6a24-74ca-4da8-8593-352afd515313@suse.de>
 <CANiq72mMm75svCqevd8fHtVoczDpvpo4NwL0SC8=bWy030vQuQ@mail.gmail.com>
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CANiq72mMm75svCqevd8fHtVoczDpvpo4NwL0SC8=bWy030vQuQ@mail.gmail.com>

On Thu, Oct 29, 2026 at 02:00:28PM +0100, Miguel Ojeda wrote:
> On Thu, Oct 29, 2026 at 8:32 AM Thomas Zimmermann <tzimmermann@suse.de> wrote:
> >
> > Should gem.h now include <linux/compiler_attributes.h> ?
> 
> No, it should be included for you (unless you are doing something
> custom with the compiler flags etc.).

Just to add a bit more colour to Miguel's reply.

I believe idea behind include/linux/compiler_attributes.h is to make
attribute wrappers as simple and transparent to use as native compiler
attributes. In particular, this means they should be available in every
kernel compilation unit without any additional effort.

For this reason, all the nessesary plumbing is handled at the build
machinery level (see scripts/Makefile.lib:171), where '-include'
compiler flag is used to pull in include/linux/compiler_types.h, which
in turn pulls include/linux/compiler_attributes.h.
