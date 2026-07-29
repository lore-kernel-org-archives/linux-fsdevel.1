Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C7363AFD16;
	Wed, 29 Jul 2026 11:00:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785322856; cv=none; b=eCBq+uhHKDwR18evt/wsxiqar+hKE7wCGhJwrnEQ3XuwlW30VabCJ1M34DWtWvjxb4/i59MawsFlMZMqPGcQdClQWLTyEgY2HQbOUyWZqLHH/kBUbx95fRjazEN2Sjv11hDzAOozDjCc70eKfAfOs8CJvhg2bMTL7HUmB+wIdXY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785322856; c=relaxed/simple;
	bh=VLpW/dEvcKVkDmiT9lml/cSTo9kBycKoE43pnQSAfB4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=s0HidyBbAvTrQianlBwhXL2DJXqzmhWl7LxvjltdKtYyTCvNB3Z5DkSh+QfH4D2EbT7fR2b6ToZcgAoqks3AHDS5/ezeWHm2zJ9qmS28KvwFOOLmq/s36wEywDlvhKiHtvgUsJdK/xfi8z3c6tfCIjbqUZYwQLoeWk4KIAjT1u8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IR22DZl3; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IR22DZl3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D13471F000E9;
	Wed, 29 Jul 2026 11:00:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785322854;
	bh=CZkGzeTOvoWZrqaOctW06bUz6tq0Op+/YqR+st3a2lI=;
	h=From:To:Cc:Subject:Date;
	b=IR22DZl3JcD5M/gdl6LuxGrSvm9tvX6689LPEsjRYu5mzcKdmJtlePATxjRv6NwTY
	 mTpRuOiDusQHmQmPAkOo5qxNeGFG6rau1T2WOxn+OF8tGiRUp4v7pohtMkawlRbmaL
	 4ZoSO2nwR7PXhWc/DjQuz9vfS47uS+QbsxgY1JGuv3JbFA0SzZDklxWJ7gmk2INI2d
	 X8ar7mQ1JJLgp9IxE9/biRNZTR8f8RifRJr3Cxm2Q8CvXhKYqMbadt3fUbh71EGBT+
	 RkffwYn3MM8npMCuyXeMRELuhlrrwEnzb4rTscqLdfyY11nlOVO2LfThYMODOndfQZ
	 0nYybMTttM3ew==
From: Namjae Jeon <linkinjeon@kernel.org>
To: hyc.lee@gmail.com
Cc: ntfs@lists.linux.dev,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	sebastian.n.feld@gmail.com,
	cedric.blancher@gmail.com,
	Lionelcons1972@gmail.com,
	Namjae Jeon <linkinjeon@kernel.org>
Subject: [PATCH 1/1] ntfs: add ioctl support for named data streams
Date: Wed, 29 Jul 2026 20:00:36 +0900
Message-Id: <20260729110036.12129-1-linkinjeon@kernel.org>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Sebastian and Cedric requested NTFS driver support for an interface that
WINE can use to access named data streams.

NTFS supports multiple named $DATA attributes, commonly known as alternate
data streams, but they are not directly accessible through the existing
file operations. Add NTFS-specific ioctl commands to let userspace list,
read, write, and remove named data streams on an opened file.

The new UAPI provides separate commands for each operation:

  - NTFS_IOC_STREAM_READ
  - NTFS_IOC_STREAM_WRITE
  - NTFS_IOC_STREAM_REMOVE
  - NTFS_IOC_LIST_STREAMS

The read and write commands use an offset and length based request format.
Writes create the named stream when it does not already exist. The list
command returns variable-length stream entries containing stream size,
allocated size, and stream name.

Stream names use the mounted filesystem NLS by default, or raw UTF-16LE
when the UTF-16 flag is requested. Read and write transfers are limited to
16 MiB per request. If the list buffer is too small, the list command
returns -ENOSPC while reporting the required size and stream count.

Signed-off-by: Namjae Jeon <linkinjeon@kernel.org>
---
 .../userspace-api/ioctl/ioctl-number.rst      |   1 +
 fs/ntfs/file.c                                | 509 ++++++++++++++++++
 include/uapi/linux/ntfs.h                     | 115 ++++
 3 files changed, 625 insertions(+)
 create mode 100644 include/uapi/linux/ntfs.h

