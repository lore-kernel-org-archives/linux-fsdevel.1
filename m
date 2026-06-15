Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 469AB3F1AD5
	for <linux-fsdevel@vger.kernel.org>; Mon, 15 Jun 2026 13:12:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781529125; cv=pass; b=G5jBoPBKthmTHWzAkXt/zWeaFvxPh8EsR7R7QERAh+QzpGAoQTc7CNn0LVap4zksLWBkCBNJJO0az6X0Q3G/7s6oRfyrMlkKnY9aYekf86Odv8EWgN6Qz4rkpTqvmML76qZ8jY8W1xFNDRY6qtlzWvhAYqD0yNrL6PCKhO23WpQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781529125; c=relaxed/simple;
	bh=kKNBiJvc+rzdgShKrG5gbJxYUuppXn+sgk4q2LkXCxM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tr63AfuOtkGZ+c4vejZk2PPgCDkYxSYFKcPJGtrSNK1xnnhiwJBmX7wFDlH8I/+fEOdFbAdp7LLUXbs0maKwm6WNG2snXuiErfH2p6nL5rzQaxIHivS47NogJaPAOG/c78ZxSJNMNzhz84faCnFnzottXTifRMavBIwrWRGnYXc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HHYjxo+A; arc=pass smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HHYjxo+A"
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-45efb698ef2so1702111f8f.3
        for <linux-fsdevel@vger.kernel.org>; Mon, 15 Jun 2026 06:12:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781529123; cv=none;
        d=google.com; s=arc-20240605;
        b=lC/vfiP3WsnCNRMaYLq7b+kOQ1m1AUezzQZIiIdFSmUkLUS7uaNekKXp4HoipY6+9r
         57aUQoRjxLPYW5M04nmSX6h+X59nKt4R+V/UCnLPnBkAJz4xm6va7S2qUzfELShRgW9s
         1T8mFQM4iSbksGQzuGEft3JEunWKXcixkbvh5c/07a1U7Hiclgd3ywt70vOnb8wF2YMH
         hU9HVzNrh6yTmy40+4uhELbTgJMvsQKzSi4+zXw843oV/LG+JBku7dqoH8MRwFemvlbu
         vb5YpvMlcKaU7VQ+MyHOBLYp6m0+BAa4mHRq0STMw/xCgGFg6O3MWbV/1UHve0QsUZhF
         qKyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=kKNBiJvc+rzdgShKrG5gbJxYUuppXn+sgk4q2LkXCxM=;
        fh=eVEcYUQWhkts6yOrqahHQvavch/67vWFP8I2osggYNs=;
        b=cj5RQkb0vSt/dGdKP+8vIzBlOq1zyUWoJBkjiwetczP+XWA/kv96OGQJfS2spq3xoY
         Fn7CSwympbLOiKGiZrIXud+ejwMjC/hEYzI73d2BSaGkzVjrTfEVJ0jx8eRDk2pImN7x
         J9QCKWqDXeGlJsBv1sioTc+JhI5NIVzLhjL1SBOOTXtQ/gP/91OOqhM6e85UbHzvREvV
         RrJMH8jqBv08qCxGcHlFMFvmeZ/Z9VlWlZP/h9ep2oHWkTxoxaIB1MFILKAqiue1Hs+U
         CLeV+4IJVZN5AKCsn9f+rd6ELDGX26UWteAiJpoBcBTz0b1K4SdeBlHQpFja4avNqsBg
         gjDw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781529123; x=1782133923; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kKNBiJvc+rzdgShKrG5gbJxYUuppXn+sgk4q2LkXCxM=;
        b=HHYjxo+ABMf4k75UFo2LHf9OhCUH4tcliJ9GS5gTe078dGmMRE4sxyCu594yeTvhvi
         zE7gNU30USct+EsLW59ZrkfrwzgTQOUZyXDVDr6XPpKSjsnL3gLsQxS7FJW9uzC9qd8S
         gOVVi44SCZ2/AkfNVgkr6WxuDs48KCFTdGvdf5KFHaHojnTw1V0bvECSlxi/CGl1oObD
         k/6Z+Aa09LJSivg1CJTF63aYbfQa7LoGwZMQGUN2lDtCryVfpYD4kVcMBdobRFrzuUGQ
         ksQhXy4RhHVImqzxsiKmZMD+HAleczHZf42jVW7GbqrCrv80rJyUKjSKrB0/gJCm/vme
         EWmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781529123; x=1782133923;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=kKNBiJvc+rzdgShKrG5gbJxYUuppXn+sgk4q2LkXCxM=;
        b=JC6iBAymnrUcjL+7z/XXA1NxATNePXVOdFT9I9nqBe8tHmJRMm9MlfXCOgb8JXme03
         AYWPPuskiIcZadT/dVf6WbaG8Lin1bxp9TaAsPgx2Omsbf3TL053b/yB6TuCDq4xliW8
         2nm+kEGMPGdl0hGkKiSSSI9Prg7Cylz27q6nvRde7kzdSsKwef5fVxK0rbTWo+pLVWW4
         epoIcDRH3fNRIqAXa1YUR6hLi1xK4Jp3v/PJpTdb9Me3u7QyyxrL3e6yn2LNyH2BkmZz
         D/9kKGTgxnm667S7IixX5VmQQUNekfiALqz2UvX35d4m2t/FYUaHXo51aO57ok+FcBst
         rZ/g==
