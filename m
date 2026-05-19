Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79A4A3BB13B
	for <linux-fsdevel@vger.kernel.org>; Tue, 19 May 2026 20:52:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779223929; cv=pass; b=cIh48kSSh4Mu7vgwvWqt0gtj1XworjxsMzwIcrwn4t1Jy1mNZtmPgTbdhjByk8nTRDiTxuKRf+Ex87ATxUHmw5dfalHreOSio3KhlePbF+D2zddfQ4VS1hTvsdSFWL/e/6pTUBfPHuXuYc/+AWe29L5HHi7ljrm5d4NUWGezikI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779223929; c=relaxed/simple;
	bh=yc0dQk+734JZ/guiyL5ZplibEbSlVTH5WIewmxvfM8A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IrpToKrwLBhusUvnKjxoiOc+a1cZAtJNPbF7LzEbMMGRw0qqCQdOjvz/dKOIkY2qcuCmloZTb74KcoXv50xr4J8eDRKoJnM/DJ/xNnkvNNH7QYsMyDAnF3HzeFd0Os1QVpkIUCFVFylEuTNvkjEJwyl8OxrxFTDu4UrQiZvPP10=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=amacapital.net; spf=pass smtp.mailfrom=amacapital.net; dkim=pass (2048-bit key) header.d=amacapital-net.20251104.gappssmtp.com header.i=@amacapital-net.20251104.gappssmtp.com header.b=Nwm8Bjdp; arc=pass smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=amacapital.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amacapital.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amacapital-net.20251104.gappssmtp.com header.i=@amacapital-net.20251104.gappssmtp.com header.b="Nwm8Bjdp"
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-5a995ab70d1so6221465e87.3
        for <linux-fsdevel@vger.kernel.org>; Tue, 19 May 2026 13:52:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779223926; cv=none;
        d=google.com; s=arc-20240605;
        b=j+t6MD+YHBp/JpDcfvHZEjRMXUVkh9dV8qEmEAbN1bM4dc5YY6dAA9N8NkhMkU+FQT
         KNGdOyOg3MiV7Ty3DCJTyGh1YcNRiwayF+L6wU1u81WzuRiP0hEU2lMt5UaI0WdYkOQI
         Z9W+0ayP0Zf0hdx/t64u4TI758vjq58ZrG3neTRaE7covgscfcoYWR8MUs3QWPMoXfNJ
         NAKqd8ZnxviaD4ktjo43mKfYIZkZDFlfQ9fluo8s4miIPHThNZu9Uim1LmXKh9El7Kxn
         78/waNqbKYSEC6qnmw3DJsvMKtXTXiKturXvNbbLkOdFDDtgX8P7Dxxg5fjDN7DZm6jo
         fJpg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=ij0xdcuLSgQ3aowYuDZpEYrT+iRvJ+RmX9eaZmmPv6w=;
        fh=+5LPRHxY2sAaJlCIXgo5c+fRnFZuKW8wL8Bp3SMVP44=;
        b=Cfcdh8uRYu15Xtd25pjFGVxdEj0k0mafbzZvL587tvt4vFu3Fh8cVudawwBqERQZ0b
         Vf2gkG1r2GYJ64fhYRL5Gd6hXGQrYCgyTLJgaFrM5Q3AxYDL2/l3BNml3c++GxP5I22r
         JZ1cdhZn5hrf3X6h6ZI+T0/9yh9lND6MsQwhbblKGS8HXJxk0Y6eABDCq7N+OXa0Pf28
         GKx62jHH/K0pLbaf4LimDIMB5cXbPXScZXmmGKzgC0bnX8ds9EgrttebzV6nrlkVfZUW
         v6+ijjEo5GbjY8qBNkKaHc/XhH4efi5/d8Xiji112prWdc2EcJcLJ5JGmPR53n+23Cbc
         fr+Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amacapital-net.20251104.gappssmtp.com; s=20251104; t=1779223926; x=1779828726; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ij0xdcuLSgQ3aowYuDZpEYrT+iRvJ+RmX9eaZmmPv6w=;
        b=Nwm8BjdpMzDHul6LS60KpJKBisL4tcUb/E1ynDBAMWt7sE493fnyYlS3HN3jSz+nX0
         f31CkVEzr4IGl+0D6BcROQxy1Msw/Q7jBhzEXiOWvpAE++W7SPOIYgg6ALtdI5fWAhfp
         NExzjKxc39kZvg51iOTH0tZi0RQbTQAJLH8M9RsqukFiyb/tx/rgc0TrfTvcXAZHXO31
         rCgMK2F5ceA3niOOxrKL4gWtLB0hB1Lfzfkvv5XXsjga9M67nmOHkySECMX889zbxyKE
         9Zfopof5CPfpR9H1GajFzmmetog/9KU7WqpNfYXkoaXWxmx7ddNyhxyR1DSUCnNhUG8U
         ILOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779223926; x=1779828726;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ij0xdcuLSgQ3aowYuDZpEYrT+iRvJ+RmX9eaZmmPv6w=;
        b=rSi0/1zb/VV3cTi/nSUljOXAmU/wQ2VwOqVb0+a8odlRJK7E5RA853UMQDBxS8KXu4
         N/2DhMniFUwMZK1CSUNG8RNpK14X7qbAe1iS9k0e/aGEQ+Cbq5TsULh08whuNC/+ImtQ
         HAgNC0eHVLiUHvd/7Zgjy1u59NuKgKIsjx17gu3Vguz4E0k8qwl9xsUoR123gYo3Lh/M
         YB68nd9PoH3RVwi6i0Uj79qWh9NQMAEW+eyd1iTYLKpnk23r5zPNbLnckjpd2D2VcyL+
         Hz59sw73BIWeCb7J+XHfs3gM0cbGKk8JTFuD6sQPfwWiZyQoaqyO9K3ouYqTeW0N1eKo
         WPdw==
