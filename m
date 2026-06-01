Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 942F537BE83
	for <linux-fsdevel@vger.kernel.org>; Mon,  1 Jun 2026 20:23:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780345423; cv=pass; b=lVLVQQknHVOBevImw0INKG+lEaj+sjvggJdsQpah3NCVncZBybNt5IWE3Nl48J9jVwTiPaM7EvL7elo4lk7VbeBkO0bf2f0d723k5PB1mIxwSl3JlzeOYtwTS8utyhrBW6xWiY2BvXfiEYZCdG67TauBnkBcnef6aK1fex5KgGM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780345423; c=relaxed/simple;
	bh=Fm6M4um3jz58vuU2E3v6tA2UqFpTs4jPcRpeOwF8r8o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Dgj6AJjm+MUZoQSYDgsO/cv7GOVBJH7uFmFNhbe+nzDxQXe6YLknd/vdfTxV+MX6vMAZrrwmDTkjsgxO9cQKszL3OCGXSFVOfO945uyGDCTtHLzFcnUUwkAlxC/rnlzE8s5VZE+5MqVUP4yNq6nJXgMAdR3fRRPISHzUQnf7p0c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MUkDV8mj; arc=pass smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MUkDV8mj"
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-68be16c61d1so6727804a12.2
        for <linux-fsdevel@vger.kernel.org>; Mon, 01 Jun 2026 13:23:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780345421; cv=none;
        d=google.com; s=arc-20240605;
        b=fv+fS3hGSNa1dQupwnSkl1ITEtGmQBvvZBUnRd10vZhC1PXt5yQbSSNFC+/cp28aWm
         fGWRTmNMOPtImbzx6gx0WyFxcnfI4ZePXV0gOdNBN01jkK2paIGPU1RRPUo1jCTpuso3
         g4m0Z6WAixfqQ3xRp1MUYef1Lp2nSCbzz8bQQjp0swf0pBaAjXT2hF6E4C/H7zyheXB9
         hY5jeKNPAAdA01WEwP29h5vPn/aWqOKD/hmLAfLVHWdqlglqu9kS5NeJ+zzL3BDJKGiA
         RaGLS/QbfioUv/0Fkm4xORV6wTIsCR/rLBWWVSZ+QCfTYuuhF7vy5oVSJ1+0fXNioi0u
         uI5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=3vdy/9lfk10jFlI5MPXTZTsaeG+vblB7sm0FDgjlwKE=;
        fh=A1O+OnJdrAyX7AGYkUV/5gI85MOaXeBBCBsp9xReJYc=;
        b=Rn5IphLi8QnvZGGPoyqwMlGSz396Ng2KjMEy2VRn2ZLow1k3ZF2LnIjfsswSzXd1Zo
         VedNqhH+CWUB6ptXgAF/rrUJUDJQFRIcUQxM0wIzPJ+MPK8SIdH0DmrMbTnEA7Lv2HS9
         Hu3CA84MjbB0xpADDWm4v+VGylB/+cku4XwmXNUQfjByzuSE42I8sVe+/31jP1+EB8Bl
         HimxsjDW9PUFeha9QM6SI3wcQnkdSIUiEYNwQOIzVrunNi0pGTgU+LkBxoOqxIrZKQyQ
         Pd2dLvoqDC8t/XY679+TIaItRYBkXh/XBtv8LLU1R+hZIP4K/xMmMdrz2rb22L14DF/K
         y6EA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780345421; x=1780950221; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3vdy/9lfk10jFlI5MPXTZTsaeG+vblB7sm0FDgjlwKE=;
        b=MUkDV8mj7O1Yb7ncEHEC7OjSWZzoIiBR+VytpopHTC4xZUlRs+WIxkGeynIN60TN7X
         vMssBYTQ96IsQ4f0RxxTfsCADgCr+8L0OT3MkZqkpDzZ+RAwn4H+YyVMBXmbqBYKVe50
         Lk4+14vo5zwtU/+/ysajqy9qnT6ysD44pL81917hOnAop6IbLSj3Xdo6ifpf4w4LCbaz
         9zJ11y+JUNrzvTJ37xt4161MrK4xYY47++u47n4GTzxSlYXPr47AqWLCYrR67kRns7iE
         LmlcwtXCbw7qo7ctoY/gaVy8h5j/+HZ/IDgQGwIungTIVocMt46P0zqYhMd8Ro1CHcx/
         LWlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780345421; x=1780950221;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=3vdy/9lfk10jFlI5MPXTZTsaeG+vblB7sm0FDgjlwKE=;
        b=oDMxRWF9929yfwXdqZ/5gWayQ4s6D8pDRBAK/ShDRmKkJypNuGeSNhzLMHjpECmrRl
         3iMbzVocO1GEF7P4x4d06dIvdvXRj+6qFW24zxwSxgibZ3QmgWP7Ht6DRV3Ha1hmX8zV
         i31yt/zlijEtg49FJKdaMVG87Y+qRABNJ5muqVi1HqIEHt/yHDlMKaq8gFrWMRaGJTwW
         C1s39Ik+hrk1YKHonpWs7pVF/Tl3KxWsdL/0nozhcCkpyxL6zY/J2V35jduQ+ElCUCzN
         KjyNuXCX07qka/2K0Hsk1avodOwQkTcKcmTdBmKX6j14n9Q6ugtzbEAoivLxGl9zvEbF
         yGGA==
