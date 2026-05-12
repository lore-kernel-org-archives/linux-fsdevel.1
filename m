Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51066385D77
	for <linux-fsdevel@vger.kernel.org>; Tue, 12 May 2026 19:22:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778613765; cv=pass; b=Ddl7qx0WXNEXFVRPPd0ekbCHSDfcePV90OR5ugdvXkJsfNaOwYp27CrI0KkMZ7Nt+K0Hb0rxERbXCJyZS42TIOuj2IlrvOqbzQ2L8XsFXqlULAJOfd+soZqJAqkQtlMPLXU3qrkY51gxObrKzbHSnzoGF0H+gqg3IJkF7tBYous=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778613765; c=relaxed/simple;
	bh=VtrKsBqRgrQg5Z05GDQZPthjO+/OzETxg7+nkm/RnNA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KxMEzYvNNOT551o3whxvPaOE13O/UFhjqlRzM+UsLe4jK1wCVwqXNEK5Mcb3UYMVnVQAI/gFt6dS2qzL2b/hr6OPDxwHMAxPZbZkisNJlQ//1OJaDCRkjcI6bNJGNE1WZENMnnLqUV0Nxi6BsnV0HPvMOJ3SmQaQEf1i9oUDDOg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=j22Pzkvy; arc=pass smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j22Pzkvy"
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-48d146705b4so72137095e9.3
        for <linux-fsdevel@vger.kernel.org>; Tue, 12 May 2026 12:22:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778613763; cv=none;
        d=google.com; s=arc-20240605;
        b=e7t0ALOvRYlDhzSuaLmAuP+NSt/1rLptn9pDkyZTHewZ4SPi0pkuCJGTiGT5mhX2UW
         CS2tdpHzOyIIVV3Cc0Bi9ugtM/hgCAMOcj4cOYyQ+3dtjl89C9ZLtanW/NPjTeLNu2nb
         AK0M0Z5/6H6lWz1ENoKDl7ReM0HnOTPrFQyq5WnwCBKtjR+OccA4Vlv04uYAPmpnTuxo
         mUq5ywi5yAPprk69lP8ixCl/IekDNVlMllO+DGzvq+fz4ZiOwQTdlc4EpTluuhZ+aHt7
         Dd6FjXsj3fzDB8BeRAhNNywK3d3SRFv7SQke4mrYioAuahkfAuUr2qxLLZ16YlT7bTOa
         WKdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=KrksB7YyuGcL8UdLAV/lyg74rIhz+tVDke7Rs32Izbw=;
        fh=iBFInfgtOqHErb3p1wORuB1EeHSuUuRD/I+PnigndcU=;
        b=V3UE6m6TmuFFyDZb/7IbjnMbzAiOL5IhdmMrHfKUPH/PjYQZSDgyOjq+jm11cov15s
         vWGeb1XZp6zHOSkqCyUX7F24TqD9DESwVgwHWNhBN3mSFpdCjy9EfENTqilBdLOqxIuZ
         joIuC+iBeAGjYxffIgZ06HuYMq30qn1c46dAbwl2oNqcBZmVBS93yyHQL44+0bmPKeJs
         76pLOKo/HadffyyR3lxBeMMJ72vdtQg8PN+RKiYvHljTQyInvvKyngYAE+4ZHtqW4Kes
         phWYXxHK/jS3DLdkXuVlA995h83Jl9xPPsJBj6Vz2u1Y2KaVPP7x93Ig1/YB16XsQBEI
         lYkQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778613763; x=1779218563; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KrksB7YyuGcL8UdLAV/lyg74rIhz+tVDke7Rs32Izbw=;
        b=j22Pzkvyrb6Ti0js99OR7ykFuwLVn9VMn9XoyXWul9qh/wL3zLN6NQMyaXYbzjzl9W
         kb+8kNzVWyEaz9yZtTM3ygbxXY8BVqdQ0HaBBmW7viXBrwQVkjAtfT7JOQeCfDG7ooAe
         5KXBPN5Ppz76tTM04UomKdcb4ljmdyBQQ8Rm5oL0SEQOK4nkzuLfGNfrjlTkSON+nM/J
         orLahSA0TI1pNLh1YmIGhOV8g45C3yXxqaSPEQF+1wap0n8tqJBimrirYSl+xU+7OoGu
         T1VqnMxUp1NhE2RINKwu1saAxLXm+URcqs9BNxSR2mSSVEgkl35L7uGO1uXc7VILIUZN
         y/Zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778613763; x=1779218563;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=KrksB7YyuGcL8UdLAV/lyg74rIhz+tVDke7Rs32Izbw=;
        b=bWDy40GUE2Jf5wc8a42PgXqKw7fDSEuFlS2rFf2FtRY7xk/+vaK0o7rMGKs9hnHdpL
         OAtXrBgbEAc0lB7glVC+fuWUqjdxmNeBy2UVwayC65hp6tPVZ6K0fLbib8GGoeXa9ZNG
         VWGcOxQSOyB+nXV3ICHTLVDgfiHPnLzxenHwMer+x2rcFdcxQiFL/+yEfw999X+o2DmM
         Ygl2QlIVK5vEQvj6BeH11NUEmR93EeHosmYcxpVGL3jJFKTMA4N1hPtqWLg0YXCVAr4q
         onWQFa4wN1+dHGvhhlv89FFJfEbvaT4kLYXm4LTgJOjByZnN/81C+akrE7A/Ekjv0Sr8
         K0Ag==