X-Forwarded-Encrypted: i=1; AFNElJ81re3rX4O/DMqhAIbxh/JdPwzP+guSQNeBsGR+2gAvQ4YykhsYJJsO5AO0suCJhI14mQj+ngI20gjLGbjr@vger.kernel.org
X-Gm-Message-State: AOJu0YxOOtvuyN4vzQDbyDSEAp9HwUZcQnbRmcuc1f3B6ZJR4M1ZKyNS
	7VEYsshHqSFbmcmy5WwHmzJpRS6tgjFaXGVNf9vuo+TiyvnHfyVGryc4VLOIklhLwFbIEBBSD/D
	o79qWJ0bQjXbPb2LEACxq7J33DTageDdgp1tbycJm
X-Gm-Gg: Acq92OHqXlLvGMgPY21JSww7rEW90ftDRHxdWPNb5IQmJbXo5KsD9iiNUOqleWdXiFz
	1i5fxNFggCiH2CCE4Ua3jdONCZdXqNKPVjpAyaJgKPrW4xWRzikfVWLUTJjE6teglMCMaNWJTir
	NA0IkXZuy11sFhwN+jvVrDeR7i+V1Bads422seGVZvz/ts2dRxiyP3pg4HJQQnY5aAaJ1WGmOfZ
	5aE/ddPFvLCmd70KdXoV0mTzpQwJf6HlotKBH9uGtqhNiFI5MjQ3gHPb7DCbpLvN9CSlqgT8rUe
	Dg/JtKGxrYZPCAbc4y65it94Mw==
X-Received: by 2002:a05:6512:6d1:b0:5a8:52e0:7bc5 with SMTP id
 2adb3069b0e04-5aa0e7450cdmr6553274e87.27.1779223925489; Tue, 19 May 2026
 13:52:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <_fcorj7Aa0YnzUmrPnqdEbTjLqS6S7t84HKrzsswvKm71LC0uVmTD2cthCwpgeI-296unEpzPZYBNdFFDXjsQvZRtGfTaQlKmcRkiSI4wiQ=@proton.me>
 <agqevS--YYBVW2Oz@infradead.org> <20260518162048.GC9531@frogsfrogsfrogs>
 <CALCETrUFMFNnJ6FLd9SkzS5E1q3x+cqGvOvo5PzU2V_+moSEJw@mail.gmail.com> <20260519033126.GD9531@frogsfrogsfrogs>
