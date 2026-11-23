Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795396460;
	b=UXvJ7NSyvKAubb527uq2NBd6NMOIt2maxD5ba9OO9Dn4ogCjLgkFugZ4FSk0Cx7i2Js2
	 oFOXj8Pa2vvZUxwKT0rXeW94B9ufMT8MlDbHuV7bkA0su2Z4HTMGNkbQyDUuotdJ80sK9
	 no4v8Tu62nPA4ivxFGin2BDfqC/PFUVJP4Tp7iDI6qRA/oqGEjXZgMJ4cQPa1c048fbpR
	 MHvHwZFZ3w9PeroDNAGG1pw//ncWf9+Igr/wdB7fj19c8IRiSxH/BKRnaOBgD119kaJqk
	 1sShmY4DdURje3Ze2PvlEEJhqTjg6W/OFeo9yFQDOgnpt0yLzgIX8T8irbzrGva4tMQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795396460;
	h=Received:DKIM-Signature:Received:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Received:MIME-Version:References:In-Reply-To:
	 From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:Message-ID:
	 Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=beRsURI87z7ePC5UgnVhljfRVtiAk+JGSK5Yp7RQ++w=;
	b=OmWXa9WbJeMM1gqTIoIFxGi0WoDwTTznuZhQuaMH7mcs/7W6nmKp0lOk4kt0W21PIcdn
	 HWYcPoKBy84XAgs3EU7fbFeKD8LeAvn7dSSQY5+NNudXmVN5EbeyM5gpjMNuTuFttYPFz
	 F5Q/t7YgC9OFxNU973xw5KAOXm6nbaA2IP/uaheGVr64yeOuioj2qUU52TfqaS4FKh+FB
	 LT4t4JR+L3NJmMOkpggHi9wE6jmDdfr6ZJjqmwqMQ6/x5J2mqtbEFvPekPi/o8IjaePAV
	 3XijlPFqb2vWoya9Z98r4teX5TiIfyca5BYz4eeeWF7CoSip2ioJDwfr5oNwss4UBYg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Ys1yFoMi;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D331606A327
	for <linux-fsdevel@vger.kernel.org>; Mon, 23 Nov 2026 01:14:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Ys1yFoMi
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 63ADB1F0157D
	for <linux-fsdevel@vger.kernel.org>; Mon, 23 Nov 2026 01:14:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795396460;
	bh=beRsURI87z7ePC5UgnVhljfRVtiAk+JGSK5Yp7RQ++w=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=Ys1yFoMi3EImki+984yKCe81INtZaQHTXOXdANgrHv9/I07zvlyD2nTpoYX/tGYqd
	 yc6+SySpdaII+pw8XgsrTCpM3A66tynOC/z8F1MdwNB3kNHswhMNS41AJQhEFJWboD
	 kiNSWkHXDArtd5kB8OIQ2CkeuPtd6BJI9R6GnvHBzCI9uDnu81zIxw13OUZ/mEDBWs
	 ZuCk07qi0/QolXdTFeDPWAVBeP5vGK4IVAd16QuexIaRJjVoKX9uD5yUHroorHerxs
	 ih8ab7EmuB5sbtxCgrx7uzM8MHnDn47aasBHwVh/E9KhwdGLxIAV2dlKcpxcdV+/9F
	 FjfZHMSnH4gMw==
Received: by mail-qk1-f176.google.com with SMTP id af79cd13be357-94961ed97bcso314124885a.1
        for <linux-fsdevel@vger.kernel.org>; Sun, 22 Nov 2026 17:14:20 -0800 (PST)
X-Forwarded-Encrypted: i=1; AL+hErHjGJJXDTIzFbxHqbz26YbAuhkCzNHHzAFRE0AgEkcN4tOtGCh4XO/u8xrMROuQzF/uH0LdOKB0hBxWdgqZ@vger.kernel.org
X-Gm-Message-State: APuU4Z8QSlXk5qtwGOZHGRplGvOsRHPBwbyEKMYA2qnD3+QT/KKwwMif
	q9YFIk0OlJ6IopwFCmnjzvTvBlvp0dQvx0qFgMYZCIBacvUTTSwUaijvbBnnrMJa0yQbzNeMgj7
	AFULp/sg0DJhYf1qfHBK60sb3IDWGGiM=
X-Received: by 2002:a05:620a:450e:b0:949:5c62:e785 with SMTP id
 af79cd13be357-949ba9b7429mr1776786785a.21.1795396459175; Sun, 22 Nov 2026
 17:14:19 -0800 (PST)
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261122-migrate_reclaim_deadlock-v1-0-83c56185b0fb@kernel.org>
 <20261122-migrate_reclaim_deadlock-v1-1-83c56185b0fb@kernel.org> <179537313704.412063.6683001223228002260.b4-reply@b4>
