Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44C6730DEAC;
	Wed, 20 May 2026 06:15:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779257722; cv=none; b=OH/NpmcpISXqY1WymAIXBh2n975JOHZi27yvKoeyZMSlsaRwWk/VhX5cYuYdQFdOmYBFMU4VVpYfamfVY3rvQeh9P/9bQE4gwcCfRYg8BLsnD1YHrKhcNh3id+Vg7tO28rqchsm0aLtiW8/h5IwmiejuUHtky9VZyei7nq4Isss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779257722; c=relaxed/simple;
	bh=QfxKedq0lzsIHKqxqKAfKgyhObgG6aovxjJg80dmPDM=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZdpXC/MTJF5/1Ma/6jLKyuQf+u/1oppIuQ7Q8RUrSArOVwd/6EotfztxFr9vBRNjHZ4q3MVxf/vtkp23lLaTD4iZCxHoLJ3hlHc9OLpRXwIcCpXhWJB53HA8XjSZDLcfXFQJQHJOziju+jdetRTS+Ju0aq3u0g58CEhHnRVjK2M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Z1FBDbxD; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Z1FBDbxD"
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id CADF91F000E9;
	Wed, 20 May 2026 06:15:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779257720;
	bh=RRQ5NrQlBDEI+yHYxqEQQjeyuU5p7LL1W+nO9oeKGm4=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References;
	b=Z1FBDbxDsebOMATTxnquLuhYXgm6WAgQAy2bjgVKVPpJvCi0XAcwnon4nqyfjvfxr
	 t18UVwjQQeLFCfShJ0OV5i0UEISkXe2CAw5ZomDOA0qvwlCosq/qcc89AWbSyQWC1t
	 7nMfQJUJPvJPZ05m2UstL9fs8IJyFaJd/ETl1bK6xWILfcbTPuPtCElsh+3F8prp7l
	 e6PzxQkGcMxmkXKChdNej4sfXz7UMAQgeM6NiEYxO/TqNldrrp2Q5hsDvebFsv/lv7
	 IPXyzBJGrMM36ctGlxS2Ysi4ukDHlTpUhYeU7FkSYuyGok+nnrLLwCe2UuJzmRKwxa
	 dh8PGGU6e4g+Q==
Date: Tue, 19 May 2026 23:15:20 -0700
Subject: [PATCHSET RFC] fuse: allow fuse servers to upload iomap stripe
 information
From: "Darrick J. Wong" <djwong@kernel.org>
To: miklos@szeredi.hu, djwong@kernel.org
Cc: fuse-devel@lists.linux.dev, bernd@bsbernd.com, neal@gompa.dev,
 linux-fsdevel@vger.kernel.org, hch@infradead.org, joannelkoong@gmail.com,
 john@groves.net
Message-ID: <177925767662.2711065.15846161331592459171.stgit@frogsfrogsfrogs>
In-Reply-To: <20260519222229.GB9544@frogsfrogsfrogs>
References: <20260519222229.GB9544@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

Hi all,

There are certain fuse servers that might benefit from the ability to
upload storage device striping information into the kernel to assist in
responding to ->iomap_begin requests.  In other words, this is
filesystem striping for fuse iomap, implemented in fuse.

For example, consider a fuse server that abstracts a large amount of
storage for use as intermediate storage by programs.  If the storage is
striped across hardware devices (e.g. RAID0 or interleaved memory
controllers) then the iomapping pattern will be completely regular but
the mappings themselves might be very small.

Performance for large IOs will suck if it is necessary to upcall the
fuse server every time we cross a mapping boundary.  The fuse server can
try to mitigate that hit by upserting mappings ahead of time, but
there's a solution that does not involve BPF that can provide this
usecase: uploading device striping information into the kernel.

In this case, the fuse server upload a stripe map into the /dev/fuse
device and receives a "backing" file id.  That id can be combined with a
new mapping type (FUSE_IOMAP_TYPE_STRIPE) that will load the stripe
information and adjust the mapping to point to a real block device.

If you're going to start using this code, I strongly recommend pulling
from my git trees, which are linked below.

With a bit of luck, this should all go splendidly.
Comments and questions are, as always, welcome.

--D

kernel git tree:
https://git.kernel.org/cgit/linux/kernel/git/djwong/xfs-linux.git/log/?h=fuse-iomap-striping
---
Commits in this patchset:
 * fuse: allow fuse servers to upload stripe maps
 * fuse_trace: allow fuse servers to upload stripe maps
 * fuse: implement striping for iomap
 * fuse_trace: implement striping for iomap
---
 fs/fuse/fuse_i.h           |   30 ++++
 fs/fuse/fuse_iomap.h       |    8 +
 fs/fuse/fuse_trace.h       |   57 +++++++-
 include/uapi/linux/fuse.h  |   24 +++
 fs/fuse/backing.c          |   85 +++++++++++
 fs/fuse/dev.c              |    2 
 fs/fuse/fuse_iomap.c       |  328 +++++++++++++++++++++++++++++++++++++++++++-
 fs/fuse/fuse_iomap_cache.c |    8 +
 fs/fuse/inode.c            |    1 
 9 files changed, 533 insertions(+), 10 deletions(-)

