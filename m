Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69534313E3F
	for <linux-fsdevel@vger.kernel.org>; Mon, 27 Apr 2026 12:17:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=170.10.129.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777292225; cv=pass; b=ocnkNeJhbMVqRUc29BmyGNCLBaeN7fPhZFZibE1qTPmhO/6EUe4bZUcSHb3MI2ZnFjTN0XFw++cvdlEi1esMIgVbnEFD6dhQ0oL7f3ek+QVO78uBQdPuqLI22nfFwQe7C3WGRFrIlTEWOMhmJNhu8ZpRuNevUQhUJD/YYLT4TOs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777292225; c=relaxed/simple;
	bh=2ywfDe58YjYPaJ6lp+LpIauTVFUhGkoSMPBXwn94dcc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hgu3we10EG+4Tdzn25cCs+1OLSNZ8ljRzIcfPlIIm1XPieDaw0UIXhQZZCQJJI7mOcZiNWzsDepKwQLLN0Y+Tv2za+M/+kL0aBU2HjU7NPc1v3pJLV9GnPjKUfpKZctvsJ7G8c9bBr7aLZU668LRD/V/GWnrYDDUT9e2UzE2jQ8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ReN2yedT; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=S9ejxqBV; arc=pass smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ReN2yedT";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="S9ejxqBV"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1777292223;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PAsgrV2Hu7OQXaXg2h5jiKD7Lt+bjnUPQTfQ6XMG7BY=;
	b=ReN2yedTnJZxVAqz94TLdrrY7CAgvQDH0YG7Nocpl9x2I5sbr7TrQpyOBnXpwTSiGkNJ7i
	im5TEfybgPGbpTSfT2jh+K131WDC+SvCHKfJ7t/ZQrxdBMgJQLvhI8an3BWAnck4f42SUP
	P5AlgLQy8lcQLwws4aVbaJCI1RhmHeU=
