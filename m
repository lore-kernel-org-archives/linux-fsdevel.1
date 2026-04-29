Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1805930DEB2;
	Wed, 29 Apr 2026 14:47:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777474062; cv=none; b=BuZ7Bzz2E6afyTdOmuymVX+uMMxDpaTjdwGW9yqTj1u/y9BsjAI5yOL+w4zVmpJHBaxb48wBcUeOO1rKlPZmBReTj8CbyGFcGWLt3+j3b9KOCAycL6KV05mTVae6XOjzKkTU1UaKQ7O3bfT9phVSo9Kbmg6oGAhAV3Il8Rd6FxU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777474062; c=relaxed/simple;
	bh=n7nshLE4JYfRiYd09CuVWFj9tPncNSuvyMaaEXTxllg=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GKEUmzrsbi1yq/GVXwGA6jRM3zq4JyDhfDJDsOTL/z3RP6zx5FdhfMw9xyLv1RD2VKU/l3p/YFSsrncv0dIyD5RJZimy3xiX/Fs8RumwjWUGTmklWwlFvwSFnWQDnatdcN4XbhjZaZHYWCRNVTS1P0U336xLuQlB7BApYExFlvc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SVTUoZvW; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SVTUoZvW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 96CA9C2BCB8;
	Wed, 29 Apr 2026 14:47:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777474061;
	bh=n7nshLE4JYfRiYd09CuVWFj9tPncNSuvyMaaEXTxllg=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=SVTUoZvWte5FTJ0UJjx/NtNVChzxofDDzV3WbfFEOpAGAJ7yb9qkdACXI/1s4qSS3
	 XBhIr6FihVJTNUvTPOXKnjc6bW+4t269hHiPduC8gdt0unxioalDSeq8khx6jidXTK
	 FFaLAVGeoUuWxwL4PzCX9gx2ksFLh6LRGOPrrS3QaVyd9j2sEnJyZNbZjeEku5P42E
	 3z2WoQJafsFuylo4WIuckhx1rGyGh5jixQafQdRbRM+azOSD8B4SGvb5dEEQ4X4WQz
	 yxlspE01T8WTN7x1/heondSbVr/XxiT5R8TAFfc75UsVP/ZPnwBUphVDlcraf0B0Ol
	 fEBYxIQ40/J9w==
Date: Wed, 29 Apr 2026 07:47:41 -0700
Subject: [PATCH 2/7] example/iomap_ll: track block state
From: "Darrick J. Wong" <djwong@kernel.org>
To: djwong@kernel.org, bernd@bsbernd.com
Cc: miklos@szeredi.hu, linux-fsdevel@vger.kernel.org, john@groves.net,
 fuse-devel@lists.linux.dev, joannelkoong@gmail.com, neal@gompa.dev
Message-ID: <177747212914.4106066.17052280815938043062.stgit@frogsfrogsfrogs>
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

Track block state so we can do more interesting things with iomap.

Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
---
 example/single_file.h |   11 +
 example/iomap_ll.c    |  419 +++++++++++++++++++++++++++++++++++++++++++++++--
 example/service_hl.c  |    2 
 example/service_ll.c  |    2 
 example/single_file.c |   30 +++-
 5 files changed, 432 insertions(+), 32 deletions(-)


