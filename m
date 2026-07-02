Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B44AA34844C
	for <linux-fsdevel@vger.kernel.org>; Thu,  2 Jul 2026 23:02:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783033328; cv=pass; b=VOtj2lc8hg5CuVIH2+ODf6XtUlX+XwibhDqrGaW/0eWDwYeoiQvLsRHzN7n6+qPiRqPC/PPthkEHcepuKb6fjqIi++0CpaLruTTOsUJeiZCuDiKciJ6Sm5TtA9xiBYIx6gAX0vbzMm38NZjP+H8WnA66sx7wVM2ivi84O0ySRAQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783033328; c=relaxed/simple;
	bh=4Kn3VQND47UCcI26pv7bb40u477SLSvq4NVjLC7sHeg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=C4JTQfMAYGiipkbCpkP6X2jEkHadAYGXf7LedhKiYVHWo+JDQeq/Zt6vKvq7ybl0VcktShmgFq5DTETjohHCDfMOQoMZEmajzgXWDTodopJ2Rxkw+uGgEg4GD6gkBDJuwPRcSsJAjNrmt2OanYpW1CYHavByzOF9YOiS1Xlxt/c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fJaEPJ3l; arc=pass smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fJaEPJ3l"
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-4629051c946so767607f8f.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 02 Jul 2026 16:02:06 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783033325; cv=none;
        d=google.com; s=arc-20260327;
        b=jqSjZJ+Agj9XAVPkbUn+OLaIkjJweYwKE1TB6ph0Edo23uN2cb5lDyC5gg7n8RaI2h
         GCKp/bm4iJUqExRG+yCO8pAsLH7I2wCE9LqbBrqsGDUsPDqD+Dk3AeWrPC4TVaISI+C+
         OXQfr+/oYLUazJ2r/EbmvZ0Z3u/rYQfF9l0F0PI6cto/TjB5zuMsTl4P8PKuiTaoWora
         74PIpTNOawKy3cJv1MOVx1sh4HEknLy9hPA4IfeIZsQMILkXiXbqyW934uuw5ji+B7D2
         gSIL/7w0MYpD1bp8lUB+JV2XLuARyWo+IReBc2zmU8ZU9YXnAEWidWfAqjAz321u/otr
         8F1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=4DB0StncCI4DCdkHVBFZN5AAMbnpw9y/OLi7Kcm8C6U=;
        fh=SDmnqi78Q+4YLtbZm9hllZsmvhoExTQ6a0zRVoeSIrI=;
        b=BXZrNbF70uH9xdTNFWtXTILmzX3/59gtDVZxKZTpSP9ZpqyMfgRLr9HFTSo9Q8vGui
         unVbcsWRAfLQX9oT0MWC4/O4DLct5njswb8ih3pazgc3Eu2TXd8sBfzaKd0taYAYqu/Y
         6ivpVx2AQVchffGRRWtbXEvCmZIXLPC94mhnSwpxWiAjBMXBF3vQx3qslr4Nsoe2y4CC
         4Z07G2bpu3C+jeUvZ3Tv0N1Hr+0oNoZq6p0lzjyk8vRAFnmFSPVs07UUCk9XQGy0Wdpx
         NlWJE1gDK6Zi9Ad0p3xHPMwht5+yurTQPahWysdG1oRuE4euGnVuMYjbM6Q9LaXwIR1/
         2Thg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783033325; x=1783638125; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4DB0StncCI4DCdkHVBFZN5AAMbnpw9y/OLi7Kcm8C6U=;
        b=fJaEPJ3ld+n66r1G5fSulWfucGH7LbdhRHl+lw4OzgmeFjsyUZpSjGk0ARFBeMStHJ
         5iBdiO1V9XFNcgioODdbtjBieLBMehoW9n2JdGkpAk9S6+6qTfdfCGEjKPr5XM7VioOu
         CBxZtd6lthU/F0kBOtEAW9th911Tkx2DnrhSZwqa0UuanXVZfgk3C411Tf/gUNvMBVrc
         rzOZRzxgrcApMw2SeK/YK43VaOAKVhQXCNJ9OOdwZV18IvOM43VGIMl1Gejr54Wa9orj
         Xus2O8eFj4mYhw8D33DFyRSomOK1AbOjSkpIJkHilF6ovudCY3f3PryZAjQy+wTpaa5i
         CuZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783033325; x=1783638125;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=4DB0StncCI4DCdkHVBFZN5AAMbnpw9y/OLi7Kcm8C6U=;
        b=orn/Ckjk/9POZ8I6pmWu/LNnQqKul5Ro8TWPG7SuvceRIy0s1pL9N9iIn/LhJo5XJx
         evmds19liUAQcS3PuJpkm0P+L2qx3UrPOqbFQ6+bvR/D+pyX84jh6jdmA6Vgdc54tjDd
         jwQamwAhZarTUQMeNP7C08qUCVQeoxjAjJ0oqes6dpXX/nNYHgXkpKQySMMIT0CZ+I1S
         qPJ5riePEJY/qTdtuoZXJz6BXIsAb62ME8+Q1ANA/A3DvdB7xr/gpuqlQrIcR7P83b1j
         Y48syL+HGuWH9m82xTunmiRuuMwHyjPVlyFjnzOR+wJ9k7243xAylkCC4HD6g4GdX/2D
         YiZQ==
