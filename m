Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.224.46
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793646411;
	b=C9ezC3XFvTiux2dZSvw6n1H0tDCPHaP97uzkxdscgyFmU/KV1c0LmWL8wG7L5bGOVGEj
	 ORwKtCOP2ys3yEUXJYDlu47JA0vSseuYjIvxWWZ5Ee7NUp7iX00urnZIXOsVj2XLLlNue
	 I+Z6W0dtBap4CYKMfX9gazJ4hkukkn+mtziDScBjDP9e7TtpJWsiphAusOZcAo1m/yTn4
	 D9kgohPNJ0FMkQwR9oIQks3wU9YQq66RDVDz2bY1oj9OZuyKHvarBO+oVe6Gz7BTxJ8hP
	 d1L7xsWw2tJF1J4cX5L5QPSywapVSSqldlQ7ffhha8K+N2IzBC1sisbVenUiy77Fqgw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793646411;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=CoGzdrvvaViECSeg3PiBflj+0qzs8BGFy96FG4d/cj8=;
	b=cLsS67fQMTeVgb5EYP+Ppr8soQlfK8ChZXSypDncSoGUNRHxZI00iiqh6+ixN7B+uarN
	 58q5ogiCLBm3Wki57LHyfmN4Cc1tgfR5mmPJ+55TrrZPGZZbti/ta37fF9Y6zZphuHB2R
	 k2Q/V23KmqUciy7cckQOO4+ZkjExf5y2UNPDgS+Fgqllzz/vX7Pi1gPZaKG/7cvl9tECE
	 v6dtmmiwqDAnOB+K8mhRY93Wr7OPN2x/GlnVx7FNuJwWZ/VD7f6QSk02RWdB2HiY21hKw
	 3N0Gc2lnh2hcQVq9j1vaqAJFhoo3B8QKBV/FAzJll94S3Bqawm/AEd90NC6n2y5Nbpg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=tnNnjlYE;
	arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.224.46
Received: from mail-yx1-f46.google.com (mail-yx1-f46.google.com [74.125.224.46])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDE56606A32C
	for <linux-fsdevel@vger.kernel.org>; Mon,  2 Nov 2026 19:06:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CDE56606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=tnNnjlYE
Received: by mail-yx1-f46.google.com with SMTP id 956f58d0204a3-67a2efec15cso3072989d50.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 02 Nov 2026 11:06:50 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793646410; cv=none;
        d=google.com; s=arc-20260327;
        b=AFBTcgV6v5tVwuF6F40Qq8y8GGROuf5PmhIQ89C73uDAY20oBdohN32Zr9C9OQH1rK
         EJM1OEgA23UGt2V9uJ28njtUceVMU1W9os2Rn6kWZGWVegJx7G1EfJNi9XpkFehTEqdp
         eXMATffXC7beRljNw/gWhV0h6t+UKVNGXf5Zocqyvpouf6rItpwwyaGrtccKpqjA4mz/
         F+WCmVQNHat1K656QtcG90Wtl+5xixb3D8F1Y6QqGWsyEEMAhyftYQ/H0tXoxZQUWrJ6
         wsa9Y/UEkw0s87eHFFa5u0yZbNZkXqPd/wVqMYeWeKq492QWvuslAiVG92FdY8Ei80cM
         0KTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=CoGzdrvvaViECSeg3PiBflj+0qzs8BGFy96FG4d/cj8=;
        fh=6NKhViZNc2rycAmTPZ1tW3hBzq831o/0Z7lcyL4dmMU=;
        b=AnwUI3OFXayMJb7+NDzMiuKHy1y8jFK0pBGqHhjpT5wvSJM3ChqxtWtGQqtftb85rN
         Ow3sraKyfUA+cqbOsAB3sMZjTeYdNUGZitlHQOEKs5durIoPj7FBShFXojgfszSQMKeg
         b7VNVN/3NK1uZDY1QyvB3+SwKVDo8a0nTHIlOkrk7xEkLS+Va9c2nJ6+FELzqDdvCYve
         jwHOFawd5hcD1hde0OzmpstyzHepB0dQjdxZ3ojDxeoLuS7pAB5T9JXwSoovVdt4pv/+
         ouAsukdGzHT9Sy2YBc9harx12yHLMQAmWwAPBYoCPFOU1rQBSZ73J+4sd7p5bTiicxMJ
         3tQA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793646410; x=1794251210; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=CoGzdrvvaViECSeg3PiBflj+0qzs8BGFy96FG4d/cj8=;
        b=tnNnjlYEC10sRjaX8VVbgcAd8IKKiRclExe8oUiilq9oJbJXGXPaFX7svfDWA5VLcT
         dOrwbO+NBopmy9Rrtc6LeuIOKlv9sNYHZeMG9OC5fE9TOe9mWgw2wNWZQtspd9LRsAK2
         C6/Fd8cuZZCW6A0ONYIN37BzGXlDL9/3Cq419MKJAvuV+BEd67LaqKQwLsTh3j9I0VSq
         caiKXG/Jt2mJ+QGF8dd5beMFmncSCIGhzIqJjv2AeR6ntBD/ovF5X+Z9WgKo7D5LXKy7
         EJ1DiHzkPdusb/TESQq1QJDbStCB4CUmD/ziqBshYiv2TZsxjLh0ZHwxzhWc8cEUWunN
         yyGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793646410; x=1794251210;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=CoGzdrvvaViECSeg3PiBflj+0qzs8BGFy96FG4d/cj8=;
        b=kWhPUmfKx9mCIPHMl8jKiyzumVHWnrPFM2vEJEiB8lKVjRNXG9RRF3VA1p54f4rOzZ
         aaV/s6vavho8HRkZMN3LOZKp/V/B1sCKUcJq+VUe6JuUTtn0jbQjav4NvtR6bGrNFf/e
         Z9JzxixO+vSihNGYgQkwsrQMKwIqjHKbnFEerM7tr7c8dPSiSpSDlsrtaOU0YRyRNzWC
         Xu3oi6nKZPXfPPkztsGh/gj7Yp2fp19C9/nCoIM4ixuMndcZU12Dwy4COP9f8itL3VDx
         4kU4J232gwkXh5SyebkrAdegoxDhnl+nIN/JZAn7avX+OH/9pEj2nIt9MXLOr4ZRoS0A
         AbCw==
