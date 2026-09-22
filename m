Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5130C49E145
	for <linux-fsdevel@vger.kernel.org>; Tue, 22 Sep 2026 20:55:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790110560; cv=none; b=d1VsffdlWc46TZeXeLpnam5tQHXiRwuvKVtzI4N315istyXrF2xpjd9jwTaM9h8XskQPqtTAQp28laFv5q1u+rgbVe4ilFxBVSNtXtEOV8XUHVaDMFI+LuHqqlTgxF1T61u9iHfadoZh+dCKK0F33p0ttnHy0zkIOdr6a200kzg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790110560; c=relaxed/simple;
	bh=p6x3aoighk00gg5seqMKSj2yW50gaB1L65MJicSOd8A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IFGq33fCbU3J5LGfb9UT0+KL2eC9FgwQVqYa5DP3yg/t1iphqYD4K83k5UHTTnwUymTD5cB4pTUQVZTMJqr6CVcndDlab/rmKLpWj++sdgnJRfVGA/7y7Ncvk2hQ0l6S/7CqBYmgPoz4hLyd6eQ2zb1ZA4VA+dYFE4qWvJQP66I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NLiwYckP; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NLiwYckP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CB8671F0089A
	for <linux-fsdevel@vger.kernel.org>; Tue, 22 Sep 2026 20:55:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790110551;
	bh=p6x3aoighk00gg5seqMKSj2yW50gaB1L65MJicSOd8A=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=NLiwYckPmHCO/uy5zqf5lUKdmRoC0FecvuYfjX0XTmcncIecz8LFB7bxxq34up+6L
	 Dg7SxVV+rrstPe6rGclYkMEmeo8FIM4EXnMsoiObCbvHLDZvFYf/ZW+CkEVJIG9ypY
	 zXO0d93fFfR2pPuXAQZfR6MfekTRU8y9grvpoHv21evU/XPfYEXZnSWiCEcJ9OvjkW
	 dExF0cQqb05KXJ1oCasvasjyNGS/1TLu7dHJTIwEseesrldMwQkB6fh8ZhnDZPkqTg
	 /foHCR7mIbRN/2plKJrx2lBD6kyxOWpXAX8xPvyy7kqCPWy7q3S7GPp1AT+F+4DwvC
	 i1HXbC88SjTaA==
Received: by mail-qk2-f12.google.com with SMTP id af79cd13be357-93910ca5aa7so29871785a.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 22 Sep 2026 13:55:51 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvBwnxi578xmEFry/rbRxXwS/aY1twcPU7COqTkT6E8ZNOFKedNxHtjjm40rMqze9YxijKm5/LP1yZ/lCnkEb@vger.kernel.org
X-Gm-Message-State: AFuF++m9/5xYZNOFvHiOYZ3lox3404ubGtCO/90GbCd0GL/BFv3c2x+9
	xTS7G3HPkY1k5c6dGoGfQgIV8eSp+0eQxL0fT20Zu/CVpTT2ckbA7QS5Suv6pULqNw//Ly1KznG
	wEGETwIajraS3IVZDH2TZvRmdw6qU5Mo=
X-Received: by 2002:a05:620a:3197:b0:93b:d79b:9a5c with SMTP id
 af79cd13be357-93c2523ced1mr99421785a.61.1790110550897; Tue, 22 Sep 2026
 13:55:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260921152449.629486-1-alex@ghiti.fr> <70cae945-3a4a-40db-96ac-5ce66a3fa186@kernel.org>
 <CAGsJ_4y8-wD0yMV8GCtCz5MfNrOKqUaTd+UgH=8MoP_nuvPnGg@mail.gmail.com>
 <108487b7-0529-4282-b5f4-355804b4c0cf@kernel.org> <CAGsJ_4zGmGh70QtRBpnhueev3qt_bgB4ZiE9fkW-hgNjAVhv+w@mail.gmail.com>
 <2e695c8a-4212-42b5-bb51-fbe1aa162e1d@kernel.org>
