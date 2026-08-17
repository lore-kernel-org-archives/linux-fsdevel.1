Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47CB64314AC
	for <linux-fsdevel@vger.kernel.org>; Mon, 17 Aug 2026 18:22:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.182
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786990949; cv=pass; b=B58svM71IPxDINQeRIgHH+eYNxYgIH7Gra5OYKH2WCpR8zE6Zd6lEDuNZJ/iZ9z4ZVewGFMMQfflrQfTpeSE+pudA5VLxd402gI7/nVsUDYOre0mKRhlzeoD5wTbU+eWWaG51UZvplxbPUFmtKcng/PzEPRB4PAF4V57XzwKl1c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786990949; c=relaxed/simple;
	bh=C8eL0RXUqd+z/87h6pbMWRZbWxcVYzCNN4whWihuau0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Gts46+WDw3giy+EyYWJ1vlVpL0A88zX5dcBVBCnvSAk2GOuDBEMMCXmXiT08d8ErIxzKDfmcWmnDI60GCxwYveTndPJGF9vv2t6ZibXaZ5NMxf/QOQcf+/fxzNyDClFJyNxdbuHfb+wabOsEr07Vht7eH85uOJj94LNgTCp8Xko=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=pxTp3xpc; arc=pass smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pxTp3xpc"
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-84faf0fa17eso3789165b3a.2
        for <linux-fsdevel@vger.kernel.org>; Mon, 17 Aug 2026 11:22:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786990943; cv=none;
        d=google.com; s=arc-20260327;
        b=W9DWT75cUSvrluJHGEsYK2C1Wd3W1fqVIWbCA/ECx/GCL9jAQFFZ4tDUjgMao4yb5z
         avzMXxz94TtmnfTKsMXTKYvLqdTqicLsx2J4X6s8IjDQwbKZ04WsrmzoC1uLHSNqmaGi
         RaHFP00HHLO8yn8iFnZQ7oofpCvH8+dr8w2l+BsZj/ed+lZBVPjZZpCvcDLRs6doAQyZ
         MmUyLUWoF4xgZIzAoVTuDKAabYUfPIH9PgeETwqabHM6F1mM8VdVC+tbdYiqwCPtdkmr
         trN/ujNVKvBtGWrdEFI2biCDA4nyZV+vtq3t5j6RiGVdGeqAulNaAOQyciJE7CHX+brL
         B9dw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=LxYwqYOrD411oJvKVf7MSl5O4yE/v1cgNQc8LyxR9SI=;
        fh=Zgd5HsoQSrJD1bsl4vN0TvYm0Lj7ven8eKHTu1+83jY=;
        b=pie5+AxGgUgX7H+BssyQ4O++85jSMLS3y7DQeY4w5jHP//Abc7FwQhePD0wUnog1FQ
         xlW+g40kYTSxSMs4o9/JUPguOCASjd2xVrQ8GXQ9jB3BXRv+FttkUfOObJy4+f0jMtgu
         n8W6QPuXjsa1+JHykMYGI9k1YH+naYBqoxMv4nOL9ue8mmRVygjYlCpMuxNIypGwTZIU
         zFtW5CVufZ23EbkGmLbqGEHUFTQeJWikuSC6p7rMo0BgTnWCqz9z5ebod2n5K9ysJFM/
         CUVI5rx1XZdx6cx8/gm61Pl0ew1rQ+8tHO36TDMqb49L8yYBCFXIXsc1ha4kz7B/q3cL
         /Z7Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786990943; x=1787595743; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=LxYwqYOrD411oJvKVf7MSl5O4yE/v1cgNQc8LyxR9SI=;
        b=pxTp3xpcRRwAAYWMoaX073/GbevAANKDrvDyppPn6Nm727yH0fa6q8ECO154D4mst5
         t6BZ+8ZkAtfnH8c8dLCg2HrybqE/741z0/pK6acsbb+oUrZX7pxSk3PvqzWA4wXJSHmZ
         s3njRLpVqydgjv3KdiEoS3d5jz2T97ih1wMxyRIePss4XKaTicxeJIg8jT6T3TkUYES7
         FAV4LIchVxgw9VjOmZrskjTmMhetaVcRcQJMyh7YP4WYAeZUf3oy14WhTTsw/wUNof47
         mlVaeKRsmrycVN06if48ejZAvqteSWEPpA7CoMW5v1/8RjCbeH/YoJxofNcD7pP5Fp7v
         QCDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786990943; x=1787595743;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=LxYwqYOrD411oJvKVf7MSl5O4yE/v1cgNQc8LyxR9SI=;
        b=DOZmIc9l0SGOdJf1RQTUptaEyfoGm/nzQieWK/yT8GSPqoayl3DEjGmaNtC5P9UihJ
         zjBv9qi9okaxVWdlx5uPfVVIbEElokN+3xi5NRD4AjgmrOiw9+QDWDf50FcvyAkdP5YX
         hfxvNFOK/2WZuOCxuP1AVntT5XD5Q5SeyJ2tp6FzwIPjdK/JTdi5nx+4xUafn8ecyLqi
         H9WnSJPYEnEkXaPTHVbZ18hwu3gq8/3RexAWEDCT/lGyvkDdQKLEFsnC6+ZW7yigReVB
         rMEYaQQ5rmQxrMx++Z0boVonAdKOpHj6o4X2sBzGadp+uzI+Izf6z7edz484EdDDaVcI
         eBjQ==