X-Forwarded-Encrypted: i=1; AKwUvBwfFptGWkqNam8cBbjQV/PkF38TTV0hC0AhExZjjobX3jHRwfVJN3n74HRodnzYB4Aast1appfQZL+ofMbM@vger.kernel.org
X-Gm-Message-State: APuU4Z/rKVXRFO2pn/JtRm6+iWCepbeByVQUjbCWdBWKNb3Bkoo/7Oj2
	48qHEczd2VqptRPI0clvtg7/HfDhytVPnyuylbM9YbXLRRhRkaHJ45/QKm9Lo5DV7Hqnpx4m8a/
	M+b4/dlKT0ABwxAV+v8VJbPtVHEeK9Ew=
X-Gm-Gg: AYBFou0R/c24M08ME3ssWZM67rvfus88BDkuWF2R+orCQQ9nqcYB+NHjwyzRdxz93mL
	C/+sl+AK4fNMPWNLys0AJ6llubyrsbC8bznvjR+4WcRe3VsIx4pIozPhNXyZVG310O8Kq8UDH30
	s3zDL6whBQRxEwOC4u9iJT+X+7MVk9iAvSNGC2TX/g0zJ24I5mP7fKCRg+rdCU4ofm36k06q7Jt
	NQWpXD/EEPh9AVE0GCFXFWRB4Ad+coQl0+T+t2Tn7fS5A3PAQxRDVzxg3hpoWItATnEwbM9jhby
	lif+B+JDH/KJ6jNV+wPw9Mpnqs6ZP4GOAURfCUTUZ5qO9/GZLNVLi9SYtVfwE7QCGEXcBdeoLuK
	CKElqSOaCj069fGONgGzwZVTl5QOkw60q2KMs5doEJwPiKaxwNaPmpO+F+N7ctU9QvuYUSdropY
	iuhalGt+jlOei9DABrthgLc6WWiLEUS7kriYNu9Zniy4V5rU0zrxQRfeSuaQ==
X-Received: by 2002:a05:690e:1c20:b0:679:90f4:3223 with SMTP id
 956f58d0204a3-67a8d3987b5mr8777022d50.9.1793646409776; Mon, 02 Nov 2026
 11:06:49 -0800 (PST)
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261102130540.252894-1-omosnacek@gmail.com> <CAEjxPJ4hxdvV-r8chmF3RAi9RJX=-4AqntG01=fWUhh4-xP+ew@mail.gmail.com>
In-Reply-To: <CAEjxPJ4hxdvV-r8chmF3RAi9RJX=-4AqntG01=fWUhh4-xP+ew@mail.gmail.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Mon, 2 Nov 2026 14:06:38 -0500
X-Gm-Features: AclHuK9UEiLULgDNF_R4Op6pxR3pAD5yp_wmeU60kO8Lo7f2jaleNkGh11hTlfk
Message-ID: <CAEjxPJ6X3Hvd5eOCxmqaNWi-vqbGEj6rULHiFJGgD41uPxAm7w@mail.gmail.com>
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

