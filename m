Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.221.41
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795115701;
	b=poltovXS91QOa9E+0LSazRn1SKryNAci3myoxNrp1VoOoAAYD7aQsgyCtfsj/luBq+GJ
	 YIg/3AQ4NSzDIry0UJPgOGJ+N6AZhjlw6JW2+SqBfOX/ZWrTpCyyC6aFYBKtKSxjIC0je
	 moFqwR5r0B4SXXAxtg2Q5avkp2Vsfcu0fRsuDWHrN9CO5T9SayS50M+C/c6kNSF8oJeF4
	 6CQ/AGdNcL1BUY1+Zqif6K85hLxAmcPI2Ayv9bPhLMSpME+USFOeqeVqEA+bzzVsbelVt
	 hO7jAAsFEIOMbF5V0hHa3zmlj2TDIGLJBq35Lg39k4OE/Luyb1V0OS0ibpxW4DspZyg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795115701;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=ZfGNZp0FqXRF14R2lEvSl2W+3CYQf21jFvNPi6RI+VM=;
	b=m2jytTehQxrgIZFcLqPYa1InBLpaq6S0HCr7qGJMs9PiwsTLp9Z+nizV4eMT0QATU40X
	 x7/M9DlvfESoOc7Lrec2fxiJwDDfltOQHD9g15FuoI7htxbJfq65BULpSBgklsgR4NezV
	 9fECVI9jPTkFrU+uWb7PDa53ZDFYUTymdGi3LyBGdSOv0qY/iSpGnkHC8Lx6C92kn4vvI
	 eWbupaBaNuowKOBcR+cRhQnbPITlvbIz2WWt4Tf4Ub0M0ecYDGXV5ann5y+t6FGK3h9qh
	 4XEiKVSM/zt0TRZzW2uG4DF2AghmAl+l4/udcrgs9sdJv89zZtrdzrd5aAFYHq9CGJQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=BM8VDiiC;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.221.41
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22B4E606A330
	for <linux-fsdevel@vger.kernel.org>; Thu, 19 Nov 2026 19:15:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 22B4E606A330
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=BM8VDiiC
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-4a3e706b5dfso24486f8f.2
        for <linux-fsdevel@vger.kernel.org>; Thu, 19 Nov 2026 11:15:00 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795115699; cv=none;
        d=google.com; s=arc-20260327;
        b=h92Pt+ZAfX0ZZMIojwIpBVZT+pOqcQ+mqksilvoBChLEyBEdV+Oat6VwBoj+73Urbe
         0I81bh4jdbJssrtXoeAvccmUfD15EgIN36xMSuTL16sqMbxqaPViZmofDvsFzVhy4NHF
         R8y1i3VZhjsr3dKVGX0prRs9ezk6YyJHWDvoYDEx6SEX4mA1iDYmYSKxJIj3wTP2VrKW
         i8ZAKgeIyHJN0YXapqWQ7lsGXJHqPZTRdt9hxsTuigYqHgZ3sgpmESY8yV17JgW/pgfv
         CelwreHHSj+9YDzteC5yGloUZtpSsrzsYxw38zLFanixkkbLrthVSrY8wypJ2hChiJSK
         uICg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=ZfGNZp0FqXRF14R2lEvSl2W+3CYQf21jFvNPi6RI+VM=;
        fh=nLSFqzE44aBCzYP2xsVa+I8O3lwVAev64381/V6OCTs=;
        b=bgcmvw9GwUDMqBWkTEt67N+vulgoe8nlbRWI3Ulmuw23Pu5KSQHtCTcBBRmaKl069N
         UtyCSO4L5fg/64/QaiNNIk2xBcjSyMXLnT8k9+hpU+uyuY2EfeKmiYmabog8gduTmEfp
         PmuqdT54B4zI4grnUIfumF1cpTTO2/21Qgu3M+ywseWWM2pkZy63UAZ2qfqTlXgAGK0a
         4PKWpLK3DV2LpD1o0ZjkoW5q3iN2oealwvsd1n+HdOvXop++iI9RIS80McX+C3QmaVo4
         BPy3Q0ItY+ThHTAP0WEOuB4e2FF60nqvT1CZpLxR8YOGKSw3su2qWEIEABnafz88Z7qi
         WVnw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795115699; x=1795720499; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=ZfGNZp0FqXRF14R2lEvSl2W+3CYQf21jFvNPi6RI+VM=;
        b=BM8VDiiCqZFgdJ20G+mihVuZLMXA3U9Rr6crtGq/+369UrhguIi0LP03Sbforbacbt
         KaQK0lpAB4DGcsi63g0z70euu0QI57qr+dxKyBlfXEXWg2leNd1Db00d3XVvBUQUSdLf
         U7PGMvpdI0+4l/V55/PdY+6XJSuNJKZUrHcMYGDNLJcs4ttsk9UVu5idq8jq/QZy2jic
         rkOjrFDOAO6HbLM3i4nhsH72KREpilTRTJyyKHJZeu881I8J7cPceH0PnYU9gjHV10Tw
         xaY70aiZ0tZwpJ1i+is4AtITX3brOnCweGepboOxLr70vwiMhst/FQpuR99oOjRFQEUt
         Afbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795115699; x=1795720499;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ZfGNZp0FqXRF14R2lEvSl2W+3CYQf21jFvNPi6RI+VM=;
        b=fQta4tpcoQrylKLSE+iDMTy5v9E9BkjRmN4D3vmG8YnnjKhuX/sXTpMlj+A1LWP0jc
         xKBv1YtlswXsNSjo7TC4iRF7rZM/teVJlITldutc2xGpDMclKjO3t63dWzayECY3auzL
         UvW0Sopf6Dx9sQZNXbzcevzQG5xzxvN+ANj2wDsb8Vpl2/sVnwT8R71WwI6yC/TlRWl/
         5iR6wDAaDBaxaPK7ItT2asDnoaQau/YQ1mLvsSLqmRA4lolebalUugeJZIombdN/c5Pd
         Htfq6qmnl79Uoly6AjHLJSdNqKJRjMzdn/UDeQk0NSZNvOEbn6cvEdJN7IoVKeCFAz9v
         /Hpw==
