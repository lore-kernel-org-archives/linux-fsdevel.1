Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 546A52F60CC
	for <linux-fsdevel@vger.kernel.org>; Mon, 24 Aug 2026 13:34:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787578461; cv=pass; b=pfdJ8LfNrSywDqfoaFPEE41Dme3QYdDCJuWbaYwNRsiGqMcwE14takj9BLNvqocI9W/9PPR4QdihDupuyLVmwoBaS0x1TU15n6kyCEo2+kS6uu77PHFCLo7TYLIDj4xL9dJTD8ZEoDi7kFNgbBFRh2qOO3CtMbXBgNbe4SGLJGI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787578461; c=relaxed/simple;
	bh=jt97fa4ek6DCnOIAmnDAOw9PN5qury3d3mDg3j9imW0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nghJ4d4MkuZGWR+xvCd5GO86GObGUOkRlvG0HRQ4WTh13duoILB0zOXd+lpZTW6VnpkS1oiODSLC31OWTHmXHTHzgz0+mvJfr0azZ4ijUYQQZdlUB9im+JRLt8KTtV2aJ7r/Lr4pZAdG+fHwvIdSEv2bSZTKkvuh5ncTH8Y1aCc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Hkg60M2W; arc=pass smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Hkg60M2W"
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-5b159850b16so3219277e87.3
        for <linux-fsdevel@vger.kernel.org>; Mon, 24 Aug 2026 06:34:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787578457; cv=none;
        d=google.com; s=arc-20260327;
        b=qh27PP2rkR9emDtYIZSZ7dm/07NTrlCaOx2n5IgLpm7kRyksrtGHEGIFZavmk1o8Ba
         5PcHl+t6qEYZn3l/sAG7FJBlsRwg5dYrlkuPQYueyhEUMljJ9uxj3DmtZRbuXEVGzlhp
         rgsSZDpQIE5AcOCYzmrjCJRnVItUs4e6FqEt/VDTLR9+KecjkPxk/uJRMyqTAOhIwOBo
         nwFy7joGNG35ZlyB/0SjWytZ/h2TefZKmLZ+iSsdyCvWA63wzlgdeoZsTk4D074OYKPe
         GIj/Ctb5cQc3RKuKQtkBTFa5R167tMfaXgKAlvi7od6uKqjxZHK7uxO28tTZ9ALrC0yT
         TuYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=QBacaBnshuCPlzxPKwpr0zEJzedqj8NVhoTRiE9AZZQ=;
        fh=zWM5xMAEF2dnOeR0dpbb//+0BV+8kCqeZLWpvEDmEiU=;
        b=N4jQwztERYf0u4KjpI9QVDJPKPIjg1/pKHf8fIdGBp0T6o5Tm5W2SiNh/ab1OvTn5u
         ViYEdynD6irEbsvGXpbb5+s51duJJtGhYzGtSef8OtWJhW2dZE4Q9Wtc095j4qEUPXno
         KRMC/vXPN3lf/4IuboFG6iu1tuA/8CrwqLiMgVhPNk7MLbPi+hg9yiQQVCyWLimuxNqQ
         RBOh32/8bots3qU9gpOyvStM5CujHt+X1rdByDwAMBaDGTk3cmwzXiMEsYbQ1alYtQ/N
         MmSruTwEhnzDd8v4YxKszB98EF7GRoOJMG0Ciaj6+WPeCmQXTRnl5zLLwwLLWI+3xxKJ
         BG8Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787578457; x=1788183257; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=QBacaBnshuCPlzxPKwpr0zEJzedqj8NVhoTRiE9AZZQ=;
        b=Hkg60M2WxQrFbGE3Hx9CRDMjku87T0cjArApM+ey4QgBnz4FAr0ScCKKViqD4wBuTn
         znMuLnK5SB0zydQjnt3hzhCGFVYBYrMSzhk8BsytKadcGCzRaz75MG1JpSbM8o+eyuoo
         ybbrkIM4H+NOVDibTvLe7VctmRk6EhJ9J4sZRgJ+FDfdGiClZWm3Ru5XQpDxIXPjJG4s
         mGymtksTPioboolTNoxpTjZrOYkjYX3KbcD6xk1IN2h4Gt0sQs/rK0FQZKkxBG1mJQGF
         IZyk2O3l/mhTUcyoyptVXo7QGc9PtmCMUwueXnBxgQCEYK5upctqk7nbvOoAsSZQ0XKq
         iRKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787578457; x=1788183257;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=QBacaBnshuCPlzxPKwpr0zEJzedqj8NVhoTRiE9AZZQ=;
        b=QGcZcsqZPe8UbMwVEZhvg+xu3kq9dHmI+KdfbyWC4E/L1pZcuY06RMAA+r5eMVUKV1
         Ogk3YmxFOdOqrFCOHv08//DIyZ2JmslNk1ZjjTnQsps6z1tS6iVp6GUAqlrxdztqGF95
         vBqiA0QQUxRvBc3F5RS9edDJpnv5OtGYE33BCQwXUKYkApszNTkiaLnQ7gFHzDrlQCaT
         XBLDyo4CiwiVsEXD3GDTNJoMbmzQxYD3BolBQKfF7P+F3IXpEFxwzOVCMNLmAZsyvUcJ
         9AWlJjOF4PROHN1gaNwOGIPl5sBoeozcS+JkIeKW9t8Q1qJqHzPtRmBFhklPnfbb6w0Q
         VfhQ==
