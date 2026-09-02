Received: from mail-vs1-f49.google.com (mail-vs1-f49.google.com [209.85.217.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91C0348AE1B
	for <linux-fsdevel@vger.kernel.org>; Wed,  2 Sep 2026 13:44:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.217.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788356690; cv=pass; b=BtihX9jIdaB9Zx7/r9lb6iNRCnAfurobZDFh+VLuA4DPz22HqQSyLbLEVRxo/2BFOL4B9vSOAzypXXl2mCmE0LHsc88ZiT0ma5bS5xdC61fCbkioGNK0hLX2nAFRsQvSwqmcJtzGlCY9xMTxy/WrwnCl5cN/pDIQspV5fWQO3HM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788356690; c=relaxed/simple;
	bh=1FmV1x5QxFOQdXdzoayVGJUSKQjfwQz5XyfnM7vvKJw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sy67MIyp5cv79HXiGB5PClFIWOAuF+w7Vo4TyZNPUtTPEWpkTSsb9o7rWp9+nzNWS3FUaO11EsIudUq3nV1hTJyBh3l64rHIEhSYbBvs8YhIZCGheSxmik07mtiuuGuSCzL19jzONZtAwnhEBURawzrNlDojTDR1FbjTmGSujpY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PY+flS2A; arc=pass smtp.client-ip=209.85.217.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PY+flS2A"
Received: by mail-vs1-f49.google.com with SMTP id ada2fe7eead31-78a1dea6958so617832137.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 02 Sep 2026 06:44:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788356687; cv=none;
        d=google.com; s=arc-20260327;
        b=Ud8zNMCTYcZFHGdoLIyRDKHl/Nd0Cv8BePxVhDIAsqW/C8PPYI8qWwNgnw125e6SwK
         v2vJ+s0NaS/3JbG9C1/AifRAvB8LIEV5eQjeeXbv2iJsvLRIocK5pmrsC5LI8TO9QbMu
         qDKgFBkhfbZiwrZmAAjFf8R+znMwDWDREjlqX6xfMgUe8rgZU2UV4LnXL7wU5ql0gRYW
         Zrov2cixov4PMzHIQNZ1FLSUvLpEUKPQ9ckWL1fitABOS53VqH3XJJ8uUOZSeLopqog+
         9fG/rO7FXdPZg2vf4rJsy5sHJvDuNT3KzyqQLG4fhPxVuk678mmCE6uUT1qD7QdcbnrU
         aZuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=6dSC4i56GDCKpLLN6Iph6zr29jWx7mFCg/VcjlijsBo=;
        fh=+0Z7pdsKu5GoZJjW6ak/qh07fzRSH13Y5jFkGSCrOJo=;
        b=UKgi8vWV8WWLGLpFwW4oN1p1LW9EjqJ5w/UDNAD2Mu2ztJLnvVUFQT9gRv9e5caVV4
         /MaQm0SjRpJP+drqo/di0uyuua08zahbxew+49EfKznw3HDVgwkzAWlCvlwtPPFXJVXD
         4vpY9l1WwjVng1meVL14Diel+RkDDofc2MRCYifHKOP8TN3bs/jW6dRe4WG/Ruz57fCO
         Q0Y9UobvtDOXZcETOIHQSkRUCa7jpbrvP9mAz/zsZafYlfccFUdl4hgLyZeAfVdorw0/
         7sx0i5O/NWpFejJ6airlYwh5cGsKUY9rKK7HgagP2zMG1HybbqofVK31W2Z/uALoR79k
         9CPA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788356687; x=1788961487; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=6dSC4i56GDCKpLLN6Iph6zr29jWx7mFCg/VcjlijsBo=;
        b=PY+flS2AYfW7c/WsVfXXcq47PSXzkHnQBPWB0DQgi2h+hlmuk+WNQ9IBLbzYDXTcW0
         OU1UykZC/figLH82QQvgmAL9gNw986FHtozNGKTjJs2SqYE/2GKXAph+bYJ5DO+07LOS
         gyj7yTEw7t4oskT3O4KWDtjEOH0gGjW6iDaZaRw7nve8utJhK9rMDXzHUlgsBhTEM3bg
         5GinnynACF8X4VQXlWEDRFPm4DezYMFFlCyM9/TGFPul4EeARD+XWgqNYf92xvERIQXW
         KZv2ZP34kUyLQ2fELzlfTtYdETRO4s+k7PzoEjbrqbAw5/6e8zBqz5TMNR6UHnifhLZo
         VB7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788356687; x=1788961487;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=6dSC4i56GDCKpLLN6Iph6zr29jWx7mFCg/VcjlijsBo=;
        b=MkoSpCnDUMkS3BWlGl3V4sl3XHghd8wnvBKVcLUmDFCmp8bv6/mSelrVGfB3c6Ei9b
         qSJlUPgkbo54V3B5eN+s+28E6uDjVtYGSJEWNF1YUau+6IEjdFBA78e0/Ht9bzrlNazq
         jas/xMMR8fi02SVi1WOVRqvW02P5OERgKTIhhOTJ6cSwVUbOce9L0Z7v3F/ZpoHtnvdW
         SiEBhFF/cYu2RzuvrLsbFhUaznLKKun70XDjxIxvyYG6mROCrJ4LBR09k+jHE11jvchm
         aRE8XUOEpo9WuHY3BXCxdVV3fdG0pYYHyichOgQ6pk2tEckTIcwYf5+6fen7EX7E5Nnj
         GL4w==
X-Forwarded-Encrypted: i=1; AKwUvBzdDLXE3OyZdsASpeIQixQWyg0HHO/xBAGFY+XJMovMDufmj3QSrDDw3WptWrrW134+0BUW7X7W7RSkFtlK@vger.kernel.org
X-Gm-Message-State: AFuF++kb3ZzpiMtQGfyLOMDhyM6LcbqKcynRxK0VJypsxhx15hKrJViG
	t3kWaRW0vCXG0wgVAyCuHgSeDEWwlmNlBWYyp2XMvdWEOB12vzJrX4bdrmZm4VPpGG+B4SehwvP
	qR2JivILMnYMyYvaeGUywDOk7cpS8nw4=
X-Gm-Gg: AYBFou0rrs4qb9MNE+EbET2qw05ANOkcAxkZRKbfIyWOnVGJgeXq16O/+tUVTxtQmOa
	X+30VhHH5KjQHHdD7k9uXXSb7BMspXj5pD5c/iWwdJ/+KczSQK/087cWhtLy/+ZUNgpQ8OiugxX
	+poy8m8063neHrDbvHNV0aCmBR6uAvZfC/1G9CKQrQDZsB/H/3kKGQycQ72kn1ju4HFJ6MinugT
	FwgWSRBV4bC25iyWMQiO2BmwW8RUSrxzMZEsksrE9iN+/5ne/uvDI8l0Ndlk7AsJI1ImIAuBepJ
	KYlMF9YeuMSR92r+TVlvy4P8ejJ6LATw2acA+mseEqgfmoEKUzpNQWcmuclhPtPCmvkxEfW4LxZ
	pxUss
X-Received: by 2002:a05:6102:41a6:b0:779:328:8a2e with SMTP id
 ada2fe7eead31-78a1f725fc6mr950132137.5.1788356687181; Wed, 02 Sep 2026
 06:44:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260817-remove-wait-on-page-writeback-v4-0-0e5e53d47eb0@columbia.edu>
 <20260817-remove-wait-on-page-writeback-v4-1-0e5e53d47eb0@columbia.edu>
In-Reply-To: <20260817-remove-wait-on-page-writeback-v4-1-0e5e53d47eb0@columbia.edu>
From: Ilya Dryomov <idryomov@gmail.com>
Date: Wed, 2 Sep 2026 15:44:33 +0200
X-Gm-Features: AcwNN1Vvf7FpyU1HrqjBI0mng4bI8rN-Wlo5S9DqsAbNDuh3hnayuNaPhBcoE8o
Message-ID: <CAOi1vP8SCZaFTodwm3_c9cFfc4UB5X8J8vF-sxh+4TuhCS8iog@mail.gmail.com>
Subject: Re: [PATCH v4 01/10] ceph: fix error handling when the OSD client is
 stopping in ceph_submit_write()
To: Tal Zussman <tz2294@columbia.edu>
Cc: Alex Markuze <amarkuze@redhat.com>, Viacheslav Dubeyko <slava@dubeyko.com>, 
	"Matthew Wilcox (Oracle)" <willy@infradead.org>, Jan Kara <jack@suse.cz>, 
	Andrew Morton <akpm@linux-foundation.org>, David Hildenbrand <david@kernel.org>, 
	Lorenzo Stoakes <ljs@kernel.org>, "Liam R. Howlett" <liam@infradead.org>, Vlastimil Babka <vbabka@kernel.org>, 
	Mike Rapoport <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>, 
	Zi Yan <ziy@nvidia.com>, Christian Brauner <brauner@kernel.org>, David Howells <dhowells@redhat.com>, 
	Jeff Layton <jlayton@kernel.org>, ceph-devel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-mm@kvack.org, Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>, 
	Sashiko <sashiko-bot@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 17, 2026 at 9:15=E2=80=AFPM Tal Zussman <tz2294@columbia.edu> w=
rote:
>
> When ceph_inc_osd_stopping_blocker() fails, ceph_submit_write()
> redirties and unlocks the folios remaining in ceph_wbc->fbatch.
> However, none of those folios are locked at this point: locked folios
> were moved to ceph_wbc->pages[] and removed from the fbatch by
> ceph_process_folio_batch(). Unlocking them triggers
> VM_BUG_ON_FOLIO(!folio_test_locked(folio)) in folio_unlock(), or
> unlocks a folio locked by another task.
>
> This error path also returns -EIO without fully cleaning up the folios in
> ceph_wbc->pages[]: their references are never dropped, fscrypt bounce
> pages are never freed, the writeback congestion count is never
> decremented, and the pages array is leaked. ceph_wbc->locked_pages is
> also left non-zero, so ceph_writepages_start() loops back around and
> hits BUG_ON(ceph_wbc.locked_pages).
>
> Leave the fbatch folios alone, as ceph_writepages_start() drops their
> references when releasing the batch, and unwind ceph_wbc->pages[] the
> same way writepages_finish() would have. Abort writeback in
> ceph_writepages_start() instead of continuing, matching the handling
> of ceph_inc_osd_stopping_blocker() failure on entry, as the OSD
> client is being torn down and further writeback cannot make progress.
>
> An LLM was used to verify that the cleanup was comprehensive, and
> suggested aborting the writeback instead of continuing.
>
> Fixes: 1551ec61dc55 ("ceph: introduce ceph_submit_write() method")
> Reported-by: Sashiko <sashiko-bot@kernel.org>
> Link: https://sashiko.dev/#/patchset/20260804-remove-wait-on-page-writeba=
ck-v2-0-81f0ab065284%40columbia.edu?part=3D5
> Assisted-by: Claude:fable-5
> Signed-off-by: Tal Zussman <tz2294@columbia.edu>
> ---
>  fs/ceph/addr.c | 36 ++++++++++++++++++++----------------
>  1 file changed, 20 insertions(+), 16 deletions(-)
>
> diff --git a/fs/ceph/addr.c b/fs/ceph/addr.c
> index 1f77aec8e960..d5a349daf4d0 100644
> --- a/fs/ceph/addr.c
> +++ b/fs/ceph/addr.c
> @@ -1482,27 +1482,28 @@ int ceph_submit_write(struct address_space *mappi=
ng,
>         BUG_ON(len < ceph_fscrypt_page_offset(page) + thp_size(page) - of=
fset);
>
>         if (!ceph_inc_osd_stopping_blocker(fsc->mdsc)) {
> -               for (i =3D 0; i < folio_batch_count(&ceph_wbc->fbatch); i=
++) {
> -                       struct folio *folio =3D ceph_wbc->fbatch.folios[i=
];
> -
> -                       if (!folio)
> -                               continue;
> -
> -                       page =3D &folio->page;
> -                       redirty_page_for_writepage(wbc, page);
> -                       unlock_page(page);
> -               }
> -
>                 for (i =3D 0; i < ceph_wbc->locked_pages; i++) {
> -                       page =3D ceph_fscrypt_pagecache_page(ceph_wbc->pa=
ges[i]);
> +                       fscrypt_finalize_bounce_page(&ceph_wbc->pages[i])=
;

Hi Tal,

fscrypt_finalize_bounce_page() was removed in 7.3-rc1, so this one and
patch 8 need to be reworked now.

Thanks,

                Ilya
