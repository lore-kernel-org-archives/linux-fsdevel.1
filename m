Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DEC53B8958
	for <linux-fsdevel@vger.kernel.org>; Mon, 27 Apr 2026 12:27:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=170.10.133.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777292873; cv=pass; b=ps4sKDLeWfSBho63tIIgSlarfNI1BzuVFLi8XhqUQFsvaCtXTWsOZT39eUm6ziXaIHkWC/Jhe+ttEwhSVNwb8vdZTS7wtyA9eB4ErQ7r9RQc3jCz5SP+j1ZX9VJHAkp3jK4WpO2NZdgZKI1//TfpRvv/qZ2Z0bH4DApfTiPVB48=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777292873; c=relaxed/simple;
	bh=ecjz0oCz1AqhgzN7n/BflVTGTj3fyMdBMfskfW6UBr8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LxgCWLxmbq6buVobTKcSZiSCKi3lTYVzNYaez6DcVwKXVtDPP+boSPVRpjkVxmhCSllVqf5ZYjSTVfpsw3id5p8RdCQ8qEG6FAln95XaEhOV+44uJWEl44vtoS/c/lgcQEMJaoEm4NcqX81+fxdjLqBMj75Vrp0XuYZBAmIyNLY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Ou8uRwrY; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=L8SRxScu; arc=pass smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ou8uRwrY";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="L8SRxScu"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1777292870;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7S/ntXneIhHNVzo1cn63XWJKU8G3uiesnoFMLhunhBM=;
	b=Ou8uRwrYW7ln5YTRdsrw0kencDUMHHpqFr3o+hkeSuAHIVabvLN3oamEhMgQ3u4IytEsdM
	tJb8tLqBpMZ9Gc8vkHKqiBz1YrLjLbKGHk2jUkfBNpXPquCr+9W0e/eDG2XQsUE+H4cUw6
	G2Plq6//wakWrHCcdCZz2KRfVSes4jw=
