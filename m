Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A22D0393DD3
	for <linux-fsdevel@vger.kernel.org>; Mon, 24 Aug 2026 23:43:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787614985; cv=pass; b=J9KvkVd8KWgGrnjlXPopNcLu7ZcAp2IGaYIZHumC/qAbHIJkCyVfBOg/Fd9unjZefz5WBhfx8AkVQ/sMvBcK+oyovomk6jYlpK2z6Zy3T5lLLgXhZi73WxdwXVgsWudto4jD0Q2xjFjLkZnwCri3ufK96ZNGaXDwAQVJ9FTHHlI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787614985; c=relaxed/simple;
	bh=sHnXZHT8WiiUeAdh+tKiJaengtnfesqTEZdJsUGA+8I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sLySR+CVMTAIARoFTTAdO/X3iF8l6k2GR7npBZVs9Ug1Gv4Bu+akxklvHVxBAkyprCbc0bnEAJF2lVkrdCSTpgK77e8PuQBIRLcMA9RV+GB++a6lsI/D+D42/6D2eeCy64hrnjtco+Buk/WHpZqEiqbUZgimFw3HPcsyZUuSXyc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=h2uelV63; arc=pass smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h2uelV63"
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-499b02fc590so25163135e9.2
        for <linux-fsdevel@vger.kernel.org>; Mon, 24 Aug 2026 16:43:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787614982; cv=none;
        d=google.com; s=arc-20260327;
        b=XGCLE0v8KrEKsGpqecyvgA3G/98lbJBF0zxVW8dfUV59EfxnwRlCSOezCWoR1YyB+Y
         xujseoC/tJ9bW86PoSmh49ePwdKtEurtudkTHSxcHEFCOggF6pCw2OYSEiq5HK0ziP1v
         rfpjmp+tzOFYZ3u2okEciqrgEbOm+o/7eUCYjSvaCF+xCxFRQT7N3jXlW5uhpqV54uam
         afpLcAW1Ts/fIcWcD8prle1o6CLqiE2nzfKW7SdonYWtfZVcJYGlmQttmjVvOfC0ecgk
         IK9/01qeAhdzy1c45H0QUTM+PD7w33w/NAXvvI8q50IYJUOsrhiMHJwxDT1u0hSHk0Vi
         aS6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=sHnXZHT8WiiUeAdh+tKiJaengtnfesqTEZdJsUGA+8I=;
        fh=xsIKqjB59G0ep94WE+p/fCiPOW0bCYOUL3eeU0okxyI=;
        b=krqbd9pG6y9OKSnDT7nUUnhD+iL0X76B0qq7UvUGEei+XfmCRZnthdvw2+EkAYMstH
         BdRPDVUSdEE1HuLgSZOj8ZwXppuGJxsDIfQsPPKdR6JJXZySzFtpAw5zeYLv3holdfbG
         N7k9DYUS+u6CRZt9XjFOBO0u6TmbNrbqy02/CFn8IWkgT1PmVx7adrm/mo3uT1R8S6rl
         dyxiVoJ4SCiqR4vwxJ+kfP1GTnPodnVPVFGfEWFCeNoaxU109wx9P9NYI7YX814LP0ku
         Q1TuqeOqBSsv+KZ+GBBos1fN06p2nGVrJf0eTIqxa/sC7/+r35NXS3NrQOuDjSqQrNQ8
         Q9aQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787614982; x=1788219782; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=sHnXZHT8WiiUeAdh+tKiJaengtnfesqTEZdJsUGA+8I=;
        b=h2uelV63RA1KI/d610zMVtXkoVzjoNExOXZEOOETin1s6ccJnSsLuNwP63Qz5Mey44
         frM2+JDVCqfWZPAEeK+BRffhVIFOTEbVHVeWySFX2wDYZ+cQMevQv4rsBSUNTn7UaqRe
         zrueLROytLujeezVwR5d+mA25uxdHvCeTdIHZup1P9e7fLz7RZf2ySve3cyzLwDX9mvr
         r8I2zPOBAF+drq1WnFcbNsNyhNgYXum5MWjcnjXp9hxNIyiCEySL+xKd1mlW6RW9xwP+
         ij+K3BRd9zUslegs/+tCSIAIkDiaaxEwmFB72AXI6jJdxh5cjqdUZJEiRZwc3QQVGuqW
         ZIyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787614982; x=1788219782;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=sHnXZHT8WiiUeAdh+tKiJaengtnfesqTEZdJsUGA+8I=;
        b=FhuMvteXyA93tW/3bzuEnwplr6Sybl8jDcAKVGm7NR6wv3YOZ9sbqh8/s4QQZWk344
         yaUmNqfFoaqmU77BHx9D9ZCJdw5whgtjdS8Udp2os/TsziPy9u1g1o04nq/XeaP2LxbX
         6GjmqbarlIDye1VTKJRhee1/O7fzi4ZSJIiYjuOU5sCArg2fNmoHazSja1pgiioKQhF5
         X9cJDhwu6YAXEkTQcBN9aksWPMWONtLfe9VN+Tpz+5dt8dG8DYPrmJ8yEHKtkGXW3GZR
         3jFUnW7DMc+IHWCPunoc9f9enD0gCSrAkdCCmRJuoMFj0e6b0xM35HLmYgT5gSg8LR8R
         Mj+A==
