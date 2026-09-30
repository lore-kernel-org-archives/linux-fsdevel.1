Received: from mail-qk2-f43.google.com (mail-qk2-f43.google.com [74.125.230.235])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 727E345560A
	for <linux-fsdevel@vger.kernel.org>; Wed, 30 Sep 2026 10:27:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.230.235
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790764051; cv=pass; b=sATm8wbkoBSejtfhZ1cz+EjCZN+4Ta/L5IMhU8LonoQiH+RLYFcAK72qbh3a9lUz6jhTKHZVOzrr6tuoIblq3ZQC+0/YMo+x2ZahGFgnyDVq0ptawAClBvFuEzPdoubZjesi3O0BgZYcbXTAiVlA6b4X7jkIl9szAKi2gm2bHKQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790764051; c=relaxed/simple;
	bh=1bhyfk1ADE8+nR+UpUvKzTDyETELacsIgwqRNvLeG9o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=j85dY08XUPQ7+sojIh6lCDCHJ4U3QWy4AglwrdU1z33WMvytKm5aMae2isTfDNbiSUubYx7F8hJawwI4Dqq9IjabqrFUEpa4l0N6x40mtyBTaOOt0oQG4+D/1Ych7fITwqOR7no8RIiFKjxVWkDbZYcxr4Ftz+/Hc24aQf7n/+4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HvZbFdB+; arc=pass smtp.client-ip=74.125.230.235
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HvZbFdB+"
Received: by mail-qk2-f43.google.com with SMTP id d75a77b69052e-530e28a62abso76785711cf.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 30 Sep 2026 03:27:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790764045; cv=none;
        d=google.com; s=arc-20260327;
        b=UxNpRo47jOV89HQm8zf6mFRk6EN6QiMket6CfA3ejaWmNrch38z0JwfkX0UQmUwFtp
         J2ssGZdeWijV9oBPwE3cFhu8Tvqf5+tgG2yX9qoDqurjdjx0r9kRJ5baQXv6uVMCKJ0+
         TnpyXsAiAWllDa1AA5hzSAAfpLoNz6A2yGlvIUw/B8EnikJjDOdZgqUtBMeN600ywP1F
         Fnb1+HA/uDWaM8WVYHgLQMOVs3QmbbCSr9YoH3msiitBSSxlNdoh5Lr75MDqmVQjvcz7
         XI1bGmi9N0fK0ukyoOKgI2ruO/RK396AwJF1B/FOUSJqsLVpHUF+tvRQHeb9fPzsfHdR
         6c9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=1bhyfk1ADE8+nR+UpUvKzTDyETELacsIgwqRNvLeG9o=;
        fh=2l7LYtHw+JYfsqZjCGvlO6Po34z8AugAg6TayHudH3s=;
        b=kyF/Qw4mXZ4QZYX5TWTD6eW+5J1zArJSzNWaUXcSnDuHHdafqhSg+YrnB7cBj62Ipl
         BC3PWqpDwfk6Efq9OB/fxCqkRsNn52EJxIFUqqqVB/ooT2GwNlzUOFilOBY4HgHHORE3
         EBgghsMTaRYNwXBN50b6kD5nihgMYZeDY+Rei3/xBo8C0gSCaGDVxMSBoCUcBXdyo2xP
         NyrgvOF7k/x7mTzKS4sTjJvETWPEzHnVdMpsURQ6vLNeZ7lHJ+yTVbdGHiVvgZbII415
         YwOTjw1t4cwT0f/IbW/gtUg59xGxILiGJpxzWDv5pcShxoi/vk10esWojtLYUAROQucY
         HAZw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790764045; x=1791368845; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=1bhyfk1ADE8+nR+UpUvKzTDyETELacsIgwqRNvLeG9o=;
        b=HvZbFdB+V/MBvlYJGdy+FUssdchjfx+qqs16V7R57Gqz+2kcIb/fGdBo20bj8Sx+hQ
         IAWsLX1ZTaz1Y8zQ7sjWTHrZ8/nj32rYXn16aPJEGVEjrsjb2NCTATY1xfmvOaq3EKL8
         e1+gOgAfm/MdQiW3JtgagNgOmUGFDnYmqROeWqGGPeKhMlgsgrOdDQQbq5prIfZLDCli
         ZTEa17nQS72mTR8LTbxpzz7CqHYt7ZQvoEdTww0enP85h7EZAQZuJrE7xbbVRrjYH29D
         ONx7bhQkiQr3pIIe5PeGNGg7u98ckT54vy/vxkbf0cD5B9lyCgP/ED0LmnqNAMbMCfkM
         RxRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790764045; x=1791368845;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=1bhyfk1ADE8+nR+UpUvKzTDyETELacsIgwqRNvLeG9o=;
        b=cY6rhIabVQzB80DV9Xcg1By+UARFwlRQFTGEjnIM8CoC3cdfGTDxBpRYXOcskKIO/2
         mxqyo+paacuQA7nZISNkS5zLst1wdkTISs9N6Nb0okuohWS5RcNwQZLFdwclq6gyNqrC
         0bWyXKXfBK6zBNTmnGz78AsSs4Bm748T1+JoGCeoR0eUHsTZzTbRyi/SySUbMASxiC3Z
         EUGVB/AzqhtaqANLHDXLAEZmYog4kj/Nir7LMA/jJhU7+/kmapyx5ldztHOIcn+WROkZ
         I7tARucw/aWdivgxMWSLKujXJqyAct7O2dUbl95n4ogPSo3vGkQJT3iGN44XjLS+X4oj
         iHsA==
