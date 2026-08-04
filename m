Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 482912E738F
	for <linux-fsdevel@vger.kernel.org>; Tue,  4 Aug 2026 03:09:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785812991; cv=pass; b=uAHJiSobaJLo+xQW1NoSbUBgtQEHXCKv8jPdOePC9E4hvrekfr0QSGgqRQ/dh+SsXGPnqPIUj041sI4ZVmk8bIShd/8kSRISabssZEJ2RFvVLPMdV8OgxrQpZa20eeGLlWHnjoLUfsi4fi/5RlpVsMkmHepNYto/c8o3xw2N4w4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785812991; c=relaxed/simple;
	bh=PaXew+FZpfDX6CTHu7tlK3pwxbda2KE6TQKtVwb/Pgk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=n/trYuwp/K7QMOYxqRKiAhjT8dx/nJUJs8JdRv4bAcTIkQNRx8UkrOrg0oib7JWTgrpsYUbmpV8/CcHAejqhg1aZw3GdmlDTILg75qRgWsFsSqor3RTOb5rXXhjv9bkVAoMndMJ1fBySJtWEDEUzx8eSeigekXSn2Y23Vd3KZpE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=W0vixZ4m; arc=pass smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W0vixZ4m"
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-c1c50c1e29bso579333866b.3
        for <linux-fsdevel@vger.kernel.org>; Mon, 03 Aug 2026 20:09:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785812988; cv=none;
        d=google.com; s=arc-20260327;
        b=JnwzJHATW++b9CfsOUl0gkWoMDsm/UWScTSreqBwdJefi8WtdJhZSAcic4fYf5F1SL
         MQllMZZit0SNl3CUv0/UANbqTaJq5q8Vg7W0rywCKGHlorXqOPXT5F2tRE/m2/ACCgy4
         cMvM6C6M5/xCfEGojEBenKj11WViHDP7E93XlFAYV+0CTVg0t+az165AZK7ND0ZOMKya
         M7/xb1knvoPj7/LhcY0P6DTV8oOfWoV4/fKpR1Ho2NHP0Pyz6MmS7LDXFv5xR6A/L5c0
         1i1+pIyTrsWtmo6s/HFxM9LBJEK6L9di0XFFkHpbPXfzEO+cb7KMgmfQnZs6Mt01lKNF
         EVWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=+lD7EshW+wqvTAIy0+vw88oURzXcR3MWC7k5l35qTt4=;
        fh=pVoNshpgKWXM9LAkZs6Fd+qcV1NlazC3E5s4vExRNtA=;
        b=NuI6yLRQkoLAEWpY1u9JcFQKHt18LIX2gbL6Fv6gbjyI3h8NLKgDH8YVf2WEehso2H
         I76o3WqVddPEpEbUtj12R6ZLsjZQqH+vS69Z+Nj5XoH3fJVCdWhmfvaJ6jaNXBpJ0EkA
         coHHXDpDMiZ/CQpLfu+49t81q4yOCI88DA2XH7f/xICrNYuAiY9BFJaXW1yDkcYG+XOB
         tzKuQNtkWCQql9YvX2CALA7iogrpgfJkC92bUEaoiyut/zTtYbRJCws14qhdZmqZFqZJ
         44cWtUIdRMwXWyVMRYPVXuVAgFk/Jwi8l1QBNTHjPsWHU8XRg8EA2/LYx61Rk2sw2UJn
         1VWg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785812988; x=1786417788; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=+lD7EshW+wqvTAIy0+vw88oURzXcR3MWC7k5l35qTt4=;
        b=W0vixZ4mH8nO5nYFFd4tX5PlQH++Yf1p09jx1ASvp60eltDIA7vkPxHdcdcYQ3Z6UG
         sRBIX4PTmhzL0+2UkHpmslhFdcu8kOaXC0o6u4hSpgRU9UtjO0Vb+3UalSyCZt2ibqIO
         YT7EIBJ6FI5QhryYyxIfPOrqNRebxpPwaw+Wb4iVuwnUbMMDY1ibUc7HaENd9k/4w53U
         BYDsGiMwN0W/7zm5ABhKG6x8hG9NDJvTe468qE/R/+SJx6J5Z4bOLhlHf4dOjSv36z/R
         9NiwAR+g2zZp+J9fvnC/87593CktvbatoiGoB7s3ClDSdu2EnslQZGP1DduXsRzlxWhh
         JokQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785812988; x=1786417788;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=+lD7EshW+wqvTAIy0+vw88oURzXcR3MWC7k5l35qTt4=;
        b=U6V7p6HJoXlRs+Y+kMmHBIloMonH89TpOz5r3poZWG+7iC1XhRPAt6CECFMnPNzYa+
         rMVgFTqb6EIjrhmh3pxb9M2SqNJ5a9jMDwM6/YCPr74Q3q7+4nMATSrtML3qv7puSyaG
         xTYmQHyXPZb23rsfqK/ROOC7KbZsc4csOA6eFYli5pP3tqYb++KFu9Qyro64HazUr/37
         2Q78iobCaa2tusEGj5IoUefnithqK6CePYncextTTtRKRe1reV5ZPYgu1XlWW10qIKHf
         QHzMNjyjtD6TofPx0oa4+aGkWjeK/PYZeo7FNwSDI4YaA2t5ot1ly5yxGGUWDf+5Bsw/
         5mdA==
