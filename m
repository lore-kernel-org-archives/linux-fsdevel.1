Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 290371EEE6
	for <linux-fsdevel@vger.kernel.org>; Wed, 11 Mar 2026 02:07:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773194855; cv=pass; b=t5pUSQRiqFGUX/p1/DqCCQciWuXZKcP3c53bhAYlzNbsP3ut3MCl9gvnmQMAJA0Uhlm7UWOw2uML9zxD++rb+jNYPzV80Hp+EvOMSrmaceHWDFxhDo0kA+x6XEsPZS4dI6mjmoEXr/qppePr45I4aWQj7ufrI+KRNiXVYdMI8t0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773194855; c=relaxed/simple;
	bh=8UJnLa/DDQ+b65RDSHa97nR/Rm6zetnRjswOkVb13wc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BXpJVfRbo4LlXCcOZcdMTSZguzp+cVIx0KISpfGfBR5GZsgpQoVAlwFx48a7FZe92mvAfCs4pISJzIGD35j4fUHxXz1jh6LAAkO/dRo3RdeyRnOvOMKB8uyqlSRY6aMKh1lACEP4J4hko00bjgaT9gA/dJ05ihAnODVVoWzn1po=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=SqpOgAb4; arc=pass smtp.client-ip=209.85.167.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="SqpOgAb4"
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-5a0fc5e2c59so9992842e87.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 10 Mar 2026 19:07:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773194852; cv=none;
        d=google.com; s=arc-20240605;
        b=jM93D2XEqyfv+LVABgRKQfbrsJlcmeb1RkZtm1rQ4Rw4kJEg/6DG5PsV5Nbrv2WhEv
         GKN1ZEM16/wT+x7DvF8uPVbIRkY0cgD2QmNo4Lylw2ae7/FJjtHxaKkkG466S16MuupR
         0EZBvC18YI1P1qWyfJjRkLO4B26JQDbZ9VZa+Rj1k1SMxdRzhLZhRjkzK6HB6vrp67Ch
         L+qNw9L/6r9eViV272cQl3kTTCFdnsmJs61urK1q1geG9+MjpBSTHPgAt5ArjF48tCOq
         I0CItlhy83FrtgTb2cGnbUe/tjPGEPLhqKWmIctLD35hmd9xkaL4e61bw4drzIHarrLI
         +v+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=+zLBLQzKjcztDlxJqoLP6w+B6xnZmfHibV4jlBQCebA=;
        fh=aMGycohOUI4MwGTPG/Ooe5U9FhmJmN61mlwgHVJ/6hQ=;
        b=VsJDL2BHrFKUNCShsMfILmpi9msE3esePEaHvKhhnOM4OLYBf7+ALuK3+QMHC+omQB
         S75qRFgdv9j8VFnYwe/XBVtAwBHU3RPfDjwGT7MDLwCmcNBzbX8gF+fxDYRjcuvVAWWO
         nHvZ/EyqZFXoUggcz9Wrp7D2TrmYi9hEepoyTcP6CqO6OQbcUpOODb1W2ZOJVJhM3wVc
         d3dsa5U/FcKbs/dxGU7Q4tGRl0TQQ3dLVN7n8qlRZH4iq8AbX8RlurVG/2bkp7GCfwge
         2RJNAdK0aOQz1bmkNNglPfWD4s5GuNlHZ7XbmfCTe6jyIImCBb2YNar1W9YwudwaHO2G
         sPVw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1773194852; x=1773799652; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+zLBLQzKjcztDlxJqoLP6w+B6xnZmfHibV4jlBQCebA=;
        b=SqpOgAb4CQOCp6QT1IhDiJXNOENCCAthmmQiQ2Xm1LqdH6AuNnr9pWEOxoaM6J2EHp
         TaZvrNsWvEAAdeAh3rGZCGLrxzU767HUy57VJt43+079ae3+2kuAr2+JBVbU8T9+l/BT
         vjjO+GANIyds0bGFgUhdgNG0FnF3NJi/nWQH4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773194852; x=1773799652;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=+zLBLQzKjcztDlxJqoLP6w+B6xnZmfHibV4jlBQCebA=;
        b=qnf4NRnqv8FDmKfsyXj6s/aMagAQKTzRfk2lsr1gIHBguG9gAWX3wo6OoN2XRinast
         0nG3WKqiuju9NlS868EizBenzF15854hNrbu3dWeKOJoy4YtfacB9PMKPGAIx6YkHEyb
         IPu3BcUh71qNRiOHcKi65+tZabQdlwMNgfUKHF8Ri3hA23kKCTKZGoFGpRhAEIBkAcTs
         PVza+j5ZOR+CmLLPGejYPew+LBarVl9Mcdjyl/YgFeI5q/Fbo6x180LP2WEWDXc/moBJ
         UMQaxjPNoxELoSBYsiAuysb/E2XgDZ1I2kn7yCVbDI5QkaCd/tJWhgtAO/VTMdQWSLmr
         Q7Bg==
