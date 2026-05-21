Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65CB63C4B86
	for <linux-fsdevel@vger.kernel.org>; Thu, 21 May 2026 12:01:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779364881; cv=pass; b=i5D0SF/s15J/mFjTpc/B5KlWjUy/LHRlPoz8Yl53pQfofOFt7NWybMHo+XJvb9BNGDl7XTU5wFXR95ZZ0IoFfCnj3vL9hKcP1N8O5dWZqUK/WbQumWsRvqpYWoKyTCXrXEiuQ6Um8oF4W7dXwTMhRioJgEAniHYhwFCbg0XZPjc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779364881; c=relaxed/simple;
	bh=N0WRCQ+KH01CpayEYyy7mrrqhMaV2Yzdg1bxdqWZuZw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=M503cVtXybUhe4z0wo0SnmN8ilpDrz0Q1jjKkzohT6jegSLGLIeIG02bb2hoT830+6ZyvKy9U4FPIMnxjT7EEQuvQe9P0BF/QHIMor2p1rzbcHdCl/Ob8kRER/9o24rpdTMSXnGDeGFscKlgL6jrK4sAukBRlX3uqOkWOIyNlMY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EEfftwHJ; arc=pass smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EEfftwHJ"
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-b9358bc9c50so893533266b.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 21 May 2026 05:01:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779364879; cv=none;
        d=google.com; s=arc-20240605;
        b=a2SoH/VO6pI1ebA0oOqSoGssHLvYAsVSPWe8TdhylDodQhAhFmEwT9XNj6VZmE8Cit
         DgJTtpMFMbyJuJqZVGViumpsGJoVTVoTdsDWMo5SSqtc+DDPD797ZurWTo+ZCcA8e+1C
         C6gSWj87DIjPeA1+xjF2p1KYoY+re/jJ9xtT/aszYoEYslUSTk9cq05D56wIvDs9uL2A
         qh7IxO8Fzwn9jdYjFTl5JtyPSp64JLpY+hUgIOHvrbbafwZHImNkw7GS4Pzh0OyKYaIx
         1iUNvxA6Jwokc67OZekNpN+q36LnHx35OZI5aNJ0CBumcFKl9BGEsjDCO+sjQStrQQKZ
         +9Ag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=N0WRCQ+KH01CpayEYyy7mrrqhMaV2Yzdg1bxdqWZuZw=;
        fh=oHVm3EwnNUxHfq6WHgsdaJK/MB0t9IBhoVDUuPGKVZI=;
        b=C2UmC1CbAqWROHrHnn0zExtkOusQth5cHoCOzBLgl9HGfuiAn64idqs3n14YCneCTz
         Asx7h54pFPgkxsXRh+J2emfDY31bLDycldYGIVBB12VwiB1ENlo8paO6RccJB4BIhYga
         kAiwHIQi99r/6Qjh4LRn75RD22HE1yNUy9my9fw0EMM4laOuawBczLvxw2SMOzYTiYzz
         MJe+dct/KgWJhTvICcge7FSoomLZqwbQ/3Fi+0CKoL94Y0XYolWyozvbP5r5SOLK1lPK
         hSUw02zdQITEUlTxFX5yQIrRZWRgXQ+57g50yWC9jWRqvyxQMdrWZnwOQsx3S56j60wi
         fEVQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779364879; x=1779969679; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=N0WRCQ+KH01CpayEYyy7mrrqhMaV2Yzdg1bxdqWZuZw=;
        b=EEfftwHJbcxNYZ8176Z7aAfSijLuDtPDRKLdydRy1+2YDmjEkZJiTmHnvAnxrU0dw2
         RLsT+YuiyzBuoWBA2Hk9KBRGwIuf8GvTW65VFpcf+XcPIDS0EOaJyuhNYdgk6nkmMJfg
         nBsCrmdCkRQge2x+dNcbUyHB6Fwxh7l4FiiqCLFq7ip4Qnqm9p8U20O33hneoL1Xdb6f
         JWloFenWsX8hx698dkDFwFi1r+rXKW1sfoc721aa0mawAE2a/fHZ2uxvAbBjm2SNcnSn
         cmn6Z8XCjEvTXR9qWBCusRm9jieBmSIlXMK6i0k3A4yduErcwaD9TFFDKgwDDnP1efUz
         L0gA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779364879; x=1779969679;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=N0WRCQ+KH01CpayEYyy7mrrqhMaV2Yzdg1bxdqWZuZw=;
        b=omMVaH0NR46ccrFgda0R9vfwwe7SE9K23GqOLvweEQleyK5jhXlUgfSN9bssdxGspo
         sqFH9QETE9ll3Xq2o4r7yLhNRsJMWesbFZ80NiWPTgj5INKeWukFSI0UAf/MxFEEm6Hh
         TV1y4aH6K8PMIjgaJ9BmTFBLRp8x7PMJKdvFeViy5o3XWm7GKzpIghnwBV5CBVpEFX3b
         oRIgvXWB07eah7vE8I7EYxYLH21pROPRNemNlQo6NiREjTwgLEsHjNtuSxr9619N43sO
         3LA2lvrrWbXtI9SEhkzjDRY644SsoUyT/6OgUHZOrmVY8AwMONFSxiq314/OYOvVaD2A
         mkHQ==