X-Forwarded-Encrypted: i=1; AHgh+RojuquIO8rK6fYdhMVRnEAChsLKirNCVnIzOMrRRisEYtQFdTdKqQERDDCDdosu5K3sFib5knLAFc6ykY3b@vger.kernel.org
X-Gm-Message-State: AFuF++nOOYwZV8bP7UF3wP2ZQYluyY4zJZS7m8YUpiwrhtjLYMjMdN8o
	pephtXH8pj7nwmmGF5iEk3OY3okhiXXzUzU+t/ymKEnPiidmJFEOH2GEcDQtjHEqaOhdjicXRGj
	904zDF1f2Q3xi5GJcds2E+Lt8oMAemlY=
X-Gm-Gg: AR+sD11792A98ogtwLpFahLLjgR31b464yDKyGZEaea72MQuf9+DJhx4EYPkK/cuNCY
	0idEUSiR2yzbzSX9db+lZKuylNW6onhZHffMSPJKAZTjImVW/dAY+ixZRv7yCMswrMw6ySEeyeg
	jtOrOvRrgMSyw9Kt05ZxJ/Nmf5ORb51//nc6QKdtOg7YA6pZYDSzbQVk/1KXJEOkfbij2MZDDvw
	qOkNJT9HP1XsC6KBIGb7gZIRl2iRP+5nJmPIVpCKEQ/8prR1vlGPA4iyftj9q0/QXCCYNl5f1YQ
	eWXZTlur7ASIGteM9cVrKW6c24v93zm6G+UmfB2/dkD1Dg==
X-Received: by 2002:a05:6512:3c8d:b0:5b1:121e:56ae with SMTP id
 2adb3069b0e04-5b484207013mr9172063e87.11.1787578457000; Mon, 24 Aug 2026
 06:34:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260820142956.1414337-1-qiwenjie@xiaomi.com> <aocQcaMMU7-rfn3e@casper.infradead.org>
 <CAGFpFsRarmDScAQxHpCtSZxK5H4WCg4Y=y0hXQLjGT804ZoWkw@mail.gmail.com> <aofGOQB4TViwQQQ7@casper.infradead.org>
