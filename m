Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=117.135.210.5
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795773459;
	b=SK3jZ0XJrVQtzLOMMQg7puwcFgxzGKkw5LwUC0oJT1x77vYWsN2H8C9VchC2GvOMJNia
	 nKawCjpUk6NnU2es5Wlb1zTfJ78ukWknJ+KDms15mVUhJkiwJ69ofQNPRMrGCqAAueSyO
	 03s0sjGrc6J7ywbGorg17lGFKmYiQKtIrpj1xR3ZoBB/SbmTYHWzvOl2mkEnr9/QRNTiq
	 zXqK5byzlBN8GbioHa6tID0bcXYGduHmkLoHcuLfy4Xdm2a6ugut3GmhVcu8C+eyIw/w1
	 FNoLh8iF8YYyY02oWKrlpnFC1BnLdz2/02IuTb6mVFG+rjeoVy0dR4XlVLzH6UpXwUA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795773459;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-Id:X-Mailer:MIME-Version:Content-Transfer-Encoding:
	 X-CM-TRANSID:X-Coremail-Antispam:X-CM-SenderInfo;
	bh=69+4bHVY7J3UMA/5+KV1w/FUHDxIBD0PWF/YGVpWFJc=;
	b=NAbVlsdZXukTB8+3tyWES6ek4f38ApDCRQzTHrZIYabqpOEroyZCnzH5R8C0/SIYDwFl
	 qB8IsQZBmE9EWPW1QzSIeTXIzjWrvPidThaaplNsLx25mbK46YqnTEyBTBNAbJac5Q6Gj
	 cKqWEEVDE13yPxSFXIGGFDONi2BC9KFFdoG1oOq7egvIWrti95r8fQujBYwRZG5fVUHOo
	 ucNFX+8HNc7ooNyN6nUTsiwESki9MduVcD2ycUTnr0VLprxq6e+SZ4EgglOqRR/ct44JR
	 LLmc4MBKhFCTeJzJLbSeUG+PZ4TSZqXkymayO9xlbgHcFA6D211xComHE2fYof4aQHQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=163.com;
	spf=pass smtp.mailfrom=163.com;
	dkim=pass header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=GmRyzO0+;
	arc=none smtp.remote-ip=117.135.210.5
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D2CC606A31C;
	Fri, 27 Nov 2026 09:57:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4D2CC606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=GmRyzO0+
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=69
	+4bHVY7J3UMA/5+KV1w/FUHDxIBD0PWF/YGVpWFJc=; b=GmRyzO0+tN4zGIMIzb
	j+AT0kEkxcFLa4T5yIXw9h8inFXk0/9VmTjUI23Ips60frSGxQ6MpEvXY4DLcfAO
	U3hxV3KGb7dBVhrTDrjYxADI2bCqcfnvSHKMcrncJU3WX7352YzsvAngFuruCaRC
	1XeMZqyPkwhNUzR8sjvknbPkU=
Received: from shaos.localdomain (unknown [])
	by gzsmtp2 (Coremail) with SMTP id PSgvCgCXagrcUwlrG+rhHw--.25255S2;
	Fri, 27 Nov 2026 17:56:45 +0800 (CST)
From: shaos <shawnq1@163.com>
To: shaggy@kernel.org
Cc: Yun Zhou <yun.zhou@windriver.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Christian Brauner <brauner@kernel.org>,
	Mike Rapoport <rppt@kernel.org>,
	jfs-discussion@lists.sourceforge.net,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] jfs: reject self-linked directory tree pages
Date: Fri, 27 Nov 2026 09:56:44 +0000
Message-Id: <20261127095644.1193523-1-shawnq1@163.com>
X-Mailer: git-send-email 2.34.1
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
X-CM-TRANSID:PSgvCgCXagrcUwlrG+rhHw--.25255S2
X-Coremail-Antispam: 1Uf129KBjvJXoW3Xw4fCrW8Xry7Xw47WrWrAFb_yoW3JF17pw
	1fCF1ftr4kKr4UAw1xGF4kZayfC3ykJrWYy3Z7Gw4xCasYqw17urySyr13Z3W2qrWkW3ya
	9r4jgr129ayUKaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jOtxhUUUUU=
X-CM-SenderInfo: pvkd40jtr6il2tof0z/xtbC8h0pN2sJU90TYAAA3u

A malformed JFS directory leaf can point its next or previous
sibling link back to its own block.  check_dtpage() validates the
page's slot metadata but accepts either self-link.