X-Forwarded-Encrypted: i=1; AFNElJ/g3JFgyUjg1h7lmynVjbYkfWeTTqXZYlruPFflMALxbUF/oqKGR0UBb9R0WYHQEaxkKR7kiqo/1iPxrmDB@vger.kernel.org
X-Gm-Message-State: AOJu0YwbRtPp8vkoQHN+sOnVxmmFcsvlBWCou0rsQcdAHzXqRSRIzd9n
	Ci32sGRJip3esY8REnT7JuSgu+9tpYpS0RNk7Qe+aM2wklPk+q8d/vm9HI3k5csWO3+KgIocVrX
	ADD7jDVtwxiuNaRHpdUj+YhgbGOLDMjs=
X-Gm-Gg: Acq92OE/5uxyjRTw/DAim4jHNDarCgVCe4V6kLniY3DjVksor0DtiXPBMZHz1ZZA4Ba
	LMIfDTExbW85t64i7KspHL8GW4NyMpwKqVnHpSM6sy89QQQRA7ugv+KCAiDX2nvI3w+10BjrMNg
	wyhZNmE6DXmF8EFRqCZMGFkK12AuFH2QeYOM2tNGs2FOSn8svPBr1E4MBSdYfUxJdwqfGYWqKRe
	2rUDyjYlmqs8tb+9fzBZB37ATdV0Q4uTLJbuRdBEKeujFGeGfwz6e0P1W1yJUTl9Hna/UTPgLXt
	6GGXiHMRKs0/ny63p1cuk1iBJ6aPLagrmoqY0Sg=
X-Received: by 2002:a17:907:2845:b0:bdb:e19d:5257 with SMTP id
 a640c23a62f3a-bdc152607demr109803166b.29.1779364876921; Thu, 21 May 2026
 05:01:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260520225245.2962-1-spasswolf@web.de> <fnrz73n5jojl2wlbgrsjdtu5zuwykwbcjzznaijbquuovpoand@i6ihdqn7a6zv>
 <s7cu3dpioidx6mepmai6eyj2pxjs4skbw7v534zbzs6g2fwcis@cvokidcxy3xa>
 <4f548d61b2dd12e01f401ce4b8c865f238f7b23c.camel@web.de> <878q9dvzh0.ffs@tglx>
 <50e5e76bc13256e3f5b3301e92f159957c3d6762.camel@web.de> <CAGudoHGk1CP3gRQLCV85AFHKx6vBEyKySOn4J+AZVAP2FkrN3g@mail.gmail.com>
 <70676dae700e6a40989315bf31ea269a509ddc0f.camel@web.de>
In-Reply-To: <70676dae700e6a40989315bf31ea269a509ddc0f.camel@web.de>
From: Mateusz Guzik <mjguzik@gmail.com>
Date: Thu, 21 May 2026 14:01:04 +0200
X-Gm-Features: AVHnY4Jlf-yrDim2uzOH0TXtokw0U7b4OPXVrImpSSlCPvkxIq7CNbdejhw5Too
Message-ID: <CAGudoHEX=Su_ehV8nNP_6Onfh=hB6uiyTTCojR7nSOkEj6zh4Q@mail.gmail.com>
Subject: Re: context switch within RCU read-side critical section in
 next-20260518+ with PREEMPT_RT
To: Bert Karwatzki <spasswolf@web.de>
Cc: Thomas Gleixner <tglx@linutronix.de>, Christian Brauner <brauner@kernel.org>, linux-kernel@vger.kernel.org, 
	linux-next@vger.kernel.org, linux-rt-devel@lists.linux.dev, 
	linux-fsdevel@vger.kernel.org, adobriyan@gmail.com, jack@suse.cz, 
	viro@zeniv.linux.org.uk, Sebastian Andrzej Siewior <bigeasy@linutronix.de>, 
	Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, May 21, 2026 at 1:51=E2=80=AFPM Bert Karwatzki <spasswolf@web.de> w=
rote:
>
>
> >
> > Can you please do the following:
> > 1. go back to the known crashing-tag, add my fix, verify you still get
> > the amd splat and then try out the fix provided by Thomas
> > 2. regardless if the above helps, can you boot a kernel built with
> > CONFIG_KASAN=3Dy
> >
> > fwiw I verified my patch works fine with KASAN, including by
> > intentionally miscalculating the size of the target buffer and seeing
> > a nice splat from it so I'm confident I'm not corrupting anything.
> > However, as there are new mallocs + free flying around at early boot,
> > it is *plausible* amd was getting zeroed memory without asking for it
> > and it worked by accident.
>
> I think the warnning from amdgpu is only displayed with CONFIG_LOCKDEP=3D=
y, so
> your "improved fix" does not silence the warning from amdgpu.
>
> The additional fix from Thomas fixes the amdgpu warning.
>

I just wanted to confirm my patch does not *cause* issues, at worst
uncovers them.

> I also built the kernel with CONFIG_KASAN and get no error messages.
>

nice

I presume Thomas will handle getting the amdgpu patch to the right
people, I think it will be fine to drop all the mailing lists and the
cc's. :-)

So overall I think we are done here.

Thank you for testing and sorry for the breakage.
