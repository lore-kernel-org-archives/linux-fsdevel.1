Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 607893932FA
	for <linux-fsdevel@vger.kernel.org>; Wed,  3 Jun 2026 23:23:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780529031; cv=pass; b=dA4X7OTKVimHmThPIcvo+YhDnWYj0cACQmhNuccbGDBGkFnM0KpB7JgzUm4xXWvNGyM6fYrxMEO0yWqBIpV34MrDV8SHADSH0rUsZ43Iwqt3h0Fm3Z/Iv0iIIx81dx3nhgVrfEdKYXVPmUc0SNc+niOqbdbDXKcFUOxbb+hCCOc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780529031; c=relaxed/simple;
	bh=8LaD9hmGlPfugg7Vxou/GZSBpqWyfWOJUw2hWYTmvig=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mWRvr1YF3qkwvAkwl7hplQIzbk/+ujUYMcdv+ZhjxWuBrbNeJaNJ3vn6AthihAdZX/vYn0wdYYtGSuVgLxUMvU7Cb9NzFfQhWTL/KbZeuPKSLYPxVQfIVSjKLJOZ3ldtzlzdzIoq3kd6zD7gj6pmdlJMwEGg+bib1Uk/r3GPDzc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=daNyVRC2; arc=pass smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="daNyVRC2"
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-6877c719cb0so69732a12.2
        for <linux-fsdevel@vger.kernel.org>; Wed, 03 Jun 2026 16:23:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780529029; cv=none;
        d=google.com; s=arc-20240605;
        b=k2CRMEwNzyt6Ipw6350o8xG9MQaCFvXemgRnJ3mvbxZ1mXRb5zswVPaSiguA6L312v
         7jaoAzFJQxMG15Lk1iitj6TYQmyYOFSAimjbr0/PguXxzdDIGZsr4KHKKsVd59+ECx80
         KP2KBu/3F2erIp42DXSQhFNf6a0m/XeZhwbIeMH9HIBIUVU0qrWuiEI08ugeLO8MgX42
         +uPBlObCSmQHKHI5KS94GE/tBuRENBh87nocZk1IS0nyxGPIdghiHpsz6kTLxs6LtqTP
         Jt0H5KIUhBqTja7xNomguJi6sZ1e7nXE/SQxrHLh2DRyZY3u3ZiVzR2UOvec0TYVNKEW
         cE6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=asfvolnkdYW8hK0Eqrj1lFlfp6udJ7ESDn4wAM46dyo=;
        fh=F7CxQRxqYJu0l0BRx8UTxR+ozLTUhR87Z4RSTqWuaco=;
        b=AGf5lXYdXAUyAp7aRfx51Q8+lNqay5xudIFJx7AFIE2+ubZv/tH+ZBv2DTh01gdlJp
         5g2/Bl1XRBQTuqfawTeuLUjZOI7LirQE6OHrfZ8DQLt2/uVceS+8I+YZZaghX64dx+4D
         ghpe+kH+YNuwXHpQvuhcAb5nuiIufM1P8DKMFM+UNI05boirP/rFRew4o+h+vbZQo5U5
         VZin8ZSw+O7KmXGo0DFZSJBDp31YZLeVY9DEglknCmCEvgK0ZowOog7hYa1HuzUUfA59
         3W/RA+EZD2bxYsHdcJODS6FbljASxgkQ48MK2xt1sENMryqWhU2zyQbVuglBff7tPW8a
         hiog==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780529029; x=1781133829; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=asfvolnkdYW8hK0Eqrj1lFlfp6udJ7ESDn4wAM46dyo=;
        b=daNyVRC2cNu6Io+/0PpWC4iJsCdMMEVEtPJNagiQt9s20IygU5sBoiUqJnv8DH8SAh
         mCM9VCPuWKqMvMN0BquDtlYJI0uT6sXhrJP1wk4BRPb7YSYzfeFknq2l3nvEgsNx+WNB
         GhovArs4f0sP0+9R9sxc6cbey0KZZTYEhy0SMffDyFznm2aK7BKQ8Y6bvq3ztcvOri40
         C616TcnlUH85EjE3QbbPDjiUqOQuUxBtU+qMbnaUYLniy23D+AlMj23h2RGHC3QAZRfI
         XZdGh8CgTtDenQDO8sNxUzKPVaeyjmoew62tmQiVWvMExp7idXnidzLjP+MjUC178Z3W
         uZTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780529029; x=1781133829;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=asfvolnkdYW8hK0Eqrj1lFlfp6udJ7ESDn4wAM46dyo=;
        b=cDod8TRuA/MK72WDk9VnSRKNN1jI2+8ou2H0LWJN1NIjBeTSt1NEqSbC1xDrPlwFok
         GDZgNHewR3Nuzb51EfKodTEKVBDEvtGPNhZIf5zdACCIvLSnulNjKF2Lw9AUvLM4CbIg
         19Sw6YU5rUQuEQLp96Nw3nFAh6x0d8+L31v1gdBzh22pA+Z3ZTMHq6uKdYLxoBNF1Fqt
         r47eOpytpaFiASZxZeaA8hJ8qu57ISjlsP5IsX17GdXfxlneWhm+j+ja6Upm5G7/ncTh
         NK2LnXKyi6bqACzhhwLg1zfROkS2hyoWwgf/Yt1Txg0LGCYn497URu1LwOc9oP1UV4qv
         gphQ==
