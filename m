Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC4CA3168EE
	for <linux-fsdevel@vger.kernel.org>; Fri, 17 Jul 2026 21:48:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784324899; cv=pass; b=cHFL0q0H0slx49PlsETvziSNYX9Yg+t1+tsqSkdLJaQJm4eYVL3jfakW0IwnMnebbjRLwOQjf4h1jz2P0cSJjQPB/xjj4Uo5R4WQXDImsv6bADgB1TUIQZTXDw3bqNCC6n34i7XXHKxFH52iXf35bENjmp9HEsncak8cu/uxxEA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784324899; c=relaxed/simple;
	bh=sqU5R3rMMXM1EIenNXeNYk0ZrLRzBSfZNYzit9/wafk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qhVNjNfp+mx8HAW9Hxjo00GELfQThGzy06+TVMJdFspv//lzGSmOu2NRtnkg+HSh1vpTdhWJ0VC4mCh2TDd2AX3mtbZjb9G2Sk50H+sdq8MDtrk2/kUlV8mIdFif6UtqH1k0/S2gY/FolwdLnz+gkEocBYy0K2su9Kox0WjQP7Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=pXf8Eyj0; arc=pass smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pXf8Eyj0"
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-49548e01d02so6110585e9.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 17 Jul 2026 14:48:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784324896; cv=none;
        d=google.com; s=arc-20260327;
        b=AnoBpE2RItOCeK8B4tmx5a3r7FScnW7s3NS5r11PfQjyytq93jCsv/xzpohYl8EM2G
         AdHmQncNktLDOvpH9leNf2J1TWTPlOHMSLDukjqkW+A2Iymb0mM4BhNiclSNPjX7BgSR
         U7Wfq3jGqhr3h5Z2OTg5l4Ra8tMdLpPGpUHxC3l+u9/6ta5ywh3hbMT3L61S6EdjLw33
         B9tkjD3bgiB+LWNfKVVo7vSZCrVcwhdOlC+LTFuFQLgCb2LxfuB/ms61hh9ZqZxgcXDo
         ARPgYyyE5Ow8lhLaa1APRJ9JZNyQczXS3XfUuc7876hFyYzuVGOZuuhy5AkFMDfNZmWU
         cbqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=GZjDxyMd9lYhUp+Y2lk0pT92jHBogv3cxfdr1gHkuyE=;
        fh=RJuk6rZ5Rt/oxGEDlUjYReQ7j5RnbfhoesS5jPKDRp0=;
        b=kV9cgcUWNuE5PLY4ziIbpQOo6mWVANy9DvrCa2n/kbRb/djvVBCYeDYkBK9smS/TVA
         NWsI7QzjL9hjwKp3OoFtqy6gujY4jbFRQ8TtcuBjuGm7iHFuHhMJvGCe6O7/ZEuL7lL7
         TcEknGVbJ5EC0Xj6QaluSFFpHoTeS/iWLjoZArrguK/j3onjQAmzOpVta4fcEGMuu6iv
         hB/AOyhSqr41OY1W4DF635pYM5YUQBR3y2GxGTSskghv4oPK6zJy3lpMm+0fTxh5MHJe
         E69bHqN09YSmCB/Tc11qB1EuuYSbSit+I0ernGEV8h8ys8oEfJIfuTteHHzhvXpmY8vq
         j0hg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784324896; x=1784929696; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=GZjDxyMd9lYhUp+Y2lk0pT92jHBogv3cxfdr1gHkuyE=;
        b=pXf8Eyj09mAmVDmf9/D/oU6rwnXS3DXrCmAgYbcllxqHWloDIN5otfEN1/HYWGncu5
         KGNl8W/jKpbg4y+KXukBSmaOeXpce9XSj0/N88xLQwRuNGFvF3C4aAFyZeUKVJOiDeeg
         HB3yiXNBtpOIQHby+oqsEMR7nV5IBycmUrm84EYSarfghzAYvllj5mhJjse6w7u1IjrY
         bq10aNTKhzOV5j67Cy6fmbaBGzr37Ys453D5V07Kzb7eBLlZYMKgQgrHSsZDLRt83um4
         aqCxFolDcaaOeVAsTpcFfCef6aQEGS5+WrUURjf4EKYwvM5tcmeIvb3+9KF3+gM4uMaV
         IozA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784324896; x=1784929696;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=GZjDxyMd9lYhUp+Y2lk0pT92jHBogv3cxfdr1gHkuyE=;
        b=Pl+N0sR0dUFh8XqcYXXNXEI9gN3859Ek0FBbcHRu51FXQ0TVoctW2clXA7WfBY1O/L
         lfnYewPmYpKJ5P8JhNFu0wvJzlFIBA97lZ+olGt66f6M5s8cLHE2Z53tPSEt2/ksARAV
         JKzb9+xQ0IkU0FMgs6NW9w+0RseHWO8ElylTi6aHeayXZ5cODQMCh+nCB3woCRtlPW6f
         KRHDXqKlZspJI+1scPR5IM4Kkbh7LJ0Hs9l6ioXXTi8qSib65ft6cFVMFuKd54BTU+tU
         p7f7ct3XhmueUvpzU/fxRZECad2vsACaGJRm3X65L+ZSs+aZfiDQLYiNqzp4lugRoTHX
         pgcQ==
