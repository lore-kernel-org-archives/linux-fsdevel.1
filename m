Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.53
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794815911;
	b=pLTPJyDw79c95NIH9HRF9/xVpSTwxyw1Xe3AEbK+/X4/OpyP8sXI9L/yul2B5XdvKDV9
	 cl+poeynezL6j6L9suWMuD/tNIMoi3wQKpj3KPh9xZ/Pc9lNt4jxWCSrnx52wivZx3AoB
	 FnCVHbs0vPNzu1Lz653WDYdae0FSywtBj5WFoVy8IghhmHFu75FT3T0fmDat0RySPaR77
	 CupxYvCtQOwLrvlBsl1Ysj1E4tKVX5igYmRcc9scGgLeu2CUOMU5nPcKIt2imhd66hubM
	 PtReeTRKY+o7V6U3vVfLViSJ91CSeUR+cxxwId+/yUJNpiby+SQfplOWRyC9JBiITnQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794815911;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:Content-Transfer-Encoding:User-Agent:MIME-Version;
	bh=MJ7d3rNHeUtNAkSjUSjsQ3HRQiSBTnNiLXOBSu1liKw=;
	b=Ltsu7mBjSMUWfa2OkJ/QaKWd04MWKbZo1aAu/ecT+Xd3uGiQpopp+SSk1w08OaWZODVW
	 AdEo06tE3ItFzQnPoojKUkZ8wU7X+s8Nn0I/cWND1SscwaHEEG/trbzMs6iY1v6Hs0GDb
	 aPWfsiSaBTcoUs0NhJDt8Hbm6ogtid77OdEpNy1I2nMGnIu0ZlRS7gLEa/GZaAHybL81Z
	 UCSEqwET4pPMDSWxZIS07z6JpOTL6Q5tOfDNodqPP0c105IblpJ4SX0IWEoMfk8JikbYn
	 aAJa9F/0tTwbgtj+or2Z9y2ZT6jekQexU+X9R36J4EzfF42/w0YoyMs8Rj5PJfGdDlQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=amutable.com;
	spf=pass smtp.mailfrom=amutable.com;
	dkim=pass header.d=amutable-com.20260707.gappssmtp.com header.i=@amutable-com.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=RZwbcCo0;
	arc=none smtp.remote-ip=209.85.221.53
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99394606A330
	for <linux-fsdevel@vger.kernel.org>; Mon, 16 Nov 2026 07:58:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 99394606A330
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=amutable.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amutable.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amutable-com.20260707.gappssmtp.com header.i=@amutable-com.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=RZwbcCo0
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-49412eb1474so1449601f8f.3
        for <linux-fsdevel@vger.kernel.org>; Sun, 15 Nov 2026 23:58:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amutable-com.20260707.gappssmtp.com; s=20260707; t=1794815909; x=1795420709; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=MJ7d3rNHeUtNAkSjUSjsQ3HRQiSBTnNiLXOBSu1liKw=;
        b=RZwbcCo0a4gjuV18T+2Ucnw6jCdsWPKRC5LMIQkGS1u3K0j0E8r+eXQHgwhpFjV9Ns
         E4eQbhZlMF0oYosxibPqVnuTLzKDIZ56ygSzOKMLI0U3HdyWkdsGQRg4ffVVNprx0lNl
         3VoShnBY86Rw8ivEwPnvAve0hmIwWUhUt2ZoXiWAG5yImwJfbTo3xhtFN5I/MYPHtn4b
         enxL6PfWiyWc5q9d46A94egMlP3knZPlBbquGKVnCwHFNT5Fsl4ImTFxxiA9tP+r47o4
         8TQ7tud9tTBHlzYrfDmF4FaRvuovfFXjlIwl3BFIwbrGT1RvY+zLOzg32pd1vrPaiWJ/
         fCWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794815909; x=1795420709;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=MJ7d3rNHeUtNAkSjUSjsQ3HRQiSBTnNiLXOBSu1liKw=;
        b=zxMJqFaC70P/Wc7QplUZEwrgFLpAq269NR24XmcprVPxrGE42Urv7YRbVQnrp+R2l+
         616NOfxiqG/oVTrJIUBH4MqURUvhZ2yg5OyLa+Re0ulXGva7t4q1W0/rBNNfGYxo5K6q
         mSIFcoWSlfdbPB8gMnbLxOgdq1H8b2Xi9UH0aeQmT6D4BQsEdDEzqneIE1vhXD9TsZaj
         HqbMD4YLUyYce9WkJbo3PIyHNgFp1YhPDnl7bD+47T+zM9V4RnZxid7dHfQulTh7aKqt
         YSdMXo+Oqie3yBhHuwYG8N/kyVJ7HKl5ZQuevqWjgnu/W+jHxyJOQNEGZa+5Al6AWKLt
         /XUA==
X-Forwarded-Encrypted: i=1; AL+hErHsRYdvDnANM5QFwHoIgystFqK4zypOQywE6Wdqfi3TQPb/OoBxYuu29t950zcqcs6cclC92BS+43qQw6qh@vger.kernel.org
X-Gm-Message-State: APuU4Z+9JuMKiq5mZATFtMikSNYulbb6+rHgTYkcPZHOSzAM4VONdAny
	lLRuRBOoF2DFgnsUwiYSpKk6XaVk5OPid//O2ofYVJQYSE3e5znmUsVo1Xwktw4HFca/
