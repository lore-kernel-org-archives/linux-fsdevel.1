Received: from smtpbg151.qq.com (smtpbg151.qq.com [18.169.211.239])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 006D73E3D80;
	Mon, 14 Sep 2026 07:56:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.169.211.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789372596; cv=none; b=YPNnWlO40hXhceuoc11HrmKXwxZ6SHnU+7S+ozy7J/Imw1apR3sTgtWJhG2/j//ZXlaYUXH7vaYX+CdlUCS7A2jnEbPDQB7WnSYtO/BFySGHeC16K70KgQ5id7NS29eLIPvfMbQC15jewc1X/FWlpr+H8U5w9lIwQ/s6gYV8XS0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789372596; c=relaxed/simple;
	bh=IT0/M8cz7ElvWA1JrdSV8oaK+GXPYcx4GMvc8fa4M5M=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=q86H34VjwChIcJDgq0Xb2VgQKYnH8L21kVObC1taeoBLJQf7t7n8viURAUkroLvAsY7ocJ6xpDPgyHSzGpjtwKyORDrfOrNrEdXNMml+V1J1JkPvw3lXsMAeOZFFUL3g74GPgy9VDtllmtZWRW8FaApQ0Vbf8jMp8vFa0a2Zh4E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinsec.com.cn; spf=pass smtp.mailfrom=kylinsec.com.cn; arc=none smtp.client-ip=18.169.211.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinsec.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinsec.com.cn
X-QQ-mid: esmtpgz11t1789372559t150a2ba5
X-QQ-Originating-IP: i+XZ1p+6zAcEhLtH11CpK/GhMtVumYa7dWW2GF5WyiA=
Received: from localhost.localdomain ( [175.0.204.93])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Mon, 14 Sep 2026 15:55:56 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 2337740407314765687
EX-QQ-RecipientCnt: 7
From: Yingchao Deng <dengyingchao@kylinsec.com.cn>
To: Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>
Cc: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	qinyungao@kylinsec.com.cn,
	Yingchao Deng <dengyingchao@kylinsec.com.cn>
Subject: [PATCH] fs: fix misleading comments in read_write.c
Date: Mon, 14 Sep 2026 15:53:37 +0800
Message-ID: <918177B3298981ED+20260914075337.1739-1-dengyingchao@kylinsec.com.cn>
X-Mailer: git-send-email 2.45.2.windows.1
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpgz:kylinsec.com.cn:qybglogicsvrgz:qybglogicsvrgz5b-1
X-QQ-XMAILINFO: OEv1vYFDM7rE9+b/oVSlJWP5Ve4qLOet3ApdfEZUFdmcIu3FXBxqln24
	9iIB6B1E9hGfbwTR8MBYF7fgrxGqBP8RIToi+b1g77u6bYT7rRHblftnUeDQKwYWYtZtpmw
	xI+mJZRUb7SC3OU1DES7QLyr151ctHbe76VUXJKRXiLuF2hUnaZw6bKTETKhMEIB/uJzm2O
	EWDSboL6fSmOgHV5kFbYqRQCRA1xWB43Ar84m8rnAPhVtqqsXt19Bgc9aGgebSKohPkS81q
	oaSoGyJ7Idcqws12ZnOpNoobtQxCDb+vfmkRdSLrYBItPcxEZaIknKF+RVKqY9j4h4LUx+9
	sQYBocjTYJXdMqmv0+bKSvhorsVyOJHdf+G59sTT3cemaP0YMTR5QlxMIxYLvHqyrLixg5W
	4YEHSExNUzAE+wKYir9bQgfWrMzRaJQ3qmSEt7/pwPxWiVEIhZIgeF4LPME5JA+wExCL7TL
	nDQR/lmyTUz2ZxejSel/ZMkeEzzsxKWNzJOkef8pfHWmgHsw8lhJtUmWBKyCF41mHyLf6jP
	WNlmsLoUIZwX3GWknz/Yu0S+TW10C6wxJrEuezolGl85GYThO0BTG9cNbwUyCJHP/AGxJ8Q
	kwVSk8kSEJAlWWqksUkIPB0dWYZ8Rxm/vEuNdxa3/FjeYR+zVPhq3a8pz2tyVRkyl2Qyy0L
	ew4b1v95P8j0tFpmwrAK3GTXg4T9awZYJzNOpsSCpAw8Gyt9c+uKyvG04wV6I5K3eyFq8VQ
	DGhWZgD2Y2XBeyyN68S6Bvx7C6vu/uXWMGU01q4UUNmssp3JjotRrDoD5Y6Qqz8A4Xr6sWL
	9ytdhyXxSm4+Dsqg9Y1MqgyKhbAiTIvkmqODK8RKzhYuTlS+Bi/UzMULRWO5tsyT9mJrke1
	/2yLkG9Vb1GBAvhv5QV27+uUf09KfqtGsIU9222dgR4ixsi+3BIrXmemiiZPROFMy2ua7jt
	zw5X/ROp/ZS8jH8lpO98rQpbNwF7/MwXGd/mzOOFazxGANHB+ejnhaFrhUc4jZZK3yT0xTI
	/B5M3UCwlDFP028GJOtHQoLVaHGTJw0cglDv8KJ9E3Abz0wL7b7UDP9uFqTN3yNEeuUYV4i
	kFRxFDjlWqpFfFvj6f2rEYxmMVZF25q3v+YDh0rClEsJ0cE4KBGsiQ=