X-Forwarded-Encrypted: i=1; AHgh+RoO2Z9ZGP9uwKGW7NgkgoR+QEZVljHoddPSBI7pjWHBWj32v9A311/zNDXri9Ain0ZvLiv1cJeRs2S30Heb@vger.kernel.org
X-Gm-Message-State: AOJu0YznCgj7c2FU1hc12oKMPSVAfW6yJ8gxa/h5MyqbBMLv/zs8tpCf
	v27/L24O6BqeM1eMvuBztAsovuUFtTl4EIBoHhqhTdz3+NsgyXng2qtQLcnGNpLLBf08HNvr/Jr
	iFcKbfGIXhdsa1x5uRqvmbEjpO8CTEk8=
X-Gm-Gg: AfdE7cn/C3wUV5I0KULV17MI82V55HI+kyfyjc8h/PNBAcg2KixXZic/kr/wvBJCKfR
	uRBG0qroSC/DoCJRYlqyTriu7CQDXUF7WC6+wTQ/TmbpNAyM9U8VlsztYy1C9+36/V3X6XXqUSd
	8FY8iZGLlRThkcHKNESioj4JpWAvr/ej9Tu+eIjmiarmZZwgZUbnQx2q8Rbb1W/3eWwZxbl53HT
	JgaOcwqYoo3oHx8MgdcDSYGt7GvJ5B2MeoCJOCnjcZ6xhZjV2zGUIau6ZYKmNCPhlj7Q4/QEMEy
	rBKOuKeJSFggLT39eSdiWpTMlLTQ4IlYUyNPJTSZiw==
X-Received: by 2002:a05:600c:b96:b0:495:4b00:1bab with SMTP id
 5b1f17b1804b1-4954b001c39mr45485455e9.21.1784324895791; Fri, 17 Jul 2026
 14:48:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260701000949.1666714-1-joannelkoong@gmail.com>
 <20260701000949.1666714-3-joannelkoong@gmail.com> <20260702164339.GI9392@frogsfrogsfrogs>
 <CAJnrk1ZRQaFseAnz3zm31oR3KmQWje5HDJjhNbAQSAQyK9_PMA@mail.gmail.com>
 <CAJnrk1bj4pLpAzLhehrbDJuKWa=WMq-3XOAm9dhsEVDF9WCBPQ@mail.gmail.com>
 <CAJnrk1YkAEUhjw6mNEx70ojN7UMQT__oHn5m1Ng2Lz7FoLRhrA@mail.gmail.com> <20260717175552.GT7380@frogsfrogsfrogs>
