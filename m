Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2DF437998A
	for <linux-fsdevel@vger.kernel.org>; Thu,  6 Aug 2026 19:46:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786045592; cv=pass; b=loVZ1lI2HCqRe61+GQmQDdpkgGtYnIiIKEkvRaUL5oERznUVzAYqiLCgsIihI59IVPnrgbBWLeRNMNO2XEjkfn3y9sX+l0RtZqMuZ34or7c1Q1kn+HJCmCfHj4N7G8YWUPxKe5iPfY5+raXNzZZbbZdFhciP1/Dx5Q3qhXRMy5Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786045592; c=relaxed/simple;
	bh=/grpQlkFIsjOtZJ9kjTYgO1M00ZnDq0iZMthC0cITsY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZS2YOHB1WdZ9rxXA58a/Z1rzulF0D/FQuoZVX522vZA60TIstLGAPL+z5XYObSnRAP8l7yWYONX/U066LXuydod53n9RElwxHjRsmqft0Vnu5W/CiYiPlbpJW9na03zjUHCkBQLaW6ONHj9leK8Fv8Erb7CBZOSMG0SA7VVmoNY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=qmwWWMN5; arc=pass smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qmwWWMN5"
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-6a063d211ebso3425159a12.3
        for <linux-fsdevel@vger.kernel.org>; Thu, 06 Aug 2026 12:46:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786045589; cv=none;
        d=google.com; s=arc-20260327;
        b=bjDVS3AoFD3uSX8Ign5JeWJ9gI0YrIvw+TrFbcmWP3nzVQk4BTqjByMC/Rrruc+dZu
         5qLTYgbEKEToXdJM2vX3V7a8kQcbsDhBMLNk/bc2JD6Jx7hnqq1RyJinBrF8B7rLEq71
         M8cJ4xTYS3t1W/P4vXSpnqud4uJ9Wt4RFw/CypQDSxE/QyVovnSh9qCMEJdlvznLPxJs
         mW2ghJy7j2Z3L+7ox/Z7qa/vqIgtpIB2L+p7J7640AgCP/psZZ6U1aak1b5xEpGRBQt+
         iqH4uDb00ZxssnaP8lxgVKcDth40rdlidgtHiPapMfcMR+F4u1akVvBI4Rqf8OQ5+3ip
         IdNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=nLbIcjJWlLYm7ckgJdCevI6JSBS4OVTbw09CC4o45Ao=;
        fh=mRgpaCthDK6MsSEBIDbOWhwprHEB+oeY1RpHt42gj7E=;
        b=GGoOcYMQouCAlkgUp8lJYEDfYu7aqW6be+mAQOM1k0NKgndH2MOqupgBUYGDz0Gs9y
         uHK+9PlCIupqdKXndDH4x52jWR6MdNJMsJSBLGvsEtPNV7EVKJhf9KVL3m/6LbOIBXnI
         5AgMmdTVGe2mpyxqqK7+Z9ndRboblroZJnqkCeAmjp6yL8lyiEYs1AchyEohtz6f+Riq
         hns6l5v2Cs/mqNZXoVaZz8Qq35AasR7B6Ux93i63JCbTwg/Gmaxi9JsswXU5UuB7iaHB
         REpwqRGEOrPUaWgfNegHQGwNsct5SaMn7KuekmsfgekyJ7Mf7CMGPuNq0ixY+x1IN0gK
         b/OA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786045589; x=1786650389; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=nLbIcjJWlLYm7ckgJdCevI6JSBS4OVTbw09CC4o45Ao=;
        b=qmwWWMN5UedFBcu8ghP0xP81Cqqlz8IBTKm0z0u5zwffu5IhxFmXlj5j6djRPWHKae
         j9RbjS0COMq3U42wl4IcOVBusoeq0QeFcWy7Y+LCrp2933BQMC/T688pzu+xqAL2Zy4d
         fXd5KFzrM8aPeRr+oRWlsLv9IjZ/qPv08YN7+LhQygPzqyyZQ4bG4ewtlFt3pXyb/oWW
         bX1d94daQ//wpufa4uCGIs/3AgWQOxmbazGT0l+QVli2Q7J2AlB8LRFhumVjCk2Ccf9b
         9P0hHgtstIgPojaE1PoW7nlPMqF+S8NZr8UUM6BhqY7HqYEtUWooOx28dUKiSxC/M4sG
         BoFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786045589; x=1786650389;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=nLbIcjJWlLYm7ckgJdCevI6JSBS4OVTbw09CC4o45Ao=;
        b=obFjJz3FLXyicgFTUi+bD/haCFXXpTKjZrHPIIJpJ3YSk375suu3pIwbAa7sc6G9kJ
         V3KelfCoRfYba27q/94s6Tvp8M4cikDefhTEivG66nYhi1xS6OUL7qnxllblXnu20KT7
         3FtOdOlQrXWGs31FJV0K+PgOig9N8ZgMII31NxnABtCZS1t9zna3vz6ghZlhCyRMQY9V
         M5qETxi6Dbo1tGZD8I6C7He1ywsQWaHCH+yckTK5pVO/vfRZayck744IjKLmtU+26T9U
         W+GZIc8aBZW2HEjZzNwxDQj4QMyruD4mHuvlT6I1zgkwPGH069BpwzK9IFYQqua59BlD
         Ti6w==
