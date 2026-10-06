Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16C473B9D9E;
	Tue,  6 Oct 2026 22:41:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791326495; cv=none; b=FkPrRem+Nl7phPQUIj4x4FzRgoFbH1XSNo5siOyebOuaaS8V80EQv07ej+QogXoeecS3Zv/AQ2dKj7jak9QK52Lk9ZpuE8DtGoRDDsCW81n1A1G496bsXhuHsdMqQApUolnF7BxdjPmZjQErzz8cUivKIrTcwlxGsX+ENuMrwyk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791326495; c=relaxed/simple;
	bh=I9xxhsO2w6VGUs42768h2SG95ZFb1H0j++K/F4VfNMo=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=LexTzMd2vJ4YoJCPGOPZtak3iEKmqQG0y0MU6NUkD00V3ngXwWYwyboteF4d5xH2rflUkPAvMpE9OHFdhnEz5uDQmuM4IiaroMThq2uggo8H5I/DIRHTiZVPQv+JCigSialI/iO+sQEgOt+Oi78dJArad/HCS10umNO2djh84nQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eeby68nw; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eeby68nw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3ECA31F0089F;
	Tue,  6 Oct 2026 22:40:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791326459;
	bh=d6J1PNDBYwLXs3RtTibAVOec8+VM7r9+r9AgPrS27A4=;
	h=From:To:Cc:Subject:Date;
	b=eeby68nwI7a6vgRx7NrMJf1xv6wOvQhq5whNfEUBeUIM3RKu61cr4w9wl5EK4kOHT
	 vreW/u9R6rw4xez3P8Uj7q8x3/lQj7XxMUU9MzTjauwCkY/j/WIfTDwVS+jKdVDJRP
	 bOGV96MbD7TqpwxOfNQfEEKt01Ff2nLRwhtIqhwWBcZ1sJPB0LryV59nj7gUbGN+5R
	 V5EDpABtlJW15zdfbLwf/YDNmHyJv62N8jjrm+LJvaY1kTz5I6zfZYp1o7lxhwNDQr
	 Xm+jPVGQ56Kn0UxXvwwdbWFldq+fSNgpYb2UlsogHXEZxclyWjNntivTPCoutrIsQo
	 9tJqqDUFmM8Wg==
From: Namjae Jeon <linkinjeon@kernel.org>
To: hyc.lee@gmail.com
Cc: ntfs@lists.linux.dev,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	sebastian.n.feld@gmail.com,
	cedric.blancher@gmail.com,
	Lionelcons1972@gmail.com,
	Namjae Jeon <linkinjeon@kernel.org>
Subject: [PATCH v2 0/4] ntfs: add named data stream support
Date: Wed,  7 Oct 2026 07:40:20 +0900
Message-Id: <20261006224024.14535-1-linkinjeon@kernel.org>
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
 fs/ntfs/inode.c                               |  206 +-
 fs/ntfs/inode.h                               |   19 +
 fs/ntfs/iomap.c                               |   62 +-
 fs/ntfs/named_stream.c                        | 1812 +++++++++++++++++
 fs/ntfs/namei.c                               |  175 +-
 fs/ntfs/stream.h                              |   81 +
 fs/ntfs/super.c                               |   23 +
 fs/ntfs/volume.h                              |    3 +
 fs/ntfs/wof.c                                 |    6 +-
 include/uapi/linux/ntfs.h                     |  123 ++
 20 files changed, 2792 insertions(+), 210 deletions(-)
 create mode 100644 fs/ntfs/named_stream.c
 create mode 100644 fs/ntfs/stream.h
 create mode 100644 include/uapi/linux/ntfs.h

-- 
2.25.1

