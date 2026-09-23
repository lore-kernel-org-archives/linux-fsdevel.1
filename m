Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D1554756BA
	for <linux-fsdevel@vger.kernel.org>; Wed, 23 Sep 2026 22:19:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790201974; cv=none; b=MBZWfvPHAxwUHdzP1VZECuWcfPdahhCMOONF25fSyJNrLj5rvtQUktraNIorLTZxq6JVpCcGdPiW+fGcS1RlmaDKzrSYpyDJgMGnAyRTXQfYjVyegEcIa7QRxpZPTtUoiBgfnMWxMPZo2rpMWJAktIZGZPuONenl04xtfJgW1Fg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790201974; c=relaxed/simple;
	bh=/7ukyqApOhg3YNKlAOdgyO4oOMgkPVZjioE6Q10Nucs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ZuZM+DuJvuEPYTeirkkVRLk4naCqYJNzFtDb3li3EroKthL4QgrvscmCV3RfRCUV5kROauIN48CgBNOTe5vASz9+thq+jEdkBZPfGkdOxIyPHA4B85lEPwK4wHBLQlZQRiECt5nJACbKrnNweWHzYv7tqVEqbK9c1EgeNsx9em0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ls64uYEj; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ls64uYEj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9D0F71F000FF;
	Wed, 23 Sep 2026 22:19:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790201972;
	bh=haRiHOLwJ8faN87oZe+OXtadnH6LhwBJB81P12H7+hQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=ls64uYEjZRK+wkqxWbSM6WOgMT3IfM61NWcbKyg09L3BcL/Gu5+Q6oLg6MvZqsPOu
	 SLuWfbVilkHe9VM6lURVWhS/7loxl4CYYNj7e4bicEXTWWCuTGvRQHOFBZSiVn8xDk
	 V5bcKUgtF6ctAjO0m/NdS8S3TvVuVysMGoh+z+JGRlOWFMktyH9o6d4D3Vjj/8jXTB
	 7jdIjDApae17R61h/xRds51VT9pSPYSZ7FaGvjVOOzabf7n/eqZaF9j6EKeGhd4ZKp
	 8kYslvg6gJNZakcOj0rhRBgfNhUHOoFfIxdIW1LPT3l16JhECdAAaF2cTBrG7ITyBU
	 S5K/mPfs1Edyg==
From: Christian Brauner <brauner@kernel.org>
Date: Thu, 24 Sep 2026 00:18:55 +0200
Subject: [PATCH RFC 6/6] selftests/filesystems: check that the holders let
 go of a dead mount
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260924-work-mount-knullfs-v1-6-ae89b29f7cb3@kernel.org>
References: <20260924-work-mount-knullfs-v1-0-ae89b29f7cb3@kernel.org>
In-Reply-To: <20260924-work-mount-knullfs-v1-0-ae89b29f7cb3@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Jann Horn <jannh@google.com>, Jan Kara <jack@suse.cz>, 
 Amir Goldstein <amir73il@gmail.com>, linux-fsdevel@vger.kernel.org, 
 Alexander Viro <viro@zeniv.linux.org.uk>, 
 "Christian Brauner (Amutable)" <brauner@kernel.org>
X-Mailer: b4 0.17-dev-db0b7
X-Developer-Signature: v=1; a=openpgp-sha256; l=27764; i=brauner@kernel.org;
 h=from:subject:message-id; bh=/7ukyqApOhg3YNKlAOdgyO4oOMgkPVZjioE6Q10Nucs=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWRtCUj2l6jj2/1C3kd31YTrvpmFLxJD9vMvnBHD8bXVY
 OVer9/7O0pZGMS4GGTFFFkc2k3C5ZbzVGw2ytSAmcPKBDKEgYtTACbi1cDIsOnakaJTEhuVInW2
 XQveHHOw9Ez83mM8/kk8xwumB+gfnsPw3ylz1Ycqi5SF2otFPk9/sO45+90A9uus87Y/YN4uybn
 DkgUA
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Extend loop_cycle_test with one case per holder that keeps a file or a
path on a mount and can be mounted below it:

- a loop mount P from an image on a tmpfs next to it, so that P's death
  shows as the loop device giving up its backing file
- autofs with a FIFO on P as its pipe, zram with a device node on P as
  its writeback device, both on a minix image since vfat has neither
- ecryptfs with its lower directory on P, under a passphrase token
  added to the session keyring
- binfmt_misc in a new user namespace with an 'F' interpreter on P
- a fuse server that answers FUSE_INIT with passthrough on and registers
  a file on P as a backing file
- zloop with its zone files in a directory on P
- a mass storage gadget on the dummy UDC with its LUN file on P, mounted
  from the SCSI disk the gadget shows up as
- md with a RAID1 of one loop device and its bitmap file on P, which
  skips while SET_BITMAP_FILE has no way to succeed
- rmdir of P's mountpoint from the parent, then the child exits, then
  the device must be free and LOOP_CLR_FD must release the file

Each case leaks the device on a kernel without the holder's conversion
and releases it with it.

Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
---
 .../filesystems/mount_cycle/loop_cycle_test.c      | 760 +++++++++++++++++++++
 1 file changed, 760 insertions(+)