diff --git a/Documentation/userspace-api/ioctl/ioctl-number.rst b/Documentation/userspace-api/ioctl/ioctl-number.rst
index 3f0ef1e27eb0..2b9869aeb811 100644
--- a/Documentation/userspace-api/ioctl/ioctl-number.rst
+++ b/Documentation/userspace-api/ioctl/ioctl-number.rst
@@ -399,6 +399,7 @@ Code  Seq#    Include File                                             Comments
 0xE5  00-3F  linux/fuse.h
 0xEC  00-01  drivers/platform/chrome/cros_ec_dev.h                     ChromeOS EC driver
 0xEE  00-09  uapi/linux/pfrut.h                                        Platform Firmware Runtime Update and Telemetry
+0xEF  00-0F  uapi/linux/ntfs.h                                         NTFS
 0xF3  00-3F  drivers/usb/misc/sisusbvga/sisusb.h                       sisfb (in development)
                                                                        <mailto:thomas@winischhofer.net>
 0xF6  all                                                              LTTng Linux Trace Toolkit Next Generation
diff --git a/fs/ntfs/file.c b/fs/ntfs/file.c
index d4282822b3ce..961b94f545f2 100644
--- a/fs/ntfs/file.c
+++ b/fs/ntfs/file.c
@@ -15,6 +15,8 @@
 #include <linux/posix_acl_xattr.h>
 #include <linux/compat.h>
 #include <linux/falloc.h>
+#include <linux/overflow.h>
+#include <uapi/linux/ntfs.h>
 
 #include "lcnalloc.h"
 #include "ntfs.h"
@@ -23,6 +25,7 @@
 #include "iomap.h"
 #include "bitmap.h"
 #include "volume.h"
+#include "mft.h"
 
 #include <linux/filelock.h>
 
@@ -839,6 +842,504 @@ static int ntfs_ioctl_fitrim(struct ntfs_volume *vol, unsigned long arg)
 	return 0;
 }
 
