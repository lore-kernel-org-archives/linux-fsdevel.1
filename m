Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AC9E188713;
	Wed, 29 Apr 2026 14:18:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777472294; cv=none; b=Xmi5PEjAV2+KXaepq4/k2i76q9DMC3yHeziQDTCBufw8t0pg1ipg/Sb54oaAfXBUfX85rIrgh/8udwDpmMfNiy+jku0vVt1su3wrtOJmdesFeOAOk86SyHZ1j+Ou8T+eLyl/EJMyME0DtNqVU4yBWI7JubpM41D54zIppPbzSJ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777472294; c=relaxed/simple;
	bh=zV2+aPw8NyEQ1jy1hRqVXxWm5SAaJs0sx7uN2kY+n8E=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GMQv8+4W1extzOqMBGBbE0ep2HTR1wdudHkbfta6uhdyZPF1cWrkwNADo3MSRRcQv6tnpIBLdlTqkSpl7KuEzUiFqoWBfq0ge7thtuT65XLQzOJ6XAekmHCgD5m4Rg9+m9KLmMpr+OhI3VwGgViYfl4fP5Iw02jHcOLPmcV/SVI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FgDrC596; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FgDrC596"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 08B13C19425;
	Wed, 29 Apr 2026 14:18:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777472294;
	bh=zV2+aPw8NyEQ1jy1hRqVXxWm5SAaJs0sx7uN2kY+n8E=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=FgDrC596HExxQtlLNjrHQ7u5mlpYBem0rTFP5jmNl/kn8J2+OCZacp1v3eS1ID29K
	 wN+OidAugqPRWVQvXLZqsP1dS0gPZ4rsCTJwuEhvZv7rujJ0qkH7edpV1weru0EKzi
	 c65NP0CzGuyQ2pTrDhgi9qHaAfbat3aAgTrJ7+OQf6pflvLM+eTtRV6KaXLf1Ee5cs
	 3lwsDvnm/ReNQAa1vc7jSoxk63kXt9uNRNt9sSuL+Uf7vooM+m7OMt/Jj4Zs2COZuc
	 Uxd2rNnOsisdzMOY8RZfPB5LBRZ5loPBqFaAjp7bToFU9aVlr9YCVwwTCERsf6IwtM
	 n0ENjhVvwisDQ==
Date: Wed, 29 Apr 2026 07:18:13 -0700
Subject: [PATCHSET v8 7/8] fuse: cache iomap mappings for even better file IO
 performance
From: "Darrick J. Wong" <djwong@kernel.org>
To: djwong@kernel.org, miklos@szeredi.hu
Cc: joannelkoong@gmail.com, neal@gompa.dev, linux-fsdevel@vger.kernel.org,
 bernd@bsbernd.com, fuse-devel@lists.linux.dev
Message-ID: <177747206929.4103699.18256961856283014867.stgit@frogsfrogsfrogs>
In-Reply-To: <20260429141253.GQ7739@frogsfrogsfrogs>
References: <20260429141253.GQ7739@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

Hi all,

This series improves the performance (and correctness for some
filesystems) by adding the ability to cache iomap mappings in the
kernel.  For filesystems that can change mapping states during pagecache
writeback (e.g. unwritten extent conversion) this is absolutely
necessary to deal with races with writes to the pagecache because
writeback does not take i_rwsem.  For everyone else, it simply
eliminates roundtrips to userspace.

If you're going to start using this code, I strongly recommend pulling
from my git trees, which are linked below.

With a bit of luck, this should all go splendidly.
Comments and questions are, as always, welcome.

--D

kernel git tree:
https://git.kernel.org/cgit/linux/kernel/git/djwong/xfs-linux.git/log/?h=fuse-iomap-cache
---
Commits in this patchset:
 * fuse: cache iomaps
 * fuse_trace: cache iomaps
 * fuse: use the iomap cache for iomap_begin
 * fuse_trace: use the iomap cache for iomap_begin
 * fuse: invalidate iomap cache after file updates
 * fuse_trace: invalidate iomap cache after file updates
 * fuse: enable iomap cache management
 * fuse_trace: enable iomap cache management
 * fuse: overlay iomap inode info in struct fuse_inode
 * fuse: constrain iomap mapping cache size
 * fuse_trace: constrain iomap mapping cache size
 * fuse: enable iomap
---
 fs/fuse/fuse_i.h           |   11 
 fs/fuse/fuse_iomap.h       |   10 
 fs/fuse/fuse_iomap_cache.h |  121 +++
 fs/fuse/fuse_trace.h       |  445 +++++++++++
 include/uapi/linux/fuse.h  |   41 +
 fs/fuse/Makefile           |    2 
 fs/fuse/dev.c              |   46 +
 fs/fuse/file.c             |   18 
 fs/fuse/fuse_iomap.c       |  535 +++++++++++++
 fs/fuse/fuse_iomap_cache.c | 1791 ++++++++++++++++++++++++++++++++++++++++++++
 fs/fuse/trace.c            |    1 
 11 files changed, 2998 insertions(+), 23 deletions(-)
 create mode 100644 fs/fuse/fuse_iomap_cache.h
 create mode 100644 fs/fuse/fuse_iomap_cache.c

