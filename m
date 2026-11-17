Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=79.135.106.116
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794898409;
	b=ycaeS3F7u+ePp7c+Bsuiii0hUKe3xuZTuFX/ITXrBhESB4HJMpNCIgmm8Crj5Z7UknlE
	 HQb6/1AM8WP9tFjsMUXewxQfv06tZh2NaJ9B/at7NnPwP9TllDduFuFaERJWI6WgKGS1r
	 1PY1wPLfYhHnNMulU3KLxVyKNg20IIDp9W00RTZ0w3To1SrZdVFk0LHNufoSy70MlTB7G
	 6KAyydLKYUzlYpq+lXap4BAJ8DB7GAI7zkcWxmaIV478ZZgc26yV9f19fymqc3S965Lx3
	 odSG926euuYwrIYVjHBO4qHIK7lf1BlNPlrMdn3+4YmU6qEV9PjTrmHneH/qKpv9wmQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794898409;
	h=DMARC-Filter:DKIM-Signature:Date:To:From:Cc:Subject:Message-ID:
	 Feedback-ID:X-Pm-Message-ID:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=fhlZwPb+EKUD7sj5PQfE0XLq0EUa+AdbiHlHBWb3So4=;
	b=XdOkdK35J/duYJlc3R69I4dKUpusfz2C0oNy4GQIeq/g/c4irqOma1BHLXXsmwTHoVmY
	 KJ+lvN6B0ChYBccvdUzuUGWle6pW7A2pIo9I9Hj+cz4WluUqY+amFUalGPLHVUfNsL+6a
	 2WKbgNoeDLfeQ3xK1tdKfuthYKh8v9ucT6A6KcJUucFj8397QesVXj8Ur3CuctVBSZKhT
	 HpKMDbv3Cuvoi+M/0D8oRfelfc3qVekb51rUzy8GEnbfHymvH3UvMWi1SWixY8VqSH5St
	 dEYWK7Kzd+M2eWqL7Sgo8Lu1d0GKQS2MoEHGtqD1ydt8I1wBIAMmkFz9ig9hzpuXo7w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=logarcheon.com;
	spf=pass smtp.mailfrom=logarcheon.com;
	dkim=pass header.d=logarcheon.com header.i=@logarcheon.com header.a=rsa-sha256 header.s=protonmail3 header.b=QIrwGm6C;
	arc=none smtp.remote-ip=79.135.106.116
Received: from mail-106116.protonmail.ch (mail-106116.protonmail.ch [79.135.106.116])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B8D2606A31C;
	Tue, 17 Nov 2026 06:53:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4B8D2606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=logarcheon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=logarcheon.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=logarcheon.com header.i=@logarcheon.com header.a=rsa-sha256 header.s=protonmail3 header.b=QIrwGm6C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=logarcheon.com;
	s=protonmail3; t=1794898405; x=1795157605;
	bh=fhlZwPb+EKUD7sj5PQfE0XLq0EUa+AdbiHlHBWb3So4=;
	h=Date:To:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
	 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=QIrwGm6CIIIFNJfkg2STl1TMDfBlRQaNd8eeDi2SPqw/1csxvAH8hby+B2Hfrdf7b
	 eTdeDHUbrkwZlKHgV7CEDI4DHE8D9hcS2rQOoT76rG/uMLCS1kEfV3XS2y5fi/aFhM
	 TX7/7mkzExz/+sjn6bpN1CDFtlx3hV3n/pzqMysXTXPphSeN0MRVuVDq/Phu9KAdy7
	 VP2EMpGAMvKb2lXQ0GFHqKwjmGGT7yc74Ki0Akpmhuigy+jNcaQYH052GtwiuR4bqi
	 DBL7zZDsxRTUPlTH7Mp2V0mtj7ZGcLumfcFlEwsKjG2Yuff46d6ZcMC8F3slOZ/B3D
	 208N8blbBfVVw==
Date: Tue, 17 Nov 2026 06:53:20 +0000
To: Breno Leitao <leitao@debian.org>
From: William Chuang <founder@logarcheon.com>
Cc: Andreas Hindborg <a.hindborg@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-usb@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, syzbot+c75a7db5ca6ae96ed2d4@syzkaller.appspotmail.com, syzkaller-bugs@googlegroups.com
Subject: [PATCH] configfs: give the root directory inode its own lockdep class
Message-ID: <20261117065314.4309-1-founder@logarcheon.com>
Feedback-ID: 145408520:user:proton
X-Pm-Message-ID: d7fbabea252888f9d3327da5a014fea2d1d7cdd6
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Directories created with mkdir(2) and the configfs root directory share
the default i_rwsem lock class of configfs; only default groups get
their own depth-based classes in configfs_set_inode_lock_class().
Lockdep therefore treats the root inode's lock and the lock of any
user-created directory as the same lock.