On Mon, Nov 2, 2026 at 10:14=E2=80=AFAM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
>
> On Mon, Nov 2, 2026 at 8:05=E2=80=AFAM Ondrej Mosn=C3=A1=C4=8Dek <omosnac=
ek@gmail.com> wrote:
> >
> > Currently, when a process receives a file through AF_UNIX's SCM_RIGHTS
> > mechanism, the security_file_receive() LSM hook is calledto allow LSMs
> > like SELinux to validate the receiver's access to the received file
> > (similarly to a process inheriting file descriptors through execve(2)).
> >
> > However, there are cases (such as dbus daemon/dbus-broker) where the
> > receiver doesn't intend to access the received file and merely wants to
> > forward it to a third process. In this case the forwarding process woul=
d
> > need to have the appropriate r/w access to the file in order to receive
> > it, even though it will never actually acess it. That leads to the
> > security policy having to grant the forwarder access to a potentially
> > wide range of files (in case of dbus-broker basically all files), which
> > is not ideal.
> >
> > This patch adds a new CMSG flag MSG_CMSG_SEALED that, when passed to
> > recvmsg(2), wraps any received files into an opaque anonymous inode wit=
h
> > the name "[envelope]", skipping the security_file_receive() LSM check.
> > The returned "[envelope]" file descriptor can't be used in any
> > meaningful way other than being passed forward via sendmsg(2) with the
> > MSG_CMSG_SEALED flag. In that case the original file is unwrapped and
> > sent via SCM_RIGHTS to the receiver. The receiver can then either
> > receive the file as normal (subject to the LSM check) or again "sealed"
> > in the "[envelope]" anon inode for further forwarding.
> >
> > Note that sending the "[envelope]" file is only allowed with the
> > MSG_CMSG_SEALED flag set, to make the unsealing explicit and avoid
> > unexpected behavior. Attempting to send it without this flag will fail
> > with an error. This also avoids recursive nesting of "[envelope]" files=
,
> > which would only make this feature harder to audit for possible issues.
> >
> > This patch also adds a simple read-only sockopt for UNIX sockets that
> > allows userspace to determine if this feature is present (passing
> > unknown CMSG flags unfortunately doesn't lead to an error currently).
> > The minimal code to do so can look like this:
> >
> >     #ifndef SO_RIGHTS_SEALED_SUPPORTED
> >     #define SO_RIGHTS_SEALED_SUPPORTED 88
> >     #endif
> >
> >     #include <sys/socket.h>
> >     #include <unistd.h>
> >     #include <stdbool.h>
> >
> >     bool MSG_CMSG_SEALED_supported(void)
> >     {
> >         int sock, ret;
> >         socklen_t optlen =3D 0;
> >
> >         sock =3D socket(AF_UNIX, SOCK_STREAM, 0);
> >         if (sock < 0) {
> >             /* handle error */
> >             /* ... */
> >         }
> >
> >         ret =3D getsockopt(sock, SOL_SOCKET, SO_RIGHTS_SEALED_SUPPORTED=
,
> >                          NULL, &optlen);
> >         close(sock);
> >
> >         return ret =3D=3D 0;
> >     }
> >
> > Related: https://github.com/fedora-selinux/selinux-policy/issues/3286
> > Related: https://github.com/fedora-selinux/selinux-policy/issues/3287
> > Signed-off-by: Ondrej Mosn=C3=A1=C4=8Dek <omosnacek@gmail.com>
> > ---
>
> > diff --git a/net/core/scm.c b/net/core/scm.c
> > index ae38f3c1165c..08822b2a1f22 100644
> > --- a/net/core/scm.c
> > +++ b/net/core/scm.c
> > @@ -114,10 +127,29 @@ static int scm_fp_copy(struct cmsghdr *cmsg, stru=
ct scm_fp_list **fplp)
> >
> >                 if (fd < 0 || !(file =3D fget_raw(fd)))
> >                         return -EBADF;
> > -               /* don't allow io_uring files */
> > -               if (io_is_uring_fops(file)) {
> > -                       fput(file);
> > -                       return -EINVAL;
> > +
> > +               if (sealed) {
> > +                       /* Only allow sealed files */
> > +                       if (file->f_op !=3D &envelope_ops)
> > +                               return -EINVAL;
>
> This leaks a file reference.
>
> > +
> > +                       file =3D (struct file *)file->private_data;
>
> This fails to take a reference to the underlying file but will later get =
fput().
>
> > +
> > +                       /*
> > +                        * No need to check for io_uring files here as =
the
> > +                        * underlying file had already successfully pas=
sed the
> > +                        * check when it was first sent.
> > +                        */
> > +               } else {
> > +                       /* Don't allow sealed files */
> > +                       if (file->f_op =3D=3D &envelope_ops)
> > +                               return -EINVAL;
>
> This also leaks a file reference.
>
> > @@ -365,18 +398,37 @@ static int scm_max_fds(struct msghdr *msg)
> >  }
> >
> >  int scm_recv_one_fd(struct file *f, int __user *ufd, unsigned int flag=
s,
> > -                   bool notrunc)
> > +                   bool notrunc, bool sealed)
> >  {
> > +       struct file *f_received;
> >         int error;
> >
> >         if (!ufd)
> >                 return -EFAULT;
> >
> > -       error =3D security_file_receive(f);
> > -       if (error)
> > -               return notrunc ? put_user(error, ufd) : error;
>
> Design point: I would suggest adding and using a new LSM hook that
> allows security modules (like SELinux) to still be able to check a
> (new) permission that governs whether a process can pass along these
> sealed fds so that we do not entirely lose control over their use.

One other design point: you are creating the envelope with
anon_inode_getfile(); consider using anon_inode_getfile_secure()
instead so that security_inode_init_security_anon() can give the
envelope a labelable context, which SELinux could then use to label
and control envelope use directly.
