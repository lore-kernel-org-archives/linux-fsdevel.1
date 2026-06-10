Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77925429811
	for <linux-fsdevel@vger.kernel.org>; Wed, 10 Jun 2026 16:00:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.180
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781107220; cv=pass; b=gis/huQjG1jRIkns26eZTGCKrsPdpjPcp07RIKRMpuljWaserVK7BwiCFEOH+8EaPh4EQdoRWnLIIvP/8RzEOiL9shEovQqn9ki1NbGUgV+ptXJq18G9NFJ7bHXcI/HLCvD4D0+V6KWmNXSrWXPLlOZUrZUjCsJYU3br/DtWPaM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781107220; c=relaxed/simple;
	bh=FDKcaug90NBdb3eAv3Qp4jgmXypjdjtoUU7uT9ckXrg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oMp+/yXhGHVOcnLq7gSLoMQMkENjoW3a5MnuxYrK38s4mePI6+SCi766p/dKv4cC+wxBUYGAZ8mFJtgiVzMZCzRsxKMEFeqGYthRipANUoY4NKPmCf05RnV7C1Lip71iYzt15L5TU2rlhSKxVr2ivr/bc9GhRyJej2ebu0wSILA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=LOsDAHgq; arc=pass smtp.client-ip=209.85.160.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="LOsDAHgq"
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-51765531803so483871cf.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 10 Jun 2026 09:00:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781107218; cv=none;
        d=google.com; s=arc-20240605;
        b=kIGMc7WVPNza/OIcdxk2SYD/Oa0S2d2A1nspihXO/21wXsJ2ASUlvBYCl/7pYwDTcE
         Krn6pMZ9dyAg3RId3fXJGXjCNFNFMy26VxtogjAIH/tDi0QyKU2IcldF6TAFWwbW1pq6
         NMiM99gJC3/3saKaNXHyer08xMu3s5trkFiYTGYf/2qwMar3+pi7K76YBB2nLTvd9wGG
         qAo0B9j/f3WMxK+Z14P8eWu92yfhlMR8gEg/d44VjcMWWWMxklzqqHS0px7w6zBnRKKc
         HxsKSkYL6oaOPY/ZvSuuOvuP+1ZKm51T30IWBK2185E7SBRZCDdl3O0bFSHrhycqM9ob
         1rhg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=VEDUkC8AXaU4PRdZaXQ1N+8ibbW+O3iaY6lkOQGumLU=;
        fh=b042MjELl6TYrrYu0PvEdH+8XgXX75SbJBiikk74NEg=;
        b=aBN855uWRy0ZR8+PT/UCHUHiQTjaFc1i2/Q1ugFT0RfGDt+B618JO8B04XbGZTqKbS
         WKxS3Uj6QzwwFY4SBM5Hv8gDwhfXIEGwWAqpVE3QrC+iE7QEa2fQXDxE1pc+6cfmeaRn
         BVyMGUJj0vFcaWkWkqL8mImBtV8uuHzh8MvJwNB+ynJwHpELQgqk6JF4H04CbNSKaCh5
         Ink5TLZO+Yu91VR5L+QRMpXKSHmReff34AGIJiIYOEi5zhoK4y2tuYDh0q8Sc8e7+7kp
         qnUptdb/O6HGQejR4YFSbJlk7TKhRM1bjnSNL702ny8fN5ctvKLvxcm8WD2Jocwov+Aj
         DtGA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1781107218; x=1781712018; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VEDUkC8AXaU4PRdZaXQ1N+8ibbW+O3iaY6lkOQGumLU=;
        b=LOsDAHgqbFt5qPHxs98APkKZOGALE0+yXUQYY7V7iTi17zzflIvWEDV1siaf8JGO8s
         GCMeHkk9v83sTTFLP48jjqngMvQE5Ww5/rOi0FapBqP1OtGP2rRBsOwMbE6xg8eR1gnw
         KkXyBFDshibO/kpYxvOYtnU7SXomH4djMEaJZnSFVa9FQjF5wxxau2hwWVlVfnoOVI51
         pHO5isIZK7Uv8CfNji2KIFm/g2FDVKpzTrHaVGHWiO5z6oY1o+BHiWgi6HPsCovxb5EU
         R8iiKRTmlMaVPsqVlRdkaUGSrARGI8UoTCgFAIemrWhuSBy1NolEdI+76LPAhYdmgK3q
         BRlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781107218; x=1781712018;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=VEDUkC8AXaU4PRdZaXQ1N+8ibbW+O3iaY6lkOQGumLU=;
        b=oBfYLwLDxIPyBPHvGV/vW7uJ8Y77fi/Pu0uIeU4Gl/qoVHolgPBEAHLdDIoaF7kjTh
         VgbI8ashqnJ1NhZB1pdxnUVjejI+oIn3v+YfmffelwKuvN/lIGSpX5VxP9I+CXTl8ayz
         jZLiUJDB3X1LICFz2djfPxGszbUsqJ77yVNldsH6GWwHhIEXoIIe0pKPwsGpMP5wcWON
         G0p9rzWErBFrGc3F8U0IR8g3rTfCI1x6yhIFWlXLa1fV0lgQFvURVhf7YZXj/KiOdviE
         A0xBnDPztXkKrDUFWXr0Iz/IsPRI4IoD2xy6+2dqiPEl16IRpRJ5Lux47uIiv5DrHBdb
         H2aQ==
