Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.160.177
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793984035;
	b=qCa65WiX89Ta21SCAMG79kSaZnYljtQoPSNN5XPR4wJkKrJUZNrry5umzXpZ8GhqrVN3
	 g2VRxvRUR3YWnOB92K7xNAUj9nDNvjyOQi0vQ3/7tF9/kjzyeUCbBrb4hoMCwsxAKswuE
	 9S/IRyBMAghEgLTbp/FWEbPDOfdqx0kmzvyilFkPkEKeH6Y2HLtcjJ48xMTyclkDEYjJE
	 fMlhKyUCX1KyEjBWe3LlzG36H+K5p/uP61tglJ5JdA9AS6kZ57+4VrIlIF68+V2pXb/x1
	 7dakLXkkWat6X6XAQ9fvrnaLbX0/T+q8nj4EM6m7eOX4okteKC9Jv11taWiUCrnKsuw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793984035;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=AG0jNrJz1ZIzn99iYysxWdVpqyd2imosrQ397ggvDJc=;
	b=MX73YpYxfRqe6mlBUt1JBxPJdE3MLnNW8o3lYnfEcK+n8RNp53zdM0oH25pnKhoBwgBj
	 wL2QNYfAZm1at6Q/F81B9zJ8oTk7R1XmLF8XhSLVcckZ2PVVDvmGgyVmFxVShBR+WXpRX
	 ltPuCFVVXlDjHa9xlIu2gC0KWKefJWkjhu0dKfL1UQ+0Lklmz65JMYLg6dXqfO/Q2C251
	 JxmWPo1uznzwasqYKAYsxqRHgrEbfk74oqcISEJryi9Mjsalbki++3FogII2gf5P0rjfd
	 5f8h5VI2TOZRazpVfgzZC/DVmq3DXneyhvtOfB7SvADyFgqYpYQVVOzXI3G4b/fHbGw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=toxicpanda.com;
	spf=pass smtp.mailfrom=toxicpanda.com;
	dkim=pass header.d=toxicpanda.com header.i=@toxicpanda.com header.a=rsa-sha256 header.s=google header.b="fNm/ZUuP";
	arc=none smtp.remote-ip=209.85.160.177
Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8774D606A326
	for <linux-fsdevel@vger.kernel.org>; Fri,  6 Nov 2026 16:53:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8774D606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=toxicpanda.com header.i=@toxicpanda.com header.a=rsa-sha256 header.s=google header.b=fNm/ZUuP
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-536c8f958d7so6599061cf.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 06 Nov 2026 08:53:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda.com; s=google; t=1793984033; x=1794588833; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:subject:cc:to:from:message-id:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=AG0jNrJz1ZIzn99iYysxWdVpqyd2imosrQ397ggvDJc=;
        b=fNm/ZUuPBsjUNtceFUOAljbfiOj9vdSbrqV7Nm5HENgnIe3b8kAupl3fuoEB3VPWQE
         i9FMYCzIiwBSq+yolJGbMcHoPM2fyJmKZ7jpVnPHzw44JDkhgNUavUl+aoBUVIMdueBm
         qEoQLrDLmt5084mt22tQwDwFppEj3sEC9YMDzZ11D0W3w1oOrjJoXW/0togk1J8tgHuw
         5/hZ375AJ0cFVtp0EmNU4sOnjit5EvZjySCNjScTGgZO2IIOpJssHsXRNG6CBMvR32ad
         q2NpM9LtZfWV2kcQmiLaDv46dcXtqeVBJxhS2fmXmOZl4hmnO2smZwn/tRwmkOgm3kNY
         eu9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793984033; x=1794588833;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:subject:cc:to:from:message-id:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=AG0jNrJz1ZIzn99iYysxWdVpqyd2imosrQ397ggvDJc=;
        b=P9iy3WJzGqJeOVosqfzrXdmkioGnFw4ZW68r9Saxghd5DadR7aXEA0asDTE92PdZoq
         6g+rwrUubGXWOUM1ip/5r7y7naxPrUIWDOY8uBSQxdFs2iHT42h7qnmi6CZcTlaMp0OS
         CqTvEL9T/ExaOa8wUQdzZtnSbdz+uLpd+8nDnLMKvIDVVFKcTEqszvBMDlrEcNXPmTLd
         QytKiFUykqO64iDbkDVIIidHFDPPYCtpbUEStOwZ4E3W9DFA90QL1WNMWNjNS0cHzhyP
         lx0dY5umE5P3TzCJhTdKGOTTnOwT7fD6XvVLh2a1p0ek0TsnW4J9HXjch2uN029orMgO
         6RfQ==
