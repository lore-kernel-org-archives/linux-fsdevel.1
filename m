Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.218.48
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794816102;
	b=NuTSYDkDFDGFZn6e8QAHfcfJb11k1W0af9L5ydO2A7MXe2BooDzP40/IhTRLT/WhdObM
	 /2Cdn4UOy1BfXDvcL2HzJkRiEk0kdkcOElY8ojIC3BX+YYYOOTGEUG700zslINvR85yJN
	 J42k9zRkkTrd+dN80ZFwBZZSm4awOkB5PiS6eIlgy80JOqD0/gM2u2cygAPrnq+ALPnNI
	 6LdG/3ZvoG9jTb6ximugcS5FhVsv20dXiHD2giDMtfvou1F2lE8+rt5vkpxA6IM7yPYAv
	 0DJj92oerDC8MJFX2ZNcXft+gyVuYTbi31m14PASqe4sxL7BBRcjAs3fy+yiJtgFLxA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794816102;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:Content-Transfer-Encoding:User-Agent:MIME-Version;
	bh=YsacxGE14wOKz6Pg8TZXlOHyLRTqOTqtvBl+xKa/O2U=;
	b=BvdfCsJx9m1f1QyC4dw+JmGgCO21ozs9+DA6M3F0KkCtOg3qQNxfDUkvpJYqIZIY4EHc
	 qTxJaA+WI2U/r79Jy/lo+e6iEQ7XgGuZz0ND8oYeingAxXR4nI/4hvWLFJX88/cNXVq8R
	 Ymc6FrDvA8bBnFTUUtKOXoffSk03S05OUONpMcZkebk0auoTYLrbcOlkJBL4sPqwe/uir
	 dXDBw5gBLjWl4WVU6SrbKjrpgrsADa9A6wNV/PtWZ9A56TKAhllSl7+K9Hvx6qQuKITAt
	 iOx6h/XKcd6E1A2dzZy7dY2/3IfiQY5kSbGpNRYIZP1sOJm1vin017epzIDvFa8+Fqg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=amutable.com;
	spf=pass smtp.mailfrom=amutable.com;
	dkim=pass header.d=amutable-com.20260707.gappssmtp.com header.i=@amutable-com.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=ITTaRbho;
	arc=none smtp.remote-ip=209.85.218.48
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7D18606A331
	for <linux-fsdevel@vger.kernel.org>; Mon, 16 Nov 2026 08:01:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D7D18606A331
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=amutable.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amutable.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amutable-com.20260707.gappssmtp.com header.i=@amutable-com.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=ITTaRbho
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-c50a2efbe1dso484971466b.3
        for <linux-fsdevel@vger.kernel.org>; Mon, 16 Nov 2026 00:01:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amutable-com.20260707.gappssmtp.com; s=20260707; t=1794816100; x=1795420900; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=YsacxGE14wOKz6Pg8TZXlOHyLRTqOTqtvBl+xKa/O2U=;
        b=ITTaRbhoS4PjiN8GAOES1ZGs6qN+vgkvAKeLRlIimkjlbYipl5xqSb3TUHp0tLBeQK
         8VJ4PUMKS/FNKCoXmyt1UpKQ/ROURNkDMJToB9UBX27FhTSo6eVGNZYMsmBcZSnsq1dR
         Ti2MEJnhemD4QbEQr8R8gaYt2AT1TS0fd5CwwLuE1NYcww5Gv4/lmzn/fNqEDnizVxVJ
         w7vtS8T+P/NNNxsygBQPHeOYgpbIkL4D+msHdPp+Ee/csnwj/f3kJQ8M9JTQCcnWQw3+
         hypYmyI27q+SPyRnAGNFKfouVBKIMedzL/tbBOX0yr1VGnty1WioJvL9iVfMcx+IALE7
         L8lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794816100; x=1795420900;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=YsacxGE14wOKz6Pg8TZXlOHyLRTqOTqtvBl+xKa/O2U=;
        b=n09BgoB5efHQ6Ryjh9ckX721DEVgSBmmQqjxH+klCZUk2vhATRzFTmrtODZyjUDVYt
         8r4x2eWXN9xs7Q5/78l2XvVFEue4a163Yr4tduroIexqDwyMzA69flCUePAckfx9cqWo
         OFVSdVR1VU7LnX2nCtwUxYWJHtTJqlCWvNdqYwbYC0kuckw+iIHS9bxTMD+gAEfIomZ8
         Z1ryDISRzOiLvtaY/myYqb/r0pmYzwruvEVR4STrz5Sp9n7w1FPy5cMn8INRbvysjHCA
         4NYMtZ+lgNVL44AWrpfkkYW3MT5D3ETgAkQT3X+omCxXZcFSghoXxuW83hz5mr7Ac8eE
         Zugg==
