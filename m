Received: from va-1-114.ptr.blmpb.com (va-1-114.ptr.blmpb.com [209.127.230.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE7D33FE367
	for <linux-fsdevel@vger.kernel.org>; Mon, 29 Jun 2026 12:16:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.127.230.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782735373; cv=none; b=GGMSkPnDDRGVhonSkNGGnuJHRSuJnJCTnTljmrCA9YQeK6o2z9c1F6NZ70kQ0Z/hG0Px9yBLIRQ/3xh207voZW7pGWrgIaZOjpjlDSsQBa24IRhDJqcSJOkwFn9W9mPSh67+QauTJRZff9myGVcDYFD56A0Mm/J5RwUxPJq/iZ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782735373; c=relaxed/simple;
	bh=TbUVZuA/SCu0yTZ0KrGtcaVszMM9K5uM6HRc0m9imho=;
	h=Date:Message-Id:Content-Type:To:Mime-Version:From:In-Reply-To:Cc:
	 Subject:References; b=nAiBOgzXlxxM+knNiBbXV4MFILQWy0x+YCjHz4yL011vOaJn9s92Td4wHK6lc0eiWgSYOKd5K3OWuZYPRE3uY5fDTJsxM8aHypefmFYe/AKmi440iKG48JViPpKPwZThucBDDCSb84BJmfPyWlcV+PR5GGYfghUn8AIX4u55TKw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=lQERgKX+; arc=none smtp.client-ip=209.127.230.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="lQERgKX+"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=2212171451; d=bytedance.com; t=1782735366; h=from:subject:
 mime-version:from:date:message-id:subject:to:cc:reply-to:content-type:
 mime-version:in-reply-to:message-id;
 bh=59oe9MSbaFR9G77NSs6MIbFSg3wXOoWsd8NTCEqjIFw=;
 b=lQERgKX+NJmRCxgeK2Oe4xyk2lYlKScyN0ShLP2yy7yU+5ua1pxLXt/AyU+/UX4P4oFZcr
 +/CUoYp32PrxFAIdR/0Lu5X/xTtvo2x5RiJqWSy9PNhRGKTLcURckQ8KSZlATb5ZjroIzR
 b5uHzsJ9kvWUcfrus27CNlnNb/6Mj6KsfYRx3km2hM9p04STQpNzcOAJSzC8lEYPuUfUHq
 umuUZEmZPE/2OEIk+NrAxNLiJrGZ9jkVgQqHVIU2Wh+dq5K4t2gGWL0en3jf+Ckr9xLTch
 UVEqy+eT2EsW9APYrvp+crDaWcyubt8O8jL2N0X/FrzCID30ShevOrKY2krtzA==
Date: Mon, 29 Jun 2026 20:15:51 +0800
Message-Id: <e85e73bd-5fbe-4d11-89ba-7b42c237dd34@bytedance.com>
User-Agent: Mozilla Thunderbird
X-Lms-Return-Path: <lba+26a426204+5dfd2e+vger.kernel.org+changfengnan@bytedance.com>
X-Original-From: Fengnan <changfengnan@bytedance.com>
Content-Type: text/plain; charset=UTF-8
To: "Joanne Koong" <joannelkoong@gmail.com>, 
	"Christoph Hellwig" <hch@lst.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
From: "Fengnan" <changfengnan@bytedance.com>
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <CAJnrk1Z=o701G_gNFM2MNaQPN9_vFCxfK3FvKSjz6pf1Qwj-YA@mail.gmail.com>
Cc: <willy@infradead.org>, <djwong@kernel.org>, 
	<linux-fsdevel@vger.kernel.org>, <linux-xfs@vger.kernel.org>
Subject: Re: [RFC PATCH v1 3/3] xfs: example of devirtualizing buffered write iomap callbacks
References: <20260625024723.1611000-1-joannelkoong@gmail.com> <20260625024723.1611000-4-joannelkoong@gmail.com> <20260625130052.GB22620@lst.de> <CAJnrk1Z=o701G_gNFM2MNaQPN9_vFCxfK3FvKSjz6pf1Qwj-YA@mail.gmail.com>

=E5=9C=A8 2026/6/26 04:46, Joanne Koong =E5=86=99=E9=81=93:
> On Thu, Jun 25, 2026 at 6:00=E2=80=AFAM Christoph Hellwig <hch@lst.de> wr=
ote:
>> On Wed, Jun 24, 2026 at 07:47:23PM -0700, Joanne Koong wrote:
>>> This is an example of what removing the indirect call would look like.
>>> With the inlined iomap_buffered_write_inline() that gets passed
>>> xfs_buffered_write_iomap_begin() and xfs_buffered_write_iomap_end() as
>>> constant callbacks, the compiler is able to call the callbacks directly
>>> and drop the indirect call through struct iomap_ops:
>> Nice.  Btw, a more critical path would be direct I/O.
>>
>> Fengnan, maybe you can play around with this series and your direct read
>> fast path?

First, a brief update on my progress: I modified |iomap_dio_rw| so that=20
the XFS direct

I/O read path can support |iomap_next| mode, and ran 4K random read=20
performance tests.

Using the performance with both |iomap_next| and simple read disabled as=20
the baseline,

enabling only |iomap_next| improved performance by 1.6%; enabling only=20
simple read

improved performance by 7.3%; enabling both |iomap_next| and simple read

improved performance by 8.8%.

In non-|iomap_next| mode, |simple read| improves performance by about 10%.
After enabling |iomap_next|, the gain drops somewhat. The changes needed=20
to make
|iomap_dio_rw| support |iomap_next| are relatively large, so there may=20
be issues in my
current modification. I am still investigating why.
>>
>>> +     /*
>>> +      * Call inlined iomap buffered write and pass constant begin/end
>>> +      * function pointers so the compiler can devirtualize them and av=
oid the
>>> +      * indirect call through struct iomap_ops.
>>> +      */
>>> +     iter =3D (struct iomap_iter){
>>> +             .inode          =3D inode,
>>> +             .pos            =3D iocb->ki_pos,
>>> +             .len            =3D iov_iter_count(from),
>>> +             .flags          =3D IOMAP_WRITE,
>>> +     };
>>> +     if (iocb->ki_flags & IOCB_NOWAIT)
>>> +             iter.flags |=3D IOMAP_NOWAIT;
>>> +     if (iocb->ki_flags & IOCB_DONTCACHE)
>>> +             iter.flags |=3D IOMAP_DONTCACHE;
>> We'll probably want a helper for this initializion boilerplate.
>> Or make it part of iomap_buffered_write_inline somehow?
>>
>>> +     ret =3D iomap_buffered_write_inline(&iter, from,
>>> +                     xfs_buffered_write_iomap_begin,
>>> +                     xfs_buffered_write_iomap_end,
>> So we're not even doing the _next scheme here and already get
>> results, nice!
>>
>>> +     if (ret > 0)
>>> +             iocb->ki_pos =3D iter.pos;
>> Similarly here, it would be great if we could somehow avoid
>> too much boilerplate.
>>
> Agreed, I think this can all just be moved into
> iomap_buffered_write_inline() and then the call would just be:
>
>    ret =3D iomap_buffered_write_inline(iocb, from,
>                  xfs_buffered_write_iomap_begin, xfs_buffered_write_iomap=
_end,
>                  &xfs_iomap_write_ops, NULL);
>
> I'll clean this up for v2.
>
> Thanks,
> Joanne