X-Forwarded-Encrypted: i=1; AJvYcCVvef5mqVFLtWNURBGV5JhyM+RFtzU2BNvfMe/Y1WTXsdyvvNw89fUuN7ZX+JAZh6vEfmdBvJEjZfwE6NVj@vger.kernel.org
X-Gm-Message-State: AOJu0YwGjAEgibTaGKINO8uVmeQ9hO2cfiAxxX9Js3lyZNSEKRCtL8k3
	bWqLdTa3chBGDTYUtiwXwt2bITd6Q07rHaOaOyOCrJfalD30ZNHkSo3dxEaYYSaqVMAnkdpHzT0
	4Pd+CftHFmcvZE6O2qahK2wDyuLbzRpZ5Pxa0j/h2
X-Gm-Gg: ATEYQzyl1JsWrrKcZPBkVYSmFwEqj3sFENjOXhFIQHkni8lsaf0noVE86oF2bOxviGB
	6t3MhiatXy4iVVmKKMv6Ev3jDwyqQQdXqxehbAfHJFyB1n/uiq9I5PZ1sVVY9as8MiYdjDIfj51
	KF8pa02lPRBIweaa8IBzxgsgEWNndBn3MEJDXeh/AKT8o3nTuUt/CJqhdlGQkOm0YFR4RYeHjuC
	A7BHcyQ01CxsczLqPgHHslkyF1VHp0GZcQsL75r9dpylHB6386I8t2ubJ7vKYJa7U7gSCpXaCt3
	JQgIT+u4xQ==
X-Received: by 2002:ac2:4427:0:b0:5a1:3134:9bac with SMTP id
 2adb3069b0e04-5a156cbd1bbmr169453e87.28.1773194852284; Tue, 10 Mar 2026
 19:07:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260310-b4-is_err_or_null-v1-0-bd63b656022d@avm.de> <20260310-b4-is_err_or_null-v1-56-bd63b656022d@avm.de>
In-Reply-To: <20260310-b4-is_err_or_null-v1-56-bd63b656022d@avm.de>
From: Chen-Yu Tsai <wenst@chromium.org>
Date: Wed, 11 Mar 2026 11:07:21 +0900
X-Gm-Features: AaiRm5028PWt8n-JnveiRgn8oYMksdR_-_nk4JOkvxMfplWs-GDr7RRk-OxICyw
Message-ID: <CAGXv+5FQAVaJjqhv+Xq-ysOc4SHQn2mCNTgCAp8XocmWBWGGoA@mail.gmail.com>
Subject: Re: [PATCH 56/61] clk: Prefer IS_ERR_OR_NULL over manual NULL check
To: Philipp Hahn <phahn-oss@avm.de>
Cc: amd-gfx@lists.freedesktop.org, apparmor@lists.ubuntu.com, 
	bpf@vger.kernel.org, ceph-devel@vger.kernel.org, cocci@inria.fr, 
	dm-devel@lists.linux.dev, dri-devel@lists.freedesktop.org, 
	gfs2@lists.linux.dev, intel-gfx@lists.freedesktop.org, 
	intel-wired-lan@lists.osuosl.org, iommu@lists.linux.dev, kvm@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-block@vger.kernel.org, 
	linux-bluetooth@vger.kernel.org, linux-btrfs@vger.kernel.org, 
	linux-cifs@vger.kernel.org, linux-clk@vger.kernel.org, 
	linux-erofs@lists.ozlabs.org, linux-ext4@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-gpio@vger.kernel.org, 
	linux-hyperv@vger.kernel.org, linux-input@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-leds@vger.kernel.org, 
	linux-media@vger.kernel.org, linux-mips@vger.kernel.org, linux-mm@kvack.org, 
	linux-modules@vger.kernel.org, linux-mtd@lists.infradead.org, 
	linux-nfs@vger.kernel.org, linux-omap@vger.kernel.org, 
	linux-phy@lists.infradead.org, linux-pm@vger.kernel.org, 
	linux-rockchip@lists.infradead.org, linux-s390@vger.kernel.org, 
	linux-scsi@vger.kernel.org, linux-sctp@vger.kernel.org, 
	linux-security-module@vger.kernel.org, linux-sh@vger.kernel.org, 
	linux-sound@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com, 
	linux-trace-kernel@vger.kernel.org, linux-usb@vger.kernel.org, 
	linux-wireless@vger.kernel.org, netdev@vger.kernel.org, ntfs3@lists.linux.dev, 
	samba-technical@lists.samba.org, sched-ext@lists.linux.dev, 
	target-devel@vger.kernel.org, tipc-discussion@lists.sourceforge.net, 
	v9fs@lists.linux.dev, Michael Turquette <mturquette@baylibre.com>, 
	Stephen Boyd <sboyd@kernel.org>, Daniel Lezcano <daniel.lezcano@kernel.org>, 
	Thomas Gleixner <tglx@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 10, 2026 at 9:57=E2=80=AFPM Philipp Hahn <phahn-oss@avm.de> wro=
