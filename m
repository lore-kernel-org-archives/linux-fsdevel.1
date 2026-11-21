Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.41
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795221249;
	b=seNak/AzrD+0PobrADJnGRnkgpuG7MV5cKUXMrxgghJ7t8nOspNoLUPvpKd4Q2mckG3Y
	 ECitvFu+W/lZjyF4DhrlPA1q2dRRR1Y1Mo5LQ2Kjkn2pgVsLoRv+wwYxkwfwoinK54go6
	 CJtPzoVBelXsxF6fiopwtKFk8HXdyFy/cjwtInTuZdmUlyvaQvGryR1DPvkfTLJJ81yDJ
	 4QuG33TL0tGekT4NfuUjgsH0eTQtIz5+xtgbtdRrxCaEWe135vV3DpzI/gOb52k8kBJ0C
	 kNTSQ5W8bUD9oQ4doxGdgKtpfkAWmkOU67nw9PP/eGoMD/gRQpfQApsxoW15+oiZNtA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795221249;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=+jB7fxNZtqmiW6gtoN61gXB4CDTQflqNtVX+fxWNhT8=;
	b=CWxrWZVOtZu6F02OPNdR3lHwgDVfU38QWYWeyOErcoifffLOToARUO3N8Pae2IDGhnpf
	 NnqYJg2p8ULJWHNwqETK8xAXyP+Z0+k4J7Lg9zCcu0UPWfeH7X6oetALzt1Se/11PyRXe
	 Cbzb678Q5Wrr2WRb8FhF6bC8KSCqRwvjmalZNGlmwRoYGBQDtM7OKHvKC/dqXzNaXqKXP
	 xeOVu/Ck11BdtsIe87fYBaOzGn0l8L93925p0KJZY4VetGjffCmIKr9RsYU9CnCoHNC9g
	 pmA2Zgbw9QwGQN6p6u+phzhPjPjimyTLIho6ttxwPjiw3TnEnfhHdSGjf0h1d+V6lUw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=V8nFTjHa;
	arc=none smtp.remote-ip=209.85.221.41
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 195E6606A69C
	for <linux-fsdevel@vger.kernel.org>; Sat, 21 Nov 2026 00:34:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 195E6606A69C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=V8nFTjHa
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-48e09aa5264so802673f8f.2
        for <linux-fsdevel@vger.kernel.org>; Fri, 20 Nov 2026 16:34:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795221244; x=1795826044; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=+jB7fxNZtqmiW6gtoN61gXB4CDTQflqNtVX+fxWNhT8=;
        b=V8nFTjHa+1oyIqrf4lS7Hnj8Z4xgUvSGPVZzCpv1r8cCCisbqIyf0ag6Za2dHEXvha
         MJ1GnP7GvwXM1wbnDvpbzV6zU3fFZ/8LfHAsyefyRrNHeFUTcM0JbhFDdPjutERm/QOQ
         gb1oVK8FY80SWvFRLx411gMwMPATuOMR5xPqDEiIw7syqBC/eurDuXoxvprudhrlhTdj
         kNS4U5+PCthvDrm9C/XC6xst57KT+aXI43xbLJ2l2aqlEykx3FmDchFhd9j+LPi+M4Oe
         46zDCjB+L/y3rcTuSherNZ7eoyD3dDYJzpBoTS3IjsbRm7jGscFf8sWGrF9Rh1L1g3M1
         ttcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795221244; x=1795826044;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=+jB7fxNZtqmiW6gtoN61gXB4CDTQflqNtVX+fxWNhT8=;
        b=QyiW9QYqsNVYDWO0os3gUlMeMN2TgtdwwiyZ5wqqyIQiX2sLxeJoOvA9K+UgFla/CS
         SpUZOCZmRSyzzLRo+s+5f/39snSyQZF8QmA0Q+9HgylCeJAZRBKEghUXxzw2LyDvMqfO
         HQgQZkSbmQ5OtLeV63q2kf+Sp1FTjFLbWw5npSesn/n6aESh1zhTBaTXhJCdI1rNALmX
         4K4fM9p5wy6Fco+OSmPlZrjR2Mc86D0hIn8ruC+TXQIE3r1uRoBQVHNx+FmQhb4YWYSF
         XNC4cZqSfuaOvRjCl9BINgETC+VhgY0Tz33D7pu7f4uHG5eNHlFiaJ5glI8xBFLLeoYb
         n7wA==