X-Forwarded-Encrypted: i=1; AFNElJ9umyA82lyjwpZ3E9yRto2vj/vriEfZ3j8EpBUOu7yQuFcJeFPokJdNRse3SUdPywLqbDjlRM50rZudI6ON@vger.kernel.org
X-Gm-Message-State: AOJu0YzI2FDyuXWUzYCTusYfRa+jn4uYaYHTvWgW952j8RIYN1sATQzy
	9I1WYBp+H52Fq6DHgIw6aSWUPZObvQPSPSI3WQySx3z5siR1mY0mWx5f5/V6AQ4edn6yg0quyQ/
	ClCOQRgd/thgTpFF4yKxW1c6T1J0MmfU=
X-Gm-Gg: Acq92OEv7PFS4q7nBkmu88rQnGVEM6K1dqCbZE+mT2zGN7yzRI0wGbUFMftmlizpKV1
	zbemDw8UcipuC53hnUVVX/dmeZOYjyWXfdzVdS4yOWuVNcv5jC+oCzw8de2CrefQ3u6m3tbPKfV
	u1bROrFiRtkzW9WhE+yLzrCxqGneKLuGpUozYRtOiN01tg7HGe4FxaI4T5xZ0PTqvvI4ZaLYeve
	EzkAQeGdaceUAz+UePLs+WXQ4qj4eJqNs03YO5AJ/cOLLchzw6zAxG+NhxYrQHaCWEbHpzdVlfS
	0x+R9A==
X-Received: by 2002:a05:6000:2289:b0:43f:e99a:ff91 with SMTP id
 ffacd0b85a97d-45c5859f1famr171276f8f.4.1778613762530; Tue, 12 May 2026
 12:22:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260429102058.1362965-1-mszeredi@redhat.com> <CAJnrk1Z_JWtuA3UjucF9=YH63AH_-J_0hzr9jbY99Hx3O8YrAw@mail.gmail.com>
 <CAJfpegspraqMp1Z3mi_csiw6haawZPa4zWheSUN7MhBy47aYKQ@mail.gmail.com> <CAOQ4uxgV4_Pet0w3f+Sq4kLkvgKM6FyJwZ4AQsnvctC3w=dP6g@mail.gmail.com>
In-Reply-To: <CAOQ4uxgV4_Pet0w3f+Sq4kLkvgKM6FyJwZ4AQsnvctC3w=dP6g@mail.gmail.com>
From: Joanne Koong <joannelkoong@gmail.com>
Date: Tue, 12 May 2026 12:22:30 -0700
X-Gm-Features: AVHnY4I0Y3BrmLWelt6oDqQj0GcnCVMfHGqh6xLzugs-tH2pa1VNyILa-YgX3n0
Message-ID: <CAJnrk1ZvB-R3Szn-VxOZvPRgX_dXwMLouBphnT9_URCE8SxTvQ@mail.gmail.com>
Subject: Re: [PATCH] fuse: add fusex filesystem
To: Amir Goldstein <amir73il@gmail.com>
Cc: Miklos Szeredi <miklos@szeredi.hu>, Miklos Szeredi <mszeredi@redhat.com>, fuse-devel@lists.linux.dev, 
	linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 12, 2026 at 6:22=E2=80=AFAM Amir Goldstein <amir73il@gmail.com>=
 wrote:
>
> On Tue, May 12, 2026 at 11:31=E2=80=AFAM Miklos Szeredi <miklos@szeredi.h=
u> wrote:
> >
> > > * in passthrough: backing_fd passed at lookup/creation time only (not
> > > at open time), expanded struct fuse_backing_map
> >
> > Yes, this needs discussion.  Amir may have additional info on this.
> >
>
> Having the two different lifecycles (open-to-close, lookup-to-forget)
> is by design.
>
> This allows the server to potentially move files from passthrough mode
> to caching mode and vice versa, as long as all fds are closed.

I'm unsure how useful mode switching is between caching and
passthrough because the server has no control over when the client
application closes all its fds (eg it can only react but not trigger
it). For my internal use case of switching on passthrough, I was
envisioning the server handling everything through direct io until
passthrough is possible (eg the remote file has been fully downloaded
over the network) so that passthrough can be switched on even with the
application having open fds.

>
> Adding inode passthrough ops does not play well with this mode
> this is why it requires the lookup-to-forget lifecycle, but I see no reas=
on
> kill the open-to-close lifecycle as it seems useful for servers that
> mostly care about I/O passthrough.
>
> w.r.t expanded struct fuse_backing_map, at the moment it does not
> sound right to me to map a backing id X with more than a single backing
> file or device.

My thinking with the struct fuse_backing_map expansion was that future
ioctls for managing backing files (eg attaching a backing file to a
live inode or swapping one backing file for another) might benefit
from a shared struct instead of needing to add new structs for each
type.

>
> I think that the maps of fuse_file to multiple fuse_backing is better
> handled by another layer of mapping (sort of a backing_mapper)
> which is what famfs and iomap need, but it is just my initial thoughts.

I like this idea a lot, it makes sense to me.

>
>  Joanne, if you are a concrete use case for that, let's try to see
> how a design to this use case may look like.

The internal team I'm working with is planning to start working on
their server in H2. They will run some benchmarks to see if current
passthrough and/or io-uring+zero-copy might get them the performance
gains they need, or whether they will still need the set of advanced
passthrough features they requested. I'll keep you posted once there's
performance data and if there is still a need for the more advanced
passthrough features (file mapping to multiple backing files, backing
files dynamically changing, enabling passthrough on a live inode),
I'll draft up a design doc to get your thoughts on. In the meantime,
I'm planning to send out v2 of the inode metadata passthrough patchset
sometime this week or next with your feedback from v1.

Thanks,
Joanne

>
> Thanks,
> Amir.
