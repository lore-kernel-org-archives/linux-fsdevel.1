Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2120D392812
	for <linux-fsdevel@vger.kernel.org>; Fri,  5 Jun 2026 17:42:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780681330; cv=pass; b=cz4GPaURZ91/7DWIQaoQ9i5sTzT0785zB7IuGAeSNBH9V3hwYiOH7A2vIKYxbKYbk29wiXAvFhH+HtBAIscfIYmD1BhnkbZQLEj15ZOkT0I359jjmfGICdxIkUyGt73LuyPANTEz4XdoaSVlTyrEry5GmA3e2Qq9G+tXsf9qLss=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780681330; c=relaxed/simple;
	bh=dYuQLFZyw9MBV3K0UUurnj4coifzgZE7GVc2qkIpHXc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HZd+KSbw6kyp1uzGvS2TqyNdtbU0jF93k8Tf4McBgtAH8WdJkBcs4VHy6rtDPU3mzshL57WTxYq5t1r9U5p+rKIOFcOlKoqI9X26M9XtL0R/rC3RqvEGeG+eG1aYkOEEU/w77qC3m6hycpxXAj861SktTaZFIHUyizoXm7oxo+Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hwqar7y5; arc=pass smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hwqar7y5"
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-490b8ac62baso22606545e9.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 05 Jun 2026 10:42:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780681321; cv=none;
        d=google.com; s=arc-20240605;
        b=Nq19PoVRWiq5ZtOwfESr+1uSUkwIZpwJlXH2PsH/QcTMRrm+Wj1tcMRVvNkfjuA6Av
         BF5QJXnM0Gk5vgBh6QJiLfcNZxU/mYe+fG68CSygL1+90x9dopXBbo4NTUk86DuEQtgs
         oAeC07FQmPygaGXkePcwUYs7UH+Ld2c9UG+QQPaov0RqaWt0exHDX+42HBqVF3M4iF9Y
         kmbLQNJ3kRmQxPezXEtMsTLNdwnheGitsEeNOLKiXe7ZM6FB8ouZkI58XHvHIMGHo5Ln
         6rebdZtCXm8b+a0i44V76+xvTy6ZRHvYTU31ewCbzTTRWVXoWh9kF+wLzkJ6AjM6uCSV
         lHPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=QW39kiBGB3An2hVUf/UDc+UkyLppS9jaJRb32IsireU=;
        fh=x9AoV/FNUh8Las40cZIh8nfY8NO1XtYg1CEosDUz2Vw=;
        b=JwOcqk107TNhNu4LVzRHr4fQubmTGoN5AHf8vmlR5nPIdfsG4KEEYu9Jkk/y1C/liP
         +rB0tgJkG9xbgi7WORPuzjtMcMahrwmmgJS/kJKzo42n/yYhCO4ezndhwe2BbAJYXZ62
         4ZS4E1HZt3RuHzD2qOgPgGFNDcWJj/Ec7jGrLXtjugy/cEqrx7XtSS7pQ3PYyUlOUSc5
         qP5EdQVtUAmpqwR6QsQRAJwJFIoiBJkomQfZ2sU5CT6pHqobv+yj2CDtfr+ye5PjKxAe
         U5In+Bgh4DsEe7K5Ac+iAyk5nUZf1JUBpcULS1B2fj94ysY/1M4WFX/YnFRTY3HtVsXh
         EMNw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780681321; x=1781286121; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QW39kiBGB3An2hVUf/UDc+UkyLppS9jaJRb32IsireU=;
        b=hwqar7y5+MN3Jrt68sHwOABtjcbK9H+/rMDOhQ9mbPneztV6ERmb9nq1aZcK3G31mW
         hV4kerN1e4lCkcUOMELGQrGBEOOlR6+W8ntB1LnQgi8AUrQ4Vn7aiHEoU+JvS7npJ7t8
         yJ3QVqpww56scgroVo25l4qKiC2KkesqkTYb2Zr+5g+D1/Cz9C0X/XrpMeuUwChyFxm3
         hjqMIsgEIpl1y5oI7I4m7MMOVpVhEXao+sOXeaDN1l+CnidIJwCrzBwVikhI6141o2wC
         ABgOk31R0Cf4FqTSPu+Xs5CXexyGC7yjcipZmG2Bkg3ZLADg5X5sNvaD9tMz6dFd07JR
         FMKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780681321; x=1781286121;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=QW39kiBGB3An2hVUf/UDc+UkyLppS9jaJRb32IsireU=;
        b=s/BowmNHHsJaQyp+ixVhxTBz1DyWNs7f6KZl0CPTeqZSLT82mc6d59ZKH6TiCtuZuO
         kVL4WScDy/4a+GOOsmDnZui4Ixr1XF4WqPEzZRmbMXiZqS9f4bi1AtyOs+hYtT/nIHiw
         D9BVFyPd8GiCe3XX6HS/TNWbXDXdO11/0EEODapJW873Vhd4unQYo8CSNsfLgdwdQ2ME
         z+FK1qsMTdrmlXrndYKnSci5AUlnWbxHhyJKLJ1Dv8nFyID4UuO7pueKl8SkyH9fMOoB
         aAEe6yMaEdlvLj/HEPJdfldvCWIq+Zven2TuDigHvR0gZ41CRY4ySoKy3jVXxEGB+6Os
         ohVw==
