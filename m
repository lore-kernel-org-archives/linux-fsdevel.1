Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BDC529B8E1
	for <linux-fsdevel@vger.kernel.org>; Fri, 19 Jun 2026 17:43:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.172
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781891000; cv=pass; b=QxCZDfuTU6cfEYTdzK4AIA0G+5FLXZEdBCRyOKbCgHpvx3v0fsLIJ+1qK0zEDgdylyteL//ZlRqP9SxMCl8duCsajK/a82GGEUfj7xvBdHQEK3CmVtn6gW45GrNvr9at9On5SJyU6C8ePUyPaVlgwfIIcDc4YmCnU1NNDImC5Lc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781891000; c=relaxed/simple;
	bh=6iOouH9FLLpLFlRd7xPpvdd+MxCiGiBTjcQqmIDuvV4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ghVgegI/sanwuVQoxM5oBqtBhG8xm4gnKELoE0svQJneo59q6oHBCwU4c3aM68hqyqhXVjpKWwNlj9drZ9g38ggYFd+Z1P48HJ/Fd91kc6XVtRgOowW/ycUGJLMKPn4L+8T4NIi04gQ0GS68u0CvNbub3lRw8ZV1bJn6tGNZ5Y4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=oNeqQNj2; arc=pass smtp.client-ip=209.85.160.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="oNeqQNj2"
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-51765331535so260991cf.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 19 Jun 2026 10:43:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781890998; cv=none;
        d=google.com; s=arc-20260327;
        b=r1R1SYxn4R1MFh85c2mfGKgo2keuu77qyqGDW5Kpowr5RVJ8XKk8MZ5pAc/JKrr2bI
         qG+BP+ooAU5PCJgpA+gy9zg+qUlpesm0ZQC21/ewgujPdz25P2O7znQkg8NkZ5QNNS+C
         KA3k2vQmVfNpSIAESJ46AzuYY2qyQB71R2a6WMPEr76kYpuMi+zi2MOC9nvYs8UpaK0q
         KcFzNPUYojhkO2yTDl86AsF3IrPZIus8T3U++xdDWxLzRsSZIj2znhlg+ZOfTTzZyTp+
         Jju7ubwz68dC7x4RaUnrzTSrMzDVnkeMSQK8FJ7v/BpmScxDVNZD2r+WCLpCPloUhYvR
         +Gog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=kay5wp1i1E+dRCDTPAxSLQ9GOQ/50mATiU8b8y6jipg=;
        fh=XkzmFjmV0Wz4iQwlwk8uugIWltyXUDBizw7M2sDkzT4=;
        b=JwsYM75JcTmAS02zC0Mu41u8TJUMtN6o7Oc5WW0hTdzhrMqfCj3B0M/OBjeLtTzSN0
         Ow9s6qw4DoS1tzwkenCQxetf8gqQSdrMiJRBRns+f+lnlbAjYHSYayQbxfiFOFOoJsvn
         txiFlmbJxASq4b91VPS+EEkqO8QFLm+j8dSinlktFzbiXGS7rNwWQjMJ78Pv2Sp9Tvz0
         h8wlO4jWzua0k3uaqNZxmmhCQa/IGjj9724/ZFW5q7EyQ9DvUv2ej0itOY4FQdnqrOMi
         ATysmTlnK2CetYwddBwsH75SV/g2jo5qZKzmQQv40h2NrdRz9IYE0rKQaFCZbF7T4SCk
         9IJg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1781890998; x=1782495798; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=kay5wp1i1E+dRCDTPAxSLQ9GOQ/50mATiU8b8y6jipg=;
        b=oNeqQNj2HdIBGOqZzAfmpBKDC+pH6YxzaeSccS+kMNemKAjqNw7DN8E5cWo7xGTVuo
         DdSvR1AiWi3imIKzopxjepQfuy+PzUIc2JRI6ZCuzDT0Hm7pcxGz7t5Lz940TWt95j1t
         SL2yHPH3wTuZd43e92U/Jt61kud9UZU9wu9pLO5qFUtuotVfpx7x8KYK7N+z9Nod6xdi
         PyNh+tC7M7gvL+601XZKvRf6lKKAG/NeagOU+Gt7GFCnZGhESL5AT/DiY+xyM/l9srKK
         s6Fjn9DuKfBVwEogFUV7pLUMNHeHwiCnHNoE+vS6zooh3rSMElKJuqNt+Ng5wmLZoS7W
         +mYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781890998; x=1782495798;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=kay5wp1i1E+dRCDTPAxSLQ9GOQ/50mATiU8b8y6jipg=;
        b=SN3bE/bhibWb/1/oZ2SiH97j+NQgmER6H2sNDxqBj9+/Wla59Fw74l1zBbtDR0yHfr
         s1itk4f91EmA4HaeFJRYZamTWVWhXpSTvD8LgJz8bIFc+5k+iGaKZf8ov09EZJM44ZSz
         aBSskddb5Ob14F6du5H1Oqw4c3GNOburixP+DO0u8ZRuPjgWRrDRYHMLNDSFpdkGHto2
         vPGUPXiTuXnzX4wKpgsWj6V0BhlRlJ+3JbWXQnKA5ZX+zUw9ldhv0OyZy43JDTZNjIEp
         /eALSoHpYgSrUxwj4SzIcAcgch8elcEbPTDPSTxXiGe8g92SK2WkkdluXCcrXXa1NlaE
         XQ2A==
