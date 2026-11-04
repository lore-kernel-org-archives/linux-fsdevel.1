Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.51
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793816744;
	b=KnTqRwsxE38WzTZOUicMfCLX9jUPWJeTCvF2jbyDdvcJIenptJmfx5MPx1iIKPsvl4QE
	 uv6nuFUbYZVw6Y+VVO+uIaTE52Z4LQOpNQg0TUU60P8nv8kIyt1vbwYb4YR3h+mLqN9q9
	 gpWEAjQ3yzQElug1LlmLpD+usqFvu0t8LyprgrdOyuGJsbECBai08APSbTBMpIynzFpLY
	 FlbbXA86fZixWsfhqOdfK23y8WrZcmBsGdM09uXREC5JX08cVYGdBNZ/1poLx+80qXSCL
	 5+3TBR/8RKMWWc5gu+trwSZTPScWHmS5C64LFEbzMahg51r/IApPXysuucfnzHYMT4A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793816744;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Date:From:To:Cc:
	 Subject:Message-ID:MIME-Version:Content-Type:Content-Disposition;
	bh=fptg/GN9hp3PA+p/fi4U4fZU1Oq/WcTwcwO03y32q8c=;
	b=P8JU9QgraVoKIJXhNgXBUTSYp5wx/UoEBK0xETXcOKuS3WtgeBsFt4Wvy1IdbtHzB9L+
	 yzNnLp83DZ2sPsrBkZDynYuVwpl0X48Qqf0S4EXkw28fEvgNOCUYs/JhYCNy/njl9rpaS
	 wXMG8cCOuRh1lqK2T7N5C6VaogDF0YnSVeldcssHLQyvDz26NHAcq/q7t1Bs0g/rLrcmZ
	 wYrwxnBchrYCJXFYNYWwMUoayPEiS321N0CT4pKJ+NDRO+lvKbsLWRE++zCl905DSCOTS
	 UZSE1clAdrHJD5iOYjpz/ZM46U/ixAkmy0yf2BGn4WddYWqVs9VKreoZEFg6NG1Nacg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=RtiBVlUa;
	arc=none smtp.remote-ip=209.85.128.51
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C6B6606A33A
	for <linux-fsdevel@vger.kernel.org>; Wed,  4 Nov 2026 18:25:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7C6B6606A33A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=RtiBVlUa
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-4a215e64962so9996335e9.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 04 Nov 2026 10:25:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793816743; x=1794421543; darn=vger.kernel.org;
        h=content-disposition:content-type:mime-version:message-id:subject:cc
         :to:from:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=fptg/GN9hp3PA+p/fi4U4fZU1Oq/WcTwcwO03y32q8c=;
        b=RtiBVlUapp2BD5jpqUoc2UgPlRWeu3VomA8/dYgkxVkFsxCaggIFbJf0fdGKNeExGB
         F1Pd8Uzs0ds61GnXPpcy547rROKrX2VDLBaQpuvBWU/wevPBG9ym2Azi5miKq2wmpFr9
         XRrTFZtoru0ll4TXBICUTQMX2v/XWTHWgilcmoVyVDBaAPdnBkQn5vweOH9MvKGIKvU0
         c4uBUn2C5P3bZhlrcPmHRpeZLfOZEm0bL9db/MSaivkkNUP+YIetV0KEYo0SXkmDyerA
         Pn9GbEe/cXzsrsqZMeOB/d2pi5LMb9m8eU1G18nBHkk5Em0uEn/+cLdRc1YQ7JXgzSLl
         qedw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793816743; x=1794421543;
        h=content-disposition:content-type:mime-version:message-id:subject:cc
         :to:from:date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=fptg/GN9hp3PA+p/fi4U4fZU1Oq/WcTwcwO03y32q8c=;
        b=Qa3lj0zV/v7jV1GlK6SM+l4aa14FHsskAHEskj58RHVmUA8iP1xxv4Kc1gnS9Febb9
         0/6fochT6NA8HSYVoaOLKwONmOKbL38Xg7PUyDgi8kgAEvS/2nEb74J17BMz6Etx2yXN
         W6vbDhyQZEukKLW8mjjNJITgy1FAYhC+JrlAhbQ81yjKQkv/gh9JVrJ70rhGLMk0K+dt
         U4F3sfUj4J/BgNaZhI2anlReGFahitoxiNZSNYmuyuqwvQK74c4RrwUKSfO6+iTrpgnj
         iOI1WM6KGDfpvbLtFAtH7+liIm13DUAOqVCJFZlCRM1Ofdg0yMoaIaru5sOD7c3DAapn
         WIGA==
