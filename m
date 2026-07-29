Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55FFA471CFF;
	Wed, 29 Jul 2026 10:56:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785322620; cv=none; b=bSBu+JTwgoxbu9zlf1xL6I/QuG8p07gkV9We5AqgJ2IsTzajpl3QRjyPUm78Vg/hiJrkPSK6URU6B4ZcM8iFiYkxxO/LA7klJpEFmexBnLqOUv7V/Bz2SXATQ+t4y0XFIGS7AR1GCyraGM8y6Vklp367xinlMah66G0mooJnrtE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785322620; c=relaxed/simple;
	bh=GN/kX4xuagAcb4PcPkVPlV61Lyu2idCVu02Xq7DM7i0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Mreg7mgK7ddTCovpauVl79zwIeABaZ1Q5lB9AjK5wbU5FVuntRYEaZ9Ohjwi66RObT3dWgH6gEqR9P5EdgwmxGYeKA5RZDHnPT4XJtGqcwJd3/8rkQ7aj2wyAdFmPNc9kvGSJ7ZO+QYVYSrIF2fGHb5AmAUcISFlTvQDeVg42V4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nhc1rG+P; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nhc1rG+P"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8DF0B1F00A3A;
	Wed, 29 Jul 2026 10:56:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785322619;
	bh=IBSQ/f7K5jV/NE43W9zs6NwVOoO9dxPAAzl4WyaHZwg=;
	h=From:To:Cc:Subject:Date;
	b=nhc1rG+Pwgg3MPGvsiQK4jW6VFNDQVhVEpANN6YQDZwOFZs4i/CEu2EWzVArveTTu
	 sb5N4ur1bC2v868VENmjrAa/SAUHsuWtgJmOEhdKQLTeJp9gh/oMTgnGNy6Sp4fNGe
	 ImVYpuHZ9TyC82GONQUPxGz6SmZGAiDU5AXK2MixMEj7vytrLiRmT7paWrbi+xwmAM
	 4xiTW1tdMu5PsAIORWMDcotTpsx/nP7oEWgJ1I/xuvcbCHC6Mz8v4k62FTj0k+0PdM
	 OJrE6j2Yp+L/1CxgeRBkyRWBRA6E7enlc/0N7/8Hk8FJspYPxjBHHtqRCkSItqeA1x
	 H9uxSaysQ1vlQ==
From: Namjae Jeon <linkinjeon@kernel.org>
To: hyc.lee@gmail.com
Cc: ntfs@lists.linux.dev,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	sebastian.n.feld@gmail.com,
	cedric.blancher@gmail.com,
	Lionelcons1972@gmail.com,
	Namjae Jeon <linkinjeon@kernel.org>
Subject: [PATCH 0/1] ntfs: introduce named data stream ioctls
Date: Wed, 29 Jul 2026 19:52:58 +0900
Message-Id: <20260729105259.11810-1-linkinjeon@kernel.org>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

NTFS supports multiple named $DATA attributes, commonly known as
alternate data streams. This adds NTFS-specific ioctls to list,
read, write, and remove named streams from an opened file.

Example code (ntfs-stream-ioctl.c):

 Usage: ./ntfs-stream-ioctl <file> <command> [args...] [--utf16]

 Commands:
   list                          List all named streams
   read <stream_name>            Read content of a stream
   write <stream_name> <data>    Write data to a stream
   remove <stream_name>          Delete a named stream

 Options:
   --utf16    Use raw UTF-16LE mode (lossless)


Example usage:

  $ ./ntfs-stream-ioctl /mnt/file write Note "This is a secret note"
      Successfully written to stream: Note
     
  $ ./ntfs-stream-ioctl /mnt/file read Note
      This is a secret note

  $ ./ntfs-stream-ioctl /mnt/file list
      Total named streams: 2
        Note   (size: 21 bytes)
        stream0   (size: 12 bytes)


ntfs-stream-ioctl.c:

#include <errno.h>
#include <fcntl.h>
#include <linux/ntfs.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <sys/ioctl.h>
#include <unistd.h>
#include <stdbool.h>
#include <stdint.h>

static void die(const char *msg)
{
	perror(msg);
	exit(EXIT_FAILURE);
}

static void usage(const char *prog)
{
	fprintf(stderr, "Usage: %s <file> <command> [args...] [--utf16]\n\n", prog);
	fprintf(stderr, "Commands:\n");
	fprintf(stderr, "  list                          List all named streams\n");
	fprintf(stderr, "  read <stream_name>            Read content of a stream\n");
	fprintf(stderr, "  write <stream_name> <data>    Write data to a stream\n");
	fprintf(stderr, "  remove <stream_name>          Delete a named stream\n\n");
	fprintf(stderr, "Options:\n");
	fprintf(stderr, "  --utf16    Use raw UTF-16LE mode (lossless)\n\n");
	exit(EXIT_FAILURE);
}

static void copy_name_utf16le(void *dest, const char *src, size_t len)
{
	uint8_t *d = dest;
	for (size_t i = 0; i < len; i++) {
		d[i*2]     = (uint8_t)src[i];   // Little-endian low byte
		d[i*2 + 1] = 0;                 // high byte = 0 (ASCII)
	}
}

static void stream_write(int fd, const char *name, const char *data, bool utf16)
{
	size_t name_len = strlen(name);
	size_t data_len = strlen(data);
	size_t name_buf_len = utf16 ? name_len * 2 : name_len;
	size_t req_len = sizeof(struct ntfs_stream) + name_buf_len + data_len;

	struct ntfs_stream *req = calloc(1, req_len);
	if (!req) die("calloc");

	req->flags = utf16 ? NTFS_STREAM_FL_UTF16 : 0;
	req->name_len = name_buf_len;
	req->io_len = data_len;

	if (utf16)
		copy_name_utf16le(req->buffer, name, name_len);
	else
		memcpy(req->buffer, name, name_len);

	memcpy(req->buffer + name_buf_len, data, data_len);

	if (ioctl(fd, NTFS_IOC_STREAM_WRITE, req) < 0)
		die("NTFS_IOC_STREAM_WRITE");

	printf("Successfully written to stream: %s\n", name);
	free(req);
}

