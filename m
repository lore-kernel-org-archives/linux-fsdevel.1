Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B6913DB30C;
	Tue, 19 May 2026 22:24:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779229500; cv=none; b=ksx949WP5uV2MS8A80y65Um/8QXWRL8lhMZz+EH+G83m+64Wm+F2F+ImxkAgrkCLK4XvsYzmJ6sRIj2hFiwhTiKlUHdg51iJZ5ispW8tGWS7cTC5mtBpn/M6bXo4KwKM3Q810VF7nVnkMQzspLkoJKnGrplxw41ie9NZWX+vK6E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779229500; c=relaxed/simple;
	bh=yc1L8lCdk00bh5nukmgHITkbl2t1ikS+vAPMI0h82LI=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=K6/qZB0gVZ+cdc2q/oPbgAalbtIGSsCEdHh2eIKyOVfEv/QjHd8iLDrz4X16zT/sqytdIjrWguTM2lQB9gU2sShRUf+fMuSLHc4mu9YQcsNoNzCksc5hodSucK9Kd9xOVouPGvo3rW4mTLimD4gaPbYPevjd4/7jgkq4GKUGpjY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Daq44B6f; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Daq44B6f"
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id B58E51F00893;
	Tue, 19 May 2026 22:24:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779229498;
	bh=0hr2U0gE90u3WT98kV4xf8hek57pGpOv0l67amIG+A4=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References;
	b=Daq44B6faa34/HS1CW5/HT9ZxF/LGBPZPOCpCCe11TVKIaVoT6N8abdbgNY2sOrR3
	 EiKW2rvgqVRH396I1vuuUsNEti5mNx4G80Biuu25IetIW1ZALSin95SrCaI6zMvTVm
	 QbNi3IzNhI+cYScRUYDLxjcUjha5bK1mGsXYVMTLMxgQp1EYhi+1bcRlc9Ji7X2/qb
	 VH43VHDmUBJHBct+Cn1tdYOC1lh/dxw1uBtqIfcs/6zWT75sPs2V27OEpctrScoJon
	 U6cAdil8XrHVSjkC/yGs1qha4aHhZm7njjWgl+OzkCn990K41Funikzd0jPxoxR8kY
	 X8QV5+RtuGzFQ==
Date: Tue, 19 May 2026 15:24:58 -0700
Subject: [PATCHSET v9 2/4] fuse: basic plumbing to upload file mappings from
 servers
From: "Darrick J. Wong" <djwong@kernel.org>
To: djwong@kernel.org, miklos@szeredi.hu
Cc: joannelkoong@gmail.com, linux-fsdevel@vger.kernel.org, neal@gompa.dev,
 bernd@bsbernd.com, joannelkoong@gmail.com, fuse-devel@lists.linux.dev
Message-ID: <177922945175.2436837.10366841596277424226.stgit@frogsfrogsfrogs>
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

It is desirable to connect fuse (the userspace filesystem layer) to
fs-iomap to get fuse servers out of the business of handling file I/O
themselves.  The easiest way to do this is to reuse the (newish) vfs
iomap library that manages pagecache and direct IO.  The first part of
this work adds the piping necessary to get a mapping from the fuse
server and release it when work has completed.

Note that although this series creates the basic plumbing for moving
file mappings around the system, there's still a lot more that needs to
be configured.

If you're going to start using this code, I strongly recommend pulling
from my git trees, which are linked below.

With a bit of luck, this should all go splendidly.
Comments and questions are, as always, welcome.

--D

kernel git tree:
https://git.kernel.org/cgit/linux/kernel/git/djwong/xfs-linux.git/log/?h=fuse-iomap-plumbing
---
Commits in this patchset:
 * fuse: implement the basic iomap mechanisms
 * fuse_trace: implement the basic iomap mechanisms
 * fuse: make iomap debugging configurable at runtime
 * fuse: adapt FUSE_DEV_IOC_BACKING_{OPEN,CLOSE} to add new iomap devices
 * fuse_trace: adapt FUSE_DEV_IOC_BACKING_{OPEN,CLOSE} to add new iomap devices
 * fuse: create a per-inode flag for setting exclusive mode
 * fuse: create a per-inode flag for toggling iomap
 * fuse_trace: create a per-inode flag for toggling iomap
 * fuse: isolate the other regular file IO paths from iomap
 * fuse: implement basic iomap reporting such as FIEMAP and SEEK_{DATA,HOLE}
 * fuse_trace: implement basic iomap reporting such as FIEMAP and SEEK_{DATA,HOLE}
---
 fs/fuse/fuse_i.h          |   47 +++
 fs/fuse/fuse_iomap.h      |   49 +++
 fs/fuse/fuse_iomap_i.h    |   45 +++
 fs/fuse/fuse_trace.h      |  402 +++++++++++++++++++++++-
 include/uapi/linux/fuse.h |  120 +++++++
 fs/fuse/Kconfig           |   48 +++
 fs/fuse/Makefile          |    1 
 fs/fuse/backing.c         |   52 +++
 fs/fuse/dir.c             |   29 +-
 fs/fuse/file.c            |   40 ++
 fs/fuse/fuse_iomap.c      |  766 +++++++++++++++++++++++++++++++++++++++++++++
 fs/fuse/inode.c           |   41 ++
 fs/fuse/iomode.c          |    3 
 fs/fuse/trace.c           |    2 
 14 files changed, 1620 insertions(+), 25 deletions(-)
 create mode 100644 fs/fuse/fuse_iomap.h
 create mode 100644 fs/fuse/fuse_iomap_i.h
 create mode 100644 fs/fuse/fuse_iomap.c