X-Forwarded-Encrypted: i=1; AHgh+RqeS/7lK7dV+Sapfji1np9Ki1bH2C65kXmyK+ky3c2NC1hF+ANu51yJWuCB8x8qKaCVf2v64XAh424EJdxB@vger.kernel.org
X-Gm-Message-State: AOJu0YzSOXqb+FNGAgHA+tGqTQKkT54Cc5lBcAyIEfRS4fMGn5XFKfwR
	LGUPIdaRdGxdWWGcfsyVfODzb4lqgH+FNs7MAv5RevUcPAe9TotK7r5sK6e334d8rOlUJBU3WlM
	1Gswh/29AjBjkXtXqcWH/oao1UOsLhtM=
X-Gm-Gg: AR+sD12pf3FL1AZGzOLPn9RKz7pGhEj7bcG0AlO2Wgh0v7vf6X8KLpD1p6COJEt+AJQ
	703v/3qNCdeufuBWphou21RtcHRgQR/55EfR26s1MtMLRkjAOO1NjbjHkQieIQzSeHVNVJuc2DC
	JAYwmJOsMvq+Mt4HVWANujvai+9eEwVs45p6YYx3kUKDnC+3mfkTqFRKlpL02/zebQnt/JwhuK3
	MYIF4mqGL9mXraqHjVXEIUNIypJAQ21tDu3LWI8TbRJO/M+0qiOa7y8YKXoaV4HY+ZnlMCN7tbK
	M22p0062uPPmiRWtabykPl0K8LS7cYc0CNXsdHDu1/fV
X-Received: by 2002:a05:6402:a5ca:20b0:6a1:8ec3:764b with SMTP id
 4fb4d7f45d1cf-6a18ec37760mr3594879a12.17.1786045589025; Thu, 06 Aug 2026
 12:46:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1785621505.git.coshi036@gmail.com> <2824f30bbc43e6a0b318564fa641228e9a096e37.1785621505.git.coshi036@gmail.com>
 <anDZ5YG-Ljflv7Vm@casper.infradead.org> <anFYf1iKrNLAjJMw@casper.infradead.org>
 <CACd_6n2GY2RRQPeKtJEuVkHcSBN-Ne2gJdHRfwxg2i=OT06MFg@mail.gmail.com> <anOf4vNU_XPvyhb0@casper.infradead.org>
