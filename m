Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB3C3270540
	for <linux-fsdevel@vger.kernel.org>; Wed,  8 Jul 2026 19:02:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783537328; cv=pass; b=F6aS/aq4oeXRvLSessGZ5S7EbklmgA7nJBUzSUQRcsV57jL9Imt9ssF/xQcct/a+dmb1IADKqRUWRBQI0Rspap5R9APkD4ooEKb5DZH2R+9r9skxLVB7sTagKgpQHgWnbMmuHCPPrEdlFeAN5uGDAJB7VCRoY23oXLhmSEUMTHA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783537328; c=relaxed/simple;
	bh=RrokN5hI2xrJP0hSZASJxB0o58XKatfrhNPDXueAhYg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TBqyXD1CxAEQNNDvBWs/w8jlaGda4b4Ah1tyqs9EbBrhKCoDJa69Zciz8YOr0M6Wzc9zur6m11ubp/6NVh863W5MyyqmfmpPf9kTUzXd/TAJ8evN503gg6lXyt8DZ7aZ+ZxgUpDw/+TqAIOc7greDu/XCXs5xs6dQrwWACQtxTo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Glm/llwh; arc=pass smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Glm/llwh"
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-69a5ecbbfb2so1791325a12.2
        for <linux-fsdevel@vger.kernel.org>; Wed, 08 Jul 2026 12:02:06 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783537325; cv=none;
        d=google.com; s=arc-20260327;
        b=iamZ2i5cuxtcYDzi5YP4wIQm7nOQ2c0Ay4RRTkbZs2rzAeatfnnzLkf3Ta62qk3opc
         eAxtB8sPYNv9AK2+g0P+E7o+kk7vDjzj71PTd5/U+jSpUXBo4aGT7ZLl7qfgcPyAaHrJ
         z1COna7NRG4xv2b+9+Vp/Bw4qq2UVlY+H/31bKG4cLyAoxy0yaNKS22ew7rIJsQeaQ0B
         ptOdnfQlAKYRMRsbcbDZm2mTpWHn9A/jy+Bq6cbsLsuhWfXdCoHoL8mpTe1cG6ItHZZr
         99+oP9tnOBN1eJf70ZzWvWwCLr+fb197XS1t2xyK47+wJckjn6MNqtHlbtZr/s6ZB9/D
         rP2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=h6p7iFMPL0RnoW5Oom2GXslSbFev5CUALqnSA0TrUcg=;
        fh=msQWc35XdjL+gQP2FmHoa1YWqI9utG6NaZqlcgX6tj4=;
        b=K9qCfO0y4kdQE4LklUGmQjtDYMyw9vibdRnenZ2659yGyLchk1WUytSybo7hQWC46W
         cSvJylbOlXzNVEYi71XlZqaOWMDbzw/pCJvBNWCKYgGa8OSdwtSI316tiobTqFfmEtlC
         RZ05FaH1rZlaG6MQKMIv4tPoePIXahWSlppJONOtFqr/Xye++tAK9eSW8/NsUfsz0AYm
         Dp33vcywJHDE7g2wa7oE15prZ+VHdYMfqH9fV1WZPUCjjXJlvbwsBPOzsApO1H3PiETL
         wAWxekaGdHz59TIQzN8AuFHLxPNiRSN8jfbiQE98652DtsAxBYRt9BbUqbdRGfZ1QGnC
         Ngnw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783537325; x=1784142125; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=h6p7iFMPL0RnoW5Oom2GXslSbFev5CUALqnSA0TrUcg=;
        b=Glm/llwhmN/OqN4srBrldQ2ar8nOoVYOXQIzgUAQusWDAUbWpUwfXvP7QQfe4hkzoC
         6T/1wWq6ZNv49ZgET+xVVQSy2BN8YuxH2ZQBTCI9FVUMS3kwODjqebtAoJxFSmhKKNLM
         26/dxR/PyXTA4pftE5BznuI2QJ9J8kd/1iis8BTs4fXPRzTV2okI6hfdEdafzGZS0Try
         t/7iH6EVPIQDdvm8s2MIflJ78xi2Ceh3zPPB6y9EXOcq/3MwuQnb6nH7H3JoowV58uRo
         c2Ct1hRUgr8w6j7fAa/f8XIFy1Bwj5Q+kIo1xLn5oKxdJnEK00J1cLUkxzco0vC5m49z
         kJFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783537325; x=1784142125;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=h6p7iFMPL0RnoW5Oom2GXslSbFev5CUALqnSA0TrUcg=;
        b=ihUFegNyYy/5XMXZc46a7b/m3RcCwH0dQKlaGZ5BwDx7XzP4jI3XNwaLlXE6fGtaPR
         SRgb2ANT6F+/wwN0VcYhoB6FbF73C7bbfS0jL1HNiJGX8N6Cy5dozSe0XLUKZQEqlHGM
         gpT+PIUea4ZN//ofDaaDUR/coQMGTqJFKQxNQfq1VMiuuHOv/IzO84/mY2yJ5mtUfw1s
         zyL6nNDZ+SBc38K1FTMNjeYquSMX8UqdvFsQmbrwh+4uLZGA2SQ/NAUJ5aG02QFtCIC0
         hAny5/hsw/1dwamvS53RxBPfDMfYASz9mxKv2gLr08edAgRUKjz3xN8fZfP72L0dTiWF
         M/9g==
