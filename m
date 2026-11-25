Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=79.135.106.101
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795628300;
	b=G0Y2E2p9+2XnaTmmyjt8aS0ubayiWRLAALE3cvwm5F9hi6X+CCUKx9FR7KJrr4/5Z+zQ
	 xANUpDaxIV4qOwiKXOzRYx/rSvduzjjeWaj6uljdmQ3/I78PBf1afZq1cnXzmdWIEl+fW
	 XcDuIuIDBrqs0bpRxuqm/StinwmR7REwqX929vq5sawuauiSSg+AwM5XBYSh31I50vl8y
	 HR13uU3pPkAugZgn1+71unrxD43/0MumqFEVcDXi+2f+NjPWhyMW84+1eOS7PQyGfeRzj
	 +LDjdq7Gq0KUCvEsZurgGdO8QBP/skx4aTrtYzlFWAFM+iAiq9mjZs8Xl1MdrhQ6RrA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795628300;
	h=DMARC-Filter:DKIM-Signature:Date:To:From:Cc:Subject:Message-ID:
	 In-Reply-To:References:Feedback-ID:X-Pm-Message-ID:MIME-Version:
	 Content-Type:Content-Transfer-Encoding;
	bh=gAcavlN73Ya35kPG8jV5KeGYcjZOWAaF1oYlQD8iN5w=;
	b=PbiGmVLsjZC+rpBwSir0xUE0Sm0Pec8FTuVObNOhDQzdmkLd4OPoySh9vCdzg2VUhGHi
	 +tIQUArqPwS/RkO+/qnhiUmObUZQd8MqDuv7Mc3lTHU73+MiJ18qGZWCIfok4IPL2jSur
	 WXx5bamdhlmL1lPX4ii89CGEwAQSbKQs+y5OHMQYk64l7wblSQkkarFCtvLMgM4SPSDct
	 7xkX6FzVF0JSJrRmi90FhXCwTwhv4EN4Tiqpbpb0mwq01UBRpOQtSh6jE9cRYwz+mvK3A
	 XcKFARJSHVB4QjBZop2TulNP15iiJQBCNW5vj73PQ2MeCDlJSxoUfqdoRd5q5dT9eWg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=proton.me;
	spf=pass smtp.mailfrom=proton.me;
	arc=none smtp.remote-ip=79.135.106.101
Received: from mail-106101.protonmail.ch (mail-106101.protonmail.ch [79.135.106.101])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC025606A323
	for <linux-fsdevel@vger.kernel.org>; Wed, 25 Nov 2026 17:38:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AC025606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail2; t=1795628280; x=1795887480;
	bh=gAcavlN73Ya35kPG8jV5KeGYcjZOWAaF1oYlQD8iN5w=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=f8RE/aLuMO7y6xfH6FYf9K2lVlTw6JA66iLH5dzXM/MikPcfj6UyoOONQqQMBDQxi
	 9n8NX6KASD3e7fEEMowcp/Bb64dxxubWm09DjJvoNFOGcbBSRzte+f9RMiBwVbLRmW
	 SV54BACFWgl0RNBUM+aNJB32SAK/M9LR125Q/BQbHhl86qhOzLoqYplZlgisCoPddd
	 +3MMhOhRpDNwXbJPzMvKXDieMLyMC8HMZjsX5h9r0wCpGdtEypGLorKsXAzyZmNcPN
	 ql947HEFM7GP2TMT8VSq1xo76AQFtN+zrTSEBFX8E0yfixHdTR3KzEusKbJujXcnOP
	 xd8BlnvoSUuSg==
Date: Wed, 25 Nov 2026 17:37:54 +0000
To: Christoph Hellwig <hch@lst.de>
From: Ernest Borowski <ernest.borowski.git@proton.me>
Cc: ernest.borowski.git@proton.me, Namjae Jeon <linkinjeon@kernel.org>, Hyunchul Lee <hyc.lee@gmail.com>, Baolin Liu <liubaolin12138@163.com>, Christian Brauner <brauner@kernel.org>, "Darrick J. Wong" <djwong@kernel.org>, ntfs@lists.linux.dev, linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org, linux-kernel@vger.kernel.org, Zhan Xusheng <zhanxusheng1024@gmail.com>, stable@vger.kernel.org
Subject: Re: [PATCH v2 02/11] iomap: add a helper to mark a range of a folio dirty
Message-ID: <179562827127.336908.5205349169070022087.b4-reply@b4>
In-Reply-To: <20261125055016.GB20604@lst.de>
References: <20261124-b4-ntfs-delalloc-fixes-v2-0-f394c800ec03@proton.me> <20261124-b4-ntfs-delalloc-fixes-v2-2-f394c800ec03@proton.me> <20261125055016.GB20604@lst.de>
Feedback-ID: 236360163:user:proton
X-Pm-Message-ID: 4839e5da1363b7916307013b17874d66462b3b46
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 25, 2026 at 06:50:16AM +0100, Christoph Hellwig wrote:
> If we end up with this, iomap_dirty_folio should be rewritten
> to call this instead of duplicating the logic.

Done for v3. Both now share a static helper, and iomap_dirty_folio()
keeps passing the mapping it is given rather than folio->mapping, as
->dirty_folio can be called without the folio lock.

> But I'm a little sceptical the use of this can be correct.  I'll try
> to look into it, but it might take some time to understand the ntfs
> code.

To save you some of that time: the user is ntfs_dirty_cluster_tail() in
patch 10.

ntfs reserves delalloc space in clusters, which can be larger than a
block and larger or smaller than a folio, and it has no unwritten
extents. If the copy of a buffered write into a hole stops early (an
unmapped source page, a fatal signal), the rest of the cluster it
stopped in is never written. Writeback then allocates the whole cluster
and writes only the copied blocks, so a read of the rest after
drop_caches returns stale disk data.

Before the unused delalloc clusters are punched out, ntfs walks the rest
of that cluster under the invalidate lock:

- in an uptodate folio in the page cache, it locks the folio and uses
  this helper to dirty only the blocks in that range. Those blocks
  already hold the right contents: zeroes, or data a write through mmap
  added since;
- otherwise (no folio, or not uptodate), if the cluster is still
  delalloc, it zeroes the range with iomap_zero_range().

It cannot zero an uptodate folio without overwriting such mmap data,
and it cannot use folio_mark_dirty(), because that dirties the whole
folio. When clusters are smaller than the folio (1k and 2k clusters, or
a large folio), the other blocks can be holes or delalloc clusters the
write never reached: the punch would then keep those clusters reserved,
and writeback would allocate clusters that hold only zeroes.

The alternative needs no iomap change: when writeback allocates a
cluster, zero on the disk the part the write does not cover, before the
cluster goes into the runlist. A later series of mine already does this
for clusters allocated by a write fault. Doing it in writeback costs
extra zeroing I/O for every partly written cluster, but it also closes
the race where writeback allocates the cluster before
ntfs_dirty_cluster_tail() runs, which patch 10 leaves to that later
series. If you think that is the better way, I can rework patch 10 like
that and drop this patch.

