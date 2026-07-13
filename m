Received: from mail-oi1-f179.google.com (mail-oi1-f179.google.com [209.85.167.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D96F2745E
	for <linux-fsdevel@vger.kernel.org>; Mon, 13 Jul 2026 19:18:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.179
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783970288; cv=pass; b=QSwJK81FuYO5OZI1UVZRqnZF/MMR9Kiiy0InUnD+Nuxs/DWbWkWIlTSH35GaOdQLtS//aZ+poQSejhjafXhAD2uH5wn8N1Ve8bDzuT5vyyIvAt7XF2TzeeUePhJvB0ajflDPUpYiIaihUHCD3aVQSpCG/Pd8ME6dvDUdNVHcdjI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783970288; c=relaxed/simple;
	bh=nd/GbPVhPSqumv/w2cTpkFqLXvGQD8OrGAndVtih/DE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YzE/Aj8GQosSkf7kKbStoWEEF7cgGpIevmrH+GXhA1DxNn3+wwnoNZP8NePH3xKBHTgYQVhIY8+pa790iKXolIdRO6tx2u9YW0EOFr+xjHFoZMVrNnSPdqG7reLi+ruaz8jnCXn6wGv3OmmDllxK1eLpk7sUULqQTMTj4TZMqeE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=rS0Ad2Bj; arc=pass smtp.client-ip=209.85.167.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rS0Ad2Bj"
Received: by mail-oi1-f179.google.com with SMTP id 5614622812f47-492046a3313so166180b6e.2
        for <linux-fsdevel@vger.kernel.org>; Mon, 13 Jul 2026 12:18:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783970286; cv=none;
        d=google.com; s=arc-20260327;
        b=rICJR6ZXWFfOyMutsr1r9pnz+BTU0nHeYbXUrzf7f2llvjP7SHJW2UQNmmdGOG0VW+
         3M/ZXc0p54fp3JAy13zlTV9I7nMRPRVktrD1pS3iz8o/DaAloaTIrfoodYoa/ozRdVlZ
         h2hYWv5ad/4vTA1ykHDxUQEClL31DLAVzoieEwvIg+Wgc+/ivbLS99nx5ApDtJMHmYaM
         qPv0H67rpiFykpdPehQek/tRKhQhXTZX6NoQ2aOZlPW66jmicUSV8vHpNEj8O07CrvcX
         Ziu5ISVBw4MNr5x1QCW95a1QQSFG67+X6+ygbTV6Zs+tTROTkHz0b3A90Kxn1Ncm4QIu
         ObjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=g7oXzbKR+Nla7biREoU4+S80J1Fmi0WpZ2OpnGwsyN8=;
        fh=yOiudSuk+B/rR47n2F7nA/XPr/J7mTeztq57UTMxu4Y=;
        b=aUVATSSWWx9lXUNcvurCnR8G0t1R/3Po0sWjb2KqnQ3XdNL8bmRt+4yrCYuoD8d4rn
         pUdyTa3Xtr1vrHdfXWVS8fK54qqo0ek5YIqpZV7l0Ja/cGGNq3CjhupxjA5xgnbOhuQY
         fcfe/LgUlaXIKkD7zaytUZUCE3HqN6m583NyGmSRri0rbHTwRIRO5pjYo07thAh9JkAN
         XkqDyM5b5Qhe3ktUiG6EeinTol2UHhdUkSMV0kZCSqr6DCR5t8YfyWb/Db9UY19B9457
         6ApqVFQsJ9lhs0BHiFeBPNz/+0NJ8nP8tV9Ua2ukb3jjZx657m7LnbS+Z7DJfyEXIZ75
         57/Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783970286; x=1784575086; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=g7oXzbKR+Nla7biREoU4+S80J1Fmi0WpZ2OpnGwsyN8=;
        b=rS0Ad2Bjri77gjN7FjZlPrIwYutezahaxZlx69KuzoNzxnQwUgHrQ3qSpCwJ6zHUkp
         F2RQ+LcTuOF4NCICfG0jc689PS0xxSChAVLezoPaDZe2rOtMR8iMqPNKVmBOEuTeT4oy
         9z/Gpz3vIPJfi/U5dTDot+M8iS9w7DxEOGAA37xEGSb52PpPheLe61i9faMFSK8PTowW
         4PqCgb1u48TCEZ60CPOD5WXYNu8lVQSc4l6CPRht37ceI8NPaMI1Mvt5wDzdfqqYk8gg
         cvtOPJ97/XjHQNZKIxWiVSHmcOp8M6bI5IOZLCrNw6LO67IX3ugWOPnjVufImDtoFOaC
         PivA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783970286; x=1784575086;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=g7oXzbKR+Nla7biREoU4+S80J1Fmi0WpZ2OpnGwsyN8=;
        b=HJtZcwHFNkr92Nf42R0toGhyKFB2v3vlUMsMVgNlG1Y+lfP34VM3a43ZRCk5Z4FFAE
         r/QgNblCYdvWBa4yo62wPU0LWYgOp8GUXxp0Xmwtin1CxW1yNS8Y7Yjxhgg+TkQWzzEB
         AT3ykYwfyDMwLQJY63nAlvIoiFgV6GdYDUk8bWb6UvRJPDOAOrjpVQeDcddpnbtq3bbt
         T2QVzi+Mzr2TnTDgpgEfrFZujTtz0MMr+Nm7Cn485uxOH/8fE2ZkCIvMHdKqyrIMiRUX
         Ha0KLtD82o4VivUyZp5X3EZjrWUE08u9agKMAa8zZSX/J5gD+nHixSMefjR0n8LhRc/Y
         ElqQ==
X-Gm-Message-State: AOJu0Yxz2YJTHOBBQTpJEXTS/CTzbyCfWtr+PDzbSH1R4GTyk0wwrv1+
	x4wg04RiP22n7GhX3teh73KdX5kGouto5BtKu2NpML08Y/JUQhkAVuyvUUKvWxVlo69z9qGlvBW
	ErrYMHdkGDi1mhN51sk7rNCfnF6tlSgmd7w==
X-Gm-Gg: AfdE7cntEW56nLuMr6eyY96/vEEpMmNQNZRQuj4ixhL/FQt01JbqLxhl2FAqf35cXWg
	SUD+OLYkK/kygfGPdMCxViG8FHKSez+jFUy7yaPssxZw7xCWjoKSjwbfE+aDs8jBKyVQygNyiil
	jh+4FNztKwMrff7JV+PLpwR8xolEisqWhWvkfysCVv3gYmuMjqbzwWw7YuCxD9Meo5M2cFJwyVY
	DWc2hX0mTNyMagnCSJqbXA6oe4dduh3kME79dGY5cJxwI0aq4sbCMLOG8DT6QovHxjvA+mM
X-Received: by 2002:a05:6808:1509:b0:4a2:df67:d08 with SMTP id
 5614622812f47-4a42b0848e3mr6865361b6e.39.1783970286347; Mon, 13 Jul 2026
 12:18:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1783707063.git.jbingham@gmail.com> <3f7e48122d2b280de63e7b901c7a1d7a99c0e063.1783707063.git.jbingham@gmail.com>
 <alS0Z_wlS-C-2XxU@infradead.org>
In-Reply-To: <alS0Z_wlS-C-2XxU@infradead.org>
From: Jeremy Bingham <jbingham@gmail.com>
Date: Mon, 13 Jul 2026 12:17:55 -0700
X-Gm-Features: AVVi8Ccr7vHfcJOTqB96VjWnIiqDQmPy8ci3vILrTaXHIFLjxJPWf_TG0JGFowQ
Message-ID: <CAMyBmMBRrqc98v3dnKeOw_VFCDO_p4BjMi05kpYyX52Dn1z7Tg@mail.gmail.com>
Subject: Re: [PATCH v3 4/5] minix: add file operation functions
To: Christoph Hellwig <hch@infradead.org>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	brauner@kernel.org, jkoolstra@xs4all.nl, jack@suse.cz, djwong@kernel.org, 
	viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 13, 2026 at 2:48=E2=80=AFAM Christoph Hellwig <hch@infradead.or=
g> wrote:
>
> On Sat, Jul 11, 2026 at 01:59:08PM -0700, Jeremy Bingham wrote:
> > The previously static minix_setattr function is also now exported; it w=
ill
> > be used by minix_symlink_inode_operations.
>
> How does this work without the next patch?

It works as before until the next patch, which is where the symlink functio=
ns
are updated to use iomap. I thought it might be better to have it in
place before
rolling the symlink changes out. I'll

> > +     struct inode *inode =3D iocb->ki_filp->f_mapping->host;
> > +     ssize_t ret;
> > +
> > +     inode_lock_shared(inode);
> > +
> > +     const struct iomap_ops *ops =3D minix_iomap_ops_ver(inode);
>
> Please keep all variable declarations at the top of the file.

Missed that, apologies.

> > +
> > +     ret =3D iomap_dio_rw(iocb, to, ops, NULL, 0, NULL, 0);
> > +     inode_unlock_shared(inode);
> > +     return ret;
> > +}
>
> But more importantly please explain the use case for adding direct I/O
> support to minix, as adding new barely tested code to a legacy file
> needs a very good justification.  And it really needs to be split into
> a separate patch.

The direct i/o support was inspired by looking at the exfat and ext4
file.c code.
I honestly don't have a strong justification for it beyond that it seemed l=
ike a
nice bonus while I was working with the read/write functions. Since
it's something
that ought to be a separate patch anyway, I'll redo this to not
involve direct i/o.

Thank you for your comments on this patch series,

-j
