Received: from mail-oa1-f44.google.com (mail-oa1-f44.google.com [209.85.160.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61C53391E60
	for <linux-fsdevel@vger.kernel.org>; Wed,  1 Jul 2026 18:42:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782931379; cv=pass; b=SbqDW8Xsb3LHLm07sFaFZY9KKwv8IZhne2+8P2PIi2Lt7tJ0tynGf5S2LZ5/h8zOmjralW9MftGxYJSA80ICgd/SRKDRkQKSOQpcQHAW/bQVb9zwq0zLWFWImNQoM9plgCJTzK8QtmOKOJdIhEd15sNNxMYfeoR7SipJ6ANsNj8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782931379; c=relaxed/simple;
	bh=dtn2YffXfDyR5hZVMmhNG75JP/ICDogzGJzK452Phz0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EePpDCRZjjo+skciO2XvZOarrFHtrnaGpE39fgfmphmSQ6wK7evcz38Pet41vbQHzs2IutkH+vBCZAQG6TLcGFYLLQxflXcmOX1r0CkZhUuG4HLaqzrpljjA73jAkKhwHLGk/bhdLp6GUlbU+W5PEbJkx8k4ZKQe1uggNjLFwRo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FDixXHgF; arc=pass smtp.client-ip=209.85.160.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FDixXHgF"
Received: by mail-oa1-f44.google.com with SMTP id 586e51a60fabf-44ae14b4fd6so458635fac.2
        for <linux-fsdevel@vger.kernel.org>; Wed, 01 Jul 2026 11:42:58 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782931377; cv=none;
        d=google.com; s=arc-20260327;
        b=WNpcPK80ORm/ibgh4lSmJ9PXIRDr12BDkQx/MRZEr8cIFbP0tkpl8TcKPPRL+fA3XD
         VZ0yozvqV6EItOuXAeNmuMig1JtSjpFoJf04HwvRYxdLs0I0oAwVqIt5mPt5MmnG49mP
         fsVprovioh3wwAXrGn/A2Fyu6R+YzElcc/0WPhT4Uv2x5U6K+fWXlRFhvyOrzlLPMlJc
         BNSDbn1sHdphU5yiXqXaT1YpPr+SKOIR1/1Ocu9N/WxKljt9QahqXLGvxg0IiyyCMLvV
         9vuLQwFwOiv88rZBFT5XlDH9TbagP0jQH1IbBpi8/70cayL0T+lkTg9Ydmr/cUkO8Jj7
         QIqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=YNo4H7B94p9nhYVyAQkHxg75frg7eF2HSh8OUMRCG+Y=;
        fh=3f05R44LPn5QtKTe5Ybn5txrPU91y8/U1XHlpy2T+1E=;
        b=dyzlJ4oT35SR580OHHo5qC+rwzo6d7N+Zk+F/yM1xMNwKVu77Z+VoyUmheJ7ph5B7K
         KD3bfg0I1Kd8w782c15qjprLLXEk5gBR3q4tL4j7wXcWu/h6bF2rrXrpLLithe/bcK0V
         n6dQv/YMyDChws63J7/SfS1GnfrhHV83vdXXryv5CSeuGHqoBlHGKuNPaQibCJXrb/mg
         tJL3IKjbEry7Ya/CcfixfTEclZcKK2q1POScHo7vKiyd9YLsT6D2FDpICz6D3VAKC/Cj
         rdUlp22dxNheRmfWQt6jx+O5y2pQRJIw1tfS2FiRLIneSqpixE62u1LFd7xCEadb4rwc
         Dtcg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782931377; x=1783536177; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YNo4H7B94p9nhYVyAQkHxg75frg7eF2HSh8OUMRCG+Y=;
        b=FDixXHgFs+cf2aHLypYYykq7tCxVtKhUWUOTr+Y3uScq1zjvYdaP7f9uw2UYsAxZuA
         m82cfb5UF3lzqmHz4qjIZvwpiplGLQV+Tqd7qEGpnY36GKhEJmdQ9zS5EwmYt+s9kZAx
         l5YKm7feJKZOammoSqOmVm93iaL0v2BBjNtlrz5VScGRNqf7sFOFBumOqxiXApKZo/Oi
         ANCNGFw27ekbvmLx9CbU8Uy81NsWWslz1/inKz/OEzdxUWDpF0oUD2O9hh0k5HTY6W+m
         SdwG1dhIq56uAVEBNT2g5d6bIBVeD+yvBT7KkunYVDugh4Aozu3kVf3DE1/4xjUNczPX
         JKOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782931377; x=1783536177;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=YNo4H7B94p9nhYVyAQkHxg75frg7eF2HSh8OUMRCG+Y=;
        b=c4pYL+W1Zv+De0C6z8ZM+l5Qn7mjMzzO4cOR31C1Okwgt9lndfiemv3p7uNFxu2B+A
         OF4i2aI0uJaPCraP7We5E6UvRE3RkchUDJpglCOmioxW2Z/jG/k1R2zw/DwVbaR/Eab7
         3J6zdr7/SGcmzlEqC/owXYcDxkwLK+W0PVgupOLUIyfq1LJ7BlZltw2Blw+79MTWbRiR
         GSzOhFKMhRyX6MF5F+okuESvtSENag7VNfY+TS97j1APRueRDiQ0uqgu3WHrsimXMi16
         YAF8k4GWz4f8f+ZMHW+azMpyOgckm2OcHzKsIi3yWbCFH2H0T5cDbkA/byGOaYvsEJND
         Op0Q==
X-Gm-Message-State: AOJu0Yw2I57CIwOSjPoidPumq6VbUF7gzTtlYYxGUKhJ9apH69k4aCJV
	coKwwl4A3IsCxpodQsNbOE+u1fGJfTfrYyhu/3LTEHCq4r0ucugYAu9nNlWwc5q0kVSmkAFqJXN
	Rhrh2qFyhNc7eH6Yzc2/AxbjUweYJK4I=
X-Gm-Gg: AfdE7clRJqjNpndMsmHlqZCAInC88o/ZQV+KGJmA/ymsc4Ok9aFc49FdRDsabibnCiD
	YCBT44YiBFGSAW67xHb4Z8hC33SAwusTKcqs4B9J/K8q9tXEzs1KI4LgrWlDl3D3+xfPIQJriDs
	nxcKb+6kzfPJtTuo04HLt3CMBlaUcj3khRwIotq9A2sZ84Y8rkhz0OTegfIjWn15MX5Bc6x418X
	uh/nVkxapVQ6sz0jNZgWwEKSP2m/2I0iNKFPdInMmfrDWzY3jgYdQm0Rz9jgXqR/DDW5uTe
X-Received: by 2002:a05:6808:1508:b0:491:3ade:8ba0 with SMTP id
 5614622812f47-4960ee01b26mr1888600b6e.16.1782931377482; Wed, 01 Jul 2026
 11:42:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1782619718.git.jbingham@gmail.com> <44e53f18f7bc7d190c2676e66a0b77a40a62d448.1782619718.git.jbingham@gmail.com>
 <20260701182146.GD6507@frogsfrogsfrogs>
In-Reply-To: <20260701182146.GD6507@frogsfrogsfrogs>
From: Jeremy Bingham <jbingham@gmail.com>
Date: Wed, 1 Jul 2026 11:42:45 -0700
X-Gm-Features: AVVi8Ccx7043s48-Csvz6w-YG14hk-GhZUaghEDj8Vlr68E5PdG8KlquygtL-G8
Message-ID: <CAMyBmMAFSXFcSt_KQNeVvfXRCbZ0twS60J5VLCVDsUfMHqce5g@mail.gmail.com>
Subject: Re: [PATCH v2 3/4] minix: convert file operations to iomap and add
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	brauner@kernel.org, jkoolstra@xs4all.nl, jack@suse.cz, hch@infradead.org, 
	viro@zeniv.linux.org.uk, syzkaller@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 1, 2026 at 11:21=E2=80=AFAM Darrick J. Wong <djwong@kernel.org>=
 wrote:
>
> On Sat, Jun 27, 2026 at 10:15:55PM -0700, Jeremy Bingham wrote:
> > Subject: [PATCH v2 3/4] minix: convert file operations to iomap and add
>
> ...add what?

Ugh, "add direct I/O". When I was preparing the second version of the patch=
es,
I screwed up.

> > Replace generic_file_read_iter and generic_file_write_iter with custom
> > minix_file_read_iter and minix_file_write_iter that dispatch to iomap
> > for both buffered and direct I/O.
> >
> > Buffered writes now go through iomap_file_buffered_write instead of
> > the aops write_begin/write_end path (which no longer exists for
> > regular files). Buffered reads still use generic_file_read_iter
> > for the non-DIO case.
> >
> > Direct I/O is implemented via iomap_dio_rw for both reads and writes.
> > minix_dio_read_iter takes a shared inode lock; minix_dio_write_iter
> > takes an exclusive lock, does generic_write_checks, and falls back
> > to buffered writes via iomap_file_buffered_write for the tail of a
> > DIO write that is not block-aligned. The minix_dio_write_end_io
> > callback updates i_size and marks the inode dirty.
> >
> > minix_file_open sets FMODE_CAN_ODIRECT so the VFS allows O_DIRECT
> > opens, and splice_write is added to the file operations.
>
> Ignore my question about FMODE_CAN_ODIRECT in the previous patch, then.

Noted.

> > +
> > +     if (ret >=3D 0 && iov_iter_count(from)) {
> > +             loff_t pos;
> > +             loff_t endbyte;
> > +             ssize_t status;
> > +
> > +             iocb->ki_flags &=3D ~IOCB_DIRECT;
>
> Why not set IOC_DSYNC here and let generic_write_sync do all the
> flushing work for you?  There's no requirement to dump the pagecache
> after a downgraded direct write, but if you want that, use
> IOCB_DONTCACHE.
>
> --D

*nod* I will also try this when I'm updating the minix patches.

Thank you again for your comments,

-j