Received: from mail-vs1-f69.google.com (mail-vs1-f69.google.com
 [209.85.217.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-614-X0tE64xmNb6P1J2BLOLwBQ-1; Mon, 27 Apr 2026 08:27:49 -0400
X-MC-Unique: X0tE64xmNb6P1J2BLOLwBQ-1
X-Mimecast-MFC-AGG-ID: X0tE64xmNb6P1J2BLOLwBQ_1777292868
Received: by mail-vs1-f69.google.com with SMTP id ada2fe7eead31-605e5d95cccso7749427137.3
        for <linux-fsdevel@vger.kernel.org>; Mon, 27 Apr 2026 05:27:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777292868; cv=none;
        d=google.com; s=arc-20240605;
        b=J1UYFGmHRk+hW6DqfDJB0o3rDsEunCIzQBdBB8m9Vqikmk8+rjLFibxVom56ZY+5pM
         1O/Yk+aLUtoy8Zj//dZV0goAwKCd6zBd+obvch8TPWlwf7fCYadfwwO7595UhdBM3HWv
         Iz6DHi3AWZ+GO8j4Na177wHZ3LdDuJ5S0gjuCngiyjIB0JSH8gc6uBk1I+UaETr6bq9K
         fPxeB6fXyARjC7RnMxkuHFdzlJ8eaJ9WUv+eSzwAZhXVz+Jz6Rs233vFhTN9VOMa3weT
         2F5e9zi4Wyzlwe3RMsXhBr7wPfXTV43OH6CcU8GCUEwa+F/0QCwtcDlv0r7ekFXxarHt
         2DwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=7S/ntXneIhHNVzo1cn63XWJKU8G3uiesnoFMLhunhBM=;
        fh=p3E0xavbKGbVLcLpKAFa9DifeNwDInj+a5ioxb9kttU=;
        b=X+uwEKs7uNqLogZdB48nKMprXGN4DH0K8jJgGq1EMhRIJfNDG9x4dLTdtneiUZFv3p
         upoNp6FmkZcQaOMlLsMTtE88iETQwjVPUPllnuSJsjtv6u6QgzOvCVFxs6d2xUJ3BLU4
         hsXRgrqtN3TT5OUANdwWJM13BaeuqUs4hDP4d50/efRBRIZt5D0dpe0vDjDP4qXnHgHR
         aO85yDiw3ZR/RqQUgGuyAA451++w2/NTlGYsNSXldFgiPaplwzox/fOD6hzkz2NkDiIe
         qVKX3PGniioUMNj6+EWKBC4r4JSvekbPZ8yFjxVhaos/YP77Gl22HwvIJqEHZnwwlUVN
         zLbQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1777292868; x=1777897668; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7S/ntXneIhHNVzo1cn63XWJKU8G3uiesnoFMLhunhBM=;
        b=L8SRxScuvJYmt/M1fvJXmivtxa/neu9UL72iLHwVkqFW8ekMuOlgT44kNGUDxl8zhh
         8PUni0CmXeQpKAJsVevtCFR4H84xbCwWFOSQ/Krhl5bEbM52cIqGT3U0TIPBkHjx4xUG
         8Q7SCvIl238+6YrvaVUa1JurWtmXfUKvtnAbd8nk0YIrWMm/YzDrelZLdkN5n9UmYfd4
         lhXIP0y2951Z24Rt4YRuUq2FEKkLNGyHFhnbIwfC6dEQhZt1TqVC06rS+ioUd64nA8Lj
         ofqG5/IpJ2aC0us7vR3EmTbDtqAeZ1rud7k3kcY1XL38ssEWYN1gHcE3RGyLPECjQZo8
         TNsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777292868; x=1777897668;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=7S/ntXneIhHNVzo1cn63XWJKU8G3uiesnoFMLhunhBM=;
        b=fcDBHLiGodgf7f71Qnxy1dfRW9v+v4rZ/yb+fjxCe6PxtDgW+wH4XkmX8TvAB+JJVs
         vSJ1BooD3jLsADhyxgBELT5k+LwzLkY8UCOF7j+SqESnO6x0VJdozf7KqOuf4R4+gFXq
         kvM9Z44jl2VdBKAhaSfeWM4QQx5AC5G678fN3Sz79//MmAuji/UiC5egCTPrW8YMMaJY
         3kuUzL1K1aTK7BKIFUR9f46fmNFHFgdX5J7yt6CWE7i5GdQZPCpZW6UOz5h8Numny8yL
         5LYN/T1lOCwT//uL754EY/mmq/hW4rb0AeVDBrCcwF1xfq9Oc/peDaGmqohmdJ0lj/bj
         Ex9Q==
X-Forwarded-Encrypted: i=1; AFNElJ+KLp24hSFqVWb+h+CiAtzegSJrZz5WTVnyVB5OxWmtFWRMIshI9XoqSdvH8y57qKe+EOgrlxBV93bxb9Te@vger.kernel.org
X-Gm-Message-State: AOJu0Ywnu2MmGDoUteXMjSyxy7iH0rPhgIxd1NMpbtJyjEeSFSA/Fhdd
	8DMeBGdyFXqtNBEEwy+mWdzi8QStT2hbThsvAnQepVmZL5NExrHhTcriHK+msHnBjlAJomRz1QG
	aaNtUCVWncSSd+X4gyPyaog9PcAFbILvFjIubCk6970knt2RLGNH9+yZSpd7jMpEuMYGzy9Jww3
	BAY3DQTxpwWNqNeGcp/h5vIDd7ZEhtRi5mtXZUoKe9fQ==
X-Gm-Gg: AeBDievfIEmOQhM0T4ppN5aYQdb9HrfXuxGGXbYfHoKXNL1xPCTEvWmdmTCVtuURKTD
	+hT/KnGuZYIE2+8hnmXAEY26Ksl3OrJ/JVmDM01KqFjpwYAGTverNs0iQKk0oq5+akdVARDnmvV
	YESDNJaXj0Uqz3S/SHqXlF970W6oA3qy7dp+/hRo+1FxOTKV4tlFnqZAcGZAf6CVT8lx8OBMef6
	5/8aSusy1d8oAg=
X-Received: by 2002:a05:6102:809c:b0:5ff:cb2c:a04c with SMTP id ada2fe7eead31-616f45352b2mr20584140137.1.1777292868351;
        Mon, 27 Apr 2026 05:27:48 -0700 (PDT)
X-Received: by 2002:a05:6102:809c:b0:5ff:cb2c:a04c with SMTP id
 ada2fe7eead31-616f45352b2mr20584117137.1.1777292867862; Mon, 27 Apr 2026
 05:27:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260226223042.2027550-1-slava@dubeyko.com> <CAO8a2ShPx3j4UUwAY404VdzG7wE8O-nGRiv5twwyLek07_RVhA@mail.gmail.com>
In-Reply-To: <CAO8a2ShPx3j4UUwAY404VdzG7wE8O-nGRiv5twwyLek07_RVhA@mail.gmail.com>
From: Alex Markuze <amarkuze@redhat.com>
Date: Mon, 27 Apr 2026 15:27:36 +0300
X-Gm-Features: AVHnY4LTJDFau-bPbPRO0d7e3yauoztsw-Y7k8CBdgilfw5mB1wBlKi0EokpaMs
Message-ID: <CAO8a2Sh+=ef4mjp8tOR4HeqY9r4CaPJ7rCq1-WEmO25on7uSRA@mail.gmail.com>
Subject: Re: [RFC PATCH] ceph: fix kernel memory exposure issue in ceph_netfs_issue_op_inline()
To: Viacheslav Dubeyko <slava@dubeyko.com>
Cc: ceph-devel@vger.kernel.org, idryomov@gmail.com, 
	linux-fsdevel@vger.kernel.org, pdonnell@redhat.com, Slava.Dubeyko@ibm.com, 
	vdubeyko@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Apologies, I acked the wrong patch here.

The Bug is real and needs fixing, but there is a problem:


  1. subreq->start is silently dropped

  The original code:
  len =3D min_t(size_t, iinfo->inline_len - subreq->start, subreq->len);
  err =3D copy_to_iter(iinfo->inline_data + subreq->start, len, &subreq->io=
_iter);

  The new code:
  len =3D min_t(size_t, iinfo->inline_len, subreq->len);
  err =3D copy_to_iter(iinfo->inline_data, len, &subreq->io_iter);

  The subreq->start offset is completely removed. If subreq->start > 0
with valid inline data, the wrong bytes are copied (always from offset
0 instead of the requested offset).
   While CephFS inline data is typically small and subreq->start is
likely 0 in practice, the fix is still semantically incorrect for the
general case.

  2. -EFAULT is the wrong error code. When inline_len =3D=3D 0, the data
was uninlined; there's no inline payload.
      Returning -EFAULT signals a user-address fault, which is
misleading and will propagate as an I/O error instead of falling back
to the OSD path.

  3. Coding style violation. The } else without braces:
      } else
          err =3D -EFAULT;

  I suggest the following:

  A cleaner approach would preserve the offset logic and handle the
