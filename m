Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3838348F841
	for <linux-fsdevel@vger.kernel.org>; Wed, 19 Aug 2026 17:24:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.215.182
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787160298; cv=pass; b=WqTYRyj6C2HAsSThVXfnCh/RzuAfXFAYIy+iOiRg3CURIoXyeK9i713JYJTi5DiGZzl2swgddThCAwBDgwHUpJU8Hze7eEISz8qwPZDq881pSVts0qL2Eazez5KOe3mMXlLfJhvG1+Q7USNjYnUjP/2D/pRhTpLKG7hLC9JNiNY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787160298; c=relaxed/simple;
	bh=x2315l0HX26F0q2RsoAivd6Rb//tCuIU+qZjABFUpwI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fRV7kdQyZ4VN5Q/zKrmkfeOjWTKc0pdzzs+zuhd4Mu3l8KpFSaOYTEYpr1TefSWx86XdQ7CFbr32ZeG8Km4qnpjf5fWCpdeiQQHh5yVo0Au1oyc3zks2xNrN07vt979eUbK6lzjZb5/5swPIJKeUBpkQYyNTtHTgKm0FfrsXMlo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=f1/ndzPu; arc=pass smtp.client-ip=209.85.215.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f1/ndzPu"
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-cbe6295f05bso70274a12.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 19 Aug 2026 10:24:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787160280; cv=none;
        d=google.com; s=arc-20260327;
        b=dW75wTvTzSRw20/0TweUTv+mXzHwctV0nT+e07lxO8NZYMv3CRKHfVg0wZwZL9dYZB
         ipeFEvSWwEQ4Wbqr/DZQcuqU7qq35IdbU6UWXnM2PNpDEope2+fQQQ9USOqn5b+1pXAi
         pZm9vztSPXCSWCbuWJxs15xS1vmjFD9Ou0ksH4MKzBUqefHtKcSjiwHf1i4Sci1oOzrA
         fMJZwvGhwbbSMokjONKjJ1NQLVDPShBaojo/DFDuQYpTrRR1HRri11S4wlX9GUVZH65j
         LtJgRZ0mgAG/5K+5xwfKwxV3j6ZXvgIDk5BhQX6QvrH2c7ZNUEBoLNK244yE7wQ7BcqB
         E/SA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=/s3DFDu7mQUXNF0KqwtrJ+MXPopmdruNjqo6IWXh1qo=;
        fh=rOFJWrA0JOlwvVDDGhT9uXb/1uj0MwjYwN7p/MrPPQM=;
        b=GCzOzpYwCxJxwDvTVj2vaaxK250vjm84jpbZZXkdjDZudbhhQQdGNRlZBdahC05Ygl
         eeFNNrGNCKJM00ofUSsV0a0ntnR9Q6HLk2Gq45JOA8EnSV+kOdD1ZmEdfp6eaULWd+XB
         +EfuZELBYPC++o4/zyt6U+Pfu4c78MERJ+m0oOkQmoS5j7kJPrr9VC6nRzjo1G9OzSQj
         csQ6vaRzhV62ki6lQmhrJX+x7OktjtvqUFDgxzT2YoFAoBz04Poy+fbziTeDI9ZkwjpU
         0RzBOW1sbc0GGysMSLNpaWyPBBZfOFb6gsjiXnmTMK61utUx5e/lFocDHWAQKexCs7Ny
         /tkw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787160280; x=1787765080; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=/s3DFDu7mQUXNF0KqwtrJ+MXPopmdruNjqo6IWXh1qo=;
        b=f1/ndzPuVcMypBBW+/p6xd87pNq2pWwwoeTfEsaNG2cl41gQ4ts6NC21oxdI5SkMS5
         M9kQ3cq7EkiEvg8Xyt06txzqb1aDLLvs0vCygOmXa4NyuxuC3NcIvA2R3T8Ar+Ep/6L/
         cjML7Pqc44ABW64XY3ukPgGwbWdVZRdN8I3Gejd/VwbNWZmTbRMvUNW01uZBDWSsJ/VQ
         dDdAgi3paTg9vPFdVGrtsCSqPdrzjVYv/AvPWUTM8bWRS7bUOKbOdILQEtPD6loPjIwh
         PGtyN0m+fr/azOrytQUC5frd3Ovsr/kgI4x7sVxXTwguv5eKbDwDHHgBv1vWfPUMpV6W
         CF8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787160280; x=1787765080;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=/s3DFDu7mQUXNF0KqwtrJ+MXPopmdruNjqo6IWXh1qo=;
        b=FUHfpygoATGYH3EP+0NO7aNfbKiC5913WrsaKEnHzAHMGiMwbUjFHktnPr6jI+oqz8
         SH5REL/uPGqPFjASwBDOl8J6xE7gctksqiUr0dF3OL9bvaF6AdVa3nEvQB1byUERNeSa
         dk7i4NbRD+5LRE8IVJJgXFe5QweMZuDy65oTJhA1iq0fZtCTqqVqAfYR1q95+pQvQSR3
         QadyNo5tYbIFQ1tZUIfzfntfHfUsd5ZeJN7iRk9/MPwOzhNKV/JM/L/aQsU5RmgmFwgP
         3n5hpLrLVvXi8dpF1TryQvwdy5Dl8SbELuYv1sqcRGMfDePn+M8V+/TQJXmyMkr6/tgN
         4+Cg==