X-Forwarded-Encrypted: i=1; AFNElJ9HOnwPSnW/1zkclThoYkjpzt7CtFW0l3nHqyLUaX3biLTd+GFdq42aMDFisI1uYibHH8m4ZM/0qrJ2jwVf@vger.kernel.org
X-Gm-Message-State: AOJu0Ywev50qD7ENQc632LFcBfJ2LuvQRtvRuvhAcVr2NYo2Tvzc9JSU
	xiXZ+xTkpniUievmnuCxnpqSSeQbQSEJwxFmNb1Q3OZXMFA/qhQE5mn/ycc2tleluIs5AC5jQJ/
	5Id2FqC7HlTbOfv+OHXgzrknxS3GcqJo=
X-Gm-Gg: Acq92OFQQvhtW1uQbgDe0op4UT1HHm+YlOoopZgoS1/BPwKn2BpxO40L2izedbbZSul
	ehBTnf19KTpRJoST+hfkJapG63DTf84HvNnwDwqNCdSpJxtZBEc1koKZITWcO3r4Zzpjqwsbif+
	aX040hqXw/Bjvqu353+4nZTRq/RM68MDbO2Snj3MfIf8TLMIOv+BCISyt8HxB94UsZyNj376ENP
	P072msbCXr16A0+V9WMbNCiHwQVgm7BaIKF0Jr8+R3ousANR+HvDCBlAEXyMA9URVnagtSVClMf
	pZGjEgGMB0okz0fK+AexQ7UpmJPurPCsfT5AmWIwVAHKmqtlMkGsPb1ce7A//mU+Kd4=
X-Received: by 2002:a05:6000:1842:b0:45e:eec6:500c with SMTP id
 ffacd0b85a97d-46074b8a1a8mr14546144f8f.39.1781529122279; Mon, 15 Jun 2026
 06:12:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260531010107.1953702-1-safinaskar@gmail.com>
 <20260601-enthusiasmus-canceln-anlehnen-0e62317a9784@brauner>
 <CAHk-=wifX_rrDjRGnDnOqE-usptAukuXKrmuPuVDP5bOCBWzGQ@mail.gmail.com>
 <20260601173325.GH2636677@ZenIV> <83f05c55-efba-4bf5-abfe-d2ab0819e904@packett.cool>
