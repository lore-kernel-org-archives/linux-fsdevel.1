Received: from mail-qk2-f39.google.com (mail-qk2-f39.google.com [74.125.230.231])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B7383C109B
	for <linux-fsdevel@vger.kernel.org>; Mon, 28 Sep 2026 13:09:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.230.231
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790600979; cv=pass; b=DfXgnpqd+aEgEoeHE2KjQYMiBRI2nSyzMItZHdYHfwSX3IksSk6Jfz6t/he8jSnObRrhNQmdEAI2Jy9GSl/6ThNRMgSB3i8l3hu2kkc5wy5iORnNmSeMYZiNFS2ozWQA0fiS13e1fqsAeJg+iR6Ck0kaqm3qSNy8KOidqugMT5g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790600979; c=relaxed/simple;
	bh=Vr2qG/B14z7DBLdgcVbPjILETyBUq1qTqRPd8m8dPVc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sGDSzl/N0/zHYzWw1J7KmVtCss/SV9/WH7PEbP3FmgbV0KRBH9/L84ZpuRywbR/DtX/+9Cdg/pb3HnhEBK32zrdkncY65CdqMrQPP4aOsMmJNiHiG42PqyhPP4y0Wyo/1SUmRWOPy8v4d9DMTTMsqhVN1wVTE7IJsQ2fbm6eryo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aMXpcx8S; arc=pass smtp.client-ip=74.125.230.231
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aMXpcx8S"
Received: by mail-qk2-f39.google.com with SMTP id d75a77b69052e-5332cd97dc9so13492231cf.2
        for <linux-fsdevel@vger.kernel.org>; Mon, 28 Sep 2026 06:09:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790600977; cv=none;
        d=google.com; s=arc-20260327;
        b=RHy6wTJRvIvVMDU3MFIuQ72FpLb+wQLKGhgwaP82tFPPx3kPF0cqWLHstVCtZ9CPLs
         NxVAyA4nnlW1LEZhKwpt32/RQLxGN+mgk299PvF5/T1pH8+8h/fJP0SFCfGLgpPiRBsd
         OlJ+G+C19bx/va94ffiCWXTEi5ici0xRcd6lswJK1itXN2NUe23IelSybS7R6pHghUN7
         0xRmkw7R/oS+69O+IvECeC23oATMopEbfRHI+qwFnT0yLpgRVnR8nEY7g5UfqYmOXYxO
         CADLBe38ATjd4XkeKOzNGPw0RYyWGVMpYl1GSkaHWMFu/Aww7OaiyzKmu9mbvccn2WrL
         MFiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=8Tv7M63w17ElfFd32vLV8raQp3cLLJqmMrgl8abFNtc=;
        fh=Bokjr9AkbECNY8dKgS0tQSVOZe5n9MtruMYUnGCg/nU=;
        b=bv6KRR8oSSz06BhXWtZtZTh0p5rK8UCZ6eO7ixTG2xO51x6XRN6PRUjOpkkcFL9Ag+
         D9LTm98zPDEwAq0FdYGOgLMxhPEqw1GBS0ixnfDaYIDOfR8GVQrvcEBGEDhdOM3apVdR
         1HZw1ncDXypvqmrY40pFhYqpTm3oHLm1GU81eR2W9O7t8AY9MoAVJ5NIVUsUDVwzIAwg
         Z0u5dYhk8CsMr0dVkuLkaJgnnI5DKfXMyITQ7WMSDet3GVSNjuFPRds7/Rs/czc4x+v7
         XBw2nZ3LWXKtqPqpcX4XxagMMUAsOVzbcJ6aAMTviws1esnIACobJZC1v0Sk7bZ7PHPo
         86Qg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790600977; x=1791205777; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=8Tv7M63w17ElfFd32vLV8raQp3cLLJqmMrgl8abFNtc=;
        b=aMXpcx8SJFE3wQHwSr9N1sHkKs0qRTbvmDK04fRgofO71YHobbF9PwmxYAvTcSvgZZ
         3jUI/Lftpcs2wDW4WxL8T0NWoGevp0CA0r4mQJsMF2OEhd81h6Ku8nnTxfotzxcLYYEK
         2zEj7m+HCVOYVjVa8cT7ySXvSc7Fp7SUyqtTvv2r234RfGXc+yM1z1cFlDfv4+Es/CHT
         MRVYtMOQfHp+VJ/PG2XZzpWw4ZCJCXJQv7F0UDsu00E3SqAh3ny2l7RKDqCoPP/Sz+0s
         02zTDXs1vZzVJXsPEcdnGU0VGnIx0Vlm1yIYqfgkDybvcH9B6ssZ2u4ALIMtqiwnil1s
         py3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790600977; x=1791205777;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=8Tv7M63w17ElfFd32vLV8raQp3cLLJqmMrgl8abFNtc=;
        b=G7/taKcRg0IwBuGsj7d2RY7Uc4HYxxXgvjI076Kx2SFpZqmIdl5BiwwMKN3LR9Veo/
         pv+buhLAVJcfqfQmm4+XlxhyRbvnD/qcGWEAIF7F9bnrglM/Hl6+GbU8jEk1bCbwqdeF
         idYoO2R1cMs5wbmX8BYLTp8XlTSVH3RzNyv95RFzpIKH5vGu3snlGszvejHnImlc1Pk3
         H6KFaLjiVKqlvuHZjI8CeU3tOHqrHSPPlVfiW5+5ye/GYJqlMycWXwfnQMs2f0VBYG9z
         mn5/8FRZ7uCtEF91e37DGIGYFkV3YkwT41mvVuBW14jgoF3xaCmu8VpXp7xV0FeKB1M8
         dQpg==