X-Forwarded-Encrypted: i=1; AKwUvBwVTtcsKy/F+CwHBdOfvv7R4T+HV3axx83p3hwhKDw5L3cxtt4avfc7910lrF1mmC2yl9emaJGfCIQLmF6Y@vger.kernel.org
X-Gm-Message-State: APuU4Z+DKZ4hrk5tetVXtbmwzCP9K8oXkrrEGw6iy3pQ9lGdKYcbvl1d
	vLt3+JP/57xlAi5435A/+p4r2DJswiY6/UOgEd1EfbTEZfaU6vjwfZDxSWLqHCqvIlkTAeTvi0l
	5xyOMMqM=
X-Gm-Gg: AYBFou04jhdRsLhnXkGbTTKAVCshCwulvaoT7r0P9yymAjR1peDrtDtQVVjOIVCDs4P
	CPngzrltT1U0HTwYLgHnw1Sd90Pg03ZRGV7MKUQ7zuxOcE+vhoeqxP1ecDuSypyliCXP34hPaKL
	/hZ3buhPPv2zY0e98Mu5yv2TzYSiAHPCjHB/sp1aKyHZIdYxQbSUfpAQe42kg5aCL6tn5zJePu2
	LgokgpbE9GFe75NpW0AU3sLWdilrZhJSDklVau7Yb56V+VBLQuQe8zM+cLr7Yrm/aiJZrsCFzLr
	xHxlEkhudUGBViWa+PQePzJiFFs+Y0xAz9Hgr5shQ4ImGh4c8TO1SKcnHYQPTLdlP9zFst2MdBd
	Yvlokame+94VFS9sPR/b0Aqsoj+REDpYMhLGc0RDp2ryWh1Jc2He0zGSJEJHoavDCvEINoLKOxv
	pLsyc+C7Uo6hY8nxO3zsu3scsbFyZhCDM3yY38NXVY+ycnqu5xtOOkCOfn16LPOikExNcSyonxG
	4yZAfEZcoD1FPrRU+uquinbjv4iALfhRc6whakn/hUpIYvqY48DsT5nqVx+/iX2CWKhhOUfFCTb
	GGgC7LkuGz0+8Yr2V0MZTDt8vJ8U5Uh3V1BaYKkTLVRAgQ==
X-Received: by 2002:a05:622a:418b:b0:535:b506:11e8 with SMTP id d75a77b69052e-54e0d35a069mr48834131cf.0.1793984033239;
        Fri, 06 Nov 2026 08:53:53 -0800 (PST)
Received: from toxicpanda.com ([153.61.196.246])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-54e257862a6sm24440811cf.8.2026.11.06.08.53.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Nov 2026 08:53:52 -0800 (PST)
Date: Fri, 06 Nov 2026 16:53:51 +0000
Message-ID: <5ba0cd611f787673e219509aba8b81a0.josef@toxicpanda.com>
From: Josef Bacik <josef@toxicpanda.com>
To: Christian Brauner <brauner@kernel.org>
Cc: Miklos Szeredi <miklos@szeredi.hu>, Amir Goldstein <amir73il@gmail.com>,
 Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>,
 Christoph Hellwig <hch@infradead.org>, Chris Mason <mason@kernel.org>,
 Chengguang Xu <cgxu519@mykernel.net>,
 Chengguang Xu <charliecgxu@tencent.com>, linux-unionfs@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 0/8] ovl: only sync what was written through the
 overlay
In-Reply-To: <20261106-nebel-fragment-normierung-84511a5676d9@brauner>
References: <20261104-b4-ovl-containerized-sync-v3-0-8daa20144f53@toxicpanda.com>
 <20261106-nebel-fragment-normierung-84511a5676d9@brauner>
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

On Fri, Nov 06, 2026 at 04:32:50PM +0100, Christian Brauner wrote:
> The thing that's a bit ugly is that overlayfs open-codes the tail of
> sync_filesystems(): ovl_sync_fs() calling upper_sb->s_op->sync_fs() and
> sync_blockdev() itself is one more place that needs to know what
> sync_filesystem() does.
>
> So we should probably add a helper to fs/sync.c for the ->sync_fs() and
> block device part and use that.

