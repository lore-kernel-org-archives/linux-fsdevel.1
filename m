Received: from mail-oa1-f48.google.com (mail-oa1-f48.google.com [209.85.160.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E4163DBD43
	for <linux-fsdevel@vger.kernel.org>; Mon,  1 Jun 2026 15:29:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780327784; cv=pass; b=bNill9c2DrVkSOj20At09ublMvkVHsvbEhPmHGbyO88SET0cGqYlGYkv7XtBhRjlVQHrHT5d9Wn6lHQ2iGcdvsH/nmy371pVBrcCeZNj50rrL7YZOqQy2zuq/IKRu32d1yeItwHtPXRMij4obMSV8wBr6do3H3pyI+4D9PDIJPQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780327784; c=relaxed/simple;
	bh=oi0Ow0XDEAtBt8RurlGOIpfeSQVz3W7XDL/R+3Ddj+k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oxaTZTK7NCe/btfi+NfXwXsM0fNaeLtPvTMZxXaG+dsUHYWdCMs4lfA1D14jAcmJ8ibvm9CXv4aD9qSQAdqClyKGcdeMYWJQmLSURm72Z1P6NSpbMJLHa9QWExd6cTZKQcjDlDeYygxnhG/LheOwuTdKrXkOhxyHlJCzOv+2Otw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JmZLuySf; arc=pass smtp.client-ip=209.85.160.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JmZLuySf"
Received: by mail-oa1-f48.google.com with SMTP id 586e51a60fabf-43cfc372abbso641300fac.3
        for <linux-fsdevel@vger.kernel.org>; Mon, 01 Jun 2026 08:29:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780327778; cv=none;
        d=google.com; s=arc-20240605;
        b=CnX6IV53JISXWZbgiFlHxeH/Xs+y7Lp8WbCXdj9jZB06p4b6B0vKurP56DvK2MMyh+
         zNOWvfzILNpeJTC3CQ6VxHy8eBcMkFyN3f5lCeEklkZnYTeBpZwyR61eO2w10diIfzda
         dwWxiIymSvB3OZq+AlL0piOXG2MFVJ+lOoZFkOv+0y+Vv7VuIXbuDB/Hz0kMgH3hTXxN
         PEMVaI0+uOJT76K14pfY6aB2l4tOpva1RV8BcqZng0PicT0tgcwP5UMhbGAu4U0sxSKf
         BLEDKIsEoJMkVzZV+GdI/T4Redv2fprHPzHtzWpMRfeqo8WL4VWTr99GxI2rsfrgS26R
         8Gug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=rUPzckO9AMpnkkxRCiU7u4+L0pp2JXYyq4zdqyU3+88=;
        fh=cRw2g0qY0k2K7fIji714vAZtEeU15t5L6hAdKgfS9FQ=;
        b=he0iQtolq2xvGzQ7hz2sj04/Sfm4YIUFtpAYubEqwGpQQn3UyHBqFScqCLcpVhnwlh
         TrLFyCpjZ6NZy/u3oALUaGzyI2kym7byn3+EQtk/mawDCHf8dDo2i71eTQaM7alfveSq
         t7LNPndOWkCM6oF7IlNt6uCvo41qp6RGkbdsMF1Hed9M1jfpBjOX5mcnKmgskLZr5Kd+
         5a9Y1bLCKeV+5/7GRp+b29UCmTMIBxztyMUFUGtglDUU9YIo7dI7Chh9LVmScho3iV9n
         ZxRhanxQbvW3H/LUbnb0BlESJ1Fr2tm1/SsgfG8vkA8xPwBcOs1D9paRJmvL9As36uHZ
         UdTQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780327778; x=1780932578; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rUPzckO9AMpnkkxRCiU7u4+L0pp2JXYyq4zdqyU3+88=;
        b=JmZLuySf1jxWK5iDgOUg/KC5wpk4YcTA4iHLvu3SPSE6bQSgAc/uzq/xgRbv1H9GNx
         jX29mDcnib861fKIHDOztT1C9J5hKrp56xQwMKnFZSG9MZ2K4BKW95lLf3VbLQlRAITb
         6L6p248QXgPCy070KkpSC25fdw1D25He37dIruTaI9ei4g1N0p1vtyPZa/fem+Q+Cr4e
         hexmIDrKKR1LzML5Axq6NWW7A0Q1OR2JYMMutEM0sjOrz4E9SuQSQXE0tNsTI7bH4k+t
         asSyLZRtVrAP+Ad03YBGvDtgn3bphgeBTVK3+I5flNNT3KAejHZb1WkkA3k4Qn7fpefh
         SZUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780327778; x=1780932578;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=rUPzckO9AMpnkkxRCiU7u4+L0pp2JXYyq4zdqyU3+88=;
        b=c0cmCFJJRIFcT8+azkYOrK8yLuQ2plUCnIi9Ioqw4xqD4SPXHjmttnvoIdwaok+1Fk
         eGXUwbjXPUV/X7uF3sd107WNznvpZwoMIygScarxIcNEhsupTJrw2dGb6oJijCQthNE4
         5tK8O712DQFQojAp06caw5c6pDW1SrAP5O+CnYQqsjMAtAHZ1rEk60eWAapJH9qMYAZP
         utBwK1lbKwlNM5mOdu5LekF2U/PldFWLB+MxZaIYt9vJjgvlN2hKLvikrTDy5Ce7jzUH
         B+HRJAVwuFwidtsdcpU7H2c6LmTYyR8mMgDl28Zr8kgOBcpaqvtAejh5bUPUx89+Q6Cx
         BVWA==
X-Forwarded-Encrypted: i=1; AFNElJ/ka+xDefA27VIATOQIkILMq74PvbtUDK8ROlnjtjTpUKtUYjQv9QZZPt5qWLrNrIpKPUjnSEu4xLNw+tZe@vger.kernel.org
X-Gm-Message-State: AOJu0YxIGMwn+86BaKoNOQhj4MvIzQCfI7hEqMTlzufExhpNHKOJfY1t
	Y8uxcf3B35w0h1+XmfG0icYXrpgBUCbUSt96QzHTQ0lMTS723i0ol3qPqM9NGlqw9CxmmNXn69a
	UkY+iYLXeqBUYJdCz9XV1h7XF2FRMYH8=
X-Gm-Gg: Acq92OG5NY7aAHmM+1bVdnBeCySDzVuaZQ6jtuTv/Om8k7J6LIEpObWK15Ehvq5B9rh
	LH6NaWOZzmE8bScHm5eQ+3R1MB0s8fAMSKwu68eeUqkI8648HnTW82MPoBGLXYa2/Gm9Ou/UPE7
	4DoX0Cu0vwhiUsGl8JzK7YFgVEhidPyWEudoFbLM5rtAdWw6AL7aCwAKsgFmch96iA8mMdUV/5t
	owu7v8j+2z/FFAjpa4kPQ78/BAGnUO6Zr2JWzwGA2GVcoNgSm11Eu9jXWcrA/QeWqKRIFyvv4tQ
	ecmc6xIxoyUfQBDFM+ifHHeBqshkvWEqziSjzZqlQJl+rFxezol1dDoT0Xm10mv18G6uiNVRXhd
	+yUre1nkVPdfzLlzw2w==
X-Received: by 2002:a05:6870:e393:b0:43b:4e42:9867 with SMTP id
 586e51a60fabf-43ca40b19a2mr6888184fac.15.1780327778175; Mon, 01 Jun 2026
 08:29:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <1ab8c579-eb76-4227-8a72-6ec819135219@I-love.SAKURA.ne.jp>
 <ag1223nAa0wZ8ALC@fedora> <fda8abc8-6aa2-463b-bf72-865f6b838034@I-love.SAKURA.ne.jp>
 <ahRocb0Vs_m6RF_O@fedora> <1a9f53d4-6f48-4df8-a3d8-2b0e442a163a@I-love.SAKURA.ne.jp>
 <ahZGxoI6oHQ_vSrx@fedora> <d1b5a737-f0e3-4927-b762-430b37fbb2f9@I-love.SAKURA.ne.jp>
 <ahZeYQ0cLE1i8TGs@fedora> <fbb3edda-f108-4e5b-acf2-266f043f8125@I-love.SAKURA.ne.jp>
 <ab5492b6-a053-4e3b-8c59-2e836ae85bc4@kernel.org> <20260528083848.GA7694@lst.de>
 <36571f8a-4df8-4152-b078-d82dbff4ad7e@suse.com>
In-Reply-To: <36571f8a-4df8-4152-b078-d82dbff4ad7e@suse.com>
From: Ming Lei <tom.leiming@gmail.com>
Date: Mon, 1 Jun 2026 10:29:25 -0500
X-Gm-Features: AVHnY4Jo-naNphBnmCUZCCUNQGptd23v8VZulBU6wmiaiHgGY3TyxDIc_hpXI6A
Message-ID: <CACVXFVOSm=VpYfxUEpYk4yC2N1uAoK=vbg_A=h51GXeeArzCpw@mail.gmail.com>
Subject: Re: [PATCH v3] loop: Fix NULL pointer dereference in lo_rw_aio()
To: Qu Wenruo <wqu@suse.com>
Cc: Christoph Hellwig <hch@lst.de>, Damien Le Moal <dlemoal@kernel.org>, 
	Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>, Jens Axboe <axboe@kernel.dk>, 
	Bart Van Assche <bvanassche@acm.org>, linux-block <linux-block@vger.kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@linux-foundation.org>, 
	Linus Torvalds <torvalds@linux-foundation.org>, linux-btrfs@vger.kernel.org, 
	David Sterba <dsterba@suse.com>, linux-fsdevel@vger.kernel.org, 
	Christian Brauner <brauner@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, May 28, 2026 at 5:16=E2=80=AFAM Qu Wenruo <wqu@suse.com> wrote:
>
>
>
> =E5=9C=A8 2026/5/28 18:08, Christoph Hellwig =E5=86=99=E9=81=93:
> > On Thu, May 28, 2026 at 03:11:05AM +0900, Damien Le Moal wrote:
> >> It sounds like the VFS unmount call needs to have something that waits=
 for
> >> sync() to complete. Though, it really feels very strange that an FS ca=
n complete
> >
> > I don't think this is the VFS-controlled VFS file data writeback, which
> > we wait on, but some kind of fs controlled metadata.  And yes, it looks
> > like those file systems are buggy in that area.  We definitively had
> > such bugs in XFS before and fixed them.
> >
> > e.g. 9c7504aa72b6 ("xfs: track and serialize in-flight async buffers ag=
ainst
> > unmount")
> Considering the xfs fix is pretty old, it's before the fix hint thus no
> such mention in fstests.
>
> Do you happen to know which test case is for that fix?
> I'd like to adapt it for btrfs as a reproducer.
>
> This syzbot report doesn't provide a reproducer.
>
>
> Another thing is, if it's some btrfs bios on-the-fly after
> close_ctree(), the most common symptom should be NULL pointer
> dereference inside various btrfs endio functions.
> As all those end_bbio_*() functions are referring to either fs_info or
> inode/eb, thus if the fs is unmounted before the bio finished, they
> should all cause use-after-free.
>
> The only exception is discard, which is using blkdev_issue_discard()
> thus has no such reference to btrfs internal structure, but that's out
> of my understanding.

syzbot log shows the null-ptr-deref  is on WRITE, instead of DISCARD.

https://syzkaller.appspot.com/bug?extid=3Dcd8a9a308e879a4e2c28

Adding WARN_ON(!lo->lo_backing_file) in loop_queue_rq() might capture
this bio submission context if this req isn't issued via wq.

Thanks,
Ming Lei