X-Forwarded-Encrypted: i=1; AFNElJ8zUZlhNuk4AWWfC8Fi4RLT1BYjUT+TQLoFZzRbrhsZ7DZVGa2ZrOrVvX2kclYk1GLfsq3n/mBEeP6fEqJM@vger.kernel.org
X-Gm-Message-State: AOJu0YxVrtrek8PqyDbo7re6xHAv4b5vy6gYFeApXTE6E0yFlCLu/Wsu
	Ss5G/4ioayvQTrGDSOV2T4aJETvvd5DNLil2CakOm/LAg2mTPUGaz+jwouW5LZ+Ro8Alm9ooveV
	wqJd+TkCXw1lO30SZF/WdMUC+5hXfGqfX9qAhKbNO
X-Gm-Gg: AfdE7cn6x+UBfBntGpB3b9KnmyqtlTcH2gjwYMp7snrVQ6+P9t78Uhi/M4EWnD5bOt9
	Oqbyg/Mie31iTTDp4YlNYZqlWIDpXQPTUpuRdyfIrVWHRYm44GBhW6M6NFPP2KmfXl1bXiYaT15
	PVa3ciBlXEdMDgaZ97jfrv3JZNPtg7jNN6BxURD0MpYzL5+Ej2rbMY1erpLP2oiE3rIl8kdAWlK
	/67gdLygWAgbmRWnus6HAsON60QvIVjdBDXnaYIQh58pGUfx2zBHJfJVAGOiHghwrSrtYosrilu
	YxdQgA==
X-Received: by 2002:a05:622a:5513:b0:519:df4f:6c93 with SMTP id
 d75a77b69052e-519e4a70447mr8437651cf.20.1781890997445; Fri, 19 Jun 2026
 10:43:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260619112852.104213-1-ljs@kernel.org> <20260619093711.d0d37c9920b3a16394c356a6@linux-foundation.org>
 <ajVz1nhMn2JwucMY@casper.infradead.org> <ajV0TbwEyaKMzoa6@lucifer> <ajV49Fyogfa6aIjy@pedro-suse>
