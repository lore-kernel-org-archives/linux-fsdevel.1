Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.218.52
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793180883;
	b=KK0Spw8Go4GTcWMdCrNHyV0MTznl6q6PcQMfnwIc0kNkgtGHttuywHzAZFVJIZQTE664
	 uzdkbgA/x3wiaoVkIGzVwzq6anM5Wuwh+1rI4MVvcCqlg1yWGGC5ZM0Zhgc+3/iF6gPwV
	 ANp6hX5/1w1wkIN83Xe2Ya3tSZXtvAh59Kqt2Owk6nuoyqVeunKoA9crnjMx9CAbdetDW
	 Uhh4xgpEPnidYy9lsifctxJsjjghiYFdOJIAKP1rYKHZauzwXfTewe87GXh3BzASevBxM
	 +V6KwKFWJhBECJTpYTjjTgHN4rW6yiKX1dSF13YwgWLC7282oJ9j7WwwX6tDTLQN6ZQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793180883;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=Gl/4Yc6JnTMakWEbHOettwInvSk+aSwCfPGu2bGV6uw=;
	b=FrbGozRRX3I6tFFY6COxLf0IM+y6RDn+DNNZ5l5V3u32HBhVHCSgfhdt+ONvSJPqz8AH
	 rdRv9FsnQwkuWSsDy2pL2D+E9BKycU3dxh7jds11UFK84dBi1bThi1H7nY/hxPo/QfrcI
	 MSzVILLX0MbMifSVOvrRJSzAQNpnhjzLaWyjTLkbtHbZjtunruS3qcnq1r4n33kESJSb5
	 zADmCAZjKvJzWL+b/vH83WHCUD/vdAoO1nJS3xK9II1Na4Jk4R1CsxHXlhMf8x7IfWpai
	 qAW25bazyXea2xUIfBInYevGh6bAvxm4DnThZCgZ0l8dlYs16goltYBAQXI5M7GhRlA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=zJw6mAzl;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.218.52
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC8A3606A324
	for <linux-fsdevel@vger.kernel.org>; Wed, 28 Oct 2026 09:48:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BC8A3606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=zJw6mAzl
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-c169ae1cb26so286655266b.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 28 Oct 2026 02:48:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793180881; cv=none;
        d=google.com; s=arc-20260327;
        b=ApQoLUpzSvwBo60Vuf8GAh9pVFLc2eaSiBBTGB2RVpXxDfosvVc6PWuWvjh3cUtaQ7
         x0D3pflQsfg8O21eS/5m/j75SAAbt//E471KOyiyKPeByLBs0YXcBHL2lrkjA5OKadJR
         uZYph5LyJ6rndDuVmWo2eoGoPSZMFJdF9iFzfxIwXEtX5hgifzsFFy7G5eBMY8FpflVp
         ayODIcAhJU1K/d2SCcmH6ymPHlKvQIglSdpTQkFCVSY6HRTt0Di/561Xiqu+8v0UgXdo
         ij9wcgCnrM+DepTSSh8ZIxvrtL0JZALO8YNQLmlJMMayrNMz4HCly0PL+2peUWCXsk+y
         TxuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Gl/4Yc6JnTMakWEbHOettwInvSk+aSwCfPGu2bGV6uw=;
        fh=LqAaOMxx2lSrW5HqFBeo9QnIoq5cek0vAqMJop+ToyI=;
        b=f6uL7e4F0jbOfIy2V8kSEqpQpBZ34tI3HKghStNCYEuQRZo9N1/tkgIO8kDa6lg6Du
         /KluBABL4mVccokZCnNmNCGgSixMoFz3loPC8u/Kzrs98LCAWi/Gxkk19MJD5MyjBZXb
         4kVYf+1nBeD/ZofBsEtnih4juyeBYKgN0dVWLVA2+AQv12mTu4PxVtUBIeFYjjEMTPWm
         2vH2tOJSThXzrlet4xYylg59S1PLgAIsOjfjGWtx7jisNjbQjNh0LtMoBZmn9Kxq0DIE
         1ebe/4K3i387SE0hcO1lcB5WZ4VcGT+2KN7labdBZYs7gEFYPqkuxtnmb+953O3ioKFx
         mrLA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793180881; x=1793785681; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Gl/4Yc6JnTMakWEbHOettwInvSk+aSwCfPGu2bGV6uw=;
        b=zJw6mAzldYFqYZzdqrK5sVCjCWQPQmTep1dLeDCOodLgldWlrkclOGlwaZnjuK1Oum
         TPJIIs//JWN7qNyOHlCsUAdJNutM2b52i0HJOialjxTrWs4keZvZmw3BRcoJU4Awqzjr
         WT7ZIhJrd4c9JQzrTY2yU8wr3bsllD1F4CAiDQBfntXs5r47SzlK8X0ezxzisTf0fyLH
         V2m79FTBz5/Q8KkYGms7kGw/9UPrH+YveHnhAh0ujkqjlAJ55dCcMHh8t8hYyve2EZ4W
         CPhdOdeH9FP4wI1+y2tqcuYKKYhDPN/HKsHrz7f0EKP2g/ydwoE9hgBJKjkE88fNdPU0
         JRLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793180881; x=1793785681;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Gl/4Yc6JnTMakWEbHOettwInvSk+aSwCfPGu2bGV6uw=;
        b=JWDQVKxFrC2WRfbnRPHZXK5x4oqjEWQBTi/MveNJNlErobPshjKqQG5h4hgnDPkOOj
         /WSVeq9Rmmi4kxAJJ5syJxTlDfEqAIofgZqZIFdF84KClnXqKXFkT9oDl0OShWMm3HZ4
         drQ43OZbXjPv4APFfw4WiRvKbstofAzZIN9d5TYJZhS5Jb/FvGXidOCOkgzYRVTtSR0K
         WexWESCfPkiuUYrrTpPuO+hh2V0CZk0Rk/LyH4SFm3EqMSaqXtppl/hdEXBqTme8uQqp
         9ddyaOf7DCXOxrtJNqE8KWTnjOtFOm8/Ao/AkVtkYUrkQkY7ziZx+9xJIXOqOiYWPUCb
         lxGQ==
