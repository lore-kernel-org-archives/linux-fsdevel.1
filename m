Received: from mail-dl1-f42.google.com (mail-dl1-f42.google.com [74.125.82.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 240A935AC16
	for <linux-fsdevel@vger.kernel.org>; Fri, 24 Apr 2026 10:22:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777026140; cv=pass; b=rj8T8j7dD+eBiDxeD1Nc+sErIJmNhH1Tlb4+NU13EnoBVLkE5MAqL7VyrWklGkgjVcJ1sKpir8na/XonDb905HXtsP2qKG+sXKWxpTzulNG5p1yTG7cCUfgWnGACmV8G8U9jFKbyHLHYfyTNu/7cDpyc9gENln5ilrkRBTVVRZY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777026140; c=relaxed/simple;
	bh=qwkdZtPwPaCl3X89xMpkQSbOGgQa5R8LkAKoZCqUTeQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=M817OuliNZYGD1q3FJ4IVu4gOfYUN21Zu1ZkV/JMgxOvLosMAJsO9ibKuztcN9FsGPUDHVEhVg4WEaOXOMl58vNkt59IMkflTIXBt+0Jz/49W7NI0nEkciUex/sxr4qv/Vk+VTOKbIeP4KUAxBUAwP2oaAZHz+cQql82WYoKwJY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dF9Kufm9; arc=pass smtp.client-ip=74.125.82.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dF9Kufm9"
Received: by mail-dl1-f42.google.com with SMTP id a92af1059eb24-12c565476d7so3133841c88.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 24 Apr 2026 03:22:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777026138; cv=none;
        d=google.com; s=arc-20240605;
        b=irAboPwH3uZZoghO/MOO3FRimx32/YBUyIld23NFkDhAZr5uTqgRzdOme03PEdbNWx
         TDBemuaRuCGQbIoHdqWMPOv8jfv3Gok29dWLjaGQEp5AiZSh2dPFh2iX8BvFbYq4csOq
         sRCKl3wtAuPU6HfahB0LqtJ0NvU4ofPtyFZ0jZBAmgB2z86UNef1PF7KvCWFsXyuco4A
         he454ABPgdZY0Adswc8pxqWEI+ZmVupM7LLgH+cM3+yMW+LRfnl2aXyM2sm9rUhuPdn1
         E/l9E9E3gnSe3HxasJak8ZKGOYgwd3MiZCpubYkAO1dGTghaK41vMaYqU2Xkkc4Xgz+k
         mvQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=eheeWEUfzmB0M3rbJTls4P9xIKSst+zUcfI2+fpkm+A=;
        fh=72kdE86FPlsRmH5YM6oGpKx4w6YUow0zx6HtTl36SUA=;
        b=U+T+yLx9RoRiA3xqNptlCcsCf6J+5iULMORYfzyHmuvdk/wtztNiWhBvkbPVUKN/aL
         fJyjfFtJaOc8VZgnNGk/is1UuofQ1na4sRqiSONkxPJlb73HnpuipR5+cLKg7L3+GUWD
         b0/Jz+NNvuhAxiY2pgOQukxNnS+3RKe8mxkyIScgTljFjTl5FN3WGb0fLJtR5s6lNJYh
         OSVPhyGH9XE2Ndtcu38rGn8tnVaRn51rjcnCDhSPBR/NnA2+Iypo6Rm/9lN3zF4jguZT
         rjsjAk9MavxjoMGqc3R+J/Az1CWvLfjl022VOCALzJxrlGNfQtlUrPgo4t2x+7IQeRIc
         lE2w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777026138; x=1777630938; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eheeWEUfzmB0M3rbJTls4P9xIKSst+zUcfI2+fpkm+A=;
        b=dF9Kufm9P6JLHF1Ah/BuRdPnuFsOEcb53/f02YtPm1rNiCCnG65Yuz5h2GRIfB3f4c
         qO8cvRSgrjkigggy00HXibJ69hh5dsfdPSHqQxaHLanPDnlTjHE3ZxD2xbe65F3cDSo8
         13LmfRPxmhY4hBhlpZUsbIFBFj74l6debFqAr9OhPSbFn22TiRHBenTj3AXIpGpRfOgV
         Vr/1u8BofQ+rrlt8rTgW5YHfqieKtlNb3EQyF0FfbfGyMtDImOMMVtXHDAzXVVa+/FZm
         04phSCXmy9seUIYMy8a9lq2OlzkL34fYR5teVO8c/0nEGb8/rowUOIyRh4jlGrQSVQ2t
         D29A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777026138; x=1777630938;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=eheeWEUfzmB0M3rbJTls4P9xIKSst+zUcfI2+fpkm+A=;
        b=Ty503Bj2hl4YUL7Z76DhBXF5u6COelSLu6FrzEG6J0JkR4P1esCAAa5CcvuiQdF1J9
         IKv1goFqrK/DyHyP4jfjrdTe77tH/6azh4vSL760r05sXWkbsgWP2iR/U9wi2nDR38Hb
         Bo5z+Hu3KoP32EJElmdgrR4ZWi9xC39RA95YQg4mmLLN31HHvq5c9xhnREpiHZu60G+R
         LX2LjLj2Cv3yGfJ51AYSXBtIYi+SsPVJ8mDTuvUHUGMsCixj+DGQMRRMeEhyuKtNXmtY
         N/2kAbEDt4h7xx8bKyuVdvYLSyg39O3FeV10ums74M57BnvjcM9GqKj36OLJCn4N+GjW
         EqzQ==
X-Forwarded-Encrypted: i=1; AFNElJ/4zvQXH7+70ckmWfhNcHLwDEsfXFQyhHPN2TxUxP1pN3hPIJhc3KJbiqa+Z7v19ea3x4QeIRdGehe9dxgc@vger.kernel.org
X-Gm-Message-State: AOJu0YzHLqZfS4N6BKZ6xNhs5uYInQvu0WKlPEXg1xXa+MShAr6JcHW0
	ivOpVj1mj38k9xNBffA3rjX7ej6FmFbpOg0dHa0yJCch1Ijp3khQjTUIY8vgXo12+pfEB6R+s0R
	T5VFAjjjIONEo/9/ZBAveAlMvEEIRXjg=
X-Gm-Gg: AeBDiesYttj25icO8T6NFyCTGb0FeEhNYjAa1M3NVMXLBQpcq2w5VDBFsdQftrdH4Bn
	6LcReBCLdZIpmEpgcbp3GV5018RIxB9ieVXGf763bWW4c05Pxg2UGkR852l1GCgQgn5649wT4Gy
	nvX0iMCL+nK/t6BZ6N2+K8xkAaUZYTA2/wl7DOd8oAtiCj9Kn2yOSDtnfKbHurmZ1RnFVvdlhEP
	w0K/BVRPLNn7fL0g9uzEtbT9/dqPMBlvujnTxQ7XTTVERlagraytDcXSP6QiJ1qW/CiTr0H3fz+
	8QtjBHfqOrVmyE6jhg==
X-Received: by 2002:a05:7022:513:b0:12a:b3c4:c3b6 with SMTP id
 a92af1059eb24-12c73f998b1mr16786993c88.21.1777026138293; Fri, 24 Apr 2026
 03:22:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260409191517.318015-2-slava@dubeyko.com> <CAOi1vP_OFnzuJB438=L_MUS2K0m7j49en=U2K19ZrH-xYUzaLQ@mail.gmail.com>
 <1a5b5d23dc54c9099643795bfad9f14705505fed.camel@ibm.com>
In-Reply-To: <1a5b5d23dc54c9099643795bfad9f14705505fed.camel@ibm.com>
From: Ilya Dryomov <idryomov@gmail.com>
Date: Fri, 24 Apr 2026 12:22:04 +0200
X-Gm-Features: AQROBzBqIrAEqAV7UyZiBn9NAaxN5qQFbZC7UoDQrtfspODu3u6onvyUqBQd-G0
Message-ID: <CAOi1vP95f6x5LX0TmsKxG6k57mCq3HdGBQRL5UJR7sprjHLq-Q@mail.gmail.com>
Subject: Re: [PATCH] libceph: switch ceph-msgr workqueue from WQ_PERCPU to WQ_UNBOUND
To: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>
Cc: "slava@dubeyko.com" <slava@dubeyko.com>, 
	"ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>, 
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>, Patrick Donnelly <pdonnell@redhat.com>, 
	Alex Markuze <amarkuze@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 23, 2026 at 7:59=E2=80=AFPM Viacheslav Dubeyko
<Slava.Dubeyko@ibm.com> wrote:
>
> On Wed, 2026-04-22 at 17:34 +0200, Ilya Dryomov wrote:
> > On Thu, Apr 9, 2026 at 9:15=E2=80=AFPM Viacheslav Dubeyko <slava@dubeyk=
o.com> wrote:
> > >
> > > From: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>
> > >
> > > The ceph-msgr workqueue was changed to use WQ_PERCPU in commit
> > > 27ce71e1ce81 ("net: WQ_PERCPU added to alloc_workqueue users") as par=
t
> > > of a tree-wide transition to make per-CPU workqueue binding explicit.
> > >
> > > However, ceph_con_workfn contains a while(true) loop that retries on
> > > -EAGAIN from socket reads and writes, making it capable of hogging a
> > > bound CPU for extended periods. This manifests at runtime as:
> >
> > Hi Slava,
> >
> > ceph_con_workfn() does have a loop, but it doesn't retry EAGAIN from
> > the socket.  Both msgr1 and msgr2 munge EAGAIN from the socket to 0 to
> > indicate the "socket is empty/full, need to wait" condition.  See
> > do_recvmsg() and do_sendmsg() for msgr2 and ceph_tcp_*() for msgr1.
> > For example:
> >
> >     ret =3D sock_recvmsg(sock, &msg, msg.msg_flags);
> >     if (ret <=3D 0) {
> >             if (ret =3D=3D -EAGAIN)
> >                     ret =3D 0;
> >             return ret;
> >     }
> >
> > Ignoring opening, closing and a couple of other special cases,
> > ceph_con_workfn() starts by trying to read.  When the read side of the
> > socket becomes empty, it proceeds to trying to write.  When the write
> > side of the socket becomes full, ceph_con_workfn() terminates.  It
> > doesn't even go back to trying to read, so I fail to see the potential
> > for what you have described.
> >
> > >
> > >   workqueue: ceph_con_workfn hogged CPU for >10000us N times,
> > >   consider switching to WQ_UNBOUND
> > >
> > > Switch the workqueue to WQ_UNBOUND so the scheduler can freely place
> > > workers across CPUs, preventing starvation of other work items on the
> > > bound CPU. The loss of cache locality is acceptable for network I/O
> > > work.
> >
> > This might be true, but I'm not sure this conclusion can be made
> > without at least some benchmarking.
>
> My system log is full of likewise messages "workqueue: ceph_con_workfn ho=
gged
> CPU for >10000us N times, consider switching to WQ_UNBOUND" when I am tes=
ting
> the CephFS kernel client by means of xfstests. Which particular benchmark=
ing
> would you like to see?

Hi Slava,

What kind of a system is it?  If it's a small VM, the backing Ceph
cluster is a vstart-style deployment co-located on the same node and
the node itself isn't beefy, the performance profile may be very
different from real world setups.

The first step would be determining the source of the hogging.  One
thing to keep in mind is that OSD and MDS request callbacks are executed
in-line (i.e. from ceph-msgr worker threads).  If there is evidence of
significant lock contention or any other activity that can potentially
hog the CPU inside of e.g. MDS client's handle_reply() that would be
the thing to look into and fix, not the messenger.

Thanks,

                Ilya
