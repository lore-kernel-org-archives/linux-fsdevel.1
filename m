Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.218.42
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793180935;
	b=wBhWEQgx8q1rjsMJTTuiMVc4rtuxsfMLaoy63cWZ7E1Q077x7iZOop6XGIB67/Yp4fIA
	 ae79ng2GwdRgsv5qKV6h3RXLZYTuannRVQp3A/vBvb1X6SFVkN1Dwp7NPF4L5V+BLd9L3
	 dBOKkKnsbmASuSZKPYkhmgI2NF08icHXvqH2aiGda+IQGkLiGxo1s1bR4jVPBCdtwh/Q0
	 LgEMgvw0IHl4Q6M2bId/rsi9xQcHZbLBpTcGLfpleptVhfo5Yui9qTSLmjdclr9/Cunod
	 7AzrsonQ3XtKd/K9F/7cq5oABa1FxJn3tCg3MwQfG2mNQm5IIngyUo8cYiw36cAmCHw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793180935;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=dcY0Gi4dcvyxZkHDA78yGLoz9GDb1HPFjbtFx6GpqEs=;
	b=ZBdEn3bne9AdibeUhoWVGdKUv/HvahwFbHLhihpS1u+7c8mgEIlS4vhscAPQ+YN61Wm5
	 ktTHWvCuljWPW8AKiol4z0MsHiZH/S2gCTbTdH3362ZBzUD7rGOPl9gGKi5RBj+EiX2dh
	 +xdzjOqgFuMhO3eS007353IT4w9eSrCR0LRnFfc70eyu16QOD6fgfyVeyMg9g12fm/VDR
	 qoRolEKy3nPf0xobBkyh1DEF0m7JpEWsQxFX/xXu95mJb27lbpiaXkgaix9bL1xBAkb52
	 jelg076/MRwA98pbr6bvWhhBvs5pqdMqS7f976DpUUxnzXAKfyGQwXF8bIa8DgTg8Rw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Vui6KWrO;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.218.42
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D21DE606A324
	for <linux-fsdevel@vger.kernel.org>; Wed, 28 Oct 2026 09:48:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D21DE606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Vui6KWrO
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-c46d41f6af3so102026166b.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 28 Oct 2026 02:48:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793180933; cv=none;
        d=google.com; s=arc-20260327;
        b=QgEVQS2Z3DmNlvq8vxcJC/+2cYxZYNR2CgCAzkuDhqzET6DsHHFKBB/c1+PwVCTENZ
         pxZDCmur6qNb11Ft3mlqenKdia+lmjPBlL+J8s7KMkfvWL+/WjZuHhLTzPRRBboL6Ve+
         76y+lii7hFBfWKNyRhnA4JiW4+ZYjWGG+78uA/3gEu4IOLTC8GNdXHJr/5NoOyrU3RDR
         tPlkAq9XzCfHZy2Zw6ugdbeL3mFSKRRoo2NBEyIhrgLAHTT2CUyjL5MpSbIaAa3/PWIw
         1nSWABlLugMPcfg6fTrBQeKrjdWsTqRtcPuveDwDbKrXqciXdxkTKECoXncEOIaeKpHT
         G6Pw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=dcY0Gi4dcvyxZkHDA78yGLoz9GDb1HPFjbtFx6GpqEs=;
        fh=tdpLYb1o36rAXTZwKN/rz3X98uYUwy8xyQUsRaW9W18=;
        b=d/NMWABJSYLFkQSyhTsk0CbUJmom0ZDQ3GhYFb/3mrV8k5procxMfaqun5rpjL5TEB
         2nNZDD1A8fVAg2m1NTUTfFB14BBuW8ghLLes3SJMN73eChEt3ssWiHHAC19G7DVa8+km
         PltYihhQyocDilm9fmzxKEbZsjSGfJufXMBS/7+6C0tvmOtpGs5LbcfAmn7tlcYDh2yX
         apXDwa9EE6lELP114am9TYwyuvIBXYSg2SVnFhN+ixDw4zvH2rmqJOkHQ0Qwl/eNeKqY
         6GJS2fmxVfCDe8SvRoDBhyU1pSwhBosHLZmxzwQX4l52lTNlGX9S5JMO4PAsFUDA9vYw
         srXQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793180933; x=1793785733; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=dcY0Gi4dcvyxZkHDA78yGLoz9GDb1HPFjbtFx6GpqEs=;
        b=Vui6KWrO4M0VRNK72Uu/n41uCoswnoTt+s/4QwFSHl7/x7Wwr/LrY3N3cJToCeeoXM
         gjMWLp2yO7pfatfowW3ZvCHPPtkx/53S/09OAgySOYQqlj1GHNRXmPOsjzGdOwkPRw08
         1/E93mARaaQYA60m0E0r3++wEApoTDg4hisWLVZFMzjrGhx6r5bLTJP/d/9noXhRolUh
         YG+kLrJQW9QXS0gd34x62/dM+7wa+NmCevHYC/qS7YEKyxS+fAE1T4fKnUnN/erff9tG
         OvbCtkvj0vDFGT0GdrFXaN8Mc+wQG9Gu3QDE89h3/4MLK25Lx6K4CEO1axqBDwDqaSmX
         AW9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793180933; x=1793785733;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=dcY0Gi4dcvyxZkHDA78yGLoz9GDb1HPFjbtFx6GpqEs=;
        b=H0Kl8ViI9xZgkePtYxFEVO2hmfjccD92WhgE/E82BU4POBeGFAtdim3f5IKDkDE38R
         3xWjzRUiVWaXFoJix7zrkOMxT/uBDaoDjsnCINT7w1bxylQEpE/7GjzWXG3cFrJWpjVl
         jEN8fVBGArJO4O1Ben0Y/PXBPpcaEL44Y7s0wccjTXtMtyLb6A/NSuhlhTgRRF6IiJ8I
         iiEkuevR7ZtdjmIbQyeBhpKlEYoheb+UNSPFYBSpUV2VJflubiCgeLZUYYD+dyekyj/O
         DcFGy1JfLtYxBo/izxxR1tmvUHALUMD6sJw3sDmYQLA++OVQFdSKrVzwIZ3JkbPKoxx9
         sSDA==