X-Forwarded-Encrypted: i=1; AHgh+Rq5AV9tC2h2Ww/TPwUY94LtrY+l+QkZE4vKvO6trPdRoH9yFAXIN/F93HgrNLa+dC7tfdNezky0iPlrjNXC@vger.kernel.org
X-Gm-Message-State: AFuF++nDMiVNDLzZEN87q+K2PCvdkhvDbItzGUwpYi1f6xeBFS5ZtpoO
	tCBWsmm7Jqo5sowjluobKvZ9g4qCKdAlxl+Dk6JUNcxhl6D/M2USTUodBSuR8aFhI0Wb5zPHCfw
	fbgWY9rt862vkOzg05MPxSt3jeytsobY=
X-Gm-Gg: AR+sD11ANgGK/t7Rz7lP0e/epvigrMXDD6TT4qGHhCwwihX6xEm8lYrQTu/wCFTq9LN
	Lolt3gGbTHj33ykOhx7PslArX3bu+7hsY56AOk70zRnUd8JTGMK3JvrzSbkQxIeiTtLLrDvXIhn
	LMdv/HXhbcZIbhYa7wrpPeLHoTwJMP1ltvy/mM5fBQyIC0eeW5ue62907Cmmy/PFn9r6Sms2UAP
	QBIx4Ny5+b6o6Pq9fT4+ccKGu+jO3/Eysji0k+ILqNLA95qzTWSJ/OMx0XFelpBrg7OUUG3KJgk
	RZOZI/pxoG+wfYGvklqURWmoDjjAriR1sxCHThyiHSf8ZZoIx6JFSWFR2q53YndvuFTirtIw+fl
	cJGD/+hFKeRwjTcutj8SE+TnivA==
X-Received: by 2002:a17:90b:5104:b0:38e:c232:9d2c with SMTP id
 98e67ed59e1d1-395a04e3ff5mr731754a91.2.1787160280176; Wed, 19 Aug 2026
 10:24:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260815091819.3651099-1-gaoxiang17@xiaomi.com>
 <04f3ce2f-67f5-4829-9551-a69b9df29854@kernel.org> <CAEf4BzbwZkoacX-iP1j4+p8YNbWsq0pc3eTermh2uT5ir66zbw@mail.gmail.com>
 <8d2e20842c24460296e4c83e6dc0dde3@xiaomi.com>
In-Reply-To: <8d2e20842c24460296e4c83e6dc0dde3@xiaomi.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Wed, 19 Aug 2026 10:24:28 -0700
X-Gm-Features: AcwNN1V5XFvKw71PEM0biAs1oBlMlI9-0UtGl8hho5Gay8JpXC3-FqvpvbkLZuc
Message-ID: <CAEf4BzYQvhSVN=Hggg5FHzFdkRr4UNBD6yXaBsOaAwbsRpXpsw@mail.gmail.com>
Subject: Re: [External Mail]Re: [RFC] bpf: account ring buffer backing pages
 separately from Lost RAM
