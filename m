Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 553091A3160
	for <linux-fsdevel@vger.kernel.org>; Tue,  1 Sep 2026 03:07:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.173
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788232029; cv=pass; b=esog8CoDEb4/6GcKh22qcnd7hdEyN6plnS+D1JoRRmVi5g9BMo+mMkD3eUCcp2QyP59t77nHr+uYMCvhPK3F6TvoZgoecjZPn73Me4DzVPqDTn2wIh4KMCKRk0o/F2SqnfAl9yUcWFcOaDXToV9GLELchof03DRscsh/z6spjL4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788232029; c=relaxed/simple;
	bh=E4g4P4Uas1wvhY+7wxoHD2a+ao0SimGdN25hIT/0+HE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XxzaFThzWPx28xMBB+Nrmi8mWI7Ogvo0IyEeehGS2vTPCVDD5e84rLrp1xPLvqd2aSTd70WRKBxgJK9r2QyZh7bAZzs0R4UHpjt5PxiWjw13cXt9ZZpzekU7tx3bypAjIEi3HzQqqgam6ZvOa75jR6J4XAiZJegF7BbJmYG1T7M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=E3sDJvxM; arc=pass smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="E3sDJvxM"
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2d715f4a587so5046455ad.2
        for <linux-fsdevel@vger.kernel.org>; Mon, 31 Aug 2026 20:07:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788232024; cv=none;
        d=google.com; s=arc-20260327;
        b=dA+9qZ7BKr7zzK2G5gPx6xzHH4GvsOGld0HWU1pEKWbGOiKtvLiPNrR9EEYcvY9tBm
         //ezeKLanHMWk+LBN1osYdcQX0FRddnPOO2t4jnEZAIGT10TmNk/R9qXtA/iN2FTWZ3g
         tMEhksbOP52CEFZH5wi1BxMZLECkCA6l34XyhMtpki54iWACW+V5iQ7idX2n+uZSHUnP
         2SHB825NX61yRfnRiriFW0u932SK8vkDCjs07Fr5JVFF0ZdOgkN3Nh5F+elR9ghpfhW5
         E/4fGlu+YB973DOyi+mfHfrSGS6NKbkuW0PBdlsvvo4WegUokrDYJZajwppFutqM2z2Q
         M+Wg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=rV+PXaukkYgPfD2pL8aBLAu93sZ0O6nrJKBecZuhC4U=;
        fh=/7xYB3j3SuJTxj428UOGOcrR8b/sLI6IgBFDMcQXHwQ=;
        b=FSN//z90A0pPMvzokDfcfGlGkFYrR/pRh+m0NrgfTOPRdEIo6Pjw/AsIMQeCp7EoTI
         LpF2ufA4Xid/CJf9HnaK97401kJVxOe+etDhpqnVgq0x94IMxgck+QTKVIVSGsj5brfa
         HEuDQhzYx1DYCJOHosZuyXgxqczIZrwka1jKkBsgFdGsKMaEcEQ/ZPl4xj5Jc3/QZPku
         54i+3z8fJWgL6ReIeBfU/nR9z+h+DXFbzKwV4DVNJowS/iilXhgp7Rp/32jBXKCsoQb6
         CIhJsWICZ5g49esnQTITffe+WMpkmaE1cOByr8xm6RuG6tC31TRyzUwk2dkNkQJ+a7ME
         BrCg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1788232024; x=1788836824; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=rV+PXaukkYgPfD2pL8aBLAu93sZ0O6nrJKBecZuhC4U=;
        b=E3sDJvxMdUYqTFahEgzEDxdwPRUnbZJ4AFSBtrbAcr31uGZtIp8CPW1zuPAdI7UlXk
         ffkPBYqPWRAtE7c1KegrqFx+uq4dY5WUHtbjojAWfEqErWiw6cBrVKDfyljE40VfQhSx
         cayHRsPuwDdpXb/odQZ7uqHCFb1RUKNl7bGFD4Qc36Gb30F4cuWe/wczYKz0/Wdu6zIx
         9l492pndZtH+AqioVUML5ttI/zDsWfdT+k2BVzn5xDgEJ8WFagYGFyyU+h7oBI4mAGW1
         5i7S+T0ZmrVsxX9HjwZQbwZ7n8hCKe0SKkLxMRkxPudhIh8Pl48szQDr+KJThM3GMgVZ
         0gWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788232024; x=1788836824;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=rV+PXaukkYgPfD2pL8aBLAu93sZ0O6nrJKBecZuhC4U=;
        b=BS+oh/C0hmVxq/u2/e+mHpyPPy/aHUIV0nIGQLtfZlcfGerKCaHpo/kWBZow9PsnFf
         0VNi2PFQiqFpvOI/nbyCxn5p21Y8JFhO1/PnBhf/lWMmzqgBUIhAPFJr1v3CDtknOSqK
         x65RJfGP1uSsrpJkV2WSnsv529kG/jKAw48Bfadbig5ycQTGFVtkuOzEBJt83dMhOyIs
         BR/v580m6ililhetnzFXz4qapy7NrTV7uOcxjOlStCnr4g6jMkXXiJkiTXsh/gDpKcRb
         qiyMBSZlfeUJQUAy740Pb7i/1nYeOt1Mzp4eaV4S+Jw9eRihooVoU2MEq0SvdZ3tveWv
         rWHA==
