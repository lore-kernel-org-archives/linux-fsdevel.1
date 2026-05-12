Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C30B3CC7CD
	for <linux-fsdevel@vger.kernel.org>; Tue, 12 May 2026 21:07:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778620062; cv=pass; b=ZFKVOjnCC7MglSx9umT9N0lNTtCSzdrrUu643D7gjCas2FNJelXYoZ9Zj6D4iKZzNzKY9w482LzQWVngvtEuNO8Xlb1zAadojSVTQjsWPWVj9iZmCTz8LeV6cwh4AwwYw7mvBst5zNrjJKg70RMW/MkIztdMfFpOgTnIiZTPeQg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778620062; c=relaxed/simple;
	bh=Np6WGxv9zWdDl93A8vQaAShlHx+p31/wJM4yu89+h8k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TunxPYbiTIet2wnlW24VOnk1yiQ5rQCKLzzNPs4IknLmKsg6k3oQaw4Kf+L4i6WbTWzes8/3LTzUf0MIj+41ClrjOppXvgRziQ/BnTANreM47NWzXBD+KdOLzS/fcorjYvy8fUtoISRYMrLTl9yvYLpnVIo/cR2W0oVxolk2AdQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NONogQv4; arc=pass smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NONogQv4"
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-67bc6098640so9627488a12.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 12 May 2026 14:07:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778620059; cv=none;
        d=google.com; s=arc-20240605;
        b=E/W16j/07ba1ldPqchX96p1HqSstuY4mzTjvdzUJm45AjhQiBWBGa4/2pTGC/4BFfU
         FfNY5+mRG55LxpreFgBj0TnEqFFgpbhUXVdIX1ukVoGmJIBA1/5ErXPR5ag6klrDoe/t
         dJiCAEwCZifNji6TLlZ+tqCs+Y/axCQTIIWRke59mTbLtwClGVpqSb7M53a8Hi4QaqMf
         DzZdAkW5UKoopCaGOiNBv0HKKFt2C0DJrP/lMqEgm40jj5Lp4tSAzY+TzhI/fAEasqu1
         QahUWzuuDHji7N4tzqV16XXf/7fqCrQcsBNT2BxzDxCXgKx/MO5hN3ICi1ecGOVbPKfY
         NL1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=2j2E+ZMhCPeb8oU2A+69RVueY5y8n7R8izOZ6b0UaH4=;
        fh=Gm3oPKL/T9R83GgQ6UGuvfAzlU2mOWWpz4/q/iT3vQg=;
        b=KcoZ/vmswGj+iMNZsdGk4xkphRRRoG81b6mFnIbWyg1PML/yblMCCkF6zfu+NFlGpA
         B1+T7rcC7dd423huPjXBpD/ZCPvyUtVFjJtG0mnOKZHHmBpT4DdABVAEh9l6+Xe8I5wY
         3MKbeBB/VczV0to8Tx7folP8Nog1DwwyQXV+T0gyP46zXNDaIuyhlt6RARR2zjMSUJXm
         dM7T3Lp5vEv53VLtmX3Eltsh1s34xhMRslCs9IHdfqQSz8heQ1PYu7i46AhuS0XcdRsg
         WWIKDTQE/a+E7YVlaF+H9WUFMKJa0g4z/DcaNnz7Tm+6dFoEJtUnM7KvzoK+4s1I5xLj
         NR5Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778620059; x=1779224859; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2j2E+ZMhCPeb8oU2A+69RVueY5y8n7R8izOZ6b0UaH4=;
        b=NONogQv4OKQnikIweLfT/WdzX67R/g8iGt1pobaMOtWjsROS3y8khVzpyVqj8L0cUP
         NghB/OgEwP0omvWcd+0t6V18MCzF/kbEIKn83HTcYgKxAtIUlCEAaDFvQGrcUUX02cNE
         WfNTWQGx2Esdc5AxNwPDV9TxhWtSuyVff9JqUHwwOYwGRx8OqVsxqvUcItr35on6H/DW
         q5qB+WgR92EAv7eUvMMh8ZcsWPmy/zz12NDwYZSL1nxLP9uNqwbQK5lpkeXOzWCT6xyR
         DsXnWQiW6OvvFRq3mxdcjr/nJ7lXb9hILby+i/p5jHq3DGeG0hjiohRnfOQGCP0Utykp
         fsXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778620059; x=1779224859;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=2j2E+ZMhCPeb8oU2A+69RVueY5y8n7R8izOZ6b0UaH4=;
        b=olVtATYJ+zMVGAD3kAruIqrOczmMogiy3w6/0yQ4xgSsBEDEnvoT2Yu5tLlk3XH94t
         6hy/2bRbRDQnOJ4iRxuqFLpji7Nq/vrX3n4WH9AEIBTjs9ZKA5blHOx0TV1rGk2MRyuW
         yB0C/D35olM64Ov8JQasFtIgVa1PFeyo9MRWO7K6GxkyQPizVThW+vaxgME+kcDZK2oN
         oMpcn2AKtbHoePouYDY7sVjHk01H76WXKFzFaw+Mn+Cc8RvfjCis1Wa5lHuDnJxta5AV
         +jvAP/XrrahDPni6wvqdrYRFp7bcY0bf8DMs1jFXyZ01r1VhavkqLsHdhn0wTl4QK4Sf
         le9A==