X-Forwarded-Encrypted: i=1; AHgh+RpCKlFO1Qr+oFGHiaT9M9SQIFi21lK0q/w7VzYH9aTC1pJF+3eLu3DMa4u1TiHlf3+HZcTNyGzNtSMEL//H@vger.kernel.org
X-Gm-Message-State: AOJu0Ywb92t1XumdedT4V97QtpVSxteJQ50JN+opSOT77YM8BZsrwsRd
	sfiifaP/8hKue9d8YTgNSLGuZOw86bLTaouHMc6a1eXtLvk21Qes5eompjL0WBeLfjkZBvt7tXy
	xHm2aWuS3r7Qwaq6FleegQz5QicEKaxE=
X-Gm-Gg: AR+sD11bQc6VHGx6HoJ5wX/Pw2JVW2bPuDaoR/Gu1ZqMb92T/b8pSMV6WeO5iVaYJQQ
	Q/dSWGlmA0XB4LKS4IVMlAtZpY/0oPgYU/1YADXNKbtcLVSrZErMRQVAxkfIL0achr6eb9Okvj6
	R9536Xk7jlj/q5wWwdFgT4UPrFg297M1ZMk6l4W5g8ROTeMNYGDYUwDbAujLln3LH3HwsDfLMbN
	+zl95nVDXJqyH5vYtvJpok5mR2rYWqk02YeYRVoAcUsvZw51XqCTYNttNtgJUOTdw4v72UG5Al/
	auk8/65XE2r10ESAB5DdZX9Qb30ScWpiUceyaabUjNfKBPFsx4V1NkS05nKQCMNbwEcIB/DYpn1
	+HQ==
X-Received: by 2002:a17:907:c18:b0:c15:a1e8:c141 with SMTP id
 a640c23a62f3a-c1fe8205b11mr1194078366b.30.1785812988580; Mon, 03 Aug 2026
 20:09:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260730-add-gfp_account-to-xas_split_alloc-v2-0-5a56c2361d85@nvidia.com>
 <20260730-add-gfp_account-to-xas_split_alloc-v2-1-5a56c2361d85@nvidia.com>
 <am28pV2PEfHsi4p-@lucifer> <DKFEEI2EDS4F.1AHGKB1EL6XRG@nvidia.com>
 <anCtxQE5hDUH5N6a@lucifer> <DKFEUPDED2AF.22PKCFTWTG6G5@nvidia.com>
 <CAMgjq7CHDG8JhesSPMkn1kzG8jKb0BXO756BvxMQC_MCn2eTyA@mail.gmail.com> <D6EE6133-8B15-438C-8616-4639710F8973@nvidia.com>