X-Forwarded-Encrypted: i=1; AHgh+RpMNf3oZ3dSvWnKIbfPrwuhxoOdIWMvW9jSR8DueBIzltdfxQJxUF95OUg0IxhF90JMPdkRhYSej5Yvn0Aq@vger.kernel.org
X-Gm-Message-State: AFuF++lqrjOH5L8iyjGJTBEKqPCTDQK5B/bpbOkr6zSWlpefPg5QRdqi
	0HSsTU3ZDdtsFPip1DcYeuOpE2MK1AMRqsWTo5i826bboQNDAeHhTxe0LpPDRlaR1jL72lo6x9n
	oosWcg9IgYH8iCHTsTyNPUBayZn9wpBw=
X-Gm-Gg: AR+sD10l0hFMarYNu0S8E7e3G1DWrI7gDAj0jUJ57Oy26WMXXFKntkF4k36I74bRUsP
	kY782ojmv6joFwtzhoJFtBrNTdIKieopbmG0Hx71e7WzvGrzj8xqQl6UgWJQx9U4G6Fp53k0sno
	aOGQy2IZ1lvXYi540kD3GTtyojhw37XE3unV0aoDYCLlzbhSx6iwox5KAFdgdp/fmtXxeyfMvlm
	3os4MLl5KjqYdFu0OzGR2PEwXe7Gw4dN8BoIpeEHq4FGtOorErXq9yIAKouk1zS+KAWAf7jhkD3
	YJ2z82/LJLxzQCbPjfEA97OrlZHvJd/RB3IJgxIl3z53aucj4mOhqS98YbubH9G6b2cprr0uBIH
	QLZVv4PGUG/PxFpjGL9w2BfXkfwM=
X-Received: by 2002:a05:600c:5294:b0:499:7f38:d77 with SMTP id
 5b1f17b1804b1-499b830f690mr402396315e9.6.1787614981730; Mon, 24 Aug 2026
 16:43:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAJnrk1bk66ZhRAS7mojSnD5RBfFS+0ChAPymE3ObRWr0C_udWg@mail.gmail.com>
 <CAO9r8zPpe6fWOSXtRUjFB8WNMroeBqvLT+2QtAU4E27AtLUXMQ@mail.gmail.com>
 <CAJnrk1YifN22mA5PFRVrh3m_ygxax6x4_8nraG2hPqCzyzBj7A@mail.gmail.com>
 <anpsLy_pCanocgS1@google.com> <CAJnrk1Yoj7fqbzurmHkbA-vegpQu3cf-_dfvKor_VxuNhPR-AA@mail.gmail.com>
 <CAO9r8zPLipVW6bvyDK1ypSawbo=LHKvmLqWH0xA6WMR9GYNJpg@mail.gmail.com>
 <CAJnrk1ai-TqcudPoK-qFRYAJnUjBmg1kVa6Vxg3eDm5w5ivqSA@mail.gmail.com>
 <CAO9r8zNJ=Fpc0pZExrttVTDCM3yzSmLPCAU=+RS0k5Pm+hY96w@mail.gmail.com> <CADrL8HV7_f68qfd6hG=xCTqzupPqr77ynbwdz8jm0hzjdgDVeg@mail.gmail.com>