X-Forwarded-Encrypted: i=1; AKwUvByyaSnNoh1P9GFRfhD6Yk5uuvxSKUy2hIJSxlTZEXyVt/g+ibI3axK/2VnfkXt2jQXc6DaZM1A20fpeo073@vger.kernel.org
X-Gm-Message-State: AFuF++lP2WiGS72FGU5CkLjcz1Jlqo7ylIg0/aqtWoDDxFpdeVmjVBh1
	e/YiCGygWzbnpaMDWwvHU2tiK8ziOUqyisD5JXhuVUF+Ck78yYs/lDi87UN3nMFPCGK1yC9KSfi
	D956mg9euN+T/yNRHpDMaWoK7O4gVtWI=
X-Gm-Gg: AYBFou1GRnqiAP0vJ4ngiztyeFS2aKCj25q033jV87gc2MjiO+XQzQT7ERLho/aLk9w
	BuG6L0pLiG8/9FF+VbJ9Bnm0D8g0vYPQ5XXJbKZBK8Twp1t8nxaxjuc44zWy+WDkIZZS9eeCwTx
	4USHU0diiOC71Vjw3ZeYWXgNtYh3E4Kc1gAHQuE3uKyEBzgaI1xc2oPSvHhCL1MqHjXF5DclEkw
	NJG9N6SNhqCnbu5VG6CwANXTq0dOC4hU4SWI5uy37S9VbjVTLHI0hLX65q6tCa9foh44AHJkHRK
	0HSX8NUEmc6qEcs/nKgfqXerXQ0Mm/zc4kYU+CVykLx9bkt34zV3CoLB2aN8dXn5hhb+JwLRI2D
	TN2ZPN8R/L0GL711udxXI7wvJytwa51FpR+Q26w==
X-Received: by 2002:a05:622a:2593:b0:533:2ed5:3191 with SMTP id
 d75a77b69052e-53374d2ed19mr14887221cf.34.1790764045045; Wed, 30 Sep 2026
 03:27:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAAE3jtcL_CZJdcattCwe0RraKnHcZO=UknxEUQVG858ouZCUQA@mail.gmail.com>
 <7ebe4591-2306-4b5c-b83e-6a2e34b52bd8@kernel.org> <CAAE3jtfeKJLSypScqRAEEgvO8En5kJfpbcFn5X+LQ2YL+xz_vA@mail.gmail.com>
 <85aff663-2131-47da-ac04-8f0799a49b91@kernel.org> <CAAE3jtcRQ407P9LTbg=JOwhABQRViSaq2XBefnDdNWiD7PxvUg@mail.gmail.com>
 <1ce9cf3a-15dc-4815-ba29-2e22b05206fb@kernel.org> <art8EKRKMdwSDCkr@gremlin>