X-Gm-Message-State: APuU4Z/u/jiX7N5DAbEKmxp0PxBMk9siGXsRLJ7BhZMij8qxzHM8F5EP
	Aa3m7CvkXVhZt1UbcfuLCWmzYegnpU77Md0cW3GWb8zlQt9xWJ9PkFW8UfCKeYFo
X-Gm-Gg: AZFdTZec+Ari6GbX5qyaFo150ff3FXA+3LCeoL+Ux4cJ/KLxBNassOlbBt11AFctjDG
	xYkaRVOGCQdPKHitaUe/adMaKLnOWKDEEuSzd53plCzWtv3cdQxsLoASnmN51U7tDU3fHsH0y4k
	9Z0v4BVVRDgJbgO6gUm6CU/TwbQNOPkkh+3bmEbHQz1ZlIP9b65V7+l4LLCJqR3bcGLJEOs2JtJ
	7/D0EO/wuQBOvAyINNhr6RSVXYaJGR6tuZ76n5NkTfwcz3kEdt9v9o9v6nkX/RgPti/PjkHO62Y
	S4Nxf30bTM2EuBbMRDVonksH5vnn42bi4kiq07CqDSaDZOosXPcMls2cdLHKHo9LgJsptoZNqfV
	uw7OW2YCNet1jBCwIc2s+IpY5tux5o8eF+Oq91Ctv/wKzthIzKIfLw4YSVsOOjkO7YDhhs66hk3
	xpTgyH7r5L0RW7f3bkMYj95JrDQuPwIhDQAhJB928/6cjwOkPpWQDMrjCMmchsKYCNWm88/raXj
	aLqlQaamIOELecoPxQnhsdAynq+i1BNoWdH3IzgpjQxRmTPtP5KAFDuBT3WiI6AVNfkLPE6KA+U
	MxmAwN5KO+RjbN7d5hunFYExSiZQ3zaadjhGYx4se13y
X-Received: by 2002:a5d:5f86:0:b0:4ac:f79a:28ab with SMTP id ffacd0b85a97d-4acf79a2aa2mr7241880f8f.8.1795221244092;
        Fri, 20 Nov 2026 16:34:04 -0800 (PST)
Received: from asahi.teknoraver.net ([195.182.211.216])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4ab6a680483sm8528316f8f.28.2026.11.20.16.34.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Nov 2026 16:34:03 -0800 (PST)
From: Matteo Croce <technoboy85@gmail.com>
To: linux-fsdevel@vger.kernel.org,
	Christian Brauner <brauner@kernel.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Ding Feng <dingf3ng@gmail.com>
Cc: Paul Eggert <eggert@cs.ucla.edu>,
	LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH v2] fs: shorten I/O that would extend past the maximum file offset
Date: Sat, 21 Nov 2026 01:33:56 +0100
Message-ID: <20261121003356.290201-1-technoboy85@gmail.com>
X-Mailer: git-send-email 2.56.1
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

rw_verify_area() fails with -EINVAL any read or write where
pos + count would exceed LLONG_MAX, even when pos itself is valid.
Such a request should not fail: a read should return the bytes that
are there up to the maximum offset, or 0 at end of file, and a write
should write what fits and return a short count.

This breaks ordinary programs that read a file up to an end at or near
LLONG_MAX, even with ordinary buffer sizes. For example, dd fails on
the last block, where it should get a short read, and cat fails where
it should get end of file:

  $ truncate -s $((2**63 - 1)) hugefile
  $ dd if=hugefile of=/dev/null bs=1M skip=$((2**43 - 2))
  dd: error reading 'hugefile': Invalid argument
  1+0 records in
  1+0 records out
  1048576 bytes (1,0 MB, 1,0 MiB) copied, 0,103536 s, 10,1 MB/s

  $ (dd bs=1 skip=$((2**63 - 1)) count=0 status=none; cat) < hugefile
  cat: -: Invalid argument

