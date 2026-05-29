Received: from mail-yx1-f41.google.com (mail-yx1-f41.google.com [74.125.224.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5561630E84E
	for <linux-fsdevel@vger.kernel.org>; Fri, 29 May 2026 13:14:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780060464; cv=pass; b=ShLhAJUCLZHB73NwakIV9BbL5I9bHsg9PLs+2O6Ovs7Ujc9YM75oXmYghjlrJkuvTVbl/bAyHmTqG2e/vRL6bFHlJb5Bodb/Xc2+2oaFOPbhl8eB8YE31dhnYzXJlTgFOZjVstws/LdS5YwebGOj3iAizaDReHqXUL1ssoWAeWw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780060464; c=relaxed/simple;
	bh=qylgKpAkiI6+L10JX1xz8/ilPns35LBgZkWOBAm9RiI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lLN1qUoYA/Tdz/HooCRPkiYMTk81sNnI3K4LLHh9hksSq7ZDwENCQQ1E6bhL7yC09RdIiV91B6xWstYfc97i7jQswCZji+oPYRh/DYDHeyWt2nt5kljXxLHG+Wv/xcKdqPtx61H+YACUq7+OCmQbUCYSzEOyJDN1BS03AgYbR0w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cgqtr/eq; arc=pass smtp.client-ip=74.125.224.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cgqtr/eq"
Received: by mail-yx1-f41.google.com with SMTP id 956f58d0204a3-660323f7b27so2612030d50.3
        for <linux-fsdevel@vger.kernel.org>; Fri, 29 May 2026 06:14:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780060462; cv=none;
        d=google.com; s=arc-20240605;
        b=GN4rPsIecvDY2QPhaut3485skXNIER2kmx+qzcpAnSlqvrzrqqWrYdFCDypuN7Zm7g
         UrldmN0qNWqUjbbxzfg4+0ycBiNlNX7hlYxGa0renJFVIvyB/F6id2mkpSi5wjYc1Dpy
         M+xyv1fhqMWkPYnpIzSvWhC3fTMmBDH+UgUHRscRWIBLphyhkmXrMiY59Op5urmwhUCO
         tmUTkDnT+IgrRgy0gMVP16gkLuVyXNL9MiEFQaYHzw85WEHE82P++RnvW/e2FERqMBJV
         v85ivw1MIuE22+oYyzKKLHRM415miryEDEU80Ulm9djox40UC9WBX3cDBslabR4zFDrQ
         QsPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=qylgKpAkiI6+L10JX1xz8/ilPns35LBgZkWOBAm9RiI=;
        fh=2UMgKuc4XbsKiA2uGwOt1jIUCueF/SoMAo0d4Regozo=;
        b=fzOHlMvCU5fiex9TLn/4pyMgGJVS9zaxpqxhHpDe5VSzE0iKbJsSRAKfs8bFrLNQYe
         cGL2SfolMf54H1pM5n5yrjWvqxeFqOeWzc+JB8ACACfDzS7VPSRGBMVOklcfnoBXR+Qs
         yzgCmDCDEFX0LAjflyW4G0TORSY1bJhfVMvMX52Fb8uqatOluPFH45mkblTH8fiB6Q5N
         z7xE6T7rbch+mLwMuCRkA+pmcztbb1eKkHH5PY0nBxRnWG/y27sgiXNa7X39aKsKKiWv
         HXKu8eWpzq/nM1tAXGf0O2Zs1bPxq9EnPdHCg2Mxa8BJ7J64upO8sC2mm/W9GSTu9iD9
         L+hQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780060462; x=1780665262; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qylgKpAkiI6+L10JX1xz8/ilPns35LBgZkWOBAm9RiI=;
        b=cgqtr/eq7NcE+o4G8sT5S+ZPAZf7+jCndzuN/wDa+SPHo5IOMPUWvVDwL/jf+Y9B6T
         XUmm1VddHvKKoxgpu7byq5U5PkaMhdyYhnNdivRz6jv0cih2MPx/c93KJbm3oSxoJt66
         V/3uD7Z4ojLLhj6nvvTmKwD1C36/P2gFIK07hJfF72keeWdAGVnrHytpaeSm7QYYHSMT
         qTJndihEQzhdalPPq8qdMN5YEYFEU6u+OJjGybTMwvsjHO59M7WsMswfWYuG2Sx60WE3
         lgVLoiSc1T9TF6BBz/gw5pZ/Q8zu51wO53GIG5Ef2558Q4ScpeTAvBwDgjT8ePccikTJ
         ANYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780060462; x=1780665262;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=qylgKpAkiI6+L10JX1xz8/ilPns35LBgZkWOBAm9RiI=;
        b=HRSuX4Vbtx/OolPm0Z4fr/Qm4nJsR3e1oZ0YdM77kynY+AYTfJO8YX+GsqDq+hD9eV
         +eVc+wzsVE+/xrMrAvKmJQX0dh8gSaqxvdK/k6UNovYCJB0L5WxCoem823OQTggC6/vn
         1puncKaySBUC2Z4NGB/ER5t2Qw/bjtagzh2cghas6A/Xhx89/h8KpjIN5FskSpXtlGDu
         1dTbMzMU37He7+4OQQo5pVqmqfGpIhV3kzYe1/RN8iTXSjn/GOnKdR9X7lb9/b/sIDqv
         gJD4E9Pe3PBjj6jD1LXp69UflCTKtVrKswpPKdd4/6+cqOU3/7VXiWK1doG31S/qgWw5
         PRiw==
X-Forwarded-Encrypted: i=1; AFNElJ8dOeSwD8VLb6Os9LbD/9xAOhJrX2SN0zP54/IOv9AshB3NPM0Mn0+CCvcSXlLRUtKigmY2I2IXW6HdPzRe@vger.kernel.org
X-Gm-Message-State: AOJu0YwP5PCv/okcgWKqTjnLOn2YSzz4Ohaov4gMh+IM/tlhPpNsU4Qi
	R33DXs1CWG5ySGTo/K1tHMB8VpEPKV1l56O7tZTTg9HdRMxNdFKGgVvSgxyA8p5Tp24/cQ+tmKS
	cjbmOYHFCwulDERPr4VCSNS5b07T0Fsc=
X-Gm-Gg: Acq92OHSHNh6oLg/kdU0XKy5bs7J8nPzbo2etzXlot04xJzuRx4PGlxbCtCBG7ImnRM
	OSGZFeA5QmMBaopu3d6Xa7GWlcMmsgPNDmBklik5reSRJX2yS7LsoAvZ27AuI5Y2D4VnqMt/O6f
	HNVDkefyGsvOFxGH/tpcrHCx80dI3iPG2j01SrLAGeHUDjY5QCqj4kB3cdMMeskbSNm+49Wi8ej
	ifFpr11GCwlkvE+zc+rMi1mpfME08ocZZTdgU0m9JZsmdxcLt2Rg8C/R9tV8rL7GOu979ofjYkF
	w36ENMetquv33ur64J6Rfw7RNfajr1BqaBK8R//ATjY8NSWMQc8Fj4OQ3X9IQy+L6l8SJ76w5mY
	Pz/rJ5ps=
X-Received: by 2002:a05:690e:169b:b0:654:acd4:9c10 with SMTP id
 956f58d0204a3-66052cb1beemr1919659d50.13.1780060462086; Fri, 29 May 2026
 06:14:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260529042507.87593-1-kartikey406@gmail.com> <20260529-quast-epilog-gelernt-a381bb87c32e@brauner>
In-Reply-To: <20260529-quast-epilog-gelernt-a381bb87c32e@brauner>
From: Deepanshu Kartikey <kartikey406@gmail.com>
Date: Fri, 29 May 2026 18:44:11 +0530
X-Gm-Features: AVHnY4JaTudYF3xNVEq0R3q7by-wWzGTQRE8GcwM96MH0MUXF21GKM5T5w0r9Ug
Message-ID: <CADhLXY4hqc3z1ddt1ZtDB7VG1Gm4Bc1avS_A6g_YywaXML4Ftg@mail.gmail.com>
Subject: Re: [PATCH v2] eventpoll: fix use-after-free in clear_tfile_check_list()
To: Christian Brauner <brauner@kernel.org>
Cc: viro@zeniv.linux.org.uk, jack@suse.cz, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, 
	syzbot+69a3d7738ad3aa175caf@syzkaller.appspotmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, May 29, 2026 at 1:15=E2=80=AFPM Christian Brauner <brauner@kernel.o=
rg> wrote:
>
> I'm still confused why all the casts are needed...

I have sent patch v3.

Thanks

Deepanshu
