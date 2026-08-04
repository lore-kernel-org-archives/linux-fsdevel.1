Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BA893E5EC0
	for <linux-fsdevel@vger.kernel.org>; Tue,  4 Aug 2026 09:10:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785834654; cv=pass; b=Nogb/Wf25VtHqwLZwPjs393ApCk/qrtsdtPKShCu3eT2DiaglxrTn1QBB5fi3N6cznLgJfv+SvNk6zy9yvNLu7b/T6TSssYWaCJnaE/ILE1sHLJyufu68EHblo/RaAPkURGCPQVrxiXXsDcs/MgUfHbjC/R4SR2Y+8F1H83MWSE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785834654; c=relaxed/simple;
	bh=D41cRLYBHnw6B9Y2G3XWqLyHU0FJj3zLnJbRklH5eKQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=as1xTWmyay8m9ebmwVhUOW4bdqZELGZaWpGiLWjztEqS1XuQ4WeCCG/syaBfrYaA99es5vs3iI5mcHk39wPrTW6Xmxwg40tWu8Mmqh8+WgsZNqX1Bv4LgN5q8pDswZsCYT/RX//b9FP2TcaOgyoqYr1NNkjv1FtKj13Dr9+iy9A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Vp+nIEWA; arc=pass smtp.client-ip=209.85.167.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Vp+nIEWA"
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-5b2b92065ffso4072338e87.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 04 Aug 2026 02:10:52 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785834650; cv=none;
        d=google.com; s=arc-20260327;
        b=N3peUmg1eqeT1cj+oMbPbBchUuGps+dGLxLfXYkYC5JFvITE/RueNeBh0j4RyeAxEq
         VaTJQ0nTxLJXogFb0OD1j1DmOPQfW4azCfeORFeha0h8BQEkj5PL1G12YsUlmTtrvaIJ
         aztxx9svFZ9VBRc1Oz/qyU1aDWyrptNx61NfTn9zfhRBepwbGiJSZbrq9giIHIzEUxW3
         3YxMyq9fV+n9++VVYSO/ZJGrp0aV286ESr7TP0qk4/ylRJ/lj7TH14Vv001Q2B836L+U
         JhSEL2FJ2fnuZ49HFII6HPPe4f1tav1rP0aV54Uz2NlWIN/iMrrhvnqzoO05H6zteOns
         bOmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=gKrRKD9mOOpHls+nK2VAtpKS46uprjKQsiDimCvh0MI=;
        fh=4D0KI2ZF0MTOhHfmLVbt/pU++M7cqStoyXE/xzLO6XY=;
        b=jLnMLUBd05u/1LpolS9MqVX3d/Dm+nrZwX2Z8+8nswfQVGvMPAjZeuU4nT2xbbQPC3
         tWZncSSorDCJODG+hl8LalxKOeimpDc7ghADE8lKhyoddk4vGqBWXZLA5oEJ+1Ehsyt1
         7cbxrcmoLIsIPq9RTBTDiIA01AGMEHt/oqVcs/uD/I907beN4G7IBSH/RKw8riynJZ85
         wsJuLiMNwLIzK9H8buiftlPEMyjqDzGjI6A5z7hsSLLTuEyqYQh07YXNfGnT80cjkpdm
         O/dXXD8+FXoyqGa/y4IVlyhAOseINon6r6T/ga+QKz6b+aIOsPZLsb6mMuabk+Dhf2C2
         xNxg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785834650; x=1786439450; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:to:subject:message-id:date
         :from:in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=gKrRKD9mOOpHls+nK2VAtpKS46uprjKQsiDimCvh0MI=;
        b=Vp+nIEWAjuSSDJ78/nykEhGDgYMC2WmkKmULAGI7u56claFMokHLwZ1XfRHTz2Zn78
         pFieB3TgT7vwEfvt+9Nc8X2r22U/x1/OUY2lGre92pHtyjdliJ87fSQ+cUyihZ6sGtHt
         KBtCHsfEnUgXDiIiX6utx4eQ4Py5ODqGm+aISvyicO3TcdhESRS75dfyVV02yR6A9jNV
         uw56SDCxAPZqUnKuf7ZolzDcS3B+XLEDcCtCtIL71A5l9IvEhKA6bJu94LEUISSABu/v
         ZyLt/b8JY1cTVgem/nDKzWDp8xdEIVXL98coMwbNLWrx/36EOOW2rRH4yCPgPxHkm84K
         2x7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785834650; x=1786439450;
        h=content-transfer-encoding:content-type:to:subject:message-id:date
         :from:in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=gKrRKD9mOOpHls+nK2VAtpKS46uprjKQsiDimCvh0MI=;
        b=Jdc314V2ZOw9Jr0bbsEMcZQousp26AbNRgvkEVKwE0SCP7IbNaRSmqbSSXIRTft8Vq
         RCCK5bPFj2NQ+q0oQrkwVHpMvlz9wnWDOlT4Arw6Qw64sZ4Ety9q4yqGY/uBJAShJhw4
         rjS/27Gu3PEVEMB/MDRQOA/ohki5odXn0rx09BhP118NS2ylp7kX3qKxakm8h6JLOCfY
         2wi/FgKsdLw5V7qx6p7Uq0bL5F37pp9SkWqOtjsjFo9Y34YmcLyHd01jgg6MotpU24EQ
         ahS9cFHjjTaoD+kVvgw8vnNEglrmcLx8MzDhjR7meendjxW9dQRIskeps3Ay7fSjgFLn
         G9Lw==
