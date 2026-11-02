Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.224.49
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793632470;
	b=YSEzeJ6bflbe7fSsvJr7EyldS1xl4FFcxaFMiACe5+F1zMga7qXq19Fq5hYUHUlI2w8n
	 FGIJotbCYcHHZDiuExjBj4kDa+djJObpkahQ1modujBoDI1Kgh71Bi94clagfVvLElNaP
	 G5t4i2oMxi7kLKqiHpmc8iCBqdFV+FdjtLjPZVWz9/+I165WUSWRk0pkW9KQPQ5oqu0aj
	 lwlTqILCgz1/uBo+ggk0tLd38paiggWK1AnS88+9+ZxG+pMyynTJxSxNq0JkA1Gmxq/+z
	 p4zg5w63uZS67mFECzBqNDDDKd1ubYBn7S/l5ktUlNMUlvnugKWtpTqVRUCkazrh0+w==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793632470;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=aOdCxZO55hUw/6I077tI6EL/o28ur2wlUbUGRR4UyJU=;
	b=Lz6xyCyU0Y0sIwAXjLePBqnJuzD+iLd8eb+DWjI+kAKXRx0Q1D26J8ySKd9T4Pfx6EHI
	 cocva9k/Ak9Xf2E4muJUwKaYZQ/BBX+reX9TSZxJsuyKqS6Pu2b4gk3d3/ndbFIblYunJ
	 uXjyOJ6xlQjVNK7KD3CxetTQzW42E5A9oRwXHTbYJJt60Ie+xIohnZ1XwlCXwaRMQ4bcj
	 C1HnDKlwCGRsNMk4wGpc2olaDRtHMk7mdft5CY/oGt747wjmi6vcqlVDnD7nFShG2F06r
	 +pM26jjKgbQIuwXIBpnfK4LGSd49DUZGpsNReiQkFJ89snjURWtA7BMZlb0vaoMWiog==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="UK/Ov2Zm";
	arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.224.49