In-Reply-To: <83f05c55-efba-4bf5-abfe-d2ab0819e904@packett.cool>
From: Joanne Koong <joannelkoong@gmail.com>
Date: Mon, 15 Jun 2026 09:11:49 -0400
X-Gm-Features: AVVi8CeKgoUdgzfGyE3gGhvo39veJuptxa85IFXCJ5UZu0W-8unFPPqkk0CT60c
Message-ID: <CAJnrk1Y9egYizkx1H9K0cqxSYuB+7vLvQbV7Tf4C5eHFqnnC-A@mail.gmail.com>
Subject: Re: [PATCH 0/3] vmsplice: make vmsplice a trivial wrapper for preadv2/pwritev2
To: Val Packett <val@packett.cool>
Cc: Al Viro <viro@zeniv.linux.org.uk>, Linus Torvalds <torvalds@linux-foundation.org>, 
	Christian Brauner <brauner@kernel.org>, Askar Safin <safinaskar@gmail.com>, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, linux-api@vger.kernel.org, netdev@vger.kernel.org, 
	Matthew Wilcox <willy@infradead.org>, Jens Axboe <axboe@kernel.dk>, 
	Christoph Hellwig <hch@infradead.org>, David Howells <dhowells@redhat.com>, 
	Andrew Morton <akpm@linux-foundation.org>, David Hildenbrand <david@kernel.org>, 
	Pedro Falcato <pfalcato@suse.de>, Miklos Szeredi <miklos@szeredi.hu>, patches@lists.linux.dev, 
	linux-fsdevel@vger.kernel.org, Jan Kara <jack@suse.cz>, 
	Steven Rostedt <rostedt@goodmis.org>, fuse-devel <fuse-devel@lists.linux.dev>, 
	Bernd Schubert <bernd@bsbernd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 15, 2026 at 2:25=E2=80=AFAM Val Packett <val@packett.cool> wrot=
e:
>
> Hi,
>
> On 6/1/26 2:33 PM, Al Viro wrote:
> > On Mon, Jun 01, 2026 at 10:17:23AM -0700, Linus Torvalds wrote:
> >
> >> TLDR: maybe we could ghet rid of "f_op->splice_read". *That* would be
> >> a big simplification.
> > FUSE might be interesting - fuse_dev_splice_read() and its ilk.
> > Communications between the kernel and fuse server at least used to
> > seriously want that, so that would be one place to look for unhappy
> > userland...
>
> speaking of fuse_dev_splice=E2=80=A6=E2=80=A6_write actually, this series=
 has broken
> xdg-document-portal!
>
> https://github.com/flatpak/xdg-desktop-portal/issues/2026
>
> Specifically what happens is that the EINVAL is returned due to oh.len
> !=3D nbytes:
>
> fuse_dev_do_write: oh.len 16400 !=3D nbytes 15526
>
> (where 16400 =3D=3D 16384 (read len) + 16, 15526 =3D=3D 15510 (file len) =
+ 16)
>
> After reverting the series, there is no error because oh.len
> becomes 15526 too.

I think this is because of how libfuse handles eof / short reads. When
it detects a short read, it fixes up the header length after the
header was already vmspliced to the pipe because it assumes vmsplice
mapped the header's page into the pipe by reference. It assumes that
modifying the header length in place gets then reflected in what the
pipe later splices out.

The logic for this happens in fuse_send_data_iov() [1]:
a) sets out->len =3D headerlen (16) + len (16384) =3D 16400 in the
stack-allocated fuse_out_header
b) vmsplices the header to the pipe
c) splices the backing file to the pipe. if this hits EOF, it'll get
back 15510 instead of 16384
d) detects the short read [2], fixes up the stack out->len =3D 16 + 15510 =
=3D 15526
e) splices the pipe to /dev/fuse

After this patch, step b) is a straight copy which means step d)'s
fixup doesn't modify what's in the pipe. This could be fixed up in
libfuse to not depend on modify-after-vmsplice, but I don't think this
helps for applications using already-released libfuse versions. I
think this patch needs to be reverted.

Thanks,
Joanne

[1] https://github.com/libfuse/libfuse/blob/master/lib/fuse_lowlevel.c#L846
[2] https://github.com/libfuse/libfuse/blob/master/lib/fuse_lowlevel.c#L956

>
>
> Thanks,
> ~val
>
