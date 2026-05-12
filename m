Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8193356757
	for <linux-fsdevel@vger.kernel.org>; Tue, 12 May 2026 13:22:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778592164; cv=pass; b=kdvt4a8frLtDG339rEV2TQUwpss7th9A/U5Q9ujnS+lszjLrExwoQ3PXaic67iDX+5iyJD6ul/6wGsrrkaULOsjIBCll3McSL5BWqSetvES6BNMiYvHBxrFKVF2Or1AbSdV0Tbrk5Ax2us59EAe4qmfuKIJCBQ24CE2TiFQaRBE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778592164; c=relaxed/simple;
	bh=CmODMNUrJwva44S0HSVL80Zk81EoeNnwtT9hGsOQ208=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tnbEnj3OahgooY1zh2KueVAmhU0RbzJMPyB0lhBW+1rGAf/ImGhIcy9lwoOHcK7mym1mc/+PuyjNGAgv6HuvNG7Wa1lcUDsi30i6ye9mC2xEiW4oOPbAYEeXzXtPKBF95uXFc7Qc5xapIDPXI/B3yvu4P667IIfx4uBPRhhA3wE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UFFGVgQq; arc=pass smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UFFGVgQq"
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-67c4aaf76ecso8611745a12.3
        for <linux-fsdevel@vger.kernel.org>; Tue, 12 May 2026 06:22:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778592161; cv=none;
        d=google.com; s=arc-20240605;
        b=Utf5pJiOYGP7lYpL0DZuR2Lq9VJbfV/I2uwcQ6wd/9bm4BCIfE75qYNmxRCKhw76Xn
         BN07xpDl+5ZKb4/4zn2UlfDyNMIMC9mJend+iGPiOcjD3Zy0aGRNwUKI7mdCPPqQgCKS
         dIdK+RKyNYo6GabqLGTOdKCLy/rnV+xHz6VxX0DYTnhz7oSaLKD0k9+8GBMJpMc/benP
         uJjJ1SQ1Rc1+MCJGQomqLEgZPEReqNeZPFZWgfPpMVX7QR1oSwYef43tV8UXRfsB4aB2
         oBMhTZVdqE+DR99JGCXIGcV5pmdqmRiSQtGiB2+zi2aUE1C5Ed00zrX99vHs56pO1f0x
         ulyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=rx38VwJ9mLgM3NjUfqPkMzkkJTQ3yufriPs39QpBr2o=;
        fh=vkRVG0cyZxVnb0G87W6dbfcKv/sJttuHFZZj74CXLjs=;
        b=i7/xuXBnwJUF8xWk/rzVi8UqN+4g5u8DCKVaC82/ebMY61SWMWEokdZgOehdqhq5rj
         C9bZqytKH1h143zBHDhrtffPxgee6/jkCgp6RqpKNRX2rRQJvTszAkbjbQYP0aoNRV6e
         0wNBJtp8jy01b1LeJNHWViCLFukbKQ3m+ZIT+5rqn0PqzFl9uSxpodWcNlt+s5ww5DCT
         adxjF67S9r12tHwgafnHgK3AzFJHs3vrbr9W0RLjBKDQ/nD5gX+U2S/GbuIVUxCLUEMI
         goC31f0+z69gSSyRaj9fSSJJmYwINjrakkV+8j6oXqoaCbkAAXNkQVbaXDFPByh/QDxZ
         tY5Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778592161; x=1779196961; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rx38VwJ9mLgM3NjUfqPkMzkkJTQ3yufriPs39QpBr2o=;
        b=UFFGVgQqUCDj+YA5b0ZoMDcNd5ttUVd5Dxy7Er2sqxdUtRZUBDutQf3ruBVOI+BDnK
         difQN0w8ZkhhUQ9PUx548dWTDmxJXn2IYIZRFLH3bsDHvbk5BAG5cwwfjMPP6+jHKJ2T
         qAgovHa+L1+z872cjcdY4quNTkOYKBdLoZkCIBgGkmn1NPaC4ApYAJm6uB9rO3p8dbFp
         5lQ3j6/HWMuYtlfoyjvKuu1orrvO7vHWl/vRTiQFzN2kaeahTPE7vmLF28epk6+I8Sc2
         Zl0vEQGFm9tqmoUt4daMwMv0ikpeyZ1FBsNPBqjOyqE3Rtcz40SGzy3REWqIdcpWCXLt
         twCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778592161; x=1779196961;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=rx38VwJ9mLgM3NjUfqPkMzkkJTQ3yufriPs39QpBr2o=;
        b=SWlIBPYDP4jKsoRGnbFZhqWvwtI8y0w3nBsijddKjYL//eqj8RUpi73KnTJrvrX0IY
         PErzoUqhA6SVKbx7VbTpZjXrEwEmUOUKu88muyCqqHrf6kzavV82rSkvGCT5IbSqp6lV
         iQfCMya+1soXMOrdZGj0TnkJYlxpbNj4xuF0diYu1QGHaWmcMMrNKRc2sJz7PBoARdkc
         NlLmA4GqH7h0+WnGl8z84J+FSDWkNTOpuZKokZQc78bRM9rIFIikA/og3sXayjtZszZ1
         M14/w1C74QWnSt4aqzfkSIxH1pw2rhYfIaR6jn5VIDqLfqrI09WXWSQ8sXPSJv7IJlEk
         5IPw==