In-Reply-To: <aofGOQB4TViwQQQ7@casper.infradead.org>
From: Wenjie Qi <qwjhust@gmail.com>
Date: Mon, 24 Aug 2026 21:34:05 +0800
X-Gm-Features: AcwNN1UaVcaeyubnRP3fsC3CJZmuoOgGKa4w0B0il0q9I0mk8QLj8AnssfwDVCk
Message-ID: <CAGFpFsTUBCiGEUyKzYNaT7Xe3O_7dVg6T==v3ssZ-9HGQiafLw@mail.gmail.com>
Subject: Re: [PATCH] mm: filemap: tighten dropbehind completion context check
To: Matthew Wilcox <willy@infradead.org>
Cc: akpm@linux-foundation.org, jack@suse.cz, linux-fsdevel@vger.kernel.org, 
	linux-mm@kvack.org, linux-kernel@vger.kernel.org, baohua@kernel.org, 
	Wenjie Qi <qiwenjie@xiaomi.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

  I think fault-around provides such a path.

  do_read_fault() calls do_fault_around() before ->fault.  For generic file
  mappings this reaches filemap_map_pages(), which walks mapping->i_pages
  directly and maps ready folios without going through
  __filemap_get_folio_mpol().  It does not clear dropbehind or exclude dirt=
y
  or writeback folios.

  If the mapped PTE range covers vmf->address, filemap_map_pages() returns
  VM_FAULT_NOPAGE, so do_read_fault() does not fall back to filemap_fault()=
.
  Both the faulting folio and speculative neighboring folios can therefore =
be
  mapped while retaining dropbehind.

  A fault-around PTE does not necessarily mean that every mapped folio was
  accessed, since neighboring folios are mapped speculatively.  So I do not
  think folio_mapped() alone is sufficient to cancel dropbehind.  Clearing =
it
  for the folio covering vmf->address may be more precise, but that would b=
e a
  separate semantic change.

  If this distinction makes sense, I can send an RFC to clear dropbehind fo=
r
  the faulting folio in filemap_map_pages().

On Fri, Aug 21, 2026 at 11:30=E2=80=AFAM Matthew Wilcox <willy@infradead.or=
g> wrote:
>
> On Fri, Aug 21, 2026 at 09:23:12AM +0800, Wenjie Qi wrote:
> > This is based on code examination; I have not reproduced it in
> >   folio_end_dropbehind().
> >   There is an analogous EROFS report where bio completion ran under an =
RCU
> >   read-side critical section and hit a sleeping-function warning even t=
hough
> >   in_atomic() and preempt_count were both zero:
> >
> >   https://lore.kernel.org/r/20230621220848.3379029-1-dhavale@google.com
> >
> >   That is not a reproducer for this path, but it shows why task context=
 alone
> >   does not establish that sleeping is safe. Here, folio_unmap_invalidat=
e() can
> >   reach unmap_mapping_folio(), which takes mapping->i_mmap_rwsem throug=
h
> >   i_mmap_lock_read(). I noticed the mismatch while comparing this path =
with
> >   the stricter bio_in_atomic() check used by the block dropbehind work.
>
> So your analysis is right as far as it goes.  But if a folio has
> been marked as dropbehind, but was then mmaped, we clearly shouldn't
> be discarding it!  I believe that we'll clear the dropbehind flag in
> __filemap_get_folio_mpol(), called from filemap_get_folio() called from
> filemap_fault().
>
> If you can find a way to get a folio with both dropbehind & mapped set,
> I'm interested in hearing how.
>
> > On Thu, Aug 20, 2026 at 10:34=E2=80=AFPM Matthew Wilcox <willy@infradea=
d.org> wrote:
> > >
> > > On Thu, Aug 20, 2026 at 10:29:56PM +0800, Wenjie Qi wrote:
> > > > folio_end_dropbehind() uses in_task() to keep folio invalidation ou=
t of
> > > > interrupt context. Task context alone is not sufficient: preemption=
 can
> > > > still be disabled, or the task can be in a preemptible RCU read-sid=
e
> > > > critical section, while filemap_end_dropbehind() may reach
> > > > folio_unmap_invalidate() and sleep.
> > > >
> > > > Use the established conservative three-part atomic-context test: re=
ject
> > > > preemptible RCU read-side sections, reject configurations without
> > > > PREEMPT_COUNT, and otherwise require a preemptible context. Unsafe
> > > > completions retain the existing best-effort behavior and skip inval=
idation.
> > >
> > > Have you seen this happen in practice, or is this based on code
> > > examination?