The same happens on a 100-byte file:

  preadv2(fd, 200 bytes, pos = LLONG_MAX - 50) = -1 EINVAL
  preadv2(fd,  50 bytes, pos = LLONG_MAX - 50) = 0

With a large count, the range crosses LLONG_MAX even far from it:
splice() of a 20 MB file with a count of 0x7FFFFFFFFF000000 fails once
the position reaches 16 MB. sendfile(), aio and io_uring fail in the
same way as read() and splice().

Files with FOP_UNSIGNED_OFFSET, such as /dev/mem and /proc/pid/mem,
have the same problem at U64_MAX, their maximum offset: a read or
write that starts below U64_MAX but would end past it fails with
-EOVERFLOW.

Add rw_clamp_count(), which shortens the count so that the range ends
at the maximum offset, LLONG_MAX or U64_MAX for files with
FOP_UNSIGNED_OFFSET, and call it before rw_verify_area() in the read
and write paths of the VFS, splice, aio and io_uring. Where the I/O is
described by an iov_iter, truncate the iterator. This is what
filemap_read() already does for s_maxbytes. In io_uring, also save the
iterator state again after truncating it, so that the short read retry
loop does not restore the full length.

A read that starts at the maximum offset returns 0. A write that starts
there cannot transfer anything and still fails in rw_verify_area(), as
do negative positions on files without FOP_UNSIGNED_OFFSET and counts
above SSIZE_MAX. For files with FOP_UNSIGNED_OFFSET, the file's own
read and write methods still decide how much of the shortened range
they can actually transfer.

rw_verify_area() keeps its check, so callers that are not converted
behave as before. copy_file_range() already clamps the range in
generic_copy_file_checks() and is not changed.

Reported-by: Ding Feng <dingf3ng@gmail.com>
Closes: https://lore.kernel.org/linux-fsdevel/20261120051457.47753-1-dingf3ng@gmail.com/
Suggested-by: Paul Eggert <eggert@cs.ucla.edu>
Link: https://lists.gnu.org/archive/html/coreutils/2025-12/msg00097.html
Link: https://lore.kernel.org/linux-fsdevel/20251219125250.65245-1-teknoraver@meta.com/
Signed-off-by: Matteo Croce <technoboy85@gmail.com>
---
v2:
- Also shorten I/O on files with FOP_UNSIGNED_OFFSET, so that the range
  ends at U64_MAX (Paul Eggert).
- Fix readv() and writev() returning the requested length instead of 0
  when the count is shortened to zero.
- Commit message: fix the cat reproducer, add the splice() case.

v1: https://lore.kernel.org/linux-fsdevel/20261120184225.257554-1-technoboy85@gmail.com/

 fs/aio.c           |  4 ++++
 fs/read_write.c    | 26 ++++++++++++++++++++++++--
 fs/splice.c        |  3 +++
 include/linux/fs.h | 45 +++++++++++++++++++++++++++++++++++++++++++++
 io_uring/rw.c      | 16 ++++++++++++++++
 5 files changed, 92 insertions(+), 2 deletions(-)