diff --git a/tools/testing/selftests/filesystems/mount_cycle/loop_cycle_test.c b/tools/testing/selftests/filesystems/mount_cycle/loop_cycle_test.c
index 4f4c88397861..09cc824c769e 100644
--- a/tools/testing/selftests/filesystems/mount_cycle/loop_cycle_test.c
+++ b/tools/testing/selftests/filesystems/mount_cycle/loop_cycle_test.c
@@ -23,7 +23,16 @@
 #include <stdbool.h>
 #include <sys/wait.h>
 #include <unistd.h>
+#include <linux/fuse.h>
+#include <linux/keyctl.h>
+#include <linux/major.h>
+#include <linux/raid/md_u.h>
+#include <linux/raid/md_p.h>
 #include <linux/loop.h>
+#include <linux/magic.h>
+#include <sys/syscall.h>
+#include <sys/sysmacros.h>
+#include <sys/uio.h>
 
 #include "../wrappers.h"
 #include "../../kselftest_harness.h"
@@ -34,6 +43,7 @@
 /* A blank FAT12 floppy image: boot sector, two FATs, an empty root directory. */
 static int write_fat12(int fd)
 {
+	struct stat st;
 	unsigned char sector[SECTOR] = {
 		0xeb, 0x3c, 0x90, 'M', 'S', 'W', 'I', 'N', '4', '.', '1',
 		[11] = 0x00, 0x02,	/* bytes per sector: 512 */
@@ -60,9 +70,114 @@ static int write_fat12(int fd)
 	if (pwrite(fd, fat, SECTOR, 1 * SECTOR) != SECTOR ||
 	    pwrite(fd, fat, SECTOR, 10 * SECTOR) != SECTOR)
 		return -1;
+	if (fstat(fd, &st) || S_ISBLK(st.st_mode))
+		return 0;
 	return ftruncate(fd, IMAGE_SIZE);
 }
 
+/*
+ * A blank FAT12 image with 4 KiB sectors and @sectors of them, for a device
+ * with 4 KiB logical blocks (zram) or for a bigger image than a floppy.
+ */
+static int write_fat12_4k(int fd, unsigned int sectors)
+{
+	unsigned int fat_sectors = (sectors * 3 / 2 + 4095) / 4096;
+	unsigned char sector[4096] = {
+		0xeb, 0x3c, 0x90, 'M', 'S', 'W', 'I', 'N', '4', '.', '1',
+		[11] = 0x00, 0x10,	/* bytes per sector: 4096 */
+		[13] = 1,		/* sectors per cluster */
+		[14] = 1, 0,		/* reserved sectors */
+		[16] = 2,		/* FATs */
+		[17] = 128, 0,		/* root directory entries: one sector */
+		[19] = sectors & 0xff, sectors >> 8,
+		[21] = 0xf8,		/* media descriptor */
+		[22] = fat_sectors, 0,
+		[24] = 63, 0,		/* sectors per track */
+		[26] = 255, 0,		/* heads */
+		[38] = 0x29,		/* extended boot signature */
+		[39] = 0x12, 0x34, 0x56, 0x78,
+		[43] = 'N', 'O', ' ', 'N', 'A', 'M', 'E', ' ', ' ', ' ', ' ',
+		[54] = 'F', 'A', 'T', '1', '2', ' ', ' ', ' ',
+		[510] = 0x55, 0xaa,
+	};
+	unsigned char fat[4096] = { 0xf8, 0xff, 0xff };
+	struct stat st;
+
+	if (pwrite(fd, sector, sizeof(sector), 0) != sizeof(sector))
+		return -1;
+	if (pwrite(fd, fat, sizeof(fat), 1 * 4096) != sizeof(fat) ||
+	    pwrite(fd, fat, sizeof(fat), (1 + fat_sectors) * 4096) != sizeof(fat))
+		return -1;
+	if (fstat(fd, &st) || S_ISBLK(st.st_mode))
+		return 0;
+	return ftruncate(fd, (off_t)sectors * 4096);
+}
+
+#define MINIX_BLOCK	1024
+#define MINIX_BLOCKS	4096			/* a 4 MiB image */
+#define MINIX_INODES	512
+#define MINIX_ITABLE	(MINIX_INODES * 32 / MINIX_BLOCK)
+#define MINIX_FIRSTDATA	(2 + 1 + 1 + MINIX_ITABLE)	/* boot, super, imap, zmap, inodes */
+
+/*
+ * A blank minix v1 image, for the holders that need a FIFO or a device
+ * node on the dying mount, which vfat can't hold. Superblock in block 1,
+ * one block each for the inode and zone bitmaps, the inode table, and
+ * the root directory in the first data zone.
+ */
+static int write_minix(int fd)
+{
+	struct {
+		__u16 s_ninodes, s_nzones, s_imap_blocks, s_zmap_blocks;
+		__u16 s_firstdatazone, s_log_zone_size;
+		__u32 s_max_size;
+		__u16 s_magic, s_state;
+	} sb = {
+		.s_ninodes = MINIX_INODES,
+		.s_nzones = MINIX_BLOCKS,
+		.s_imap_blocks = 1,
+		.s_zmap_blocks = 1,
+		.s_firstdatazone = MINIX_FIRSTDATA,
+		.s_max_size = (7 + 512 + 512 * 512) * MINIX_BLOCK,
+		.s_magic = MINIX_SUPER_MAGIC,
+		.s_state = 1,		/* MINIX_VALID_FS */
+	};
+	struct {
+		__u16 i_mode, i_uid;
+		__u32 i_size, i_time;
+		__u8 i_gid, i_nlinks;
+		__u16 i_zone[9];
+	} root = {
+		.i_mode = S_IFDIR | 0755,
+		.i_size = 2 * 16,
+		.i_nlinks = 2,
+		.i_zone = { MINIX_FIRSTDATA },
+	};
+	unsigned char imap[MINIX_BLOCK], zmap[MINIX_BLOCK], dir[MINIX_BLOCK] = {};
+	int i;
+
+	/* bit 0 is reserved in both maps, the root inode and its zone are in use */
+	memset(imap, 0xff, sizeof(imap));
+	for (i = 2; i <= MINIX_INODES; i++)
+		imap[i / 8] &= ~(1 << (i % 8));
+	memset(zmap, 0xff, sizeof(zmap));
+	for (i = 2; i <= MINIX_BLOCKS - MINIX_FIRSTDATA; i++)
+		zmap[i / 8] &= ~(1 << (i % 8));
+	dir[0] = 1;
+	dir[2] = '.';
+	dir[16] = 1;
+	dir[18] = '.';
+	dir[19] = '.';
+
+	if (pwrite(fd, &sb, sizeof(sb), 1 * MINIX_BLOCK) != sizeof(sb) ||
+	    pwrite(fd, imap, sizeof(imap), 2 * MINIX_BLOCK) != sizeof(imap) ||
+	    pwrite(fd, zmap, sizeof(zmap), 3 * MINIX_BLOCK) != sizeof(zmap) ||
+	    pwrite(fd, &root, sizeof(root), 4 * MINIX_BLOCK) != sizeof(root) ||
+	    pwrite(fd, dir, sizeof(dir), MINIX_FIRSTDATA * MINIX_BLOCK) != sizeof(dir))
+		return -1;
+	return ftruncate(fd, (off_t)MINIX_BLOCKS * MINIX_BLOCK);
+}
+
 static int read_sysfs(const char *path, char *buf, size_t size)
 {
 	ssize_t n;
@@ -158,6 +273,8 @@ enum {
 	CHILD_LOOP,		/* could not set up the loop device */
 	CHILD_MOUNT,		/* could not mount it (vfat and msdos both refused) */
 	CHILD_PIPE,		/* the parent went away */
+	CHILD_HOLDER,		/* could not set the holder up below the mount */
+	CHILD_SKIP,		/* the kernel lacks what the holder needs */
 };
 
 /* Bind a free loop device to the open image @ifd; the device number. */
@@ -462,4 +579,647 @@ TEST_F(loop_cycle, crossed_images_released)
 	}
 }
 
