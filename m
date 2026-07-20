Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CD9A43786E
	for <linux-fsdevel@vger.kernel.org>; Mon, 20 Jul 2026 17:08:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784567340; cv=pass; b=dChpJRqqqSPK1anM1qa30UczJXpOveS2os/2zJOQOZdrhd3V32LCEiDwHa9+GtKUKlp5qYTOjL0JfQbb9097wnPKosvYMgd2PBSM5X/E2F/QYMvdog7LdhUplPVfDPgSFlYEHUIQpzeUTOj3nmR3n4bEKrYNVd4VrCcGZFG051k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784567340; c=relaxed/simple;
	bh=WWr3oWdkA9thr3mPmTFX24PTXG4y9Bqi7LDApv0gSHU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RpU3yiTk6wn/C20dxCxbbhcRS6RD43m/hLRNGqZPV1DfCBWOOCpURXr13UB/jKV8NELcyx26rPZp0Ykmfz09hnH3DLTZwfW1tN8AWPqvl23ayaKJP42gpoEuIvRgtaWQotyaQ513noNyvXcgLvtIZahO1QU4du5DJDs48481r/8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VeoSX/dT; arc=pass smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VeoSX/dT"
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-4954d383e64so16918435e9.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 20 Jul 2026 10:08:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784567336; cv=none;
        d=google.com; s=arc-20260327;
        b=UjFYtD1zUEeqWuIjFLPXy7oBL5XqK3+AQ6s3KxauWRfdg92U15j0MGlq9Qir3HXqlE
         py07ctn8jy7ntNgGmsLUVu6kMlKd/31gN9uFUmdUl/mG3rA33lDZVC3A3HulqpiliCnV
         CblafNGBNMGnNgKY9JAm2cxzKhtydVYRr4rPPuzTbMQlujacgvg6eMO0nakWthq+oYc0
         /6PDu9arNw91KLzP2X18XtYezQTIsDs33NO+CO3wZo3t+ZaeGvVfc5/NPhoBbqI+K5S1
         HczU+3hd2HqyXTUywG1ueUJufhN3komPHJ1hBQz7X72sJCOoHDTjuoggTwond+eML3ZO
         gkBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=MLZfeSNfk0GyJFPhRPnsJJeloRm+Q/IBJupsdVxyw2M=;
        fh=NZagqMBLmDRjrYvekLC2uag6NdICCnIEzvmFk7WKQb4=;
        b=oBQziEGZcetzs1Ni8Hk6CfxPyCRlT2CAzscZIVANFfEyQsqOd7PhzMdVPBiMt9IjqW
         gjPg7bsORn1wdErDqjXs0/F/LA2VfRcJpMJn3VQTeVaKsF9T4Mn1KvFgb1kqcrOJqURf
         4SSwOUcCjIHzDMdgyIgWMDgt7wZt5O7gAVwtUarMYSQVmB9YNhaXlMvrIMg3NkYZD1q8
         LjdfajA2JucS+rNmBZFnTQw/IZZY5qnoRFin7Aha553P9HmeqoWgK8ceQdnQ1ScXm5xX
         BOucz+1mZ02HGbzc62Im0z+eAyRqcLLlACadKLpqtx3foAaFxUbf+YAiK5iNbKoB6yyT
         6pwA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784567336; x=1785172136; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=MLZfeSNfk0GyJFPhRPnsJJeloRm+Q/IBJupsdVxyw2M=;
        b=VeoSX/dT5/spe7F5u90VISsxP1MM9YkgWuL/8/PRDEOu29ToTeOSWarHskNhgJk4Ey
         4uz2d5RCF0HlO0AQ6Ogwm80Amo2GXD5bg7qMF2z74mjnqZpaDvB+4AIE9+s6qDtpwyl4
         gAtM31aLLFKejp/nVSqbmNzJu4SqFaDyTA58gJ7FYUWqKNwmGYDxe+Lm/XvczL82OWFq
         czYYGfIPFvGz60OlrmIfhDW2WK1vGqYLXlv8uow/BXXcdCR+RshWegRixwVpt3yhRV6j
         WNzGNo/JHttx1zYFZWF4bnpr4DUCmpypGXq4+pKw9icfiDtDMLmnmMvfGBn4JocJVdkb
         fUlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784567336; x=1785172136;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=MLZfeSNfk0GyJFPhRPnsJJeloRm+Q/IBJupsdVxyw2M=;
        b=j3xMUR09c7LNkTncid3f3Xny7UJ7tPbis7BcQJSi9vjHeu7Udgqk73bj2ZOPhkw3jM
         azV+JFyEmkneRUhTU701plK5X1Pvx/y4XGv2ERxLcXN/cTpIyJCC0ZStw0Z/szKwantd
         W5k+GBLqpbhJLaoZL0zbl2qRmuNGbdVemVD6nk8BtS1mv1KddMF+oBELLJ8H7V8+yTrE
         12gjchaNIGPSGDkvSECP3AkyFgy7ei91Jupces+om5FfOacvpuLWE3LpJBROLHRTDOG+
         CRmeoW9JEfa8QaMxUwATmZVO/OVxkenNNG4TJ4GEhfxb+aKyRPtYDZ2awrC1ta9QBtj/
         kImA==