X-Forwarded-Encrypted: i=1; AKwUvBz5MoI2vE/10GIZ+aPkMs/aeFJvsIhVZ0N438HvwDYQxNO5dzhE3pnA8H4Tl9UgPelNPvvImwe7dDl5Xw3p@vger.kernel.org
X-Gm-Message-State: AFuF++mhpq6Y/j3uM9f63jGi5lkGxMaWtCO5VznHHtKjurhRKbS2prWI
	IoIM/RjyffbRpakS0eOXlE6eb6PVXxrfLUoFLvxeSfF+QjqK5o2rIAcyMQNuZjYUTR59pX4qTmt
	q6tM/jOGwszsLfeN7J/qPiStPYDOOiX0=
X-Gm-Gg: AYBFou3Am+BDfcI6PeY6dyt4GcAXQjCLdMpn+TuLX87up2hyZojF5CBoU2j0vPPduTz
	5bp6w8LoJ3Q4DIOCY4IIYKzAFKSelr0TYObfpSWEorqwIok0vAoHnkfF3xmt1AYYPHyl/LgcDXW
	1K08jH0A+k3nZDMGFpu9H+dtYI/BhucTZCeluisR25RLShAQcWSqI/jDnbgIc/6+rN8Sgqv9lpA
	UFtkqTx0CEdnydsrS6emFUTOUnNxCipdmD5VkMRxaKvH/5vbX1ITZzUqhAe1cHhEzFB5d+Hqaxe
	SSNT2FO439/0mAkURigsjp/KOhNicXYXu4Yp1jtpaZi34qREC7/Y2NEQuZwebmdwC2puLZo2cFm
	BEy4yD0tn8Tqv0KsmJMcKLcNZu5OcQBMQmqHYHA==
X-Received: by 2002:a05:622a:10b:b0:533:286b:f7f3 with SMTP id
 d75a77b69052e-533286c0360mr163170121cf.14.1790600976900; Mon, 28 Sep 2026
 06:09:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAAE3jtcL_CZJdcattCwe0RraKnHcZO=UknxEUQVG858ouZCUQA@mail.gmail.com>
 <7ebe4591-2306-4b5c-b83e-6a2e34b52bd8@kernel.org>