X-Forwarded-Encrypted: i=1; AHgh+Rqt7IGg+nI45oolJBJLOQwDnolAtm/6jEYMLvGmaIddLBOO3llT4yCKRwGo3RqbVUVV12Oo4zYr4AW7IxEd@vger.kernel.org
X-Gm-Message-State: AOJu0Yx34IH0MQxj18V8rvM+rxH8otbpYW7tBr6hoxbCU0uzUojr95SP
	jxBY8kxp5Wu8q9TGtQWAYpbPk6hBC8KFeUapSQJKMN3oCWJkBaRWAZ835Sw5J83iEmhzCUG3MzA
	oXzOtuv7hR5U0StCMoPt+Iu3ExrX8oTA=
X-Gm-Gg: AR+sD13golsqyLAZKKBpmTlSssiWYxQL0gucEGOF4b2dkZGWc3idweE1ly1R4JkD3RO
	U4hhwQIEX+gbUFEFo+EeuvwiXRosPKhC9uskjEAB51D8Ddlv7RnhaYDS9a4CGwiCkBLzxkt51GW
	aQ6nwHl5UOP1mJa2tPfaHLAIwwWNkWHxU5YxK2DhwQdiDz/TF6wWyc7amwhwSR0sClLE6rUTpSt
	1UjgwcIXHFysSRCNpyM7EAXvxjSMGdWbdkHsJnr+CSph7LjCOdBfQuJEn0luFAiH6StYSPyVSBQ
	sXaA9/OJwpGyAlTIXWX4szs4UXHOoI+f/MCYD6Gqe6q/r5XhQdqVnIl5ncL8OshK10T8eXO2mVa
	M0mTG5RfrMUaf8cN1Kntz6sM7Ygc8NnQfFIQTzil7TQ==
X-Received: by 2002:a05:6a00:94e3:b0:848:6720:6fec with SMTP id
 d2e1a72fcca58-84fde34a291mr26130114b3a.28.1786990942981; Mon, 17 Aug 2026
 11:22:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260815091819.3651099-1-gaoxiang17@xiaomi.com> <04f3ce2f-67f5-4829-9551-a69b9df29854@kernel.org>
In-Reply-To: <04f3ce2f-67f5-4829-9551-a69b9df29854@kernel.org>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Mon, 17 Aug 2026 11:22:07 -0700
X-Gm-Features: AcwNN1WfsDbZbp0-lpvXe5rDMDaXky5_oG6XfLm1oTm1uuOmMOh7cMvg-ry1wfk
Message-ID: <CAEf4BzbwZkoacX-iP1j4+p8YNbWsq0pc3eTermh2uT5ir66zbw@mail.gmail.com>
Subject: Re: [RFC] bpf: account ring buffer backing pages separately from Lost RAM
To: "David Hildenbrand (Arm)" <david@kernel.org>
Cc: Xiang Gao <gxxa03070307@gmail.com>, Andrii Nakryiko <andrii@kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrew Morton <akpm@linux-foundation.org>, yinchuang1@xiaomi.com, bpf@vger.kernel.org, 
	linux-mm@kvack.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Xiang Gao <gaoxiang17@xiaomi.com>, 
	"Lorenzo Stoakes (Arm)" <ljs@kernel.org>, Steven Rostedt <rostedt@goodmis.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 17, 2026 at 11:10=E2=80=AFAM David Hildenbrand (Arm)