X-Forwarded-Encrypted: i=1; AFNElJ9Ai0L8f+AYPSihfhHYGz9e+ds4CTgg0935FFXhTq4YaIDNcbXEAnH219aOSo74CXOyR81HUrFF2Y82TJ1S@vger.kernel.org
X-Gm-Message-State: AOJu0Yw3sS9VYbzOVgUWRVyirRzxNXh1cZEty4CkxnjK0hrK4oopsTuB
	PS9EZxvYSmznS0xcv/e3ZYNZOI/DTWISnxvYfe8tjCded8tspQEJAM9W8tiQfaNTzMR2IoxShpi
	pem96s2Nm7lxAZXr1BnkH+ENYUH0ZTDv8a+qEuXs=
X-Gm-Gg: Acq92OEG7klFT+EJnQ3FS7gwq+Aw/wD8pyJMyLO6J2Qp7tnPnuC1TCZfPnKiO8GlVc+
	p49cm/ISO6AujoEpuCESHGt7WEjIKSUTDufZNIM1EX9tW/16pKSI3p/C+mvSvv2SNCXOoxOJELq
	nZzO2SteRatlBviF5SLnB5NVHh2/Gcp9P0v1SpKD07AVV/E0oUMMoC7nTwvRaHQpscE6A0ByKQY
	5kixdqW5+fAC+lVnzjrWwkSK+D9bT7daMLGSDgEjP1olA5tU8Yki3txocZM140FieDC5Hg772Q2
	BBwJ1OKl3+QkXdsAzMgO4MILIkoQMmjzU40XG9dz
X-Received: by 2002:a05:6402:29a:b0:674:b355:555e with SMTP id
 4fb4d7f45d1cf-67d643bfa26mr10574254a12.17.1778592161133; Tue, 12 May 2026
 06:22:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260429102058.1362965-1-mszeredi@redhat.com> <CAJnrk1Z_JWtuA3UjucF9=YH63AH_-J_0hzr9jbY99Hx3O8YrAw@mail.gmail.com>
 <CAJfpegspraqMp1Z3mi_csiw6haawZPa4zWheSUN7MhBy47aYKQ@mail.gmail.com>
In-Reply-To: <CAJfpegspraqMp1Z3mi_csiw6haawZPa4zWheSUN7MhBy47aYKQ@mail.gmail.com>
From: Amir Goldstein <amir73il@gmail.com>
Date: Tue, 12 May 2026 15:22:29 +0200
X-Gm-Features: AVHnY4IpLWVuGINjTtdIOiW6Q13XsruW-Wn7tJW0RAPYsusRW9h0550GyHT4zRw
Message-ID: <CAOQ4uxgV4_Pet0w3f+Sq4kLkvgKM6FyJwZ4AQsnvctC3w=dP6g@mail.gmail.com>
Subject: Re: [PATCH] fuse: add fusex filesystem
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: Joanne Koong <joannelkoong@gmail.com>, Miklos Szeredi <mszeredi@redhat.com>, 
	fuse-devel@lists.linux.dev, linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 12, 2026 at 11:31=E2=80=AFAM Miklos Szeredi <miklos@szeredi.hu>=
 wrote:
>
> > * in passthrough: backing_fd passed at lookup/creation time only (not
> > at open time), expanded struct fuse_backing_map
>
> Yes, this needs discussion.  Amir may have additional info on this.
>

Having the two different lifecycles (open-to-close, lookup-to-forget)
is by design.

This allows the server to potentially move files from passthrough mode
to caching mode and vice versa, as long as all fds are closed.

Adding inode passthrough ops does not play well with this mode
this is why it requires the lookup-to-forget lifecycle, but I see no reason
kill the open-to-close lifecycle as it seems useful for servers that
mostly care about I/O passthrough.

w.r.t expanded struct fuse_backing_map, at the moment it does not
sound right to me to map a backing id X with more than a single backing
file or device.

I think that the maps of fuse_file to multiple fuse_backing is better
handled by another layer of mapping (sort of a backing_mapper)
which is what famfs and iomap need, but it is just my initial thoughts.

 Joanne, if you are a concrete use case for that, let's try to see
how a design to this use case may look like.

Thanks,
Amir.