In-Reply-To: <anOf4vNU_XPvyhb0@casper.infradead.org>
From: Chris S <coshi036@gmail.com>
Date: Thu, 6 Aug 2026 15:46:17 -0400
X-Gm-Features: AUfX_my3MOnB94S3irinQYPvJ_IWdDZWDeP-gGrdJ_Rtf7S3jrdVnkhoJS9GiKE
Message-ID: <CACd_6n2pHtu3aKWc0TbQ04BEwa7Loqcug_=5i5KGo9w_-tZBGw@mail.gmail.com>
Subject: Re: [PATCH 03/19] jbd2: point the shadow buffer at the frozen data directly
To: Matthew Wilcox <willy@infradead.org>
Cc: Jan Kara <jack@suse.cz>, Christian Brauner <brauner@kernel.org>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, linux-fsdevel@vger.kernel.org, 
	"Theodore Ts'o" <tytso@mit.edu>, Andreas Dilger <adilger.kernel@dilger.ca>, 
	Baokun Li <libaokun@linux.alibaba.com>, Ojaswin Mujoo <ojaswin@linux.ibm.com>, 
	Ritesh Harjani <ritesh.list@gmail.com>, Zhang Yi <yi.zhang@huawei.com>, 
	Bob Copeland <me@bobcopeland.com>, Namjae Jeon <linkinjeon@kernel.org>, 
	Sungjong Seo <sj1557.seo@samsung.com>, Yuezhang Mo <yuezhang.mo@sony.com>, 
	OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>, Mark Fasheh <mark@fasheh.com>, 
	Joel Becker <jlbec@evilplan.org>, Joseph Qi <joseph.qi@linux.alibaba.com>, 
	Andreas Gruenbacher <agruenba@redhat.com>, linux-ext4@vger.kernel.org, 
	ocfs2-devel@lists.linux.dev, gfs2@lists.linux.dev, 
	linux-karma-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

folio_vmap() sounds like the right shape, and nothing in this series is
waiting on it, so there is no hurry from my side.

One thing worth settling before anyone writes it, because it decides what
the callers have to look like: kmap_local_folio() documents "Context: Can
be invoked from any context" and has no failure return, while vmap() does
might_sleep() and returns NULL on failure.  So folio_vmap() would inherit
the weaker contract from the one case that needs it, and every caller would
have to be written for may-sleep and may-fail even though on !HIGHMEM
neither can ever happen.  That costs the jbd2 commit path nothing - both
checksum callers run under jbd2_journal_commit_transaction() in kjournald2,
which sleeps freely - but it is not free everywhere, so this may want to be
two entry points rather than one.

Glad to talk it through, and happy to write it if that would help.  I
already owe you a look at the bs>PAGE_SIZE callers once this series
settles, and this is the same errand, so it would be no extra work for me
to start there.  Entirely your call.

Best,
Chao

On Wed, Aug 5, 2026 at 4:41=E2=80=AFPM Matthew Wilcox <willy@infradead.org>=
 wrote:
>
> On Wed, Aug 05, 2026 at 03:02:05PM -0400, Chris S wrote:
> > Thank you so much.
> > Taken, with a change: the helper needs a matching unmap, and must not m=
ap
> > the folio-less case at all.
> >
> > static inline void *kmap_local_bh(const struct buffer_head *bh)
> > {
> > if (!bh->b_folio)
> > return bh->b_data;
> > return kmap_local_folio(bh->b_folio, bh_offset(bh));
> > }
> >
> > static inline void kunmap_local_bh(const struct buffer_head *bh, void *=
addr)
> > {
> > if (bh->b_folio)
> > kunmap_local(addr);
> > }
>
> Ah, I hadn't considered that option.  Yes, I think this is the right
> approach.  Thanks!
>
> > Two reasons.  kmap_local_page(virt_to_page(bh->b_data)) loses the offse=
t
> > within the page, and b_frozen_data is kmalloc(b_size), which is only
> > guaranteed page aligned when the block size is at least PAGE_SIZE.
>
> Yeah; my bad.  I should have added in PAGE_MASK(bh->b_data) to that,
> but what you have is better.
>
> > The second one is your other point.  With CONFIG_DEBUG_KMAP_LOCAL_FORCE=
_MAP,
> > __kmap_local_page_prot() maps even a lowmem page, one page at a time.  =
So
> > mapping memory that is already permanently mapped would walk this path
> > straight into the bs>PS problem you just described, which it is otherwi=
se
> > immune to - b_data covers the whole block whatever its size.  Returning
> > b_data and calling kunmap_local() on it anyway is not an option either:
> > kunmap_local_indexed() WARNs on an address outside the fixmap range und=
er
> > that config.  Hence the pair.
> >
> > On the bs>PS folio path itself: agreed it is real and predates this ser=
ies.
> > I would rather not fold a fix into this one, but I will take it - I'll =
look
> > at it separately once this has settled.
>
> I've been considering adding a folio_vmap() which would be a nop for
> !highmem, kmap_local() for order-0 highmem folios and vmap() for
> large highmem folios.  It's not reached the top of my todo list yet.