Received: from mail-ua1-f72.google.com (mail-ua1-f72.google.com
 [209.85.222.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-363-G2z70gM4MgCirmcarY4B4g-1; Mon, 27 Apr 2026 08:16:59 -0400
X-MC-Unique: G2z70gM4MgCirmcarY4B4g-1
X-Mimecast-MFC-AGG-ID: G2z70gM4MgCirmcarY4B4g_1777292219
Received: by mail-ua1-f72.google.com with SMTP id a1e0cc1a2514c-95674175677so3381464241.3
        for <linux-fsdevel@vger.kernel.org>; Mon, 27 Apr 2026 05:16:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777292219; cv=none;
        d=google.com; s=arc-20240605;
        b=c/4eLf580d5J2kuy4tWWYt5Fg6COfILqdVlfdLHXStLkdJ+BkEtk3hjjL5+XQg+mKY
         4GyYrhDz+WTVaz2Mw7V+UWZFKUoA7xTqsUf6Ik9PZEGJMShpaBdcFNumPZHzY+EyiS1L
         UJLEyCe0pKqVoC/bs3YgUaLy0JgkuU2KYAhfbuozCnZK9KE82jYS2JxJBBrK/wO9a85Q
         g1tBfeVEbGPpQ0uEP6EeRq2pYxsBMQjfcgCI8DKYf/000QwV46zlxL+HBIu8XBhRzuAH
         QeeVGEPHd2JQisyBGhgaykVPmet6VLe4VkV1QwD0LlUhWvYQnzYQF4YhnT/XWs9+ZqG5
         S1Zg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=PAsgrV2Hu7OQXaXg2h5jiKD7Lt+bjnUPQTfQ6XMG7BY=;
        fh=gbaqS31omFmPn+3fRZ1eH745kC0D1aQJee7fEX7KYF0=;
        b=EFucsjG9ZlBjABFRizmu1BqvPCq3DT+JUJP5tN5zO8b1w5Ovtbe2J5SNSrxKo2JG+K
         oVKdwjLxJ3ZOIJVuhvQc6B4/ZaK7QATZnVGpHbqwpiC+U5ErmyeVgZwfUVgQZgcWvDvX
         H0JLN+kFMuo7UdeecoU9MAan5KRqPodif1/dcmALkPSmI6b6uGzmN7PCzRN69V44yyg3
         RS3caoTkN5MmgKbZliMtKhNPnmux4VbHuZlb8bEvn680QXNo1MuGSCYDGmis+jUddvQH
         YPTqDjzaEtBJaU2eaRREpoFu+DsBa35jNSTLRVph2GmAuGdowZAVMsn1csXQdISs3EsU
         y2cw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1777292219; x=1777897019; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PAsgrV2Hu7OQXaXg2h5jiKD7Lt+bjnUPQTfQ6XMG7BY=;
        b=S9ejxqBV9A9ZvDZdoWBFtuTmTyNUn/lcDJbwA1NsVrkyOq/oNl+2cAhpWsqyFqf24O
         bCmd+L2A7y2pU3lB0tfS84W0e96BEa99jUV3yGjjSfeI0JcPHdVFUY9bTm5+bA9cCnZR
         I/2Lq/A0ROBabgS992WI4pMbY7AQS3vdE6n1BBUCSJKQxXFydg4rQ3Fl4UGc2yPsSvEA
         hEr9VpRK9PPpf0KXexUptbKZq3S8H1EOhWA8C0dtKtG2CVAjZjA/LPvz1mXJFZ5cx7P0
         m7/wS3bT1xU3UgioN9bC+D6uC8TpfwlH4B75Qa6y+jTuR6LRqaXRRUMz5xOL9Qh929M3
         RLiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777292219; x=1777897019;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=PAsgrV2Hu7OQXaXg2h5jiKD7Lt+bjnUPQTfQ6XMG7BY=;
        b=UHou3hwGa3nncsjckU7Ft0lA6ZUaD0Une8sg9mOliMh2NbU3BwAWH9MRcOorviofo3
         eHV0dI1iwhAGVA2jCfd/JTQsIC7f4og5p9QuoPrux3WiZ1/c7VN62k6KJu/CNjHuha0H
         UIv1S8JrGJRxaJJKdkP8aUrAbtVS28mOnwrLXKNQX7sxVLlLQQlAL/yqa81uKEPTdt6/
         klpNgZ+jcIp0B2F/lHd+z+rwbsqUYLPZT9BDaGXIdlZyyMSCBCVpIzT1OgA7/aV6uHYf
         1bn7qzdnEeJDjImwqy3M/BnOCzdiq/kJ7qBtnpM2rj4pkcvpUUj+abxXo0O2Z9SzRW9B
         HnIw==
X-Forwarded-Encrypted: i=1; AFNElJ9hP4e7llbhN1n6RZ5npheUggbXFPqn6t3m/PqDxjRvzJx80mrpN2fSv2tBx/9YnNEQ63lXEshuoFZg32GQ@vger.kernel.org
X-Gm-Message-State: AOJu0Yx91IIF4XGC7COdh0umPGYpt+jvIdPE1tfVuIXPHrIi6B85s+CI
	VivmHviOOV6088Yws9UNjnpbgEVIOgiYCrVYmYQRdbeeYn2RlXjUYzlN/+auSOtJWyGz01FydL/
	EQMF1Zor2CAECD4p5ZOM8tVSAABYvfxttI2lUIyS0GQMHTxB1fQ9MnHa04JMc5W5WRGo3Y9houL
	SEjAPvaAcBD04gHsUHhT5MiEdgvySuLnnN9yzAsln4VQ==
X-Gm-Gg: AeBDieuOgUPblF/RTKcj8CWAJVIBh/fIuntRCninEn5ombUulDPsLv8CZeH+VM7CJQO
	92OnNYoZtCyDTjuV3ohAdb/yFOC6UvGFDbyUnzsxbUWn4g5lf9M+bv1lI4QWPvmlcGcoNHG16FI
	2cfb4aMmz3y8qxuwLwtAn6NqOxAk3nAO5em8i5Pu0vn1rzOvjIdiZd4mjqLG/mG0xcmHZ56csm8
	/o9xAPiX1/TEY8=
X-Received: by 2002:a05:6102:689c:b0:608:94e4:1c00 with SMTP id ada2fe7eead31-616f4e7a272mr18254883137.2.1777292219161;
        Mon, 27 Apr 2026 05:16:59 -0700 (PDT)
X-Received: by 2002:a05:6102:689c:b0:608:94e4:1c00 with SMTP id
 ada2fe7eead31-616f4e7a272mr18254846137.2.1777292218718; Mon, 27 Apr 2026
 05:16:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260226223042.2027550-1-slava@dubeyko.com>
In-Reply-To: <20260226223042.2027550-1-slava@dubeyko.com>
From: Alex Markuze <amarkuze@redhat.com>
Date: Mon, 27 Apr 2026 15:16:47 +0300
X-Gm-Features: AVHnY4IytD21i1Xr9yJ37hxMecnFrTQ5k3Ta8e4ClaSksCZKXK2vyLl9X211RM0
Message-ID: <CAO8a2ShPx3j4UUwAY404VdzG7wE8O-nGRiv5twwyLek07_RVhA@mail.gmail.com>
Subject: Re: [RFC PATCH] ceph: fix kernel memory exposure issue in ceph_netfs_issue_op_inline()
To: Viacheslav Dubeyko <slava@dubeyko.com>
Cc: ceph-devel@vger.kernel.org, idryomov@gmail.com, 
	linux-fsdevel@vger.kernel.org, pdonnell@redhat.com, Slava.Dubeyko@ibm.com, 
	vdubeyko@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Reviewed-by: Alex Markuze <amarkuze@redhat.com>

On Fri, Feb 27, 2026 at 12:30=E2=80=AFAM Viacheslav Dubeyko <slava@dubeyko.=
com> wrote:
>
> From: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>
>
> Repeatable running of generic/013 test has revealed
> the kernel memory exposure attempt for 6.19.0-rc8+ in
> ceph_netfs_issue_op_inline():
>
> while true; do
>   sudo ./check generic/013
> done
>
> [17660.888303] ceph: ceph_netfs_issue_op_inline():317 iinfo->inline_data =
ffff8881000b0112,
> iinfo->inline_len 0, subreq->start 328187904, subreq->len 4096, len 0
> [17660.891728] usercopy: Kernel memory exposure attempt detected from SLU=
B object 'kmemleak_object' (offset 274, size 4096)!
> [17660.893370] ------------[ cut here ]------------
> [17660.893377] kernel BUG at mm/usercopy.c:102!
> [17660.894426] Oops: invalid opcode: 0000 [#1] SMP KASAN NOPTI
> [17660.895749] CPU: 1 UID: 0 PID: 150873 Comm: fsstress Not tainted 6.19.=
0-rc8+ #13 PREEMPT(voluntary)
> [17660.896823] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIO=
S 1.17.0-9.fc43 06/10/2025
> [17660.897891] RIP: 0010:usercopy_abort+0x7a/0x7c
> [17660.898575] Code: 48 c7 c6 80 bb 3e 8c eb 0e 48 c7 c7 c0 bb 3e 8c 48 c=
7 c6 00 bc 3e 8c 52
> 48 89 fa 48 c7 c7 40 bc 3e 8c 50 41 52 e8 e6 00 fb ff <0f> 0b e8 ef 0e fb=
 00 4d 89 e0 31 c9 44 89 f2 48 c7 c6 c0 bd 3e 8c
> [17660.901225] RSP: 0018:ffff888179fbf340 EFLAGS: 00010246
> [17660.901762] RAX: 000000000000006d RBX: ffff8881139ac112 RCX: 000000000=
0000000
> [17660.902295] RDX: 0000000000000000 RSI: 0000000000000000 RDI: 000000000=
0000000
> [17660.902813] RBP: ffff888179fbf358 R08: 0000000000000000 R09: 000000000=
0000000
> [17660.903317] R10: 0000000000000000 R11: 0000000000000000 R12: 000000000=
0001000
> [17660.903820] R13: ffff8881139ad112 R14: 0000000000000001 R15: ffff88811=
9da8bb0
> [17660.904283] FS:  0000747714d62740(0000) GS:ffff888266112000(0000) knlG=
S:0000000000000000
> [17660.904719] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [17660.905122] CR2: 00007477143ffff0 CR3: 00000001014f9005 CR4: 000000000=
0772ef0
> [17660.905555] PKRU: 55555554
> [17660.905743] Call Trace:
> [17660.905902]  <TASK>
> [17660.906042]  __check_heap_object+0xf1/0x130
> [17660.906372]  ? __virt_addr_valid+0x26b/0x510
> [17660.906667]  __check_object_size+0x401/0x700
> [17660.906959]  ceph_netfs_issue_read.cold+0x295/0x2f1
> [17660.907322]  ? __pfx_ceph_netfs_issue_read+0x10/0x10
> [17660.907657]  ? __kasan_check_write+0x14/0x30
> [17660.907940]  ? kvm_sched_clock_read+0x11/0x20
> [17660.908268]  ? sched_clock_noinstr+0x9/0x10
> [17660.908531]  ? local_clock_noinstr+0xf/0x120
> [17660.908817]  netfs_read_to_pagecache+0x45a/0x10f0
> [17660.909168]  ? netfs_read_to_pagecache+0x45a/0x10f0
> [17660.909482]  netfs_write_begin+0x589/0xfc0
> [17660.909761]  ? __kasan_check_read+0x11/0x20
> [17660.910019]  ? __pfx_netfs_write_begin+0x10/0x10
> [17660.910340]  ? mark_held_locks+0x46/0x90
> [17660.910629]  ? inode_set_ctime_current+0x3d0/0x520
> [17660.910965]  ceph_write_begin+0x8c/0x1c0
> [17660.911237]  generic_perform_write+0x391/0x8f0
>
> The reason of the issue is located in this code:
>
> err =3D copy_to_iter(iinfo->inline_data + subreq->start,
>                    len, &subreq->io_iter);
>
> We have valid pointer iinfo->inline_data ffff8881000b0112.
> The iinfo->inline_len has 0 size in bytes. However, subreq->start
> has really big value 328187904. Finally, the sum of iinfo->inline_data
> and subreq->start results in the pointer that is out of available
> memory area.
>
> This patch checks the iinfo->inline_len value. If it has zero value,
> then -EFAULT code error will be return. Otherwise, the copy_to_iter()
> logic will be executed.
>
> Signed-off-by: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>
> cc: Alex Markuze <amarkuze@redhat.com>
> cc: Ilya Dryomov <idryomov@gmail.com>
> cc: Patrick Donnelly <pdonnell@redhat.com>
> cc: Ceph Development <ceph-devel@vger.kernel.org>
> ---
>  fs/ceph/addr.c | 18 +++++++++++-------
>  1 file changed, 11 insertions(+), 7 deletions(-)
>
> diff --git a/fs/ceph/addr.c b/fs/ceph/addr.c
> index e87b3bb94ee8..426121e38f3f 100644
> --- a/fs/ceph/addr.c
> +++ b/fs/ceph/addr.c
> @@ -314,14 +314,18 @@ static bool ceph_netfs_issue_op_inline(struct netfs=
_io_subrequest *subreq)
>                 return false;
>         }
>
> -       len =3D min_t(size_t, iinfo->inline_len - subreq->start, subreq->=
len);
> -       err =3D copy_to_iter(iinfo->inline_data + subreq->start, len, &su=
breq->io_iter);
> -       if (err =3D=3D 0) {
> +       if (iinfo->inline_len > 0) {
> +               len =3D min_t(size_t, iinfo->inline_len, subreq->len);
> +
> +               err =3D copy_to_iter(iinfo->inline_data, len, &subreq->io=
_iter);
> +               if (err =3D=3D 0) {
> +                       err =3D -EFAULT;
> +               } else {
> +                       subreq->transferred +=3D err;
> +                       err =3D 0;
> +               }
> +       } else
>                 err =3D -EFAULT;
> -       } else {
> -               subreq->transferred +=3D err;
> -               err =3D 0;
> -       }
>
>         ceph_mdsc_put_request(req);
>  out:
> --
> 2.53.0
>