Received: from mail-yx1-f49.google.com (mail-yx1-f49.google.com [74.125.224.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 682236093F47
	for <linux-fsdevel@vger.kernel.org>; Mon,  2 Nov 2026 15:14:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 682236093F47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=UK/Ov2Zm
Received: by mail-yx1-f49.google.com with SMTP id 956f58d0204a3-679a2297c55so3277282d50.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 02 Nov 2026 07:14:29 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793632468; cv=none;
        d=google.com; s=arc-20260327;
        b=nCNSIaa6me7OvslDmrSZZ7NCko+0KD3qHqafz9BGM7djAPHmDUStGZgTIYIidUeKfB
         V/lIHZAO6bv5u6xNkmXp3geLfj93mRJ0ddZK/Mssy4IYEOiOQjhPkjYDtWiE5pHwkKc/
         tW3oKydve5pJOTs8KBZGfV99gVNSC8T/oASGTpbrAmNMpfPbi78Gcf3j4U/yWWUz7Fsj
         n9dEOB9Z5/O4b8dlgH8UHcnGVE2TcIt0WPFFrgn5R88viIgb6ZWKHpWr6fVwJz8lsBhr
         R8cSzmAm8TT7fdUBvMo1l296Cs+q3HnRmSexdzG5uj4RthlkafGXyRMxjsNCvpR7EtI9
         CD3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=aOdCxZO55hUw/6I077tI6EL/o28ur2wlUbUGRR4UyJU=;
        fh=qNbaoDmTlstoUEa44bK7P1PB64K3x49FtGktwkAReSk=;
        b=XXzp18CeKNuca7+PhPT1FZRZOt43oyoPttPs27Slc/tPjFWE778dCYA3gpPjOMr1QO
         wBhNdB3QpCqdoL1UnIZaE92wZ+Z+ckVcmNyWBAXhEvqjdfYP9yGfWhxMzLLnq+0NHIvU
         KKgkP/lPZEh1vB7WvJ5BZeT/70pSe7AyXFXWwxheezmSvQ5xI24wpfi4X8888mjI0s6h
         j4i5UHxFV8pWrqZJACzmM1ZptIIKZoYgAVkopLTYtUhkzfTkf9imcEagTbE7CrWsV9Oj
         glex2DU4kEcM/N+y9PGslg1zUcxOGNsgT6nQENzGq4hT702uDSGyfSun2VnCm806ZddQ
         YZBg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793632468; x=1794237268; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=aOdCxZO55hUw/6I077tI6EL/o28ur2wlUbUGRR4UyJU=;
        b=UK/Ov2ZmZrdzn6wtpyN4IuP0s2NI94uQI7yYBJibP6aHf1CPcffmPVYaLkzYSc7pZm
         Q+awmbVw7SIAx9igzH2GxMbpkJkUZWNm5FYtB1KlYDTmR1d4BJDrwn+eZuXuDN3hfkKi
         wic6ZSVgM3Y1UqylgTszFO6RuIHOCzlfX7DyBHr6w+fBZfeaHkL3L5lbBc4iRYJCXspt
         9pzWytIy2fjqQ7RVqjA8Iyg0vs6YCR+ISjcat8IZewOZC+HDkTF+GC7SBwr94lTftIlb
         iXOhyfTyOpSiHWGkM8CQhvl9wo0AmvYC/zHu1qJMn7diEAHe+U1q3JmLq16spCqaJO9l
         ToNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793632468; x=1794237268;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=aOdCxZO55hUw/6I077tI6EL/o28ur2wlUbUGRR4UyJU=;
        b=rY9bPrjbl8NonMV4vGWfifGdCDw/bcG+ek3uHAaEs2PSuXbqYofVstHtayEHtKk/D5
         QiGPMbYQdFwV6RwfxJUlGC3lBd8lFM1a6FD0yGcI7uM2tfIdp0QrypK/liwVdEBG2ASr
         tr03T/gU4qX467ZV42/F69GUnfgBnTz5ptjwa49l9c6E8olBVqEd+gqwwqieFdvZEs61
         ESEN0TYrWB9rNIoVctaFN7Xiv7HJ6R2oQcE/WxaOS7YMUmSmoSecA9BpCZVUevWhm4fz
         Y/7nw05gDhJ6VhoMTt6Ph+eycBlLKMM2WCaZBfgK+omauSq20Rr8jUwSPGQQF0DzRTY+
         dH2A==
X-Forwarded-Encrypted: i=1; AKwUvByOWqCjDXiinGvI+Tb38NNqrU+r7lqe1Ur6KL8If45FF9razKDXSUcUwJk5m5TtOWtrWzroqgq0Uj9zXJqu@vger.kernel.org
X-Gm-Message-State: APuU4Z/Dfb+rxHpDAps2UdtuszT0bPQ4GQ+QTFM5emX4FWX3M1kyM7ai
	iFjuqvUVhWQjVsiZVdPvaj771/op/oG54rtt4M/CBXKmi9WPUr5Bycz7FLgKIim/Jj+M1D4VQZe
	Ye6HPUo1LSNkzJ29n1UK14k/p/tnRBeg=
X-Gm-Gg: AYBFou15EGhtPRk70HssZ11gTEjXwBQQSxFRXcafd+c9sVpakA0OVH4FimKfbtVbjJD
	KFGeRxeGoeNRORrekk0AXRMn1iS8K2aMZ6vuTjSRSPJUcpKQP4it8FmiyPxwWJq6n5Oqci5oN0P
	yYFfo8AFmO/EXA+lTXriUGlx7dzgzlgmd5NPJMbYeLN7HlXtYTKJ8uVES0Bhj+mnmYsjA1mz0xJ
	aUqufzxvUCjtdE26JRpUcqzpzzg8bCk5rG4T1H8ngrZmBU6UPfGQHdMSpfcXv0JilQSZ50sD95+
	MQDJkN3WdOXHTP4Bw+/yLy9iEqxED3gV6TgHJ1qQePSp684m5gmUh2C0qKnvSurme5UdNBABzGC
	vuC8nkSYTMA3sxPm6PH7hXySZcSpGGv2PVEt0Wl+qfMWI3v55BLdPu5U4YsPH1LvHmM8QsVgmot
	1sDo4CxxOL5QN2vzfylGzvvy+FG06dV2Dqms5M+XNz5L5IEu8ZlKeWACA7QQ==
X-Received: by 2002:a05:690e:1201:b0:679:28ad:d8d8 with SMTP id
 956f58d0204a3-67ba5118897mr8055833d50.104.1793632468374; Mon, 02 Nov 2026
 07:14:28 -0800 (PST)
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261102130540.252894-1-omosnacek@gmail.com>
In-Reply-To: <20261102130540.252894-1-omosnacek@gmail.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Mon, 2 Nov 2026 10:14:17 -0500
X-Gm-Features: AclHuK_S3LwuvSZEIcs1e2WEC4WgX3S0M8bKoabDzHzf2mxELuht56K17Z9rPEg
Message-ID: <CAEjxPJ4hxdvV-r8chmF3RAi9RJX=-4AqntG01=fWUhh4-xP+ew@mail.gmail.com>
Subject: Re: [RFC PATCH] af_unix: introduce MSG_CMSG_SEALED
To: =?UTF-8?B?T25kcmVqIE1vc27DocSNZWs=?= <omosnacek@gmail.com>
Cc: Eric Dumazet <edumazet@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>, 
	Paolo Abeni <pabeni@redhat.com>, Willem de Bruijn <willemb@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>, 
	"Serge E. Hallyn" <serge@hallyn.com>, Simon Horman <horms@kernel.org>, Jens Axboe <axboe@kernel.dk>, 
	netdev@vger.kernel.org, selinux@vger.kernel.org, 
	linux-security-module@vger.kernel.org, io-uring@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 2, 2026 at 8:05=E2=80=AFAM Ondrej Mosn=C3=A1=C4=8Dek <omosnacek=
@gmail.com> wrote:
>
> Currently, when a process receives a file through AF_UNIX's SCM_RIGHTS
> mechanism, the security_file_receive() LSM hook is calledto allow LSMs
> like SELinux to validate the receiver's access to the received file
> (similarly to a process inheriting file descriptors through execve(2)).
>
> However, there are cases (such as dbus daemon/dbus-broker) where the
> receiver doesn't intend to access the received file and merely wants to
> forward it to a third process. In this case the forwarding process would
> need to have the appropriate r/w access to the file in order to receive
> it, even though it will never actually acess it. That leads to the
> security policy having to grant the forwarder access to a potentially
> wide range of files (in case of dbus-broker basically all files), which
> is not ideal.
>
> This patch adds a new CMSG flag MSG_CMSG_SEALED that, when passed to
> recvmsg(2), wraps any received files into an opaque anonymous inode with
> the name "[envelope]", skipping the security_file_receive() LSM check.
> The returned "[envelope]" file descriptor can't be used in any
> meaningful way other than being passed forward via sendmsg(2) with the
> MSG_CMSG_SEALED flag. In that case the original file is unwrapped and
> sent via SCM_RIGHTS to the receiver. The receiver can then either
> receive the file as normal (subject to the LSM check) or again "sealed"
> in the "[envelope]" anon inode for further forwarding.
>
> Note that sending the "[envelope]" file is only allowed with the
> MSG_CMSG_SEALED flag set, to make the unsealing explicit and avoid
> unexpected behavior. Attempting to send it without this flag will fail
> with an error. This also avoids recursive nesting of "[envelope]" files,
> which would only make this feature harder to audit for possible issues.
>
> This patch also adds a simple read-only sockopt for UNIX sockets that
> allows userspace to determine if this feature is present (passing
> unknown CMSG flags unfortunately doesn't lead to an error currently).
> The minimal code to do so can look like this:
>
>     #ifndef SO_RIGHTS_SEALED_SUPPORTED
>     #define SO_RIGHTS_SEALED_SUPPORTED 88
>     #endif
>
>     #include <sys/socket.h>
>     #include <unistd.h>
>     #include <stdbool.h>
>
>     bool MSG_CMSG_SEALED_supported(void)
>     {
>         int sock, ret;
>         socklen_t optlen =3D 0;
>
>         sock =3D socket(AF_UNIX, SOCK_STREAM, 0);
>         if (sock < 0) {
>             /* handle error */
>             /* ... */
>         }
>
>         ret =3D getsockopt(sock, SOL_SOCKET, SO_RIGHTS_SEALED_SUPPORTED,
>                          NULL, &optlen);
>         close(sock);
>
>         return ret =3D=3D 0;
>     }
>
> Related: https://github.com/fedora-selinux/selinux-policy/issues/3286
> Related: https://github.com/fedora-selinux/selinux-policy/issues/3287
> Signed-off-by: Ondrej Mosn=C3=A1=C4=8Dek <omosnacek@gmail.com>
> ---

> diff --git a/net/core/scm.c b/net/core/scm.c
> index ae38f3c1165c..08822b2a1f22 100644
> --- a/net/core/scm.c
> +++ b/net/core/scm.c
> @@ -114,10 +127,29 @@ static int scm_fp_copy(struct cmsghdr *cmsg, struct=
 scm_fp_list **fplp)
>
>                 if (fd < 0 || !(file =3D fget_raw(fd)))
>                         return -EBADF;
> -               /* don't allow io_uring files */
> -               if (io_is_uring_fops(file)) {
> -                       fput(file);
> -                       return -EINVAL;
> +
> +               if (sealed) {
> +                       /* Only allow sealed files */
> +                       if (file->f_op !=3D &envelope_ops)
> +                               return -EINVAL;

This leaks a file reference.

> +
> +                       file =3D (struct file *)file->private_data;

This fails to take a reference to the underlying file but will later get fp=
ut().

> +
> +                       /*
> +                        * No need to check for io_uring files here as th=
e
> +                        * underlying file had already successfully passe=
d the
> +                        * check when it was first sent.
> +                        */
> +               } else {
> +                       /* Don't allow sealed files */
> +                       if (file->f_op =3D=3D &envelope_ops)
> +                               return -EINVAL;

This also leaks a file reference.

> @@ -365,18 +398,37 @@ static int scm_max_fds(struct msghdr *msg)
>  }
>
>  int scm_recv_one_fd(struct file *f, int __user *ufd, unsigned int flags,
> -                   bool notrunc)
> +                   bool notrunc, bool sealed)
>  {
> +       struct file *f_received;
>         int error;
>
>         if (!ufd)
>                 return -EFAULT;
>
> -       error =3D security_file_receive(f);
> -       if (error)
> -               return notrunc ? put_user(error, ufd) : error;

Design point: I would suggest adding and using a new LSM hook that
allows security modules (like SELinux) to still be able to check a
(new) permission that governs whether a process can pass along these
sealed fds so that we do not entirely lose control over their use.
