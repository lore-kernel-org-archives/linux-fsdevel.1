Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.52
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793181021;
	b=VWrw2pTV4vlNBkE+X1MkUZa45szt4J4WF7AqhIN72C1PQhQ9ncTfXRcICvwjcpDoICsw
	 Y2Gj4m4l4gRCUX0rZA6+BdpiTzfLA3g3FC5Tz2vCw+bl6Nz1l+uPS/zgc/3gFQ0ARrkWJ
	 C4Wo6OB33DnBYnOvIUYdeWRsf7A3+092Joja+Swz+4mkrSYqZgTLgYXtFJzr/Eswfe2rp
	 RE9kuaa2nHLGptBTK4j/h8cufy+Bb/N8ai5PhGNLqdXtMdwqWgzj4dFcZ2x6e4eaCc80z
	 s9f1rIspfcAh5GKXrchS3UFySAHpeTJUNSEiVH0M23IY3SJe3jYpVnz8Yfpd3pe9frg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793181021;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=OncitmhmKPxQRhu8FlY/GIP5U4Gt08ht3PeyL8T2LDg=;
	b=m0UVlqxeKYhZJRm5MELktjcxmroBU3JZmo3bIMIyqf2S9te6bawmBs2DjTSgvdDLvm+y
	 xPiUVBBd+XBAx4/bO9E4rsK9YOQb2PSPmqzP6X53nn5WpvqgbjLQzktRWIeyQ0NlmKbYM
	 YQ2kii64pZShGtxFY2W3o0EqR825jcjY7k1a1dwC0M57jkKJ1Erf87T3YhWEwytUenbyq
	 T1Fcf8SxZGiVp2NTDB1BXKwgmDUC3ybfeoL9hizEjDq+japjGy2x8UOkTUBMbGD+sEU7g
	 4y2vtiymwuYSm4cXw1bGGw8iT1h/dTJiT87fz7c6POm6StZxIeKLdOJdwmNVnuiM9Bw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Po+tkBhH;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.52
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C10FF606A335
	for <linux-fsdevel@vger.kernel.org>; Wed, 28 Oct 2026 09:50:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C10FF606A335
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Po+tkBhH
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-6b1aa27963eso2865233a12.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 28 Oct 2026 02:50:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793181019; cv=none;
        d=google.com; s=arc-20260327;
        b=GZyhWUoRI+SmY1m5SSO3m+ZAqzk36aVka8tjKZpTULYUFNLioJaqWoTyrVw17EsmJ3
         V07t6zK2fQ95OyLgdp/anw6PkYiU4TIQLF6lP1wDeVjgPDjRpYYiim3vsph9NfJCmE4u
         PaJJSHW+7A2MehWWXw/a6m2P/wzyBP3gbnEjB5fCZVWsk3tU8H6AJqRDXkkgLM4gQzMg
         4iw9m36UN4X/nkg8BG1cSFl7qX9fMFwkQQssMhX7N6huFHK0/6y4+FuZMjxc0f1aaCc6
         6Q4Y53X/2XEi3OZAatqH4Pp6BSWrPpIvMI9/ERJGUcwIhbnKPNHyc+kuKyBEuNJMh0vH
         sl0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=OncitmhmKPxQRhu8FlY/GIP5U4Gt08ht3PeyL8T2LDg=;
        fh=dHl249S/Hhzol5hxaLoPADoiRJNY2/aNwhAYQ4yD+qI=;
        b=qxcPqu+QnST53RBzd/G/3t1/71aG+eMCCUYV42KgjoEKJ5BgbQNow/t0u0xG9kc7yB
         4+jguhd7KE6jh6vz8zLHMfZ+SLulst7pZ/BhYXI7ZdRrUz8YTbwu72wD1Re3kUlczpMr
         lvmaeKlQvU5jbXPJ37R41saMZh5z2/5nF2utxfSnOZKATEQuCa8fMTskQLu5qP60ovim
         9xRWQPhHC/YOPnI35QBOIGvNLYoFL1jv/nF8jN73oLrArYe8VUi+OBealnF1X/XPoD5z
         eLb0m0n4Tihgls9ZCrRMyvz73VPB9Db8p7z3JLpBkvL2GZMtAwbDSbVZT+u4ZtPcyaE9
         wHGw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793181019; x=1793785819; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=OncitmhmKPxQRhu8FlY/GIP5U4Gt08ht3PeyL8T2LDg=;
        b=Po+tkBhHSAxqEHwLFlZ/dUO+MJX4kBmJcMJ72/CBTwKDm72BzNBiMEteALPgfbyNoP
         EzBjYCRyohCnJfUhTv7oF1MACYHopGGCSjOQ6AazrqyebZD9uRI6Ayr5dej4TDUM4dlt
         SXymOqJpD4azna2aSzuZrbEp4Lwg6lVAvMmnKhE8Jgl/LQsXxfn1L3AWnI0S+lFXopYE
         GOgNNvE45nthasHpbdgbf74OgLbSrrfaJWK7r2jXh+PEfaeIx1GrmaA8Q6XsabUHVALV
         5xyPXXcFo+JPCjrfzKLTnwjN4I5ZzTw08NB2P3kl8K8jQ2pAiA05GHlZledigQ/6uRPm
         L8TQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793181019; x=1793785819;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=OncitmhmKPxQRhu8FlY/GIP5U4Gt08ht3PeyL8T2LDg=;
        b=triPBasJ27FeRjOSVA5ys0LVzCEt+XZfcax5X/bxkUDn5bYO9ueBQQ1gkUiqKlawY+
         F+S9AHQH5LiushlyefiAXLMtU5wY6DGER59uSbyD7LegFTcz2Gfv23te4HYNS/T3K+OP
         uKbRzJ5JoqRCgWAIDFXiRlbowH3cB+4CUBTeO+gP4Okhp4XABF6sNG+3Lzm8l0zwIGe4
         xan4mQc9KBY9t1OlXfCW1Bwoslg+WhrgtLd0fGD9w1T3U6qTAOilW/UbUffAlaVZZK2q
         HSC2NqS31SVgI4TiEGeq29H+vKr7qzTllH7XJDNXYwX5yIQbar+LHPdIxA4TQlqr5BHt
         5GqA==
