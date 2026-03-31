Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C3EE3C5555
	for <linux-fsdevel@vger.kernel.org>; Tue, 31 Mar 2026 11:36:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774956997; cv=pass; b=stNo7LeQon78nFvkDkmb4Q08NtkK5Ab+72kNrbBjgjQTfxk/vV00DOHlxtey4+AAYE/ouGnRT/AI3xR0spulWILSzzsOAQsMukBr0/Bn6pmfZPKtxtO/Q6MyjM2DAewNGQovOx6xV55HJj3a2Pc2pFh9PIOlQ6q74Dq3aOsKPQY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774956997; c=relaxed/simple;
	bh=2VX8+waO9fKghwPzqPeQFgjJ3307ZEy6ZMmjNnqfzv8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=plTtGX0duIR7j7PF+rNbsW839BcUujlCa4V4Wq4n05nIyX/ioT/7/jz+yRkV9FvaU6NRjearXqC+7ByPa6BdORS+5r9r9RIhGuYgd/BwcnWiCqIqp6JoqCpc8ZXHXS6k/xAouwAojyamUOwPFiXaHW64LQ7NUcSnIqNAWqm8JXk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=J05EiY6o; arc=pass smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J05EiY6o"
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-b9961e4f71bso819551466b.3
        for <linux-fsdevel@vger.kernel.org>; Tue, 31 Mar 2026 04:36:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774956995; cv=none;
        d=google.com; s=arc-20240605;
        b=FeZx0pXt4m3Cqugc+TRdzCpPlK8tK8kWE4Cef7h826jZ6VxoYujTPf5YMDvmAJ0j5i
         LI0cZLkq8NAdjR5Ecs7/mnx+xnVWMHMy+BEW/vvj1riEGtBZkjJh/DhQj7ELgnoe2tLh
         GvTmOiUv2VrDTm42evTlLvWMhg1seVLgJtsGu11CAdkwv5zlpFnIZiQHjO8fRLeI1vmz
         HlY1yzvTX876Y/I9Vz5IqHzkPPuFfrvmrfa1QajxcWcJBp1PY/J3uajXr/jX505j9K5n
         bgqDWrot27VXUuki7zpyR8zgkNoYoDOH7Se3rFuuow+ywUlPZTZZHC541/ZoOxuUEkSt
         0dOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=2VX8+waO9fKghwPzqPeQFgjJ3307ZEy6ZMmjNnqfzv8=;
        fh=GFfd788q44ja+erIejYc5Tio0pgiJlA8GNyNw8sKr5c=;
        b=CnuEjIiOxt2Kh5DMZD0/cUeBZAfPSo0UPll2du81kn2HS4SnXaWiOu+lvQOgpc9O2q
         rTicvb4VMprCPlegAhVP+H7OJBpc5Tr8d6Q3CnbM1XhmEEN8s9FvRH72vW9BgyyvUGZa
         wilNVPRyiJXal0U4idDQ59MUmYonIsU4+tv+kJau6FkQvLQmh4sHKA8obTQgXtklogy8
         UGHEz1B/yGgAx4gFdyXOLQb+zSAsgijP3bHeDnLVG4pm3MqMa+03hJjb4IfIVvDVeu8l
         voljy9y5piBzAUBahCLUg5HFiTrWqLuaNRg0K0N29auxnTCJSrWqg+S330tmFMkbiyEk
         LM+Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774956995; x=1775561795; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2VX8+waO9fKghwPzqPeQFgjJ3307ZEy6ZMmjNnqfzv8=;
        b=J05EiY6oHU/oamT4TJkR9iaDez1zlf+dDbjF2e2NZwJ57s9Xq/kqt6Z7ZFvq9W/k67
         6N37zfQ6+aL/PBEIiBQoDJ8k+PqzmvptC5CuHdX69f+Lu/guMeqkswY1uYl4bPRxTBNz
         Lf/5vboTb10lF2BgnD4Jal9OsApXIAbB8+FTUSw3qRB3hivsztGzzYsUiaUG/NyNVVta
         lXwko3KuDScROmojJn0upeyjCSpz3EwxnZAMQbmV0k9uHpsSIGAqZWpk+GhHGkl+uyWk
         +0uk1YS8sngWNVALmm6GVoNtZ6Hsy4wrvBTqz7KxMRDyQAsd7pC0AXf485B9XWQp5vXy
         jo5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774956995; x=1775561795;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=2VX8+waO9fKghwPzqPeQFgjJ3307ZEy6ZMmjNnqfzv8=;
        b=ZA9wT28g9Zrk0Bz8AsDSroG7EMWgKgPkBsEY1P00mR6Pb2WN4EMr4aXXMQfaQysxvl
         pWURxx+ZLyy5r0OMLM+bgULX1HRircAfzREf1eL2Lu7i1ZTp197QVUmnsAqlnLqHAGiU
         mG7v3oTdZJQIO9T1mN1zNH8PkO8+5POnMDa4c4GbwFGubwOQg2ZBBzlwpHP8Rh+p9AXc
         IciCu9NmfO2Towxlx4phzb5m+dQ8EIJuSTyck+BuT9Z3AmUZO7Nb+JOrFffyvgPx+U/7
         2y4qbUG+2/lL28Dv8UrWdl/F5Cft1GWSciYTs0RGyrCYmxlPOlKTF6EsqwVQeHLrykY4
         jVCg==