X-Forwarded-Encrypted: i=1; AL+hErEuZXOtlyzZUEPC5w9AQ4If2ZFXpr+Dzm5HGELNxlAcF4dC9fenETWZ9PE/OkTBCkwz5ORYf3u9WxGBycis@vger.kernel.org
X-Gm-Message-State: APuU4Z8Z14JYaYs5FPQ27WIf9Y/ogy0PQQkK1fzleY2sABsB+fb0Axm5
	9BFH89Sxkdy9JLXDn/PHGUIaibqBRLiP0ThacCSOm0//ARjIRNnvrIvSP9gWqmvgSX9j
X-Gm-Gg: AYBFou0PY3vrOUGEdRLYvkeWPZCMeC0AZownL8fF1rXA9ZoW5cwHPuzeDsFtIU7aq1u
	dOG4qo8psXOdzxhvbGYolyRwxWrv++wupkdwKoIlxaDP+IWcfK8MRN8eG3viWd0q/+mMzjd8PuC
	9qEcE/wHMwBoPTYOQ+brTe2gAVR3ju7vQs7eJYnPBCeczLS509H3xTyq9hCrdlzl6imQqdwDM9r
	8Vn/yWDoOihMT1ECqwMNFD3ItATHW02XquRrN4vkdQMIYQ455zYUc5rUcecGwR9cGzKsPv8plFi
	QLlmkeunAzziiGGbXCam9nUvuItNTZ8A6aRrV+zqc8GuzyJcH0SdQPcwulwmn+Le9COUfDW2K7W
	uPPUJtFyBdPwQQW65+p38Nk1YH+gVe4WoCbULeWBlRtiKcPmGdgheTA/KrujTsu9r3EK2ZwTCgw
	Ycj+17wnn8lQOs21j9ZtmgdTDux1RuEsV+MpA+FFTTK5rrsoU+ut9rPXMOUSkfYpaGUIaucJWi/
	FS0P5Y9kVE0IA/MzlELOT+skxDnL3If0/nWM01IQzRpzWCIB46UyHCTAMd4XrhOHpPqB9QCzur7
	o1BuOefBRYZy5UDevZs91IhMWRfe2m2eJFLeNaKvZoyVDVhP04RxTg5LwTqLp9o=
X-Received: by 2002:a17:907:1c90:b0:c2e:63ba:1f90 with SMTP id a640c23a62f3a-c50963bc4f0mr777600066b.48.1794816099924;
        Mon, 16 Nov 2026 00:01:39 -0800 (PST)
Received: from [10.0.0.233] (tmo-086-54.customers.d1-online.com. [80.187.86.54])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c5095b7b2c9sm385795866b.73.2026.11.16.00.01.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Nov 2026 00:01:39 -0800 (PST)
Message-ID: <dfdd6f4437cbf8f55458b908ec5347f3189bce80.camel@amutable.com>
Subject: Re: [PATCH RFC 4/4] crash_dump: use copy_oldmem_to_iter() everywhere
From: Alexander Mikhalitsyn <alex@amutable.com>
To: Christian Brauner <brauner@kernel.org>, linux-fsdevel@vger.kernel.org
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Breno Leitao
	 <leitao@debian.org>, Chris Mason <mason@kernel.org>, Thomas Gleixner
	 <tglx@kernel.org>, x86@kernel.org, kexec@lists.infradead.org, 
	linuxppc-dev@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org, 
	linux-riscv@lists.infradead.org, loongarch@lists.linux.dev, 
	linux-mips@vger.kernel.org, linux-sh@vger.kernel.org, 
	linux-kernel@vger.kernel.org, David Hildenbrand <david@kernel.org>