X-Forwarded-Encrypted: i=1; AHgh+RoAyA/A1Q+sQaZ35Vgb5fE2GXlvLSTcnqZJQ6YqKyA5Gzp0GZh+N+Thwo5M2HjRs350KMNfh3HlWytjgenS@vger.kernel.org
X-Gm-Message-State: AOJu0YwKBLslWRxcz+2xyzVgNYWUFVNuSQo6qbgR4Xw58Zwd0jXKdISs
	DpjX8Z5TMmV7zFZQ4jmlMqyLKFiI8I3NySdrX7mfkqmWxJJLl7LxQx1d99KIuy/C5A8naEXWqro
	MykvE2MkU1vZrR3y79WfenESJCruiN0vq2vjwyQuEJg==
X-Gm-Gg: AfdE7ckWXzf11dtJhtQ0xvWDZHVtK0i3PesTdLsxRerexRJID1/jJRVpxlsdcj1G6Z9
	nZR7s/fx76/ntfEJCreLr2cnJVjmJLyflqqmyIcnu9oy0xg8cDtcyA28pe2I3sQVhURd6UY1f8g
	wzZYjxFcML8Nuhoygb/iN/vyaE9iD/j1mHskkWAL0wkcrXPTK/pH1nIoEKDE8vW60f6hAwygBsA
	k6b9YnP2p4UHmyYrWeMLjBGMXGDU1S64P4rq6uAN8efW4WQ+gfHGK9d+HXUa7BmW4QnI7uJ2g==
X-Received: by 2002:a05:6402:1f89:b0:69a:9355:ec35 with SMTP id
 4fb4d7f45d1cf-69ab44b5e42mr1817377a12.41.1783537325129; Wed, 08 Jul 2026
 12:02:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260708095831.3381978-1-gscrivan@redhat.com> <CAJfpegsJON=1_84PCGMjASYPFL=Wqsz7dnTAbO3Tdz5DfRQU+g@mail.gmail.com>
 <878q7l8y4y.fsf@redhat.com> <CAJfpegvQ06=2E0V_ADgxwmo7e5weTfOMozmBB-QVNLLWYAm8WQ@mail.gmail.com>
 <87wlv57dt1.fsf@redhat.com> <CAJfpegtTixwWSh9M-9NbwP0nUbJJ9rh0rxqO7BzgK7Su_RpM+A@mail.gmail.com>
 <87o6gh79yi.fsf@redhat.com>
In-Reply-To: <87o6gh79yi.fsf@redhat.com>
From: Amir Goldstein <amir73il@gmail.com>
Date: Wed, 8 Jul 2026 21:01:53 +0200
X-Gm-Features: AVVi8CcH_8D2AVPgSdZmur5rdOwKhUpVaCHJD-tULtZMblV_EPw4hJoYlLj59_k
Message-ID: <CAOQ4uxgbNhdzKN7tvRmFDpt-8CZWh9pVcMLv25HxJzA0_0WfSg@mail.gmail.com>
Subject: Re: [PATCH] ovl: add ioctls to retrieve layer file descriptors
To: Giuseppe Scrivano <gscrivan@redhat.com>
Cc: Miklos Szeredi <miklos@szeredi.hu>, linux-unionfs@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-api@vger.kernel.org, 
	Al Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, 
	Gao Xiang <hsiangkao@linux.alibaba.com>, 
	linux-erofs mailing list <linux-erofs@lists.ozlabs.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 8, 2026 at 5:55=E2=80=AFPM Giuseppe Scrivano <gscrivan@redhat.c=
om> wrote:
>
> Miklos Szeredi <miklos@szeredi.hu> writes:
>
> > On Wed, 8 Jul 2026 at 16:32, Giuseppe Scrivano <gscrivan@redhat.com> wr=
ote:
> >
> >> Amir suggested to add that functionality when I've asked for some
> >> feedback before sending the patch here.  I am fine to drop it if this =
is
> >> the consensus although I see its utility from user space.

I was thinking that getting the number of layers or info would be
a good idea to complement getting a layer fd.

I agree that the same information is probably available via statmount
by parsing the upperdir/lowerdir/datadir mount options.

> >
> > How about a completely different interface:
> >
> > int get_fd_opt(const char *name, unsigned int index, unsigned int flags=
);
> >
> > Enumerating layers would be as easy as passing an index stating from
> > zero and stopping when -ERANGE is received.
> >
> > It would work for all filesystems that use files as options.  No more
> > fs specific ioctls.
>
> Is a new syscall really justified for such a narrow use case?
>

I feel the same way.

Giuseppe,

Could you add some high level context in this thread on why you need
this functionality.
I think it's this composefs-rs work. right?
https://github.com/giuseppe/composefs-rs/commits/reuse-mounts-and-prevent-g=
c-overlay/

I must say this seems a bit upside down to me.

If you want to keep a pool of mounted erofs images, you could do that
in userspace -
create a service that indexes mounted erofs images by unique mount point pa=
ths.
Then you can introspect the overlayfs mount options referring to those
mount points.

Going through the kernel to get an fd and reuse that fd for a new
overlayfs mount
sounds like a strange way of accomplishing this.

If the overlayfs mounter is unprivileged, it would have to go through
systemd-mountfsd
to request a mount of erofs trusted image, right?

Can't the same service provide the "is_image_mounted" query which provides
the mount path?

I am not against introspection of overlayfs, but I'd like to understand
the use cases before finalizing the uapi.

Thanks,
Amir.