X-Forwarded-Encrypted: i=1; AFNElJ+jo3CG7ViVGtme4uVsl/G+rDdTzhme3Re7CwWWqcjnfPrMj23ni85ZEm2QYWJ+fkSRofV+Ho0FaBXChw9W@vger.kernel.org
X-Gm-Message-State: AOJu0Yyq0FKs/UjNA/DeGkZ8I47HuhiBW46gDUsQmSNjGfLWiyZ3mjTy
	wsbceiiFmMSUmlUoOA+Kx6hM1TL51mijKcaLrYMPUOa2LszthTABLRQ4FbBe9S+XOWlfS2Y+i20
	Sv9SDdnvPrd6ssWfK3XhPOf7f2C2uda0=
X-Gm-Gg: Acq92OEr+oOY7pUO3LjY56bXWrHC1wuXwA41NCoy6xMBZq1RQa+9Sn+XGku3hMT0cep
	7P47oyFZ0LuuEOuqyjv6YzyzQXw+VDmLuLUotkhRziOjJ8t+gc0GwPAhQP293OouPXwqBeHReGs
	vuI2/OdA8rNeZbAjdhUp3D7h0eWgBX/BWp8h7vts1nLxhRWkiHzfs0m71XOsl4AAKbH+OKN5tAd
	AFovgK9YCKU/5b+V7lgkXVHRDYzJjx22sDLElMYG0o5fZYqzck08mdOnVxUBmcpCTxR22R0VyBl
	ObajddNNPH8Yp3h3lx3/OtuhUWUp0pZmqvvN5AeFMgme/GDqfbV3t3rr79xHQl21U8vijCDXC9E
	fDM3IhO591/gts7FC7gUw06tR25RWwJeh5A==
X-Received: by 2002:a17:907:9446:b0:bef:90af:6ff1 with SMTP id
 a640c23a62f3a-bf0ae80264dmr310854066b.31.1780529028536; Wed, 03 Jun 2026
 16:23:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260603105317.944304-1-dawei.feng@seu.edu.cn>
 <20260603105317.944304-2-dawei.feng@seu.edu.cn> <961fbada-5ca3-46c2-a5df-51bb006f9cb6@linux.dev>
In-Reply-To: <961fbada-5ca3-46c2-a5df-51bb006f9cb6@linux.dev>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Wed, 3 Jun 2026 16:23:35 -0700
X-Gm-Features: AVHnY4I_skWxadH4yJbpQpsBRuIx50G6yyAI8fs9EbX22rR67XYadXSXG1E9ZTs
Message-ID: <CAADnVQLtKYpE0=-UWLWkBVp4s0cncR+KXRu_7Wkt4zXWsmkchQ@mail.gmail.com>
Subject: Re: [PATCH v3 1/3] bpf: NUL-terminate replaced sysctl value
To: Yonghong Song <yonghong.song@linux.dev>
Cc: Dawei Feng <dawei.feng@seu.edu.cn>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Emil Tsalapatis <emil@etsalapatis.com>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, Eduard <eddyz87@gmail.com>, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>, Song Liu <song@kernel.org>, Jiri Olsa <jolsa@kernel.org>, 
	Kees Cook <kees@kernel.org>, joel.granados@kernel.org, bpf <bpf@vger.kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>, 
	Linux-Fsdevel <linux-fsdevel@vger.kernel.org>, jianhao.xu@seu.edu.cn, 
	Zilin Guan <zilin@seu.edu.cn>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 3, 2026 at 7:37=E2=80=AFAM Yonghong Song <yonghong.song@linux.d=