diff --git a/fs/aio.c b/fs/aio.c
index d78acc69f487..abd17f75faaa 100644
--- a/fs/aio.c
+++ b/fs/aio.c
@@ -1651,6 +1651,8 @@ static int aio_read(struct kiocb *req, const struct iocb *iocb,
 	ret = aio_setup_rw(ITER_DEST, iocb, &iovec, vectored, compat, &iter);
 	if (ret < 0)
 		return ret;
+	iov_iter_truncate(&iter, rw_clamp_count(READ, file, &req->ki_pos,
+						iov_iter_count(&iter)));
 	ret = rw_verify_area(READ, file, &req->ki_pos, iov_iter_count(&iter));
 	if (!ret)
 		aio_rw_done(req, file->f_op->read_iter(req, &iter));
@@ -1679,6 +1681,8 @@ static int aio_write(struct kiocb *req, const struct iocb *iocb,
 	ret = aio_setup_rw(ITER_SOURCE, iocb, &iovec, vectored, compat, &iter);
 	if (ret < 0)
 		return ret;
+	iov_iter_truncate(&iter, rw_clamp_count(WRITE, file, &req->ki_pos,
+						iov_iter_count(&iter)));
 	ret = rw_verify_area(WRITE, file, &req->ki_pos, iov_iter_count(&iter));
 	if (!ret) {
 		if (S_ISREG(file_inode(file)->i_mode))
diff --git a/fs/read_write.c b/fs/read_write.c
index e8c14e2760b2..03b8b0f351b2 100644
--- a/fs/read_write.c
+++ b/fs/read_write.c
@@ -544,6 +544,7 @@ ssize_t kernel_read(struct file *file, void *buf, size_t count, loff_t *pos)
 {
 	ssize_t ret;
 
+	count = rw_clamp_count(READ, file, pos, count);
 	ret = rw_verify_area(READ, file, pos, count);
 	if (ret)
 		return ret;
@@ -562,6 +563,7 @@ ssize_t vfs_read(struct file *file, char __user *buf, size_t count, loff_t *pos)
 	if (unlikely(!access_ok(buf, count)))
 		return -EFAULT;
 
+	count = rw_clamp_count(READ, file, pos, count);
 	ret = rw_verify_area(READ, file, pos, count);
 	if (ret)
 		return ret;
@@ -653,6 +655,7 @@ ssize_t kernel_write(struct file *file, const void *buf, size_t count,
 {
 	ssize_t ret;
 
+	count = rw_clamp_count(WRITE, file, pos, count);
 	ret = rw_verify_area(WRITE, file, pos, count);
 	if (ret)
 		return ret;
@@ -675,6 +678,7 @@ ssize_t vfs_write(struct file *file, const char __user *buf, size_t count, loff_
 	if (unlikely(!access_ok(buf, count)))
 		return -EFAULT;
 
+	count = rw_clamp_count(WRITE, file, pos, count);
 	ret = rw_verify_area(WRITE, file, pos, count);
 	if (ret)
 		return ret;
@@ -879,6 +883,8 @@ ssize_t vfs_iocb_iter_read(struct file *file, struct kiocb *iocb,
 	if (!(file->f_mode & FMODE_CAN_READ))
 		return -EINVAL;
 
+	iov_iter_truncate(iter, rw_clamp_count(READ, file, &iocb->ki_pos,
+					       iov_iter_count(iter)));
 	tot_len = iov_iter_count(iter);
 	if (!tot_len)
 		goto out;
@@ -907,6 +913,8 @@ ssize_t vfs_iter_read(struct file *file, struct iov_iter *iter, loff_t *ppos,
 	if (!(file->f_mode & FMODE_CAN_READ))
 		return -EINVAL;
 
+	iov_iter_truncate(iter, rw_clamp_count(READ, file, ppos,
+					       iov_iter_count(iter)));
 	tot_len = iov_iter_count(iter);
 	if (!tot_len)
 		goto out;
@@ -939,6 +947,8 @@ ssize_t vfs_iocb_iter_write(struct file *file, struct kiocb *iocb,
 	if (!(file->f_mode & FMODE_CAN_WRITE))
 		return -EINVAL;
 
+	iov_iter_truncate(iter, rw_clamp_count(WRITE, file, &iocb->ki_pos,
+					       iov_iter_count(iter)));
 	tot_len = iov_iter_count(iter);
 	if (!tot_len)
 		return 0;
@@ -970,6 +980,8 @@ ssize_t vfs_iter_write(struct file *file, struct iov_iter *iter, loff_t *ppos,
 	if (!file->f_op->write_iter)
 		return -EINVAL;
 
+	iov_iter_truncate(iter, rw_clamp_count(WRITE, file, ppos,
+					       iov_iter_count(iter)));
 	tot_len = iov_iter_count(iter);
 	if (!tot_len)
 		return 0;
@@ -1007,9 +1019,13 @@ static ssize_t vfs_readv(struct file *file, const struct iovec __user *vec,
 	if (ret < 0)
 		return ret;
 
+	iov_iter_truncate(&iter, rw_clamp_count(READ, file, pos,
+						iov_iter_count(&iter)));
 	tot_len = iov_iter_count(&iter);
-	if (!tot_len)
+	if (!tot_len) {
+		ret = 0;
 		goto out;
+	}
 
 	ret = rw_verify_area(READ, file, pos, tot_len);
 	if (ret < 0)
@@ -1045,9 +1061,13 @@ static ssize_t vfs_writev(struct file *file, const struct iovec __user *vec,
 	if (ret < 0)
 		return ret;
 
+	iov_iter_truncate(&iter, rw_clamp_count(WRITE, file, pos,
+						iov_iter_count(&iter)));
 	tot_len = iov_iter_count(&iter);
-	if (!tot_len)
+	if (!tot_len) {
+		ret = 0;
 		goto out;
+	}
 
 	ret = rw_verify_area(WRITE, file, pos, tot_len);
 	if (ret < 0)
@@ -1325,6 +1345,7 @@ static ssize_t do_sendfile(int out_fd, int in_fd, loff_t *ppos,
 		if (!(fd_file(in)->f_mode & FMODE_PREAD))
 			return -ESPIPE;
 	}
+	count = rw_clamp_count(READ, fd_file(in), &pos, count);
 	retval = rw_verify_area(READ, fd_file(in), &pos, count);
 	if (retval < 0)
 		return retval;
@@ -1365,6 +1386,7 @@ static ssize_t do_sendfile(int out_fd, int in_fd, loff_t *ppos,
 #endif
 	opipe = get_pipe_info(fd_file(out), true);
 	if (!opipe) {
+		count = rw_clamp_count(WRITE, fd_file(out), &out_pos, count);
 		retval = rw_verify_area(WRITE, fd_file(out), &out_pos, count);
 		if (retval < 0)
 			return retval;
diff --git a/fs/splice.c b/fs/splice.c
index 9d8f63e2fd1a..7a889274f9d6 100644
--- a/fs/splice.c
+++ b/fs/splice.c
@@ -1001,6 +1001,7 @@ ssize_t vfs_splice_read(struct file *in, loff_t *ppos,
 {
 	ssize_t ret;
 
+	len = rw_clamp_count(READ, in, ppos, len);
 	ret = rw_verify_area(READ, in, ppos, len);
 	if (unlikely(ret < 0))
 		return ret;
@@ -1338,6 +1339,7 @@ ssize_t do_splice(struct file *in, loff_t *off_in, struct file *out,
 		if (unlikely(out->f_flags & O_APPEND))
 			return -EINVAL;
 
+		len = rw_clamp_count(WRITE, out, &offset, len);
 		ret = rw_verify_area(WRITE, out, &offset, len);
 		if (unlikely(ret < 0))
 			return ret;
@@ -1364,6 +1366,7 @@ ssize_t do_splice(struct file *in, loff_t *off_in, struct file *out,
 			offset = in->f_pos;
 		}
 
+		len = rw_clamp_count(READ, in, &offset, len);
 		ret = rw_verify_area(READ, in, &offset, len);
 		if (unlikely(ret < 0))
 			return ret;
diff --git a/include/linux/fs.h b/include/linux/fs.h
index deb411e86661..708d211d14de 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -3128,6 +3128,51 @@ extern loff_t fixed_size_llseek(struct file *file, loff_t offset,
 extern loff_t no_seek_end_llseek_size(struct file *, loff_t, int, loff_t);
 extern loff_t no_seek_end_llseek(struct file *, loff_t, int);
 int rw_verify_area(int, struct file *, const loff_t *, size_t);
+
+/**
+ * rw_clamp_count - shorten an I/O so it does not extend past the maximum offset
+ * @read_write:	READ or WRITE
+ * @file:	file the I/O is done on
+ * @ppos:	file position of the I/O, or NULL for stream files
+ * @count:	number of bytes requested
+ *
+ * A read or write that starts at a valid file position but would end past
+ * the maximum file offset should transfer the bytes up to that offset and
+ * return a short count, rather than fail.  rw_verify_area() rejects such a
+ * range, so callers clamp @count with this helper before verifying it.
+ *
+ * The maximum offset is LLONG_MAX, or U64_MAX for files with
+ * FOP_UNSIGNED_OFFSET, whose positions are unsigned.
+ *
+ * Out-of-range positions and counts are left alone so that
+ * rw_verify_area() still rejects them.  So is a write starting at the
+ * maximum offset, which cannot transfer anything.  A read starting there
+ * is clamped to zero bytes and reports end of file.
+ *
+ * Return: the possibly shortened count.
+ */
+static inline size_t rw_clamp_count(int read_write, struct file *file,
+				    const loff_t *ppos, size_t count)
+{
+	u64 pos, max = LLONG_MAX;
+
+	if (!ppos || unlikely((ssize_t)count < 0))
+		return count;
+
+	pos = *ppos;
+	if (unlikely(file->f_op->fop_flags & FOP_UNSIGNED_OFFSET))
+		max = U64_MAX;
+	else if (unlikely(*ppos < 0))
+		return count;
+
+	if (likely(count <= max - pos))
+		return count;
+	if (read_write == WRITE && pos == max)
+		return count;
+
+	return max - pos;
+}
+
 extern int generic_file_open(struct inode * inode, struct file * filp);
 extern int nonseekable_open(struct inode * inode, struct file * filp);
 extern int stream_open(struct inode * inode, struct file * filp);
diff --git a/io_uring/rw.c b/io_uring/rw.c
index 432820f86251..6c01290aa2fb 100644
--- a/io_uring/rw.c
+++ b/io_uring/rw.c
@@ -918,6 +918,7 @@ static int __io_read(struct io_kiocb *req, struct io_br_sel *sel,
 	struct io_async_rw *io = req->async_data;
 	struct kiocb *kiocb = &rw->kiocb;
 	ssize_t ret;
+	size_t count;
 	loff_t *ppos;
 
 	if (req->flags & REQ_F_IMPORT_BUFFER) {
@@ -946,6 +947,13 @@ static int __io_read(struct io_kiocb *req, struct io_br_sel *sel,
 
 	ppos = io_kiocb_update_pos(req);
 
+	count = rw_clamp_count(READ, req->file, ppos, req->cqe.res);
+	if (unlikely(count != req->cqe.res)) {
+		iov_iter_truncate(&io->iter, count);
+		iov_iter_save_state(&io->iter, &io->iter_state);
+		req->cqe.res = count;
+	}
+
 	ret = rw_verify_area(READ, req->file, ppos, req->cqe.res);
 	if (unlikely(ret))
 		return ret;
@@ -1134,6 +1142,7 @@ int io_write(struct io_kiocb *req, unsigned int issue_flags)
 	struct io_async_rw *io = req->async_data;
 	struct kiocb *kiocb = &rw->kiocb;
 	ssize_t ret, ret2;
+	size_t count;
 	loff_t *ppos;
 
 	if (req->flags & REQ_F_IMPORT_BUFFER) {
@@ -1166,6 +1175,13 @@ int io_write(struct io_kiocb *req, unsigned int issue_flags)
 
 	ppos = io_kiocb_update_pos(req);
 
+	count = rw_clamp_count(WRITE, req->file, ppos, req->cqe.res);
+	if (unlikely(count != req->cqe.res)) {
+		iov_iter_truncate(&io->iter, count);
+		iov_iter_save_state(&io->iter, &io->iter_state);
+		req->cqe.res = count;
+	}
+
 	ret = rw_verify_area(WRITE, req->file, ppos, req->cqe.res);
 	if (unlikely(ret))
 		return ret;
-- 
2.56.1

