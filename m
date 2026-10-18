Received: from outgoing2021.csail.mit.edu (outgoing2021.csail.mit.edu [128.30.2.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66249341068;
	Sun, 18 Oct 2026 02:46:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=128.30.2.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792291568; cv=none; b=mLU8jdOXlcSfQdTrDzgcsx8JO/NXMLPRK4jdZOLxYrxPb1+q5sXdXucYkdLJTDI+Mx9Q6hdKjMLKFNVfmjRK1CE2UjTRgPVitoL3cpK1mxlItkOMghAeutkkLXH6mMGMM/KQGtOH345zBywuEswRrjDsLTqvCwouAbPGB5Tx8eU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792291568; c=relaxed/simple;
	bh=N3JZHamr3xmeGJnZ7mJpty8nceqWqiUlMmPZkiBjhXY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=U1YWJV3PUGXFv3XiVNqPf0BZG/OKguqkpwe9fUMykPenP1p+BSYXeeRZrwSqeYjnS5PLSniVJH+EfP7YcqcC1xBxMzbWuaKof7by8+td7VB3VWU1ypfBDtFo2fKDm99n4WJO0kPo9+1bcxyCugdjkiwZEvpPcjJfuQaG1qgOPVo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=csail.mit.edu; spf=pass smtp.mailfrom=csail.mit.edu; arc=none smtp.client-ip=128.30.2.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=csail.mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=csail.mit.edu
Received: from escalante.csail.mit.edu ([128.52.128.198])
	by outgoing2021.csail.mit.edu with esmtp (Exim 4.95)
	(envelope-from <nickolai@csail.mit.edu>)
	id 1xIGuD-004PQI-7m;
	Sat, 17 Oct 2026 22:45:49 -0400
From: Nickolai Zeldovich <nickolai@csail.mit.edu>
To: Christian Brauner <brauner@kernel.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>
Cc: Jan Kara <jack@suse.cz>,
	Chuck Lever <cel@kernel.org>,
	Yongjian Sun <sunyongjian1@huawei.com>,
	Hugh Dickins <hughd@google.com>,
	NeilBrown <neil@brown.name>,
	linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Nickolai Zeldovich <nickolai@csail.mit.edu>
Subject: [PATCH v1] libfs: end the readdir walk when no entry is left at or below ctx->pos
Date: Sat, 17 Oct 2026 22:45:48 -0400
Message-ID: <20261018024549.798968-1-nickolai@csail.mit.edu>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On tmpfs, a getdents64() call that continues a directory listing
returns the whole directory again if the entry it was due to resume at
has been unlinked and no entry with a lower offset is left.  "ls" or any
other readdir loop then reports every name twice.  It is enough that the
oldest entry in the directory is removed while a listing that has
returned all the other entries has not yet reached the end: create five
files, read them one getdents64() call at a time until only the oldest
is left, unlink it, and the next call returns the four newer names
again instead of 0.  No privilege is needed beyond write access to the
directory.

offset_iterate_dir() walks d_children from the newest entry towards
the oldest and leaves ctx->pos at the offset of the next entry to emit.
On the next call offset_dir_lookup() maps ctx->pos back to an entry
with mas_find_rev(), which returns the entry at ctx->pos or, if that
one is gone, the next older one.  When nothing is left at or below
ctx->pos it returns NULL, and find_positive_dentry(parent, NULL, false)
treats NULL as "start at the first child", so the walk restarts at the
head of the list.

mas_find_rev() came in with commit f70681e9e606 ("libfs: Fix
duplicate directory entry in offset_dir_lookup"); with the forward
mas_find() it replaced, NULL meant that nothing had been emitted yet and
restarting at the head was right.  With the reverse search NULL means
that every remaining entry has already been emitted, so return NULL and
let offset_iterate_dir() report the end of the directory.

Reproduced on x86_64 under QEMU with the program in the notes: before
the change the call after the unlink returns file4..file1 again, after
it returns 0.

Fixes: f70681e9e606 ("libfs: Fix duplicate directory entry in offset_dir_lookup")
Assisted-by: LLM
Signed-off-by: Nickolai Zeldovich <nickolai@csail.mit.edu>
---

Notes:
    Reproducer (root, mounts a tmpfs on /t; any kernel since v6.14):
    
      gcc -O2 -static -o offset_eod offset_eod.c && ./offset_eod
    
      /*
       * List a tmpfs directory one entry per getdents64() call until only the
       * oldest file is left, unlink that file, then call getdents64() again:
       * the directory must be at its end.
       */
      #define _GNU_SOURCE
      #include <fcntl.h>
      #include <stdio.h>
      #include <string.h>
      #include <sys/mount.h>
      #include <sys/stat.h>
      #include <sys/syscall.h>
      #include <unistd.h>
    
      struct d64 {
      	unsigned long long ino;
      	long long off;
      	unsigned short reclen;
      	unsigned char type;
      	char name[];
      };
    
      #define NFILES 5
    
      int main(void)
      {
      	char buf[40], path[64];
      	int fd, i, n, seen = 0, dups = 0;
      	long r;
    
      	mkdir("/t", 0755);
      	if (mount("tmpfs", "/t", "tmpfs", 0, NULL))
      		perror("mount tmpfs");
      	mkdir("/t/d", 0755);
      	for (i = 0; i < NFILES; i++) {
      		snprintf(path, sizeof(path), "/t/d/file%d", i);
      		close(open(path, O_CREAT | O_WRONLY, 0644));
      	}
      	fd = open("/t/d", O_RDONLY | O_DIRECTORY);
      	/* newest first: file4 .. file1, file0 still to come */
      	while (seen < NFILES - 1) {
      		r = syscall(SYS_getdents64, fd, buf, sizeof(buf));
      		if (r <= 0)
      			return 1;
      		for (n = 0; n < r; n += ((struct d64 *)(buf + n))->reclen) {
      			struct d64 *d = (struct d64 *)(buf + n);
    
      			if (d->name[0] != '.')
      				seen++;
      			printf("listed %s\n", d->name);
      		}
      	}
      	unlink("/t/d/file0");
      	printf("unlinked file0\n");
      	while ((r = syscall(SYS_getdents64, fd, buf, sizeof(buf))) > 0) {
      		for (n = 0; n < r; n += ((struct d64 *)(buf + n))->reclen) {
      			printf("listed again %s\n", ((struct d64 *)(buf + n))->name);
      			dups++;
      		}
      	}
      	printf("%s: %d entries after the unlink\n", dups ? "FAIL" : "PASS", dups);
      	return dups != 0;
      }
    
    Before (master 70dd4ee72eb2, x86_64 defconfig, QEMU):
    
      listed .
      listed ..
      listed file4
      listed file3
      listed file2
      listed file1
      unlinked file0
      listed again file4
      listed again file3
      listed again file2
      listed again file1
      FAIL: 4 entries after the unlink
    
    After:
    
      listed .
      listed ..
      listed file4
      listed file3
      listed file2
      listed file1
      unlinked file0
      PASS: 0 entries after the unlink

 fs/libfs.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/fs/libfs.c b/fs/libfs.c
index 27d7dc16fcb0..6ebffad7c028 100644
--- a/fs/libfs.c
+++ b/fs/libfs.c
@@ -485,7 +485,9 @@ offset_dir_lookup(struct dentry *parent, loff_t offset)
 	else {
 		rcu_read_lock();
 		child = mas_find_rev(&mas, DIR_OFFSET_MIN);
-		found = find_positive_dentry(parent, child, false);
+		/* nothing at or below @offset: no entry is left to emit */
+		if (child)
+			found = find_positive_dentry(parent, child, false);
 		rcu_read_unlock();
 	}
 	return found;

base-commit: 58161ead29e50d70a317ea26b472e0c7508e69da
-- 
2.53.0

