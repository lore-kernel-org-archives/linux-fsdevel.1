Received: from mail-dl1-f45.google.com (mail-dl1-f45.google.com [74.125.82.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE8CE271468
	for <linux-fsdevel@vger.kernel.org>; Wed, 22 Apr 2026 15:34:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776872062; cv=pass; b=X9SNZazzNdnUCCOlqzA6ZIQSNxk4XwqtJOwIeojmOTRjVUJkh+zhjxkX64L9s5mM4LHQsvaXsVhkV0GPxjQEcD1igLR242JvUfF0mWkGq55aezGDdNbfVQpGV1y+/XKKPoZtC6LYCQTKwi95VOXsyExmCriJB8o47jtooBB1FSQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776872062; c=relaxed/simple;
	bh=S/TnKoZdkb9HNlWBiqkMsyeGAdW7oEoOobtapOUR5NY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=A4Wlqnbu7nPQdKQWK3DWjTrnQTJmTRguqP6ZtGhDxrKjktIfh4kjm70GYXKS/Ck7vzgac8EICrYVZuq4W9H0fZPb2Q/ZXJIzq81pdddEOigJNqpMWuWtzBz2ISbWL6M72HmgjMcfFdF9CqxMnFowF6BBjo9bIMfNd3q7K2+yN1w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GOB3XdnY; arc=pass smtp.client-ip=74.125.82.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GOB3XdnY"
Received: by mail-dl1-f45.google.com with SMTP id a92af1059eb24-12c8cc7a77eso2283631c88.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 22 Apr 2026 08:34:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776872061; cv=none;
        d=google.com; s=arc-20240605;
        b=KL3aWd68CBiWxdLi3tv3S2RZ9EXHlQ5v6LS/DoadbNVO8BEmQrih18qZVVHWDcmvZV
         MXEbnmv1lgdLP1y63/zl0U1kw7xoTX746QvZr7mldDPoEKgWNvhcCB44nLYBajUQDyDO
         k096AdOirgXuItuKuWDQK7gBoQs8duT1HEX1YEsgqBo3x/pIFuJssCPcxsU+vJFxtJvb
         rIocAeGwcpc0gRGxflIR8amOMENxmSqwUMeMaBkDkDrlDIa7wUXrXBfaempS9j/rIOIq
         DTSDqZuPl49d6ZCb/P34VtHlqeHhFlQMxkMm44YyP88MiR0bs5Hp7nVzt0Q1PlnTZ3Bc
         julw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=J0hv8VmWlW7hTbHZjg4sIUbWzKDBkQBwU2+883ho7Cg=;
        fh=EghPdcEOS60NkNk7RfdaxYk2FLkvckHcJt2AMoiGvTc=;
        b=GuVO1uVR47kb+YZ5pLuaLlQpU4PgzxqxVMkzAGkPOl9jDxTzDEkCrlqMkzoJUDl2bn
         tQSci9l8KX7glBNW9PN+YGPRA3XpV4EpfqKL3W7y2X8p5Azzkc2nVPV67bYJiHJtJU0J
         hDULv8ZMBMqFh4p6TwmryXnHslGvjaWrJt/l90NJHUhjBvwbKso6O1FD0UIHS8aUc+X9
         EHSAr6//hjHlmu1dNCCnkpMXu7QrAkDXV1B8r5a4379F0VAQCsaSx/FFyshi8zNj0ICs
         EjhM7nHcNPG8K4KxrOgcxsnzxlQGZdoIx9oyTTSM8gUsP778U81FyKhrHQi2bSIOo1Qv
         Td4g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776872061; x=1777476861; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=J0hv8VmWlW7hTbHZjg4sIUbWzKDBkQBwU2+883ho7Cg=;
        b=GOB3XdnYx31mBC5qNguWIQAk0h8Di1U4sjkB/fU3o5LIr28dFIE5v74G0JBtTS8C4Q
         BJopacyy/vZzKImkUDb2PmpC2WJyXKT1ma1UCQZWuevwZ4XBr2VLHjWzeqCfVXN5z/IS
         rDVGwswLNLhmpxHnAbCaPr9o84mIqCZBUbkzHEODXNebtIJ7BOgZr+G9r4xIjUuttpD9
         wPaHZpUksPPouClNZyyRgMC2Xa23I9BS5XibqFHpGAh7QmIxuztU9XHOdcjPlM22y8t6
         EAKc4d7QlzG8WR1Th4bxBT6o5YkOOyOy4ZW4owEQh5l9PP4Ay6lSjwHJLaRfoDnalb77
         RVUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776872061; x=1777476861;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=J0hv8VmWlW7hTbHZjg4sIUbWzKDBkQBwU2+883ho7Cg=;
        b=J/SAktdOTSuY7LHIbNI+nkH2FK6WYoMAuNaj58tBNWpo2+ORkQbGwrMa750b5iL+Mq
         Z179hwTiT6lYrLFa6Pw6a9N48DZhkDJpclzkr2y+7asQtO7l0amyLIbkjh8ydA3peCaQ
         2IMeZvWnCEN7D1gYFl9IKnVpoK57edDIqF4nfnRV0LhkHfxpaRNfOmK0Zz3f5tbGXCpD
         yDbAfBX5DuC+C8sIoBScHJVXE2Xp4FmTETMXjKR1GW4poJcenUhxhwmeuvVh/D+xyynG
         +kxcUAORJWTDb/mqokD2p+jZGxVCk+A/nj4hm4yKmxgncjerX/iZ9YNg8bIlDhwf5iGE
         xrHg==
X-Forwarded-Encrypted: i=1; AFNElJ9j6DEjV0pgnDjMRf1fs560zs0Z4I59ZGP6wqd/HjFBbvpgowf2g8xmoIBrQIbW2vKO1SOgULgEXXm4wTfe@vger.kernel.org
X-Gm-Message-State: AOJu0YxWuQWxyTScHdY93eQQCrl+1nkIyxiA813Jdsk82YiRMMYjK/q6
	Z4ivdiT1mf00DZXSrhm2jbn8/cN96SBQUJHpV1Jce9uVBS1tmZQXeUtK3ggnQJKj95TiSEWqdRL
	+g8TbX6oBzFF4nOtU/0vm2w+8EbLH5U8=
X-Gm-Gg: AeBDiet2WtsPkiTEbpwhsfGfpwcGqLLam6qugoaFzPZPsCZy1hFfoL+t+gFjPdDpjpr
	taozRw58snU2KmL9X34TI7hWJup0ogDuKss0r7fVC0QsBM51CYF420VtGCUTNSC/3Dl10QqNYPB
	75ob+Qz7d6ozHtjcO7tPs7JQLSBfDM/euSkk2wd/KI88IjTz6Q+T98bleS0oeiJ3V7CqMYrmTPs
	4i0jUIgoc4ooJP5XtXcNfmXHYFheIIOsJVvIJvjcD3ZqR1pV+f+vwkMS4ZzhwKijY1NCATGSR48
	jAthCXgqVlczKprRNA==
X-Received: by 2002:a05:7022:fa2:b0:12c:11d4:61dd with SMTP id
 a92af1059eb24-12c73b39a41mr9850951c88.18.1776872060807; Wed, 22 Apr 2026
 08:34:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260409191517.318015-2-slava@dubeyko.com>
In-Reply-To: <20260409191517.318015-2-slava@dubeyko.com>
From: Ilya Dryomov <idryomov@gmail.com>
Date: Wed, 22 Apr 2026 17:34:08 +0200
X-Gm-Features: AQROBzCBL6n6MOVuI1650s_ve_MMIwwV6uA_md14TRV4yKcjEc5J6RafImsad-s
Message-ID: <CAOi1vP_OFnzuJB438=L_MUS2K0m7j49en=U2K19ZrH-xYUzaLQ@mail.gmail.com>
Subject: Re: [PATCH] libceph: switch ceph-msgr workqueue from WQ_PERCPU to WQ_UNBOUND
To: Viacheslav Dubeyko <slava@dubeyko.com>
Cc: ceph-devel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	pdonnell@redhat.com, amarkuze@redhat.com, Slava.Dubeyko@ibm.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 9, 2026 at 9:15=E2=80=AFPM Viacheslav Dubeyko <slava@dubeyko.co=
m> wrote:
>
> From: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>
>
> The ceph-msgr workqueue was changed to use WQ_PERCPU in commit
> 27ce71e1ce81 ("net: WQ_PERCPU added to alloc_workqueue users") as part
> of a tree-wide transition to make per-CPU workqueue binding explicit.
>
> However, ceph_con_workfn contains a while(true) loop that retries on
> -EAGAIN from socket reads and writes, making it capable of hogging a
> bound CPU for extended periods. This manifests at runtime as:

Hi Slava,

ceph_con_workfn() does have a loop, but it doesn't retry EAGAIN from
the socket.  Both msgr1 and msgr2 munge EAGAIN from the socket to 0 to
indicate the "socket is empty/full, need to wait" condition.  See
do_recvmsg() and do_sendmsg() for msgr2 and ceph_tcp_*() for msgr1.
For example:

    ret =3D sock_recvmsg(sock, &msg, msg.msg_flags);
    if (ret <=3D 0) {
            if (ret =3D=3D -EAGAIN)
                    ret =3D 0;
            return ret;
    }

Ignoring opening, closing and a couple of other special cases,
ceph_con_workfn() starts by trying to read.  When the read side of the
socket becomes empty, it proceeds to trying to write.  When the write
side of the socket becomes full, ceph_con_workfn() terminates.  It
doesn't even go back to trying to read, so I fail to see the potential
for what you have described.

>
>   workqueue: ceph_con_workfn hogged CPU for >10000us N times,
>   consider switching to WQ_UNBOUND
>
> Switch the workqueue to WQ_UNBOUND so the scheduler can freely place
> workers across CPUs, preventing starvation of other work items on the
> bound CPU. The loss of cache locality is acceptable for network I/O
> work.

This might be true, but I'm not sure this conclusion can be made
without at least some benchmarking.

Thanks,

                Ilya