te:
>
> Prefer using IS_ERR_OR_NULL() over using IS_ERR() and a manual NULL
> check.
>
> Semantich change: Previously the code only printed the warning on error,
> but not when the pointer was NULL. Now the warning is printed in both
> cases!
>
> Change found with coccinelle.
>
> To: Michael Turquette <mturquette@baylibre.com>
> To: Stephen Boyd <sboyd@kernel.org>
> To: Daniel Lezcano <daniel.lezcano@kernel.org>
> To: Thomas Gleixner <tglx@kernel.org>
> Cc: linux-clk@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> Signed-off-by: Philipp Hahn <phahn-oss@avm.de>
> ---
>  drivers/clk/clk.c               | 4 ++--
>  drivers/clocksource/timer-pxa.c | 2 +-
>  2 files changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/clk/clk.c b/drivers/clk/clk.c
> index 47093cda9df32223c1120c3710261296027c4cd3..35146e3869a7dd93741d10b72=
23d4488a9216ed1 100644
> --- a/drivers/clk/clk.c
> +++ b/drivers/clk/clk.c
> @@ -4558,7 +4558,7 @@ void clk_unregister(struct clk *clk)
>         unsigned long flags;
>         const struct clk_ops *ops;
>
> -       if (!clk || WARN_ON_ONCE(IS_ERR(clk)))
> +       if (WARN_ON_ONCE(IS_ERR_OR_NULL(clk)))
>                 return;
>
>         clk_debug_unregister(clk->core);
> @@ -4744,7 +4744,7 @@ void __clk_put(struct clk *clk)
>  {
>         struct module *owner;
>
> -       if (!clk || WARN_ON_ONCE(IS_ERR(clk)))
> +       if (WARN_ON_ONCE(IS_ERR_OR_NULL(clk)))

clk_get_optional() returns NULL if the clk isn't present.

Drivers would just pass this to clk_put(). Your change here would cause
this pattern to emit a very big warning.

I don't think this change should be landed.


ChenYu

>                 return;
>
>         clk_prepare_lock();
> diff --git a/drivers/clocksource/timer-pxa.c b/drivers/clocksource/timer-=
pxa.c
> index 7ad0e5adb2ffac4125c34710fc67f4b45f30331d..f65fb0b7fc318b766227e5e7a=
4c0fb08ba11c8f9 100644
> --- a/drivers/clocksource/timer-pxa.c
> +++ b/drivers/clocksource/timer-pxa.c
> @@ -218,7 +218,7 @@ void __init pxa_timer_nodt_init(int irq, void __iomem=
 *base)
>
>         timer_base =3D base;
>         clk =3D clk_get(NULL, "OSTIMER0");
> -       if (clk && !IS_ERR(clk)) {
> +       if (!IS_ERR_OR_NULL(clk)) {
>                 clk_prepare_enable(clk);
>                 pxa_timer_common_init(irq, clk_get_rate(clk));
>         } else {
>
> --
> 2.43.0
>
>
