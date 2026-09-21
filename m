Received: from mail-oi2-f12.google.com (mail-oi2-f12.google.com [74.125.231.204])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DD8B4F5E08
	for <linux-fsdevel@vger.kernel.org>; Mon, 21 Sep 2026 18:16:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.231.204
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790014579; cv=pass; b=hfTZseRwWYtgvi2NvB8vg8z6f1pZuWDQbBwuiOo1RQ5jwmG646TGOwmK1abEe0LppcKeWT7Wwgm72ymFxwThCuHZARcLkrCgiIKKop86Uzo6nHqxHMzct6fTVE0R0KJXQl6V8BwU1ltqYzidOFrK/sSiH8qX3efXuW3OoiYLnQM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790014579; c=relaxed/simple;
	bh=kQtPYSl7bHhTOTgCW2i8m6SCW7df2sqm6ruQrNx24Ow=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uVndUlViCqfbrBy/SKbCG2BjFYtyVK/aooN7NHAX3qsbonG1KZr1SsZkQ4CJ8ly632ZdQBn0zMznGBXOOFRsxA+LUvymMkkb07gkJnbPdnSsuaPFpaTrU4PG+n5PjOMydXfioZLEeAgBU69EF5URUu5X5y4guJd/7M/eRtAOwwc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=arh2CsAv; arc=pass smtp.client-ip=74.125.231.204
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="arh2CsAv"
Received: by mail-oi2-f12.google.com with SMTP id 5614622812f47-4b37a316adfso2570470b6e.2
        for <linux-fsdevel@vger.kernel.org>; Mon, 21 Sep 2026 11:16:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790014577; cv=none;
        d=google.com; s=arc-20260327;
        b=VYt9WzvaYIG0VimNk6l+E/hkqRTk/TxJxTQccLM+Xao79IV3OoZxd64zpRyNkQSp3g
         qKo4Jp5wFCTTZVKWP16KMuI0evknXCsmIkkzkxlvNN4Bpr+CBkyPHzFpszod3BZdU0+n
         Tt7TPcnbmR7g5n38iuZx/vzIt01Of6viQQKX7CgYJnq9BZfffbN5VfHbobyO76lAtU4+
         nY33hr+UBCTYxGsjmLnG872kUlTLzeRf9O+qZxLU/SsyV+IMmA49ZUUbDgAAk0EtUfhF
         xWBuayZZ9tH85V3FQ2VxUxF0p9/E+Guvdn4Z8LseWYdRWcEFiZppkd3eT1oRzVF8Cslb
         081A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=XoAohc/oZmCo8GVd+NHkqD6t+jhnykYm3ciXI8clm2k=;
        fh=yOiudSuk+B/rR47n2F7nA/XPr/J7mTeztq57UTMxu4Y=;
        b=X8LX2sHlz1p4o8fp6OP9clGo0u0x+sdY+6PXWVfZdLMGwyfauXkJCKDVu/+MAJcc/S
         Q7frad1DjmxeFWlaDkpPS3HOcSZuFXN1uzT8A6uSfX/Qk7YM7zVjd16dxcFPxAcIEDGO
         d3CowKa28pIwyFMGwqGour8t0uiqIpXt2oJhlHYnfdWsUlK+ROu2q8ljFIEXwzk7kkUG
         zck+tvU6lgR/vuB22t6jMw2snG6lW97cYdqoTn8YCszI3GdV00/jN3m/K1nww+LBIW/U
         NFx8UHhX0X2ee7dc/ah1HWgCGy3O8cfDoo/WSriLzC9G6TDR+U9bTRDTGOKOhSulpi+9
         6ohw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790014577; x=1790619377; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=XoAohc/oZmCo8GVd+NHkqD6t+jhnykYm3ciXI8clm2k=;
        b=arh2CsAvM+llBWkuU04WH4ERkMzAnWHZTK4bOFg3bU6zMmYSBsGcn52hT4AXwP7YYP
         QkEjgEsyXW57dDZFWagJ6yLSdYrMqpHd+syXM4bvFKXAy1PkBmY/o02WPx1yEsGsqZpd
         YcN8sXe2Y/lY1e/kuJbOz2zl7d+Di6uvzdY73zpgCvenc0KHykTUGnUyOeM1+THCFjhW
         uAc6bsba2b4P35JMMbU+EwOOJ4rF3RO1x7ovzU9qooi7wHTnmJkM8qJ80j1IkZW1YsO9
         NFHIl7Yjxm2TgqSmKVBaqKrIC46ZAdGL5cAjiiil0UWzh4NZz2Jg0O0We5yMHEeVqbc3
         WzPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790014577; x=1790619377;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=XoAohc/oZmCo8GVd+NHkqD6t+jhnykYm3ciXI8clm2k=;
        b=ecGir4kO8aKrOHkdpB+ykFD0vuz0lJSd4h5QIOrU6XL/RMCCzr1NfxB52m15HQB4Vi
         6aCeSeIr6MMPUSUqf53KJ63Kpln0sHKXgiSDduqqIaIbLzzTpoNExHLpSVGYsh7yaDeh
         slPs39V3Sd6XUMW7zYQskjDIMo41q7v10DM1E7DLv9kkBNO4RSq3/9PvhvAskmkULJ8E
         s8ukwDFCe1pxA1fzA8kJPguj1HHlAQINpOTmldMF8LKeHQf6h2Ek4TPSR0St/JfrufGL
         cFXELNqUIzkY9qcdhXvJA8g/gFIYKKELFf+Ih30Afy3oKMEspnzK96WpblwSnJiDVxQ7
         A8uw==
