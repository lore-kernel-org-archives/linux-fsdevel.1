Received: from mail-vs1-f50.google.com (mail-vs1-f50.google.com [209.85.217.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C11733B3BEF
	for <linux-fsdevel@vger.kernel.org>; Thu, 16 Apr 2026 11:59:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.217.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776340752; cv=pass; b=g63Ttkmf/fZSKpEV1FEd+U/VMzqgoRynF6vSNYSRzC/MzGLIJ/P5tMRnk+2ALtoUBSraEk0dxViQDIdwtsrT+zo5R4j/BWZV6QUXJlal6svkmYjZ3MjjFNu1QzJ+9smyS7jgcWiL2YBsqyRZMGt9f0TlaxVoa+5FBMJMqTCdI5s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776340752; c=relaxed/simple;
	bh=Bw7/eU46XNMmEAY5yaZoewjP327xtGOJwYlC+oEFeMA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=C4Qge5vc5wZCgGzv6gAmeXU0yIwoE+/eRs8/BDyNd6oETk+2T8jW9gmLCw6lH3n66UJajv0zTqUIwR4n1hBsuzoC1ViTGp3Upmmz3zQblFfsIihoFlvNDuRgJpTysFAKGIwal1sSddbjiqk70hW+b8l/dLbCx7ns4ZgQsejdGOc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Yv/iJipA; arc=pass smtp.client-ip=209.85.217.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Yv/iJipA"
Received: by mail-vs1-f50.google.com with SMTP id ada2fe7eead31-6058ac0ebceso5253838137.2
        for <linux-fsdevel@vger.kernel.org>; Thu, 16 Apr 2026 04:59:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776340749; cv=none;
        d=google.com; s=arc-20240605;
        b=VOqsVt0I3SgjTMYthohMSW000YKU8V3j6a4BcAVN3y3JcqHqLgX+KzmxtjvsYZKNbV
         dUCkh3xoRzjAMvERR+5L2K5XT7O9fDCnf6JdFQHLVMDKkctA3rdWrYDjhWVhYpkdZ5N2
         VvMJ11niuKfNPYT5QBD7wNIf492q1C7IcWU8Pr3m+fWzLvj8/NxD0yJhgqDXmEf6zAS4
         mXzqcRdyl/WNYGO3jf2h+0mwSVwzw76cLPNlUiIiWWSQu8DA4jLGSWbFIwhtG6d+KHvZ
         qihF+8F5OBqvbmk3q7VIwnQVnIHlY48FTe6y6HZ99BU5f9kSr0oKelFXqUivif8CLM6Q
         sHMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=JqYJ8R4iGWahwud4pP2JmsmCHvSHhoaPalUrCsDrudA=;
        fh=1X0BEDqGUwDUVKL30CyDUXDvdpr0nUxnTxnen1LWMVs=;
        b=A8eVzuJGONI5f5vH8PvLQFcBiNCMH6A9YNeAPDJxS9MBMiEvyKBrW6K0x917wp6kue
         jTB5gVZWjFJAH8KWySPVc6q45saYXLYjaDrpdoK+AGr8lS8qFm9KmczRXSSCtS0Bqbaz
         I56G0bdA5aTLI1ti2CFvmaFLcdco9XCgmRVNXpzGd2/vFahS1dqFifv2e3PQ4YzRSwV2
         9S80Ttc8EkqShtcnI3azM/+8VYoF6Od+8bAwNcrex/AN5h1XnqzThoV6AuEsU48moIDi
         aYw9KdUWnvPmHZro4b10g03y1l6YuDEyGdMjqTL/Glh0Y7apKrFfa5UDJBnBp9+wkyFG
         ergQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776340749; x=1776945549; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JqYJ8R4iGWahwud4pP2JmsmCHvSHhoaPalUrCsDrudA=;
        b=Yv/iJipAA+nhsL4hM00ueWwDagedY8BECDRzHx12spLwNgoS8ZakY4zrK2dkiR6l2J
         mQ3pEXXlrCi9kMRBkZi2YHE6qORxLcsWe+D8l+wjDn8HWOrCtWjKCgf5gVQmenh2NByp
         MCPNQ/tGjC/7AKKVlE3P3sIa6vn80p3d3lTSYo8ONK1oz6WoMzmPVNtYluTYxoNlq/gl
         23amyKa5o+u6+Qji1591D7SZNcgKyeEHjHsrOnz+jlamox/cVrUC1NkqUB4QzAKYFrCI
         XYiMktKmpNaISctvSp/Zchtq++MLrF/hVgPWAelzahh5Lq/eJ/sH7+6gxH0vD3vgUtNt
         7D/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776340749; x=1776945549;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=JqYJ8R4iGWahwud4pP2JmsmCHvSHhoaPalUrCsDrudA=;
        b=cvOPvlHr8KR2A/Kj3EILJ+cCTYGcQgzzhaTb0GvlSeJoDYrt0jc36EFOe5FE3LjRSW
         DXri1c7UjrEQwKLI4UNw05cLoS7gaTudxNYmwrG94ULrELC4Zabl9EKpDkq/BckF56yR
         Lv9hDLURPJ7fL08Uz69xYlGsmCpqzNT7z2o7yEpmx4PJQhV5X54bzM1Q4nLOPh2AwsDN
         yVEMj2ZQnY9Eb12IgXAwOunWYXXA/n0+VjgFeMkvHU3TzVt5QE8DTNgyM1QaFmPTX1m3
         gUR8JCZsmcuiOWq3amUa4On3elUxM9M37CuGZqYzZ6U35EReYBVvrKr6r0R95eIpAaGd
         Ih0Q==
X-Gm-Message-State: AOJu0YyGU+v6hcfn6L5IoYUcLkhMM8wBs2wCUcVx7tzHCpZMuIU8aT6V
	tJ5WoPBEWhgW7gjbVCtGoJ19jqoItoBlPDKgHxW96pT5MYojH5X1F5vEQDcWhF7peb+DYOKnNum
	9dIZPAOB7oZVlAVk/C+yDh82/qz4lbCg=
X-Gm-Gg: AeBDieuVgGrnnd1CgPKuxO5SzeNTBa5I8qMI+qEMme6Ah6ZvyLepBiz+uSXaDOuJbxt
	jfQ1ChZs8LNpfj5eoWSUeJm0Gs6IG4V6cMoCf9TRaarTdOvz2EUSo2GVMdH4jxedc0V77mAMcpI
	qHGsBMSR6Aw6DVyKkk397yNpFABIY2Z8A2U+E4mp7JAmNH23YjOYpocfexaQAg7bLcx8YTlDWK4
	wcF93lgmHqf9CAzWESjSYUFfosBJvt6pQzP3iHr887Futhws6qF4cW7wCzBm5l2iBIM1N/s77De
	9TMHjx5v4C6cynsMEc0gO4uj9Nyx/Pkl5X15j5sLtg==
X-Received: by 2002:a05:6102:6a94:b0:607:a3cb:4573 with SMTP id
 ada2fe7eead31-60a00c36c76mr12126981137.26.1776340748680; Thu, 16 Apr 2026
 04:59:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260328172314.45807-1-dorjoychy111@gmail.com>
 <20260328172314.45807-2-dorjoychy111@gmail.com> <2026-04-16-selfless-milky-wasps-shin-p6liRL@cyphar.com>
In-Reply-To: <2026-04-16-selfless-milky-wasps-shin-p6liRL@cyphar.com>
From: Dorjoy Chowdhury <dorjoychy111@gmail.com>
Date: Thu, 16 Apr 2026 17:58:57 +0600
X-Gm-Features: AQROBzAEjiDzwaGAEKhFLRhObmxO2qMMzryZZhbLCURVPls0DvUuWHW8g_k7mMU
Message-ID: <CAFfO_h5kWCYszymaY=tPAbpU=PjLFxsND+CWSYtypN4iuW+qPw@mail.gmail.com>
Subject: Re: [PATCH v6 1/4] openat2: new OPENAT2_REGULAR flag support
To: Aleksa Sarai <cyphar@cyphar.com>, jlayton@kernel.org
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-api@vger.kernel.org, ceph-devel@vger.kernel.org, gfs2@lists.linux.dev, 
	linux-nfs@vger.kernel.org, linux-cifs@vger.kernel.org, v9fs@lists.linux.dev, 
	linux-kselftest@vger.kernel.org, viro@zeniv.linux.org.uk, brauner@kernel.org, 
	jack@suse.cz, chuck.lever@oracle.com, alex.aring@gmail.com, arnd@arndb.de, 
	adilger@dilger.ca, mjguzik@gmail.com, smfrench@gmail.com, 
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

On Thu, Apr 16, 2026 at 5:41=E2=80=AFPM Aleksa Sarai <cyphar@cyphar.com> wr=
ote:
>
> On 2026-03-28, Dorjoy Chowdhury <dorjoychy111@gmail.com> wrote:
> > This flag indicates the path should be opened if it's a regular file.
> > This is useful to write secure programs that want to avoid being
> > tricked into opening device nodes with special semantics while thinking
> > they operate on regular files. This is a requested feature from the
> > uapi-group[1].
> >
> > A corresponding error code EFTYPE has been introduced. For example, if
> > openat2 is called on path /dev/null with OPENAT2_REGULAR in the flag
> > param, it will return -EFTYPE. EFTYPE is already used in BSD systems
> > like FreeBSD, macOS.
> >
> > When used in combination with O_CREAT, either the regular file is
> > created, or if the path already exists, it is opened if it's a regular
> > file. Otherwise, -EFTYPE is returned.
> >
> > When OPENAT2_REGULAR is combined with O_DIRECTORY, -EINVAL is returned
> > as it doesn't make sense to open a path that is both a directory and a
> > regular file.
> >
> > [1]: https://uapi-group.org/kernel-features/#ability-to-only-open-regul=
ar-files
> >
> > Signed-off-by: Dorjoy Chowdhury <dorjoychy111@gmail.com>
> > ---
>
> Aside from the nit below, feel free to take a
>
> Reviewed-by: Aleksa Sarai <aleksa@amutable.com>
>

Thanks for reviewing!

> > diff --git a/fs/open.c b/fs/open.c
> > index 681d405bc61e..a6f445f72181 100644
> > --- a/fs/open.c
> > +++ b/fs/open.c
> > @@ -960,7 +960,7 @@ static int do_dentry_open(struct file *f,
> >       if (f->f_mapping->a_ops && f->f_mapping->a_ops->direct_IO)
> >               f->f_mode |=3D FMODE_CAN_ODIRECT;
> >
> > -     f->f_flags &=3D ~(O_CREAT | O_EXCL | O_NOCTTY | O_TRUNC);
> > +     f->f_flags &=3D ~(O_CREAT | O_EXCL | O_NOCTTY | O_TRUNC | OPENAT2=
_REGULAR);
>
> It's not clear to me why you dropped this, I didn't see a review
> mentioning it either. (General note: Ideally the cover letter changelog
> would mention who suggested a change in brackets after the changelog
> line so it's easier to track where a change might've come from.)
>

Thanks for the general note. I will keep that in mind.

The review was from Jeff Layton in v5
https://lore.kernel.org/linux-fsdevel/5fcc2a6e6d92dae0601c6b3b8faa8b2f83981=
afb.camel@kernel.org/
" 1. OPENAT2_REGULAR leaks into f_flags - do_dentry_open() strips
open-time-only flags (O_CREAT|O_EXCL|O_NOCTTY|O_TRUNC)
  but does not strip OPENAT2_REGULAR. When a regular file is
successfully opened via openat2() with this flag, the bit
  persists in file->f_flags and will be returned by fcntl(fd, F_GETFL)."

I think it makes sense to strip off as OPENAT2_REGULAR is an open time
only flag (like O_CREAT and the others already), right?

Regards,
Dorjoy
