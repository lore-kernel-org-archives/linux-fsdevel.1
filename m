Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D3EC367F2F;
	Sun, 11 Oct 2026 22:16:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791756971; cv=none; b=BCLvlcBow8dVGBs/AZMxBpL2RLq5LhZxIIMi8V12NL4hNUx6zWeVwO2GvTy99C6mTkGXH/vOYKuzpIVxE/LRPhYBH32gKOWu/wBVBzgciRHhnDdw/FBj23fgWX2u9DAARA/G7UYME4BcR0ZQeaTDIArlvlqcLpen1HAyvFbpQww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791756971; c=relaxed/simple;
	bh=BVVkhgggdd6o0v6W5xxFIFMyEN5wD2bILzn+CGpD4sM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=dE+VrsPAUm+m+96pF5k2ZDr7JY7uaMV1vqi/nwCodSGAhEO7OpqpztOap7kXoYqN5tXxWbKgSK22j9RgrFZIefcMisDbPyj5YktuUjVkH0q7k3PLU+UaU5UhM7zUOt7uqAs0aYuuuHd3oHqPIr9/Iow1krzkjjxh/VxwoUQas/Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RdOeRgeF; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RdOeRgeF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 94CFD1F0089B;
	Sun, 11 Oct 2026 22:16:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791756970;
	bh=Q9QD5Up22O7kK1udohhlV3nu1/nCaiw/h4OPsFiiy1A=;
	h=From:To:Cc:Subject:Date;
	b=RdOeRgeFW2j5wh8eZQkLqiO2/XxWYZWwJAmRkFLrA+gT5g4VAmfKpE3qS10D+8ozZ
	 NK0LisCCEkCAqKrnGYIoNANPcSbrnE8l+75qyxHf74uix6epgNqNXT34yqdKyGEuAk
	 3bAjreqAmLJfFjbnf74wnenwE5CMSVgbM0FB0QKHDBoYBnv4aGyz0zNLzo0pCUH2bR
	 W3+dWgl1e2hPRznIJHV2wyXhTr3q1eH4v1fhYOl5/6RJqQL4CywgsBQYHZwdhiSALy
	 7gN2BCmZozwoX1cJYzLF/BuXaAj+VsHNeKVw12+kKhlCcGmnP7POsjfxNIzLknmVMe
	 WQyPxtdjONHsA==
From: Namjae Jeon <linkinjeon@kernel.org>
To: hyc.lee@gmail.com
Cc: ntfs@lists.linux.dev,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	sebastian.n.feld@gmail.com,
	cedric.blancher@gmail.com,
	Lionelcons1972@gmail.com,
	charsyam@gmail.com,
	Namjae Jeon <linkinjeon@kernel.org>
Subject: [PATCH v3 0/4] ntfs: add named data stream support
Date: Mon, 12 Oct 2026 07:15:57 +0900
Message-Id: <20261011221601.6707-1-linkinjeon@kernel.org>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

NTFS supports multiple named $DATA attributes, commonly known as
alternate data streams. This series adds support for accessing these
streams in the ntfs driver through a new ioctl interface and an
optional Windows-style pathname interface.

v3:
  - Fix named-stream runlist error handling to unlock the base inode MFT
    record mutex.
  - Disallow streams_interface changes on remount to avoid stale dentries.
  - Propagate named-stream read errors and document short-read EOF behavior.
  - Disallow named-stream removal from NTFS read-only base objects and clarify
    pathname deletion authorization through the parent directory.
  - Refresh stream inode timestamps after successful updates to the base inode.

v2:
  - Add the optional Windows-style pathname interface, exposing streams as
    regular files with the operations needed by Wine.
  - Document both interfaces and add MAINTAINERS coverage for the UAPI.

The ioctl interface provides stream enumeration, reading, writing, and
removal through an opened base file. Read and write requests specify a
stream name and byte range. Names use the mounted NLS by default, with
raw UTF-16LE available for lossless access. These ioctls remain available
regardless of the pathname mount option.

For example, a userspace program can enumerate streams on an opened base
file as follows. Usual headers are assumed. Error handling and retrying
with a larger buffer after ENOSPC are omitted:

  int fd = open("/mnt/file", O_RDONLY);
  size_t size = 8192;
  struct ntfs_list_streams *req =
          calloc(1, sizeof(*req) + size);

  req->buffer_size = size;
  ioctl(fd, NTFS_IOC_LIST_STREAMS, req);
  printf("Total named streams: %llu\n",
         (unsigned long long)req->stream_count);
  free(req);
  close(fd);

The pathname interface is disabled by default and can be enabled with
streams_interface=windows. In this mode, file:stream opens a
named $DATA stream as a regular file descriptor, allowing ordinary file
operations to be used:

  $ mount -t ntfs /dev/sdb1 /mnt -o streams_interface=windows
  $ printf 'This is a secret note\n' > /mnt/file:Note
  $ cat /mnt/file:Note
  This is a secret note

A stream can be created only for an existing file or directory. Only the
final path component's file:stream form is supported. The pathname
interface accepts a base file name and stream name only. It rejects paths
that also specify an NTFS attribute type such as $DATA. In windows mode,
ordinary filenames containing ':' are hidden from directory listings.

Namjae Jeon (4):
  ntfs: add named stream ioctls support
  ntfs: add pathname access for named streams
  MAINTAINERS: ntfs: add UAPI header
  ntfs: document named streams

 Documentation/filesystems/ntfs.rst            |   34 +
 .../userspace-api/ioctl/ioctl-number.rst      |    1 +
 MAINTAINERS                                   |    1 +
 fs/ntfs/Makefile                              |    2 +-
 fs/ntfs/attrib.c                              |  168 +-
 fs/ntfs/attrib.h                              |    2 +-
 fs/ntfs/attrlist.c                            |    3 +-
 fs/ntfs/dir.c                                 |    7 +-
 fs/ntfs/ea.c                                  |   21 +-
 fs/ntfs/file.c                                |  253 ++-
 fs/ntfs/inode.c                               |  210 +-
 fs/ntfs/inode.h                               |   19 +
 fs/ntfs/iomap.c                               |   64 +-
 fs/ntfs/named_stream.c                        | 1821 +++++++++++++++++
 fs/ntfs/namei.c                               |  175 +-
 fs/ntfs/stream.h                              |   81 +
 fs/ntfs/super.c                               |   33 +
 fs/ntfs/volume.h                              |    3 +
 fs/ntfs/wof.c                                 |    6 +-
 include/uapi/linux/ntfs.h                     |  126 ++
 20 files changed, 2818 insertions(+), 212 deletions(-)
 create mode 100644 fs/ntfs/named_stream.c
 create mode 100644 fs/ntfs/stream.h
 create mode 100644 include/uapi/linux/ntfs.h

-- 
2.25.1