X-Gm-Message-State: AFuF++knNs/0gweQY+xrI0FgkddzPxQjk3k7BqjiBxRfdekKfKEE4EBC
	u7sOlld431/ObSWALghdCmvCNAJKcdn5nXlGFszsGePhBS2HmWO/7tYbk6XdwxUsuVKz857cL4/
	XPc9tPHnBWkSX/Tp09R/XvgosWe919pM=
X-Gm-Gg: AYBFou06by3dYGjXyvDc1iCU61FCLsGs2fhTbxQbLRiPc9xn7iBLDdesM4aAgEbgPj3
	0kYoqJaQk+nmT916jkRwYJt2hVbkmNaUO9LoimVqNbsqyfQnfZN4np+FawfORJt8QuGqwCPJyea
	oB+zpmZL46rekgDQc/SxcaoE1/9XIFaCzLWUo7OSlpvWoEDh3xTYGLgYIDJpvDcPC4H2n4Sr2yr
	DFD5Fy3ZoKFy6Wk/Sxa1kY6+YOVV+nmQ/qq2V9SCw1fEPApGlrjj2qDaMy4Rr0TbKof4M2QS+NE
	XyAtNvwUI6n0/26kQ2BSXjtcbQKyE6lGWuvYz9C+GIr8khUbyvdsoTGqK1fNiQ8yU0HDKsP0M4f
	3S4ht7ZDFqvIJ5wTz1oXY8lfZicwb8HLJg8MVDc8f
X-Received: by 2002:a4a:ee17:0:b0:6c3:b78c:8e21 with SMTP id
 006d021491bc7-6ca9af40f37mr10327142eaf.21.1790014576770; Mon, 21 Sep 2026
 11:16:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1787770110.git.jbingham@gmail.com> <e7ab836149f814b04017905dca2e07a4c94078db.1787770110.git.jbingham@gmail.com>
 <aq1GsO6dkS747OEb@infradead.org> <CAMyBmMA5bOaGK0TfPMGpmfR6oD0k9EdS4_R3RoJ7d5QTjm0bqg@mail.gmail.com>
 <arDTnjK84EGsIeYE@infradead.org>
In-Reply-To: <arDTnjK84EGsIeYE@infradead.org>
From: Jeremy Bingham <jbingham@gmail.com>
Date: Mon, 21 Sep 2026 11:16:05 -0700
X-Gm-Features: AcwNN1VhcUYnA_BgycWs1X0gtTYnMaQMUuvmZXTv_tc95zD8EYbwB3pOSB_oS8U
Message-ID: <CAMyBmMCAGFR5nS=SXA7rMRxxnnbyTAVnych=_1sxo7vGVugrWQ@mail.gmail.com>
Subject: Re: [PATCH v4 2/3] minix: add iomap functions and definitions
To: Christoph Hellwig <hch@infradead.org>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	brauner@kernel.org, jkoolstra@xs4all.nl, jack@suse.cz, djwong@kernel.org, 
	viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Sep 20, 2026 at 11:50=E2=80=AFPM Christoph Hellwig <hch@infradead.o=
rg> wrote:
>
> On Sat, Sep 19, 2026 at 10:51:32AM -0700, Jeremy Bingham wrote:
> > On Fri, Sep 18, 2026 at 7:12=E2=80=AFAM Christoph Hellwig <hch@infradea=
d.org> wrote:
> > >
> > > On Wed, Aug 26, 2026 at 02:41:56PM -0700, Jeremy Bingham wrote:
> > > > This patch also wires iomap.c into itree_v1.c and itree_v2.c, simil=
arly
> > > > to how itree_common.c is included in those files, and exports versi=
on
> > > > specific versions of minix_iomap_begin and iomap_ops.
> > >
> > > Can we keep the iomap code out of this double build mess?  Just defin=
e
> > > some low-level helper in it, but keep everything else in an only
> > > once build iomap.c
> >
> > OK. I went back and forth a bunch on how to best do this, because it's =
*such* a mess.
>
> Agreed.
>
> > I had a lot of reservations about the way I had done it, but
> > it's so all around
> > messy I ended up there. When I refactor it I'll either move that functi=
on to
> > itree_common.c or craft a way to get that depth information out.
>
> It might be worthwhile to kill this mess off first.  AFAICS it was
> written at a time when branch predictors where much worse than
> today.  So having a branch for te two cases much lower down in the code
> should be just fine with modern CPUs.

As it happens, back on July 6th I submitted an RFC patch to do this
very thing. It dropped off the radar, though, and I didn't push it. It
may need updating to match the very very latest kernel sources and
strip out the extra RFC-related comments, but the lore link is at
https://lore.kernel.org/linux-fsdevel/cover.1783324260.git.jbingham@gmail.c=
om/T/#u.
If the general concept is good, I'll clean it up and send it through
again.

-j
