Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com [209.85.208.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D17D466AF7
	for <linux-fsdevel@vger.kernel.org>; Thu, 23 Jul 2026 13:53:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.178
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784814836; cv=pass; b=MoHIfsBLGpm9J1cw9TXj38YDokAh8WCpxkKtQJ/XyO+ozF8AcfAXfN8UDK93rRNPRd1hLsdO8VDGoEvpYQRGwfz0WnaGk6pNe6FaS22xlc0e1BQj6GDxxuW4E+1BXvnu3MEaZNjdfaBaxohnL+MXvu0QXXSLtsNk7CxNd9OQpJo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784814836; c=relaxed/simple;
	bh=+2YHD0LYLDY85VIis/zdXqssptfCZG80ADhJvUZVeOo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Jhqxz1kg0On0Q8TP3NpwQZ+aNJlPjogKONHbsR1147OVc5ymDrfwRg0yodRL+Nt0pfVZLQCmj2c0QidAeaXuAYEOn/D5Jun4gmopsqw5lZOOWvfct6ssyjJ+DnQhdOQScPflYyPwbg9ro7mCZ9C6tY0jxgEOHj1gruI5lXcKNew=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=amacapital.net; spf=pass smtp.mailfrom=amacapital.net; dkim=pass (2048-bit key) header.d=amacapital-net.20251104.gappssmtp.com header.i=@amacapital-net.20251104.gappssmtp.com header.b=TCOs5iNH; arc=pass smtp.client-ip=209.85.208.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=amacapital.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amacapital.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amacapital-net.20251104.gappssmtp.com header.i=@amacapital-net.20251104.gappssmtp.com header.b="TCOs5iNH"
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-39c62764c7cso4252871fa.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 23 Jul 2026 06:53:52 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784814830; cv=none;
        d=google.com; s=arc-20260327;
        b=FnzgPtb6TTD/69dQNAtdjb9LS3y6mL8vP21PZoAWIAJuqeDa4Hqk7i2ozOfxCu9CTY
         1D12HmJHFZ0WQFOjVblFCLIdDhpS4qXsl3c6wVGvSWgNlBrQJ/YI7PrvmPf/hFI5pc+1
         feqgeld6sEi4s6dREBWXTxppob63jUx51lS8PhOpGE7O1ZaRimHEjivNIQz/5i2DhnZz
         y/Tq2YNC+bB5WAhsGzKNGaC5611DLgOdMLVNWg3CbxznEahbPOJNFkfT5DExT537IRMj
         NnboZsqkpej8jY+xdMGLDFs11B7Ny9RzP9KDgivVv3C+Lv37g3D2lAC7EUUqvMhja0gs
         Aiiw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=/Qvp7W6WcD3MjP5gFX1gpVdJqvDJJ2Ad7xiF0QUVglM=;
        fh=pKK85JQm0bsuS+LFvgqch8FL2T2qToVjQjNtdNeDie8=;
        b=THbPOiaLxfmS+lfERP+mYwnPpneHjqrA5RPEQjGiPd4zMdDJT4X8Hon37GjW+0ewIi
         KjzVorjhkzNUTP3r9DHP0+sgNUANPgs9PIrpJzNdEEFf3m4daosvA3aRN9R4zgYwN3mE
         ikBTepjLbPRXCX5VTxiJPGSBEi9BxUKCQsGXkZjiZlDA2C04bHTAkASYTgXxxljFRPW0
         6o1hYi3TVx+ygK/US5s7n4t+qHyDg6vTdIQsuC3tIks6FIX+lF3H5awrdzSIXUF/8/OJ
         fgeEkzWNIVJm7ZQivS09gDLSbXzUvnbKX5Fv07TPOjPfqQE38KxHzhVFhGq1bo9XmDzC
         Erig==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amacapital-net.20251104.gappssmtp.com; s=20251104; t=1784814830; x=1785419630; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=/Qvp7W6WcD3MjP5gFX1gpVdJqvDJJ2Ad7xiF0QUVglM=;
        b=TCOs5iNHvbsl5X6Hfo62GvD27H13zYc3QJBzwYLSTICTXOBhF+lI6AkcUI2dFVsJXD
         g0aLU8WncvBsbZ62FIBlKUXFEO7Tu+S95BeppRX0MknJBoAQZQ3EwjArRLoPNqeaDypP
         9UwvodURNnpiXFe+1QTHM4jgX+8zxNyuCl/XE7AFiX7+VFHORmwYBps6ke0M/SuvlTYs
         bx5yPZU2am6Xoh0JYP4JqTaQIWPTfQOXgVtq/1WpN443Y28g6w32TJxwhfQLNjx3K6YP
         UGjcIy0Om5nIufS5anzRnOLL0rLP39PjNDn/093CvY21UINr6LQYaq/3YLQeeXZ78o8V
         DEmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784814830; x=1785419630;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=/Qvp7W6WcD3MjP5gFX1gpVdJqvDJJ2Ad7xiF0QUVglM=;
        b=qIyfl0wt4rUgq879qnWOb6ANWEZyzobQZOQWtWM8zZe30RIM0cZiylCIzI84NmYGoJ
         p3q7P6aE+2DK8ny9TXRYiltq3ZkYm5Y32w4MZ+ahzxQRDRoSSCpXINziPsbY7xzWPxAE
         BuCFc+Z8U64q/D7nrezoOu1ZJDKbq16HDgu15O3qsnCOfi8WqOnTassQytfac6fZoVCL
         ZuZ+Uo6TcBkOXtDHd1Qe6XCJZRRG//OOHm/nOQPsEHCKbxLTsjBjcOY0lyy+yufCkdZ0
         Uwf7kpkgYz6xB0ZejiqXW/urMSHCLGmxZ+tbZARK2RmHV0BW3jO2X1XbNb39F7ONjLbX
         XXAw==
X-Forwarded-Encrypted: i=1; AHgh+Rr6+FBEnpsNNt8M/HzT7CPn4OLnsuSVsWKvjwy7nYFdXOGhpaaYGe8ayufpYDB+VWGCzJCX5H9xV2alZtAZ@vger.kernel.org
X-Gm-Message-State: AOJu0Yy2XpiGEqH1SGSBQdd1hHZ/oDDNlAjlk5XW20QN7tjNtsNAXeVU
	dliCcnk6ETgNXviPeo28EyBS5ShKyONiUqbyf2ZIPTV8/SnS0YQjKItf8D/3nvUFlbxiF2xbBq3
	ese5e3F1+8hv6SG2eDUzzgdnasmBsBpDf7RSAGEid
X-Gm-Gg: AR+sD109kbr9e8wLCkTYOV9ycvH3RrZzO/K8ZaH+U2qeT7MSXh94mC0N+GbmrL/NSXt
	dWFIPqR5647sLfKNemPJFJUpPIPqamNBQ4AFRhiDYajJf7FV+DpNQVOJ+0q7Pmc0fpCs6dTv+9P
	isKkbUC39jI7D2xU25kmd8zhrISXwUNJpf9ps9coyzkQvJP3/CjjCyfY01x0jz5V9I0C/srVppH
	rO0LXm3UISkKac+FpNGPTF0GqJvQFCp15ZlzeahAzZHSGWMGf8DkRkc2mva9g==
X-Received: by 2002:a05:6512:ba9:b0:5ae:a9ed:35a6 with SMTP id
 2adb3069b0e04-5b2b33cde5emr603977e87.31.1784814830282; Thu, 23 Jul 2026
 06:53:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAJfpegupwNTaVNZtdQTmvtz9x=ehH59hzsRT7D0=VbhOZvaqrQ@mail.gmail.com>
 <6C96C8A7-345E-4388-8EDC-D94E9463D214@amacapital.net> <CAJfpegteZbnPkiTSAPWXDqZbf5eALK0E_npBLtLTmJyZaHXdyg@mail.gmail.com>
In-Reply-To: <CAJfpegteZbnPkiTSAPWXDqZbf5eALK0E_npBLtLTmJyZaHXdyg@mail.gmail.com>
From: Andy Lutomirski <luto@amacapital.net>
Date: Thu, 23 Jul 2026 06:53:38 -0700
X-Gm-Features: AUfX_mwpGfNjVX76f8of_9AJftpdKTQtdZGp4l8jZIXndq3Duzeb778fccyzEFg
Message-ID: <CALCETrWCf67TTiRSikTjgBZ+jKc_HPptEp9BvO2G=1-C5D2F_w@mail.gmail.com>
Subject: Re: [RFC PATCH] fs: allow opening overlayfs/erofs layers through O_ALT
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: Christian Brauner <brauner@kernel.org>, Miklos Szeredi <mszeredi@redhat.com>, 
	Giuseppe Scrivano <gscrivan@redhat.com>, linux-fsdevel@vger.kernel.org, 
	linux-unionfs@vger.kernel.org, linux-api@vger.kernel.org, 
	linux-erofs@lists.ozlabs.org, Amir Goldstein <amir73il@gmail.com>, 
	Xiang Gao <hsiangkao@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 23, 2026 at 2:19=E2=80=AFAM Miklos Szeredi <miklos@szeredi.hu> =
wrote:
>
> On Thu, 23 Jul 2026 at 11:01, Andy Lutomirski <luto@amacapital.net> wrote=
:
>
> > - O_XYZ flags to open() are all kinds of awful, for historical reasons =
that are not fundamental to the concept.
>
> I'm fine with limiting this to openat2().
>
> > - symlinks. If we have a new API where opening /proc/something/magic/bl=
ah can access something that ought to be inaccessible when accessed intenti=
onally and with privilege, a symlink pointing at /proc/something/=E2=80=A6 =
can cause the API to be used inadvertently.  Admittedly we have this proble=
m with basically all symlinks, so this isn=E2=80=99t exactly unique.
> >
> > - our nasty fs permission model. We gave a sort of gnarly mix of a bit =
of fd-based permission and mostly mode/ACL-based permissions for path trave=
rsal and opening, and mapping this nicely only new APIs (as opposed to actu=
al files and directories) can have unpleasant results.
>
> Pseudo filesystems don't usually do mode/acl based permission checks.
>  I don't see any issue with that.
>
> > Of course, I=E2=80=99m busy arguing (slowly and without a concrete prop=
osal) that we should have proper capability-like fds, and maybe that=E2=80=
=99s kind of an answer to this:
> >
> > What if we had an API to get an fd to the =E2=80=9Ccontrol filesystem=
=E2=80=9D for a superblock, like your O_ALT but as a real syscall or maybe =
only accessible via one of the newer and less janky open variants?  And wha=
t if the resulting fd and the filesystem tree it represented had a few prop=
erties that made it very different from normal directory fds:
> >
> > - You cannot mount anything on it or its subdirectories, nor can you op=
en_tree or otherwise mount it anywhere.  But you can open_tree the very spe=
cific things in it that point outside of the special API (e.g. the overlayf=
s layers).
>
> This patch provides exeactly those properties.
>
> > - Privilege is fully captured by the original call that gets you the fd=
.  current->cred is not checked when *using* it except to the extent that y=
ou might need privileges over your own namespaces to do operations that mig=
ht affect them.
>
> This is trivial to add to metafs: just store a ref to current->cred
> besides the path.

We have f_cred that might be good enough, although I'm not sure it
propagates through path lookup.

>
> Not sure how this security model would work, though.

If I have CAP_SYS_ADMIN and I open the metafs and then drop privilege,
then I would still be able to do all the metafs operations as if I had
CAP_SYS_ADMIN so long as I use the fd I opened to do those operations.

>
> >
> > - You can=E2=80=99t fchdir or (hypothetically) fchroot into it.  (Not s=
ure how important this is.)
>
> Not sure if there are internal mounts that have directories?  If not,
> we can just add a check to fchdir/chroot against mnt_ns being NULL.
>
> > - Maybe you can=E2=80=99t follow /proc/pid/fd/N links into it either?  =
Or maybe that would break CRIU too badly.
> >
> > The basic idea here is to try to treat it like an API that happens to u=
se the open machinery but not as part of the filesystem hierarchy.
>
> I'm not opposed to limiting this in various ways, though I don't
> really see the advantage.

I'll sleep on it.  Maybe it's all fine.