static void stream_read(int fd, const char *name, bool utf16)
{
	size_t name_len = strlen(name);
	size_t name_buf_len = utf16 ? name_len * 2 : name_len;
	size_t buf_size = 8192;
	size_t req_len = sizeof(struct ntfs_stream) + name_buf_len + buf_size;

	struct ntfs_stream *req = calloc(1, req_len);
	if (!req) die("calloc");

	req->flags = utf16 ? NTFS_STREAM_FL_UTF16 : 0;
	req->name_len = name_buf_len;
	req->io_len = buf_size;
	req->stream_offset = 0;

	if (utf16)
		copy_name_utf16le(req->buffer, name, name_len);
	else
		memcpy(req->buffer, name, name_len);

	if (ioctl(fd, NTFS_IOC_STREAM_READ, req) < 0)
		die("NTFS_IOC_STREAM_READ");

	printf("%.*s\n", (int)req->bytes_returned,
			(char *)req->buffer + req->name_len);

	free(req);
}

static void list_streams(int fd, bool utf16)
{
	struct ntfs_list_streams *list;
	struct ntfs_stream_entry *entry;
	size_t buf_len = 8192 * 4;
	size_t off = 0;

	list = calloc(1, sizeof(*list) + buf_len);
	if (!list) die("calloc");

	list->buffer_size = buf_len;
	list->flags = utf16 ? NTFS_STREAM_FL_UTF16 : 0;

	if (ioctl(fd, NTFS_IOC_LIST_STREAMS, list) < 0)
		die("NTFS_IOC_LIST_STREAMS");

	printf("Total named streams: %llu\n", (unsigned long long)list->stream_count);

	while (off < list->bytes_returned) {
		entry = (struct ntfs_stream_entry *)(list->buffer + off);

		if (utf16) {
			printf("  UTF16: ");
			for (size_t i = 0; i + 1 < entry->name_len; i += 2) {
				uint16_t c = entry->name[i] | (entry->name[i+1] << 8);
				if (c >= 0x20 && c < 0x7F)
					putchar(c);
				else
					printf("\\u%04x", c);
			}
			printf("  (len=%u bytes, size=%llu)\n",
					entry->name_len, (unsigned long long)entry->size);
		} else {
			printf("  %.*s   (size: %llu bytes)\n",
					(int)entry->name_len, entry->name,
					(unsigned long long)entry->size);
		}

		if (entry->next_entry_off == 0)
			break;

		off += entry->next_entry_off;
	}

	free(list);
}

static void stream_remove(int fd, const char *name, bool utf16)
{
	size_t name_len = strlen(name);
	size_t name_buf_len = utf16 ? name_len * 2 : name_len;
	size_t req_len = sizeof(struct ntfs_stream) + name_buf_len;

	struct ntfs_stream *req = calloc(1, req_len);
	if (!req) die("calloc");

	req->flags = utf16 ? NTFS_STREAM_FL_UTF16 : 0;
	req->name_len = name_buf_len;
	req->io_len = 0;

	if (utf16)
		copy_name_utf16le(req->buffer, name, name_len);
	else
		memcpy(req->buffer, name, name_len);

	if (ioctl(fd, NTFS_IOC_STREAM_REMOVE, req) < 0)
		die("NTFS_IOC_STREAM_REMOVE");

	printf("Successfully removed stream: %s\n", name);
	free(req);
}

int main(int argc, char **argv)
{
	int fd;
	const char *filename;
	bool utf16 = false;
	int cmd_idx = 2;

	if (argc < 3)
		usage(argv[0]);

	filename = argv[1];

	for (int i = 3; i < argc; i++) {
		if (strcmp(argv[i], "--utf16") == 0) {
			utf16 = true;
			argc = i;
			break;
		}
	}

	fd = open(filename, O_RDWR);
	if (fd < 0)
		die("open");

	if (strcmp(argv[cmd_idx], "list") == 0) {
		list_streams(fd, utf16);
	}
	else if (strcmp(argv[cmd_idx], "read") == 0) {
		if (argc < cmd_idx + 2) usage(argv[0]);
		stream_read(fd, argv[cmd_idx + 1], utf16);
	}
	else if (strcmp(argv[cmd_idx], "write") == 0) {
		if (argc < cmd_idx + 3) usage(argv[0]);
		stream_write(fd, argv[cmd_idx + 1], argv[cmd_idx + 2], utf16);
	}
	else if (strcmp(argv[cmd_idx], "remove") == 0) {
		if (argc < cmd_idx + 2) usage(argv[0]);
		stream_remove(fd, argv[cmd_idx + 1], utf16);
	}
	else {
		fprintf(stderr, "Unknown command: %s\n", argv[cmd_idx]);
		usage(argv[0]);
	}

	close(fd);
	return EXIT_SUCCESS;
}

Namjae Jeon (1):
  ntfs: add ioctl support for named data streams

 .../userspace-api/ioctl/ioctl-number.rst      |   1 +
 fs/ntfs/file.c                                | 509 ++++++++++++++++++
 include/uapi/linux/ntfs.h                     | 115 ++++
 3 files changed, 625 insertions(+)
 create mode 100644 include/uapi/linux/ntfs.h

-- 
2.25.1

