Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.218.47
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795768987;
	b=DN+6vmLDZfMUrI1lqQO7OSfF8pyd/u7pn0fTETNnymnTXUX2EK8Iis90fJKUkNN0o+/T
	 8njF4jY59yK6RpmjKvvflsxnFaNwYdE66jp4lqRZpPDoqfS0e5ipFmk8kv4rnCK/8v7Bk
	 EXKtiCVQbtiI/5CcwoDVKrXO14WCvjXKircbEP+UP1GYpSdssCKR4TXZwqIHCXYSiocCs
	 mriVOwiN5yzalr3IcOijr0LJypq2vaYZAaoopSv3MGRcAZ2JIudxWQZd0WJ2yu16IzmSe
	 wIlqpzkjkADbqumg3mCa+F4TkFqmSyCRFVy70ZL7gUs+nJi+zXG57TKWjr04jY0bFQQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795768987;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:Content-Transfer-Encoding:User-Agent:MIME-Version;
	bh=q/a49TQEtxVoc/uj7/LlLfKe4HzfqdTDH8dyZw93gQQ=;
	b=pEltzwFvsR7WtZK/5UGRa8Z6gQai4r+IutfhxDFXG9JQ4QeL+tl3YA8AlP+8zU5Id2Xj
	 sA4O6oa/3RxqJ4HnV4KxiDk9FceIUyN6jJ2EdUJXJMjD0cghnpeCamw5UAlmd09xhSpZO
	 WB53JRfWCgljzJNZLJN+cBsnksnSJyxEWY5PkxV5yjQavoYv4FN+LF1P3fUiPRIn0Vweg
	 6voWW7AsVlfBk2b94ncdF1Tlimpm+miVmqzijbuycRXpdo9ClkiD85byL76hDQ6w832ME
	 qtmfMptPMbKmCRrzXmEH3gqODTzcCS3yJunIAFzLlbVyCw5e6PlhUK3zljfduDivuIw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=amutable.com;
	spf=pass smtp.mailfrom=amutable.com;
	dkim=pass header.d=amutable-com.20260707.gappssmtp.com header.i=@amutable-com.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=sYHW4TbX;
	arc=none smtp.remote-ip=209.85.218.47
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3267E606A31E
	for <linux-fsdevel@vger.kernel.org>; Fri, 27 Nov 2026 08:43:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3267E606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=amutable.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amutable.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amutable-com.20260707.gappssmtp.com header.i=@amutable-com.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=sYHW4TbX
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-c5127c7abd5so1197781866b.3
        for <linux-fsdevel@vger.kernel.org>; Fri, 27 Nov 2026 00:43:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amutable-com.20260707.gappssmtp.com; s=20260707; t=1795768985; x=1796373785; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=q/a49TQEtxVoc/uj7/LlLfKe4HzfqdTDH8dyZw93gQQ=;
        b=sYHW4TbXNzzMddM3SvLwgM4OjqhF60h5M0aoctPt/EUH8XuFKxYNDux3nEmlnY0YKn
         9ApYguSt21yJeEzHwFz9e54UPhphwadDBvgG80W4FF+/lukiTwYzJnXeUhyfyrdjckup
         2M+Xql4myEPbPAv9BvyyaOQa8aLOeXROtpM/eAXX/+Xlxpl49KhkE3elOgA7JCr+cK10
         vmbgSWCE/KrcYP/ZvNHf0gjHY/dZKBdRnF+Hr/FWrjrLIT4i8GKCFH8TapaEIjJiLlK5
         IO5FgJEjJ0XTwQG3gjNtEALfISczuyEbAbIJ13UenAS1vQ0/xqQSw1omU/ZCQXXYENj3
         angg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795768985; x=1796373785;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=q/a49TQEtxVoc/uj7/LlLfKe4HzfqdTDH8dyZw93gQQ=;
        b=pH+D4XFcYrZL2ZjlZ/UK3bwc8ZzTFpX9FC+UpZjAwPnmWbqc+cmLBrJ83w72wR1n/Y
         RC3EPn4BdLLw8LVxJER68D0iLpa63ZrhItpHvIEZlxZxdeT/klu8AA3e//Ck8nMdcsi0
         rRlRwq0nrnYHeZdq/jL7kRLrEZHuChydwinCdUtCE11jVtYPXTSXx9/zOjNdDZ+sRm1B
         7BbupKQ8Apu+BC+kKDGI8hd4Wz7u51WHbAGy5dsV5+CIFKOD6PKWSnbA8Y7PiYF/2elq
         XBeH2PRp3sM/daWAOteeVvEbhUNPAW1tbCiCPz7O5o0nB+qddbaJiMbYfoFg1J7RZf8s
         sriA==
X-Forwarded-Encrypted: i=1; AL+hErGRhzp/WasJHJSV/nUmlw9jlEUI0yrIhTg6t0R61TJC6Mz5HDEGgEQE1Uo4ucaalE0fbdu804KMas8LO6WF@vger.kernel.org
X-Gm-Message-State: APuU4Z/LWDr1wNcxDN/FQGzLpPp5XZbfTxI23qfn3B4+ZDWC5DZDD8TB
	qwZqNZjRas/9WO7PIhu4qS1IvWwqtkVQEnfTioXyrBmeQ1ZENfeYbXxDyJagebSVbp1P