For an empty leftmost leaf, jfs_readdir() emits no entries from the
page and follows header.next without making progress.  A single
getdents64() then loops in kernel context.  A crafted image reproduces
this on a read-only JFS mount.

Reject a non-root directory page whose sibling link names its own
block.  Save the requested block number before BT_GETPAGE() so the
validator can compare the page links with the block that was read.  If
the leftmost page is rejected, leave the directory position at EOF so
a later getdents64() does not retry the corrupt page after returning
the already emitted dot entries.

The reproducer uses a 16 MiB JFS image with one valid empty leaf at
block 112.  The trigger has header.next=112; the control changes only
that field to zero.

HEAD commit:    8d7fe9885c62fc9a95bf55d9db244d9672a8aadc
git tree:       fe970b05333fb8e41da21e9e289f652abcc7cba7
source version: Linux 7.4.0-rc4
compiler:       gcc 11.4.0, GNU ld 2.38

Console output:
https://gist.githubusercontent.com/shaos26/111949c00d3d0b42fe7a11e90f0f47fb/raw/dde677d84dbf51c6bc82fc81535aefae86370afd/console-output.txt
Kernel config:
https://gist.githubusercontent.com/shaos26/111949c00d3d0b42fe7a11e90f0f47fb/raw/dde677d84dbf51c6bc82fc81535aefae86370afd/kernel-config.txt
PoC:
https://gist.githubusercontent.com/shaos26/111949c00d3d0b42fe7a11e90f0f47fb/raw/dde677d84dbf51c6bc82fc81535aefae86370afd/poc.c
JFS image builder:
https://gist.githubusercontent.com/shaos26/111949c00d3d0b42fe7a11e90f0f47fb/raw/dde677d84dbf51c6bc82fc81535aefae86370afd/mkjfs_cycle.py

Build the test kernel from the specified commit and config.  Required
tools are gcc, make, cpio, gzip, Python 3 and QEMU.  Run these
commands to download the files, build the kernel and create both
images and the initramfs:

    work=$(mktemp -d /tmp/jfs-readdir.XXXXXX)
    cd "$work"
    gist_id=111949c00d3d0b42fe7a11e90f0f47fb
    gist_revision=dde677d84dbf51c6bc82fc81535aefae86370afd
    gist_base=https://gist.githubusercontent.com/shaos26
    gist=$gist_base/$gist_id/raw/$gist_revision
    for file in console-output.txt kernel-config.txt poc.c \
        mkjfs_cycle.py; do
        curl -fL "$gist/$file" -o "$file"
    done
    git clone \
        https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
    cd linux
    git checkout 8d7fe9885c62fc9a95bf55d9db244d9672a8aadc
    mkdir build
    cp ../kernel-config.txt build/.config
    make O=build olddefconfig
    make O=build -j"$(nproc)" bzImage
    cd ..
    python3 mkjfs_cycle.py trigger trigger.img
    python3 mkjfs_cycle.py control control.img
    mkdir -p rootfs/dev rootfs/proc rootfs/mnt
    gcc -O2 -static -Wall -Wextra -Werror -o rootfs/init poc.c
    chmod 0755 rootfs/init
    (cd rootfs && find . -print0 |
        cpio --null -o -H newc --owner=0:0 |
        gzip -9) > initramfs.cpio.gz

Run the vulnerable kernel with the trigger image and then the
one-field control:

    kernel_cmdline='console=ttyS0 earlyprintk=serial nokaslr'
    kernel_cmdline="$kernel_cmdline panic=1 oops=panic"
    qemu-system-x86_64 -machine pc -cpu qemu64 -m 1024 -smp 2 \
        -kernel linux/build/arch/x86/boot/bzImage \
        -initrd initramfs.cpio.gz \
        -drive file=trigger.img,format=raw,if=virtio,readonly=on \
        -append "$kernel_cmdline" \
        -nographic -no-reboot
    qemu-system-x86_64 -machine pc -cpu qemu64 -m 1024 -smp 2 \
        -kernel linux/build/arch/x86/boot/bzImage \
        -initrd initramfs.cpio.gz \
        -drive file=control.img,format=raw,if=virtio,readonly=on \
        -append "$kernel_cmdline" \
        -nographic -no-reboot