X-Forwarded-Encrypted: i=1; AHgh+RrPIqQZFUSVjztVwMealFMfatTNqiQmIrAkNLnTVcUkZz+3brXR52pXGjVZ+xowyindeG2bSlzH8d28Fge5@vger.kernel.org
X-Gm-Message-State: AOJu0Yzta7rREV8dg0ttCjSyE7MgZfjwIgIcpKiNMP6+2XgY350vN8k0
	GMtFA8CBYmTWHjWvW/9Tj3lOObxXYiEDd2bPGJmwqMgmaYrFAQQZ7AV6c/4FrhKLcnOzPD4uUsY
	aXlZvwwTyhJThAGeL4iu+7mxUYPtsuqk=
X-Gm-Gg: AfdE7clPY8x25dmh6/eFoRrWQG3U4yJq8Vo/6gD1Rm8q7OeafuXFRgi+JsY6kmBNDmd
	295nfWU2o1CqXgWxofINXrYswZQcwucu6rmfd2y/6btfjf3ZNlpKjnbhPSU9um0J0Y0hDrQcwnR
	1xFCJdXDhboY7ukeg3nfC1zSo2TPurBYpmVBe5AtxGq/ydc0ZuVY5uytEHAFnQkrt6DuSUAs91v
	Bau5p5kzGPiD4I6OdLmmEt8y5wGrBDB/1TXDdEs9yEap9aDwrQulAEKjchMJF3urylQSPxBgdDs
	U2pGaM7eEAyVJOPeMbj5evyoeWCbgGEwm6COlaJH1Q==
X-Received: by 2002:a05:600c:3b9e:b0:493:c1bc:79bd with SMTP id
 5b1f17b1804b1-4954a41150fmr169137625e9.20.1784567335995; Mon, 20 Jul 2026
 10:08:55 -0700 (PDT)
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
 <CAJnrk1YkAEUhjw6mNEx70ojN7UMQT__oHn5m1Ng2Lz7FoLRhrA@mail.gmail.com>
 <20260717175552.GT7380@frogsfrogsfrogs> <CAJnrk1bjA+Y5V-87AhNGR5-ss7gUJWwLkjouwic1Mckd2QRH7Q@mail.gmail.com>
 <20260720082023.GC18764@lst.de>
In-Reply-To: <20260720082023.GC18764@lst.de>
From: Joanne Koong <joannelkoong@gmail.com>
Date: Mon, 20 Jul 2026 10:08:44 -0700
X-Gm-Features: AUfX_myxykdq5BmH_ibLMFKTMx3f4TAodjFz2tFl3aRbdQZ0aLX2i2ATdYiHhLs
Message-ID: <CAJnrk1ZfQxp0SfnuPe_n0dE8vd2XCuiG8ZWRZWSkDwbiV814-w@mail.gmail.com>
Subject: Re: [PATCH v2 02/18] xfs: convert iomap ops to ->iomap_next()
To: Christoph Hellwig <hch@lst.de>
Cc: "Darrick J. Wong" <djwong@kernel.org>, brauner@kernel.org, willy@infradead.org, 
	hsiangkao@linux.alibaba.com, linux-fsdevel@vger.kernel.org, 
	linux-xfs@vger.kernel.org, Carlos Maiolino <cem@kernel.org>, 
	open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 20, 2026 at 1:20=E2=80=AFAM Christoph Hellwig <hch@lst.de> wrot=
e:
>
> > static int
> > xfs_seek_iomap_next(
> >        const struct iomap_iter *iter,
> >        struct iomap            *iomap,
> >        struct iomap            *srcmap)
> > {
> >        return iomap_iter_next(iter, iomap, srcmap, xfs_seek_iomap_begin=
, NULL);
> > }
>
> Looks fine.  And this might also be on of the rare case where a littl mac=
ro
> magic to generate this might fine.  I.e. turn this into:
>
> static DEFINE_IOMAP_ITER_NEXT(xfs_read_iomap_next, xfs_seek_iomap_begin);
> static DEFINE_IOMAP_ITER_NEXT(xfs_seek_iomap_next, xfs_read_iomap_begin);
>
> and
>
> static DEFINE_IOMAP_ITER_NEXT_END(xfs_buffered_write_iomap_next,
>                 xfs_buffered_write_iomap_begin, xfs_buffered_write_iomap_=
end);
>
> (could be shorted with string concatenations, but those are really annoyi=
ng..)
>

Sounds good, I'll add this to v3.

Thanks,
Joanne