X-Forwarded-Encrypted: i=1; AFNElJ9oHfmfDnOIDsQI6zLdtJySYzxNIYIH+C6MQgI0eFqiqNxuqKt1teFaMxcn3CQsaaqEFW4YWn19WzTPvkaU@vger.kernel.org
X-Gm-Message-State: AOJu0Yz4yqtQJcFc9vGXzF2kXE8PaXTpMbef7wOXJBx4l42yL4hvRKOy
	bCGvoQOeo7Kw4pM2ezq/QJ/YWdD5gx2aFn+fq65mjAW2kXcrN9qfoRXcEbYVCSx/S7m1RXLfMHJ
	yDneIPqlXNzhcL6vXJlUpWgNElktRiy5ju3Z+mT0=
X-Gm-Gg: Acq92OHN9R2LU0Y7KP5EXBfQJzw1+8SQaE4i50q4EtwJAxPAcHxebcrNPzw4KxvlaJ3
	5fIchGRDsar73G+SfcKxWUEGO7gCsKFw62ZJKkA0Ys7OUg4JK6AIDTmA3HRtzRy26MNamrzBz0o
	AgdlHr2dp4SPYXxoViyOMJgJmBHcNhVcmGEXmWbMEi9+cYVCpPQjKbsdwU0N5X+iYxjb9+r7C4Z
	igV1+cE5df6lp8wV+Px/lIrETjtY7gM7Pf6Z/bKJ4TVmSOkwKCp+h9Vrc96gUr1j6AaK21UTjWB
	h26xgbwebCHCPjuqT6bT8+FmEj6I9/lc3jGe7JRwa/3/67JVu+U=
X-Received: by 2002:a05:6402:5356:10b0:67d:5c3d:8633 with SMTP id
 4fb4d7f45d1cf-68257521e4fmr179622a12.26.1778620058910; Tue, 12 May 2026
 14:07:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260429102058.1362965-1-mszeredi@redhat.com> <afxK2HSiwY32KaWw@fedora>
 <CAOQ4uxg-tgCmJkjFAQ86_xB7dDQKGy=geKAcxT2vB8cUSEKdPQ@mail.gmail.com>
 <CAJfpegt7hj=WDKKASjWLVG-R2tGYUKMJ1qR0iv_Y+GaYS0mW4w@mail.gmail.com>
 <CAOQ4uxgoavKU6zNMN9YF5cchvux6CGGxd56BBOJFWX0gkVAChg@mail.gmail.com> <89cb66a2-0f38-4b44-8897-50e932ef6153@bsbernd.com>
In-Reply-To: <89cb66a2-0f38-4b44-8897-50e932ef6153@bsbernd.com>
From: Amir Goldstein <amir73il@gmail.com>
Date: Tue, 12 May 2026 23:07:26 +0200
X-Gm-Features: AVHnY4KcyyZduQMJTkOOUAxNa4xug0XT0sTlBvMZ7FQIUF8pfK6I9OHQGDZVIm0
Message-ID: <CAOQ4uxj7tZ1gcfRDPTiwgGgDR8DBXpL++=go+AeMOFvUBEjLZA@mail.gmail.com>
Subject: Re: [PATCH] fuse: add fusex filesystem
To: Bernd Schubert <bernd@bsbernd.com>
Cc: Miklos Szeredi <miklos@szeredi.hu>, Miklos Szeredi <mszeredi@redhat.com>, fuse-devel@lists.linux.dev, 
	linux-fsdevel@vger.kernel.org, Horst Birthelmer <horst@birthelmer.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 12, 2026 at 3:46=E2=80=AFPM Bernd Schubert <bernd@bsbernd.com> =
wrote:
>
>
>
> On 5/12/26 15:08, Amir Goldstein wrote:
> > On Tue, May 12, 2026 at 10:18=E2=80=AFAM Miklos Szeredi <miklos@szeredi=
.hu> wrote:
> >>
> >>> I see no reason for fusex to not support lookup by ".", which is
> >>> anyway needed for "reconnect", so a fresh FUSEX_NFS_EXPORT opt-in
> >>> for "re-export to NFS" may make more sense.
> >>
> >> Why add reconnect?  If server supports persistent file handles, and
> >> all req's get the file handle, then no state (nodeid) needs to be
> >> stored by the server.
> >>
> >
> > Yes, we are saying the same thing.
> > What I am saying is that legacy fuse has FUSE_EXPORT_SUPPORT
> > which means server supports lookup of "." which libfuse always enabled
> > and then we added FUSE_NO_EXPORT_SUPPORT to opt-out of nfs export.
> >
> > I am saying that in FUSEX, lookup "." support is implied.
> > And that nfs export should always be opt-in (FUSEX_NFS_EXPORT).
>
> I'm confused here, why do we need lookup of "." without NFS export? And
> which file system actually supports lookup of "."?
> Shouldn't all that be scratched in favor of LOOKUP_HANDLE?

Yes. This is exactly what I meant by lookup "." support is implied.

AFAICT, libfuse sets CAP_EXPORT_SUPPORT unconditionally:

        fuse_set_feature_flag(conn, FUSE_CAP_EXPORT_SUPPORT);

ALL of the high level fuse fs are allowed to be exported by NFS,
which is often a very bad idea.

Thanks,
Amir.