X-Forwarded-Encrypted: i=1; AJvYcCV8ZioBPzGL7A1IF6nXwP+sJSGiLOHtwPevZLSwFcAJfw1q22Pu4R6tMveti5jL153xttwafin0GcfgRn3J@vger.kernel.org
X-Gm-Message-State: AOJu0YznjsRDNgrJfwgxaneQc409dY4PmrKtDxAFd8t8iY7FpkMjEXDA
	qH05C65v66GTDwoVZEJwyChEjTfzL12VPckpB7mZpb54SNcMqGJdQMGlkLesI5d/jk5EWTwNMEh
	gi04vW2PYyETE3IT9uXu6bVKpjdgDhKU=
X-Gm-Gg: ATEYQzxBWuhrCvG8QhkDsJxqxxePZdJHq0r6wnkl6nHbRYeiJer1EqSi1SoZOwgjqsI
	nAMJq0MFG679aBrsARRSxDZizQoIQTqlSHgES2Wq9qm6sGNqeD/YbkzmioA2wEyCueMK1ObrMKl
	z1rq5sLc+6P9GeT3ZWok7vddw6TdGv076NpSFUfUyGrl1mbEt4hDJpJFOFTbUa4YnwGFtpBb434
	4CANEvlnWLDJfWourm03D0Q6D+hjbw5oA6e60TJ+Br+xbv8Tl41V9fvUWs9XZfp/N4bYcMn6nq6
	W/VQzCV94CKMD3t+obyrsmh6FtNDi3PQB68HEjI=
X-Received: by 2002:a17:907:c785:b0:b98:32c1:2496 with SMTP id
 a640c23a62f3a-b9b50358a91mr1165188966b.18.1774956994601; Tue, 31 Mar 2026
 04:36:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260329172002.3557801-1-mjguzik@gmail.com> <20260331-knebel-stilmittel-e384aae1d046@brauner>
In-Reply-To: <20260331-knebel-stilmittel-e384aae1d046@brauner>
From: Mateusz Guzik <mjguzik@gmail.com>
Date: Tue, 31 Mar 2026 13:36:22 +0200
X-Gm-Features: AQROBzCaxlHXqLPccAvwg-D6WW7_1dsaB5QSWo4oULw89sMgG0RBhlHzKVnQGaE
Message-ID: <CAGudoHHtn4oRvtrfL_M4mgQP6=51yteKDKFcUs8yG8_x0NUkZA@mail.gmail.com>
Subject: Re: [PATCH v3 0/7] assorted ->i_count changes + extension of lockless handling
To: Christian Brauner <brauner@kernel.org>
Cc: viro@zeniv.linux.org.uk, jack@suse.cz, linux-kernel@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 31, 2026 at 1:32=E2=80=AFPM Christian Brauner <brauner@kernel.o=
rg> wrote:
>
> On Sun, Mar 29, 2026 at 07:19:55PM +0200, Mateusz Guzik wrote:
> > The stock kernel support partial lockless in handling in that iput() ca=
n
> > decrement any value > 1. Any ref acquire however requires the spinlock.
> >
> > With this patchset ref acquires when the value was already at least 1
> > also become lockless. That is, only transitions 0->1 and 1->0 take the
> > lock.
> >
> > I verified when nfs calls into the hash taking the lock is typically
> > avoided. Similarly, btrfs likes to igrab() and avoids the lock.
> > However, I have to fully admit I did not perform any benchmarks. While
> > cleaning stuff up I noticed lockless operation is almost readily
> > available so I went for it.
> >
> > Clean-up wise, the icount_read_once() stuff lines up with inode_state_r=
ead_once().
> > The prefix is different but I opted to not change it due to igrab(), ih=
old() et al.
> >
> > There is a future-proofing change in iput_final(). I am not going to
> > strongly insist on it, but at the very least the problem needs to be
> > noted in a comment.
>
> Seems overall good to me aside from the bdev_file_open_by_dev() splat
> ofc.

The splat is fixed in v4
https://lore.kernel.org/linux-fsdevel/20260330122602.3659417-1-mjguzik@gmai=
l.com/T/#m93beb6028303f113d5d902120db834d54d52cf97