ev> wrote:
>
>
>
> On 6/3/26 3:53 AM, Dawei Feng wrote:
> > When writing to sysctls, proc_sys_call_handler() guarantees that the
> > buffer passed to proc handlers is NUL-terminated. If
> > bpf_sysctl_set_new_value() replaces the pending sysctl value, it can
> > hand a replacement buffer directly to proc handlers. However, the
> > helper currently copies only buf_len bytes into that buffer without
> > appending a NUL terminator, leaving downstream parsers vulnerable to
> > out-of-bounds access.
> >
> > Fix this by appending a '\0' after the replaced value to restore the
> > expected sysctl semantics. Since the helper already rejects buf_len
> > greater than PAGE_SIZE - 1, there is always room for the extra byte.
> >
> > Reproduced in a QEMU x86_64 guest booted with KASAN while exercising
> > the sysctl replacement path with a cgroup/sysctl BPF program. The
> > reproducer targets `/proc/sys/net/core/flow_limit_cpu_bitmap`, fills
> > the original user write buffer with non-zero bytes, and overrides the
> > sysctl value so the replacement buffer lacks a terminating NUL. Under
> > that setup, the pre-fix kernel reported:
> >
> >    BUG: KASAN: slab-out-of-bounds in strnchrnul+0x72/0x90
> >    Read of size 1 at addr ffff88800de57000 by task repro_patch3/66
> >    CPU: 0 UID: 0 PID: 66 Comm: repro_patch3 Not tainted 7.1.0-rc3-00269=
-g8370ca1f87cc #6 PREEMPT(lazy)
> >    Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.15.0-1=
 04/01/2014
> >    Call Trace:
> >     <TASK>
> >     dump_stack_lvl+0x68/0xa0
> >     print_report+0xcb/0x5e0
> >     ? __virt_addr_valid+0x21d/0x3f0
> >     ? strnchrnul+0x72/0x90
> >     ? strnchrnul+0x72/0x90
> >     kasan_report+0xca/0x100
> >     ? strnchrnul+0x72/0x90
> >     strnchrnul+0x72/0x90
> >     bitmap_parse+0x37/0x2e0
> >     flow_limit_cpu_sysctl+0xc6/0x840
> >     ? __pfx_flow_limit_cpu_sysctl+0x10/0x10
> >     ? __kvmalloc_node_noprof+0x5ba/0x870
> >     proc_sys_call_handler+0x31d/0x480
> >     ? __pfx_proc_sys_call_handler+0x10/0x10
> >     ? selinux_file_permission+0x39f/0x500
> >     ? lock_is_held_type+0x9e/0x120
> >     vfs_write+0x98e/0x1000
> >     ...
> >     </TASK>
> >    The buggy address is located 0 bytes to the right of
> >    allocated 4096-byte region [ffff88800de56000, ffff88800de57000)
> > With this fix applied, rerunning the same sysctl-targeted path yields
> > no corresponding KASAN reports.
> >
> > Signed-off-by: Zilin Guan <zilin@seu.edu.cn>
> > Signed-off-by: Dawei Feng <dawei.feng@seu.edu.cn>
> > ---
> >   kernel/bpf/cgroup.c | 1 +
> >   1 file changed, 1 insertion(+)
> >
> > diff --git a/kernel/bpf/cgroup.c b/kernel/bpf/cgroup.c
> > index 876f6a81a9b6..2c7f72d3fb11 100644
> > --- a/kernel/bpf/cgroup.c
> > +++ b/kernel/bpf/cgroup.c
> > @@ -2342,6 +2342,7 @@ BPF_CALL_3(bpf_sysctl_set_new_value, struct bpf_s=
ysctl_kern *, ctx,
> >               return -E2BIG;
> >
> >       memcpy(ctx->new_val, buf, buf_len);
> > +     ((char *)ctx->new_val)[buf_len] =3D '\0';
>
> In v2 (https://lore.kernel.org/bpf/bf25d653-d856-4ad7-a751-b97d38f38892@l=
inux.dev/)
> I suggested
>      memcpy(ctx->new_val, buf, buf_len + 1);
> Does it work?

may be it should be strscpy()?
The input is a string, right?