X-Forwarded-Encrypted: i=1; AFNElJ/Zcox/Ucg1WLahhY4vSVg/AU3+ujA77e2eKVCvWcDAhLG0/LygPCHgQa3q99xjNo6zHW8oLlrK3zDd+5kH@vger.kernel.org
X-Gm-Message-State: AOJu0YzG/bP7VK37MU381mG/6nJsB1jZj6XLlPVqZ3GLjisk3a8eg6Rg
	7BzJWM4lql9OH36fxwn03PeLvzUZ3LYCr1wcS42WxYUpdH9XVF2lrpoJfQ2//KUOlgi04tlVupR
	4HmtWqyd2/b6e3av5mvGFwrjrLFR5FxaqgSKVSu9V
X-Gm-Gg: Acq92OGzq39Cu7cyrVmiSX91wCKLrNvBr/rGub8hY0/M6FR8HtIhlA/BUN1HEEuxF+m
	+BnoA6Tu2q43PtMdAZzDL3GooPseaR6Uc/JJJAzgZveJTrYccrvVp+V2vePCZy1mJQmTEMLRRqY
	qgey3NVrJNWpt9NBL8mr7bNMKldGxcb3N/lRyxJmEXp6eIVnmI7hPWy7Usl5s9CUGE1gBwrxNmW
	dhZcr6RfwfpTsi0ebZE2YVPKSZTtBbOwTy6E3slF+gs3+yegwDtj2TFGOJm7EQjhY2NJJ8lE9oC
	FbWiUS9dN0STCXWA4KaDUAX+pjhxPpmR86eh11WFTpy4/zjd
X-Received: by 2002:a05:622a:4a0c:b0:4ff:bfd9:dd31 with SMTP id
 d75a77b69052e-517e98c90e1mr820931cf.5.1781107215898; Wed, 10 Jun 2026
 09:00:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260606015729.1837935-1-surenb@google.com> <20260606015729.1837935-2-surenb@google.com>
 <aifO_rCurVhFRTcl@lucifer> <CAJuCfpFOpvNmV4aHnk3Vi0Jg4vF4Cmsm86h2vODZ84FVLXt9yw@mail.gmail.com>
 <aikLCwuzqBetvDrf@lucifer> <CAJuCfpHX5zoaD9XxDGbpXHs5U_8OrRyRuk=Nx8CjDb5qMNy0jA@mail.gmail.com>
 <d05e51a6-428a-420e-b6ba-54f94d029f1e@kernel.org>
In-Reply-To: <d05e51a6-428a-420e-b6ba-54f94d029f1e@kernel.org>
From: Suren Baghdasaryan <surenb@google.com>
Date: Wed, 10 Jun 2026 09:00:04 -0700
X-Gm-Features: AVVi8Cf8c2ltD77T6hmJFDSlT2HwjMv7U0PwhT3D91ZCpnXZBbc7zzCdnWOEZWo
Message-ID: <CAJuCfpFwkkeA8e77s-Hm0YdxMJ2Y60vu145pZw7iiXtNoDzTzA@mail.gmail.com>
Subject: Re: [PATCH 2/2] fs/proc/task_mmu: read proc/pid/smaps_rollup under
 per-vma lock
To: "David Hildenbrand (Arm)" <david@kernel.org>
Cc: Lorenzo Stoakes <ljs@kernel.org>, akpm@linux-foundation.org, liam@infradead.org, 
	vbabka@kernel.org, willy@infradead.org, jannh@google.com, paulmck@kernel.org, 
	pfalcato@suse.de, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, Dave Hansen <dave.hansen@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 10, 2026 at 8:02=E2=80=AFAM David Hildenbrand (Arm)
<david@kernel.org> wrote:
>
> On 6/10/26 16:56, Suren Baghdasaryan wrote:
> > On Wed, Jun 10, 2026 at 12:05=E2=80=AFAM Lorenzo Stoakes <ljs@kernel.or=
g> wrote:
> >>
> >> On Tue, Jun 09, 2026 at 10:11:03AM -0700, Suren Baghdasaryan wrote:
> >>>
> >>> Ack.
> >>>
> >>>
> >>> Ack.
> >>>
> >>>
> >>> Sadly, for now we do (see my later comment).
> >>>
> >>>
> >>> It looked nicer I think :)
> >>
> >> Yeah tbh I think you're right
> >>
> >>>
> >>>
> >>> Ack.
> >>>
> >>>
> >>> We need it to avoid resetting vma_start, which is being reported even
> >>> when no normal VMAs are present.
> >>
> >> Well previously smap_gather_stats() would just be a no-op for a gate V=
MA, as it
> >> has:
> >>
> >>         if (vma =3D=3D get_gate_vma(priv->lock_ctx.mm))
> >>                 return;
> >>
> >> Not sure if you'd have VMAs past that (is that even possible?) but in =
that case
> >> we would have set vma_start previously.
> >
> > I should explain this case in more detail. proc_get_vma() returns a
> > gate VMA once it finds no more VMAs. So, in this case if VMA tree is
> > empty, the first call to proc_get_vma() will return gate VMA. Now, the
> > original code was using vma_next() and would return NULL when the VMA
> > tree is empty and in that case it would bail out early here:
> > https://elixir.bootlin.com/linux/v7.1-rc7/source/fs/proc/task_mmu.c#L14=
23.
> > I need to use proc_get_vma() instead of vma_next() because it works
> > under RCU. So, the new code matches the previous behavior, but the
> > condition is different. I'll see if I can resolve this in a nicer way
> > but that's the gist of it.
>
> I guess some well-named helper that encapsulates the check would already =
help.
> But maybe the whole logic can be overhauled.

I'll see what makes more sense once the cleanups are in. Thanks!

>
> --
> Cheers,
>
> David