X-Forwarded-Encrypted: i=1; AKwUvByYFbE2ZvEXJGWKsrPk4GVCmIOAwfz07MJnn9Q0jYfIOJyxK133SEU4G5wnQCsOvhyyb35zaeHrKmFPb1+t@vger.kernel.org
X-Gm-Message-State: AFuF++nbifsCeP3n+GlSxHt5/dJVj/dwvF8RctdmgXORJjftyPXBAbzj
	TEmS6dH9UX1ucC0iLCsx2HL3h4ygPNmDSqHZPn+sxDUJrrKGUouK49f+sT4z7b/mEZritmsgQU8
	06Rj7rYgegbOg6uMZzKwbPSOWFbSIIXdltrP+bEPd
X-Gm-Gg: AYBFou02rif/VIVlR6OkjSE+wecoJBb/pyh0GYXGHhLkrGRw6fwDoINhKNPGWq5sSn4
	mS1ArmOfuHyZ8d9z44ut+3mNN44NDsakm4Wr8ERs0DnGNnW1MG830n/JZgdM6Uf2p6zOA7d4hg9
	C8PPVdSSGPML6Ph5cFKchXvEw8dZHGjc2wzztnH6CFQCLBtJCABmZXaRKOSlh49BjnLj3fKx/g+
	QUwb1kAEHBE3USoVqEAEnhiGrxQTyNI7CnjTRwUr8BXCrqPPn18Wc8Q/e8GBD5UlOMWMEypDEGP
	geBCeKKGm/1wTEu7O7I9BOh28QEX/iYj0ZmrGGjjR5xSlRGEMMFysEpkCTv9cGyc91IaXSBKOwH
	R3Y7//5uJJUupIzrLbKyJQi5foVBBizRP8/7iy5UV5Iy32FmdkuVazbWqvsGRwuAOy/zSCLITtU
	0rHVTLTFa8Z3xA
X-Received: by 2002:a17:90a:dfc8:b0:398:e1f4:bda1 with SMTP id
 98e67ed59e1d1-398e1f4be7dmr17139214a91.21.1788232023587; Mon, 31 Aug 2026
 20:07:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260901024234.135119-1-ruanjinjie@huawei.com>
In-Reply-To: <20260901024234.135119-1-ruanjinjie@huawei.com>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Mon, 31 Aug 2026 20:06:51 -0700
X-Gm-Features: AcwNN1XRAJ9GG1DVk19njfLqbrvAH3RJBW-j57vaqgr-CsIXWc1aNtkHXfR6rkM
Message-ID: <CAAVpQUAR93t6CDrUzXt-v9qECSFHwYoofR4qinV5mty6LS7mJA@mail.gmail.com>
Subject: Re: [PATCH v2 00/12] Convert barrier pairs to acquire/release for
 better performance
To: Jinjie Ruan <ruanjinjie@huawei.com>
Cc: viro@zeniv.linux.org.uk, brauner@kernel.org, jack@suse.cz, bcrl@kvack.org, 
	tytso@mit.edu, adilger.kernel@dilger.ca, libaokun@linux.alibaba.com, 
	ojaswin@linux.ibm.com, ritesh.list@gmail.com, yi.zhang@huawei.com, 
	sforshee@kernel.org, pmladek@suse.com, rostedt@goodmis.org, 
	andriy.shevchenko@linux.intel.com, linux@rasmusvillemoes.dk, 
	senozhatsky@chromium.org, akpm@linux-foundation.org, davem@davemloft.net, 
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, 
	willemb@google.com, jhs@mojatatu.com, jiri@resnulli.us, kees@kernel.org, 
	cyphar@cyphar.com, tglx@kernel.org, sdf@fomichev.me, nb@tipi-net.de, 
	liuhangbin@gmail.com, da-x@monatomic.org, jeff@garzik.org, 
	linux-fsdevel@vger.kernel.org, linux-aio@kvack.org, 
	linux-kernel@vger.kernel.org, linux-ext4@vger.kernel.org, 
	netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 31, 2026 at 7:42=E2=80=AFPM Jinjie Ruan <ruanjinjie@huawei.com>=
 wrote:
>
> Hi,
>
> This series converts some existing smp_wmb()/smp_rmb() barrier pairs to
> smp_store_release()/smp_load_acquire() across various subsystems.
>
> Background
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>
> Many architectures support load acquire and store release instructions
> which can replace explicit memory barriers and save cycles. As noted
> in the ARM architecture reference [1]:
>
>   "Weaker ordering requirements that are imposed by Load-Acquire and
>    Store-Release instructions allow for micro-architectural
>    optimizations, which could reduce some of the performance impacts
>    that are otherwise imposed by an explicit memory barrier.
>
>    If the ordering requirement is satisfied using either a Load-Acquire
>    or Store-Release, then it would be preferable to use these
>    instructions instead of a DMB."
>
> On arm64, a typical seqcount [2] read loop requires 13 cycles with DMB
> barriers. Replacing the read barrier with smp_load_acquire() reduces
> this to 8 cycles on an Ampere Altra.
>
> We also observed significant barrier overhead while profiling Unxibench
> syscall test on arm64: a single getuid() call is ~8ns slower than on
> a comparable x86 system, with the dominant cost in map_id_up()'s smp_rmb(=
),
> which is a DMB ISHLD on arm64. Converting it to smp_load_acquire() allows
> the use of LDAR, eliminating the measurable overhead.
>
> This motivated a broader search for existing barrier pairs that can
> be converted to the lighter acquire/release semantics.
>
> Changes
> =3D=3D=3D=3D=3D=3D=3D
>
> Each patch in this series targets a specific barrier pair where the
> publish/subscribe pattern is already present:
>
> - Writers populate data, then publish a flag/count/pointer via
>   smp_store_release()
>
> - Readers load the flag/count/pointer via smp_load_acquire(), then
>   consume the data
>
> This preserves the existing memory ordering guarantees while allowing
> architectures with native acquire/release instructions (e.g. arm64's
> STLR/LDAR) to avoid the cost of full one-way barriers (DMB ISHST/ISHLD).
> On architectures without native support, the generated code is
> generally no worse than the explicit barrier pair.
>
> The conversions are mechanical and no functional change is intended.
>
> Testing (arm64 Kunpeng HIP09 server)
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>
> 1. UNIXBENCH syscall
>         Baseline: 715.27
>         Patched:  718.83
>         Improvement: +0.50%
>
> 2. fs/aio (fio + null_blk, 4 jobs):
>         Baseline: 1441k IOPS, 86.46us
>         Patched:  1452k IOPS, 85.80us
>         Improvement: ~0.8%
>
> 3. soreuseport (wrk, 8 servers):
>         Baseline: 162.6k req/s, 452.5us
>         Patched:  164.2k req/s, 449.4us
>         Improvement: ~1.0%
>
> Both improvements are consistent across runs and align with the
> expected savings from replacing DMB with LDAR/STLR on arm64.
>
> [1]: https://support.arm.com/documentation/102336/0100/Load-Acquire-and-S=
tore-Release-instructions
> [2]: https://github.com/torvalds/linux/commit/d0dd066a0fa26d55c19ace9e89d=
edd9504c5bcba
>
> Changes in v2:
> - Fix pre-existing issue for ext4 and 8021q [3].
> - Fix missing copy_mnt_idmap() udapte [3].
> - Drop nacked isotp patch.
> - Add test data.
> - Add Reviewed-by and update fs patch as Jan suggested.
>
> [3]: https://sashiko.dev/#/patchset/20260825095422.3166067-1-ruanjinjie%4=
0huawei.com
>
> Jinjie Ruan (12):
>   user_namespace: Use acquire/release for nr_extents synchronization
>   lib/vsprintf: Use acquire/release for ptr_key publication
>   fs: aio: Use acquire/release for ring->tail publication
>   fs: Use acquire/release for fdtable resize synchronization
>   pidfs: Use test_bit_acquire() for attr flag tests
>   super: Use acquire for SB_BORN check in super_cache_count()
>   ext4: Fix out-of-bounds read in ext4_get_group_info()
>   ext4: Convert group-count barrier protocol to acquire/release
>   soreuseport: publish num_socks with acquire/release
>   net: sched: act_gact: use acquire/release for tcfg_ptype
>   8021q: Fix data race when publishing vlan net_device pointers
>   8021q: publish vlan_devices_arrays entries with acquire/release

Please post networking patches separately with the target tree specified:

  Subject: [PATCH vX net-next] soreuseport: ...

8021q changes can be posted a series.