Date: Mon, 16 Nov 2026 09:01:37 +0100
In-Reply-To: <20261112-work-procfs-oldmem-v1-4-ecdcafd99265@kernel.org>
References: <20261112-work-procfs-oldmem-v1-0-ecdcafd99265@kernel.org>
	 <20261112-work-procfs-oldmem-v1-4-ecdcafd99265@kernel.org>
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
> Make the remaining copy_oldmem_page() implementations copy the page
> of
> the crashed kernel with copy_oldmem_to_iter() like x86_64 and powerpc
> do. None of these architectures has a machine check safe copy today,
> so
> for them this is copy_to_iter() under another name. But the copy of a
> page of the old kernel is in one place now, and an architecture that
> gains ARCH_HAS_COPY_MC later gets the recovery without touching its
> crash dump code.
>=20
> s390 stays as it is. It copies the old kernel's memory through its
> real
> address mode window in memcpy_real_iter(), and an uncorrected storage
> error is fatal on s390 anyway (cf. s390_handle_damage()).
>=20
> No functional changes.
>=20
> Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>

Reviewed-by: Alexander Mikhalitsyn <alex@amutable.com>

> ---
> =C2=A0arch/arm/kernel/crash_dump.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | =
2 +-
> =C2=A0arch/arm64/kernel/crash_dump.c=C2=A0=C2=A0=C2=A0=C2=A0 | 2 +-
> =C2=A0arch/loongarch/kernel/crash_dump.c | 2 +-
> =C2=A0arch/mips/kernel/crash_dump.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 2 +-
> =C2=A0arch/riscv/kernel/crash_dump.c=C2=A0=C2=A0=C2=A0=C2=A0 | 2 +-
> =C2=A0arch/sh/kernel/crash_dump.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 | 2 +-
> =C2=A0arch/x86/kernel/crash_dump_32.c=C2=A0=C2=A0=C2=A0 | 2 +-
> =C2=A07 files changed, 7 insertions(+), 7 deletions(-)
>=20
> diff --git a/arch/arm/kernel/crash_dump.c
> b/arch/arm/kernel/crash_dump.c
> index 938bd932df9a0..0f2628872b00c 100644
> --- a/arch/arm/kernel/crash_dump.c
> +++ b/arch/arm/kernel/crash_dump.c
> @@ -28,7 +28,7 @@ ssize_t copy_oldmem_page(struct iov_iter *iter,
> unsigned long pfn,
> =C2=A0	if (!vaddr)
> =C2=A0		return -ENOMEM;
> =C2=A0
> -	csize =3D copy_to_iter(vaddr + offset, csize, iter);
> +	csize =3D copy_oldmem_to_iter(vaddr + offset, csize, iter);
> =C2=A0
> =C2=A0	iounmap(vaddr);
> =C2=A0	return csize;
> diff --git a/arch/arm64/kernel/crash_dump.c
> b/arch/arm64/kernel/crash_dump.c
> index 670e4ce818223..c774b3aba107d 100644
> --- a/arch/arm64/kernel/crash_dump.c
> +++ b/arch/arm64/kernel/crash_dump.c
> @@ -24,7 +24,7 @@ ssize_t copy_oldmem_page(struct iov_iter *iter,
> unsigned long pfn,
> =C2=A0	if (!vaddr)
> =C2=A0		return -ENOMEM;
> =C2=A0
> -	csize =3D copy_to_iter(vaddr + offset, csize, iter);
> +	csize =3D copy_oldmem_to_iter(vaddr + offset, csize, iter);
> =C2=A0
> =C2=A0	memunmap(vaddr);
> =C2=A0
> diff --git a/arch/loongarch/kernel/crash_dump.c
> b/arch/loongarch/kernel/crash_dump.c
> index e559307c10929..03a136b8be8da 100644
> --- a/arch/loongarch/kernel/crash_dump.c
> +++ b/arch/loongarch/kernel/crash_dump.c
> @@ -15,7 +15,7 @@ ssize_t copy_oldmem_page(struct iov_iter *iter,
> unsigned long pfn,
> =C2=A0	if (!vaddr)
> =C2=A0		return -ENOMEM;
> =C2=A0
> -	csize =3D copy_to_iter(vaddr + offset, csize, iter);
> +	csize =3D copy_oldmem_to_iter(vaddr + offset, csize, iter);
> =C2=A0
> =C2=A0	memunmap(vaddr);
> =C2=A0
> diff --git a/arch/mips/kernel/crash_dump.c
> b/arch/mips/kernel/crash_dump.c
> index 6e50f49024094..078c0d1e8df46 100644
> --- a/arch/mips/kernel/crash_dump.c
> +++ b/arch/mips/kernel/crash_dump.c
> @@ -12,7 +12,7 @@ ssize_t copy_oldmem_page(struct iov_iter *iter,
> unsigned long pfn,
> =C2=A0		return 0;
> =C2=A0
> =C2=A0	vaddr =3D kmap_local_pfn(pfn);
> -	csize =3D copy_to_iter(vaddr + offset, csize, iter);
> +	csize =3D copy_oldmem_to_iter(vaddr + offset, csize, iter);
> =C2=A0	kunmap_local(vaddr);
> =C2=A0
> =C2=A0	return csize;
> diff --git a/arch/riscv/kernel/crash_dump.c
> b/arch/riscv/kernel/crash_dump.c
> index ea2158cee97b3..0820e3db12603 100644
> --- a/arch/riscv/kernel/crash_dump.c
> +++ b/arch/riscv/kernel/crash_dump.c
> @@ -21,7 +21,7 @@ ssize_t copy_oldmem_page(struct iov_iter *iter,
> unsigned long pfn,
> =C2=A0	if (!vaddr)
> =C2=A0		return -ENOMEM;
> =C2=A0
> -	csize =3D copy_to_iter(vaddr + offset, csize, iter);
> +	csize =3D copy_oldmem_to_iter(vaddr + offset, csize, iter);
> =C2=A0
> =C2=A0	memunmap(vaddr);
> =C2=A0	return csize;
> diff --git a/arch/sh/kernel/crash_dump.c
> b/arch/sh/kernel/crash_dump.c
> index 85c0e58f1a59f..2a5988b6e9d7a 100644
> --- a/arch/sh/kernel/crash_dump.c
> +++ b/arch/sh/kernel/crash_dump.c
> @@ -23,7 +23,7 @@ ssize_t copy_oldmem_page(struct iov_iter *iter,
> unsigned long pfn,
> =C2=A0	if (!vaddr)
> =C2=A0		return -ENOMEM;
> =C2=A0
> -	csize =3D copy_to_iter(vaddr + offset, csize, iter);
> +	csize =3D copy_oldmem_to_iter(vaddr + offset, csize, iter);
> =C2=A0	iounmap(vaddr);
> =C2=A0
> =C2=A0	return csize;
> diff --git a/arch/x86/kernel/crash_dump_32.c
> b/arch/x86/kernel/crash_dump_32.c
> index 5f4ae5476e193..cb202d4e1f703 100644
> --- a/arch/x86/kernel/crash_dump_32.c
> +++ b/arch/x86/kernel/crash_dump_32.c
> @@ -40,7 +40,7 @@ ssize_t copy_oldmem_page(struct iov_iter *iter,
> unsigned long pfn, size_t csize,
> =C2=A0		return -EFAULT;
> =C2=A0
> =C2=A0	vaddr =3D kmap_local_pfn(pfn);
> -	csize =3D copy_to_iter(vaddr + offset, csize, iter);
> +	csize =3D copy_oldmem_to_iter(vaddr + offset, csize, iter);
> =C2=A0	kunmap_local(vaddr);
> =C2=A0
> =C2=A0	return csize;