To: =?UTF-8?B?6auY57+U?= <gaoxiang17@xiaomi.com>
Cc: "David Hildenbrand (Arm)" <david@kernel.org>, Xiang Gao <gxxa03070307@gmail.com>, 
	Andrii Nakryiko <andrii@kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrew Morton <akpm@linux-foundation.org>, 
	=?UTF-8?B?5Y2w6Zev?= <yinchuang1@xiaomi.com>, 
	"bpf@vger.kernel.org" <bpf@vger.kernel.org>, "linux-mm@kvack.org" <linux-mm@kvack.org>, 
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Lorenzo Stoakes (Arm)" <ljs@kernel.org>, 
	Steven Rostedt <rostedt@goodmis.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 18, 2026 at 6:46=E2=80=AFAM =E9=AB=98=E7=BF=94 <gaoxiang17@xiao=
mi.com> wrote:
>
> Thanks for the pointer. Understood =E2=80=94 no new NR_* counter or
> /proc/meminfo entry.
>
>
> The remaining question is on the consumer side: Android's Lost RAM
> accounting would need to enumerate all live BPF ringbuf maps
> (BPF_MAP_GET_NEXT_ID) and read each map's fdinfo memlock to sum them.
>

For BPF ringbufs specifically, you should be fine just iterating all
map with BPF_MAP_GET_NEXT_ID, getting its FD with
BPF_BTF_GET_FD_BY_ID, and then passing that fd to
BPF_OBJ_GET_INFO_BY_FD to get map's size.

>
> Is per-map fdinfo enumeration the intended way for userspace to get the
> aggregate, or is there a more efficient BPF-specific aggregate interface
> that I'm missing?
>



>
> ________________________________
> =E5=8F=91=E4=BB=B6=E4=BA=BA: Andrii Nakryiko <andrii.nakryiko@gmail.com>
> =E5=8F=91=E9=80=81=E6=97=B6=E9=97=B4: 2026=E5=B9=B48=E6=9C=8818=E6=97=A5 =
2:22:07
> =E6=94=B6=E4=BB=B6=E4=BA=BA: David Hildenbrand (Arm)
> =E6=8A=84=E9=80=81: Xiang Gao; Andrii Nakryiko; Alexei Starovoitov; Danie=
l Borkmann; Andrew Morton; =E5=8D=B0=E9=97=AF; bpf@vger.kernel.org; linux-m=
m@kvack.org; linux-fsdevel@vger.kernel.org; linux-kernel@vger.kernel.org; =
=E9=AB=98=E7=BF=94; Lorenzo Stoakes (Arm); Steven Rostedt
> =E4=B8=BB=E9=A2=98: [External Mail]Re: [RFC] bpf: account ring buffer bac=
king pages separately from Lost RAM
>
> [=E5=A4=96=E9=83=A8=E9=82=AE=E4=BB=B6] =E6=AD=A4=E9=82=AE=E4=BB=B6=E6=9D=
=A5=E6=BA=90=E4=BA=8E=E5=B0=8F=E7=B1=B3=E5=85=AC=E5=8F=B8=E5=A4=96=E9=83=A8=
=EF=BC=8C=E8=AF=B7=E8=B0=A8=E6=85=8E=E5=A4=84=E7=90=86=E3=80=82=E8=8B=A5=E5=
=AF=B9=E9=82=AE=E4=BB=B6=E5=AE=89=E5=85=A8=E6=80=A7=E5=AD=98=E7=96=91=EF=BC=
=8C=E8=AF=B7=E5=B0=86=E9=82=AE=E4=BB=B6=E8=BD=AC=E5=8F=91=E7=BB=99misec@xia=
omi.com=E8=BF=9B=E8=A1=8C=E5=8F=8D=E9=A6=88
>
> On Mon, Aug 17, 2026 at 11:10=E2=80=AFAM David Hildenbrand (Arm)
> <david@kernel.org> wrote:
> >
> > On 8/15/26 11:18, Xiang Gao wrote:
> > > Hi,
> >
> > Hi,
> >
> > >
> > > I would like to discuss accounting BPF ring buffer backing pages in
> > > system-wide memory reports.
> > >
> > > BPF ring buffers allocate their data and metadata as order-0 pages di=
rectly
> > > from the buddy allocator, and then map those pages with vmap().
> >
> > I assume there is a reason the slab isn't used, right? Are these pages =
mapped
> > into user space such that page->mapcount would get used?
> >
> > Can you point me at relevant code?
>
> See code in [0]. And yes, these pages are meant to be mapped into user sp=
ace.
>
>   [0] https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next.git/tr=
ee/kernel/bpf/ringbuf.c#n93
>
> >
> > >
> > > Because vmap() maps caller-owned pages, these backing pages are not c=
ounted
> > > by VmallocUsed. They are also not slab pages. As a result, most BPF r=
ing
> > > buffer memory is not represented by an existing named /proc/meminfo c=
ategory
> > > and appears as Lost RAM in Android memory reports.
> > >
> > > We measured this on an Android 6.18 kernel.
> > >
> > > Test case:
> > >
> > >   32 BPF ring buffer maps
> > >   16 MiB data area per map
> > >   512 MiB total data area
> > >
> > > Observed changes:
> > >
> > >   Lost RAM:       approximately +529 MiB
> > >   VmallocUsed:      approximately +2 MiB
> > >   Slab:        approximately unchanged
> > >
> > > After destroying all maps, the values returned close to baseline.
> > >
> > > The question is whether the kernel should expose the unique physical =
backing
> > > pages of live BPF ring buffers through a dedicated global counter and=
 a