In-Reply-To: <art8EKRKMdwSDCkr@gremlin>
From: =?UTF-8?B?5aSp54u8?= <rockeet@gmail.com>
Date: Wed, 30 Sep 2026 18:27:14 +0800
X-Gm-Features: AclHuK-4Kbsa_X5iz4H6jHTRUMy1VIoQyPoWQlC8GcQsmw033rYSNdAy64prik0
Message-ID: <CAAE3jtftxMkCfWJ77W-xvV2x7jdAN8C8kyofYC3fEivM-Cq6UQ@mail.gmail.com>
Subject: Re: [RFC] madvise: best-effort deferred writeback for shared file mappings
To: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
Cc: "David Hildenbrand (Arm)" <david@kernel.org>, linux-mm@kvack.org, linux-fsdevel@vger.kernel.org, 
	"Liam R. Howlett" <liam@infradead.org>, Vlastimil Babka <vbabka@kernel.org>, Jann Horn <jannh@google.com>, 
	Matthew Wilcox <willy@infradead.org>, Jan Kara <jack@suse.cz>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi David, Lorenzo,

> You really need an actual file on disk. Shared memory / shmem / memfd is
> not sufficient?

Yes, an ordinary disk-backed file is the intended output, and subsequent
consumers access it through mmap.

Shared memory can preserve state across a process crash if the shared
object remains alive. However, using shmem/memfd would introduce a separate
staging and transfer step to put the data into the final file. Building
directly in a file-backed MAP_SHARED mapping lets us preserve the latest
userspace writes across process crashes and retain the same file-cache
pages for subsequent consumers.

> I also assume MAP_PRIVATE mapping the file so it's anon CoW'd is not
> sufficient either?

Correct. With MAP_PRIVATE, modifications remain private and are not carried
through to the underlying file. If the constructing process crashes before
transferring those modifications to the file, another process reopening the
file cannot access them. That would lose the process-crash survival
property we obtain from MAP_SHARED.

> It'd be problematic to effectively corrupt the page cache by saying "hey
> this is dirty but just clear dirty state and pretend this is what the
> disk has".

To clarify, the proposal does not involve clearing dirty state or
pretending that memory and disk contents match. The pages would remain
dirty and continue to count toward the existing dirty-page limits.

The requested hint only expresses that the application expects to modify
the data again soon and would prefer background writeback to happen later.

> Delaying writeback could interfere with the writeback balancing logic.

I understand that concern. The hint should not exempt the application from
dirty-page limits or throttling. If writeback is needed for balancing,
memory pressure, or explicit synchronization, the kernel should override
the hint.

The intended benefit is to avoid writing intermediate versions when the
kernel has room to defer that work. There is no requirement to prevent
writeback until construction finishes.

madvise is not the only option, deferring writeback for the entire file
would also be acceptable.

Could such an advisory preference be accommodated within the existing
writeback balancing policy while retaining its limits and fairness?

Thanks,
Peng