X-Forwarded-Encrypted: i=1; AKwUvByXp5ZdrMKRfg2BCMb/WUi0SCEVaEctWXSrIzS83BR1u0F4Ts/LSrbsz2rPjWTGKCfY5un6P1/xgIfnv7a+@vger.kernel.org
X-Gm-Message-State: AFq9FYK9Eyy4OC7TB9WK+WLOiMwaPoDop/VWjGnYlghymublWm8jEwBD
	yuyVoCnd3UOvurEGJXV6Lc+O+xalIw2C1biDV7gh6+ktAzdmS+hv45cO8WkL9PsQoKfWy+f9NY0
	G0ZghhHwDvcZPbMwGyujWxJHYhra53xc=
X-Gm-Gg: AYBFou1npwRn7eotI+N39SlNvbrU4dsyZ+34U91dU6ZnJGicUFXCCfE65SHQLnc7eJ5
	JkaRZ0FOqudScgW8hmCIYQ2ktOMWDC0nEQfr2GaJEYDbHA7gAQUkSAuuBZrfROCpsmlS/2RsVm3
	rJGVgnTsBcp6Y3Ok/55jHob8fX/Htn9YaXn8cSFlYu5TR/Epyx91kiN63jUz7zFBRgMN5EKk/bz
	Aqk11cADinP2IuIslwNdRzUzrv4Rf0v0sTU+/3C+0eRzV4lu5O2Ossah95KXbwp1V83eudxevc/
	l+PHQ+IS2SIblRgxxi7N4nJqOuYrDpNnEpxw+lz2mnLSKGzGjpKqZuKu9MN4qHouMuCoRZdws8I
	VtZlirrJrIaxaI7urcfzT+/A7GqZw6aDZyH/DG922ih53vcRa6YRvj8U67vPQDQvtTOJAKvD6ww
	6XKSQH9PNXMOfAZXU6eCzhYXfqE7djxcQ1S7eMJw5r7E7cJSRsff5qH92hwRuKv5xopnP6QOy4O
	7SqiBHJ8RwC+E4fvUSRcAhaqQ==
X-Received: by 2002:a17:907:a893:b0:c46:8b51:c17c with SMTP id
 a640c23a62f3a-c49bdf394e6mr156034066b.17.1793180933042; Wed, 28 Oct 2026
 02:48:53 -0700 (PDT)
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <cover.1793027261.git.d@ilvokhin.com> <f0d7b2f0dce916f4cde3dd466a5b51a4b88fbdd8.1793027261.git.d@ilvokhin.com>
In-Reply-To: <f0d7b2f0dce916f4cde3dd466a5b51a4b88fbdd8.1793027261.git.d@ilvokhin.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Wed, 28 Oct 2026 11:48:16 +0200
X-Gm-Features: AclHuK9bqVSr5ebQZT2ja4gGk1wmv0GUJ0T7y7aJfJNVsg1OI_1bv2lVUKDS3Hk
Message-ID: <CAHp75VfJ-L5ELAttN+Fz_Co2E1KHumwLZAEMXFMhRubzgVLqug@mail.gmail.com>
Subject: Re: [PATCH 02/10] string: Switch to __nonnull_args() macro
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
> Replace __attribute__((nonnull)) with __nonnull_args() to
> standardize nonnull attribute usage across the tree and keep the
> attribute's quirks in one place rather than open-coded at every call
> site.

Reviewed-by: Andy Shevchenko <andy@kernel.org>

--=20
With Best Regards,
Andy Shevchenko