X-Gm-Gg: AYBFou1boyi/kFZYA29FxTKdzloZ6m2jx1lcqhNUcgU4WADu7Ktr3r/onkXb5nUJqB8
	Gad5W7IHWw/FOXTLkaOvYzMyTSnDiSy11U6iyNScEhkSKV8r9m1zkts7netz2JmM0dvAWitRsJW
	WKY9Ib/0SYWuxW/CrlGuQwboR+6DLNgABn8qVW3TStTEvHDUaK+XlLEentEGiXVJm8Zsg7FJUkv
	7oqO+62BChN7hXn9gWUvp7LGIkUJUe0UMxaYQQUeCTjaGdBQQt3VF/y2s4FuFP2b9sdKMxodXLt
	oxZVjPunKUkrxua9+OdCrgLYIHiqet+MCitCO9MjokPivTuhM8h3qY0ccqiFCIi2fQOc2fF3DF/
	vHVmfLU3N7QcrW0ay1Qu9ZgvExzl6YwhueKPcD4O4kiYU6IfgB5PUCdUM2ByosCPC6490goEZzd
	ootpXxIWb/VV3+kwHzH8jLil5eoVfC8JWr2uDiGozShL3UTa/s269nV9QkGHifiQOw3c/Jr4Mse
	wbcdupe6pVeiCT1G/2fqJrtbgxJGYtr7CmORsys+CGLD6dtTrKuJ2s1YNwA8lNBCOGPnMRB1Pq3
	oIY+I0wsq6YpWQla6z+SwcpXTmHO0MthYnESgrPf9kf2Qgw/XUCCPTOQ2sK3ids=
X-Received: by 2002:a05:6000:3108:b0:48d:f9dd:e3de with SMTP id ffacd0b85a97d-49c7353c415mr20084703f8f.45.1794815908942;
        Sun, 15 Nov 2026 23:58:28 -0800 (PST)
Received: from [10.0.0.233] (tmo-086-54.customers.d1-online.com. [80.187.86.54])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-49c5ff2be55sm21124748f8f.28.2026.11.15.23.58.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Nov 2026 23:58:28 -0800 (PST)
Message-ID: <19b4c35c016a91302bf6bc3380bfcd3d21dc50c0.camel@amutable.com>
Subject: Re: [PATCH RFC 1/4] powerpc/crash_dump: check ioremap_cache() in
 copy_oldmem_page()
From: Alexander Mikhalitsyn <alex@amutable.com>
To: Christian Brauner <brauner@kernel.org>, linux-fsdevel@vger.kernel.org
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Breno Leitao
	 <leitao@debian.org>, Chris Mason <mason@kernel.org>, Thomas Gleixner
	 <tglx@kernel.org>, x86@kernel.org, kexec@lists.infradead.org, 
	linuxppc-dev@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org, 
	linux-riscv@lists.infradead.org, loongarch@lists.linux.dev, 
	linux-mips@vger.kernel.org, linux-sh@vger.kernel.org, 
	linux-kernel@vger.kernel.org, David Hildenbrand <david@kernel.org>, 
	stable@vger.kernel.org
Date: Mon, 16 Nov 2026 08:58:26 +0100
In-Reply-To: <20261112-work-procfs-oldmem-v1-1-ecdcafd99265@kernel.org>
References: <20261112-work-procfs-oldmem-v1-0-ecdcafd99265@kernel.org>
	 <20261112-work-procfs-oldmem-v1-1-ecdcafd99265@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2-0+deb13u1 
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

On Thu, 2026-11-12 at 17:37 +0100, Christian Brauner wrote:
> copy_oldmem_page() maps a page of the old kernel that isn't in the
> linear mapping with ioremap_cache() and copies from it without
> checking
> whether the mapping worked. If it didn't, the copy reads from an
> offset
> into the NULL page. That oopses unless the copy happens to be a user
> copy, whose exception table entries turn the fault into a short copy.
>=20
> Return -ENOMEM like the other architectures do. read_from_oldmem()
> turns that into -EFAULT like any other short copy.
>=20
> Reported-by: Chris Mason <mason@kernel.org>
> Fixes: 54c32021eb6f ("[PATCH] powerpc: Add arch-dependent
> copy_oldmem_page")
> Cc: stable@vger.kernel.org
> Reviewed-by: Breno Leitao <leitao@debian.org>
> Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>

Reviewed-by: Alexander Mikhalitsyn <alex@amutable.com>

> ---
> =C2=A0arch/powerpc/kernel/crash_dump.c | 2 ++
> =C2=A01 file changed, 2 insertions(+)
>=20
> diff --git a/arch/powerpc/kernel/crash_dump.c
> b/arch/powerpc/kernel/crash_dump.c
> index 103b6605dd68f..1543917bd3e1d 100644
> --- a/arch/powerpc/kernel/crash_dump.c
> +++ b/arch/powerpc/kernel/crash_dump.c
> @@ -86,6 +86,8 @@ ssize_t copy_oldmem_page(struct iov_iter *iter,
> unsigned long pfn,
> =C2=A0		csize =3D copy_to_iter(vaddr + offset, csize, iter);
> =C2=A0	} else {
> =C2=A0		vaddr =3D ioremap_cache(paddr, PAGE_SIZE);
> +		if (!vaddr)
> +			return -ENOMEM;
> =C2=A0		csize =3D copy_to_iter(vaddr + offset, csize, iter);
> =C2=A0		iounmap(vaddr);
> =C2=A0	}