Lorenzo Stoakes (ARM) <ljs@kernel.org> =E4=BA=8E2026=E5=B9=B49=E6=9C=8829=
=E6=97=A5=E5=91=A8=E4=BA=8C 16:59=E5=86=99=E9=81=93=EF=BC=9A
>
> On Tue, Sep 29, 2026 at 08:59:57AM +0200, David Hildenbrand (Arm) wrote:
> > On 9/29/26 06:06, =E5=A4=A9=E7=8B=BC wrote:
> > > Hi David,
> > >
> >
> > Hi,
> >
> > >> What is supposed to happen if the process crashes when updating the
> > >> MAP_SHARED region halfway through?
> > >
> > > The data structure survives an interrupted update through its
> > > application-level copy-on-write and lock-free concurrency design. A
> > > file-backed MAP_SHARED mapping preserves the latest userspace writes =
after
> > > the process dies, even if they have not yet reached disk, provided th=
e
> > > kernel remains running.
> > >
> > > This does not depend on preventing writeback. Deferring writeback is =
purely
> > > a performance optimization, not a correctness requirement.
> > >
> > >> It would be helpful if the use case + data structure would be explai=
ned
> > >> in a bit more detail.
> > >
> > > The data structure originally used uint32_t offsets instead of pointe=
rs to
> > > reduce pointer overhead. On that basis, we implemented lock-free conc=
urrent
> > > reads and writes, obtaining crash safety for free at the same time. W=
e use
> > > a file-backed MAP_SHARED mapping to turn that capability into an actu=
al
> > > feature that survives process crashes.
> >
> > Ok, thanks. Just be sure: you really need an actual file on disk. Share=
d memory
> > / shmem / memfd is not sufficient?
> >
>
> I also assume MAP_PRIVATE mapping the file so it's anon CoW'd is not suff=
icient
> either?
>
> > >> What exactly is the problem with writeback here? Unnecessary I/O? Is
> > >> writeback the problem or actual reclaim after writeback?
> > >
> > > Unnecessary I/O. Reclaim after writeback is not the problem I am tryi=
ng to
> > > address.
> >
> > Ok.
>
> I mean if you're mmap'ing it you're literally mapping the page cache foli=
o and
> dirtying that folio.
>
> So the kernel really does have to do writeback and it might be quite prob=
lematic
> trying to prevent the writeback algorithm from doing its work on a specif=
ic
> range.
>
> I think the shape of a viable solution really is either MAP_PRIVATE-mappi=
ng it
> or using some anon shmem/memfd as David suggests.
>
> I think it'd be problematic to effectively corrupt the page cache by sayi=
ng 'hey
> this is dirty but just clear dirty state and pretend this is what the dis=
k has'
> or something.
>
>
> >
> > >
> > > During construction, background writeback can write intermediate cont=
ents
> > > that the application will soon overwrite. Those repeated writes waste=
 disk
> > > bandwidth. Delaying writeback would avoid that waste where possible; =
it is
> > > not required for correctness.
> >
> > Understood.
>
> Yeah again delaying writeback could interfere with the writeback balancin=
g logic
> which tries to keep dirty page levels sane and is fair and balanced so pr=
ocesses
> that writeback a lot get delayed in doing so under heavy dirtying.
>
> I think anything like this would interfere with that.
>
> >
> > >
> > >> In a fuse server you can in theory delay the writeback request.
> > >
> > > Thanks for the suggestion. That sounds like a possible way to experim=
ent
> > > with delayed writeback. The feature I am requesting would make this
> > > advisory behavior available to applications using ordinary file-backe=
d
> > > shared mappings.
> > >
> > >> So fadvise would be an option. However, this "defer mode" is really =
odd.
> > >> It sounds more like you would want to have a custom policy there [..=
.]
> > >
> > > madvise is not the only option, deferring writeback for the entire fi=
le
> > > would also be acceptable.
> > >
> > > The application only wants to indicate that it is still modifying the=
 data
> > > and would prefer background writeback to happen later. The kernel wou=
ld
> > > retain control over the actual timing. Memory pressure could override=
 the
> > > hint, and explicit synchronization would keep its normal semantics.
> > >
> > > The hint should also expire automatically when the owning mapping or =
handle
> > > is released, including on process exit.
> >
> > Ok, so while you are updating the large mmap'ed file concurrently, you =
don't
> > want writeback to go crazy, because you know that you will modify the m=
emory
> > immediately anyway.
>
> Yeah see above, I really think the only sensible solution is a MAP_PRIVAT=
E CoW'd
> mapping or memfd etc.
>
> >
> > Let me CC some more people.
>
> Christian and probably Willy also? But I'm not so sure there's anything s=
ensible
> to do here other than something-anon.
>
> >
> >
> > --
> > Cheers,
> >
> > David
>
> --
> Cheers, Lorenzo