X-QQ-XMRINFO: Nq+8W0+stu50tPAe92KXseR0ZZmBTk3gLg==
X-QQ-RECHKSPAM: 0

generic_write_checks() returns the number of bytes that may be written
(possibly truncated by generic_write_check_limits()), not zero.  The
comment was likely copied from generic_copy_file_checks(), which is the
analogous function for copy_file_range() and does return 0 on success.

Also, no_seek_end_llseek() and no_seek_end_llseek_size() are helpers for
files that do not support SEEK_END (they only handle SEEK_SET and
SEEK_CUR), not for "fixed-sized devices"; that description was copied
from fixed_size_llseek().

Signed-off-by: Yingchao Deng <dengyingchao@kylinsec.com.cn>
---
 fs/read_write.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/fs/read_write.c b/fs/read_write.c
index e8c14e2760b2..4da846a2bf17 100644
--- a/fs/read_write.c
+++ b/fs/read_write.c
@@ -274,7 +274,7 @@ loff_t fixed_size_llseek(struct file *file, loff_t offset, int whence, loff_t si
 EXPORT_SYMBOL(fixed_size_llseek);
 
 /**
- * no_seek_end_llseek - llseek implementation for fixed-sized devices
+ * no_seek_end_llseek - llseek implementation for files without SEEK_END
  * @file:	file structure to seek on
  * @offset:	file offset to seek to
  * @whence:	type of seek
@@ -293,7 +293,7 @@ loff_t no_seek_end_llseek(struct file *file, loff_t offset, int whence)
 EXPORT_SYMBOL(no_seek_end_llseek);
 
 /**
- * no_seek_end_llseek_size - llseek implementation for fixed-sized devices
+ * no_seek_end_llseek_size - llseek implementation for files without SEEK_END
  * @file:	file structure to seek on
  * @offset:	file offset to seek to
  * @whence:	type of seek
@@ -1761,8 +1761,8 @@ EXPORT_SYMBOL(generic_write_checks_count);
  * Performs necessary checks before doing a write
  *
  * Can adjust writing position or amount of bytes to write.
- * Returns appropriate error code that caller should return or
- * zero in case that write should be allowed.
+ * Returns the number of bytes that may be written on success (which
+ * may be less than requested if truncated), or a negative error code.
  */
 ssize_t generic_write_checks(struct kiocb *iocb, struct iov_iter *from)
 {
-- 
2.33.0

