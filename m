Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 905424A7CA7
	for <linux-fsdevel@vger.kernel.org>; Thu, 17 Sep 2026 09:56:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789638996; cv=none; b=ZY46yif4Yb6Hym7qZkYFTKSYSPiTb0JcC6TbE3+QJrP3UZQNO2VQZawwfszs/fiUCHzqe1SHE4m2gL7znsRWD5SziGFQ7llbCC1IiXvW6F8G0XQp5y71OMPJkld6MMjGC1Fs01feF/nTkfdLqUqGS718cJokeHfntXLXimTE2VQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789638996; c=relaxed/simple;
	bh=VCZHxc330ypE/b3a5kfGoh/S/n6AlhOTYGFl6/P9O/c=;
	h=MIME-Version:Content-Type:Subject:From:To:Cc:In-Reply-To:
	 References:Date:Message-Id; b=DaTm3ejoOA5n0maDTG7tvpfJF5ROdNGJG0WQErMaE5R3XRHznSaeLzofgasxjha1b/7iymShiql7SA9YQv9ijv17u/3FKBwSinO2CdMmISMX0PHsYL41BL3pbKVLX7izZGeAL2eB29ETxYhetNgF2JUa3ZTDbECWu2AJOhJ+Fnw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cJtCXNWO; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cJtCXNWO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 45F861F00898;
	Thu, 17 Sep 2026 09:56:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789638982;
	bh=/7oxuwwWIpTFWySqmvsqUWw79LWpxoi0hva+IYJpzMw=;
	h=Subject:From:To:Cc:In-Reply-To:References:Date;
	b=cJtCXNWOgFCdWwmJZwaRr8nKw9i9xNwe77+2TgiyOj1f9fj8jEhhhUS1CxDrff+Yn
	 hKuSCEG+VHKLHGyjyYcOtPooNCmyAy3ATqGnN/cwlRav5rLk8lZdRVBJzO75/J3d+R
	 cu5BNje8po9VeH1g3XE8YqwLef+e9H+y31Y4jGBLswkwF8r/NB+3wgKk3CP/phuHyl
	 y1ovXgTZb8+quCTecyy/gET02eGU8sXrl6njdZmXAw5nM2+QKQ6w5yPVyqvLhACaOf
	 VzakmCdZf29IIwYfpM+emzI4UpA5nSIG/pF3BDLWFBicOTnaBinLnBdQnePtRYwUyo
	 0TUSlvQWGgSlw==
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH 0/5 v2] fs: Deferred inode reclaim
From: Christian Brauner <brauner@kernel.org>
To: Jan Kara <jack@suse.cz>
Cc: linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, 
 Christian Brauner <brauner@kernel.org>, 
 Christoph Hellwig <hch@infradead.org>, 
 Mikhail Rudenko <xyzzy@yandex-team.ru>
In-Reply-To: <20260911081309.14137-1-jack@suse.cz>
References: <20260911081309.14137-1-jack@suse.cz>
Date: Thu, 17 Sep 2026 11:56:17 +0200
Message-Id: <20260917-entweder-limitieren-kiefer-f033614058bd@brauner>
X-Mailer: b4 0.17-dev-db0b7
X-Developer-Signature: v=1; a=openpgp-sha256; l=2504; i=brauner@kernel.org;
 h=from:subject:message-id; bh=VCZHxc330ypE/b3a5kfGoh/S/n6AlhOTYGFl6/P9O/c=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWSt3uncfur99qXGp1aLb566cc00kWUsHzvm+UjdPPVpy
 tRnmmrZfzpKWRjEuBhkxRRZHNpNwuWW81RsNsrUgJnDygQyhIGLUwAmIjaT4b+Hmsbi4rui2sz+
 K+UVr1kskfd6JRA710IpcjdnwydRlbUM/zSX3D/IzdnWeH3NO4UV7CZcCzw2tDtzldv9vVV0f0W
 cAwcA
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

> Hello,
> 
> after a long pause here is a second revision of my patches implementing
> deferred inode reclaim to deal with MM warnings due to GFP_NOFAIL allocations
> from reclaim paths. This happens because to reclaim some inodes, filesystems
> have to do IO including complex operations using journalling and forward
> progress of these depends on successful memory allocations (which is impossible
> to guarantee from reclaim context).
> 
> This time I have fully tested the patch set. In particular it survives full
> fstests run on ext4 both as is as well as when marking all loaded ext4 inodes
> for deferred reclaim to stress the deferred reclaim paths. I have also tested
> (when marking all inodes for deferred reclaim) the patches by creating a memcg
> with 128m memory limit and then scanning from 10 processes 600k inodes in total
> which heavily exercises deferred inode reclaim paths. This also verified
> efficiency of throttling of marking of inodes for deferred reclaim. Basically
> we cannot guarantee any particular limit on the number of inodes queued for
> deferred reclaim as that is bound only by their number in memory and memory
> pressure. But as the number of queued inodes grows, the tasks creating them
> get slowed down so eventually some equilibrium is hit. In my VM this was
> at ~10k inodes (only slightly above the 8k limit when throttling kicks in)
> but this all very much depends on the reclaim pressure, speed of deferred
> reclaim etc. so I don't think this is some representative number.
> 
> The first patch is a pure fix for a problem I've hit when running fstests.  The
> second patch deals with lazy timestamp updates which I've decided to handle
> better directly inside the writeback infrastructure instead of deferring
> reclaim. The remaining patches implement the inode reclaim deferal. Ext4 use of
> deferred inode reclaim is there mostly as a demonstration. Other filesystems
> need to determine which inodes need deferred reclaim and mark them as such
> which generally requires good internal knowledge of the filesystem. I'm hoping
> that once the infrastructure is there, fs developers prompted by MM warnings
> will start using it :). I know for a fact that besides ext4 e.g. btrfs is
> hitting MM warnings in inode reclaim as well.

This all looks worthwhile to me!
Note that Sashiko is complaining about long-term stalls introduced by
this patchset. If this is intended or bs then please let us know.

-- 