In-Reply-To: <7ebe4591-2306-4b5c-b83e-6a2e34b52bd8@kernel.org>
From: =?UTF-8?B?5aSp54u8?= <rockeet@gmail.com>
Date: Mon, 28 Sep 2026 21:09:25 +0800
X-Gm-Features: AclHuK_ZQkdzhTQ5abxUqF61EpaiFGHHGKW4iV1UiQpaKJVQSJSUXWR1OO6SJ44
Message-ID: <CAAE3jtfeKJLSypScqRAEEgvO8En5kJfpbcFn5X+LQ2YL+xz_vA@mail.gmail.com>
Subject: Re: [RFC] madvise: best-effort deferred writeback for shared file mappings
To: "David Hildenbrand (Arm)" <david@kernel.org>
Cc: linux-mm@kvack.org, linux-fsdevel@vger.kernel.org, 
	"Lorenzo Stoakes (Arm)" <ljs@kernel.org>, "Liam R. Howlett" <liam@infradead.org>, Vlastimil Babka <vbabka@kernel.org>, 
	Jann Horn <jannh@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi David,

The use case is a concurrent, lock-free, relocatable data structure that
uses offsets rather than absolute pointers. It implements copy-on-write
at the data-structure level and is designed to remain recoverable after
a process crash. We therefore build it directly in a file-backed
MAP_SHARED mapping, so its state is not lost when the constructing
process exits unexpectedly.

Building it in anonymous memory and calling write() only after
construction would lose that state if the process crashed before the
write. It would also require copying the entire structure into the
file's page cache.

During construction, writes are scattered throughout the mapping,
dirtying pages rapidly and repeatedly redirtying pages that may already
have been written back. The goal is to reduce writeback of these
intermediate states while retaining the same page-cache pages for
subsequent readers.

The hint would remain strictly best-effort: memory pressure and explicit
synchronization could override it. By "process crash," I mean termination
of the process while the kernel remains running; recovery after a system
crash or power loss is a separate durability concern.

Regarding the interface, madvise was only a suggestion. A file-level
advisory interface would also work for this use case: deferring background
writeback for the entire file, rather than individual mapped ranges, is
acceptable. The hint would remain best-effort, with memory pressure and
explicit synchronization taking precedence. It should also be cleared
automatically when the owning mapping or file descriptor is released,
including on process exit. Would that be a better fit for the writeback
subsystem?

Thanks,
Peng

David Hildenbrand (Arm) <david@kernel.org> =E4=BA=8E2026=E5=B9=B49=E6=9C=88=
28=E6=97=A5=E5=91=A8=E4=B8=80 19:29=E5=86=99=E9=81=93=EF=BC=9A
>
> On 9/28/26 09:07, =E5=A4=A9=E7=8B=BC wrote:
> > Hello,
>
> Hi,
>
> >
> > I would like to request feedback on a mapping-scoped, best-effort hint
> > to defer background writeback while an application is still constructin=
g
> > data in a writable MAP_SHARED mapping of a regular disk-backed file.
> > This is a feature request, not a patch submission or a benchmark report=
.
> >
> > Motivation
> > ----------
> >
> > Consider an application building a large data structure, for example
> > 10 GiB, through multiple passes that repeatedly modify the same pages.
> > After construction, it persists the file and publishes it for other
> > processes to mmap and read.
>
> Is it an option to just construct the data using anonymous memory and the=
n
> write()'in it once ready in one operation?
>
> Why exactly are you using writable MAP_SHARED mappings?
>
> >
> > Building directly in MAP_SHARED keeps the data in the file's page cache=
,
> > which also serves the consumers. However, background writeback can writ=
e
> > intermediate contents that subsequent construction passes dirty again.
> > The application knows when construction ends, but cannot express that
> > knowledge as a mapping-local writeback scheduling hint.
> >
> > Building in private memory and then doing buffered writes adds a bulk
> > copy into the file's page cache. Direct I/O does not itself populate th=
at
> > cache for subsequent file-mapped consumers. A memfd can share the build
> > buffer, but requires a separate object for persistence and changes the
> > consumer interface. Global dirty/writeback tuning is broader than this
> > particular mapping and construction phase.
> >
> > Proposed interface and behavior
> > -------------------------------
> >
> > Tentatively, a pair of madvise operations could express this:
> >
> >     madvise(addr, len, MADV_DEFER_WRITEBACK);
> >     /* Construct and repeatedly update the shared file mapping. */
> >     madvise(addr, len, MADV_ALLOW_WRITEBACK);
> >     /* Use existing synchronization calls if durability is required. */
> >
> > The names are placeholders for discussion, not existing constants.
>
> I don't think this behavior should be part of madvise. Way too specific.
>
> --
> Cheers,
>
> David
