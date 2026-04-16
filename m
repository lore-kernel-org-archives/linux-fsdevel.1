Received: from mail-vs1-f44.google.com (mail-vs1-f44.google.com [209.85.217.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4188237BE8F
	for <linux-fsdevel@vger.kernel.org>; Thu, 16 Apr 2026 15:22:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.217.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776352938; cv=pass; b=IyLNn7xvK8n1dGv7D7JMC4IWjIP2xkO6WFweLsKmK5fKDHCZofULhLX0nh3lJ5MJ/TwffYOwtpHTqsjtjQVr864cQxXA/kivA7hYsDMcnuw/WOvzz6XfMYw/faY5njdi1S+5urTFTOEtDD82Uz/+U0aYJ9a1lB+wrGWH+RpreGM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776352938; c=relaxed/simple;
	bh=d8h0wpCxAz5qr8QgJAWyo5NPmRw20h5MEF24J15IyVI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=f12LLy1STf3YSFfPGUlqVVC8Zh3IoDU63NaQSdoCdAwuA4RfApuXN46Syg2mC0g0eoEzuE9Wj7SLO/N+k/HWeVhvSlVz9Is5PGQnJtF+TRcogY6cPYJ5AjDyguRn/r5gJ05R3Ll+6Q7utDC1i7j+M9vbzZ7HqNSW9k7sZTbzadI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=g4lVbpH3; arc=pass smtp.client-ip=209.85.217.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g4lVbpH3"
Received: by mail-vs1-f44.google.com with SMTP id ada2fe7eead31-605def5b80cso2608216137.2
        for <linux-fsdevel@vger.kernel.org>; Thu, 16 Apr 2026 08:22:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776352935; cv=none;
        d=google.com; s=arc-20240605;
        b=ckUQxifrXsQjyxwIU2LOK0rXj/ot01XV3yhN3yLg9yWpfpR8E9BA24nlIMq0LzuNcS
         uAj0N9/7ln7GFANq1z9BLR+V31eyqEvA/B8LMvU8nYs1rJRxkSSHJbzDAaVbfll+jb5O
         u7GRJeVpM2LLV6nGEjSoHxu09cH0RzixydjbOktbShr8HHLHCWyrKJ1JZAi8XBed5P5E
         0V6rT0QYDpMpvORPeRnfIRzrZ79qV9poVyY2gX6w3M0vZi8uTKueipwLCIHIdR3WeeGt
         h/Ki0SCSOFqKKDerXUSNgKV1YCXXh7MNbcTIyCw6denx58YnR3/vqG9iJwB5eB5Bq7n+
         6agg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=ZrzbbPcScOB3YiJODipm6pYCq1GabErqB6lK+E1UuOI=;
        fh=16QCpnoWFQJydsl7MQ6PjFeapC9IrJm5Fc4/0icnWKw=;
        b=h6U+oPS1hIrwbBIJ8tCvvwxCs3zsQCR40ZqO8zamWxPkK8aBSLGDVUS+LL3niUnCUS
         eLkZZYH+XYD/X/J5yPYkKVoIOaJdCXMmWhkSG6Dc76saw2GQ1ZuxqSI1pkFEW+4lO/1D
         N0mpVAt/Kr0PFAJFa4h1tNalohctStFGUPU6l5CupbARSyhzdHZgf7aeyUPM2jEKxnmQ
         3ydW4Gz0pTRQyuAUKkfs/SYssRRAVNEcYTt5AIL/VwtFbz1dp7ScpmKP3W1aato9Nckt
         PKtFeFTwehaeu8NkDCGyJ3P/zZvj23KKgkKHAh7v0th/iot9fna1NvNjjCxMc3psXrIu
         nXJw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776352935; x=1776957735; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZrzbbPcScOB3YiJODipm6pYCq1GabErqB6lK+E1UuOI=;
        b=g4lVbpH3NYuTwHK4zof4cI1R5F3IIOc7rqMOk/MWHpRmevLzRVb+qRlTlkjItjBIHx
         c7M0jhqWfaQ2vMdmdCGZvAPwF+odTZ9kyd6p7sv+kuJPT06vFRz8sGzxEE+RDZyrNUPi
         T43wkAslMCjJ0svGA08kUb5Gbx/3985K1GhQDZgh/+pTKuxWXmHDa0LxQ7N8Y6D+AdMV
         pK9JcsBfafPuXYE4xQ1M0Bsj7zmPTRKj8Oqs1QY2itp7CaL3brWr7nECH3oyQEx2Fb50
         mvvGzjXFjjCeXabKEm078u3WnFCD8fkfLKek/kSJSKQGUKyNJa4mEQC63tdpwccNytZ5
         6URQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776352935; x=1776957735;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ZrzbbPcScOB3YiJODipm6pYCq1GabErqB6lK+E1UuOI=;
        b=FhkDJHecMOF9DPZ1wgudW2n0K5TWEiskxs42whSc2svV8U4Pt+epqoLLY5IS7R9OIW
         P0ERtUw+R3peKoY0VMJqkefhbNdUnq3ddadGaZK/FMAh1bZdR8JKq7QNKfrJ5KG6tOTG
         31CQiPdm6tF7xTHE0jGTw+gS8F/PRbrG3IsoAPNjFZnwcuWvux6eU9l27B8c/CLqIVeF
         tYGHXHQ56tigu/ytY85s2SnB3uFk8Y+fdB3XKLu9PimJ5LTL0a/eETafyhU35x+khJ94
         q74QQxgn3O8udRxIuN+nX0J9cYYneFmwTiQfW8Z4yaeMWvgzx8ACqMmg1AubGHOmVV52
         cQOg==
X-Gm-Message-State: AOJu0YxSEwJTvrDHAEzmTmqdi9H+SBU+vXM8MmxHGFaWNtMkbb2sNWAi
	CihjR5zvl7n7W8JaaIJLDjJqWsH7eQ3CfHSKBMONnpDafbqkjfqo21SfujrP6rOpAGI235d47Ac
	QhJvoNj1O1W8yIYpNmEgneSrGmyO5+5U=
X-Gm-Gg: AeBDieuv2B0Ubva5LiOo8kwZi9IIqshCVG6L22h3e7mPVUt0iuIXu9JZXOr355H5+y8
	J5n+dC3K4XbySUw3N525uPSJrWwt+LgVWiuJL+dyiWCUIoKIfoMg8qLsu0m4vN14yR5QPBMWkkR
	uyzExnWMuQ9idAvwJNTq2CQADXmhgoTgxe41AK1k8vSm6waoeVLv30Fte3f01Vx/pMwigjMbR1p
	Okst7TFnIvD+dBwiJDw/mqKmwQCJYbfUYRXaN3WiVnFe/Xp22+qOB81erCkyounTWLWfCyLp2Pt
	fFmscjuWCX2r/HGIFLIjcsXI38VFg6t72JNKXiUdcg==
X-Received: by 2002:a05:6102:4194:b0:610:48e8:8c4a with SMTP id
 ada2fe7eead31-61048e896d0mr7561251137.24.1776352934841; Thu, 16 Apr 2026
 08:22:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260328172314.45807-1-dorjoychy111@gmail.com> <20260416-abgraben-seeweg-a44ce660957f@brauner>
In-Reply-To: <20260416-abgraben-seeweg-a44ce660957f@brauner>
From: Dorjoy Chowdhury <dorjoychy111@gmail.com>
Date: Thu, 16 Apr 2026 21:22:03 +0600
X-Gm-Features: AQROBzDwlhonUu0OdB2GZDkt71Qp2GPutRABZHn8dYTEqH0ntcAPsZO_it5641c
Message-ID: <CAFfO_h5mORm0OuK-d4thzBWWySmyvLSVeVa7phZc4Df-8D=1Cg@mail.gmail.com>
Subject: Re: [PATCH v6 0/4] OPENAT2_REGULAR flag support for openat2
To: Christian Brauner <brauner@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-api@vger.kernel.org, ceph-devel@vger.kernel.org, gfs2@lists.linux.dev, 
	linux-nfs@vger.kernel.org, linux-cifs@vger.kernel.org, v9fs@lists.linux.dev, 
	linux-kselftest@vger.kernel.org, viro@zeniv.linux.org.uk, jack@suse.cz, 
	jlayton@kernel.org, chuck.lever@oracle.com, alex.aring@gmail.com, 
	arnd@arndb.de, adilger@dilger.ca, mjguzik@gmail.com, smfrench@gmail.com, 
	richard.henderson@linaro.org, mattst88@gmail.com, linmag7@gmail.com, 
	tsbogend@alpha.franken.de, James.Bottomley@hansenpartnership.com, 
	deller@gmx.de, davem@davemloft.net, andreas@gaisler.com, idryomov@gmail.com, 
	amarkuze@redhat.com, slava@dubeyko.com, agruenba@redhat.com, 
	trondmy@kernel.org, anna@kernel.org, sfrench@samba.org, pc@manguebit.org, 
	ronniesahlberg@gmail.com, sprasad@microsoft.com, tom@talpey.com, 
	bharathsm@microsoft.com, shuah@kernel.org, miklos@szeredi.hu, 
	hansg@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 16, 2026 at 7:07=E2=80=AFPM Christian Brauner <brauner@kernel.o=
rg> wrote:
>
> On Sat, 28 Mar 2026 23:22:21 +0600, Dorjoy Chowdhury wrote:
> > I came upon this "Ability to only open regular files" uapi feature sugg=
estion
> > from https://uapi-group.org/kernel-features/#ability-to-only-open-regul=
ar-files
> > and thought it would be something I could do as a first patch and get t=
o
> > know the kernel code a bit better.
> >
> > The following filesystems have been tested by building and booting the =
kernel
> > x86 bzImage in a Fedora 43 VM in QEMU. I have tested with OPENAT2_REGUL=
AR that
> > regular files can be successfully opened and non-regular files (directo=
ry, fifo etc)
> > return -EFTYPE.
> > - btrfs
> > - NFS (loopback)
> > - SMB (loopback)
> >
> > [...]
>
> - I've added an explanation why OPENAT2_REGULAR is only needed for some
>   ->atomic_open() implementers but not others. What I don't like is that
>   we need all that custom handling in there but it's managable.
>
> - I dropped the topmost style conversions. They really don't belong
>   there and if we switch to something better we should use (1 << <nr>).
>
> - I split the EFTYPE errno introduction into a separate patch.
>
> ---

Thanks for fixing up and picking this one up!

>
> Applied to the vfs-7.2.openat.regular branch of the vfs/vfs.git tree.
> Patches in the vfs-7.2.openat.regular branch should appear in linux-next =
soon.
>

I don't see a vfs-7.2.openat.regular branch in vfs/vfs.git tree in
git.kernel.org.  Maybe this hasn't been pushed yet?

> Please report any outstanding bugs that were missed during review in a
> new review to the original patch series allowing us to drop it.
>
> It's encouraged to provide Acked-bys and Reviewed-bys even though the
> patch has now been applied. If possible patch trailers will be updated.
>
> Note that commit hashes shown below are subject to change due to rebase,
> trailer updates or similar. If in doubt, please check the listed branch.
>
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git
> branch: master
>

I guess you wanted to mean vfs-7.2.openat.regular here?

Regards,
Dorjoy