In-Reply-To: <D6EE6133-8B15-438C-8616-4639710F8973@nvidia.com>
From: Kairui Song <ryncsn@gmail.com>
Date: Tue, 4 Aug 2026 11:09:11 +0800
X-Gm-Features: AUfX_myZp7suhmCghhsEDX845pFAgs6S7SpJWDhswAN7FOhlW09QWQBizRnPBhM
Message-ID: <CAMgjq7DjCVxLLXU15ue6MVrqvWqW6goED_0QZLQ=USNJm9c4TA@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] mm/huge_memory: use folio's memcg inside __folio_split()
To: Zi Yan <ziy@nvidia.com>
Cc: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>, Johannes Weiner <hannes@cmpxchg.org>, 
	Andrew Morton <akpm@linux-foundation.org>, Matthew Wilcox <willy@infradead.org>, 
	William Kucharski <william.kucharski@oracle.com>, David Hildenbrand <david@kernel.org>, 
	Baolin Wang <baolin.wang@linux.alibaba.com>, "Liam R. Howlett" <liam@infradead.org>, 
	Nico Pache <nico.pache@linux.dev>, Ryan Roberts <ryan.roberts@arm.com>, Dev Jain <dev.jain@arm.com>, 
	Barry Song <baohua@kernel.org>, Lance Yang <lance.yang@linux.dev>, 
	Usama Arif <usama.arif@linux.dev>, linux-kernel@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 4, 2026 at 1:55=E2=80=AFAM Zi Yan <ziy@nvidia.com> wrote:
>
> On 3 Aug 2026, at 13:25, Kairui Song wrote:
>
> > On Tue, Aug 4, 2026 at 12:53=E2=80=AFAM Zi Yan <ziy@nvidia.com> wrote:
> >>
> >> On Mon Aug 3, 2026 at 11:07 AM EDT, Lorenzo Stoakes (ARM) wrote:
> >>> No __folio_split().
> >>>
> >>> Comment about cleanup.h really was the whole pattern of goto xxx for =
various
> >>> levels of unwinding things.
> >>>
> >>> But really I mean the folio splitting code in general, there's a lot =
of
> >>> massive-complicated-functions with a million things going on at once,
> >>> __folio_freeze_and_split_unmapped() is another.
> >>>
> >>> Feels like we should really have this stuff in something like mm/foli=
o.c anyway
> >>> too now that's renamed :)
> >>>
> >>
> >> I agree that __folio_split() is handling multiple cases, anon, shmem,
> >> pagecache, all together. Do you prefer:
> >>
> >> 1. split __folio_split() to handle each case in a separate function wi=
th
> >> some code duplication, like xarray for pagecache and shmem,
> >> freeze/unfreeze folio for all;
> >
> > Hi all,
> >
> > Do you like a __folio_freeze_split_unmap /
> > __folio_freeze_split_unmap_file split? :),  I'm asking this as I'm
> > currently trying to sort up the mess about swap cache in huge_memory.c
> > and found it will be much cleaner if we move file related code into
> > __folio_freeze_split_unmap_file, and let __folio_freeze_split_unmap
> > handle anon and swap cache, and then saw the discussion here. (A bit
>
> Sounds good to me.
> Maybe s/__folio_freeze_split_unmap/__folio_freeze_split_unmap_anon/
> to be specific?

We will have to deal with clean (not yet added to anon) swap cache;
I'm not sure if that counts as anon? I'm fine either way about naming
though.

> > more detail on this, I think we ca just assume we just don't need or
> > want shmem swapcache split, because shmem swap cache is meant to be an
> > intermediate state during IO, and shmem drops swap cache once IO
> > compete, and hybrid half-tmpfs-half-swap state is really ugly and
> > should be avoided competely, swap cache lookup is still fine for shmem
> > just make sure the folio is not in shmem's mapping).
>
> The reason looks good to me. Can you remove the shmem in swapcache TODO
> and firmly say shmem in swapcache is not supported due to the above reaso=
n
> when you split the code?

Sure, will do. Thanks!