X-Gm-Gg: AZFdTZelur7ZA36DU7GD82GGrPc/jUEvmtmgN3QqmM5K3mbrnsQ0+tzgL95sgAwcYlt
	r3orpO0FgzlKVtbR/57pqffNWt4Qu3Or0LAL7bLH1nmGkP89D9l91r8Cgy5k0fsqTqa3LFBWGc8
	b08AI1NUnIWE3+YysbOQgojKdlY27oUPE+0u7mWC+dXorOahLkAbo6vNR2UT24h48NO4tL+WoGK
	Ft64YHJjpANjUsh1H0Oo45SF0fX0EpP2LSCTPfn4fj02hqlBCV2Q+rqSffa+Q6Geb/7tVSdvaj4
	m+pOcFhRrqPCp2aLzF5ypxNHL3IkeOnEW9DkXqeejXdK0NmTHkWRnW/8zzKRGGZZw/LkaKtGh8k
	sQWizJnMk5qm6BTNBKjgQORu284qW1gKkQl67qIQ9bauRjcwsV+KbY0ynNPoNCibC2fyKXDqRSj
	5BEA4ST5sqoxbkydEgwS4K+2IyQCDMLASs58oXgKUM4y1Zc5Ijc2PCyGkK3qKdGjyX5N+EKC2CB
	ypdCmSuGdE9PV625qDr+Zz8gSfrn/dsEotwLrdXjgTbQX9owuI/WdxlnKwhKJ57YyvHrqXWZAwO
	Eq+OZAhAwG39YQBh11xEvjUixEkwBmtK1AyP/O3li2vxMuY2xvjpTArlTU9WcDdNmw==
X-Received: by 2002:a17:906:eec9:b0:c51:5589:35a1 with SMTP id a640c23a62f3a-c515589d211mr1535450966b.5.1795768985487;
        Fri, 27 Nov 2026 00:43:05 -0800 (PST)
Received: from [10.0.0.233] (tmo-084-240.customers.d1-online.com. [80.187.84.240])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c513ad01b0bsm839818866b.10.2026.11.27.00.43.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Nov 2026 00:43:05 -0800 (PST)
Message-ID: <ecba7d29cc3bfb0e18ad72d2a9690da41f66c832.camel@amutable.com>
Subject: Re: [PATCH 0/4] fat: support O_TMPFILE
From: Alexander Mikhalitsyn <alex@amutable.com>
To: Christian Brauner <brauner@kernel.org>, OGAWA Hirofumi
	 <hirofumi@mail.parknet.co.jp>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Date: Fri, 27 Nov 2026 09:43:03 +0100
In-Reply-To: <20261126-work-fat-tmpfile-v1-0-3bca7b2dbc20@kernel.org>
References: <20261126-work-fat-tmpfile-v1-0-3bca7b2dbc20@kernel.org>
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

On Thu, 2026-11-26 at 23:15 +0100, Christian Brauner wrote:
> This adds O_TMPFILE support to vfat and msdos.
>=20
> Currently, every O_TMPFILE open on FAT fails with EOPNOTSUPP and
> userspace falls back to creating a named temporary file and renaming
> it
> into place. systemd does that in bootctl when it writes to the ESP.
>=20
> FAT can do O_TMPFILE just fine. It already handles files without a
> directory entry: when an open file is unlinked i_pos is reset to 0,
> writing the inode does nothing and the clusters are freed when the
> inode is evicted. An O_TMPFILE simply starts out in that state.
>=20
> The only tricky part is linkat(). FAT has no hard links so I added a
> ->link() that only gives an O_TMPFILE its first name. Everything else
> still fails with EPERM. Adding just ->tmpfile() would've been a
> regression. systemd only falls back to the named temporary file if
> the
> O_TMPFILE open fails. If the open succeeds it calls linkat() and
> gives
> up if that fails.

Hi Christian,

>=20
> Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>

For the entire series:

Reviewed-by: Alexander Mikhalitsyn <alex@amutable.com>

Kind regards,
Alex

> ---
> Christian Brauner (4):
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 fat: add fat_tmpfile()
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 fat: support O_TMPFILE on vfat
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 fat: support O_TMPFILE on msdos
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 selftests/filesystems: add FAT O_TMPFILE t=
ests
>=20
> =C2=A0fs/fat/fat.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0 2 +
> =C2=A0fs/fat/inode.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 |=C2=A0 31 ++
> =C2=A0fs/fat/namei_msdos.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 70 +++=
++
> =C2=A0fs/fat/namei_vfat.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 46 =
+++
> =C2=A0tools/testing/selftests/filesystems/fat/.gitignore |=C2=A0=C2=A0 1 =
+
> =C2=A0tools/testing/selftests/filesystems/fat/Makefile=C2=A0=C2=A0 |=C2=
=A0=C2=A0 2 +-
> =C2=A0tools/testing/selftests/filesystems/fat/config=C2=A0=C2=A0=C2=A0=C2=
=A0 |=C2=A0=C2=A0 1 +
> =C2=A0.../selftests/filesystems/fat/run_fat_tests.sh=C2=A0=C2=A0=C2=A0=C2=
=A0 |=C2=A0 41 +++
> =C2=A0tools/testing/selftests/filesystems/fat/tmpfile.c=C2=A0 | 324
> +++++++++++++++++++++
> =C2=A09 files changed, 517 insertions(+), 1 deletion(-)
> ---
> base-commit: 2dc60bd9975fc8666a13d58410499e06e6799ba9
> change-id: 20261126-work-fat-tmpfile-0d0f49e95d8f