diff --git a/example/single_file.h b/example/single_file.h
index a12389d69e33cc..38e147ee24d331 100644
--- a/example/single_file.h
+++ b/example/single_file.h
@@ -70,6 +70,11 @@ struct single_file {
 
 extern struct single_file single_file;
 
+struct single_file_ops {
+	uint64_t (*calc_st_blocks)(void);
+	uint64_t (*calc_bfree)(void);
+};
+
 static inline uint64_t b_to_fsbt(uint64_t off)
 {
 	return off / single_file.blocksize;
@@ -123,8 +128,10 @@ void single_file_check_read(off_t pos, size_t *count);
 int single_file_check_write(off_t pos, size_t *count);
 
 int single_file_configure(const char *device, mode_t expected_fmt,
-			  const char *filename);
-int single_file_configure_simple(const char *filename);
+			  const char *filename,
+			  const struct single_file_ops *fops);
+int single_file_configure_simple(const char *filename,
+				 const struct single_file_ops *fops);
 void single_file_close(void);
 
 ssize_t single_file_pwrite(const char *buf, size_t count, off_t pos);
diff --git a/example/iomap_ll.c b/example/iomap_ll.c
index 93199b80205c2d..0388400af2efd0 100644
--- a/example/iomap_ll.c
+++ b/example/iomap_ll.c
@@ -45,18 +45,73 @@
 #include <linux/stat.h>
 #define USE_SINGLE_FILE_LL_API
 #include "single_file.h"
+#include <linux/falloc.h>
+
+#define STATE_UNTRACKED		0
+#define STATE_HOLE		'.'
+#define STATE_UNWRITTEN		'U'
+#define STATE_MAPPED		'M'
+#define STATE_DELALLOC		'd'
+
+static uint16_t state_to_iomap_type(char s)
+{
+	switch (s) {
+	case STATE_HOLE:
+		return FUSE_IOMAP_TYPE_HOLE;
+	case STATE_DELALLOC:
+		return FUSE_IOMAP_TYPE_DELALLOC;
+	case STATE_MAPPED:
+		return FUSE_IOMAP_TYPE_MAPPED;
+	case STATE_UNWRITTEN:
+		return FUSE_IOMAP_TYPE_UNWRITTEN;
+	default:
+		/* should never get here */
+		return FUSE_IOMAP_TYPE_INLINE;
+	}
+}
 
 struct iomap_ll {
 	struct fuse_session *se;
 	char *device;
+	uint8_t *state;
 
 	/* really booleans */
 	int debug;
+	int track_state;
 
 	int dev_index;
 };
 
-static struct iomap_ll ll = { };
+static struct iomap_ll ll = {
+	.track_state = STATE_UNTRACKED,
+};
+
+static uint64_t iomap_bytes_allocated(void)
+{
+	uint8_t *p;
+	uint64_t i;
+	uint64_t blocks = 0;
+
+	if (ll.track_state == STATE_UNTRACKED)
+		return single_file.isize;
+
+	for (i = 0, p = ll.state; i < single_file.blocks; i++, p++)
+		if (*p != STATE_HOLE)
+			blocks++;
+
+	return fsb_to_b(blocks);
+}
+
+
+static uint64_t iomap_ll_calc_stblocks(void)
+{
+	return howmany(iomap_bytes_allocated(), 512);
+}
+
+static uint64_t iomap_ll_calc_bfree(void)
+{
+	return single_file.blocks - b_to_fsb(iomap_bytes_allocated());
+}
 
 static void iomap_ll_init(void *userdata, struct fuse_conn_info *conn)
 {
@@ -113,31 +168,132 @@ static void iomap_ll_iomap_config(fuse_req_t req,
 		fuse_reply_iomap_config(req, &cfg);
 }
 
-static int iomap_begin_report(off_t pos, uint64_t count, uint32_t opflags,
-			      struct fuse_file_iomap *read)
+static ssize_t adjust_endoff(uint64_t fileoff, uint64_t *endoff)
 {
-	(void)pos;
-	(void)count;
+	if (fileoff >= single_file.blocks)
+		return -EIO;
+	if (*endoff > single_file.blocks)
+		*endoff = single_file.blocks;
+	return 0;
+}
+
+static ssize_t iomap_begin_report(off_t pos, uint64_t count, uint32_t opflags,
+				  struct fuse_file_iomap *read)
+{
+	uint64_t fileoff, endoff;
+	uint8_t *p;
+	uint8_t orig_state;
+	ssize_t ret;
+
 	(void)opflags;
 
-	read->offset = 0;
-	read->length = fsb_to_b(single_file.blocks);
-	read->addr = 0;
-	read->dev = ll.dev_index;
-	read->type = FUSE_IOMAP_TYPE_MAPPED;
+	if (ll.track_state == STATE_UNTRACKED) {
+		read->offset = 0;
+		read->length = fsb_to_b(single_file.blocks);
+		read->addr = 0;
+		read->dev = ll.dev_index;
+		read->type = FUSE_IOMAP_TYPE_MAPPED;
+		return 0;
+	}
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
+	read->length = 0;
+	orig_state = ll.state[fileoff];
+	read->type = state_to_iomap_type(orig_state);
+	switch (read->type) {
+	case FUSE_IOMAP_TYPE_MAPPED:
+	case FUSE_IOMAP_TYPE_UNWRITTEN:
+		read->dev = ll.dev_index;
+		read->addr = fsb_to_b(fileoff);
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
+	for (p = ll.state + fileoff; fileoff < endoff; p++, fileoff++) {
+		if (*p != orig_state)
+			break;
+		read->length++;
+	}
+	read->length = fsb_to_b(read->length);
 
 	return 0;
 }
 
-static int iomap_begin_read(off_t pos, uint64_t count, uint32_t opflags,
-			    struct fuse_file_iomap *read)
+static ssize_t iomap_begin_read(off_t pos, uint64_t count, uint32_t opflags,
+				struct fuse_file_iomap *read)
 {
 	return iomap_begin_report(pos, count, opflags, read);
 }
 
-static int iomap_begin_write(off_t pos, uint64_t count, uint32_t opflags,
-			     struct fuse_file_iomap *read)
+static ssize_t iomap_write_allocate(off_t pos, uint64_t count, uint32_t opflags)
 {
+	uint64_t fileoff, endoff;
+	uint8_t *p;
+	const bool direct = opflags & (FUSE_IOMAP_OP_DIRECT |
+				       FUSE_IOMAP_OP_WRITEBACK);
+	ssize_t ret;
+
+	if (ll.track_state == STATE_UNTRACKED)
+		return 0;
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
+	for (p = ll.state + fileoff; fileoff < endoff; p++, fileoff++) {
+		if (direct && *p != STATE_MAPPED)
+			*p = STATE_UNWRITTEN;
+		else if (!direct && *p == STATE_HOLE)
+			*p = STATE_DELALLOC;
+	}
+
+	return 0;
+}
+
+static ssize_t iomap_begin_write(off_t pos, uint64_t count, uint32_t opflags,
+				 struct fuse_file_iomap *read)
+{
+	ssize_t ret;
+
+	ret = iomap_write_allocate(pos, count, opflags);
+	if (ret)
+		return ret;
+
 	return iomap_begin_read(pos, count, opflags, read);
 }
 
@@ -146,7 +302,8 @@ static void iomap_ll_iomap_begin(fuse_req_t req, fuse_ino_t ino,
 				 uint32_t opflags)
 {
 	struct fuse_file_iomap read;
-	int ret;
+	ssize_t got;
+	int ret = 0;
 
 	(void)dontcare;
 
@@ -171,13 +328,15 @@ static void iomap_ll_iomap_begin(fuse_req_t req, fuse_ino_t ino,
 
 	pthread_mutex_lock(&single_file.lock);
 	if (opflags & FUSE_IOMAP_OP_REPORT)
-		ret = iomap_begin_report(pos, count, opflags, &read);
+		got = iomap_begin_report(pos, count, opflags, &read);
 	else if (fuse_iomap_is_write(opflags))
-		ret = iomap_begin_write(pos, count, opflags, &read);
+		got = iomap_begin_write(pos, count, opflags, &read);
 	else
-		ret = iomap_begin_read(pos, count, opflags, &read);
-	if (ret)
+		got = iomap_begin_read(pos, count, opflags, &read);
+	if (got < 0) {
+		ret = -got;
 		goto out_unlock;
+	}
 
 	if (ll.debug)
 		fprintf(stderr,
@@ -207,6 +366,181 @@ static void iomap_ll_iomap_begin(fuse_req_t req, fuse_ino_t ino,
 		fuse_reply_iomap_begin(req, &read, NULL);
 }
 
+static void iomap_ll_iomap_end(fuse_req_t req, fuse_ino_t ino,
+			       uint64_t dontcare, off_t pos, uint64_t count,
+			       uint32_t opflags, ssize_t written,
+			       const struct fuse_file_iomap *iomap)
+{
+	uint64_t fileoff, endoff;
+	uint8_t *p;
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
+	if (ll.track_state == STATE_UNTRACKED || written >= 0)
+		goto out_reply;
+
+	/* punch delalloc mappings due to error */
+	pthread_mutex_unlock(&single_file.lock);
+	fileoff = b_to_fsbt(pos);
+	endoff = b_to_fsb(pos + count);
+
+	got = adjust_endoff(fileoff, &endoff);
+	if (got < 0) {
+		ret = -got;
+		goto out_unlock;
+	}
+
+	for (p = ll.state + fileoff; fileoff < endoff; p++, fileoff++) {
+		if (*p == STATE_DELALLOC)
+			*p = STATE_HOLE;
+	}
+
+out_unlock:
+	pthread_mutex_unlock(&single_file.lock);
+out_reply:
+	fuse_reply_err(req, ret);
+}
+
+static void iomap_ll_iomap_ioend(fuse_req_t req, fuse_ino_t ino,
+				 uint64_t dontcare, off_t pos, size_t written,
+				 uint32_t ioendflags, int error, uint32_t dev,
+				 uint64_t new_addr)
+{
+	uint64_t fileoff, endoff;
+	uint8_t *p;
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
+	if (ll.track_state == STATE_UNTRACKED)
+		goto out_reply;
+	if (!(ioendflags & FUSE_IOMAP_IOEND_UNWRITTEN))
+		goto out_reply;
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
+	for (p = ll.state + fileoff; fileoff < endoff; p++, fileoff++) {
+		if (*p == STATE_UNWRITTEN)
+			*p = STATE_MAPPED;
+	}
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
+static void iomap_ll_fallocate(fuse_req_t req, fuse_ino_t ino, int mode,
+			       off_t pos, off_t count,
+			       struct fuse_file_info *fp)
+{
+	uint64_t fileoff, endoff;
+	uint8_t old_state, new_state;
+	uint8_t *p;
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
+	if (ll.track_state == STATE_UNTRACKED) {
+		if (mode & (FALLOC_FL_ZERO_RANGE | FALLOC_FL_PUNCH_HOLE))
+			ret = EOPNOTSUPP;
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
+	if (mode & FALLOC_FL_ZERO_RANGE) {
+		old_state = STATE_UNTRACKED;
+		new_state = STATE_UNWRITTEN;
+	} else if (mode & FALLOC_FL_PUNCH_HOLE) {
+		old_state = STATE_UNTRACKED;
+		new_state = STATE_HOLE;
+	} else {
+		old_state = STATE_HOLE;
+		new_state = STATE_UNWRITTEN;
+	}
+
+	for (p = ll.state + fileoff; fileoff < endoff; p++, fileoff++) {
+		if (old_state == STATE_UNTRACKED || *p == old_state)
+			*p = new_state;
+	}
+
+out_unlock:
+	pthread_mutex_unlock(&single_file.lock);
+out_reply:
+	fuse_reply_err(req, ret);
+}
+
 static const struct fuse_lowlevel_ops iomap_ll_oper = {
 	.lookup		= single_file_ll_lookup,
 	.getattr	= single_file_ll_getattr,
@@ -220,6 +554,13 @@ static const struct fuse_lowlevel_ops iomap_ll_oper = {
 	.init		= iomap_ll_init,
 	.iomap_config	= iomap_ll_iomap_config,
 	.iomap_begin	= iomap_ll_iomap_begin,
+	.iomap_end	= iomap_ll_iomap_end,
+	.iomap_ioend	= iomap_ll_iomap_ioend,
+	.fallocate	= iomap_ll_fallocate,
+};
+
+enum {
+	IOMAP_LL_INITSTATE = SINGLE_FILE_NR_KEYS,
 };
 
 #define IOMAP_LL_OPT(t, p, v) { t, offsetof(struct iomap_ll, p), v }
@@ -227,6 +568,7 @@ static const struct fuse_lowlevel_ops iomap_ll_oper = {
 static struct fuse_opt iomap_ll_opts[] = {
 	IOMAP_LL_OPT("debug",		debug,			1),
 	SINGLE_FILE_OPT_KEYS,
+	FUSE_OPT_KEY("init_state=%s",	IOMAP_LL_INITSTATE),
 	FUSE_OPT_END
 };
 
@@ -243,11 +585,32 @@ static int iomap_ll_opt_proc(void *data, const char *arg,
 			return 0;
 		}
 		return 1;
+	case IOMAP_LL_INITSTATE:
+		if (!strcmp(arg + 11, "alwaysmapped"))
+			ll.track_state = STATE_UNTRACKED;
+		else if (!strcmp(arg + 11, "hole"))
+			ll.track_state = STATE_HOLE;
+		else if (!strcmp(arg + 11, "unwritten"))
+			ll.track_state = STATE_UNWRITTEN;
+		else if (!strcmp(arg + 11, "mapped"))
+			ll.track_state = STATE_MAPPED;
+		else {
+			fprintf(stderr, "%s: initial state not recognized\n", arg);
+			return -1;
+		}
+
+		/* do not pass through to libfuse */
+		return 0;
 	}
 
 	return 1;
 }
 
+static const struct single_file_ops fops = {
+	.calc_st_blocks		= iomap_ll_calc_stblocks,
+	.calc_bfree		= iomap_ll_calc_bfree,
+};
+
 int main(int argc, char *argv[])
 {
 	struct fuse_args args = FUSE_ARGS_INIT(argc, argv);
@@ -282,13 +645,25 @@ int main(int argc, char *argv[])
 	if (single_file_open(ll.device))
 		goto err_strings;
 
-	if (single_file_configure(ll.device, S_IFBLK, "bdev"))
+	if (single_file_configure(ll.device, S_IFBLK, "bdev", &fops))
 		goto err_singlefile;
 
+	if (ll.track_state != STATE_UNTRACKED) {
+		ll.state = malloc(single_file.blocks + 1);
+		if (!ll.state) {
+			perror(ll.device);
+			goto err_singlefile;
+		}
+		memset(ll.state, ll.track_state, single_file.blocks);
+
+		/* make this a nice asciiz string */
+		ll.state[single_file.blocks] = 0;
+	}
+
 	ll.se = fuse_session_new(&args, &iomap_ll_oper, sizeof(iomap_ll_oper),
 				 NULL);
 	if (ll.se == NULL)
-		goto err_singlefile;
+		goto err_state;
 
 	if (fuse_set_signal_handlers(ll.se))
 		goto err_session;
@@ -321,6 +696,8 @@ int main(int argc, char *argv[])
 	fuse_remove_signal_handlers(ll.se);
 err_session:
 	fuse_session_destroy(ll.se);
+err_state:
+	free(ll.state);
 err_singlefile:
 	single_file_close();
 err_strings:
diff --git a/example/service_hl.c b/example/service_hl.c
index b270315e63e297..db92dbb9b611b3 100644
--- a/example/service_hl.c
+++ b/example/service_hl.c
@@ -221,7 +221,7 @@ int main(int argc, char *argv[])
 	if (fuse_service_finish_file_requests(hl.service))
 		goto err_singlefile;
 
-	if (single_file_configure(hl.device, 0, NULL))
+	if (single_file_configure(hl.device, 0, NULL, NULL))
 		goto err_singlefile;
 
 	fuse_service_expect_mount_format(hl.service, S_IFDIR);
diff --git a/example/service_ll.c b/example/service_ll.c
index f09e211ce6c393..eb3d77c639f705 100644
--- a/example/service_ll.c
+++ b/example/service_ll.c
@@ -274,7 +274,7 @@ int main(int argc, char *argv[])
 	if (fuse_service_finish_file_requests(ll.service))
 		goto err_singlefile;
 
-	if (single_file_configure(ll.device, 0, NULL))
+	if (single_file_configure(ll.device, 0, NULL, NULL))
 		goto err_singlefile;
 
 	ll.se = fuse_session_new(&args, &service_ll_oper,
diff --git a/example/single_file.c b/example/single_file.c
index d4db4e90593cc7..5af17e539c566c 100644
--- a/example/single_file.c
+++ b/example/single_file.c
@@ -58,6 +58,8 @@ static const char *single_file_name = "single_file";
 static bool single_file_name_set;
 static struct timespec startup_time;
 
+static const struct single_file_ops *single_file_ops;
+
 struct single_file single_file = {
 	.backing_fd = -1,
 	.allow_dio = true,
@@ -198,7 +200,10 @@ static bool sf_stat(fuse_ino_t ino, struct single_file_stat *llstat)
 		stbuf->st_nlink = 1;
 		stbuf->st_size = single_file.isize;
 		stbuf->st_blksize = single_file.blocksize;
-		stbuf->st_blocks = howmany(single_file.isize, 512);
+		if (single_file_ops && single_file_ops->calc_st_blocks)
+			stbuf->st_blocks = single_file_ops->calc_st_blocks();
+		else
+			stbuf->st_blocks = howmany(single_file.isize, 512);
 		stbuf->st_atim = single_file.atime;
 		stbuf->st_mtim = single_file.mtime;
 		stbuf->st_ctim = single_file.ctime;
@@ -271,7 +276,10 @@ static bool sf_statx(fuse_ino_t ino, int statx_mask, struct statx *stx)
 		stx->stx_nlink = 1;
 		stx->stx_size = single_file.isize;
 		stx->stx_blksize = single_file.blocksize;
-		stx->stx_blocks = howmany(single_file.isize, 512);
+		if (single_file_ops && single_file_ops->calc_st_blocks)
+			stx->stx_blocks = single_file_ops->calc_st_blocks();
+		else
+			stx->stx_blocks = howmany(single_file.isize, 512);
 		stx->stx_atime.tv_sec = single_file.atime.tv_sec;
 		stx->stx_atime.tv_nsec = single_file.atime.tv_nsec;
 		stx->stx_mtime.tv_sec = single_file.mtime.tv_sec;
@@ -362,8 +370,11 @@ static void single_file_statfs(struct statvfs *buf)
 	buf->f_frsize = 0;
 
 	buf->f_blocks = single_file.blocks;
-	buf->f_bfree = 0;
-	buf->f_bavail = 0;
+	if (single_file_ops && single_file_ops->calc_bfree)
+		buf->f_bfree = single_file_ops->calc_bfree();
+	else
+		buf->f_bfree = 0;
+	buf->f_bavail = buf->f_bfree;
 	buf->f_files = 1;
 	buf->f_ffree = 0;
 	buf->f_favail = 0;
@@ -948,7 +959,8 @@ static int check_fmt(mode_t expected_fmt, const struct stat *stbuf,
 }
 
 int single_file_configure(const char *device, mode_t expected_fmt,
-			  const char *filename)
+			  const char *filename,
+			  const struct single_file_ops *fops)
 {
 	struct stat stbuf;
 	unsigned long long backing_size;
@@ -1048,10 +1060,11 @@ int single_file_configure(const char *device, mode_t expected_fmt,
 	single_file.isize = round_down(single_file.isize, single_file.blocksize);
 	single_file.blocks = single_file.isize / single_file.blocksize;
 
-	return single_file_configure_simple(filename);
+	return single_file_configure_simple(filename, fops);
 }
 
-int single_file_configure_simple(const char *filename)
+int single_file_configure_simple(const char *filename,
+				 const struct single_file_ops *fops)
 {
 	if (!single_file.blocksize)
 		single_file.blocksize = sysconf(_SC_PAGESIZE);
@@ -1078,6 +1091,7 @@ int single_file_configure_simple(const char *filename)
 	if (!single_file.ro)
 		single_file.mode |= 0220;
 
+	single_file_ops = fops;
 	return 0;
 }
 
@@ -1092,4 +1106,6 @@ void single_file_close(void)
 	if (single_file_name_set)
 		free((void *)single_file_name);
 	single_file_name_set = false;
+
+	single_file_ops = NULL;
 }