In-Reply-To: <2e695c8a-4212-42b5-bb51-fbe1aa162e1d@kernel.org>
From: Barry Song <baohua@kernel.org>
Date: Wed, 23 Sep 2026 04:55:38 +0800
X-Gmail-Original-Message-ID: <CAGsJ_4z2nakqBCKd_uAn4bfub99r3NJt2spOUx-K0M7bHW3_-w@mail.gmail.com>
X-Gm-Features: AcwNN1U2jjkVaezVAxwcNpi00SANdjvUN0D07XxKUusJlvcnrdo8G4HZCjz1Os0
Message-ID: <CAGsJ_4z2nakqBCKd_uAn4bfub99r3NJt2spOUx-K0M7bHW3_-w@mail.gmail.com>
Subject: Re: [PATCH] mm: madvise: drop MADV_PAGEOUT folios at swap writeback completion
To: "David Hildenbrand (Arm)" <david@kernel.org>
Cc: Alexandre Ghiti <alex@ghiti.fr>, akpm@linux-foundation.org, willy@infradead.org, 
	jack@suse.cz, liam@infradead.org, ljs@kernel.org, vbabka@kernel.org, 
	jannh@google.com, chrisl@kernel.org, kasong@tencent.com, 
	shikemeng@huaweicloud.com, nphamcs@gmail.com, baoquan.he@linux.dev, 
	youngjun.park@lge.com, qi.zheng@linux.dev, shakeel.butt@linux.dev, 
	axelrasmussen@google.com, yuanchu@google.com, weixugc@google.com, 
	hannes@cmpxchg.org, mhocko@kernel.org, yosry@kernel.org, 
	chengming.zhou@linux.dev, kunwu.chan@gmail.com, tz2294@columbia.edu, 
	hch@lst.de, linux-mm@kvack.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 22, 2026 at 7:26=E2=80=AFPM David Hildenbrand (Arm)
<david@kernel.org> wrote:
>
> On 9/22/26 12:37, Barry Song wrote:
> > On Tue, Sep 22, 2026 at 6:20=E2=80=AFPM David Hildenbrand (Arm)
> > <david@kernel.org> wrote:
> >>
> >> On 9/21/26 23:56, Barry Song wrote:
> >>> On Mon, Sep 21, 2026 at 11:37=E2=80=AFPM David Hildenbrand (Arm)
> >>> <david@kernel.org> wrote:
> >>>
> >>> For synchronous I/O, such as zswap and zram, the memory is released
> >>> immediately after sync I/O is done.
> >>>
> >>> For asynchronous I/O, such as NVMe, the swapcache is currently
> >>> expected to be rotated back to the tail of the LRU and wait for
> >>> another scan. Alexandre once mentioned that when he tried handling
> >>> async I/O the same way as sync I/O=E2=80=94releasing the memory once =
the I/O
> >>> completed=E2=80=94he saw some regression. So, delaying the release un=
til a
> >>> later scan may allow swapcache hits before the folios are eventually
> >>> reclaimed.
> >>
> >> "may", do we have any evidence that this actually is relevant in pract=
ice?
> >>
> >> We asked to reclaim memory. We wrote the memory out to disk. We unmapp=
ed it from
> >> the page tables. We made the workload the could, access the page immed=
iately
> >> again suffer already.
> >>
> >> We should just evict them as soon as possible to free up memory.
> >
> > I suggested this to Alexandre, and he found that it could regress some
> > workloads [1]. That is why Alexandre is only making the folios
> > immediately reclaimable for `MADV_PAGEOUT`.
>
> I really hate to add special sauce for MADV_PAGEOUT. Also, I don't quite =
like
> that we do something fundamentally different for sync vs. async.
>
> I assume, though, that async writeback that is very fast might just find =
the
> !folio_test_writeback() scenario just like the sync case. ... or if we
> reschedule after pageout()?
>
> I am wondering: if we can show that letting async swapped out pages stay =
in
> memory a bit longer improves performance, aren't we swapping out the wron=
g pages
> in the first place, and not swapping them out would help the sync case as=
 well?

I guess that's because the LRU is not always accurate. There are cases
where our prediction of future access patterns may be wrong, resulting
in refaults?

Even on Android, which uses zram with very fast synchronous swap-out,
I can still hit the swapcache from time to time. So perhaps with a
slower device, such as an HDD, keeping the swapcache around for longer
could allow applications to hit it more often?

>
> >
> > See Alexandre's description:
> >
> > "Future work
> > -----------
> > Barry suggested extending this to MADV_PAGEOUT and general reclaim. I
> > prototyped dropbehind for all reclaimed swap folios and it regressed
> > sysbench OLTP throughput by ~15% on NVMe swap: dropping the swap cache
> > immediately turns cheap in-cache refaults into disk reads and collapses
> > swap readahead clustering.
>
> Thanks, does this represent a workload pattern we care about?

I don't know. Maybe Alexandre can share more details about this
benchmark. I'm also a little surprised by the 15% regression in
Sysbench OLTP. My initial feeling was the same as yours: we should
release the memory immediately after writeback completes, for both
synchronous and asynchronous I/O.

Kairui also mentioned to me that he once tried releasing memory
immediately after folios were written back to HDD, and saw some
serious performance regressions as well. Maybe Kairui can also share
some thoughts on this.

Best Regards
Barry
