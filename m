Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.47
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794815930;
	b=FY02hqAynSnQdJHKO4KxGeDt95nAQlfebBRB4sujksVisPSrZ6tlVa8aEsSkOn9tF6VK
	 y4Aw3Bnb3u8SOZTAQhyWP/zca71nf0yd4Z8MtLzs/M2GJGwfb6UmyClqOuX2DyFq7loTM
	 47xtZ8uIhXueezHMRA2LV9dAT6f2MXoQTAHPfPpxto8XXrpcjUZwTv3PlGghqIkGsgiH2
	 KAcCF9+v+brG83K5bmDwdAUmvH5Hpz0dtMls9iu0WFOAoJVRNUCckT60HX1KnaaUQtZqS
	 9tiIk6K1LAswr5laabGBygrZug4RPJ4Z3iLgh4q/sSazMMbi+73Zr0lPbyNFjg391jw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794815930;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:Content-Transfer-Encoding:User-Agent:MIME-Version;
	bh=RUWz3ZPMUxA6+r9kTNI2D7JNnedpd8n5diTIAYYVkok=;
	b=nt0tKRM4OtEsRqrQBXleBKwjODON7V4Sjc9H6ZuwAjmr44Xn7K7e2iLnFDZ3RWN8RCoR
	 MEJTmFvFo3ehA4bmjWJSlQ80kmetil8ABuP4c7c5OgVGin+30pag+5jSFvYkSSI4eCm5O
	 EVU3DtPcHnctQ4c6oWEev5FL27j+wz0X909XdOexN+skzfbEbhzl3VL7GULaOH425sBE2
	 XaTCF6KjeSaQEYu5vDxAdFV/CA9f5KX/FD0Le9jB7OAMlzzJNS3/0cvx6q2aG6jxJnhdX
	 P7d/oBdeKs/O+uRA3f7Jjn1XHvnkxeYfoHUUc4a9tUPDLe+QslPxA/mzXR1kCTnZhaQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=amutable.com;
	spf=pass smtp.mailfrom=amutable.com;
	dkim=pass header.d=amutable-com.20260707.gappssmtp.com header.i=@amutable-com.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b="m/LM6ars";
	arc=none smtp.remote-ip=209.85.128.47
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF2E5606A329
	for <linux-fsdevel@vger.kernel.org>; Mon, 16 Nov 2026 07:58:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DF2E5606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=amutable.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amutable.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amutable-com.20260707.gappssmtp.com header.i=@amutable-com.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=m/LM6ars
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-4a207b02a2cso16838865e9.1
        for <linux-fsdevel@vger.kernel.org>; Sun, 15 Nov 2026 23:58:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amutable-com.20260707.gappssmtp.com; s=20260707; t=1794815928; x=1795420728; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=RUWz3ZPMUxA6+r9kTNI2D7JNnedpd8n5diTIAYYVkok=;
        b=m/LM6ars18o8GDKRmm846P52W5VTEeLVl3zm4E6+Ukoew1PNUWaySYAFTHbhwbIHY6
         8zyWRJ3E+soSg5cVCg675JZQUuiKrI7PnShT86jC05Ju/0/IRheNzvGNmD+npQLbnkn0
         fy8Il1K6Vm+A5YZwCa+xzQ2+KQuOMrOvsBIKg/ExEvAa5Y/VxNmGrq1rCHU6BtXLMwTC
         Wsvn5VDRjOEmowS+ZSTEWPRIhLKHrJyNPuqywDI23KP2brkj28XF72ButTpsWAH9l4pR
         IypEgitHhE/vdzZkz5m5Ua6ccTEUz62Pa2MJahrsFOhrSRlAMMkSQY6/3R5U6hM1aN5V
         0hRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794815928; x=1795420728;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=RUWz3ZPMUxA6+r9kTNI2D7JNnedpd8n5diTIAYYVkok=;
        b=uLvBcvLsYIOzLYipEDxmhvqZ1IQvU5/UEif4lkr5RPemYob9vdeLCU+z6ktpA4SxRX
         bdUrxEZQ28yaqK04Pvh6E7I93GLdTYxMHlKagztTkouYSeVwqAWa8LQ+iXFO27/rnjVJ
         /ysKbhi1ySFAo7AtPXhRfIzynEDa3ic+Q2hv0mBAfRaNX9HyLp8lSZ+OEVTqMrSwtlxo
         zMPOT/WN471aSgOEWieLJa5lIJk821vwsVgpCG9RYu3R6f8siA6GZprceisyeigXvho7
         57/mIiEtroMTGPHjcdCQDcqN8s40zbUauuawwvYgvzIAEfRlYdrgET3Iy4Gqu4iY0aiZ
         N9dg==