X-Gm-Message-State: AOJu0Ywao3pzHoiHxrUc1DSfOJ5kHYwaBNM1qXze8w1Dtg9UAl62M/Nn
	EG8Pvtn+66KVVvOwkrX9O1PFkHLRh9CqczkQLqk6jjtEsVMbp/Yt7+ICpep5gKOw4eYHwCcxEY2
	QGBFuqWIAxblc73RES2g/5ISJHbp0Ubc=
X-Gm-Gg: Acq92OFtKIMM2Cnz01A/VNx4gPGXsejkhtenziYgUYHN/Sxv++ivJORgjNZPde/CX1e
	4cQvgnjXwd+W7VXbLPQpo9p9prnMyu7XCrzOPnNU+XmiIlrzqNc66wfBBTNKaek65WjpsXyLG8c
	b2iVgiFMQudbvlKPC1A4s635J2e6uiJUTl6ncOLjBavbWXfLSktbg+u3jwqEUpgYNVLPYSrVZjP
	w61jod22GEO2nMhPiSmt9c5hp8F6/Atz4ee6IXKNAMlbD8yU/qm+XonZNzM7Cp7tB0j3gOyqlPO
	wC/5+Kr+HpljLRWKSf49fvLKkN7jpfxUIG2Gj8eMtfwll1jGQuUQ
X-Received: by 2002:a05:6402:11c6:b0:68c:342f:239e with SMTP id
 4fb4d7f45d1cf-68c88b3c34bmr5981654a12.7.1780345420716; Mon, 01 Jun 2026
 13:23:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260529031918.7361-1-russ.fellows@gmail.com> <20260529031918.7361-2-russ.fellows@gmail.com>
 <ah3VCxciXhS0CFdP@amir-ThinkPad-T480> <02AD69BF-A91D-4798-A90D-7692D3C1ABD0@gmail.com>
In-Reply-To: <02AD69BF-A91D-4798-A90D-7692D3C1ABD0@gmail.com>
From: Amir Goldstein <amir73il@gmail.com>
Date: Mon, 1 Jun 2026 22:23:28 +0200
X-Gm-Features: AVHnY4LctJJobQSLiO3WLovKObSNVtqbvrH95fVZEYwelIN2yUK74a1NSIrwKII
Message-ID: <CAOQ4uxha6Z8ZH0jT5PB6iujQmLjmpEXBCVLkCFgzegcg+2g=JQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] fuse: fix FOPEN_PARALLEL_DIRECT_WRITES being ignored
 for passthrough writes
To: Russ Fellows <russ.fellows@gmail.com>
Cc: linux-fsdevel@vger.kernel.org, miklos@szeredi.hu, 
	linux-kernel@vger.kernel.org, fuse-devel@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 1, 2026 at 9:25=E2=80=AFPM Russ Fellows <russ.fellows@gmail.com=
> wrote:

> > On Jun 1, 2026, at 12:52=E2=80=AFPM, Amir Goldstein <amir73il@gmail.com=
> wrote:
> >
> > Removing stable list - this is definetly NOT a bug fix
> > Please CC fuse-devel@lists.linux.dev for future fuse patches
> >
> >
> > Not a fix, because this was very intentional.
> > It is a new feature that you are proposing to support parallel
> > passthrough dio.
> >
> > Anyway, this patch has many problems
> >
> >>
> >
> > You can't just use fuse_dio_lock() like this
> > it plays nasty games with the iomode.
> > It does not even check for O_DIRECT mode, so this would do
> > parallel buffered write (at least until it meets the filesystem lock
> > but its not something we would want.
> > You should study this code better.
> >
> >>      ret =3D backing_file_write_iter(backing_file, iter, iocb, iocb->k=
i_flags,
> >>                                    &ctx);
> >
> > The problem is that while backing_file_write_iter() does not seem to
> > directly require an exclusive lock (apart from maybe file_remove_privs)
> > the fuse_passthrough_end_write() callback does I think rely on this
> > exclusive lock.
> >
> > So proving that this can work will require more research and more effor=
t
> > and I am not really sure how that is going to work out.
> >
> > Thanks,
> > Amir.
>

No "top posting" in the mailing list please :)

>
> Amir,
>
> I appreciate your feedback.  I will review and revise my proposed changes=
.
>
> I will also remove the =E2=80=9Cfix=E2=80=9D tag and mark this as an enha=
ncement to FUSE parallel I/O.
>
> As an aside, I have tested the kernel changes quite a bit and have had no=
 crashes or corruption,

I believe that but the corner cases of parallel dio with extending
writes are the
devil in the details and its unlikely that you covered those without
very deliberate testing
I am not saying there is a race but takes a lot of proof to remove a
lock and this
proof is on the one trying to remove it.

> and the write performance is 3x.

I believe that but can't just remove the lock and show the performance

>  But, I will use your input to focus these changes more appropriately and=
 eliminate  their unintended consequences.
>

My instinct is that it might be easier to do this with PASSTHROUGH_INO [1]
where the attributes are always read from the backing inode, so less
races to worry about.

Good luck,
Amir.

[1] https://lore.kernel.org/fuse-devel/20260516004004.1455526-2-joannelkoon=
g@gmail.com/