X-Forwarded-Encrypted: i=1; AL+hErH1gFko9V6FXYUMAImgIVbeI4Di4trLOMszGsBZCj39MlGosbs/RMK7FTfoqAXpj+dpg8Dg4xpm6PR1ZMMn@vger.kernel.org
X-Gm-Message-State: APuU4Z+4U/OHPQGuALUd/lLVpGEdsfeerFZ8vn+zP/mIXAstyBElSYEk
	IxWwdQRynuw1ibs9OTKygaBiVhsCf5BKobrU1N7y4bjsh1iVsF+i9k1fLlZs7GlIdc9JXgusEDv
	CUMIAp+u2bqh1nc/BjuvmSCJ0OhZVkcs=
X-Gm-Gg: AZFdTZfBfTWKZpYI4pVpvAB2Gma7P0VAano3gtBwKdo5zgfnWW5o+4hDgLnM0Vz+WER
	0j+0MSLc9oqcgjvmrI68OHSGkQ/96HEczAJ5EbVzWLiZJ2U1/rgDHlduKPyGhEwDBtMaeFjYkip
	Vtp0Y1kUUK+FtTI36z49OddvjkvUfytBksTmZT4sLGQP+Imkt9CWSkm5hYrhu0NwZ9dQgmTQck1
	isfgiES3H0ga3Pmc9lARJ/ju2bUAYM4PbgX56VVofwl9zaRJEXOi/ID3zhW1JpkvOiXzG+VLHpZ
	HDQA8j29ba/UeLjWsTTdsOB2njkyMPxZCV79C+ZA0DyP/OwnCRAy/PmbnLXXNIeYJ3FFOQsSLHb
	2VzxePn53u0/kLm7rBdCrTAVF4/M7f8nvwAhO+nBFraEaD7HNPuwXkFgy2zkZWbyVRUlcW9Go72
	NnzHSkVVp4/rIkzio/M5HSVYbB96ol0SvIxdu2Q4nX5CKBR8JU0aIWvgzdiHFzwF4UTKtjUg==
X-Received: by 2002:a05:6000:1a8d:b0:48d:f39b:83de with SMTP id
 ffacd0b85a97d-4abad6a42dbmr895329f8f.3.1795115699220; Thu, 19 Nov 2026
 11:14:59 -0800 (PST)
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261117-unused-sym-mm-v2-0-2f845e94dd50@amd.com> <20261117-unused-sym-mm-v2-4-2f845e94dd50@amd.com>
In-Reply-To: <20261117-unused-sym-mm-v2-4-2f845e94dd50@amd.com>
From: Nhat Pham <nphamcs@gmail.com>
Date: Thu, 19 Nov 2026 11:14:47 -0800
X-Gm-Features: Aa3M54ofpta_fbFOGjurxuCbx318jL9bD4qka8Yzj9XEA2lvZOYSWWxaKEQlFjA
Message-ID: <CAKEwX=OUgd9pMbMDoDsj3z8+D-8SfEc9SDe3qX_CcX30pCrPTQ@mail.gmail.com>
Subject: Re: [PATCH mm-new v2 4/5] mm/zsmalloc: remove unused zpdesc_lock()
To: Shivank Garg <shivankg@amd.com>
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>, Jan Kara <jack@suse.cz>, 
	Andrew Morton <akpm@linux-foundation.org>, Chris Li <chrisl@kernel.org>, 
	Kairui Song <kasong@tencent.com>, Kemeng Shi <shikemeng@huaweicloud.com>, 
	Baoquan He <baoquan.he@linux.dev>, Barry Song <baohua@kernel.org>, 
	Youngjun Park <youngjun.park@lge.com>, Minchan Kim <minchan@kernel.org>, 
	Sergey Senozhatsky <senozhatsky@chromium.org>, "Liam R. Howlett" <liam@infradead.org>, 
	Lorenzo Stoakes <ljs@kernel.org>, Vlastimil Babka <vbabka@kernel.org>, Jann Horn <jannh@google.com>, 
	Pedro Falcato <pfalcato@suse.de>, linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 16, 2026 at 11:17=E2=80=AFPM Shivank Garg <shivankg@amd.com> wr=
ote:
>
> It was added in commit c1b3bb73d55e ("mm/zsmalloc: use zpdesc in
> trylock_zspage()/lock_zspage()") but has never had a caller.
>
> Signed-off-by: Shivank Garg <shivankg@amd.com>

Reviewed-by: Nhat Pham <nphamcs@gmail.com>