That produces a false circular dependency between the USB gadget and
target subsystems, which syzbot keeps reporting:

  (3) tpg_instances_lock -> configfs i_rwsem
       usbg_make_tpg() calls configfs_depend_item_unlocked(), which
       locks the configfs root inode for a target in another subsystem
  (2) func_lock -> tpg_instances_lock     (tcm_alloc_inst)
  (1) gadget_subsys.su_mutex -> func_lock (configfs_mkdir, function_make)
  (0) configfs i_rwsem -> gadget_subsys.su_mutex
       configfs_symlink() runs with the parent directory locked, and
       uvcg_streaming_header_allow_link() takes su_mutex

The inode in (0) is a directory under the gadget subsystem; the inode in
(3) is the configfs root.  A real deadlock would need something to take
a subsystem su_mutex while holding the root inode's lock, and nothing
does:

 - the root has only ->lookup and ->setattr, so mkdir, rmdir, symlink,
   unlink and rename in the root fail in the VFS before configfs runs;
 - configfs_lookup(), configfs_setattr(), configfs_readdir(),
   configfs_dir_open() and configfs_dir_close() take no subsystem lock;
 - configfs_register_subsystem(), configfs_unregister_subsystem(),
   configfs_depend_item() and configfs_depend_item_unlocked() lock the
   root but take no su_mutex while holding it.

Give the root inode its own class so that lockdep keeps the two apart.
This changes nothing without CONFIG_LOCKDEP.

Tested in QEMU (x86_64, PROVE_LOCKING) at 666539eec with an initramfs
that runs the three operations above (a UVC streaming header symlink,
mkdir functions/tcm.0, mkdir target/usb_gadget/naa.*/tpgt_1), then
readdir, chmod and mkdir on the configfs root, and tears everything
down again.  Without this patch lockdep reports the cycle above; with
it there is no report and every step gives the same result.

With the patch, the configfs kselftest passes (25/25, including its
symlink-versus-rmdir race test) with no lockdep report, as it does
without it.  Three processes looping for 60 seconds over tpgt_1
mkdir/rmdir (which locks the configfs root through
configfs_depend_item_unlocked()), the UVC symlink/unlink, and readdir
plus chmod of the configfs root never stalled, with or without the
patch; without it, lockdep reports the cycle during that run.  Without
CONFIG_LOCKDEP the patch changes no code: fs/configfs/mount.o
disassembles identically before and after.  It builds cleanly with
W=3D1.  Not tested: syzbot's own C reproducer.

Fixes: 4bb8548df632 ("usb: gadget: f_tcm: add configfs support")
Reported-by: syzbot+c75a7db5ca6ae96ed2d4@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=3Dc75a7db5ca6ae96ed2d4
Signed-off-by: William Chuang <founder@logarcheon.com>
---
 fs/configfs/mount.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/fs/configfs/mount.c b/fs/configfs/mount.c
index d8cac1cbf..d20d2fd1e 100644
--- a/fs/configfs/mount.c
+++ b/fs/configfs/mount.c
@@ -58,6 +58,15 @@ static struct configfs_dirent configfs_root =3D {
 =09.s_iattr=09=3D NULL,
 };
=20
+/*
+ * configfs_depend_item_unlocked() takes the root inode's lock while a
+ * subsystem's own locks may be held, but nothing takes a subsystem lock
+ * while holding the root inode's lock.  Directories created by mkdir(2)
+ * share the default i_rwsem class and are locked before their subsystem's
+ * su_mutex, so give the root inode a class of its own.
+ */
+static struct lock_class_key configfs_root_inode_class;
+
 static int configfs_fill_super(struct super_block *sb, struct fs_context *=
fc)
 {
 =09struct inode *inode;
@@ -74,6 +83,7 @@ static int configfs_fill_super(struct super_block *sb, st=
ruct fs_context *fc)
 =09if (inode) {
 =09=09inode->i_op =3D &configfs_root_inode_operations;
 =09=09inode->i_fop =3D &configfs_dir_operations;
+=09=09lockdep_set_class(&inode->i_rwsem, &configfs_root_inode_class);
 =09=09/* directory inodes start off with i_nlink =3D=3D 2 (for "." entry) =
*/
 =09=09inc_nlink(inode);
 =09} else {
--=20
2.43.0