X-Forwarded-Encrypted: i=1; AKwUvBxmuCAFwb1AvQ9tDepC+qZ/p2nLwz4Ued9C6NKWDBhiYGzmLCnaM+v3dFfAjzaI8oFVeMyZzXoSSDiE0iKH@vger.kernel.org
X-Gm-Message-State: AFq9FYL/sXgJ+mwdwwmRjJ85uMgkwH0IN45Cjw1Y3do1tcr4R4dp/HsR
	eOcdaDgZe6ONCR4Bb4xxCD3LYKVFuyl/V5AFrp1Qt4qBpnmm67zYrgtGgcUezdtcDgXlInd1O+4
	8A6jUupmucJABDnYX3AG1DmlRAsE9tcU=
X-Gm-Gg: AYBFou01czjM7A9F0j37uUznCzRqcYDVIEX5LL3ahxLHVtvLzqg+Q0IQpM6VuHXuxer
	vDhncBzufM3ktMgh8KBcK7kslezLZxSSUTg6fZ11h8hy6boi2c+2VuZwDF1ekCxW79JWnbMZbWJ
	P+PeMCXHiWxXkUiNEk+tnDw2sm6+9QL31JYp+CeBUhHkg4Gqe81ow5CLeNfDETwQcB1bYjLxECt
	/IVEeZ9yxAlfEa7PY/hbsJhxJhwPoNlFDDx98e1Mv2sQdK9+6I/Rs2VDfG1h8suO5C371HwcVER
	nxsP3HGw/bsVYeZCcue8qYF2Xp+Qey7pkmrg5zQKwB/C44IpFCa5k+dF8KQ39iQnNzHKCDrv+3n
	pLOtFJJJnt5Jra3aDyiVBI3cpEwqIwNF5tM5NVTeqX2kpq4mES+86H+WLGH6BlTwx1v7bKxVDXp
	fxkho/At/Oob4jLV00d+z46kTphTct9M2HcwnC1BM8lcdo2Ua8bffniW/tZ8osyc/CEEHRuHVR2
	yEQys8HRX0Z1vh6BOEjVzcA8w==
X-Received: by 2002:a17:907:86a5:b0:c25:f7db:4bec with SMTP id
 a640c23a62f3a-c49c6357d34mr69949566b.18.1793180881026; Wed, 28 Oct 2026
 02:48:01 -0700 (PDT)
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <cover.1793027261.git.d@ilvokhin.com> <580fdfbe2eb6694438cbd8f5337bd2f1edac564b.1793027261.git.d@ilvokhin.com>
In-Reply-To: <580fdfbe2eb6694438cbd8f5337bd2f1edac564b.1793027261.git.d@ilvokhin.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Wed, 28 Oct 2026 11:47:24 +0200
X-Gm-Features: AclHuK-8N84O0Y9k-BLOPVpeywTja7886uZe3ugxN4eM-96m__IvC7bzZgS0MkU
Message-ID: <CAHp75Vedr5J1WJMrAkBjRSLKA_zf1kt3GD6UhjzLcy9vowxnaA@mail.gmail.com>
Subject: Re: [PATCH 03/10] lib/list_sort: Switch to __nonnull_args() macro
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
>
> Add spaces after the commas in the __nonnull_args() argument list to
> follow the usual coding style (according to checkpatch).

Reviewed-by: Andy Shevchenko <andy@kernel.org>

--=20
With Best Regards,
Andy Shevchenko