In-Reply-To: <ajV49Fyogfa6aIjy@pedro-suse>
From: Suren Baghdasaryan <surenb@google.com>
Date: Fri, 19 Jun 2026 10:43:06 -0700
X-Gm-Features: AVVi8CeEMjgy9L2eBvRLZA5Aw02A7ftxRU-GzBSdQ5yz88FNkOKgb6VgPbpFz88
Message-ID: <CAJuCfpGdxsPDbxOwQFdY+Xt7mZGFvoKWmed6FteTongvFgjgww@mail.gmail.com>
Subject: Re: [PATCH mm-hotfixses] Revert "mm: limit filemap_fault readahead to
 VMA boundaries"
To: Pedro Falcato <pfalcato@suse.de>
Cc: Lorenzo Stoakes <ljs@kernel.org>, Matthew Wilcox <willy@infradead.org>, 
	Andrew Morton <akpm@linux-foundation.org>, Frederick Mayle <fmayle@google.com>, 
	Kalesh Singh <kaleshsingh@google.com>, Jan Kara <jack@suse.cz>, linux-fsdevel@vger.kernel.org, 
	linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	David Hildenbrand <david@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 19, 2026 at 10:18=E2=80=AFAM Pedro Falcato <pfalcato@suse.de> w=
rote:
>
> On Fri, Jun 19, 2026 at 06:07:30PM +0100, Lorenzo Stoakes wrote:
> > +cc Suren, Pedro, David - I messed up the cc on this patch.
> >
> > On Fri, Jun 19, 2026 at 05:52:38PM +0100, Matthew Wilcox wrote:
> > > On Fri, Jun 19, 2026 at 09:37:11AM -0700, Andrew Morton wrote:
> > > > On Fri, 19 Jun 2026 12:28:51 +0100 Lorenzo Stoakes <ljs@kernel.org>=
 wrote:
> > > >
> > > > > This reverts commit 7b32f64bc512b40b268776c5ac4d354b325b3197.
> > > > >
> > > > > This patch caused a significant performance regression, so revert=
 it, and
> > > > > we can determine whether the approach is sensible or not moving f=
orwards,
> > > > > and if so how to avoid this.
> > > > >
> > > > > There was a merge conflict with commit de97ae6222c1 ("mm/readahea=
d: no
> > > > > PG_readahead on EOF"), care was taken to ensure that the revert r=
etained the
> > > > > behaviour of this patch and cleanly reverts commit 7b32f64bc512 (=
"mm: limit
> > > > > filemap_fault readahead to VMA boundaries") only.
> > > >
> > > > I'm a little conflicted here.
> > > >
> > > > 7b32f64bc512 avoided readahead of "file pages outside the mapped
> > > > region", which is clearly desirable (arguably a bug fix?) and we ca=
re
> >
> > I wouldn't say it's a bug fix? The kernel has always done this with no =
reported
> > bugs.
> >
> > > > about performance of executable mappings.  Whereas it isn't clear t=
hat
> > > > we care about whatever the heck that test case was doing.
> > > >
> > > > IOW, the revert might make the kernel worse, overall.
> > > >
> > > > If someone plans to get down and analyse that test case then come u=
p
> > > > with a new version of 7b32f64bc512 then OK.  Is there such a person=
?
> > > >
> > > > I'll park the revert in mm-unstable for now, but would prefer not t=
o
> > > > rush it in until we better understand what's going on with that tes=
t
> > > > case and what can be done to address it.
> >
> > As Willy points out [0], we've identified that it's a real usecase that=
 we're
> > regressing.
> >
> > There's likely others too in the real world.
>
> Yeah, the mmap usage on SVT-AV1 is a little suspicious, but I guess the
> pattern may come up time and time again for people doing chunked mmap
> reads. I think we need to take a closer look at this change.

Frame-by-frame mmapping for a streaming workoad is quite questionable
IMHO and I don't think we should be optimizing or encouraging such
usage, but I understand the reasoning for the revert.

> >
> > This approach has also not been without debate in the past (see [1]), I=
 think
> > this patch slipped under the radar on that front a bit.
>
> Yeah, sadly it seems like the patch _may_ need a rather substantial rewor=
k :|
> So I would err on the side of caution for now and revert it as well.
>
> --
> Pedro
