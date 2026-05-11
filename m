Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB1493BFE33
	for <linux-fsdevel@vger.kernel.org>; Mon, 11 May 2026 13:47:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778507221; cv=none; b=fX/j8KS2j8d16G2oOl9BEhDOz3RMLiahKR9gTe8wyCeC7uc2t2jJVKR8NZvEaTmnLS27VzwvRBsgIT+WTYwjX/Xo3P2HvCUnxYhfOhss8HaL/QSr6G3cW7E9jpuuAhQo7gTePKnANr6PkWz6cE397fMN36qYgEj6+wh/lintZYk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778507221; c=relaxed/simple;
	bh=nhj4hX1RNsg2sNmC3Qe5fRQGq2laZMd0D19fr/m09oE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Zv0aQdEwi197mDwRL32/WXuz/Iog6dChsVT8lqWRklDT7LsC4mE36jGAyZYZJi7Fk8IHj+/lCdYQjy5EIIqDIqkKLw/tNQ7eEQr6/EmUiyH3ieiKxGSyCG5jAdvhnBikNw/ZUCm02Gg7p/3wMdKAEhZHYMZ5rKYt9P/yW60ZE/Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QMUpKHui; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QMUpKHui"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B450EC2BCFA
	for <linux-fsdevel@vger.kernel.org>; Mon, 11 May 2026 13:47:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778507220;
	bh=nhj4hX1RNsg2sNmC3Qe5fRQGq2laZMd0D19fr/m09oE=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=QMUpKHuilNHqIBv1WzJvh2Z6tFMr77sz9HrHg/cVZ0y4uau61nL8I05U/4W6CNBR/
	 sX3y5xN7PEWl4bg/TaOF7w0IZBS49cxMpkpZu4DHFFcufih92B+N922lyncvJ/eObV
	 a/thz+sDOcbAUZV9AVQIakyP6N7Lt0Y6HK1OQP4fmL9hoQCfGc9zkZs3UNeg7BK6ox
	 JaoQ7OrKY0Si5vJpZQgW1MZ4wwuJnWDIMtfKCRWI1MTX3vcduyJ2uvmmgdut89zIM+
	 T8sxEGEXiQcpmNjRBVK45yDADCaYdgHOqxA2AaJ3aM3vKdReAzSNXzri8Fvb416NC0
	 6SYp8wDK9KspQ==
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-67929ff6dbfso6623004a12.2
        for <linux-fsdevel@vger.kernel.org>; Mon, 11 May 2026 06:47:00 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ/BLdtwaXOWwfEUQTAFvK7vXMrKAk9GBwPVVE17q9Z0gQD2RKzdfTIsHd36m+6sQZ6NK5Veulqy5GDu/+gV@vger.kernel.org
X-Gm-Message-State: AOJu0Ywv3KnhLkoqamjvax1o7mYeRRDWO5ilfqUwDhOZX6Gp9NwUrQOa
	DzQznlaJveVA3AW+r3gR3Tg9vHlAQRW8rIaeD99QnIrgvMBPAdxzXjyMRozhGMcNittg/bMiodp
	HakR/7essYsKeGdhCb+Eh+M3w21drYjo=
X-Received: by 2002:a05:6402:a214:20b0:678:980c:f4eb with SMTP id
 4fb4d7f45d1cf-67d63d8eb50mr9371684a12.9.1778507219187; Mon, 11 May 2026
 06:46:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260507124238.7313-1-linkinjeon@kernel.org> <20260507124238.7313-6-linkinjeon@kernel.org>
 <20260511124500.GA18149@lst.de>
In-Reply-To: <20260511124500.GA18149@lst.de>
From: Namjae Jeon <linkinjeon@kernel.org>
Date: Mon, 11 May 2026 22:46:46 +0900
X-Gmail-Original-Message-ID: <CAKYAXd_dPeCyXo6ASWyTHH4pZnWK3JymbkTrSwF=u5OgTCb_kQ@mail.gmail.com>
X-Gm-Features: AVHnY4I-t_1H4cxbEgcD2NrW6DIU8Qh5gnQfi1F6lg8pxo1UkLuQtivLtOB86WY
Message-ID: <CAKYAXd_dPeCyXo6ASWyTHH4pZnWK3JymbkTrSwF=u5OgTCb_kQ@mail.gmail.com>
Subject: Re: [PATCH v2 5/9] iomap: introduce IOMAP_F_ZERO_TAIL flag
To: Christoph Hellwig <hch@lst.de>
Cc: sj1557.seo@samsung.com, yuezhang.mo@sony.com, brauner@kernel.org, 
	djwong@kernel.org, linux-fsdevel@vger.kernel.org, anmuxixixi@gmail.com, 
	dxdt@dev.snart.me, chizhiling@kylinos.cn, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, May 11, 2026 at 9:45=E2=80=AFPM Christoph Hellwig <hch@lst.de> wrot=
e:
>
> Note: out of subsystem patches should usually go first to stand out.
Okay.
>
> > @@ -853,6 +854,9 @@ static int __iomap_write_begin(const struct iomap_i=
ter *iter,
> >                                                 len, status, GFP_NOFS);
> >                       if (status)
> >                               return status;
> > +
> > +                     if (iomap->flags & IOMAP_F_ZERO_TAIL)
> > +                             folio_zero_segment(folio, to, poff + plen=
);
>
> > + * IOMAP_F_ZERO_TAIL indicates only the unwritten tail of the block sh=
ould be
> > + * zeroed.
>
> So trying to understand what you are doing here.
>
> We're writing to a block with the magic all invalid beyond this marker,
> and you want the data beyond the file write zeroed.  This seems really
> nice and simply, but talking about 'unwritten' confused as I assumed it
> to be an unwritten extent.  But I guess this is not actually reported
> as an unwritten extent, right?  Maybe drop the unwritten here or
> reword it as
Right. I agreed.
>
>  * IOMAP_F_ZERO_TAIL indicates the remainder of the block after the
>  * data written should be zeroed.
>
> ?
I will update it like this in the next version.
>
> And for all this to trigger that write needs to be at valid_size
> but before i_size so that iomap_block_needs_zeroing does not kick in,
> right?
Right.
Thanks for the review!
> And this does n