X-Forwarded-Encrypted: i=1; AKwUvBxZXy2IHL/reTYkiErmMGsTx75kFgE/sPx/J2FlrJ87PQLVMD50itg+r+3DvjFG4yxgIl2r327vTqsekHIN@vger.kernel.org
X-Gm-Message-State: AFq9FYJERlxMhFB37meDUbSIRNBK7S5h1DTN/ygZAG+lB2/EgJP9GP4r
	Z0HrWCOxwKr4YELAPVB4awl2Au23s3JGssSgsAC4B/uLpduhndFXZ7RgcBn5aJvteNVGIRcX/t5
	5QNKJqcV4R4AqkaVmF/kZbx8R4vQFV0E=
X-Gm-Gg: AYBFou1Baxc3W7f32d+OVTiAwvETSslEp4Wb9XNfXyDQ+GsiS+ZXsCc9t1cBu5fouh4
	6XhWOiE99vdCn1DyTZGmX7qvsgbISftgiv5vIOIxp9pgczMMTyXo//ufapvbr4OwbPbOi556HtC
	Il6H1Ulda6MCA4WF+5iYBxDKieSNjsgoMnHAw+lhH25rHQ0/AuSBQjuayamhPwOLGkADJ/lURm4
	aur21pLUAn2d499GYPdUuzvbdJzBRQbJui7SZ8g0ICUva4HjfapyMWLF75TMcrdt8hcpcbxjYhP
	VgI+uEgqk80vO5iO+c4AeTZ6rgGp3kYL9CKJ9Rr8MHwl2d3MGHz/sFSLtu7ArbzjN+U6Y23pGx3
	nlh2jt9DQwnWhiYkm++fMfYJVA0Q1GKMc7bSgka+p8A6Ans+9O0zqkfgndmrywooNTfGtNBtxUb
	61UP7tFM8EWHRSZtdc5UAeKxQLdO1Kl1gR2eyEXidIOWWqFNvToO4d3ZsNDsUEIq0ogHn3PhzJi
	wpVHZvlU8jEEmdtUf2AwCnZtILIdQ860ts/QvRz2hKuBxk=
X-Received: by 2002:a17:907:86a9:b0:c48:a838:c17e with SMTP id
 a640c23a62f3a-c49a739f8dfmr484567766b.14.1793181019107; Wed, 28 Oct 2026
 02:50:19 -0700 (PDT)
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <cover.1793027261.git.d@ilvokhin.com> <33ec8080594f9f4ef1d50e36497339c9a6897393.1793027261.git.d@ilvokhin.com>
In-Reply-To: <33ec8080594f9f4ef1d50e36497339c9a6897393.1793027261.git.d@ilvokhin.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Wed, 28 Oct 2026 11:49:43 +0200
X-Gm-Features: AclHuK92we6zl1A1tCfKfYVeuXltUG4Bsfa-fRzr4orRkDVhJuYkTUAxt0MOtcM
Message-ID: <CAHp75VfR2i_PPZwSG2UPaxShU5L=FsSdEAT+0iUMDKAfugbRsQ@mail.gmail.com>
Subject: Re: [PATCH 05/10] drm/i915: switch to __nonnull_args() macro
To: Dmitry Ilvokhin <d@ilvokhin.com>
Cc: Alex Deucher <alexander.deucher@amd.com>, 
	=?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
	Jani Nikula <jani.nikula@linux.intel.com>, 
	Joonas Lahtinen <joonas.lahtinen@linux.intel.com>, Rodrigo Vivi <rodrigo.vivi@intel.com>, 
	Tvrtko Ursulin <tursulin@ursulin.net>, Lee Jones <lee@kernel.org>, Pavel Machek <pavel@kernel.org>, 
	Joel Stanley <joel@jms.id.au>, Andrew Jeffery <andrew@codeconstruct.com.au>, 
	Ryan Chen <ryan_chen@aspeedtech.com>, Billy Tsai <billy_tsai@aspeedtech.com>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, Kees Cook <kees@kernel.org>, Andy Shevchenko <andy@kernel.org>, 
	Matthew Wilcox <willy@infradead.org>, Andrew Morton <akpm@linux-foundation.org>, 
	Andy Whitcroft <apw@canonical.com>, Joe Perches <joe@perches.com>, Jonathan Corbet <corbet@lwn.net>, 
	Shuah Khan <skhan@linuxfoundation.org>, Randy Dunlap <rdunlap@infradead.org>, 
	amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org, 
	linux-kernel@vger.kernel.org, intel-gfx@lists.freedesktop.org, 
	linux-leds@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-aspeed@lists.ozlabs.org, linux-hardening@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, linux-doc@vger.kernel.org, 
	Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 28, 2026 at 10:20=E2=80=AFAM Dmitry Ilvokhin <d@ilvokhin.com> w=
rote:
>
> Commit 22302af28d3f ("cleanup: Annotate guard constructors with
> nonnull") added the macro __nonnull_args() to wrap raw compiler
> attribute.
>
> Replace __attribute__((nonnull)) with __nonnull_args() to standardize
> nonnull attribute usage across the tree and keep the attribute's quirks
> in one place rather than open-coded at every call site.

Reviewed-by: Andy Shevchenko <andy@kernel.org>

--=20
With Best Regards,
Andy Shevchenko