The trigger kernel stays in state R, with CPU ticks advancing from
100 to 142.  Its stack includes check_dtpage() and jfs_readdir();
it remains in state R at tick 206 after SIGKILL.  With the patch
below, the trigger logs the rejected self-link and getdents64()
returns the dot entries followed by EOF.  The control also completes
normally.  The console file contains all three runs.  To build and
check the patched kernel, save the diff below as fix.patch in the
Linux source directory, then run:

    git apply --check fix.patch
    git apply fix.patch
    make O=build -j"$(nproc)" bzImage

Run the same two QEMU commands with the rebuilt kernel to check both
images again.

This is a local denial of service when a crafted JFS image is mounted.
The test used a read-only mount.  It demonstrates no memory
corruption, information disclosure or privilege escalation.

The patch was built against the same source tree and config.  The
positive and control images were both tested with it.  The PoC builds
with -Wall -Wextra -Werror.  The patch passes
scripts/checkpatch.pl --no-tree --strict and git apply --check.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Signed-off-by: shaos <shawnq1@163.com>
---
 fs/jfs/jfs_dtree.c | 21 +++++++++++++++++----
 fs/jfs/jfs_dtree.h |  2 +-
 2 files changed, 18 insertions(+), 5 deletions(-)

diff --git a/fs/jfs/jfs_dtree.c b/fs/jfs/jfs_dtree.c
index 8ce6e4458cc256a88c596748f5b0dc611a85a184..3058c56c758994ff35a9c6e26dfd6a00e9bb2678 100644
--- a/fs/jfs/jfs_dtree.c
+++ b/fs/jfs/jfs_dtree.c
@@ -113,9 +113,10 @@ struct dtsplit {
 /* get page buffer for specified block address */
 #define DT_GETPAGE(IP, BN, MP, SIZE, P, RC)				\
 do {									\
-	BT_GETPAGE(IP, BN, MP, dtpage_t, SIZE, P, RC, i_dtroot);	\
+	s64 dt_bn = (BN);						\
+	BT_GETPAGE(IP, dt_bn, MP, dtpage_t, SIZE, P, RC, i_dtroot);	\
 	if (!(RC)) {							\
-		if ((BN) && !check_dtpage(P)) {				\
+		if (dt_bn && !check_dtpage(P, dt_bn)) {				\
 			BT_PUTPAGE(MP);					\
 			jfs_error((IP)->i_sb,				\
 				  "DT_GETPAGE: dtree page corrupt\n");	\
@@ -2826,8 +2827,12 @@ int jfs_readdir(struct file *file, struct dir_context *ctx)
 				return 0;
 			}
 
-			if ((rc = dtReadFirst(ip, &btstack)))
+			rc = dtReadFirst(ip, &btstack);
+			if (rc) {
+				/* Avoid retrying a corrupt first page on the next call. */
+				ctx->pos = DIREND;
 				return rc;
+			}
 
 			DT_GETSEARCH(ip, btstack.top, bn, mp, p, index);
 		}
@@ -4381,12 +4386,20 @@ bool check_dtroot(dtroot_t *p)
 	return true;
 }
 
-bool check_dtpage(dtpage_t *p)
+bool check_dtpage(dtpage_t *p, s64 bn)
 {
 	DECLARE_BITMAP(bitmap, DTPAGEMAXSLOT) = {0};
 	const int stblsize = ((PSIZE >> L2DTSLOTSIZE) + 31) >> L2DTSLOTSIZE;
 	int i;
 
+	/* A directory page cannot be its own sibling. */
+	if (unlikely(le64_to_cpu(p->header.next) == bn ||
+		     le64_to_cpu(p->header.prev) == bn)) {
+		jfs_err("Self-referential sibling link in dtpage %lld\n",
+			(long long)bn);
+		return false;
+	}
+
 	/* Validate maxslot (maximum number of slots in the page)
 	 * dtpage_t slot array is defined to hold up to DTPAGEMAXSLOT (128) slots
 	 */
diff --git a/fs/jfs/jfs_dtree.h b/fs/jfs/jfs_dtree.h
index dfc87b6690a9a8e9f4e080a7f28abb7bd89f0e85..c62e3b8b5441a9c5bca93c646656deeb3f0246c7 100644
--- a/fs/jfs/jfs_dtree.h
+++ b/fs/jfs/jfs_dtree.h
@@ -256,5 +256,5 @@ extern int jfs_readdir(struct file *file, struct dir_context *ctx);
 
 extern bool check_dtroot(dtroot_t *p);
 
-extern bool check_dtpage(dtpage_t *p);
+bool check_dtpage(dtpage_t *p, s64 bn);
 #endif				/* !_H_JFS_DTREE */
-- 
2.43.0