edge cases properly:

  if (iinfo->inline_len =3D=3D 0 || subreq->start >=3D iinfo->inline_len) {
      /* Nothing to copy; CLEAR_TAIL flag will zero-fill */
      len =3D 0;
  } else {
      len =3D min_t(size_t, iinfo->inline_len - subreq->start, subreq->len)=
;
      err =3D copy_to_iter(iinfo->inline_data + subreq->start,
                         len, &subreq->io_iter);
      if (err =3D=3D 0)
          err =3D -EFAULT;
      else {
          subreq->transferred +=3D err;
          err =3D 0;
      }
  }

  Or alternatively, treat inline_len =3D=3D 0 the same way as
inline_version =3D=3D CEPH_INLINE_NONE and return false to let the caller
fall back to a normal OSD read.

 Alex

On Mon, Apr 27, 2026 at 3:16=E2=80=AFPM Alex Markuze <amarkuze@redhat.com> =
wrote:
>
> Reviewed-by: Alex Markuze <amarkuze@redhat.com>
>
> On Fri, Feb 27, 2026 at 12:30=E2=80=AFAM Viacheslav Dubeyko <slava@dubeyk=
o.com> wrote:
> >
> > From: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>
> >
> > Repeatable running of generic/013 test has revealed
> > the kernel memory exposure attempt for 6.19.0-rc8+ in
> > ceph_netfs_issue_op_inline():
> >
> > while true; do
> >   sudo ./check generic/013
> > done
> >
> > [17660.888303] ceph: ceph_netfs_issue_op_inline():317 iinfo->inline_dat=
a ffff8881000b0112,
> > iinfo->inline_len 0, subreq->start 328187904, subreq->len 4096, len 0
> > [17660.891728] usercopy: Kernel memory exposure attempt detected from S=
LUB object 'kmemleak_object' (offset 274, size 4096)!
> > [17660.893370] ------------[ cut here ]------------
> > [17660.893377] kernel BUG at mm/usercopy.c:102!
> > [17660.894426] Oops: invalid opcode: 0000 [#1] SMP KASAN NOPTI
> > [17660.895749] CPU: 1 UID: 0 PID: 150873 Comm: fsstress Not tainted 6.1=
9.0-rc8+ #13 PREEMPT(voluntary)
> > [17660.896823] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), B=
IOS 1.17.0-9.fc43 06/10/2025
> > [17660.897891] RIP: 0010:usercopy_abort+0x7a/0x7c
> > [17660.898575] Code: 48 c7 c6 80 bb 3e 8c eb 0e 48 c7 c7 c0 bb 3e 8c 48=
 c7 c6 00 bc 3e 8c 52