In-Reply-To: <179537313704.412063.6683001223228002260.b4-reply@b4>
From: Barry Song <baohua@kernel.org>
Date: Mon, 23 Nov 2026 09:14:06 +0800
X-Gmail-Original-Message-ID: <CAGsJ_4yEeORJw8dQEH0U-JjWih3+3ZVx=1Va5F_9qsVbPzCLvQ@mail.gmail.com>
X-Gm-Features: Aa3M54qG1iauJEScw2ktzAtei45vPodUuwGuthkS3X5FKVC_OPLT-7KU2cnzR8g
Message-ID: <CAGsJ_4yEeORJw8dQEH0U-JjWih3+3ZVx=1Va5F_9qsVbPzCLvQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] mm/huge_memory: use NOFS when allocating while
 splitting folios
To: "Gregory Price (Meta)" <gourry@gourry.net>
Cc: "David Hildenbrand (Arm)" <david@kernel.org>, Zi Yan <ziy@nvidia.com>, 
	Baolin Wang <baolin.wang@linux.alibaba.com>, "Liam R. Howlett" <liam@infradead.org>, 
	Nico Pache <nico.pache@linux.dev>, Ryan Roberts <ryan.roberts@arm.com>, Dev Jain <dev.jain@arm.com>, 
	Lance Yang <lance.yang@linux.dev>, Usama Arif <usama.arif@linux.dev>, 
	Kiryl Shutsemau <kas@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, 
	"Matthew Wilcox (Oracle)" <willy@infradead.org>, William Kucharski <william.kucharski@oracle.com>, 
	Heiko Carstens <hca@linux.ibm.com>, Alexander Gordeev <agordeev@linux.ibm.com>, 
	Claudio Imbrenda <imbrenda@linux.ibm.com>, Johannes Weiner <hannes@cmpxchg.org>, 
	"Lorenzo Stoakes (ARM)" <ljs@kernel.org>, Matthew Brost <matthew.brost@intel.com>, 
	Joshua Hahn <joshua.hahnjy@gmail.com>, Byungchul Park <byungchul@sk.com>, 
	Ying Huang <ying.huang@linux.alibaba.com>, Alistair Popple <apopple@nvidia.com>, 
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, Miklos Szeredi <miklos@szeredi.hu>, 
	Joanne Koong <joannelkoong@gmail.com>, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, stable@vger.kernel.org, 
	Chris Mason <mason@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 23, 2026 at 2:46=E2=80=AFAM Gregory Price (Meta) <gourry@gourry=
.net> wrote:
>
> On 2026-11-22 13:42 +0100, David Hildenbrand (Arm) wrote:
> > Various callers (migration, memory-failure, s390_wiggle_split_folio) sp=
lit
> > locked folios without holding a reference on the folio's inode.
> >
> > Splitting a file folio might allocate memory for the xarray and call
> > filemap_release_folio(). If either ends up in direct reclaim with
> > __GFP_FS, reclaim can evict the inode through the dcache shrinker, and
> > wait in truncate_inode_pages_final() for the folio that we hold locked:
> >
> >     try_split_folio()
> >       folio_lock(A)
> >       split_folio_to_list(A)
> >         xas_split_alloc()
> >           try_to_free_pages()
> >             super_cache_scan()
> >               prune_dcache_sb()
> >                 iput_final()
> >                   evict()
> >                     truncate_inode_pages_final()
> >                       folio_lock(A)
> >
> > This requires that nothing else holds a reference on the inode, and can
> > be triggered most easily with FUSE, which evicts inodes on the last
> > reference.
> >
> > Further, xas_split_alloc() charges the XArray nodes to the memcg, and o=
n
> > cgroup v1, memcg reclaim waits for file folios under writeback if
> > __GFP_FS is set. That can deadlock if writeback waits for a folio lock
> > that we hold, for example with ext4.
> >
> > Let's fix it by splitting folios in a NOFS scope, so callers don't have
> > to care. A NOFS scope also covers allocations that filesystems make wit=
h
> > their own gfp flags, for example in filemap_release_folio().
> >
> > On NFS, splitting folios with pending writes or ongoing writes to
> > fscache might now fail slightly more often, until these writes have
> > completed. On netfs, only folios that are being written to fscache are
> > affected. All fairly irrelevant.
> >
> > This has medium urgency.
> >
> > Fixes: 6b24ca4a1a8d ("mm: Use multi-index entries in the page cache")
> > Fixes: eef88fe45ac9 ("s390/uv: Split large folios in gmap_make_secure()=
")
> > Fixes: 789763523fb4 ("xarray: honor XA_FLAGS_ACCOUNT in xas_split_alloc=
()")
> > Cc: stable@vger.kernel.org
> > Reported-by: Chris Mason <mason@kernel.org>
> > Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>
>
> Reproduced the hang determnistically.
> Base deadlocked.
> With patch 1: -ENOMEM (safe)

Hi Gregory,

Just curious how those -ENOMEM failures occur. With GFP_NOFS, we
should still be able to reclaim anonymous folios (except in
SWAP_OPS_F_REQUIRE_NOFS cases) and clean page cache folios, right?


> With patch 2: split succeeds
>
> Tested-by: Gregory Price (Meta) <gourry@gourry.net>
> Reviewed-by: Gregory Price (Meta) <gourry@gourry.net>
>

+1 for the patch itself.

Reviewed-by: Barry Song <baohua@kernel.org>

Thanks,
Barry
