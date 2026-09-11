Received: from mail-qk2-f12.google.com (mail-qk2-f12.google.com [74.125.230.204])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 068A2352003
	for <linux-fsdevel@vger.kernel.org>; Fri, 11 Sep 2026 14:28:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.230.204
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789136908; cv=pass; b=BvDbTMbTsdysWQEC8mNwTOtijic7df7naewXgnzKtp5aPPqcymo/mxQXIc+54k8JHuGAKFFMkXfjQJ4x9GzaOEePfWwdcpGS3sjOzQefjujTOqZbw/S+NXW6LWMEjnrBxDIzg4h2evIuBlpgrRT6Hjoi87y+m/NqkTeJH/F5X6I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789136908; c=relaxed/simple;
	bh=OkVCJuwmBQSImGq06egfb3qFzategRQekOyDcs9IwJg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Tpo2l4kut/Dx1pO4CJfCn0MBK4HnLfP2ffKqRWj1M8/iTPvnm/qgm7EhDz7DtKaf0XL54kjfk7ibXvLPaUu+FrMehdSRQQXvOkTgudjm+wicgtzozfdzNmYqiqbEtJDMttCy0Dcy3Gecw/ruUOlZplgOgNw2wIumFwHEedlBe9Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=vr3A4TUu; arc=pass smtp.client-ip=74.125.230.204
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="vr3A4TUu"
Received: by mail-qk2-f12.google.com with SMTP id d75a77b69052e-530d5fc2cd8so137401cf.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 11 Sep 2026 07:28:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789136905; cv=none;
        d=google.com; s=arc-20260327;
        b=bctTmvv1JRwmhJ8p4BLle9h2t6svRIeIbuPzQNKJ7jTSMHZiwvb/2So/6pFo0GUQ+9
         OUC4dNYwVNbsvdENCKezxyJFS4Gqype0O9jy2yDGR25jQxBdvT/YHZiPh9Atk3LYnRIQ
         3RAp0Sev/MCwMk4ZT2vH26bihSdDHikS8geNE7tzwMzj/K/PrLh4teRupqhjCWsYWpQU
         SWIB+2TEFNkmnxCG9vAeTovusx92pBpGbV+WQ1+chi+eali8Wso8YvmFWNSIRCt46w5r
         CYnUqlFqW/CgK2kZhLLO/U5/jWgNnv/jPEzcGS6R4XYluc91cWHig5v0gwpvBZH0n9tC
         g4bg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=OkVCJuwmBQSImGq06egfb3qFzategRQekOyDcs9IwJg=;
        fh=nM83wnZ9IEbuqyZa/Z6g8Pf2QjIuPe4UqoyL2jzKEsk=;
        b=bfyTfW6YMNUPYQ3vUEZiOJPQWRZNBdPsRtLhIKkHQqHyWP5Uzb3uoIwBNS73CaZ2pi
         29JJqr9JG7az+VqJkVSSw4JL6hmkkEegInopiNY7+rd8+cwHHMnW+xJcjHX21Zp6PsgU
         xRvCpztYmrah2d5UDyxNQqBWm+4f25/TMqiC9ZwNtAZP3kbnjAlZRWzoY52UxihJ06fZ
         xudi0pMXxeJMb7X6j2wUkFI4IwqRjPeD/r3i8WjC0JYdCEhUxFaAgwctA2TLj3HKmM4e
         j4CsZzrh81AlqixdYrWIrZCuXqwPQZqELy25w/M7f86VJuVJilxjtQQS1MdrqLISq8Zy
         zYYQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1789136905; x=1789741705; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=OkVCJuwmBQSImGq06egfb3qFzategRQekOyDcs9IwJg=;
        b=vr3A4TUuJW14v/BgHVZDlExVXYmMmxWUj2TtswxQDiMIhsbFSE3WBj82CQvJiQnSBD
         exac/BK2DKiJ/Y90ysovwTjO6RU6HPU3SYqt+Chec3jTYOoeHnIPhtIelnvtf5Oenb17
         COD7G847fFDX0qlXSd/s/XMYQ3Xul9B9Y2MBmB6u/0QDWueMdAX82tNcaSAxNojH17Yr
         DzjDDcqPhwDy9Np7/YiGMl548bwzgasjizZzIDcLvZpKZUS3KB03JmTp4pPr/gRUATzl
         SnNiq71MS2jFCPwLRpkRzEE0258IVTPXvvbiPDRBAu7Ul4IXUj7MBpzoaIrxwEsMX8Dv
         7cRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789136905; x=1789741705;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=OkVCJuwmBQSImGq06egfb3qFzategRQekOyDcs9IwJg=;
        b=kdUvIOkYhWQrTEd300P0LcaIDrQpjgMfbA6ul5+0s77Zh7n+dYpXTGBE5vxAecGWGI
         wQA4L3ezAef9C8P6H8Sot7Njx4pt6IrMMbgChdXzPpFq0SjYLhFglpXrqAgyG4vduasb
         j7a0w7kVk6TIQTqbSThO6ogT6+P9jboFdbQHQ3TQtgc8puPowJErgyuyHofuFlfBvfQ0
         pcueNRsYlAvtbvVtHkGAMpVQpRod8c1yecO6fLBMbllVKTpb1e3PmTyQR3uPTyGj31Xa
         mD+Y6Yo+KfibMolYO5XVGCXdULsF5Zntb9JlOzi89EwWriCpMXPSO7OhTbUpWqLXPTu9
         2HZQ==
