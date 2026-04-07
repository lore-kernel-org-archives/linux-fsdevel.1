Received: from mail-yx1-f53.google.com (mail-yx1-f53.google.com [74.125.224.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5090317165
	for <linux-fsdevel@vger.kernel.org>; Tue,  7 Apr 2026 17:44:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775583848; cv=pass; b=eL+mpPBa4iPG0W+LHIItHORw8gmcmrE/IdqqdkVU0CWhw/BpkUWk2M8S/1dGTNzO5PLrI6fNhMuXhbsp8wlv4oZqprmsJ2Vg47JC//TyxNgU3yWct/DWPyxObAuTAE8pz6yZ02fBDuQf07hj49gIGGBwnQcr3BhOUlWW1plqFH0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775583848; c=relaxed/simple;
	bh=K0c8fgDTTgJh5aOspZdc9QpK9m+q2mvYovxm3KBy3/g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eXO3E3jMieNUniZxk2MEE8SI27xoMkn41ly+EW69JI3VQ77pyKrn0azzjMO6ILeq9bXY0i35PjSEs/X8z33i73Q7Jb2sM9ZSq/1H+VeBZt56ViGW1KRa4pPv6abWomE6tgYQNucd5KWpDeK0LnsVj2NwSVwNfTYoUHviLcwaUDA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HH7M+vfI; arc=pass smtp.client-ip=74.125.224.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HH7M+vfI"
Received: by mail-yx1-f53.google.com with SMTP id 956f58d0204a3-6500eae6d2fso5374446d50.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 07 Apr 2026 10:44:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775583841; cv=none;
        d=google.com; s=arc-20240605;
        b=MsxF4sK3V/lkOa17jTpwYHnsGSIF1ZPe3p8dcmSqqx+R5ovyjtuJfrL5Xpj0dJiiAm
         C4xlcD1uJlqr7T7RGqw0UW1YQuKvj/8K7AILVGS7PgpDBgMCuKNSPwo31oEKcMDkMZRM
         nNAegAd9plpVpJaR+sIjcvJl5kty5COw+SXOyx9wqTZCXcgNsWVpnpb/sqoWkLZYCFXF
         wltsGyqtyWi04s1P7I3srzctc7hNcVqOqPu0SY3Gu1DxDhaGWICTOnsdcRwHfhKuYuCa
         6f+Eb66QaNeK10+NXvYH9xU3TR56jMKjogJZjqLxAd/YwxBGNPARTEWq4m275mVDIyqG
         difQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=x6iHHA26xfTQ6LQw11xLRWPayag2FtmyU87VP6OdH6s=;
        fh=NsrZmTZVGp5gkxQxe+t8K2A39ndGTXVe8SEpzApAKiU=;
        b=Ztj80Jsv+WgP5ATZxr1zj3MdKnU42RUUtBJEf4e/13KCBtNtKx0GRzlW0mSLHdNI43
         LmK4CGQJtJqA1oxzthhXSaWR7W+d6ATHk2FyzyGFlfkCSCn+/APRlpdZunmLkpHB8NUT
         epR8U/Z9tpyiNgJLAqhY/+ZhORfT3ycOJZhP48v0lqiUFvWZpL8eP1bXgx0mkAZyFjyY
         M0gLGNBTUJ+04uNlBFoo+LX04NzS0O2EMOxrMBAoojdI0KFGI7gvHiK9w7sg4/0a5Nc9
         hQTpHqC5vAgb5sv8bFoFjGOUhnFbqDyPwVuAk4YAj4EoRb016o76A3zfoqJS+z5Yeh64
         aWqg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775583841; x=1776188641; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=x6iHHA26xfTQ6LQw11xLRWPayag2FtmyU87VP6OdH6s=;
        b=HH7M+vfIPvHd4Y/dWGbDkbnTpd8lYnVY0NNRuTiITuvEAHcrJoGnzXzOdGJ27rUOTS
         +qgJVg6b5AUUVB5QtGMd1C7gTbONoKUQEk3ldw4QijP/DQCkIkXp6EO1/mo4lgV9OuSX
         5JxPBcQ6J0EyFU12A2YZmaFhYElsKoWmhhm0yj8FqtvuHvObgECCDPz5EDLuPv78qw8G
         sKjzJNj+rLdbrOvJMsrw6h+QV33x/XSZkiXpKwICWp4LPg9JfGPUqccQXwrIxDwRTg5a
         prD/FjkUMREGAu/cj1vUAD4sroI7iw/v5znboJViHYUrdyEiBGzgNHAyMMlQVU31YyvO
         9BVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775583841; x=1776188641;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=x6iHHA26xfTQ6LQw11xLRWPayag2FtmyU87VP6OdH6s=;
        b=QZyztXfv+xZyv+XxTD9yq4u5+82YHGo2G8DzounyPtrzD83cM9I4imTfgRQAA3VTrR
         sq7J0sJvzioErnlBjstM4fHAggih8uSWgsXybTSfqbajXFD/zy3SwEnb0aAl8WlaZpdI
         vei56FSMmipbT4Z+tGMdrJ+HjVZvmvucyZfSpPJ+7aN8b+fJWJPfvsGVuyCtOzDZdc3R
         bx7t2PjIZC0DHBW0zSp1D7cuJfEz0a5DgfjaKDcpRD2S+Uukns4APNxx3w6pT7krc/A0
         txzDw/vbzwvWhe6AaTRO0MFBNqO185EdIfyT99AmC2tuxwLYzSzOBPYIYk5yt9E6Qajp
         Sbuw==
X-Forwarded-Encrypted: i=1; AJvYcCX6dOu8XRfxLPTiNlxlw8iM8biGf6zMR4+aOOkYWMp4gDSTrhs3nbvma3iLJeL3khtX9goyZ84IAXqS0sDc@vger.kernel.org
X-Gm-Message-State: AOJu0YyX7YDg0GaiDNYeFifYFNsd7i+IXgXd2eC3DG61RJip/yZm4VM/
	rDB6X9xTRJqI2X2rWqv1vSaQOBDw4IcUzjW6EaGzPce9iNbpz8sT80MYmg35MlACkaSZavD9eAy
	1zXYRqIC799KBUT5ySj2cO1QY0TEcMJg=
X-Gm-Gg: AeBDieu4c4LelbwCPzJ+RXJzgOBvr3f1f93OKTXBGkhxX7VfgTNXK0DCV6mphYbs2et
	RTuoemVjQIFc5zcLaitiAhfClP8SJGEBEfUmDjk0PbzrzP+EVDCYUWefcjMllpi0pDpQXZQuHh0
	JfNBYAFIym6gCvMUfWb/bk8NqksAvdg3pqYB7oHaAe0FngIBkMBHV1k4M9lTvwixzB8ic68YonC
	mYqDCMgKXyZhMCZK2XeHPBeEuQzyWLDjKh5ErnrQnK25KZ7Aki7fLkqnU6zpdCVVzjPWVYOm3cS
	oRdUSioIL4nMtmaZ
X-Received: by 2002:a53:e8cc:0:b0:650:95e:2fc with SMTP id 956f58d0204a3-6504880fbb1mr13323007d50.40.1775583841177;
 Tue, 07 Apr 2026 10:44:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260225112439.27276-1-luis@igalia.com> <20260225112439.27276-7-luis@igalia.com>
In-Reply-To: <20260225112439.27276-7-luis@igalia.com>
From: Joanne Koong <joannelkoong@gmail.com>
Date: Tue, 7 Apr 2026 10:43:47 -0700
X-Gm-Features: AQROBzCj8WgteA4mdqDjQbIdRRTycn6e_gfWc8DjZJ1tVjTzwLTj7TaxcvCoDdg
Message-ID: <CAJnrk1Yxpy0+tx2yb7CxVVwF9gqNRz_pHH5NUpBHOg55NNooJA@mail.gmail.com>
Subject: Re: [RFC PATCH v3 6/8] fuse: implementation of lookup_handle+statx
 compound operation
To: Luis Henriques <luis@igalia.com>
Cc: Miklos Szeredi <miklos@szeredi.hu>, Amir Goldstein <amir73il@gmail.com>, 
	Bernd Schubert <bschubert@ddn.com>, Bernd Schubert <bernd@bsbernd.com>, 
	"Darrick J. Wong" <djwong@kernel.org>, Horst Birthelmer <hbirthelmer@ddn.com>, Kevin Chen <kchen@ddn.com>, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Matt Harvey <mharvey@jumptrading.com>, kernel-dev@igalia.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 25, 2026 at 3:25=E2=80=AFAM Luis Henriques <luis@igalia.com> wr=
ote:
>
> The implementation of lookup_handle+statx compound operation extends the
> lookup operation so that a file handle is be passed into the kernel.  It
> also needs to include an extra inarg, so that the parent directory file
> handle can be sent to user-space.  This extra inarg is added as an extens=
ion
> header to the request.
>
> By having a separate statx including in a compound operation allows the
> attr to be dropped from the lookup_handle request, simplifying the
> traditional FUSE lookup operation.
>
> Signed-off-by: Luis Henriques <luis@igalia.com>
> ---
>  fs/fuse/dir.c             | 294 +++++++++++++++++++++++++++++++++++---
>  fs/fuse/fuse_i.h          |  23 ++-
>  fs/fuse/inode.c           |  48 +++++--
>  fs/fuse/readdir.c         |   2 +-
>  include/uapi/linux/fuse.h |  23 ++-
>  5 files changed, 355 insertions(+), 35 deletions(-)
>
> diff --git a/include/uapi/linux/fuse.h b/include/uapi/linux/fuse.h
> index 113583c4efb6..89e6176abe25 100644
> --- a/include/uapi/linux/fuse.h
> +++ b/include/uapi/linux/fuse.h
>
>  enum fuse_opcode {
> @@ -671,6 +676,8 @@ enum fuse_opcode {
>          */
>         FUSE_COMPOUND           =3D 54,
>
> +       FUSE_LOOKUP_HANDLE      =3D 55,
> +
>         /* CUSE specific operations */
>         CUSE_INIT               =3D 4096,
>
> @@ -707,6 +714,20 @@ struct fuse_entry_out {
>         struct fuse_attr attr;
>  };
>
> +struct fuse_entry2_out {
> +       uint64_t        nodeid;
> +       uint64_t        generation;
> +       uint64_t        entry_valid;
> +       uint32_t        entry_valid_nsec;
> +       uint32_t        flags;
> +       uint64_t        spare;
> +};

Hi Luis,

Could you explain why we need a new struct fuse_entry2_out instead of
reusing struct fuse_entry_out? From what i see, the only differences
between them are that fuse_entry2_out drops attr_valid,
attr_valid_nsec, and struct fuse_attr. Is this done so that it saves
the ~100 bytes per lookup? Would it be cleaner from an abi perspective
to just reuse fuse_entry_out and ignore the attr fields if they're not
necessary? The reason I'm asking is because I'm looking at how you're
doing the lookup request reply to see if the fuse passthrough stuff
for metadata/directory operations can be combined with it. But I'm not
fully understanding why fuse_entry2_out is needed here.

I'm also a bit confused by why the compound with statx is needed here,
could you explain this part? I see the call to fuse_statx_to_attr()
after do_lookup_handle_statx(),  but fuse_statx_to_attr() converts the
statx reply right back to a struct fuse_attr for inode setup, so if
FUSE_LOOKUP_HANDLE returned struct fuse_entry_out instead of struct
fuse_entry2_out, doesn't this solve the problem of needing to compound
it with a statx or getattr request? I also noticed that the statx part
uses FUSE_ROOT_ID as a workaround for the node id because the actual
nodeid isn't known yet, this seems like another sign that the
attributes stuff should just be part of the lookup response itself
rather than a separate operation?

Thanks,
Joanne

> +
> +struct fuse_file_handle {
> +       uint16_t        size;
> +       uint8_t         handle[];
> +};
> +
>  struct fuse_forget_in {
>         uint64_t        nlookup;
>  };