X-Forwarded-Encrypted: i=1; AL+hErGoMlfmEl/01CBZxkm1vyIt/ogrzTdVxE4C08N/XJuXGZJVyO3bVDI3Mq3DobmRFL3vnUr/wiAWx0NS4c3y@vger.kernel.org
X-Gm-Message-State: APuU4Z+0pQCpIOZpnFCrZDN/OZk0g9nZivh3KNpAsaCFHqFv6RRMb1pb
	m4NBckobnz2Oiv8/jJcTs0ioKp2gNX2UAn/xU/OTorlZHAomC1tJEiG7yibIPcVX4JNf
X-Gm-Gg: AYBFou2EAU6uobSV+YvUQKlaG/gUrdsVMM7q/Pld9x0S+mBwV85HcqUD/do64laeTQq
	X7JICu6OP32cdZMY5eod7jmtL/19m9Fl27ghon682u3GXYAaa8WRp+5iI6iSF9NG8p5UlMWnJBi
	XJ4a7ts3PBxfd8KS/FzauwcS9nBqYrL/l04xmN7MCxacc9lkoJFO7LzfxgdajJw37RsCzLmKzSE
	qyu/v/sh5Yo+nFE1PdmfMInzTTEa2j+B29CCFtI9323YF8pF7LO8AqgCvwaiALU8gdPZ3N/Cdro
	M8bfxainvh2rOlm5fXwLk9FpjWLJa/VT3rSZoU+OYllxVTRdyEoJm4rLOMji5bC/gf8cYgsA0YX
	+C19YabEDbAmzHhwqYM31qRrtez4QburgWhrJzlu8r95DbcLSAWeBTkN/LWG0+Gsunx42Iz3Ju1
	1EgPun/1euCv5mIQhzQQwmz3L06b9Oy0NJCM52hsF5UNpQxHGAgShkatnpYmSnQ3LZe2k5nSSoh
	qWHNHzR6IGrV7gnzgEf1skD3FmIZGR7aeJzlAjgHe00kyIx58kJen46vm90qCpl+laBi16Wn98L
	VmH2+p7JxYlSr5sd1q0QNFkmGxMOcnKykDoiBO+J7+lMpslHcDKMuBz4RZGsUrc=
X-Received: by 2002:a05:600c:3b07:b0:4bb:5de1:e912 with SMTP id 5b1f17b1804b1-4bb5de1f216mr172834365e9.1.1794815928232;
        Sun, 15 Nov 2026 23:58:48 -0800 (PST)
Received: from [10.0.0.233] (tmo-086-54.customers.d1-online.com. [80.187.86.54])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb4e252f7fsm375768305e9.2.2026.11.15.23.58.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Nov 2026 23:58:47 -0800 (PST)
Message-ID: <aa32167cd3865049bfe0281b8b651c47f5e1c05d.camel@amutable.com>
Subject: Re: [PATCH RFC 2/4] sh/crash_dump: check ioremap() in
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
Date: Mon, 16 Nov 2026 08:58:46 +0100
In-Reply-To: <20261112-work-procfs-oldmem-v1-2-ecdcafd99265@kernel.org>
References: <20261112-work-procfs-oldmem-v1-0-ecdcafd99265@kernel.org>
	 <20261112-work-procfs-oldmem-v1-2-ecdcafd99265@kernel.org>
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
> copy_oldmem_page() maps a page of the old kernel with ioremap() and
> copies from it without checking whether the mapping worked. If it
> didn't, the copy reads from an offset into the NULL page.
>=20
> Return -ENOMEM like the other architectures do. read_from_oldmem()
> turns
> that into -EFAULT like any other short copy.
>=20
> Fixes: 4d5ade5b29c6 ("sh: kdump support.")
> Cc: stable@vger.kernel.org
> Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>

Reviewed-by: Alexander Mikhalitsyn <alex@amutable.com>

> ---
> =C2=A0arch/sh/kernel/crash_dump.c | 3 +++
> =C2=A01 file changed, 3 insertions(+)
>=20
> diff --git a/arch/sh/kernel/crash_dump.c
> b/arch/sh/kernel/crash_dump.c
> index 19ce6a950aaca..85c0e58f1a59f 100644
> --- a/arch/sh/kernel/crash_dump.c
> +++ b/arch/sh/kernel/crash_dump.c
> @@ -20,6 +20,9 @@ ssize_t copy_oldmem_page(struct iov_iter *iter,
> unsigned long pfn,
> =C2=A0		return 0;
> =C2=A0
> =C2=A0	vaddr =3D ioremap(pfn << PAGE_SHIFT, PAGE_SIZE);
> +	if (!vaddr)
> +		return -ENOMEM;
> +
> =C2=A0	csize =3D copy_to_iter(vaddr + offset, csize, iter);
> =C2=A0	iounmap(vaddr);
> =C2=A0
