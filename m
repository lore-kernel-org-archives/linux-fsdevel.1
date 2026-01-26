Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27A642DFF19
	for <linux-fsdevel@vger.kernel.org>; Mon, 26 Jan 2026 21:36:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.172
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769463394; cv=pass; b=hCAQz/JyfmYYisqaqK2n+Wl37ORoS+XisKxqdJte+lhiWWezjbr+4mIafiTIgfT13zt1O4vXnhxW/XmlFUM5hhUPIwhxI3dkzBjIJ/QeKaPfrgD5sAndqT5wMkcAcNEb4dDSqrRE8hxy0Ak4Xj7S2ZUmMMgVNq/fNIYlEUVbBck=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769463394; c=relaxed/simple;
	bh=2LlobdN2PFPktUMiTbWxyPkhzhl6xaNmQUmMtFgX9cI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CgaAjAOgUQJSJND+P/iFxpXgYM87uIXGU9LEqmyvpIA34lK4k+nRRA8Pn2bx9yOQYimC5i5b001FUL37ZwKzzt8wuj7G6p6ON0itGotynuyIcqQso9sjyH9iT3Sqv4gm3X7Y2Pc8Ii5PvMkScJlyuarQ7r+icFVSX/PyQxC5AjI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZLoA5Q+c; arc=pass smtp.client-ip=209.85.160.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZLoA5Q+c"
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-502a2370e4fso40296111cf.3
        for <linux-fsdevel@vger.kernel.org>; Mon, 26 Jan 2026 13:36:32 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769463392; cv=none;
        d=google.com; s=arc-20240605;
        b=YPIQwKXVYxHacwkGBJH1dmqvntquRjfNJ9NVnPKT640UfJFHot7+x6QavFqieVyA1L
         5a1xe+4EMSm5hWspCTW1MvpajwqsojRnHkgHWyJZlY1xytYfCv3uswKn2FUOmpvDkws/
         UeiYodxM1s1aH0zk/s99IQvnGskO+fEd6APOBDhOqZ1PkX4Q5UnRiC/fVfGOBgS+SHpT
         NPa3YCtJWA9fPjCDtYNztbw2E+TisF73OuG2N3mypA9v+G+3ubfuA1vT5SO1RmYK0QJm
         GyppFSELw4Gd0ogMVf+JrJlvizdVSTnpYwtg4N0zipddhDww+3VPInfcvfkAkTXyuq70
         OatQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=2jNI08tutq/8D39hGYCp9mcPFqZrFuq0dA3+PKU1428=;
        fh=Ss9O9ZSZPMJFerljSvscJ1SqMiA7pu5shvigYXxTkRo=;
        b=aiwprPA5d4t9IinWJDLy0U7irjA2pUc480b0/Z2CYgujRLjO5J3k7wmmBPp9/sdW43
         ynErx5z28l0/ih4BwbJJDb7Aq1C396ar7Qm+YXv9sU/Xqvm4xLEOsxzJv7hwQHWDki1e
         tYBphyy1o9YdUT6csP6bJe2mPZzNJI58kIx3tkvd3WBofsXbeU9o+DpCJD8e0Ky0qjPu
         wgV4lI9ODOZd3au+J/b61JmtosfRFZeVKHUtpYBxoMjyg4lyb5lIXLArEQ3oySlozUKO
         cdIg45H/XTTfhmAIQui+eLCQwsFfN07LdpocRxj0hVv8yuRzY5+SHeODNkuzpwNXzxEt
         hWjg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769463392; x=1770068192; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2jNI08tutq/8D39hGYCp9mcPFqZrFuq0dA3+PKU1428=;
        b=ZLoA5Q+cdyn9N1brRkr6P74IAfzIXTmabuC9pscWRP6ciRdhtSW1EQSwcNvJsnh6Hc
         s4SmtkwW/b1XI0NTS6+D/OdLZC054csox2x0oA+c3QanAClGz+1Vxpd3dbBq6yJ2CitE
         2R74uy3g78jiKKB9w65ysL5PwnklkXBbdOC87hhfl0A0R0AcDAPzdzy62K0JlUHfiqEp
         PzPr7hmgUCJYahGKtruPy3gbyahu1j55TdoKNMW8VBmD4477EX/D+gS4665R6CRqJvtK
         bBPDP3iF3L4bn7YTxriKYh9KfJR6bF6tEW5zc5gMZmfBTOjLub9FdjBBaXZcE8kJ/ReA
         rwGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769463392; x=1770068192;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=2jNI08tutq/8D39hGYCp9mcPFqZrFuq0dA3+PKU1428=;
        b=ICsZSxDPoTE0zajAvfhM2y4bVehbftcs43yh4JYOsX0NeXd6c+pSdRrLMAgVtiWkWI
         rvXR562un9fRmbb/2iVMmm5HNGY4kK7d4hjySQHz/I8ZHgSUFZlXU9ltg4u9/JpBfxep
         EVzlc/Fv7VfEOR0iQ2CmuN2s62SY5+2DOA/pakKN0kIi9Gr8bRWffXcNHIF54W/g8MsC
         s5Az5QdxY71zKonIV0c6yeVo4VtMxWe3G3Rk8B3N6C+H/DtwhES/g38O3qqoD5oBvbzj
         5pamvoSJt8T4qlsBmKSSWP3Hc9iOJIoaItebcvdusky99uHqok3Hx7A30hNAZOVUYtyX
         Cu8w==