X-Forwarded-Encrypted: i=1; AHgh+Rrvu8NxgARzQFiD5PNftHBlHg4nicX4ESsVWXw4TD8Nd2Z09KN/Mg5xqcCe/oMV9KzlPUo7pRlScTxHMJWQ@vger.kernel.org
X-Gm-Message-State: AOJu0YxX7otv6PtUkP5vsB6aJMZ1CTls5r3hULw7tKNGBKnp1R0aklAx
	xG3MWpnltDXhBH8PEHRC9ePOwKk3/CReIfIklPQyiDDSI0do2rN/bvmipeZVygGuPs25iNRfDyc
	q7QVTbIPomH7tQMbWtIZb64BrR9DX6uo=
X-Gm-Gg: AfdE7cm/XA0MEeHkgqF6m8noLiPjNlIhU+xyknRrK6V1/J53zNMGvbOfEmORPj1kBdC
	EMpbsFiZk/d6u4/tnimZYls09XhVEypGcoGxEoHv91jWSld1f+Ot9XM3h+AgqH9rERFb0/nIlCz
	DdZjj7FzWjv/Qot1XJhLi40dODip/J9dm9W6zSn1aMBJDdovIkJDBzOoYRo7kVLyfHFCNzuGazT
	yNHlUOEDmAF5osQNLoWBiY1mC2hWBQUJEVZiE7NNc/oNwYOMQpOVIyr3yd6zU57ypREpLqmeVs9
	eG3ezbznvqnS8sGC+SRQbAFRASABZiLDsMZmqWhz5AJC2zHv05Sk
X-Received: by 2002:a5d:5ccc:0:b0:475:f0c2:75b3 with SMTP id
 ffacd0b85a97d-47936d2f33emr1915668f8f.30.1783033324743; Thu, 02 Jul 2026
 16:02:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260701000949.1666714-1-joannelkoong@gmail.com>
 <20260701000949.1666714-2-joannelkoong@gmail.com> <20260702140009.GA21339@lst.de>
In-Reply-To: <20260702140009.GA21339@lst.de>
From: Joanne Koong <joannelkoong@gmail.com>
Date: Thu, 2 Jul 2026 16:01:51 -0700
X-Gm-Features: AVVi8CeaIMzXU9RzKe_zbiO3Q8oQSJv6T5IEdOvWb1S4DuwOGjn86_r2tKsstdQ
Message-ID: <CAJnrk1ae4QJgg8pPBVaxQdBkHLTeVtdmPdzLyMJeRkt8xx9OeQ@mail.gmail.com>
Subject: Re: [PATCH v2 01/18] iomap: add ->iomap_next() and iomap_process() helper
To: Christoph Hellwig <hch@lst.de>
Cc: brauner@kernel.org, djwong@kernel.org, willy@infradead.org, 
	hsiangkao@linux.alibaba.com, linux-fsdevel@vger.kernel.org, 
	linux-xfs@vger.kernel.org, open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 2, 2026 at 7:00=E2=80=AFAM Christoph Hellwig <hch@lst.de> wrote=
:
>
> On Tue, Jun 30, 2026 at 05:09:16PM -0700, Joanne Koong wrote:
> > +static int iomap_iter_legacy(struct iomap_iter *iter, const struct iom=
ap_ops *ops)
>
> Overly long line here.  Not that it really matters too much given
> that this goes away by the end of the series.

I'll fix this.

>
> > + * Iterate over filesystem-provided space mappings for the provided fi=
le range.
> > + *
> > + * This function handles cleanup of resources acquired for iteration w=
hen the
> > + * filesystem indicates there are no more space mappings, which means =
that this
> > + * function must be called in a loop that continues as long it returns=
 a
> > + * positive value.  If 0 or a negative value is returned, the caller m=
ust not
> > + * return to the loop body.  Within a loop body, there are two ways to=
 break out
> > + * of the loop body:  leave @iter.status unchanged, or set it to a neg=
ative
> > + * errno.
> > + */
> > +int iomap_iter(struct iomap_iter *iter, const struct iomap_ops *ops)
> > +{
> > +     if (ops->iomap_next)
> > +             return iomap_iter_next(iter, ops);
> > +
> > +     return iomap_iter_legacy(iter, ops);
>
> Maybe inline the code currently in iomap_iter_next here from the
> start, as that what we're getting to by the end of the series anyway.
> And just do a:
>
>         if (!ops->iomap_next))
>                 return iomap_iter_legacy(iter, ops);
>
> at the beginning?

Sounds good, I'll make this change.

>
> > +int iomap_iter_continue(const struct iomap_iter *iter, struct iomap *i=
omap,
> >
>
> It seems like this is largely just factored out form the old iomap_iter()=
.
> Can you do a prep patch before this one which factors this out?
> Preferably in a way that keeps the code in roughly the same place to
> minimize the git blame disturbance?

Sounds good, I'll extract this shared logic out into a preparatory patch.

Thanks,
Joanne