v4 went out a couple of hours before this, it only swaps in v2 of Amir's
patch, so all of this applies to it as well.

I've added sync_fs_and_bdev(sb, wait) for v5, sync_filesystem() calls it
twice and ovl_sync_fs() once.

> Eheeeem, isn't that kind of a bad proxy for this? What ->sync_fs() +
> block device do is a property of the upper filesystems and how is that
> related to RENAME_WHITEOUT? There's a few counter examples you even
> give:

[...]

> So on ubifs a syncfs() in relaxed mode returns with metadata still in
> memory. Meh. I know the flag got droppped but that was an overlayfs
> speicfic thing. A generic property of ->sync_fs() is a different thing?

I dropped the flag after v1 because nobody liked it, me included, and I
don't want to touch every file system for this.

What relaxed leaves to ->sync_fs() and the block device is only the
upper inodes that have no overlay inode, that's whiteouts and the work
directories. With creation fixed (below) everything else is on the dirty
list and gets written.

For the file systems that pass the probe: ext4, xfs and btrfs log all
metadata. ext4 without a journal has it in the buffers of the block
device, which we write. f2fs writes its dirty inodes in the checkpoint,
f2fs_sync_inode_meta(). ubifs writes names, whiteouts and links to its
journal when they are made, only setattr leaves an inode dirty in the
VFS. The only setattr overlayfs does on an inode it doesn't track is the
chmod of the work directory to 0 at mount time, right after it was
created with mode 0. That's the counter example from the cover letter,
and it's the only one I could find.

Anybody who needs more than that has fsync=on and fsync=strict, which
sync the whole upper file system like before.

> Afaict, creation isn't covered. ovl_instantiate() ends up in
> ovl_inode_init() which now uses __ovl_copyattr(). So a new file,
> directory, symlink or hardlink only dirties the parent but not the new
> overlay inode.
>
> Fine for metadata, but a long symlink isn't metadata. We should mark the
> new inode dirty where it's instantiated.

Yup, ovl_instantiate() marks it in v5. Nothing gets lost today, ext4
journals the block of a long symlink, xfs logs it, btrfs has it in the
tree and f2fs writes it in f2fs_symlink(), but we shouldn't depend on
that. I've added a long symlink to the fstest.

> * ovl_park_inode() calls mark_inode_dirty_sync(). Jan's deferred inode
>   reclaim (cf. [1]) removes exactly that from iput() because it does IO
>   from dentry reclaim.
>
>   He replaces it with queue_dirtytime_writeback(). That moves the inode
>   to the head of b_dirty_time and wakes the flusher.
>
> So it would be nice if we could base your thing on top of Jan's series
> (I hope he'll send v2 soon!) and call queue_dirtytime_writeback() thing.

The one in ovl_park_inode() is called from ->write_inode(), not from
iput(), and it's on the overlay inode, which has no ->dirty_inode(), so
it only moves it to another list.

The one that does IO from dentry reclaim is iput() of an overlay inode
with I_DIRTY_TIME, that's sync_lazytime() -> ovl_sync_lazytime() ->
mark_inode_dirty_sync(upper). Jan's patch 2 takes that out of iput(), so
it goes away without any change on my side, and then using
queue_dirtytime_writeback() in ovl_park_inode() makes sense too. It
would have to be exported for that.

I only need patches 1 and 2 of that series, and they don't depend on the
rest of it. Jan, could those two go in ahead of the deferred reclaim
part? Then I'll rebase on top of them. Otherwise I'd rather do this as a
follow up than wait for the whole thing.

> > An overlay inode that loses its last reference while it is dirty is
> > kept until it has been written and then sits on the LRU, like with
> > any other file system.
>
> Hm, Jan's series fixes that as well afaict. :)

I don't see how, what am I missing? overlayfs has inode_just_drop() for
->drop_inode(), so a dirty overlay inode is evicted on the last iput()
and we forget that the upper inode has to be written. Patch 6 keeps it
around until it's clean.

> There's some Sashiko thing btw you should look into?

The only mails I got from it are on v1, those are fixed since v2, except
for dirtied_time_when of a parked inode, which I left alone on purpose,
it's in the v2 changelog. Thanks,

Josef