X-Forwarded-Encrypted: i=1; AJvYcCVJhQcvnECTAq0h2Tp1EqbFn7YcZfxKFdgBykaFUUNhNfAUiFgpwitviqny8tCv/qfIFa5NzrkVCcuduGxe@vger.kernel.org
X-Gm-Message-State: AOJu0YxpMSZPhQDkxoyf2x6DnmdgO4UL4UktZRyxqncl1DkIKKUMWHTh
	sSJhasB/icO/TGXq4XreYP3CN1YgQ7pD7DjkZT6dNLw3+RAYMgRfX+v5BD+L/wHLz6KX31DIPAz
	wF7mAUYu1l8Qg4jVymM8WCYX1Ivf7RoYGHk/M
X-Gm-Gg: AZuq6aL9GIeJSIJC9bUgWvO52j+LgIrb/NuuJRvKkCDf7QbQEOe9zKsvFq+QMBWKCg7
	ScQy1S1z7On0BjWnez0+9+hdb0YLAFcxWNoHmSu5ATjZ+5EmjNqow/FrfzCNNCb+QL3ONcOSwkX
	5SZK/sy+cS1fNw8Lv8BIeWXGaJ5QI1zDJADpIZ3gZ3ZUo1XLb8KKLGWzh8qvYfXQPj7fUjaIk8w
	QX47BHEj+onxJEv9zFq1Zy+SsY1mggGKDhO4kjgdwSLtevBbu94O/PHR5TbugCbCEyU63ZHFCu8
	d+EuqMPx/0Y=
X-Received: by 2002:ac8:5d13:0:b0:4ed:af7b:69cf with SMTP id
 d75a77b69052e-50314bde1c4mr71936551cf.37.1769463392079; Mon, 26 Jan 2026
 13:36:32 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260123235617.1026939-1-joannelkoong@gmail.com>
 <20260123235617.1026939-2-joannelkoong@gmail.com> <aXb_trkyt-uzdIkd@infradead.org>
 <aXeAY8K12KKf9d4_@casper.infradead.org>
In-Reply-To: <aXeAY8K12KKf9d4_@casper.infradead.org>
From: Joanne Koong <joannelkoong@gmail.com>
Date: Mon, 26 Jan 2026 13:36:21 -0800
X-Gm-Features: AZwV_QiQ2K1gZ1WqSwjbey2ulbjKIJpIAHJfE-ZwChAhpPIqooavR_wAUPMpMcQ
Message-ID: <CAJnrk1aQ8s04Co_Ncd41EpbMJEexPEF2qtAhGnG1rop8LLvWHA@mail.gmail.com>
Subject: Re: [PATCH v4 1/1] iomap: fix invalid folio access after folio_end_read()
To: Matthew Wilcox <willy@infradead.org>
Cc: Christoph Hellwig <hch@infradead.org>, brauner@kernel.org, djwong@kernel.org, 
	bfoster@redhat.com, linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 26, 2026 at 6:55=E2=80=AFAM Matthew Wilcox <willy@infradead.org=
> wrote:
>
> On Sun, Jan 25, 2026 at 09:46:30PM -0800, Christoph Hellwig wrote:
> > > -   if (ctx->ops->submit_read)
> > > -           ctx->ops->submit_read(ctx);
> > > -
> > > -   iomap_read_end(folio, bytes_submitted);
> > > +   iomap_read_submit_and_end(ctx, bytes_submitted);
> >
> > Can you drop this cleanup for now?  I think it's actually useful,
> > but it should be in a separate patch, and creates a conflict with
> > my iomap PI series.
> >
> > The actual fix looks great and simplified the code nicely!
>
> I don't think it's just a cleanup -- I think it's a bug fix.  But, yes,
> it should be a separate patch because it's a separate bug.  That bug
> can be hit if the folio passed to iomap_read_folio() covers more than
> one extent, the first call to iomap_iter() succeeds, and then the second
> one fails.  Now we have a folio with a positive read_pending that will
> never become zero, so we'll never unlock the folio.

I don't think there's a separate bug. The number of bytes submitted
is tracked per-folio across iterations/mappings. If the first call to
iomap_iter() succeeds and the second one fails, iomap_read_folio()
still calls iomap_read_end() and decrements ifs->read_bytes_pending /
does any folio unlocking it might need to do.

This change to iomap_read_folio() is a fix for the original bug (eg
for folios without an ifs, the IO helper might have already called
folio_end_read(), so ctx->cur_folio() needs to be used instead of the
direct folio pointer).

I'll drop the change for the new iomap_read_submit_and_end() helper
and submit that later as a separate patch to Christian's tree.

Thanks,
Joanne


>
> Not sure how we'd write an fstest that would exercise this ...