> > > /proc/meminfo entry, for example:
> > >
> > >   BpfRingbuf: <value in kB>
> >
> > This looks a bit too specific for my taste. And I think we should try t=
o no
> > inflate these statistics here too much.
> >
>
> +1, way too specific
>
> > >
> > > The proposed counter would include:
> > >
> > >   * ring buffer data pages;
> > >   * metadata pages;
> > >   * consumer and producer position pages.
> > >
> > > It would exclude:
> > >
> > >   * the second virtual mapping of data pages;
> > >   * the pages[] pointer array;
> > >   * map metadata allocations;
> > >   * vmap page tables.
> > >
> > > The goal is to account for the currently unclassified direct backing =
pages.
> > > Slab- and vmalloc-backed auxiliary allocations are already represente=
d by
> > > existing memory categories and should not be counted again.
> > >
> > > A possible implementation is an NR_BPF_RINGBUF vmstat counter maintai=
ned by
> > > the ring buffer allocation and free paths, with the aggregate exposed=
 through
> > > /proc/meminfo.
> > >
> > > Questions:
> > >
> > > 1. Is a dedicated BPF ring buffer counter appropriate?
> >
> > I don't think so.
> >
> > See [1] where we just had the same discussion for tracing buffers. For =
them,
> > Steve [2] had an idea on how to expose them more fine-grained and traci=
ng specific.
> >
> > [1] https://lore.kernel.org/r/20260810094025.136705-1-gaoxiang17@xiaomi=
.com
> > [2] https://lore.kernel.org/r/20260810105710.6ee5e493@gandalf.local.hom=
e
> >
>
> We already report per-BPF ringbuf memory usage either through bpf()
> syscall or map's fdinfo. E.g., with `sudo bpftool map show` you'll
> see"
>
> 1455733: ringbuf  name event_ringbuf  flags 0x0
>         key 0B  value 0B  max_entries 262144  memlock 275776B
>         btf_id 2193434
>         pids tcpeventd(2549812)
>
> where memlock is how much memory is allocated for the ringbuf data area.
>
> > > 2. Should this be represented as an NR_* vmstat counter?
> >
> > I don't think so.
> >
> > > 3. Is /proc/meminfo an acceptable interface for this information?
> >
> > Again, I don't think so. "Lost RAM" really is just "excessive memory al=
located
> > by some other subsystem".
> >
> > I agree that some users might want to figure out what is consuming that=
 much
> > memory, but I don't think growing /proc/meminfo in that way is really w=
hat we want.
> >
> > > 4. Is counting only unique physical backing pages the correct account=
ing unit?
> >
> > I'd assume the "It would exclude" part above should not be accounted th=
ere, if
> > that's what you mean.
> >
> > --
> > Cheers,
> >
> > David
