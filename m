Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2F5B25CC79;
	Wed, 29 Apr 2026 14:48:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777474108; cv=none; b=Y7ZSRArXiNcAF7kXj4UewVxqiWwf5K3YHCsGOw8BWTrhZ/LgrroMhZuLUjNoi/ySTrZvHwphnKL2OV05YbtUXBNGMCvJt/pXpv7INXZdOo0JrKfmVZxbk2/0oSfX/tSoGXyaCHhfIeCktAM/u3S05PHs76IEo/rxObyw4y2zpLc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777474108; c=relaxed/simple;
	bh=IJgplsAQoPWPu0ibZypcbFbgTBQG4+0vk8bW2tEaefo=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PnBzDMjdxi6Gw1iaBakVDrrWETPSDnJ4Mo4SkRt5WKS8BRWRmdCaBDIXS4u8Pi0JkL8wpJNZ2tD/j248bq0+7lzmFxzDew2ALM4gqgSGTmpzEl8u3lPP2/mT+SWEuHGD9tBTBWlxjoUDaGoPIGYrIFg0cM3mw3Z4cPaSqkcDVdo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pExc2pX2; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pExc2pX2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6F66FC19425;
	Wed, 29 Apr 2026 14:48:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777474108;
	bh=IJgplsAQoPWPu0ibZypcbFbgTBQG4+0vk8bW2tEaefo=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=pExc2pX2zrDYOtm+ZElNOUDVKdvO9fiM5FDcPgcnkMjfc4Mi5cBqohPX4ehapcWXn
	 HD47LNHdzg/QT7OFNLVysmj8T/Kx2roUareme3r2x43kyHHyUd6zWlqRwhD4rSdvlD
	 9VH0kUSHpZy/TD5qQ81R4LMthSJr3DSlxCu60uyxTRcjpHZgrDBbAi44AHSc8LUjZ7
	 JrK31JxRPIK1KX+1SVTxBzsfHpX0dbf6L5T4fHIfRV18kM6HCMtLxrmfYqlYokl3nq
	 npSNrtYhd7t/V53HZ91dETZ8fKIH1ZxhEXdrK2BWIsXPI2hKqGNq2vPBDg7hVEu3RH
	 cyag43mSpdMhw==
Date: Wed, 29 Apr 2026 07:48:28 -0700
Subject: [PATCH 5/7] example/iomap_ow_ll: create a simple iomap out of place
 write server
From: "Darrick J. Wong" <djwong@kernel.org>
To: djwong@kernel.org, bernd@bsbernd.com
Cc: miklos@szeredi.hu, linux-fsdevel@vger.kernel.org, john@groves.net,
 fuse-devel@lists.linux.dev, joannelkoong@gmail.com, neal@gompa.dev
Message-ID: <177747212967.4106066.15831817668245975912.stgit@frogsfrogsfrogs>
In-Reply-To: <177747212852.4106066.65045387245092140.stgit@frogsfrogsfrogs>
References: <177747212852.4106066.65045387245092140.stgit@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

From: Darrick J. Wong <djwong@kernel.org>

Create a toy iomap fileserver as an example of how out of place writes
works.

Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
---
 example/single_file.h |    1 
 example/iomap_ow_ll.c |  813 +++++++++++++++++++++++++++++++++++++++++++++++++
 example/meson.build   |    2 
 example/single_file.c |    5 
 4 files changed, 819 insertions(+), 2 deletions(-)
 create mode 100644 example/iomap_ow_ll.c


diff --git a/example/single_file.h b/example/single_file.h
index 90696a4d5a626a..3ee9dd261352ba 100644
--- a/example/single_file.h
+++ b/example/single_file.h
@@ -75,6 +75,7 @@ extern struct single_file single_file;
 struct single_file_ops {
 	uint64_t (*calc_st_blocks)(void);
 	uint64_t (*calc_bfree)(void);
+	uint64_t (*calc_blocks)(void);
 };
 
 static inline uint64_t b_to_fsbt(uint64_t off)
