Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8904C560ADE;
	Wed,  9 Sep 2026 16:51:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788972667; cv=none; b=dzLqyfjbyUPb1dCwO9WsfbmIJ8zhbA+8CL1BPxmRCxJiIIYG+U8XzKIqluWufdCg8A3E1p22AihJ2he2/TWpnG5OrMcEYkoh4fo0nMf9n2xk84otelGKy04SxcdO+lnghBxJN8FXBx8jewG/dWG37u8A3UHYtKnQhcNSTQp+c+U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788972667; c=relaxed/simple;
	bh=8bHamDc8+pQPqeJIY+NrS0juifJ3mOF9YT/lsUUw6qw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OOADFQwW9L1T3B8c7nMUQ7Lea/DTQF5KorneMalSoO1WyN0J76T/NEFk6+AXIg37LFv8JpfpDoTzNeKr/exlLgIP0ftgu6QNupJ+TOj0RDm4j0Xfw1j4WhdfwzdOGw1Q61DKK82MJP87xPEXfp/c85blYljvi1JpwX/QmwzTPNs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PWTqa/TX; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PWTqa/TX"
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id 0C11D1F000FF;
	Wed,  9 Sep 2026 16:51:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788972666;
	bh=rhFQJvw4IPqvZCsEwuQfdy6O9R7rLqOtLLgx8ZPuvM0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=PWTqa/TXp5I0pj8c/wTA3M/y+zcRP+7g6xunDDud/PFeVQwLMb3KAJ+Xj6I6etWG6
	 pkzOBqowjXlU3/b6FbAuv7CJx3xw+QPuD1pB98YkkHqnsvLbVe5I24uNjjn7k6sbSe
	 nDENMDF8IwYznwVkSjFo5efl6cMwBhEIHcZ62L9GAJM8FunwYxm11Ud2MPzoYkc4pv
	 GIjnRqWzzXtL1Ubn2+muYoreESNR+7zDG18py5zdwT5urmwvYFHou2ecZ/yVi/aMJw
	 30GJW2lHfUVsE4+DUYKkH00hZMsQaAOMreiPWf3trLEaPT6Y40Wx7IS+Vk5LdZFJQu
	 F1Fwnb+H/IJyA==
Date: Wed, 9 Sep 2026 09:51:05 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Viacheslav Dubeyko <slava@dubeyko.com>
Cc: glaubitz@physik.fu-berlin.de, frank.li@vivo.com, hch@lst.de,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	vdubeyko@coreweave.com, willy@infradead.org, brauner@kernel.org
Subject: Re: [PATCH v3 0/7] hfsplus: convert regular file I/O to iomap-based
 operations
Message-ID: <20260909165105.GH127607@frogsfrogsfrogs>
References: <20260908210448.296772-1-slava@dubeyko.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260908210448.296772-1-slava@dubeyko.com>

On Tue, Sep 08, 2026 at 02:04:41PM -0700, Viacheslav Dubeyko wrote:
> This series moves HFS+ regular file data I/O off the legacy
> buffer_head/blockdev_direct_IO() path onto iomap-based operations with
> the goal to retire the older buffer_head-based direct I/O infrastructure.
> 
> v2
> Christoph Hellwig has detected that taking the page lock around
> the kmap/modify/kunmap section is not enough on its own:
> writeback drops the page lock before the write actually completes,
> so a mutator that only waits on the lock can still start rewriting
> a page whose old contents are still in flight to the device.
> Mark the allocation file's mapping with mapping_set_stable_writes()
> and call folio_wait_stable() right after taking the page lock in
> both functions, so a mutator also waits out any writeback that was
> already in progress when it acquired the lock.
> 
> Christoph Hellwig suggested to introduce a generalized version
> of iomap_dio_end_io() that was placed into include/linux/iomap.h.
> 
> The hfsplus_btree_aops uses hfsplus_btree_read_folio() and
> hfsplus_btree_writepages() methods. The hfsplus_symlink_aops
> uses hfsplus_symlink_read_folio() and hfsplus_symlink_writepages()
> methods. Also, hfsplus_setattr() doesn't distinguish the regular
> and not regular file cases anymore.
> 
> v3
> Matthew Wilcox recommended to use folio_wait_writeback()
> instead of folio_wait_stable().
> 
> Fix failures in generic/091, generic/521, and generic/551.

FWIW the iomap port itself looks correct to me, so for patches 4, 6,
and 7:

Acked-by: "Darrick J. Wong" <djwong@kernel.org>

but my knowledge of HFS+ is pretty fragmented now, so I couldn't say for
sure about 1-3 or 5.

--D

> Viacheslav Dubeyko (7):
>   hfs/hfsplus: exchange hardcoded number of extents on named constants
>   hfsplus: rework hfsplus_get_block() logic
>   hfsplus: take the bitmap page lock for allocate/free
>   hfsplus: add iomap operations for regular file data
>   hfsplus: move file related operations to file.c
>   hfsplus: introduce iomap-based file_operations
>   hfsplus: switch address_space_operations on iomap-based support
> 
>  fs/hfsplus/Kconfig         |   2 +-
>  fs/hfsplus/Makefile        |   5 +-
>  fs/hfsplus/bitmap.c        |  18 +++
>  fs/hfsplus/extents.c       | 164 ++++++++++++++------
>  fs/hfsplus/file.c          | 304 +++++++++++++++++++++++++++++++++++++
>  fs/hfsplus/hfsplus_fs.h    |  26 +++-
>  fs/hfsplus/inode.c         | 281 ++++++++++------------------------
>  fs/hfsplus/iomap.c         | 192 +++++++++++++++++++++++
>  fs/hfsplus/iomap.h         |  18 +++
>  include/linux/hfs_common.h |   8 +-
>  include/linux/iomap.h      |  20 +++
>  11 files changed, 787 insertions(+), 251 deletions(-)
>  create mode 100644 fs/hfsplus/file.c
>  create mode 100644 fs/hfsplus/iomap.c
>  create mode 100644 fs/hfsplus/iomap.h
> 
> -- 
> 2.43.0
> 