X-Forwarded-Encrypted: i=1; AHgh+Rr/N+8c/WPC87hwo3kzOnCv761puwRekxMRGiEn5uEEcKJdtcRWciyqBTV4o93vmLpPbkRcnTGQkTItSAhX@vger.kernel.org
X-Gm-Message-State: AOJu0YxjKODTT2i6iTnPJIZ/PzTwH06Exncoa80m05wcUivp36P7T+Ao
	qP4ONNCrLO0x1SMDZjKTlevCSoTGEzP5T9ay8NBSV9S2lLC4u3U/3zkLlBJFBrOicszW41TbqPb
	ebbs2W4baL5K8a0C8Pi0J2k2+7GuueJY=
X-Gm-Gg: AR+sD12/hTdJJnM4QJhqAnDIpob6jizDrt9eTDZlenjputcp85I9jRzCrMMJK0AVtFv
	ZtK/US+r1o3fYW+p+1wgna4RODV3xttInOtFbaaAVsB8yKFCA9t5qlQEMVytg9kos89jwV2aSXK
	LtOkdbcCihakuuYO2AxbVjWAY1efti4D35x20/gZzi+f1fgFWOOshEbSddaoFMnnkxzFB41VU2P
	v3O/pVcgDJNIbCRvTwk//JX/q2aWryq/JCld43WaQ84D5EMI/khutea4sWTXxakZ1U4JJ97ixvM
	MXTqDNQPxf+1ARwDiSI4suMJSBpctLk57L1bFxxLL6jv7h88wi4wRWY=
X-Received: by 2002:ac2:4307:0:b0:5b0:82d:e90e with SMTP id
 2adb3069b0e04-5b2e4f3405fmr1874406e87.19.1785834650023; Tue, 04 Aug 2026
 02:10:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260729110036.12129-1-linkinjeon@kernel.org> <CAPJSo4WUxiKcfjDkHuOVhqBmvHng7JdWX1dibsYFjW6qwTCUSw@mail.gmail.com>
 <CAKYAXd_oohSF2rLCns432OMACc6S-M7Hv8jCGtkD-rOd2QMYEQ@mail.gmail.com>
In-Reply-To: <CAKYAXd_oohSF2rLCns432OMACc6S-M7Hv8jCGtkD-rOd2QMYEQ@mail.gmail.com>
From: Sebastian Feld <sebastian.n.feld@gmail.com>
Date: Tue, 4 Aug 2026 11:10:12 +0200
X-Gm-Features: AUfX_mxs4J-zNjoQGvz1DTxT6nz7Z7O04WeQAWYbe-SYZyntetnQXDrEW-1S1So
Message-ID: <CAHnbEGJxN9mh7cGN7ycay63F75Z0+_G0fsHm9bgxHesacUrcSA@mail.gmail.com>
Subject: Re: [PATCH 1/1] ntfs: add ioctl support for named data streams
To: Namjae Jeon <linkinjeon@kernel.org>, ntfs@lists.linux.dev, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 4, 2026 at 2:01=E2=80=AFAM Namjae Jeon <linkinjeon@kernel.org> =
wrote:
>
> On Mon, Aug 3, 2026 at 6:10=E2=80=AFPM Lionel Cons <lionelcons1972@gmail.=
com> wrote:
> >
> > On Wed, 29 Jul 2026 at 13:00, Namjae Jeon <linkinjeon@kernel.org> wrote=
:
> > >
> > > Sebastian and Cedric requested NTFS driver support for an interface t=
hat
> > > WINE can use to access named data streams.
> > >
> > > NTFS supports multiple named $DATA attributes, commonly known as alte=
rnate
> > > data streams, but they are not directly accessible through the existi=
ng
> > > file operations. Add NTFS-specific ioctl commands to let userspace li=
st,
> > > read, write, and remove named data streams on an opened file.
> > >
> > > The new UAPI provides separate commands for each operation:
> > >
> > >   - NTFS_IOC_STREAM_READ
> > >   - NTFS_IOC_STREAM_WRITE
> > >   - NTFS_IOC_STREAM_REMOVE
> >
> > Wouldn't it be better to just provide an API to get a fd, relative to
> > a filename? Win32 named streams can be sparse, and it is common to
> > punch holes to deallocate sections of streams too. Streams do have
> > their own timestamps, too.
> I believe the current ioctl interface is the best fit for this
> support. It operates on an already-open base-file fd, avoids pathname
> ambiguity with :,

Nope, NFS already fixed this by allowing "unnamed" fd for deleted
files. Not having a name is OK. Win32 uses
"filename:streamname:$DATA", if any resolving is needed. That works,
because the Win32 API and NTFS forbit ':' within file and dir names.

> supports UTF-16 stream names, and does not require a
> new system call or VFS changes. If WINE requires hole punching for
> sparse streams, I can extend the ioctl interface to support it.

Wearing my hat as the one who has to do the WINE implementation side:
I think a fd with all normal file operations available is the better
option, because we need to do per stream: read(), write(), fsync(),
fdatasync(), sync_file_range(), file locking for each stream
separately, mmap(), getting/setting timestamps, futimes(), fstat(),
ftruncate(), lseek() SEEK_HOLE,SEEK_DATA, fallocate() for space
allocation/deallocation, unlink(), ... and likely more. Pretty much
every syscall, except mkdir(),mknod(),rmdir().

Sebi
--=20
Sebastian Feld - IT security consultant