diff --git a/example/iomap_ow_ll.c b/example/iomap_ow_ll.c
new file mode 100644
index 00000000000000..c4edda1f9bfe40
--- /dev/null
+++ b/example/iomap_ow_ll.c
@@ -0,0 +1,813 @@
+/*
+ * FUSE: Filesystem in Userspace
+ * Copyright (C) 2026 Oracle.
+ *
+ * This program can be distributed under the terms of the GNU GPLv2.
+ * See the file GPL2.txt.
+ */
+
+/** @file
+ *
+ * minimal example iomap out of place write filesystem using low-level API
+ *
+ * Compile with:
+ *
+ *     gcc -Wall single_file.c iomap_ow_ll.c `pkg-config fuse3 --cflags --libs` -o iomap_ow_ll
+ *
+ * Note: If the pkg-config command fails due to the absence of the fuse3.pc
+ *     file, you should configure the path to the fuse3.pc file in the
+ *     PKG_CONFIG_PATH variable.
+ *
+ * ## Source code ##
+ * \include iomap_ow_ll.c
+ * \include single_file.c
+ * \include single_file.h
+ */
+
+#define FUSE_USE_VERSION FUSE_MAKE_VERSION(3, 99)
+
+#ifndef _GNU_SOURCE
+#define _GNU_SOURCE
+#endif
+
+#include <fuse_lowlevel.h>
+#include <fuse_loopdev.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <string.h>
+#include <errno.h>
+#include <fcntl.h>
+#include <unistd.h>
+#include <assert.h>
+#include <pthread.h>
+#include <sys/ioctl.h>
+#include <sys/stat.h>
+#include <linux/fs.h>
+#include <linux/stat.h>
+#include <linux/falloc.h>
+#define USE_SINGLE_FILE_LL_API
+#include "single_file.h"
+
+#define max(x, y) ((x) > (y) ? (x) : (y))
+
+#define MAP_HOLE	(0)
+#define MAP_DELALLOC	(1)
+
+static uint16_t read_state_to_iomap_type(uint32_t map)
+{
+	switch (map) {
+	case MAP_HOLE:
+		return FUSE_IOMAP_TYPE_HOLE;
+	case MAP_DELALLOC:
+		return FUSE_IOMAP_TYPE_DELALLOC;
+	}
+
+	return FUSE_IOMAP_TYPE_MAPPED;
+}
+
+static uint16_t write_state_to_iomap_type(uint32_t map)
+{
+	switch (map) {
+	case MAP_HOLE:
+		return FUSE_IOMAP_TYPE_HOLE;
+	case MAP_DELALLOC:
+		return FUSE_IOMAP_TYPE_DELALLOC;
+	}
+
+	return FUSE_IOMAP_TYPE_UNWRITTEN;
+}
+
+struct ioow_ll {
+	struct fuse_session *se;
+	char *device;
+
+	uint32_t *read_map;
+	uint32_t *write_map;
+	uint32_t max_file_blocks;
+
+	uint8_t *freespace;
+	uint64_t bdev_blocks;
+
+	/* really booleans */
+	int debug;
+
+	int dev_index;
+};
+
+static struct ioow_ll ll = { };
+
+static uint64_t ioow_bytes_allocated(void)
+{
+	uint32_t *p, *q;
+	uint64_t i;
+	uint64_t blocks = 0;
+
+	for (i = 0, p = ll.read_map; i < ll.max_file_blocks; i++, p++)
+		if (*p != MAP_HOLE)
+			blocks++;
+
+	for (i = 0, q = ll.write_map; i < ll.max_file_blocks; i++, q++)
+		if (*q != MAP_HOLE)
+			blocks++;
+
+	return fsb_to_b(blocks);
+}
+
+static uint64_t ioow_ll_calc_stblocks(void)
+{
+	return howmany(ioow_bytes_allocated(), 512);
+}
+
+static uint64_t ioow_ll_calc_blocks(void)
+{
+	return ll.bdev_blocks;
+}
+
+static uint64_t ioow_ll_calc_bfree(void)
+{
+	return ll.bdev_blocks - b_to_fsb(ioow_bytes_allocated());
+}
+
+static void ioow_ll_init(void *userdata, struct fuse_conn_info *conn)
+{
+	(void)userdata;
+
+	if (fuse_set_feature_flag(conn, FUSE_CAP_IOMAP))
+		single_file.uses_iomap = true;
+	conn->time_gran = 1;
+}
+
+static int ioow_iomap_config_devices(void)
+{
+	int blocksize = single_file.blocksize;
+	int ret;
+
+	ll.dev_index = fuse_lowlevel_iomap_device_add(ll.se, single_file.backing_fd, 0);
+	if (ll.dev_index < 0) {
+		ret = -ll.dev_index;
+		printf("%s: cannot register iomap dev fd=%d: %s\n",
+		       ll.device, single_file.backing_fd, strerror(ret));
+		return ret;
+	}
+
+	ret = ioctl(single_file.backing_fd, BLKBSZSET, &blocksize);
+	if (ret) {
+		printf("%s: cannot set block size %u: %s\n",
+		       ll.device, single_file.blocksize, strerror(errno));
+		return errno;
+	}
+
+	return 0;
+}
+
+static void ioow_ll_iomap_config(fuse_req_t req,
+				 const struct fuse_iomap_config_params *p,
+				 size_t psize)
+{
+	struct fuse_iomap_config cfg = { };
+	int ret;
+
+	(void)p;
+	(void)psize;
+
+	cfg.flags |= FUSE_IOMAP_CONFIG_BLOCKSIZE;
+	cfg.s_blocksize = single_file.blocksize;
+
+	cfg.flags |= FUSE_IOMAP_CONFIG_MAXBYTES;
+	cfg.s_maxbytes = fsb_to_b(ll.max_file_blocks);
+
+	ret = ioow_iomap_config_devices();
+	if (ret)
+		fuse_reply_err(req, ret);
+	else
+		fuse_reply_iomap_config(req, &cfg);
+}
+
+static ssize_t adjust_endoff(uint64_t fileoff, uint64_t *endoff)
+{
+	if (fileoff >= ll.max_file_blocks)
+		return -EIO;
+	if (*endoff > ll.max_file_blocks)
+		*endoff = ll.max_file_blocks;
+	return 0;
+}
+
+static ssize_t ioow_begin_report(off_t pos, uint64_t count, uint32_t opflags,
+				 struct fuse_file_iomap *read,
+				 struct fuse_file_iomap *write)
+{
+	uint64_t fileoff, endoff;
+	uint32_t *p, *q;
+	uint32_t orig_p, orig_q;
+	ssize_t ret;
+
+	(void)opflags;
+
+	fileoff = b_to_fsbt(pos);
+	endoff = b_to_fsb(pos + count);
+
+	ret = adjust_endoff(fileoff, &endoff);
+	if (ret)
+		return ret;
+
+	if (ll.debug)
+		fprintf(stderr,
+"%s: pos 0x%llx count 0x%llx fileoff 0x%llx endoff 0x%llx new_endoff 0x%llx\n",
+			__func__,
+			(unsigned long long)pos,
+			(unsigned long long)count,
+			(unsigned long long)fileoff,
+			(unsigned long long)b_to_fsb(pos + count),
+			(unsigned long long)endoff);
+
+	read->offset = fsb_to_b(fileoff);
+	write->offset = fsb_to_b(fileoff);
+	read->length = 0;
+	write->length = 0;
+
+	orig_p = ll.read_map[fileoff];
+	orig_q = ll.write_map[fileoff];
+	read->type = read_state_to_iomap_type(orig_p);
+	write->type = write_state_to_iomap_type(orig_q);
+
+	switch (read->type) {
+	case FUSE_IOMAP_TYPE_MAPPED:
+	case FUSE_IOMAP_TYPE_UNWRITTEN:
+		read->dev = ll.dev_index;
+		read->addr = fsb_to_b(orig_p);
+		break;
+	case FUSE_IOMAP_TYPE_DELALLOC:
+	case FUSE_IOMAP_TYPE_HOLE:
+		read->dev = FUSE_IOMAP_DEV_NULL;
+		read->addr = FUSE_IOMAP_NULL_ADDR;
+		break;
+	default:
+		return -EIO;
+	}
+
+	switch (write->type) {
+	case FUSE_IOMAP_TYPE_MAPPED:
+	case FUSE_IOMAP_TYPE_UNWRITTEN:
+		write->dev = ll.dev_index;
+		write->addr = fsb_to_b(orig_q);
+		break;
+	case FUSE_IOMAP_TYPE_DELALLOC:
+	case FUSE_IOMAP_TYPE_HOLE:
+		write->dev = FUSE_IOMAP_DEV_NULL;
+		write->addr = FUSE_IOMAP_NULL_ADDR;
+		break;
+	default:
+		return -EIO;
+	}
+
+	for (p = ll.read_map + fileoff, q = ll.write_map + fileoff;
+	     fileoff < endoff;
+	     p++, q++, fileoff++) {
+		if (read->type != read_state_to_iomap_type(*p))
+			break;
+		if (write->type != write_state_to_iomap_type(*q))
+			break;
+		if (read->type == FUSE_IOMAP_TYPE_MAPPED &&
+		    read->addr + read->length != fsb_to_b(*p))
+			break;
+		if (write->type == FUSE_IOMAP_TYPE_MAPPED &&
+		    write->addr + write->length != fsb_to_b(*q))
+			break;
+
+		read->length += single_file.blocksize;
+		write->length += single_file.blocksize;
+	}
+
+	return 0;
+}
+
+static ssize_t ioow_begin_read(off_t pos, uint64_t count, uint32_t opflags,
+			       struct fuse_file_iomap *read,
+			       struct fuse_file_iomap *write)
+{
+	return ioow_begin_report(pos, count, opflags, read, write);
+}
+
+struct free_extent {
+	uint32_t startblock;
+	uint32_t blockcount;
+};
+
+#define FIND_FREE_INIT_CURSOR	(MAP_DELALLOC + 1)
+
+static uint32_t ioow_find_free(uint32_t *cursor)
+{
+	bool wrapped = false;
+
+	while (!wrapped) {
+		if (*cursor >= ll.bdev_blocks || *cursor <= MAP_DELALLOC)
+			*cursor = FIND_FREE_INIT_CURSOR;
+
+		for (; *cursor < ll.bdev_blocks; (*cursor)++) {
+			if (ll.freespace[*cursor]) {
+				ll.freespace[*cursor] = 0;
+				(*cursor)++;
+				return *cursor - 1;
+			}
+		}
+
+		wrapped = true;
+	}
+
+	return MAP_HOLE;
+}
+
+static void ioow_free_block(uint32_t *block)
+{
+	if (*block > MAP_DELALLOC)
+		ll.freespace[*block] = 1;
+	*block = MAP_HOLE;
+}
+
+static void ioow_remap_block(uint32_t *p, uint32_t *q)
+{
+	ioow_free_block(p);
+	*p = *q;
+	*q = MAP_HOLE;
+}
+
+static ssize_t ioow_write_allocate(off_t pos, uint64_t count, uint32_t opflags)
+{
+	uint64_t fileoff, endoff;
+	uint32_t *q;
+	const bool direct = opflags & (FUSE_IOMAP_OP_DIRECT |
+				       FUSE_IOMAP_OP_WRITEBACK);
+	uint32_t cursor = FIND_FREE_INIT_CURSOR;
+	ssize_t ret;
+
+	if (opflags & FUSE_IOMAP_OP_ZERO)
+		return 0;
+
+	fileoff = b_to_fsbt(pos);
+	endoff = b_to_fsb(pos + count);
+
+	ret = adjust_endoff(fileoff, &endoff);
+	if (ret)
+		return ret;
+
+	if (ll.debug)
+		fprintf(stderr, "%s: set %s pos 0x%llx count 0x%llx\n",
+			__func__,
+			direct ? "unwritten" : "delalloc",
+			(unsigned long long)pos,
+			(unsigned long long)count);
+
+	for (q = ll.write_map + fileoff; fileoff < endoff; q++, fileoff++) {
+		if (!direct && *q == MAP_HOLE) {
+			fprintf(stderr, "%s: fileoff %lu delalloc\n", __func__, fileoff);
+			*q = MAP_DELALLOC;
+			continue;
+		}
+
+		if (direct && (*q == MAP_HOLE || *q == MAP_DELALLOC)) {
+			uint32_t free_block = ioow_find_free(&cursor);
+
+			if (free_block == MAP_HOLE)
+				return -ENOSPC;
+
+			fprintf(stderr, "%s: fileoff %lu unwritten %u\n",
+				__func__, fileoff, free_block);
+			*q = free_block;
+		}
+	}
+
+	single_file.isize = max(single_file.isize, pos + count);
+	return 0;
+}
+
+static ssize_t ioow_begin_write(off_t pos, uint64_t count, uint32_t opflags,
+				struct fuse_file_iomap *read,
+				struct fuse_file_iomap *write)
+{
+	ssize_t ret;
+
+	ret = ioow_write_allocate(pos, count, opflags);
+	if (ret)
+		return ret;
+
+	return ioow_begin_read(pos, count, opflags, read, write);
+}
+
+static void ioow_ll_iomap_begin(fuse_req_t req, fuse_ino_t ino,
+				 uint64_t dontcare, off_t pos, uint64_t count,
+				 uint32_t opflags)
+{
+	struct fuse_file_iomap read, write;
+	ssize_t got;
+	int ret = 0;
+
+	(void)dontcare;
+
+	if (!is_single_file_ino(ino)) {
+		ret = EIO;
+		goto out_reply;
+	}
+
+	if (ll.debug)
+		fprintf(stderr, "%s: pos 0x%llx count 0x%llx opflags 0x%x\n",
+			__func__,
+			(unsigned long long)pos,
+			(unsigned long long)count,
+			opflags);
+
+	if (!single_file.allow_dio && (opflags & FUSE_IOMAP_OP_DIRECT)) {
+		ret = ENOSYS;
+		goto out_reply;
+	}
+
+	memset(&read, 0, sizeof(read));
+	memset(&write, 0, sizeof(write));
+
+	pthread_mutex_lock(&single_file.lock);
+	if (opflags & FUSE_IOMAP_OP_REPORT)
+		got = ioow_begin_report(pos, count, opflags, &read, &write);
+	else if (fuse_iomap_is_write(opflags))
+		got = ioow_begin_write(pos, count, opflags, &read, &write);
+	else
+		got = ioow_begin_read(pos, count, opflags, &read, &write);
+	if (got < 0) {
+		ret = -got;
+		goto out_unlock;
+	}
+
+	if (ll.debug) {
+		fprintf(stderr,
+"%s: read offset 0x%llx length 0x%llx type %u dev %u addr 0x%llx flags 0x%x\n",
+			__func__,
+			(unsigned long long)read.offset,
+			(unsigned long long)read.length,
+			read.type,
+			read.dev,
+			(unsigned long long)read.addr,
+			read.flags);
+		fprintf(stderr,
+"%s: write offset 0x%llx length 0x%llx type %u dev %u addr 0x%llx flags 0x%x\n",
+			__func__,
+			(unsigned long long)write.offset,
+			(unsigned long long)write.length,
+			write.type,
+			write.dev,
+			(unsigned long long)write.addr,
+			write.flags);
+	}
+
+	/* Not filling even the first byte will make the kernel unhappy. */
+	if (read.offset > pos || read.offset + read.length <= pos) {
+		printf("%s: made read bad mapping at pos %llu\n", ll.device,
+		       (unsigned long long)pos);
+		ret = EIO;
+		goto out_unlock;
+	}
+	if (write.offset > pos || write.offset + write.length <= pos) {
+		printf("%s: made bad write mapping at pos %llu\n", ll.device,
+		       (unsigned long long)pos);
+		ret = EIO;
+		goto out_unlock;
+	}
+
+out_unlock:
+	pthread_mutex_unlock(&single_file.lock);
+out_reply:
+	if (ret)
+		fuse_reply_err(req, ret);
+	else
+		fuse_reply_iomap_begin(req, &read, &write);
+}
+
+static void ioow_ll_iomap_end(fuse_req_t req, fuse_ino_t ino,
+			       uint64_t dontcare, off_t pos, uint64_t count,
+			       uint32_t opflags, ssize_t written,
+			       const struct fuse_file_iomap *iomap)
+{
+	uint64_t fileoff, endoff;
+	uint32_t *q;
+	ssize_t got;
+	int ret = 0;
+
+	(void)dontcare;
+	(void)iomap;
+
+	if (!is_single_file_ino(ino)) {
+		ret = EIO;
+		goto out_reply;
+	}
+
+	if (ll.debug)
+		fprintf(stderr, "%s: pos 0x%llx count 0x%llx opflags 0x%x written 0x%zd\n",
+			__func__,
+			(unsigned long long)pos,
+			(unsigned long long)count,
+			opflags,
+			written);
+
+	if (written >= 0)
+		goto out_reply;
+
+	/* punch delalloc mappings due to error */
+	pthread_mutex_lock(&single_file.lock);
+	fileoff = b_to_fsbt(pos);
+	endoff = b_to_fsb(pos + count);
+
+	got = adjust_endoff(fileoff, &endoff);
+	if (got < 0) {
+		ret = -got;
+		goto out_unlock;
+	}
+
+	for (q = ll.write_map + fileoff; fileoff < endoff; q++, fileoff++) {
+		if (*q == MAP_DELALLOC)
+			ioow_free_block(q);
+	}
+
+out_unlock:
+	pthread_mutex_unlock(&single_file.lock);
+out_reply:
+	fuse_reply_err(req, ret);
+}
+
+static void ioow_ll_iomap_ioend(fuse_req_t req, fuse_ino_t ino,
+				 uint64_t dontcare, off_t pos, size_t written,
+				 uint32_t ioendflags, int error, uint32_t dev,
+				 uint64_t new_addr)
+{
+	uint64_t fileoff, endoff;
+	uint32_t *p, *q;
+	ssize_t got;
+	int ret = 0;
+
+	(void)dontcare;
+
+	if (!is_single_file_ino(ino)) {
+		ret = EIO;
+		goto out_reply;
+	}
+
+	if (ll.debug)
+		fprintf(stderr,
+"%s: pos 0x%llx written 0x%zx ioendflags 0x%x error %d dev %u new_addr 0x%llx\n",
+			__func__,
+			(unsigned long long)pos,
+			written,
+			ioendflags,
+			error,
+			dev,
+			(unsigned long long)new_addr);
+
+	if (error) {
+		ret = error;
+		goto out_reply;
+	}
+
+	pthread_mutex_lock(&single_file.lock);
+	fileoff = b_to_fsbt(pos);
+	endoff = b_to_fsb(pos + written);
+
+	got = adjust_endoff(fileoff, &endoff);
+	if (got < 0) {
+		ret = -got;
+		goto out_unlock;
+	}
+
+	for (p = ll.read_map + fileoff, q = ll.write_map + fileoff;
+	     fileoff < endoff; p++, q++, fileoff++) {
+		fprintf(stderr, "%s: fileoff %lu read %u write %u\n", __func__, fileoff, *p, *q);
+		ioow_remap_block(p, q);
+	}
+
+	single_file.isize = max(single_file.isize, pos + written);
+
+out_unlock:
+	pthread_mutex_unlock(&single_file.lock);
+out_reply:
+	if (ret)
+		fuse_reply_err(req, ret);
+	else
+		fuse_reply_iomap_ioend(req, single_file.isize);
+}
+
+static void ioow_ll_fallocate(fuse_req_t req, fuse_ino_t ino, int mode,
+			       off_t pos, off_t count,
+			       struct fuse_file_info *fp)
+{
+	uint64_t fileoff, endoff;
+	uint32_t *p, *q;
+	ssize_t got;
+	int ret = 0;
+
+	(void)fp;
+
+	if (!is_single_file_ino(ino)) {
+		ret = EIO;
+		goto out_reply;
+	}
+
+	if (ll.debug)
+		fprintf(stderr, "%s: pos 0x%llx count 0x%llx mode 0x%x\n",
+			__func__,
+			(unsigned long long)pos,
+			(unsigned long long)count,
+			mode);
+
+	if (!(mode & (FALLOC_FL_ZERO_RANGE | FALLOC_FL_PUNCH_HOLE))) {
+		ret = EOPNOTSUPP;
+		goto out_reply;
+	}
+
+	pthread_mutex_lock(&single_file.lock);
+	fileoff = b_to_fsbt(pos);
+	endoff = b_to_fsb(pos + count);
+
+	got = adjust_endoff(fileoff, &endoff);
+	if (got < 0) {
+		ret = -got;
+		goto out_unlock;
+	}
+
+	for (p = ll.read_map + fileoff, q = ll.write_map + fileoff;
+	     fileoff < endoff;
+	     p++, q++, fileoff++) {
+		ioow_free_block(p);
+		ioow_free_block(q);
+	}
+
+	if (!(mode & FALLOC_FL_KEEP_SIZE))
+		single_file.isize = max(single_file.isize, pos + count);
+
+out_unlock:
+	pthread_mutex_unlock(&single_file.lock);
+out_reply:
+	fuse_reply_err(req, ret);
+}
+
+static const struct fuse_lowlevel_ops ioow_ll_oper = {
+	.lookup		= single_file_ll_lookup,
+	.getattr	= single_file_ll_getattr,
+	.setattr	= single_file_ll_setattr,
+	.readdir	= single_file_ll_readdir,
+	.open		= single_file_ll_open,
+	.statfs		= single_file_ll_statfs,
+	.statx		= single_file_ll_statx,
+	.fsync		= single_file_ll_fsync,
+
+	.init		= ioow_ll_init,
+	.iomap_config	= ioow_ll_iomap_config,
+	.iomap_begin	= ioow_ll_iomap_begin,
+	.iomap_end	= ioow_ll_iomap_end,
+	.iomap_ioend	= ioow_ll_iomap_ioend,
+	.fallocate	= ioow_ll_fallocate,
+};
+
+#define IOOW_LL_OPT(t, p, v) { t, offsetof(struct ioow_ll, p), v }
+
+static struct fuse_opt ioow_ll_opts[] = {
+	IOOW_LL_OPT("debug",		debug,			1),
+	SINGLE_FILE_OPT_KEYS,
+	FUSE_OPT_END
+};
+
+static int ioow_ll_opt_proc(void *data, const char *arg,
+			    int key, struct fuse_args *outargs)
+{
+	if (single_file_opt_proc(data, arg, key, outargs) == 0)
+		return 0;
+
+	switch (key) {
+	case FUSE_OPT_KEY_NONOPT:
+		if (!ll.device) {
+			ll.device = strdup(arg);
+			return 0;
+		}
+		return 1;
+	}
+
+	return 1;
+}
+
+static const struct single_file_ops fops = {
+	.calc_st_blocks		= ioow_ll_calc_stblocks,
+	.calc_blocks		= ioow_ll_calc_blocks,
+	.calc_bfree		= ioow_ll_calc_bfree,
+};
+
+int main(int argc, char *argv[])
+{
+	struct fuse_args args = FUSE_ARGS_INIT(argc, argv);
+	struct fuse_cmdline_opts opts = { };
+	int ret = 1;
+
+	if (fuse_opt_parse(&args, &ll, ioow_ll_opts, ioow_ll_opt_proc))
+		goto err_args;
+
+	if (fuse_parse_cmdline(&args, &opts))
+		goto err_args;
+
+	if (opts.show_help) {
+		printf("usage: %s [options] <device> <mountpoint>\n\n", argv[0]);
+		fuse_cmdline_help();
+		fuse_lowlevel_help();
+		ret = 0;
+		goto err_strings;
+	} else if (opts.show_version) {
+		printf("FUSE library version %s\n", fuse_pkgversion());
+		fuse_lowlevel_version();
+		ret = 0;
+		goto err_strings;
+	}
+
+	if (!opts.mountpoint || !ll.device) {
+		printf("usage: %s [options] <device> <mountpoint>\n", argv[0]);
+		printf("       %s --help\n", argv[0]);
+		goto err_strings;
+	}
+
+	if (single_file_open(ll.device))
+		goto err_strings;
+
+	if (single_file_configure(ll.device, S_IFBLK, "outtaplace", &fops))
+		goto err_singlefile;
+
+	ll.bdev_blocks = single_file.isize / single_file.blocksize;
+	if (ll.bdev_blocks < 3) {
+		fprintf(stderr, "%s: block device must be at least %llu bytes long\n",
+			ll.device, (unsigned long long)single_file.blocksize * 3);
+		goto err_singlefile;
+	}
+	single_file.isize = 0;
+
+	ll.freespace = malloc(ll.bdev_blocks);
+	if (!ll.freespace) {
+		perror("freespace");
+		goto err_singlefile;
+	}
+	memset(ll.freespace, 1, ll.bdev_blocks);
+
+	/* block 0 means hole, block 1 means dealloc, and 1 spare */
+	ll.max_file_blocks = ll.bdev_blocks - 3;
+	ll.read_map = calloc(ll.max_file_blocks, sizeof(uint32_t));
+	if (!ll.read_map) {
+		perror("read map");
+		goto err_freespace;
+	}
+
+	ll.write_map = calloc(ll.max_file_blocks, sizeof(uint32_t));
+	if (!ll.write_map) {
+		perror("read map");
+		goto err_readmap;
+	}
+
+	ll.se = fuse_session_new(&args, &ioow_ll_oper, sizeof(ioow_ll_oper),
+				 NULL);
+	if (ll.se == NULL)
+		goto err_writemap;
+
+	if (fuse_set_signal_handlers(ll.se))
+		goto err_session;
+
+	if (fuse_session_mount(ll.se, opts.mountpoint))
+		goto err_signals;
+
+	fuse_daemonize(opts.foreground);
+
+	/* Block until ctrl+c or fusermount -u */
+	if (opts.singlethread) {
+		ret = fuse_session_loop(ll.se);
+	} else {
+		struct fuse_loop_config *config = fuse_loop_cfg_create();
+
+		if (!config) {
+			ret = 1;
+			goto err_mount;
+		}
+
+		fuse_loop_cfg_set_clone_fd(config, opts.clone_fd);
+		fuse_loop_cfg_set_max_threads(config, opts.max_threads);
+		ret = fuse_session_loop_mt(ll.se, config);
+		fuse_loop_cfg_destroy(config);
+	}
+
+err_mount:
+	fuse_session_unmount(ll.se);
+err_signals:
+	fuse_remove_signal_handlers(ll.se);
+err_session:
+	fuse_session_destroy(ll.se);
+err_writemap:
+	free(ll.write_map);
+err_readmap:
+	free(ll.read_map);
+err_freespace:
+	free(ll.freespace);
+err_singlefile:
+	single_file_close();
+err_strings:
+	free(opts.mountpoint);
+	free(ll.device);
+err_args:
+	fuse_opt_free_args(&args);
+	return ret ? 1 : 0;
+}
diff --git a/example/meson.build b/example/meson.build
index 24fdcb23cb58f2..6967a2ee370d4b 100644
--- a/example/meson.build
+++ b/example/meson.build
@@ -31,7 +31,7 @@ if platform.endswith('linux')
                    output: 'service_hl.socket',
                    configuration: private_cfg)
 
-    single_file_examples += [ 'iomap_ll', 'iomap_inline_ll' ]
+    single_file_examples += [ 'iomap_ll', 'iomap_inline_ll', 'iomap_ow_ll' ]
 endif
 
 threaded_examples = [ 'notify_inval_inode',
diff --git a/example/single_file.c b/example/single_file.c
index 1d66157a8c637c..c4ac998a2c978b 100644
--- a/example/single_file.c
+++ b/example/single_file.c
@@ -382,7 +382,10 @@ static void single_file_statfs(struct statvfs *buf)
 	buf->f_bsize = single_file.blocksize;
 	buf->f_frsize = 0;
 
-	buf->f_blocks = single_file.blocks;
+	if (single_file_ops && single_file_ops->calc_blocks)
+		buf->f_blocks = single_file_ops->calc_blocks();
+	else
+		buf->f_blocks = single_file.blocks;
 	if (single_file_ops && single_file_ops->calc_bfree)
 		buf->f_bfree = single_file_ops->calc_bfree();
 	else