+#define NTFS_STREAM_MAX_IO	(16 * 1024 * 1024) /* 16MB limit */
+
+/*
+ * ntfs_read_named_stream - Read data from a named $DATA stream.
+ *
+ * @ni:		NTFS inode
+ * @uname:	Stream name
+ * @uname_len:	Length of name in Unicode characters
+ * @offset:	Byte offset in the stream
+ * @len:	Number of bytes to read
+ * @data_buf:	Buffer to copy data to
+ *
+ * Return:	0 on success, negative error code otherwise.
+ *		If offset >= stream size, returns 0.
+ */
+static int ntfs_read_named_stream(struct ntfs_inode *ni, __le16 *uname,
+		u32 uname_len, u64 offset, u64 len, void *data_buf,
+		u64 *rbytes)
+{
+	struct ntfs_attr_search_ctx *ctx;
+	struct inode *attr_vi;
+	int err = 0;
+	u64 data_size;
+	s64 bytes;
+	char *rbuf = NULL;
+
+	if (!ni || !uname || uname_len == 0)
+		return -EINVAL;
+
+	if (len == 0 || len > NTFS_STREAM_MAX_IO)
+		return -EINVAL;
+
+	mutex_lock(&ni->mrec_lock);
+	ctx = ntfs_attr_get_search_ctx(ni, NULL);
+	if (!ctx) {
+		mutex_unlock(&ni->mrec_lock);
+		return -ENOMEM;
+	}
+
+	err = ntfs_attr_lookup(AT_DATA, uname, uname_len, CASE_SENSITIVE, 0,
+			NULL, 0, ctx);
+	if (err)
+		goto out_lock;
+
+	if (ctx->attr->non_resident)
+		data_size = le64_to_cpu(ctx->attr->data.non_resident.data_size);
+	else
+		data_size = le32_to_cpu(ctx->attr->data.resident.value_length);
+
+	if (offset >= data_size) {
+		*rbytes = 0;
+		/* EOF: nothing to read */
+		goto out_lock;
+	}
+
+	/* Adjust length to not read beyond EOF */
+	if (len > data_size - offset)
+		len = data_size - offset;
+
+	attr_vi = ntfs_attr_iget(VFS_I(ni), AT_DATA, uname, uname_len);
+	ntfs_attr_put_search_ctx(ctx);
+	mutex_unlock(&ni->mrec_lock);
+
+	if (IS_ERR(attr_vi)) {
+		err = PTR_ERR(attr_vi);
+		goto out_free;
+	}
+
+	rbuf = kvzalloc(len, GFP_NOFS);
+	if (!rbuf) {
+		err = -ENOMEM;
+		iput(attr_vi);
+		goto out_free;
+	}
+
+	bytes = ntfs_inode_attr_pread(attr_vi, offset, len, rbuf);
+	iput(attr_vi);
+	if (bytes < 0) {
+		err = bytes;
+		goto out_free;
+	}
+
+	*rbytes = bytes;
+	memcpy(data_buf, rbuf, bytes);
+
+out_free:
+	kvfree(rbuf);
+	return err;
+
+out_lock:
+	ntfs_attr_put_search_ctx(ctx);
+	mutex_unlock(&ni->mrec_lock);
+	return err;
+}
+
+/*
+ * ntfs_write_named_stream - Write data from a named $DATA stream.
+ *
+ * @ni:		NTFS inode
+ * @uname:	Stream name
+ * @uname_len:	Length of name in Unicode characters
+ * @offset:	Byte offset in the stream
+ * @len:	Number of bytes to write
+ * @data_stream: Data to write
+ *
+ * Return:	0 on success, negative error code otherwise.
+ */
+static int ntfs_write_named_stream(struct ntfs_inode *ni, __le16 *uname,
+		u32 uname_len, u64 offset, u64 len, void *data_stream,
+		u64 *wbytes)
+{
+	struct ntfs_attr_search_ctx *ctx;
+	struct inode *attr_vi;
+	int err;
+	s64 bytes;
+
+	if (!ni || !uname || uname_len == 0 || !data_stream)
+		return -EINVAL;
+
+	if (len == 0 || len > NTFS_STREAM_MAX_IO)
+		return -EINVAL;
+
+	mutex_lock(&ni->mrec_lock);
+	ctx = ntfs_attr_get_search_ctx(ni, NULL);
+	if (!ctx) {
+		err = -ENOMEM;
+		goto out_unlock;
+	}
+
+	err = ntfs_attr_lookup(AT_DATA, uname, uname_len, CASE_SENSITIVE, 0,
+			NULL, 0, ctx);
+	if (err) {
+		if (err != -ENOENT)
+			goto out_unlock;
+		err = ntfs_attr_add(ni, AT_DATA, uname, uname_len, NULL, 0);
+		if (err)
+			goto out_unlock;
+		mark_mft_record_dirty(ni);
+	}
+
+	attr_vi = ntfs_attr_iget(VFS_I(ni), AT_DATA, uname, uname_len);
+	ntfs_attr_put_search_ctx(ctx);
+	mutex_unlock(&ni->mrec_lock);
+
+	if (IS_ERR(attr_vi)) {
+		err = PTR_ERR(attr_vi);
+		goto out;
+	}
+
+	bytes = ntfs_inode_attr_pwrite(attr_vi, offset, len, data_stream,
+				       false);
+	if (bytes < 0)
+		err = bytes;
+	else
+		*wbytes = bytes;
+	iput(attr_vi);
+
+out:
+	return err;
+
+out_unlock:
+	if (ctx)
+		ntfs_attr_put_search_ctx(ctx);
+	mutex_unlock(&ni->mrec_lock);
+	return err;
+}
+
+/*
+ * ntfs_remove_named_stream - Remove a named $DATA stream.
+ *
+ * @ni:		NTFS inode
+ * @uname:	Stream name
+ * @uname_len:	Name length in Unicode characters
+ *
+ * Return:	0 on success, negative error
+ *              -ENOENT if stream not found
+ */
+static int ntfs_remove_named_stream(struct ntfs_inode *ni, __le16 *uname,
+		u32 uname_len)
+{
+	if (!ni || !uname || uname_len == 0)
+		return -EINVAL;
+
+	return ntfs_attr_remove(ni, AT_DATA, uname, uname_len);
+}
+
+enum ntfs_stream_op {
+	NTFS_STREAM_OP_READ,
+	NTFS_STREAM_OP_WRITE,
+	NTFS_STREAM_OP_REMOVE,
+};
+
+static long ntfs_ioctl_stream(struct file *filp, unsigned long arg,
+			      enum ntfs_stream_op op)
+{
+	struct inode *inode = file_inode(filp);
+	struct ntfs_inode *ni = NTFS_I(inode);
+	struct ntfs_stream __user *ureq =
+		(struct ntfs_stream __user *)arg;
+	struct ntfs_stream *req;
+	size_t header_size = sizeof(struct ntfs_stream);
+	size_t data_size, total_size;
+	char *kname, *kdata;
+	__le16 *uname = NULL, *sname;
+	int err = 0, sname_len;
+	bool utf16;
+	struct ntfs_stream hdr;
+
+	/* First copy fixed header */
+	if (copy_from_user(&hdr, ureq, header_size))
+		return -EFAULT;
+
+	if (hdr.io_len > NTFS_STREAM_MAX_IO ||
+	    (hdr.flags & ~NTFS_STREAM_FL_UTF16) || hdr.reserved)
+		return -EINVAL;
+
+	utf16 = hdr.flags & NTFS_STREAM_FL_UTF16;
+
+	if (hdr.name_len == 0)
+		return -EINVAL;
+	if (utf16) {
+		/* UTF-16LE byte count: must be even and within the limit. */
+		if ((hdr.name_len & 1) ||
+		    hdr.name_len > NTFS_MAX_NAME_LEN * sizeof(__le16))
+			return -EINVAL;
+	} else if (hdr.name_len > NTFS_MAX_NAME_LEN) {
+		return -EINVAL;
+	}
+
+	switch (op) {
+	case NTFS_STREAM_OP_READ:
+		if (!(filp->f_mode & FMODE_READ) || hdr.io_len == 0)
+			return -EINVAL;
+		data_size = hdr.io_len;
+		break;
+	case NTFS_STREAM_OP_WRITE:
+		if (!(filp->f_mode & FMODE_WRITE) || hdr.io_len == 0)
+			return -EINVAL;
+		data_size = hdr.io_len;
+		break;
+	case NTFS_STREAM_OP_REMOVE:
+		if (!(filp->f_mode & FMODE_WRITE) || hdr.io_len != 0)
+			return -EINVAL;
+		data_size = 0;
+		break;
+	default:
+		return -ENOTTY;
+	}
+
+	if (check_add_overflow(header_size, (size_t)hdr.name_len, &total_size) ||
+	    check_add_overflow(total_size, data_size, &total_size))
+		return -EOVERFLOW;
+
+	req = memdup_user(ureq, total_size);
+	if (IS_ERR(req))
+		return PTR_ERR(req);
+
+	req->bytes_returned = 0;
+
+	kname = (char *)req->buffer;
+	kdata = (char *)req->buffer + req->name_len;
+
+	if (req->name_len != hdr.name_len || req->io_len != hdr.io_len ||
+	    req->flags != hdr.flags || req->reserved) {
+		err = -EINVAL;
+		goto out_free;
+	}
+
+	if (utf16) {
+		/* Name is already on-disk UTF-16LE; use it in place. */
+		sname = (__le16 *)kname;
+		sname_len = req->name_len / sizeof(__le16);
+	} else {
+		if (memchr(kname, '\0', req->name_len)) {
+			err = -EINVAL;
+			goto out_free;
+		}
+		sname_len = ntfs_nlstoucs(ni->vol, kname, req->name_len,
+				&uname, NTFS_MAX_NAME_LEN);
+		if (sname_len < 0) {
+			err = sname_len;
+			goto out_free;
+		}
+		sname = uname;
+	}
+
+	switch (op) {
+	case NTFS_STREAM_OP_READ:
+		err = ntfs_read_named_stream(ni, sname, sname_len,
+					     req->stream_offset, req->io_len,
+					     kdata,
+					     &req->bytes_returned);
+		if (!err) {
+			if (copy_to_user(ureq, req,
+					header_size + req->name_len + req->bytes_returned))
+				err = -EFAULT;
+		}
+		break;
+	case NTFS_STREAM_OP_WRITE:
+		err = mnt_want_write_file(filp);
+		if (err)
+			break;
+		err = ntfs_write_named_stream(ni, sname, sname_len,
+					      req->stream_offset, req->io_len,
+					      kdata,
+					      &req->bytes_returned);
+		mnt_drop_write_file(filp);
+		if (!err) {
+			if (copy_to_user(&ureq->bytes_returned,
+					 &req->bytes_returned,
+					 sizeof(req->bytes_returned)))
+				err = -EFAULT;
+		}
+		break;
+	case NTFS_STREAM_OP_REMOVE:
+		err = mnt_want_write_file(filp);
+		if (err)
+			break;
+		err = ntfs_remove_named_stream(ni, sname, sname_len);
+		mnt_drop_write_file(filp);
+		break;
+	default:
+		err = -ENOTTY;
+	}
+
+out_free:
+	if (uname)
+		kmem_cache_free(ntfs_name_cache, uname);
+	kfree(req);
+	return err;
+}
+
+static int ntfs_ioctl_list_streams(struct file *filp, unsigned long arg)
+{
+	struct inode *inode = file_inode(filp);
+	struct ntfs_inode *ni = NTFS_I(inode);
+	struct ntfs_list_streams hdr;
+	struct ntfs_stream_entry *entry, *last_entry = NULL;
+	size_t required = 0;
+	void *kbuf = NULL;
+	void __user *ubuf;
+	struct attr_record *a;
+	struct ntfs_attr_search_ctx *actx;
+	int ret = 0, err, count = 0;
+	size_t entry_size, offset = 0;
+	unsigned int name_len;
+	unsigned char *sn;
+	bool utf16;
+
+	if (copy_from_user(&hdr, (void __user *)arg, sizeof(hdr)))
+		return -EFAULT;
+
+	if ((hdr.flags & ~NTFS_STREAM_FL_UTF16) || hdr.reserved)
+		return -EINVAL;
+
+	utf16 = hdr.flags & NTFS_STREAM_FL_UTF16;
+
+	ubuf = (void __user *)arg + sizeof(hdr);
+
+	mutex_lock(&ni->mrec_lock);
+	actx = ntfs_attr_get_search_ctx(ni, NULL);
+	if (!actx) {
+		mutex_unlock(&ni->mrec_lock);
+		return -ENOMEM;
+	}
+
+	while ((err = ntfs_attrs_walk(actx)) == 0) {
+		a = actx->attr;
+		if (a->type != AT_DATA || !a->name_length)
+			continue;
+
+		if (utf16) {
+			name_len = a->name_length * sizeof(__le16);
+		} else {
+			sn = ntfs_attr_name_get(ni->vol,
+					(__le16 *)((u8 *)a + le16_to_cpu(a->name_offset)),
+					a->name_length);
+			if (!sn) {
+				ret = -EIO;
+				goto out;
+			}
+			name_len = strlen(sn);
+			ntfs_attr_name_free(&sn);
+		}
+
+		entry_size = sizeof(*entry) + name_len;
+		entry_size = ALIGN(entry_size, 8);
+
+		if (required > SIZE_MAX - entry_size) {
+			ret = -EOVERFLOW;
+			goto out;
+		}
+		required += entry_size;
+		count++;
+	}
+	if (err != -ENOENT) {
+		ret = err;
+		goto out;
+	}
+
+	hdr.stream_count = count;
+	hdr.bytes_returned = required;
+
+	if (!count)
+		goto out;
+
+	if (hdr.buffer_size < required) {
+		ret = -ENOSPC;
+		goto out;
+	}
+
+	kbuf = kvzalloc(required, GFP_NOFS);
+	if (!kbuf) {
+		ret = -ENOMEM;
+		goto out;
+	}
+
+	ntfs_attr_reinit_search_ctx(actx);
+	while ((err = ntfs_attrs_walk(actx)) == 0) {
+		a = actx->attr;
+		if (a->type != AT_DATA || !a->name_length)
+			continue;
+		if (utf16) {
+			sn = NULL;
+			name_len = a->name_length * sizeof(__le16);
+		} else {
+			sn = ntfs_attr_name_get(ni->vol,
+					(__le16 *)((u8 *)a + le16_to_cpu(a->name_offset)),
+					a->name_length);
+			if (!sn) {
+				ret = -EIO;
+				goto out;
+			}
+			name_len = strlen(sn);
+		}
+
+		entry_size = sizeof(*entry) + name_len;
+		entry_size = ALIGN(entry_size, 8);
+		if (offset > required - entry_size) {
+			ret = -EOVERFLOW;
+			ntfs_attr_name_free(&sn);
+			goto out;
+		}
+
+		entry = (struct ntfs_stream_entry *)(kbuf + offset);
+
+		if (a->non_resident) {
+			entry->size = le64_to_cpu(a->data.non_resident.data_size);
+			entry->alloc_size =
+				le64_to_cpu(a->data.non_resident.allocated_size);
+
+		} else {
+			entry->size = le32_to_cpu(a->data.resident.value_length);
+			entry->alloc_size = le32_to_cpu(a->length) -
+				le16_to_cpu(a->data.resident.value_offset);
+		}
+
+		entry->name_len = name_len;
+		if (utf16)
+			memcpy(entry->name,
+			       (u8 *)a + le16_to_cpu(a->name_offset), name_len);
+		else
+			memcpy(entry->name, sn, name_len);
+		ntfs_attr_name_free(&sn);
+
+		entry->next_entry_off = entry_size;
+		last_entry = entry;
+		offset += entry_size;
+	}
+	if (err != -ENOENT) {
+		ret = err;
+	} else {
+		/* The chain terminates at the last entry. */
+		if (last_entry)
+			last_entry->next_entry_off = 0;
+		hdr.bytes_returned = offset;
+	}
+
+out:
+	mutex_unlock(&ni->mrec_lock);
+	ntfs_attr_put_search_ctx(actx);
+
+	if (ret && ret != -ENOSPC)
+		goto out_free;
+
+	if (!ret && kbuf && copy_to_user(ubuf, kbuf, hdr.bytes_returned)) {
+		ret = -EFAULT;
+		goto out_free;
+	}
+
+	if (copy_to_user((void __user *)arg, &hdr, sizeof(hdr)))
+		ret = -EFAULT;
+
+out_free:
+	kvfree(kbuf);
+	return ret;
+}
+
 long ntfs_ioctl(struct file *filp, unsigned int cmd, unsigned long arg)
 {
 	switch (cmd) {
@@ -850,6 +1351,14 @@ long ntfs_ioctl(struct file *filp, unsigned int cmd, unsigned long arg)
 		return ntfs_ioctl_set_volume_label(filp, arg);
 	case FITRIM:
 		return ntfs_ioctl_fitrim(NTFS_SB(file_inode(filp)->i_sb), arg);
+	case NTFS_IOC_STREAM_READ:
+		return ntfs_ioctl_stream(filp, arg, NTFS_STREAM_OP_READ);
+	case NTFS_IOC_STREAM_WRITE:
+		return ntfs_ioctl_stream(filp, arg, NTFS_STREAM_OP_WRITE);
+	case NTFS_IOC_STREAM_REMOVE:
+		return ntfs_ioctl_stream(filp, arg, NTFS_STREAM_OP_REMOVE);
+	case NTFS_IOC_LIST_STREAMS:
+		return ntfs_ioctl_list_streams(filp, arg);
 	default:
 		return -ENOTTY;
 	}
diff --git a/include/uapi/linux/ntfs.h b/include/uapi/linux/ntfs.h
new file mode 100644
index 000000000000..a5783dc3b905
--- /dev/null
+++ b/include/uapi/linux/ntfs.h
@@ -0,0 +1,115 @@
+/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
+/*
+ * Copyright (c) 2026 LG Electronics Co., Ltd.
+ */
+
+#ifndef _UAPI_LINUX_NTFS_H
+#define _UAPI_LINUX_NTFS_H
+#include <linux/types.h>
+#include <linux/ioctl.h>
+
+#define NTFS_IOC_MAGIC	0xEF
+
+/*
+ * Flags for ntfs_stream.flags and ntfs_list_streams.flags.
+ *
+ * The stream name is raw UTF-16LE, exactly as stored on disk, instead of
+ * being encoded with the mounted filesystem NLS. This allows lossless
+ * round-tripping of stream names whose characters are not representable
+ * in the mount NLS (e.g. for Wine, which works in UTF-16 natively).
+ * When set, the name length fields count bytes of UTF-16LE and must
+ * therefore be even.
+ */
+#define NTFS_STREAM_FL_UTF16	0x1
+
+/*
+ * ntfs named stream ioctl structure.
+ *
+ * @stream_offset:	Offset within the named stream.
+ * @io_len:		Number of bytes to read/write.
+ * @bytes_returned:	Actual bytes transferred (out).
+ * @name_len:		Stream name length in bytes, not including any
+ *			terminating NUL (which must not be present). When
+ *			NTFS_STREAM_FL_UTF16 is set this is a UTF-16LE byte
+ *			count and must be even.
+ * @flags:		Bit mask of NTFS_STREAM_FL_* flags. other bits must be
+ *			zero.
+ * @reserved:		Must be zero.
+ * @buffer:		Stream name followed by stream data.
+ *
+ * The stream name is the bare stream name, without the leading ':' or the
+ * trailing ":$DATA" decoration used by Windows. By default it is encoded with
+ * the mounted filesystem NLS. If NTFS_STREAM_FL_UTF16 is set in @flags it is
+ * raw UTF-16LE instead. For read and write, @io_len bytes of data follow the
+ * name. For remove, only the name is required and @io_len must be zero.
+ */
+struct ntfs_stream {
+	__aligned_u64 stream_offset;
+	__aligned_u64 io_len;
+	__aligned_u64 bytes_returned;
+	__u32 name_len;
+	__u32 flags;
+	__aligned_u64 reserved;
+	__u8 buffer[]; /* name + data */
+};
+
+/*
+ * Single stream entry returned by NTFS_IOC_LIST_STREAMS.
+ *
+ * @next_entry_off:	Byte offset from the start of this entry to the next
+ *			entry, or zero for the last entry. Always a multiple
+ *			of 8. Consumers must use this to advance instead of
+ *			computing the stride themselves, so the entry can grow
+ *			new fields without breaking the ABI.
+ * @size:		Stream data size in bytes.
+ * @alloc_size:		Bytes allocated for the stream (cluster aligned for
+ *			non-resident streams).
+ * @name_len:		Stream name length in bytes, not including a NUL
+ *			terminator (none is stored). Counts UTF-16LE bytes
+ *			when NTFS_STREAM_FL_UTF16 was requested.
+ * @reserved:		Must be zero.
+ * @name:		Bare stream name; NLS encoded, or raw UTF-16LE when
+ *			NTFS_STREAM_FL_UTF16 was requested (see struct
+ *			ntfs_stream).
+ */
+struct ntfs_stream_entry {
+	__aligned_u64 next_entry_off;
+	__aligned_u64 size;
+	__aligned_u64 alloc_size;
+	__u32 name_len;
+	__u32 reserved;
+	__u8 name[];
+};
+
+/*
+ * ntfs list streams ioctl structure.
+ *
+ * @buffer_size:	user buffer size(in).
+ * @bytes_returned:	actual bytes written or required(out).
+ * @stream_count:	number of streams(out).
+ * @flags:		Bit mask of NTFS_STREAM_FL_* flags controlling the
+ *			encoding of the returned names; other bits must be zero.
+ * @reserved:		Must be zero.
+ * @buffer:		ntfs_stream_entry array.
+ *
+ * The variable-length entries follow the header in @buffer, each aligned on
+ * an 8-byte boundary and chained via ntfs_stream_entry.next_entry_off. If
+ * @buffer_size is too small, no data is copied, @stream_count and
+ * @bytes_returned report the required values and the ioctl fails with
+ * -ENOSPC.
+ */
+struct ntfs_list_streams {
+	__aligned_u64 buffer_size;
+	__aligned_u64 bytes_returned;
+	__aligned_u64 stream_count;
+	__u32 flags;
+	__u32 reserved;
+	__u8 buffer[];
+};
+
+#define NTFS_IOC_STREAM_READ		_IOWR(NTFS_IOC_MAGIC, 1, struct ntfs_stream)
+#define NTFS_IOC_STREAM_WRITE		_IOWR(NTFS_IOC_MAGIC, 2, struct ntfs_stream)
+#define NTFS_IOC_STREAM_REMOVE		_IOWR(NTFS_IOC_MAGIC, 3, struct ntfs_stream)
+#define NTFS_IOC_LIST_STREAMS		_IOWR(NTFS_IOC_MAGIC, 4, struct ntfs_list_streams)
+
+#endif /* _UAPI_LINUX_NTFS_H */
-- 
2.25.1