X-Forwarded-Encrypted: i=1; AKwUvBzhaF5fIeU9QOmXccQn8LS5BT1LYcPIWmhRqHTEpFavF2jSkswUWmEu54ushm/TPRuqqB3lNYarsZXcSODG@vger.kernel.org
X-Gm-Message-State: AFuF++kD4sMiyJ3krqDP4FYEbsvA2whPFAdxl5Pk81hZ8uoY2encqEiT
	nEZ+PiQ3f8agjbo/PtRJ3+T7SxPSRsG0qlpQuJlUOG8RMjYskU0Pebf/FgqYBDyo9PEePkBH5Vh
	FGYuYWPjaCc34ttv2aI73/L4zZHPcxyDeBrQHnbSa
X-Gm-Gg: AYBFou0XZfcUNbtMBBIP3TSUKy52gg2lhRA5zmNwMTQ7wWlufhCtH+mHDXyVbuPYGSi
	7kaZl5i0WnwKpwZTFVpNnQ6zNVe/jcv8fXwsniFF3qo8x2495E87wgywOvrobhIqu8LYxaE3Bhv
	ngvjhg5L+epC4qnSXAsBxggisxF4KLVqLiVXLTxYr9WNjjyzGsbpaTZuJ4VniJpJ+tFnUywD+QU
	O8Fkc9UvhelI1F/zJ2cCE9NC45yrGfa/NOxKIauTjZdIfFCPGf7Ayr4cf9qJw3TVHSzAl1gRHmS
	iZ9Xo9ds2BkW5xid+WQoId/6ZM0hoX92ox1FyO29KYZI9qSt0FfOpXU=
X-Received: by 2002:a05:622a:999:b0:530:5120:19da with SMTP id
 d75a77b69052e-530c93581c6mr18486911cf.2.1789136903951; Fri, 11 Sep 2026
 07:28:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260910234737.1340642-1-surenb@google.com> <20260910234737.1340642-2-surenb@google.com>
 <008dcaa3-2068-46e5-9e58-afb590d90584@kernel.org>
In-Reply-To: <008dcaa3-2068-46e5-9e58-afb590d90584@kernel.org>
From: Suren Baghdasaryan <surenb@google.com>
Date: Fri, 11 Sep 2026 07:28:13 -0700
X-Gm-Features: AcwNN1XuMz6tXlbjt5zzQkbqGbZOBrpxgwA9ACDwXzvAZXoq6Qjcyr7XzcP7kj4
Message-ID: <CAJuCfpF5CBrCxZWm+Luopf2gq_hHxsbw0QptNhfRT=+KjyWbJQ@mail.gmail.com>
Subject: Re: [PATCH v3 1/7] proc/task_mmu: remove unnecessary helpers
To: "David Hildenbrand (Arm)" <david@kernel.org>
Cc: akpm@linux-foundation.org, liam@infradead.org, ljs@kernel.org, 
	vbabka@kernel.org, willy@infradead.org, jannh@google.com, paulmck@kernel.org, 
	pfalcato@suse.de, xueyuan.chen21@gmail.com, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	Usama Arif <usama.arif@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 11, 2026 at 3:52=E2=80=AFAM David Hildenbrand (Arm)
<david@kernel.org> wrote:
>
> On 9/11/26 01:47, Suren Baghdasaryan wrote:
> > When per-vma locks were behind a config option, a number of helper
> > functions were needed to simplify the locking code. Now that these
> > locks are universally available, we can do a little cleanup.
> > Remove lock_vma_range(), unlock_vma_range(), query_vma_setup(),
> > query_vma_teardown() helpers.
> >
> > No functional change intended.
> >
> > Signed-off-by: Suren Baghdasaryan <surenb@google.com>
> > Reviewed-by: Liam R. Howlett (Oracle) <liam@infradead.org>
> > Reviewed-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>
> > Acked-by: Usama Arif <usama.arif@linux.dev>
> > Acked-by: David Hildenbrand (Arm) <david@kernel.org>
> > ---
>
> I think you CCed me only on this mail correctly (the other ones went to m=
y old
> RH address, I thought that one would bounce)

Oh, man! I used an old list of recipients :/
Should I resend to avoid bounces? So far I haven't seen any bounces
even from the previous version which also used the RH address.

>
> --
> Cheers,
>
> David