In-Reply-To: <20260717175552.GT7380@frogsfrogsfrogs>
From: Joanne Koong <joannelkoong@gmail.com>
Date: Fri, 17 Jul 2026 14:48:03 -0700
X-Gm-Features: AUfX_mxuarmgCvMjpgrc3PqPzAefX6rjpJrhYlOJ5xPI1AmG7uUmKiouc0J-ti0
Message-ID: <CAJnrk1bjA+Y5V-87AhNGR5-ss7gUJWwLkjouwic1Mckd2QRH7Q@mail.gmail.com>
Subject: Re: [PATCH v2 02/18] xfs: convert iomap ops to ->iomap_next()
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: brauner@kernel.org, hch@lst.de, willy@infradead.org, 
	hsiangkao@linux.alibaba.com, linux-fsdevel@vger.kernel.org, 
	linux-xfs@vger.kernel.org, Carlos Maiolino <cem@kernel.org>, 
	open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 17, 2026 at 10:55=E2=80=AFAM Darrick J. Wong <djwong@kernel.org=
> wrote:
>
> On Fri, Jul 17, 2026 at 09:49:30AM -0700, Joanne Koong wrote:
> > On Thu, Jul 2, 2026 at 6:21=E2=80=AFPM Joanne Koong <joannelkoong@gmail=
.com> wrote:
> > >
> > > Ahh okay, I think I see the point you were trying to make. The
> > > callsite functions are like:
> > >
> > > ssize_t iomap_file_buffered_write(struct kiocb *iocb, struct iov_iter=
 *from,
> > >                 iomap_next_fn iomap_next,
> > >                 const struct iomap_write_ops *write_ops, void *privat=
e);
> > >
> > > int iomap_fsverity_write(struct file *file, loff_t pos, size_t length=
,
> > >                 const void *buf, iomap_next_fn iomap_next,
> > >                 const struct iomap_write_ops *write_ops);
> > >
> > > void iomap_read_folio(iomap_next_fn iomap_next,
> > >                 struct iomap_read_folio_ctx *ctx, void *private);
> > >
> > > void iomap_readahead(iomap_next_fn iomap_next,
> > >                 struct iomap_read_folio_ctx *ctx, void *private);
> > >
> > > etc, so it's not clear from the "iomap_next_fn iomap_next" naming tha=
t
> > > it handles per-iteration logic, whereas renaming it to "iomap_iter_fn
> > > iomap_iter" makes it more explicit. Am I interpreting this correctly?
> >
> > Going back to this... "iomap_iter_fn iomap_iter" doesn't feel quite
> > right. I think there's too much naming collision with iomap_iter() and
> > struct iomap_iter, and I like how in general ->next() matches the
> > orthodox naming scheme for advancing an iterator. I think
> > "iomap_iter_next_fn next" would be the best of both worlds - I'll
> > change it to this for v3. But if you don't agree with this, please let
> > me know.
>
> Fine by me :)
>
> --D
>
> >
> > Thanks,
> > Joanne
> >
> > >
> > > > > > +{
> > > > > > +     return iomap_process(iter, iomap, srcmap, xfs_direct_writ=
e_iomap_begin,
> > > > > > +                     NULL);
> > > > >
> > > > > But then "iomap_iter" sets up a new problem: should iomap_process=
 have a
> > > > > new name that goes along with that?  iomap_iter is already taken =
for the

I'm starting not to like "iomap_process()" either, it seems too vague...

I think it'd be better renamed to "iomap_iter_next()". The callsites
would then just look something like:

static int
xfs_read_iomap_next(
       const struct iomap_iter *iter,
       struct iomap            *iomap,
       struct iomap            *srcmap)
{
       return iomap_iter_next(iter, iomap, srcmap, xfs_read_iomap_begin, NU=
LL);
}

static int
xfs_seek_iomap_next(
       const struct iomap_iter *iter,
       struct iomap            *iomap,
       struct iomap            *srcmap)
{
       return iomap_iter_next(iter, iomap, srcmap, xfs_seek_iomap_begin, NU=
LL);
}

I'll make this change for v3. But if you don't like this, please let me kno=
w :)

Thanks,
Joanne

> > > > > legacy path.  If we were emulating python I'd suggest iomap_iter_=
yield
> > > > > but this is C so we get to reinvent everything from scratch so wh=
o
> > > > > knows.
> > > > >
> > > > > --D
> > > > >
> >