In-Reply-To: <20260519033126.GD9531@frogsfrogsfrogs>
From: Andy Lutomirski <luto@amacapital.net>
Date: Tue, 19 May 2026 13:51:53 -0700
X-Gm-Features: AVHnY4K1ndQwPwy1fKsG8m_UaFGF1PGZ35IpcHSt6y2mDSPDMZHvPLuBjSgucKA
Message-ID: <CALCETrXWuMJstpkDhV4eKTwbRhQAQ0RZTkkFN=+oXrkiShgx1A@mail.gmail.com>
Subject: Re: [RFC] fs/ioctl.c: FIBMAP requires CAP_SYS_RAWIO while FIEMAP
 exposes identical data unprivileged
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: Christoph Hellwig <hch@infradead.org>, Cyber_black <Cyberblackk@proton.me>, 
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>, Mark Fasheh <mark@fasheh.com>, 
	"Theodore Ts'o" <tytso@mit.edu>, linux-api@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, May 18, 2026 at 8:31=E2=80=AFPM Darrick J. Wong <djwong@kernel.org>=
 wrote:
>
> On Mon, May 18, 2026 at 09:22:42AM -0700, Andy Lutomirski wrote:
> > On Mon, May 18, 2026 at 9:21=E2=80=AFAM Darrick J. Wong <djwong@kernel.=
org> wrote:
> > >
> > > On Sun, May 17, 2026 at 10:08:13PM -0700, Christoph Hellwig wrote:
> > > > On Fri, May 15, 2026 at 05:36:45PM +0000, Cyber_black wrote:
> > > > > Option B) Add a capability check to ioctl_fiemap() to match FIBMA=
P.
> > > > > This restores the intended restriction, at the cost of breaking
> > > > > unprivileged use of FIEMAP (e.g. filefrag, btrfs tools, e2freefra=
g).
> > > > > This option is a larger ABI impact and likely undesirable.
> > > > >
> > > > > The preferred fix is Option A, since FIEMAP has been available
> > > > > unprivileged since 2008 with no reported security issues, and rea=
d
> > > > > access to physical block layout is already implicitly available
> > > > > through open() permission on the file.
> > > >
> > > > No, FIEMAP really should not be available unprivileged.  So I think=
 B is
> > > > the right thing.  Can you send a proper patch with a proper signoff=
?
> > >
> > > For anyone who might be relying on FIEMAP output to find sparse regio=
ns
> > > -- don't.  FIEMAP is a lowlevel fs debugging interface; it won't tell
> > > you about dirty pagecache backed by unwritten disk space.  cp was bur=
ned
> > > by that a decade and a half ago.
> > >
> >
> > The only way that I'm personally aware of to determine whether ranges
> > in two files are reflinked to each other (and the only efficient way
> > to find identical blocks to, say, archive a large directory without
> > reading all the contents) is FIEMAP.  I wrote some code to do this
> > awhile back (not in production use).  Yes, I realize that it might
> > have issues with dirty page cache.
> >
> > Is there some other way to do this?  Could an API be added that
> > efficiently answers the actual question without revealing information
> > that shouldn't be revealed?
>
> Well, yes, we *could* make yet another ioctl, but we could also just run
> fe_physical through a one-way u64 hash function and set
> FIEMAP_EXTENT_UNKNOWN if (say) you don't have CAP_SYS_RAWIO or
> something.  Then your comparison function might still work... maybe?
>
> OTOH nobody really wants Linus roaring at them, so we might all just do
> absolutely nothing.
>
> Also note that FIEMAP still doesn't report devices, so you're still
> playing with fire on multi-device reflink-aware filesystems like XFS.
>

A hash would be fine for me.

But really a nicer interface would translate logical ranges in a file
to some range identifier, where:

- It would be consistent with page cache.  So holes are only reported
if the current logical contents is a hole.
- It would return reliably different identifiers for ranges that do
not have identical contents.
- It would usually return the same identifier for ranges that are
known to the FS to have identical contents.
- It would not return the same identifier for files on different
backing devices that just happen to be backed by the same offset
within their respective backing devices.
- It would not necessarily return values that are consistent across a
remount.  But maybe some kind of mount id would be around to at least
detect this happening.

Fun bonus points: if the range is dirty in page cache, tell me, and if
it's not dirty, then, on supporting filesystems, return a value that
will *change* if someone writes to the file and it get undirtied
again.  IOW it would be nice to be able to use this to efficiently
scan through a file and see what extents may have been modified since
the last scan.  But this would be complex.

I couldn't care less about the actual location of a file.

Anyway, this is a bit of a pie-in-the-sky thought.