X-Gm-Message-State: APuU4Z/eZcVg6u2NNjtYRG8EoXvLauce82Kt/fU7AaVymkrBUY2Nhk9b
	KUx9qds5LPHIcpyk5JRXDeCr5KnVdetUo1o577XaEYBbiywWIaVLkm0=
X-Gm-Gg: AYBFou3I7jNU+Cmco2FDJVnqJ4xh3q21lIb9mxTdMMsiGQYbjjdy/mMFLSV7ZkvWjY0
	iqQu0kqdnNgPmS1rFNnsWsYsQ0Y33t0Rdj0r7CF+kaN951T0tz9SSLjPPQM8Lr8SbTGbVrE2B8E
	SVKty/PJKcs95kB/TXCwmGU7trIHFAj1MVul00UzOLNqvlnAKOEQy+xkjJaGwFzxEsy6EeX7Hxc
	eMfrU2FL3gjABUi9UTK8q/le4XqcYEoY3yFL+USmUGxW35h9EF6Pf9ghCCTpp2Uylz+zpAHsQKG
	ycCUqIRvxPQ4z+CUIQdC2QKBiQi6mqibsNWZYJe6snzwIvW6Y5kwJ1lwjP+eAw1wpsfEjZdPIs4
	UVUjpDrlF1070xRjNBV2qLP+RN4v8XPZQzK3h+fOgl8ZRNz3EtQ9mlmR6lUPyZEtrEZt7VdZq77
	oX9lsmmzrA1ln/eAWHWS73OlI2n/XxDEve54ULlNA87MeBSumIgVuFODJyhiqjCWRV/1dHdFJ8Y
	nbxvhKrGm3Zj6lBCe19vXtzb+sBq7OKwGUtDi28ZwG9EAYou0OIVsdLuxJxIC+yLxv6RCYKq0b7
	zTMqRa+zXfi7GBY=
X-Received: by 2002:a05:600c:c87:b0:4a8:cb23:f71b with SMTP id 5b1f17b1804b1-4ac186b1a2amr391659435e9.18.1793816742817;
        Wed, 04 Nov 2026 10:25:42 -0800 (PST)
Received: from p183 ([178.172.146.10])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4b4533873f0sm68175905e9.4.2026.11.04.10.25.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Nov 2026 10:25:42 -0800 (PST)
Date: Wed, 4 Nov 2026 21:25:40 +0300
From: Alexey Dobriyan <adobriyan@gmail.com>
To: Christian Brauner <brauner@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org
Subject: Re: [PATCH RFC 17/38] net: pktgen: reject device names with a '/'
Message-ID: <0233f936-1086-4b57-ab09-b49018e34361@p183>
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

> --- a/net/core/pktgen.c
> +++ b/net/core/pktgen.c
> @@ -3831,6 +3831,10 @@ static int pktgen_add_device(struct pktgen_thread *t, const char *ifname)
> +	/* The name becomes the name of a file in /proc/net/pktgen. */
> +	if (strchr(ifname, '/'))
> +		return -EINVAL;

I posted string_is_vfs_ready() to catch dots as well but it disappeared somewhere:
https://lore.kernel.org/linux-fsdevel/vqeq3ioklrgrf227zgdfho4virh74qrt5reoyptmzgktyronbr@c2mw32pqikft/

	./../alexey
