Received: from mail-qk2-f41.google.com (mail-qk2-f41.google.com [74.125.230.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDC2635DA4C
	for <linux-fsdevel@vger.kernel.org>; Tue, 29 Sep 2026 04:06:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.230.233
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790654790; cv=pass; b=t7YfT4d8xVjuHNrlaPrfFegVNYryB3OwoTjrIfzBD7HCz+fs4GYkiP9r5VT7tPHFHpFvm9MXazsj/NHsYq4xWOZjT4Gc0zBDKsddoFTEjwoNNeXEPf89yJk3Da0VR2BTkF3hgURVRT7DggfVYG+v/mnzCf8U944FjxEvkZ71uR4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790654790; c=relaxed/simple;
	bh=OUqW22UO8+f58aBt4HLAJFHAQ6hQs2WZWeoUhs/jE28=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Wq5B0lA6SihQl4I2UO0VoVPieilCdLqeS+lf2Il37OJjwZpELs847VUhCJycV32LXRpV5P+U/s+UjRT5mz/2R/aCBMo1EskhsQEXG1rUghKatXmilmFTpwSEIEBX0w/6WUtWN1y69XwUKgnxCj1JKD2/2nj8D8Fi4nHo3HHVIVo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=p/w+Sxkq; arc=pass smtp.client-ip=74.125.230.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="p/w+Sxkq"
Received: by mail-qk2-f41.google.com with SMTP id d75a77b69052e-533245fd18dso20869841cf.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 28 Sep 2026 21:06:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790654788; cv=none;
        d=google.com; s=arc-20260327;
        b=Zm9rKfXNCLcG10UBPpbikO4Lv2psSZrlwd2x9ht+FwDVGq8RipUsuF5Fb1g7uXCfZl
         cCwRrRwXeM25iQyh6bESkP63Ad1fCtAN5IVQHkLWk8xS8tqfQNmB0AVQW5s9dC05YI81
         VPg8GaQA3HIZEFnUlfsqSu4X9MGY7Ql74B2ON1gyOvU/cX9/NVvSyAiMoyPas+DEh/0Z
         hT1IajNXmsuorln4D8QUhG35D3HWhcJXh42b0H675ZDgdUPM+kcm7V8S6YMaiFva781E
         a6j/gN0mkxB2A7k5ui+gcx2Wac1Nsnz1dEQE+UMjoiOYNxLRcCpcSfO9lAF7jxaveOkG
         oAQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=OUqW22UO8+f58aBt4HLAJFHAQ6hQs2WZWeoUhs/jE28=;
        fh=x5ORzegaAJxMSIQ3+f0M1G+kH/63RJpm5xsqE2vDhpw=;
        b=oSIKBKwb0+/irQrXGao2ZLKrBFYDRQDpfHFWZRP76ODTJNhiRlTqG5ch6PGi9QnjVP
         TPPP34hEnKU+IttfvsqL3ffSzG/btUnOrALPZ/YBmtXl/KdDdT6qouc2e/EZGSXKhJw3
         vMEc86IfGO8Y5SAyJzun7kOFyQ6rWkw4Pv6bEymbbualJiFDvPDng7lfx+zI/2kyeXmm
         qnpI9TXsNl89cZChqtLzg0mzTji965vtRaCp8Z4gr0N6ncqXqYUXLEqwkTH4WFzV9ML8
         3r6Hd6r7tk3spvPDWRS2FxzJzJIsX00exME1b7T3H3jeoDgORn/dStAend9PRVGwDPiV
         ihzw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790654788; x=1791259588; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=OUqW22UO8+f58aBt4HLAJFHAQ6hQs2WZWeoUhs/jE28=;
        b=p/w+SxkqHl+mU9k2R5WVG17CQZKshheL98TcoOfto53ekEWDhXkcCzAHNR0YRGmkqb
         Ea9LWL/z1LSBiSVUcY5PTE0Q5Cp+bNymyZI6ZQ67zmnSZ/cZlpPdw3B+rrEqRyWwxzMW
         SLdn/njkWN9pL81uW39ulty1A0k8tR/NUvTQq3UpOnp3Ktpi9LJOCOeqrFIzNmF404l6
         DirKRbvw+QcK0umxFirHSIOGxZLQdWv7w5xeZZSs7ZDfA18q/Zk738N1Jj1xXxtLXgpI
         AdPqEpd/Rr4UOB+E7NXKJs5GHR37ooU6lRNOZsl5OBvUCtPpFSfeKmEYD/qOrXegNeqK
         Rygg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790654788; x=1791259588;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=OUqW22UO8+f58aBt4HLAJFHAQ6hQs2WZWeoUhs/jE28=;
        b=KgM/YxE9rN/9j26UrsH569CzpdIeE5fJjYLk1tY2TaXpg0/FZ4V/CqGFdPYrWLFXRF
         8jUCRgNZbk23N91vnAoHXZtbd/RDJK/YVgqJ81+AB9xv7GcK/r1zj8cfY+bT21vRM1eF
         dtqdOj3s7i3ncCXENsPDa8E0qDNIp1wsDpfVzpADwTiBGI8aVJ1Dtn8FplTgy87Qqs0R
         zw82tBMXwTnpojlP/8DnaySg5iKWWHviY2MkoyW79dnrLPbogMdFsTE9bWzXiRnEEKFt
         CxLgH8nrDSZgSkoHXV2TSxdjL7bWK1jW4U6eHQmFYiD+X3gkRr3SkVNGKN4h5MI+1ieh
         gQHQ==
X-Forwarded-Encrypted: i=1; AKwUvBym5RZQl3hKHUr0Wp5ElCxzQL1YgGk3n7C982XaDnHBWVInefaZCmbI5viii4H7haSVayMgOfP7mBW6FJN4@vger.kernel.org
X-Gm-Message-State: AFuF++niUvI+tanxJm+MptRK2QfFSsCzUmEXUavAQ0S+KBYG7KX4Vaj6
	AJ1ukPGPUZEJLypWOfPmrWfsnhHlSIzFb9DVUVJGrXZ+jpVgNmdWanPHprbvsx2yOkf8kZfat0N
	tqU1hXOZ7gT/GLhnQoIu4xNoYC/18fHA=
X-Gm-Gg: AYBFou3ulyNJRFAldLDeoX1cOV0WVEFvbXHmCovU2E7sGYzXQAsWso3S2omBy+jmXyY
	+Rve+aJpcU02ZsAsTSrCLFgR/Mj46bmSrbQMu45W7xPwl7Tz6b9/V24M+3TjvtUdfon8AmFvqGi
	qbRGSyMIoR8Yke8+vHqam4zGf1Ww57rY20jgkEvcCAbOVqYyTstNeqeR4oibOtEj9bt7ER0R1zv
	qDfCCHw9tReEWw05D64m48VtcYcY4TWjNCcgEg0JhDTqwsu+pjsIar000Flg+7VRGf3qPAwALPV
	oVgPkIXaTyHNuWR24b1y9symnBrjtyMaIQ4GC+FkRRYEHtr+Y9zdpAGVt2fcTHo8irY2Yw38NVb
	YV4T9Q06DNsqlmgV83unnILRts9HZbQNOAwl87g==
X-Received: by 2002:a05:622a:4d9a:b0:533:33c6:e636 with SMTP id
 d75a77b69052e-53333c6feb6mr144083901cf.6.1790654787333; Mon, 28 Sep 2026
 21:06:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAAE3jtcL_CZJdcattCwe0RraKnHcZO=UknxEUQVG858ouZCUQA@mail.gmail.com>
 <7ebe4591-2306-4b5c-b83e-6a2e34b52bd8@kernel.org> <CAAE3jtfeKJLSypScqRAEEgvO8En5kJfpbcFn5X+LQ2YL+xz_vA@mail.gmail.com>
 <85aff663-2131-47da-ac04-8f0799a49b91@kernel.org>
In-Reply-To: <85aff663-2131-47da-ac04-8f0799a49b91@kernel.org>
From: =?UTF-8?B?5aSp54u8?= <rockeet@gmail.com>
Date: Tue, 29 Sep 2026 12:06:16 +0800
X-Gm-Features: AclHuK9HdKWxBr-sSsUZ5a8tjbRFwN_-vuhBxXzXtHCDYVNfVrksHL5LNaPEO2I
Message-ID: <CAAE3jtcRQ407P9LTbg=JOwhABQRViSaq2XBefnDdNWiD7PxvUg@mail.gmail.com>
Subject: Re: [RFC] madvise: best-effort deferred writeback for shared file mappings
To: "David Hildenbrand (Arm)" <david@kernel.org>
Cc: linux-mm@kvack.org, linux-fsdevel@vger.kernel.org, 
	"Lorenzo Stoakes (Arm)" <ljs@kernel.org>, "Liam R. Howlett" <liam@infradead.org>, Vlastimil Babka <vbabka@kernel.org>, 
	Jann Horn <jannh@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi David,

> What is supposed to happen if the process crashes when updating the
> MAP_SHARED region halfway through?

The data structure survives an interrupted update through its
application-level copy-on-write and lock-free concurrency design. A
file-backed MAP_SHARED mapping preserves the latest userspace writes after
the process dies, even if they have not yet reached disk, provided the
kernel remains running.

This does not depend on preventing writeback. Deferring writeback is purely
a performance optimization, not a correctness requirement.

> It would be helpful if the use case + data structure would be explained
> in a bit more detail.

The data structure originally used uint32_t offsets instead of pointers to
reduce pointer overhead. On that basis, we implemented lock-free concurrent
reads and writes, obtaining crash safety for free at the same time. We use
a file-backed MAP_SHARED mapping to turn that capability into an actual
feature that survives process crashes.

A concurrent skiplist using offsets as pointers is a simple example of such
a data structure.

During construction, writes are scattered throughout a large mapping,
dirtying pages rapidly and repeatedly modifying pages.

> Unless you would try to bypass the page cache of course (if possible for
> your use case).

The page cache is useful here: it preserves the latest shared-mapping
writes across a process crash, and subsequent consumer processes can map
the file and read the same pages. Building directly in MAP_SHARED gives us
both properties without a separate copy of the completed structure.

> What exactly is the problem with writeback here? Unnecessary I/O? Is
> writeback the problem or actual reclaim after writeback?

Unnecessary I/O. Reclaim after writeback is not the problem I am trying to
address.

During construction, background writeback can write intermediate contents
that the application will soon overwrite. Those repeated writes waste disk
bandwidth. Delaying writeback would avoid that waste where possible; it is
not required for correctness.

> In a fuse server you can in theory delay the writeback request.

Thanks for the suggestion. That sounds like a possible way to experiment
with delayed writeback. The feature I am requesting would make this
advisory behavior available to applications using ordinary file-backed
shared mappings.

> So fadvise would be an option. However, this "defer mode" is really odd.
> It sounds more like you would want to have a custom policy there [...]

madvise is not the only option, deferring writeback for the entire file
would also be acceptable.

The application only wants to indicate that it is still modifying the data
and would prefer background writeback to happen later. The kernel would
retain control over the actual timing. Memory pressure could override the
hint, and explicit synchronization would keep its normal semantics.

The hint should also expire automatically when the owning mapping or handle
is released, including on process exit.

Thanks,
Peng

David Hildenbrand (Arm) <david@kernel.org> =E4=BA=8E2026=E5=B9=B49=E6=9C=88=
29=E6=97=A5=E5=91=A8=E4=BA=8C 03:12=E5=86=99=E9=81=93=EF=BC=9A
>
> On 9/28/26 15:09, =E5=A4=A9=E7=8B=BC wrote:
> > Hi David,
>
> Hi,
>
> >
> > The use case is a concurrent, lock-free, relocatable data structure tha=
t
> > uses offsets rather than absolute pointers. It implements copy-on-write
> > at the data-structure level and is designed to remain recoverable after
> > a process crash. We therefore build it directly in a file-backed
> > MAP_SHARED mapping, so its state is not lost when the constructing
> > process exits unexpectedly.
>
> What is supposed to happen if the process crashes when updating the MAP_S=
HARED
> region halfway through?
>
> It would be helpful if the use case + data structure would be explained i=
n a
> bit more detail.
>
> >
> > Building it in anonymous memory and calling write() only after
> > construction would lose that state if the process crashed before the
> > write. It would also require copying the entire structure into the
> > file's page cache.
>
> Yes. Unless to would try to bypass the page cache of course (if possible =
for
> your use case).
>
> >
> > During construction, writes are scattered throughout the mapping,
> > dirtying pages rapidly and repeatedly redirtying pages that may already
> > have been written back. The goal is to reduce writeback of these
> > intermediate states while retaining the same page-cache pages for
> > subsequent readers.
>
> What exactly is the poblem with writeback here? Unnecessary I/O? Is write=
back
> the problem or actual reclaim after writeback?
>
> (I recall that in a fuse server you can in theory delay the writeback req=
uest.
> So maybe you could get something going by serving your file through fuse =
and
> enlightening the fuse server about it. Just a random idea.)
>
> >
> > The hint would remain strictly best-effort: memory pressure and explici=
t
> > synchronization could override it. By "process crash," I mean terminati=
on
> > of the process while the kernel remains running; recovery after a syste=
m
> > crash or power loss is a separate durability concern.
> >
> > Regarding the interface, madvise was only a suggestion. A file-level
> > advisory interface would also work for this use case: deferring backgro=
und
> > writeback for the entire file, rather than individual mapped ranges, is
> > acceptable.
>
> So fadvise would be an option. However, this "defer mode" is really odd. =
It
> sounds more like you would want to have a custom policy there, instead of
> hardcoding something that really not a lot might want. Hmmm
>
> --
> Cheers,
>
> David