<david@kernel.org> wrote:
>
> On 8/15/26 11:18, Xiang Gao wrote:
> > Hi,
>
> Hi,
>
> >
> > I would like to discuss accounting BPF ring buffer backing pages in
> > system-wide memory reports.
> >
> > BPF ring buffers allocate their data and metadata as order-0 pages dire=
ctly
> > from the buddy allocator, and then map those pages with vmap().
>
> I assume there is a reason the slab isn't used, right? Are these pages ma=
pped
> into user space such that page->mapcount would get used?
>
> Can you point me at relevant code?

See code in [0]. And yes, these pages are meant to be mapped into user spac=
e.

  [0] https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next.git/tree=
/kernel/bpf/ringbuf.c#n93

>
> >
> > Because vmap() maps caller-owned pages, these backing pages are not cou=
nted
> > by VmallocUsed. They are also not slab pages. As a result, most BPF rin=
g
> > buffer memory is not represented by an existing named /proc/meminfo cat=
egory
> > and appears as Lost RAM in Android memory reports.
> >
> > We measured this on an Android 6.18 kernel.
> >
> > Test case:
> >
> >   32 BPF ring buffer maps
> >   16 MiB data area per map
> >   512 MiB total data area
> >
> > Observed changes:
> >
> >   Lost RAM:       approximately +529 MiB
> >   VmallocUsed:      approximately +2 MiB
> >   Slab:        approximately unchanged
> >
> > After destroying all maps, the values returned close to baseline.
> >
> > The question is whether the kernel should expose the unique physical ba=
cking
> > pages of live BPF ring buffers through a dedicated global counter and a
> > /proc/meminfo entry, for example:
> >
> >   BpfRingbuf: <value in kB>
>
> This looks a bit too specific for my taste. And I think we should try to =
no
> inflate these statistics here too much.
>

+1, way too specific

> >
> > The proposed counter would include:
> >
> >   * ring buffer data pages;
> >   * metadata pages;
> >   * consumer and producer position pages.
> >
> > It would exclude:
> >
> >   * the second virtual mapping of data pages;
> >   * the pages[] pointer array;
> >   * map metadata allocations;
> >   * vmap page tables.
> >
> > The goal is to account for the currently unclassified direct backing pa=
ges.
> > Slab- and vmalloc-backed auxiliary allocations are already represented =
by
> > existing memory categories and should not be counted again.
> >
> > A possible implementation is an NR_BPF_RINGBUF vmstat counter maintaine=
d by
> > the ring buffer allocation and free paths, with the aggregate exposed t=
hrough
> > /proc/meminfo.
> >
> > Questions:
> >
> > 1. Is a dedicated BPF ring buffer counter appropriate?
>
> I don't think so.
>
> See [1] where we just had the same discussion for tracing buffers. For th=
em,
> Steve [2] had an idea on how to expose them more fine-grained and tracing=
 specific.
>
> [1] https://lore.kernel.org/r/20260810094025.136705-1-gaoxiang17@xiaomi.c=
om
> [2] https://lore.kernel.org/r/20260810105710.6ee5e493@gandalf.local.home
>

We already report per-BPF ringbuf memory usage either through bpf()
syscall or map's fdinfo. E.g., with `sudo bpftool map show` you'll
see"

1455733: ringbuf  name event_ringbuf  flags 0x0
        key 0B  value 0B  max_entries 262144  memlock 275776B
        btf_id 2193434
        pids tcpeventd(2549812)

where memlock is how much memory is allocated for the ringbuf data area.

> > 2. Should this be represented as an NR_* vmstat counter?
>
> I don't think so.
>
> > 3. Is /proc/meminfo an acceptable interface for this information?
>
> Again, I don't think so. "Lost RAM" really is just "excessive memory allo=
cated
> by some other subsystem".
>
> I agree that some users might want to figure out what is consuming that m=
uch
> memory, but I don't think growing /proc/meminfo in that way is really wha=
t we want.
>
> > 4. Is counting only unique physical backing pages the correct accountin=
g unit?
>
> I'd assume the "It would exclude" part above should not be accounted ther=
e, if
> that's what you mean.
>
> --
> Cheers,
>
> David