In-Reply-To: <CADrL8HV7_f68qfd6hG=xCTqzupPqr77ynbwdz8jm0hzjdgDVeg@mail.gmail.com>
From: Joanne Koong <joannelkoong@gmail.com>
Date: Mon, 24 Aug 2026 16:42:49 -0700
X-Gm-Features: AcwNN1Wa1AOcfS35Y1v_bgY_n2l1WDv-MkAP-PHL7EYAY7Mw9O0j_aJCxbHrZ54
Message-ID: <CAJnrk1ZU1UO35n46acq9My77G8=h3JUCLXchiamBCFbiDZXJzg@mail.gmail.com>
Subject: Re: memcg stats flushing (WAS "Re: [PATCH] fuse: disable default bdi strictlimiting")
To: James Houghton <jthoughton@google.com>
Cc: Yosry Ahmed <yosry@kernel.org>, Shakeel Butt <shakeel.butt@linux.dev>, Tejun Heo <tj@kernel.org>, 
	Jan Kara <jack@suse.cz>, Miklos Szeredi <miklos@szeredi.hu>, 
	linux-fsdevel <linux-fsdevel@vger.kernel.org>, kernel-team@meta.com, 
	fuse-devel <fuse-devel@lists.linux.dev>, Jingbo Xu <jefflexu@linux.alibaba.com>, 
	Johannes Weiner <hannes@cmpxchg.org>, Roman Gushchin <roman.gushchin@linux.dev>, 
	linux-mm <linux-mm@kvack.org>, 
	"open list:CONTROL GROUP - MEMORY RESOURCE CONTROLLER (MEMCG)" <cgroups@vger.kernel.org>, Nhat Pham <nphamcs@gmail.com>, 
	Jesper Dangaard Brouer <hawk@kernel.org>, Yunzhao Li <yunzhao@cloudflare.com>, Song Hu <husong@kylinos.cn>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 21, 2026 at 6:39=E2=80=AFPM James Houghton <jthoughton@google.c=
om> wrote:
>
> On Fri, Aug 21, 2026 at 12:41=E2=80=AFPM Yosry Ahmed <yosry@kernel.org> w=
rote:
> >
> > On Thu, Aug 20, 2026 at 4:39=E2=80=AFPM Joanne Koong <joannelkoong@gmai=
l.com> wrote:
> > > Would you be able to share the test you're using? I've been trying to
> > > repro it locally without much luck.
> >
> > The exact test uses some internal testing libraries, we're looking
> > into whether we can translate it to a standalone C repro.
> >
> > From a high-level, the test:
> > - Creates a VM with 260 MB (256 MB for testing + 4 MB margin) in a
> > cgroup, backed by shmem THPs. The VM is not a fully fledged VM, just a
> > KVM VM running bare metal code (so 4 MB is enough margin).
> > - Enables zswap in the cgroup.
> > - Tells the VM to write to 256 MB of its memory.
> > - Checks the cgroup shmem usage and that no swap occurred (no limit).
> > - Sets the cgroup limit to half the VM memory.
> > - Checks the cgroup shmem usage and swap again, usage should be ~half
> > and so is swap.
> > - Tells the VM to read the 256 MB of memory again. This should cause a
> > lot of thrashing and reclaim, but no OOM kills as all guest memory is
> > reclaimable.
> >
> > With the ratelimited flushing, the test started flaking 5-10% of the
> > time due to OOM kills.
>
> Hi Joanne, Yosry,
>
> I've attached a reproducer for you (as a patch that should apply to
> Linus's tree).
>
> In tools/testing/selftests/kvm, `make` should build it. Instructions
> for running it (like setting up swap/etc.) are in the comment at the
> top of the file.
>
> As part of the patch, I've also included a sysctl to dynamically tune
> whether or not the memcg stats flush is rate-limited. You should find
> that when it is rate-limited, OOMs occur, and when it is not, OOMs do
> not occur.
>
> This reproducer behaves slightly differently than our internal
> version. This version, when run with `-b 512M` anyway, seems to OOM
> simply by setting memory.max, whereas our internal version would OOM
> upon re-accessing the memory. Not really a meaningful difference, but
> just wanted to point it out.
>
> Please let me know if you have any trouble running this test or if the
> test is wrong in some way.
>

Thank you so much, James! This is very helpful - I will run some
experiments with your repro this week.

Thanks,
Joanne