+/*
+ * The holders. Each keeps a file or a path on a mount P for as long as
+ * its own filesystem or device lives, and each has that filesystem or
+ * device mounted at C below P. Once another namespace's rmdir has
+ * detached P with C connected below it and the child is gone, P is owned
+ * by nobody, C by P, and P is kept by whatever the holder still holds.
+ *
+ * P is a loop mount so that its death can be observed: the loop device
+ * gives its backing file up when P's superblock goes. The image sits on
+ * a tmpfs next to P, not above it, so the loop device's own reference is
+ * not part of the picture.
+ */
+enum holder {
+	HOLDER_AUTOFS,		/* a FIFO on P as the daemon's pipe */
+	HOLDER_ZRAM,		/* a device node on P as the writeback device */
+	HOLDER_ECRYPTFS,	/* a directory on P as the lower directory */
+	HOLDER_BINFMT_MISC,	/* an executable on P as an 'F' interpreter */
+	HOLDER_FUSE,		/* a file on P as a passthrough backing file */
+	HOLDER_ZLOOP,		/* a directory on P for the zone files */
+	HOLDER_GADGET,		/* a file on P as a mass storage LUN, over dummy_hcd */
+	HOLDER_MD,		/* a file on P as an array's bitmap file */
+};
+
+#define HOLDER_IMG	"/mnt_dir/img/p.img"
+#define HOLDER_MNT	"/mnt_dir/p"
+#define HOLDER_BELOW	"/mnt_dir/p/c"
+
+static int write_file(const char *path, const char *s)
+{
+	int fd = open(path, O_WRONLY);
+	ssize_t n;
+
+	if (fd < 0)
+		return -1;
+	n = write(fd, s, strlen(s));
+	close(fd);
+	return n == (ssize_t)strlen(s) ? 0 : -1;
+}
+
+/* Bind a free loop device to @img; the device number. */
+static int loop_attach(const char *img)
+{
+	int ifd, n;
+
+	ifd = open(img, O_RDWR);
+	if (ifd < 0)
+		return -1;
+	n = loop_bind(ifd);
+	close(ifd);
+	return n;
+}
+
+static int holder_autofs(void)
+{
+	char opts[64];
+	int pfd;
+
+	if (mkfifo(HOLDER_MNT "/pipe", 0600))
+		return CHILD_HOLDER;
+	pfd = open(HOLDER_MNT "/pipe", O_RDWR);
+	if (pfd < 0)
+		return CHILD_HOLDER;
+	snprintf(opts, sizeof(opts), "fd=%d,minproto=5,maxproto=5", pfd);
+	if (mount("autofs", HOLDER_BELOW, "autofs", 0, opts))
+		return errno == ENODEV ? CHILD_SKIP : CHILD_HOLDER;
+	close(pfd);	/* the mount keeps its own */
+	return CHILD_OK;
+}
+
+/*
+ * zram's writeback device has to be a block device node, and that node has
+ * to be on P. Point it at a second loop device.
+ */
+static int holder_zram(void)
+{
+	char buf[64];
+	int fd, n;
+
+	if (access("/sys/block/zram0/backing_dev", W_OK))
+		return CHILD_SKIP;
+	/* somebody else's device, leave it alone */
+	if (read_sysfs("/sys/block/zram0/initstate", buf, sizeof(buf)) || buf[0] != '0')
+		return CHILD_SKIP;
+	fd = open("/mnt_dir/img/wb.img", O_RDWR | O_CREAT | O_EXCL, 0600);
+	if (fd < 0 || ftruncate(fd, IMAGE_SIZE))
+		return CHILD_HOLDER;
+	close(fd);
+	n = loop_attach("/mnt_dir/img/wb.img");
+	if (n < 0)
+		return CHILD_HOLDER;
+	if (mknod(HOLDER_MNT "/wbdev", S_IFBLK | 0600, makedev(7, n)))
+		return CHILD_HOLDER;
+	if (write_file("/sys/block/zram0/backing_dev", HOLDER_MNT "/wbdev"))
+		return CHILD_HOLDER;
+	snprintf(buf, sizeof(buf), "%d", 4 * 1024 * 1024);
+	if (write_file("/sys/block/zram0/disksize", buf))
+		return CHILD_HOLDER;
+	fd = open("/dev/zram0", O_RDWR);
+	if (fd < 0 || write_fat12_4k(fd, 1024))	/* zram has 4 KiB blocks */
+		return CHILD_HOLDER;
+	close(fd);
+	if (mount("/dev/zram0", HOLDER_BELOW, "vfat", 0, NULL) &&
+	    mount("/dev/zram0", HOLDER_BELOW, "msdos", 0, NULL))
+		return CHILD_HOLDER;
+	return CHILD_OK;
+}
+
+/* The kernel's auth token layout, which userspace has to match byte for byte. */
+struct ecryptfs_auth_tok {
+	__u16 version;
+	__u16 token_type;
+	__u32 flags;
+	struct {
+		__u32 flags, encrypted_key_size, decrypted_key_size;
+		__u8 encrypted_key[512], decrypted_key[64];
+	} session_key;
+	__u8 reserved[32];
+	struct {
+		__u32 password_bytes;
+		__s32 hash_algo;
+		__u32 hash_iterations, session_key_encryption_key_bytes, flags;
+		__u8 session_key_encryption_key[64];
+		__u8 signature[17];
+		__u8 salt[8];
+	} password;
+} __attribute__((packed));
+
+#define ECRYPTFS_SIG	"0123456789abcdef"
+
+static int holder_ecryptfs(void)
+{
+	struct ecryptfs_auth_tok tok = {
+		.version = 0x0004,
+		.token_type = 0,		/* ECRYPTFS_PASSWORD */
+		.password.session_key_encryption_key_bytes = 16,
+		.password.flags = 0x02,		/* ECRYPTFS_SESSION_KEY_ENCRYPTION_KEY_SET */
+		.password.signature = ECRYPTFS_SIG,
+	};
+
+	if (syscall(__NR_add_key, "user", ECRYPTFS_SIG, &tok, sizeof(tok),
+		    KEY_SPEC_SESSION_KEYRING) < 0)
+		return CHILD_HOLDER;
+	if (mkdir(HOLDER_MNT "/lower", 0755))
+		return CHILD_HOLDER;
+	if (mount(HOLDER_MNT "/lower", HOLDER_BELOW, "ecryptfs", 0,
+		  "ecryptfs_sig=" ECRYPTFS_SIG ",ecryptfs_cipher=aes,ecryptfs_key_bytes=16"))
+		return errno == ENODEV ? CHILD_SKIP : CHILD_HOLDER;
+	return CHILD_OK;
+}
+
+/*
+ * binfmt_misc instances are per user namespace, so the mount below P is
+ * made from a new one, which gets a copy of P.
+ */
+static int holder_binfmt_misc(void)
+{
+	char buf[4096];
+	int in, out;
+	ssize_t n;
+
+	in = open("/proc/self/exe", O_RDONLY);
+	out = open(HOLDER_MNT "/interp", O_WRONLY | O_CREAT | O_EXCL, 0755);
+	if (in < 0 || out < 0)
+		return CHILD_HOLDER;
+	while ((n = read(in, buf, sizeof(buf))) > 0)
+		if (write(out, buf, n) != n)
+			return CHILD_HOLDER;
+	close(in);
+	close(out);
+
+	if (unshare(CLONE_NEWUSER | CLONE_NEWNS))
+		return errno == EINVAL ? CHILD_SKIP : CHILD_HOLDER;
+	if (write_file("/proc/self/setgroups", "deny") ||
+	    write_file("/proc/self/uid_map", "0 0 1") ||
+	    write_file("/proc/self/gid_map", "0 0 1"))
+		return CHILD_HOLDER;
+	if (mount("binfmt_misc", HOLDER_BELOW, "binfmt_misc", 0, NULL))
+		return errno == ENODEV ? CHILD_SKIP : CHILD_HOLDER;
+	if (write_file(HOLDER_BELOW "/register", ":cycle:E::cyc::" HOLDER_MNT "/interp:F"))
+		return CHILD_HOLDER;
+	return CHILD_OK;
+}
+
+/*
+ * A fuse server that only ever answers FUSE_INIT, with passthrough on, and
+ * then registers a file on P as a backing file. The registration alone
+ * makes the fuse superblock hold the file.
+ */
+static int holder_fuse(void)
+{
+	struct fuse_backing_map map = {};
+	struct fuse_in_header *ih;
+	struct fuse_init_out init = {
+		.major = FUSE_KERNEL_VERSION,
+		.minor = FUSE_KERNEL_MINOR_VERSION,
+		.flags = FUSE_INIT_EXT,
+		.flags2 = FUSE_PASSTHROUGH >> 32,
+		.max_write = 4096,
+		.max_stack_depth = 1,
+	};
+	struct fuse_out_header oh = { .len = sizeof(oh) + sizeof(init) };
+	struct iovec iov[2] = { { &oh, sizeof(oh) }, { &init, sizeof(init) } };
+	char opts[64], buf[8192];
+	int ffd, bfd;
+	ssize_t n;
+
+	bfd = open(HOLDER_MNT "/backing", O_RDWR | O_CREAT | O_EXCL, 0600);
+	if (bfd < 0)
+		return CHILD_HOLDER;
+	ffd = open("/dev/fuse", O_RDWR);
+	if (ffd < 0)
+		return CHILD_SKIP;
+	snprintf(opts, sizeof(opts), "fd=%d,rootmode=40000,user_id=0,group_id=0", ffd);
+	if (mount("fuse", HOLDER_BELOW, "fuse", 0, opts))
+		return errno == ENODEV ? CHILD_SKIP : CHILD_HOLDER;
+
+	n = read(ffd, buf, sizeof(buf));
+	ih = (void *)buf;
+	if (n < (ssize_t)sizeof(*ih) || ih->opcode != FUSE_INIT)
+		return CHILD_HOLDER;
+	oh.unique = ih->unique;
+	if (writev(ffd, iov, 2) != (ssize_t)oh.len)
+		return CHILD_HOLDER;
+
+	map.fd = bfd;
+	if (ioctl(ffd, FUSE_DEV_IOC_BACKING_OPEN, &map) < 0)
+		return errno == EPERM ? CHILD_SKIP : CHILD_HOLDER;
+	close(bfd);	/* the connection keeps its own */
+	return CHILD_OK;	/* ffd stays open until the child exits */
+}
+
+/* Wait for a device node the kernel is about to create. */
+static int open_when_there(const char *dev, int flags, int ms)
+{
+	int fd;
+
+	for (; ms > 0; ms -= 100) {
+		fd = open(dev, flags);
+		if (fd >= 0)
+			return fd;
+		usleep(100000);
+	}
+	return -1;
+}
+
+/*
+ * zloop keeps every zone file open. One conventional zone is enough for a
+ * FAT image, the sequential one stays empty.
+ */
+static int holder_zloop(void)
+{
+	int fd;
+
+	if (access("/dev/zloop-control", W_OK))
+		return CHILD_SKIP;
+	if (mkdir(HOLDER_MNT "/zl", 0755) || mkdir(HOLDER_MNT "/zl/0", 0755))
+		return CHILD_HOLDER;
+	if (write_file("/dev/zloop-control",
+		       "add id=0,capacity_mb=8,zone_size_mb=4,conv_zones=1,base_dir=" HOLDER_MNT "/zl"))
+		return CHILD_HOLDER;
+	fd = open_when_there("/dev/zloop0", O_RDWR, 5000);
+	if (fd < 0 || write_fat12_4k(fd, 1024))	/* 4 KiB blocks, like P */
+		return CHILD_HOLDER;
+	close(fd);
+	if (mount("/dev/zloop0", HOLDER_BELOW, "vfat", 0, NULL) &&
+	    mount("/dev/zloop0", HOLDER_BELOW, "msdos", 0, NULL))
+		return CHILD_HOLDER;
+	return CHILD_OK;
+}
+
+#define GADGET	"/sys/kernel/config/usb_gadget/g1"
+
+/* The disk usb-storage created for the gadget, by the LUN's inquiry string. */
+static int find_gadget_disk(char *dev, size_t len, int ms)
+{
+	char path[PATH_MAX], model[64];
+	struct dirent *de;
+	DIR *d;
+
+	for (; ms > 0; ms -= 100, usleep(100000)) {
+		d = opendir("/sys/block");
+		if (!d)
+			return -1;
+		while ((de = readdir(d))) {
+			if (strncmp(de->d_name, "sd", 2))
+				continue;
+			snprintf(path, sizeof(path), "/sys/block/%s/device/model", de->d_name);
+			if (read_sysfs(path, model, sizeof(model)) ||
+			    strncmp(model, "File-Stor Gadget", 16))
+				continue;
+			snprintf(dev, len, "/dev/%s", de->d_name);
+			closedir(d);
+			return 0;
+		}
+		closedir(d);
+	}
+	return -1;
+}
+
+/*
+ * A mass storage gadget bound to the dummy UDC, so that this kernel is
+ * also the USB host that sees the LUN as a SCSI disk. sd locks the
+ * medium on open, which is what keeps the LUN's file from being ejected.
+ */
+#define GADGET_STEP(x) do {						\
+	if (x) {							\
+		fprintf(stderr, "gadget: %s failed: %s\n", #x, strerror(errno)); \
+		return CHILD_HOLDER;					\
+	}								\
+} while (0)
+
+static int holder_gadget(void)
+{
+	char dev[PATH_MAX];
+	int fd;
+
+	if (access("/sys/kernel/config", F_OK) ||
+	    (mount("configfs", "/sys/kernel/config", "configfs", 0, NULL) && errno != EBUSY))
+		return CHILD_SKIP;
+	if (access("/sys/kernel/config/usb_gadget", F_OK) ||
+	    access("/sys/class/udc/dummy_udc.0", F_OK))
+		return CHILD_SKIP;
+
+	fd = open(HOLDER_MNT "/lun.img", O_RDWR | O_CREAT | O_EXCL, 0600);
+	if (fd < 0 || write_fat12(fd))
+		return CHILD_HOLDER;
+	close(fd);
+
+	GADGET_STEP(mkdir(GADGET, 0755));
+	GADGET_STEP(write_file(GADGET "/idVendor", "0x1d6b"));
+	GADGET_STEP(write_file(GADGET "/idProduct", "0x0104"));
+	GADGET_STEP(mkdir(GADGET "/strings/0x409", 0755));
+	GADGET_STEP(write_file(GADGET "/strings/0x409/serialnumber", "1"));
+	GADGET_STEP(write_file(GADGET "/strings/0x409/manufacturer", "kselftest"));
+	GADGET_STEP(write_file(GADGET "/strings/0x409/product", "cycle"));
+	GADGET_STEP(mkdir(GADGET "/configs/c.1", 0755));
+	GADGET_STEP(mkdir(GADGET "/configs/c.1/strings/0x409", 0755));
+	GADGET_STEP(write_file(GADGET "/configs/c.1/strings/0x409/configuration", "c"));
+	GADGET_STEP(mkdir(GADGET "/functions/mass_storage.0", 0755));
+	GADGET_STEP(write_file(GADGET "/functions/mass_storage.0/lun.0/removable", "1"));
+	GADGET_STEP(write_file(GADGET "/functions/mass_storage.0/lun.0/file", HOLDER_MNT "/lun.img"));
+	GADGET_STEP(symlink(GADGET "/functions/mass_storage.0", GADGET "/configs/c.1/mass_storage.0"));
+	GADGET_STEP(write_file(GADGET "/UDC", "dummy_udc.0"));
+
+	/* usb-storage waits a second before it scans the device */
+	GADGET_STEP(find_gadget_disk(dev, sizeof(dev), 15000));
+	fd = open_when_there(dev, O_RDONLY, 5000);
+	GADGET_STEP(fd < 0);
+	close(fd);
+	if (mount(dev, HOLDER_BELOW, "vfat", 0, NULL) &&
+	    mount(dev, HOLDER_BELOW, "msdos", 0, NULL))
+		return CHILD_HOLDER;
+	return CHILD_OK;
+}
+
+#define BITMAP_MAGIC	0x6d746962
+
+/*
+ * A RAID1 of one loop device, not persistent, with its bitmap in a file
+ * on P. The bitmap file needs a superblock the kernel accepts; sync_size,
+ * uuid and events are not looked at for a non-persistent array.
+ */
+static int holder_md(void)
+{
+	struct {
+		__u32 magic, version;
+		__u8 uuid[16];
+		__u64 events, events_cleared, sync_size;
+		__u32 state, chunksize, daemon_sleep, write_behind;
+	} bsb = {
+		.magic = BITMAP_MAGIC,
+		.version = 4,
+		.chunksize = 64 * 1024,
+		.daemon_sleep = 5,
+	};
+	mdu_array_info_t info = {
+		.level = 1,
+		.raid_disks = 1,
+		.size = 8 * 1024,		/* KiB */
+		.not_persistent = 1,
+	};
+	mdu_disk_info_t disk = {
+		.major = 7,
+		.state = (1 << MD_DISK_ACTIVE) | (1 << MD_DISK_SYNC),
+	};
+	int fd, mdfd, bfd, n;
+	char buf[4096];
+
+	fd = open("/mnt_dir/img/md.img", O_RDWR | O_CREAT | O_EXCL, 0600);
+	if (fd < 0 || ftruncate(fd, 8 * 1024 * 1024))
+		return CHILD_HOLDER;
+	close(fd);
+	n = loop_attach("/mnt_dir/img/md.img");
+	if (n < 0)
+		return CHILD_HOLDER;
+	disk.minor = n;
+
+	bfd = open(HOLDER_MNT "/bitmap", O_RDWR | O_CREAT | O_EXCL, 0600);
+	if (bfd < 0 || write(bfd, &bsb, sizeof(bsb)) != sizeof(bsb) || ftruncate(bfd, 4096))
+		return CHILD_HOLDER;
+
+	if (read_sysfs("/proc/mdstat", buf, sizeof(buf)) || !strstr(buf, "[raid1]")) {
+		fprintf(stderr, "md: no raid1 personality: %s\n", buf);
+		return CHILD_SKIP;
+	}
+	if (access("/dev/md0", F_OK) && mknod("/dev/md0", S_IFBLK | 0600, makedev(9, 0)))
+		return CHILD_HOLDER;
+	mdfd = open("/dev/md0", O_RDWR);
+	if (mdfd < 0)
+		return CHILD_SKIP;
+	/* the bitmap ops are only installed once a bitmap type is chosen */
+	write_file("/sys/block/md0/md/bitmap_type", "bitmap");
+	/* EBUSY: somebody else's array, leave it alone */
+	if (ioctl(mdfd, SET_ARRAY_INFO, &info))
+		return errno == EBUSY ? CHILD_SKIP : CHILD_HOLDER;
+	if (ioctl(mdfd, ADD_NEW_DISK, &disk))
+		return CHILD_HOLDER;
+	/* attach the bitmap file before the array runs, the way mdadm does */
+	if (ioctl(mdfd, SET_BITMAP_FILE, bfd)) {
+		fprintf(stderr, "md: SET_BITMAP_FILE: %s\n", strerror(errno));
+		return errno == EINVAL ? CHILD_SKIP : CHILD_HOLDER;
+	}
+	close(bfd);	/* the array keeps its own */
+	if (ioctl(mdfd, RUN_ARRAY, NULL)) {
+		fprintf(stderr, "md: RUN_ARRAY: %s\n", strerror(errno));
+		return CHILD_HOLDER;
+	}
+	if (write_fat12(mdfd))
+		return CHILD_HOLDER;
+	close(mdfd);
+	if (mount("/dev/md0", HOLDER_BELOW, "vfat", 0, NULL) &&
+	    mount("/dev/md0", HOLDER_BELOW, "msdos", 0, NULL))
+		return CHILD_HOLDER;
+	return CHILD_OK;
+}
+
+/*
+ * In its own mount namespace the child puts the image on a tmpfs next to
+ * P, mounts P from a loop device, and sets the holder up with its own
+ * filesystem or device mounted at C below P.
+ */
+static int holder_child(int to_parent, int from_parent, enum holder holder)
+{
+	bool fifo = holder == HOLDER_AUTOFS || holder == HOLDER_ZRAM;
+	/* room for a 4 MiB zone file or a floppy image on P */
+	bool big = holder == HOLDER_ZLOOP || holder == HOLDER_GADGET;
+	const char *type = fifo ? "minix" : "vfat";
+	char dev[32], c;
+	int ifd, n, ret;
+
+	if (unshare(CLONE_NEWNS) || mount("", "/", NULL, MS_REC | MS_PRIVATE, NULL))
+		return CHILD_NS;
+	if (mkdir("/mnt_dir/img", 0755) || mount("tmpfs", "/mnt_dir/img", "tmpfs", 0, NULL))
+		return CHILD_NS;
+
+	ifd = open(HOLDER_IMG, O_RDWR | O_CREAT | O_EXCL, 0600);
+	if (ifd < 0 || (fifo ? write_minix(ifd) :
+			big ? write_fat12_4k(ifd, 3072) : write_fat12(ifd)))
+		return CHILD_IMAGE;
+	close(ifd);
+	n = loop_attach(HOLDER_IMG);
+	if (n < 0)
+		return CHILD_LOOP;
+	snprintf(dev, sizeof(dev), "/dev/loop%d", n);
+	if (mkdir(HOLDER_MNT, 0755))
+		return CHILD_MOUNT;
+	if (mount(dev, HOLDER_MNT, type, 0, NULL) &&
+	    (fifo || mount(dev, HOLDER_MNT, "msdos", 0, NULL)))
+		return fifo && errno == ENODEV ? CHILD_SKIP : CHILD_MOUNT;
+	if (mkdir(HOLDER_BELOW, 0755))
+		return CHILD_MOUNT;
+
+	switch (holder) {
+	case HOLDER_AUTOFS:
+		ret = holder_autofs();
+		break;
+	case HOLDER_ZRAM:
+		ret = holder_zram();
+		break;
+	case HOLDER_ECRYPTFS:
+		ret = holder_ecryptfs();
+		break;
+	case HOLDER_BINFMT_MISC:
+		ret = holder_binfmt_misc();
+		break;
+	case HOLDER_FUSE:
+		ret = holder_fuse();
+		break;
+	case HOLDER_ZLOOP:
+		ret = holder_zloop();
+		break;
+	case HOLDER_GADGET:
+		ret = holder_gadget();
+		break;
+	case HOLDER_MD:
+		ret = holder_md();
+		break;
+	default:
+		ret = CHILD_HOLDER;
+	}
+	if (ret != CHILD_OK)
+		return ret;
+
+	if (write(to_parent, &n, sizeof(n)) != sizeof(n))
+		return CHILD_PIPE;
+	if (read(from_parent, &c, 1) != 1)
+		return CHILD_PIPE;
+	return CHILD_OK;
+}
+
+/*
+ * A device keeps its file for as long as it is configured, so once nothing
+ * below the dead mount is left the device has to be told to let go. With
+ * the cycle unbroken C's filesystem still holds the device and every one
+ * of these refuses.
+ */
+static int holder_let_go_once(enum holder holder)
+{
+	int fd, ret;
+
+	switch (holder) {
+	case HOLDER_ZRAM:
+		return write_file("/sys/block/zram0/reset", "1");
+	case HOLDER_ZLOOP:
+		return write_file("/dev/zloop-control", "remove id=0");
+	case HOLDER_GADGET:
+		if (mount("configfs", "/sys/kernel/config", "configfs", 0, NULL) && errno != EBUSY)
+			return -1;
+		/* a zero-length write is a no-op for configfs; a newline ejects */
+		return write_file(GADGET "/functions/mass_storage.0/lun.0/file", "\n");
+	case HOLDER_MD:
+		fd = open("/dev/md0", O_RDONLY);
+		if (fd < 0)
+			return -1;
+		ret = ioctl(fd, STOP_ARRAY);
+		close(fd);
+		return ret;
+	default:
+		return 0;
+	}
+}
+
+/*
+ * The release of C's filesystem may still be in flight when the child is
+ * gone, and a device that is still held refuses to let go, so try for a
+ * while. With the cycle unbroken it refuses for good.
+ */
+static void holder_let_go(enum holder holder)
+{
+	for (int i = 0; i < 50; i++) {
+		if (!holder_let_go_once(holder))
+			return;
+		usleep(100000);
+	}
+}
+
+/*
+ * rmdir of /mnt_dir/p from here, where it is a plain directory, detaches
+ * P in the child's namespace with C connected below it. Once the child is
+ * gone the holder's file on P is the only thing left that refers to P,
+ * and it is dropped only when C's filesystem dies, which waits for P.
+ * The loop device backing P tells whether that resolved.
+ */
+static void holder_cycle(struct __test_metadata *_metadata,
+			 FIXTURE_DATA(loop_cycle) *self, enum holder holder)
+{
+	int to_parent[2], from_parent[2], status, n;
+	pid_t pid;
+
+	ASSERT_EQ(pipe(to_parent), 0);
+	ASSERT_EQ(pipe(from_parent), 0);
+	pid = fork();
+	ASSERT_GE(pid, 0);
+	if (pid == 0) {
+		close(to_parent[0]);
+		close(from_parent[1]);
+		_exit(holder_child(to_parent[1], from_parent[0], holder));
+	}
+	close(to_parent[1]);
+	close(from_parent[0]);
+
+	if (read(to_parent[0], &n, sizeof(n)) != sizeof(n)) {
+		waitpid(pid, &status, 0);
+		if (WIFEXITED(status) && WEXITSTATUS(status) == CHILD_SKIP)
+			SKIP(return, "the kernel lacks what this holder needs");
+		ASSERT_TRUE(false)
+			TH_LOG("child failed to set the holder up: exit status %d",
+			       WIFEXITED(status) ? WEXITSTATUS(status) : -1);
+	}
+	snprintf(self->dev, sizeof(self->dev), "/dev/loop%d", n);
+	snprintf(self->sysfs, sizeof(self->sysfs), "/sys/block/loop%d/loop/backing_file", n);
+
+	ASSERT_EQ(rmdir(HOLDER_MNT), 0);
+	ASSERT_EQ(write(from_parent[1], "x", 1), 1);
+	ASSERT_EQ(waitpid(pid, &status, 0), pid);
+	ASSERT_EQ(WEXITSTATUS(status), CHILD_OK);
+
+	holder_let_go(holder);
+	assert_loop_released(_metadata, self);
+	if (holder == HOLDER_GADGET)
+		write_file(GADGET "/UDC", "\n");
+}
+
+TEST_F(loop_cycle, autofs_pipe_on_dead_mount_released)
+{
+	holder_cycle(_metadata, self, HOLDER_AUTOFS);
+}
+
+TEST_F(loop_cycle, zram_writeback_node_on_dead_mount_released)
+{
+	holder_cycle(_metadata, self, HOLDER_ZRAM);
+}
+
+TEST_F(loop_cycle, ecryptfs_lower_on_dead_mount_released)
+{
+	holder_cycle(_metadata, self, HOLDER_ECRYPTFS);
+}
+
+TEST_F(loop_cycle, binfmt_misc_interpreter_on_dead_mount_released)
+{
+	holder_cycle(_metadata, self, HOLDER_BINFMT_MISC);
+}
+
+TEST_F(loop_cycle, fuse_backing_file_on_dead_mount_released)
+{
+	holder_cycle(_metadata, self, HOLDER_FUSE);
+}
+
+TEST_F(loop_cycle, zloop_zone_files_on_dead_mount_released)
+{
+	holder_cycle(_metadata, self, HOLDER_ZLOOP);
+}
+
+TEST_F(loop_cycle, mass_storage_lun_on_dead_mount_released)
+{
+	holder_cycle(_metadata, self, HOLDER_GADGET);
+}
+
+TEST_F(loop_cycle, md_bitmap_file_on_dead_mount_released)
+{
+	holder_cycle(_metadata, self, HOLDER_MD);
+}
+
 TEST_HARNESS_MAIN

-- 
2.53.0