> > 48 89 fa 48 c7 c7 40 bc 3e 8c 50 41 52 e8 e6 00 fb ff <0f> 0b e8 ef 0e =
fb 00 4d 89 e0 31 c9 44 89 f2 48 c7 c6 c0 bd 3e 8c
> > [17660.901225] RSP: 0018:ffff888179fbf340 EFLAGS: 00010246
> > [17660.901762] RAX: 000000000000006d RBX: ffff8881139ac112 RCX: 0000000=
000000000
> > [17660.902295] RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000=
000000000
> > [17660.902813] RBP: ffff888179fbf358 R08: 0000000000000000 R09: 0000000=
000000000
> > [17660.903317] R10: 0000000000000000 R11: 0000000000000000 R12: 0000000=
000001000
> > [17660.903820] R13: ffff8881139ad112 R14: 0000000000000001 R15: ffff888=
119da8bb0
> > [17660.904283] FS:  0000747714d62740(0000) GS:ffff888266112000(0000) kn=
lGS:0000000000000000
> > [17660.904719] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > [17660.905122] CR2: 00007477143ffff0 CR3: 00000001014f9005 CR4: 0000000=
000772ef0
> > [17660.905555] PKRU: 55555554
> > [17660.905743] Call Trace:
> > [17660.905902]  <TASK>
> > [17660.906042]  __check_heap_object+0xf1/0x130
> > [17660.906372]  ? __virt_addr_valid+0x26b/0x510
> > [17660.906667]  __check_object_size+0x401/0x700
> > [17660.906959]  ceph_netfs_issue_read.cold+0x295/0x2f1
> > [17660.907322]  ? __pfx_ceph_netfs_issue_read+0x10/0x10
> > [17660.907657]  ? __kasan_check_write+0x14/0x30
> > [17660.907940]  ? kvm_sched_clock_read+0x11/0x20
> > [17660.908268]  ? sched_clock_noinstr+0x9/0x10
> > [17660.908531]  ? local_clock_noinstr+0xf/0x120
> > [17660.908817]  netfs_read_to_pagecache+0x45a/0x10f0
> > [17660.909168]  ? netfs_read_to_pagecache+0x45a/0x10f0
> > [17660.909482]  netfs_write_begin+0x589/0xfc0
> > [17660.909761]  ? __kasan_check_read+0x11/0x20
> > [17660.910019]  ? __pfx_netfs_write_begin+0x10/0x10
> > [17660.910340]  ? mark_held_locks+0x46/0x90
> > [17660.910629]  ? inode_set_ctime_current+0x3d0/0x520
> > [17660.910965]  ceph_write_begin+0x8c/0x1c0
> > [17660.911237]  generic_perform_write+0x391/0x8f0
> >
> > The reason of the issue is located in this code:
> >
> > err =3D copy_to_iter(iinfo->inline_data + subreq->start,
> >                    len, &subreq->io_iter);
> >
> > We have valid pointer iinfo->inline_data ffff8881000b0112.
> > The iinfo->inline_len has 0 size in bytes. However, subreq->start
> > has really big value 328187904. Finally, the sum of iinfo->inline_data
> > and subreq->start results in the pointer that is out of available
> > memory area.
> >
> > This patch checks the iinfo->inline_len value. If it has zero value,
> > then -EFAULT code error will be return. Otherwise, the copy_to_iter()
> > logic will be executed.
> >
> > Signed-off-by: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>
> > cc: Alex Markuze <amarkuze@redhat.com>
> > cc: Ilya Dryomov <idryomov@gmail.com>
> > cc: Patrick Donnelly <pdonnell@redhat.com>
> > cc: Ceph Development <ceph-devel@vger.kernel.org>
> > ---
> >  fs/ceph/addr.c | 18 +++++++++++-------
> >  1 file changed, 11 insertions(+), 7 deletions(-)
> >
> > diff --git a/fs/ceph/addr.c b/fs/ceph/addr.c
> > index e87b3bb94ee8..426121e38f3f 100644
> > --- a/fs/ceph/addr.c
> > +++ b/fs/ceph/addr.c
> > @@ -314,14 +314,18 @@ static bool ceph_netfs_issue_op_inline(struct net=
fs_io_subrequest *subreq)
> >                 return false;
> >         }
> >
> > -       len =3D min_t(size_t, iinfo->inline_len - subreq->start, subreq=
->len);
> > -       err =3D copy_to_iter(iinfo->inline_data + subreq->start, len, &=
subreq->io_iter);
> > -       if (err =3D=3D 0) {
> > +       if (iinfo->inline_len > 0) {
> > +               len =3D min_t(size_t, iinfo->inline_len, subreq->len);
> > +
> > +               err =3D copy_to_iter(iinfo->inline_data, len, &subreq->=
io_iter);
> > +               if (err =3D=3D 0) {
> > +                       err =3D -EFAULT;
> > +               } else {
> > +                       subreq->transferred +=3D err;
> > +                       err =3D 0;
> > +               }
> > +       } else
> >                 err =3D -EFAULT;
> > -       } else {
> > -               subreq->transferred +=3D err;
> > -               err =3D 0;
> > -       }
> >
> >         ceph_mdsc_put_request(req);
> >  out:
> > --
> > 2.53.0
> >

