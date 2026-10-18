Received: from outgoing2021.csail.mit.edu (outgoing2021.csail.mit.edu [128.30.2.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEF6C35DA6A;
	Sun, 18 Oct 2026 03:03:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=128.30.2.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792292628; cv=none; b=POIjIT9cbg15C3HCou+viSnQo5NviUgm6N9mVv9EDlvbHfFThXo1UolEcbAPJKpYE5PdHCc0fCzzCFL2+jjHKAf+ZslMR/zevI09dbuhTip2DPhDg1dBKOE1BXoMtLllU15LQQdfj6I64PQ/nc/SCfRqhRg/SUMSpdavlHZYdcY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792292628; c=relaxed/simple;
	bh=gPCk6cz3/UNRaQoaTMI3n3BckGmxOk3Wy+w9bv5KzcY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ck1f32+PwqJHV3lrym0XO4kRT7sK5vbfpV9zdKt7vb/+lyIKVS9hTi+weK7LRk30sKU/tHGrRE6nSdtYMHA5ycR6beL5tmqaxRu3NhPUnV4jF7ZpaWbOU+V9Nprq8gsA99wlCuhEdPOVQF6nPDv9Bo71lHCpn5RhJ1+yQubHJTE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=csail.mit.edu; spf=pass smtp.mailfrom=csail.mit.edu; arc=none smtp.client-ip=128.30.2.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=csail.mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=csail.mit.edu
Received: from escalante.csail.mit.edu ([128.52.128.198])
	by outgoing2021.csail.mit.edu with esmtp (Exim 4.95)
	(envelope-from <nickolai@csail.mit.edu>)
	id 1xIHBW-004T2R-7U;
	Sat, 17 Oct 2026 23:03:42 -0400
From: Nickolai Zeldovich <nickolai@csail.mit.edu>
To: Christian Brauner <brauner@kernel.org>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>,
	Jan Kara <jack@suse.cz>,
	Amir Goldstein <amir73il@gmail.com>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Nickolai Zeldovich <nickolai@csail.mit.edu>
Subject: [PATCH v1] nsfs: check the trailing bytes of a file handle in bytes, not words
Date: Sat, 17 Oct 2026 23:03:41 -0400
Message-ID: <20261018030342.799383-1-nickolai@csail.mit.edu>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

open_by_handle_at(2) gets the wrong answer for a namespace file handle
longer than struct nsfs_file_handle: a 16-byte handle padded with
zeros to 48 bytes or more, which is what the comment above the check
promises to accept, is refused with -ESTALE, while a 20-byte handle
whose extra word is garbage is accepted. Reproduced on v7.0 and on
mainline with the handle of /proc/self/ns/net from
name_to_handle_at(AT_SYMLINK_FOLLOW); no privilege is needed, as
nsfs_fh_to_dentry() admits the caller's own namespaces. Since v6.18.

nsfs_fh_to_dentry() receives fh_len in 32-bit words, like every
fh_to_dentry(), and NSFS_FID_SIZE_U32_LATEST is the struct size in
words (4). The check that the bytes past the struct are zero adds that
word count to a byte pointer and passes the word difference to
memchr_inv() as a byte count: it inspects bytes 4 .. fh_len - 1 of the
handle instead of bytes 16 .. 4 * fh_len - 1. Up to a 44-byte handle
that range lies inside ns_id, ns_type and ns_inum, so the outcome
depends on the values of those fields (a padded net namespace handle
passes because the upper bytes of its ns_id and ns_type are zero) and
the real trailing bytes are never looked at; from 48 bytes on the range
always covers a non-zero field byte and every padded handle is refused.

Start NSFS_FILE_HANDLE_SIZE_LATEST bytes into the handle and check
(fh_len - NSFS_FID_SIZE_U32_LATEST) * sizeof(u32) bytes.

Tested with a program that encodes /proc/self/ns/net and opens the
handle with handle_bytes 16, 20, 36, 48 and 128 (zero padding), and 20
and 48 with a non-zero last byte. Before: 48 and 128 refused, the
20-byte garbage handle accepted; after: every padded handle opens, both
garbage handles are refused.

Fixes: 5222470b2fbb ("nsfs: support file handles")
Assisted-by: LLM
Signed-off-by: Nickolai Zeldovich <nickolai@csail.mit.edu>
---

Notes:
    The arithmetic keeps the two existing constants: NSFS_FILE_HANDLE_SIZE_LATEST
    is the struct size in bytes, NSFS_FID_SIZE_U32_LATEST the same in words, and
    fh_len is in words as exportfs passes it (handle_bytes >> 2). pidfs has no
    trailing-bytes check, so nothing else uses this pattern.
    
    Reproducer (any kernel >= 6.18 with CONFIG_FHANDLE, no privilege):
    
    #define _GNU_SOURCE
    #include <errno.h>
    #include <fcntl.h>
    #include <stdio.h>
    #include <string.h>
    #include <unistd.h>
    
    #define MAX_HANDLE_SZ 128
    
    static int fails;
    
    static void try(int mntfd, struct file_handle *fh, unsigned int bytes,
    		unsigned int poison_at, int expect_ok, const char *what)
    {
    	int fd;
    
    	memset(fh->f_handle + 16, 0, MAX_HANDLE_SZ - 16);
    	if (poison_at)
    		fh->f_handle[poison_at] = 0xff;
    	fh->handle_bytes = bytes;
    	fd = open_by_handle_at(mntfd, fh, O_RDONLY);
    	if ((fd >= 0) != expect_ok)
    		fails++;
    	printf("%s handle_bytes=%u %s -> %s\n", (fd >= 0) == expect_ok ? "ok  " : "FAIL",
    	       bytes, what, fd >= 0 ? "opened" : strerror(errno));
    	if (fd >= 0)
    		close(fd);
    }
    
    int main(void)
    {
    	char buf[sizeof(struct file_handle) + MAX_HANDLE_SZ] = {};
    	struct file_handle *fh = (struct file_handle *)buf;
    	int mntfd, mnt_id;
    
    	fh->handle_bytes = MAX_HANDLE_SZ;
    	mntfd = open("/proc/self/ns/net", O_RDONLY);
    	if (mntfd < 0 || name_to_handle_at(AT_FDCWD, "/proc/self/ns/net", fh,
    					   &mnt_id, AT_SYMLINK_FOLLOW)) {
    		perror("name_to_handle_at");
    		return 2;
    	}
    	try(mntfd, fh, 16, 0, 1, "as encoded");
    	try(mntfd, fh, 20, 0, 1, "one zero word of padding");
    	try(mntfd, fh, 48, 0, 1, "eight zero words of padding");
    	try(mntfd, fh, 128, 0, 1, "zero-padded to MAX_HANDLE_SZ");
    	try(mntfd, fh, 20, 19, 0, "non-zero byte 19 (past the struct)");
    	try(mntfd, fh, 48, 47, 0, "non-zero byte 47 (past the struct)");
    	printf("%s\n", fails ? "FAIL" : "PASS");
    	return fails != 0;
    }
    
    gcc -O2 -Wall -o nsfs_fh_pad nsfs_fh_pad.c && ./nsfs_fh_pad
    
    before: ok   handle_bytes=16 as encoded -> opened
            ok   handle_bytes=20 one zero word of padding -> opened
            FAIL handle_bytes=48 eight zero words of padding -> Stale file handle
            FAIL handle_bytes=128 zero-padded to MAX_HANDLE_SZ -> Stale file handle
            FAIL handle_bytes=20 non-zero byte 19 (past the struct) -> opened
            ok   handle_bytes=48 non-zero byte 47 (past the struct) -> Stale file handle
            FAIL
    after:  all six ok, PASS

 fs/nsfs.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/nsfs.c b/fs/nsfs.c
index c3b6ae76594a..0ef4e1455b7a 100644
--- a/fs/nsfs.c
+++ b/fs/nsfs.c
@@ -529,8 +529,8 @@ static struct dentry *nsfs_fh_to_dentry(struct super_block *sb, struct fid *fh,
 
 	/* Check that any trailing bytes are zero. */
 	if ((fh_len > NSFS_FID_SIZE_U32_LATEST) &&
-	    memchr_inv((void *)fid + NSFS_FID_SIZE_U32_LATEST, 0,
-		       fh_len - NSFS_FID_SIZE_U32_LATEST))
+	    memchr_inv((void *)fid + NSFS_FILE_HANDLE_SIZE_LATEST, 0,
+		       (fh_len - NSFS_FID_SIZE_U32_LATEST) * sizeof(u32)))
 		return NULL;
 
 	switch (fh_type) {

base-commit: 58161ead29e50d70a317ea26b472e0c7508e69da
-- 
2.53.0