X-Forwarded-Encrypted: i=1; AFNElJ/M+k0YsfTjjljyrTsJwA03pHLwC+rkjeoX5ugyUesIwgHG8DEQQTnjKGnNajeHOJ2QpYgzV1QG8x0TdLbt@vger.kernel.org
X-Gm-Message-State: AOJu0Yzdrbf19+hlqxRXwI28UeO2WJJlp/2IOBsUlMG0qRxDoCAsYr0h
	lrBQRuNLaHw00XAQ/CwKmHtvmZxCztfwVl6DQZSXk9LkEYcGYMJ+ZAPVF6/IPjAJTJRsT1GG+cP
	PvYGK+k5RzKtagDRXwV9cvG1cTQ/IW8ASJ4yE
X-Gm-Gg: Acq92OEzVK0BqjXj0YPBJ9d8lJ8sfxsBzWIxHqA6R5VbYmyPwx5JcvrLT+wzC1gdpLX
	k/uCwvuj3Alms9Qf+sgLB+SDJGsQcaeQvwrUMB1AB0E0EFjvPvITzU3zaEwW5uu9HYYXlpgu7YT
	Hb7mmejEmHNcF11eX4pw8AfNBMvm4KHefe2YmgXfZydNRh4NCqTfnwOoFoE5jvQJDyWuFkCnu3E
	5zLCnIRRTovHAe5zzn4G8/v4QB5roAWKpRp/1jgWI8EIc2Hkxhs9EL0hnHzJnR7ZaPIi60Zf0P4
	AvPTwGQahPV11vX62GSczOPG/Cs=
X-Received: by 2002:a05:600c:3b04:b0:490:af63:2cb1 with SMTP id
 5b1f17b1804b1-490c2cdd2bemr60415115e9.7.1780681321251; Fri, 05 Jun 2026
 10:42:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <177922946123.2439242.16666495969848656301.stgit@frogsfrogsfrogs>
 <177922946372.2439242.13829037107289830266.stgit@frogsfrogsfrogs>
 <CAJnrk1ZQbvCL=ok4WHBn0gC+=k88Cejts_-_DP3epa51Wz5+5g@mail.gmail.com> <20260605000134.GJ6070@frogsfrogsfrogs>
In-Reply-To: <20260605000134.GJ6070@frogsfrogsfrogs>
From: Joanne Koong <joannelkoong@gmail.com>
Date: Fri, 5 Jun 2026 10:41:48 -0700
X-Gm-Features: AVVi8CdkXR0MXAvVFry-1RgGSo7c735m9aAqhN8hZzwidZowcJTOmI28WGekW5I
Message-ID: <CAJnrk1Zig5+97Qs3JiaSgLE1KJMn-mgXSFUcxM9-kv6xvpfBHA@mail.gmail.com>
Subject: Re: [PATCH 9/9] fuse: set iomap backing device block size
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: miklos@szeredi.hu, linux-fsdevel@vger.kernel.org, neal@gompa.dev, 
	bernd@bsbernd.com, fuse-devel@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 4, 2026 at 5:01=E2=80=AFPM Darrick J. Wong <djwong@kernel.org> =
wrote:
>
> On Fri, May 22, 2026 at 06:06:15PM -0700, Joanne Koong wrote:
> > On Tue, May 19, 2026 at 3:33=E2=80=AFPM Darrick J. Wong <djwong@kernel.=
org> wrote:
> > >
> > > From: Darrick J. Wong <djwong@kernel.org>
> > >
> > > Add a new ioctl so that an unprivileged fuse server can set the block
> > > size of a bdev that's opened for iomap usage.
> >
> > If I'm understanding it correctly, doesn't the fs/iomap layer align
> > all i/o to the fuse file inode->i_blkbits and submits bios to the
> > underlying iomap->bdev without ever reading the bdev's
> > inode->i_blkbits? Why do we need this fuse ioctl then for setting the
> > block size of a bdev?
>
> It's not for the regular file IO, it's for the blockdev pagecache that
> sits in front of filesystem metadata IO.  Block devices do writeback of
> their pagecache in units of buffer heads, which is a problem if the
> buffer head size is not aligned to the fsblock size.
>
> Basically, imagine a 1k-fsblock filesystem with 4k pages.  Let us
> further assume that block 0 is a superblock, and block 1 is the only
> file data in the whole filesystem.
>
> If the BLKBSZGET size is also 4k, then dirtying the superblock now means
> that the bdev pagecache will think that the whole 4k is dirty, because
> there's only one bh for the whole 4k.
>
> Now let's say iomap writes to the sole file data block.  The ondisk data
> is newer than the bdev pagecache.  Next, the fuse server initiates
> writeout of the dirty bdev pagecache.  It writes the whole page out to
> disk, which means the ondisk super is newest, but the file data block
> has just been clobbered by stale bdev pagecache!
>
> Ouch.
>
> So if we can set the bh size to 1k, we avoid the clobbering.

Thanks for the explanation.

From what I remember, fuseblk servers can pass in a size at mount time
for what the kernel should use for filesystem inode i_blkbits size.
imo it seems like the responsibility of the fuse server to make sure
to pass in a value that matches the buffer head size of the block
device it's using, or does this not suffice for what you need?

Thanks,
Joanne

>
> > It seems like this ioctl is re-implementing the BLKBSZSET ioctl but
> > bypasses the cap sys admin privilege checking that the BLKBSZSET ioctl
> > requires, which seems like a security violation. Am I understanding
> > this correctly?
>
> It is, but the assumption was that you'd only get fuse-iomap if you
> already had CAP_SYS_RAWIO, so you have to have some privilege.  But I
> concede that RAWIO !=3D ADMIN.  This might be unnecessary now that fuse
> service containers can ask the mount helper to open a bdev in O_EXCL
> mode and set a particular blocksize.
>
> Though note the weird thing -- a sysadmin can use chmod to let
> unprivileged userspace to open a bdev and it can open it O_EXCL, but it
> can't set the block size unless they have CAP_SYS_ADMIN.
>
> --D
>
