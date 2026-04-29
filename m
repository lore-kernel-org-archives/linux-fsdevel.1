Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10F2230CD81;
	Wed, 29 Apr 2026 14:18:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777472326; cv=none; b=pM8JvKD4ZKRm+ZF0OzI+ykGBSrOVW9DDUAdbbzs48PQzKGg0Ngq1+Lt88wIxNwg2iYyvyDusqW/wAlQWNny5bMPDg5eEejyV5IR2gxKmfpvK0jkYnl3ysNjm5zVdnX+YmwfAJ1iNM2Qw9y4yODvm1PFqQx9WIRoUjdPkheYoffQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777472326; c=relaxed/simple;
	bh=UzYhfn1/rXLKSRHZPBHqG+VZ7xYRHhw3y6La0vr5xVQ=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sWzjjqNGvPTz42FYwOPZgFwVDDeweKce+TRvBNDz8CEZP7kZLSsm+dlAR4oMo2mjCr5zMYsJLMda3dM3s4zhG/T+IT4OBFLKbX2WR7NnFkxXDVs2marWnNJMWn1HYJioBWSXWuIA+z+cE+aHti1CpOycIo8OEoUbHenOnlK3imQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uv2N+ATF; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uv2N+ATF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2E05DC19425;
	Wed, 29 Apr 2026 14:18:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777472325;
	bh=UzYhfn1/rXLKSRHZPBHqG+VZ7xYRHhw3y6La0vr5xVQ=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=uv2N+ATFqodPl2PoSYonwqXrUcbXBPfN018aKlIjFPEKSDwMDMa8BnR/ogV5ACDu9
	 oQXFQzWyz0K8PRAdOMpHy59NRIwdHoYcwlxzoeslLfVcod1ZydX5ip6eDZUqxz//r2
	 US9GF7oDuuJ/RD+5v/+Jw4QGA+JFqF2/FlKUolNz5SZLkh693Q+vkOCk/J6QCAF4uc
	 ZW9WEK8BfKeCmLYilFlAEVgcfWSkqC79leAMj/QOqGEQ2LHD6npGmZq4FIRzqiCrcW
	 6EL5gUhAaVvuiUOIi/aO2KRcuDTSWYJDFR8h12fTXZwA4OAfYex6lAR0rwppuFvHpV
	 KWX/7Hj3UeNNg==
Date: Wed, 29 Apr 2026 07:18:44 -0700
Subject: [PATCHSET v8 1/6] libfuse: allow servers to use iomap for better file
 IO performance
From: "Darrick J. Wong" <djwong@kernel.org>
To: djwong@kernel.org, bernd@bsbernd.com
Cc: miklos@szeredi.hu, linux-fsdevel@vger.kernel.org,
 fuse-devel@lists.linux.dev, joannelkoong@gmail.com, neal@gompa.dev
Message-ID: <177747211463.4104686.1151865355399948078.stgit@frogsfrogsfrogs>
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

This series connects libfuse to the iomap-enabled fuse driver in Linux to get
fuse servers out of the business of handling file I/O themselves.  By keeping
the IO path mostly within the kernel, we can dramatically improve the speed of
disk-based filesystems.  This enables us to move all the filesystem metadata
parsing code out of the kernel and into userspace, which means that we can
containerize them for security without losing a lot of performance.

If you're going to start using this code, I strongly recommend pulling
from my git trees, which are linked below.

With a bit of luck, this should all go splendidly.
Comments and questions are, as always, welcome.

--D

kernel git tree:
https://git.kernel.org/cgit/linux/kernel/git/djwong/xfs-linux.git/log/?h=fuse-iomap-fileio
---
Commits in this patchset:
 * libfuse: bump kernel and library ABI versions
 * libfuse: wait in do_destroy until all open files are closed
 * libfuse: add kernel gates for FUSE_IOMAP
 * libfuse: add fuse commands for iomap_begin and end
 * libfuse: add upper level iomap commands
 * libfuse: add a lowlevel notification to add a new device to iomap
 * libfuse: add upper-level iomap add device function
 * libfuse: add iomap ioend low level handler
 * libfuse: add upper level iomap ioend commands
 * libfuse: add a reply function to send FUSE_ATTR_* to the kernel
 * libfuse: connect high level fuse library to fuse_reply_attr_iflags
 * libfuse: support enabling exclusive mode for files
 * libfuse: support direct I/O through iomap
 * libfuse: don't allow hardlinking of iomap files in the upper level fuse library
 * libfuse: allow discovery of the kernel's iomap capabilities
 * libfuse: add lower level iomap_config implementation
 * libfuse: add upper level iomap_config implementation
 * libfuse: add low level code to invalidate iomap block device ranges
 * libfuse: add upper-level API to invalidate parts of an iomap block device
 * libfuse: add atomic write support
 * libfuse: allow disabling of fs memory reclaim and write throttling
 * libfuse: create a helper to transform an open regular file into an open loopdev
 * libfuse: add swapfile support for iomap files
 * libfuse: add lower-level filesystem freeze, thaw, and shutdown requests
 * libfuse: add upper-level filesystem freeze, thaw, and shutdown events
---
 include/fuse.h          |  102 ++++++++
 include/fuse_common.h   |  149 ++++++++++++
 include/fuse_kernel.h   |  147 ++++++++++++
 include/fuse_loopdev.h  |   29 ++
 include/fuse_lowlevel.h |  307 ++++++++++++++++++++++++
 include/fuse_service.h  |   12 +
 lib/fuse_i.h            |    4 
 ChangeLog.rst           |    5 
 example/printcap.c      |    1 
 include/meson.build     |    4 
 lib/fuse.c              |  593 +++++++++++++++++++++++++++++++++++++++++++----
 lib/fuse_loopdev.c      |  441 +++++++++++++++++++++++++++++++++++
 lib/fuse_lowlevel.c     |  564 +++++++++++++++++++++++++++++++++++++++++++--
 lib/fuse_service.c      |    5 
 lib/fuse_service_stub.c |    5 
 lib/fuse_versionscript  |   24 ++
 lib/meson.build         |    7 -
 meson.build             |   13 +
 18 files changed, 2329 insertions(+), 83 deletions(-)
 create mode 100644 include/fuse_loopdev.h
 create mode 100644 lib/fuse_loopdev.c

