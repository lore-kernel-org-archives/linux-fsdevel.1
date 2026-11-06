Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.219.41
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793972243;
	b=S8v/UXtCZT9ywejyfJSzINLLynSx0r3iN0GqCSbU03YSmN70zfCtylIfqjj+FQL8cyKI
	 jkXsYDRtyPcZ3IyPXHtpmURZPh/yx4gWtqxcW36TQFch3D1iUV/oq5eyjg5wwlqzLXUA6
	 CwFXdH021rrSdZahT+GM2JvUK+oK+eUgZdmwWfyfjgYjiXt2I96KyF9EdwyE9RISAjbC1
	 goXs8OQ/7invHGtrVyZoJqKLRRq+grOvrU1ur4e85bi/4CTShlZtaAT+NMM6fMSZEBaXH
	 eO+5L7UPxExClU5PN8r6Bs9I5ayg1nmFc1BN7DyrWxvJvvS93Nshc0qo8YjQvoJjgJg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793972243;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key;
	bh=T+TZK3doCaBYXj2sLfttSL9vgjeHuDd0u+6ujH6XdcQ=;
	b=s7pkQpye+caJwtZENGrouirt1khpBMCVR1IYJxaExEz9plE+jb3zp2or/Lv3TdJg7XJI
	 cs4psd3p/gYarBliyINOGjDLrTK92xGDAYW3IObk5R1h2i3MXzu+WJpTDeKN3IEB0OqA7
	 adnzbK9WuQN0iJNo+U7lk978/n2krj8dYHppIIu98JndMJvWjZMlxd5/IFOonZzHFsNDi
	 qkUaKWSfCEnEjpSmh96kE7jlUcAUua+nPMojxl54GjsScK44/MB1JA3usoKd6bPnA6onQ
	 xiBLh95F+42JczdbO7BzNXnc5tMNAnHbzEpCDv0jJ1ahTYqjtnOnLkrEvF4gbe4N0KQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=toxicpanda.com;
	spf=pass smtp.mailfrom=toxicpanda.com;
	dkim=pass header.d=toxicpanda.com header.i=@toxicpanda.com header.a=rsa-sha256 header.s=google header.b=LhrIStQp;
	arc=none smtp.remote-ip=209.85.219.41
Received: from mail-qv1-f41.google.com (mail-qv1-f41.google.com [209.85.219.41])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23C7A606D80D
	for <linux-fsdevel@vger.kernel.org>; Fri,  6 Nov 2026 13:37:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 23C7A606D80D
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=toxicpanda.com header.i=@toxicpanda.com header.a=rsa-sha256 header.s=google header.b=LhrIStQp
Received: by mail-qv1-f41.google.com with SMTP id 6a1803df08f44-91eb53957cbso2239306d6.3
        for <linux-fsdevel@vger.kernel.org>; Fri, 06 Nov 2026 05:37:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda.com; s=google; t=1793972231; x=1794577031; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=T+TZK3doCaBYXj2sLfttSL9vgjeHuDd0u+6ujH6XdcQ=;
        b=LhrIStQpI81jKPXexsLbiQf+Fr/HRsjNvPzSdsjgHmiI1jWS4jQ8b9XVUXQkZ4w6iz
         wrFtW+RZpZQ4PH3EYehTLvYkFnXpu6QbPkg9VADz1lpeDqwEdvsDK6AXV7Brrd1NUOOB
         v+vP7hcIhxU9K5TSfIaGT3mZlBjFi/njyMoxYPcG7z66si5fkifXK7ghMWkmT367J5yp
         NIsJ1d71lhlk092qEd2XV4OCYmoeY7Kpln9wriX0M7ROjCmLs94P+5vCG9jzCwmDqqXc
         i34nAV3OPcyiUyyOtNSQaQnoo1ymghTnAU3Oh1mVESXWhDChtRKWB3Irxv/QxiqTUY6m
         qklw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793972231; x=1794577031;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=T+TZK3doCaBYXj2sLfttSL9vgjeHuDd0u+6ujH6XdcQ=;
        b=mTPknWCUWTAnZYmybZx9jehUmnPx3Kq3bt7mFxnV0QphYSJghDQNFZySlbCYzkiO/n
         HQarJEG5RK2zWwZVj6pD4GYd8gCEhhe3iGAv8VhsuR23p8QBQ+vm1m6M2D9VPyNMaYoa
         nDTB+C2fya2zEhWlZgHoxuwYHqLgPDN3R20al88BojnYB2cvMYte8PB0uhwR7QC7IAxW
         KC54t+5hwlB60OMKvlUlEHOt4jrBiQMCJvvtcqa4mS4D7NMOYoDWpiMQdPMWfaHXCxCm
         FpDd/ZMu7rRkPRAWGZe9+DKFjacu0EYsBTEBPaUxpU3MMzEBg1xObn0Svd9ubdDXTzQ+
         KZuw==
X-Forwarded-Encrypted: i=1; AL+hErGEINy0Ie2oFCSRHRR76WEY25pC70c0mmZbtedWGISGa6NGBfm8yEDGeBtrP8ipP6ZAz0to/O3jo8HzYB5d@vger.kernel.org
X-Gm-Message-State: APuU4Z+bOwgn1taWvz0J1j4z8gElq5Ux9X0O2+T/2b/Lnd270QTKijPV
	rw1MZH4AdARTRiwSQ4lNPev5rYr9icKQ6BD318SIRhWKnwosVrv5fyBbNi7LKBZlLAo=
X-Gm-Gg: AYBFou2lIzxmqhAt8S/WtY7GoCH327Tv8kpYbo5OPl98Nd7Q7JUTPKgMG1+bfSY7roy
	klAAhxHOeR1Qmw4XgvGb5dYOl3XCz/csfet+vOUXsr0b/Gydk+G4bYzmjbFV8Itf0sOmBGzc1+z
	Cc7s7Uwc692H9+H7uILa9a7M4C9JgKWlpyhn7tYg7fcwvhhR9UPlWPKJHg4cGgyefVs4Tybcp9K
	IYiZamb1y/EcrWRz+2B01VESRr51wkVeZsdWawlFjdxmNgAgGi480AtswC6+exabOagkDHNhG0R
	H3RaBx9SVJO90QEuMq8iNFra3AVw9SRwsrUGgoV1D+j7fFHILfFvtC4efhVjfBFjcFLjliZH4L/
	Ra03CcjRDKrVpPeWs9hce8/jPBNihwdlEAS+yVE9WpKnxilOMPEUc/3jjps7ShVCvSg35pwgFEZ
	elznDOQJ6wAD8+tBfQD6tVRC238JSRc/jFSviihVDZsZE3NleChGGLfSK6a286xSSaJu7iMn1VM
	dYmM+Skf5lwZVi7wqMm9Cx8pon6xlh+1nCMwow5ieG7yTT/aukeUeGmiBjAUv9A1rKooP829ohl
	Zt4Km60jLKyb6VVmiSJ74jdE5Jczwz8iHvNEhxptbHHJIvSlVdAcAvXqNX8B43bbieM=
X-Received: by 2002:ad4:5747:0:b0:91e:9a4e:8d5 with SMTP id 6a1803df08f44-91ea9656c55mr33820846d6.22.1793972230897;
        Fri, 06 Nov 2026 05:37:10 -0800 (PST)
Received: from toxicpanda.com ([153.61.196.253])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91ea6acebb0sm20331706d6.45.2026.11.06.05.37.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Nov 2026 05:37:10 -0800 (PST)
From: Josef Bacik <josef@toxicpanda.com>
Date: Fri, 06 Nov 2026 13:36:50 +0000
Subject: [PATCH v4 8/8] ovl: implement containerized syncfs for overlayfs
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261106-b4-ovl-containerized-sync-v4-8-6ddde0b7dd8a@toxicpanda.com>
References: <20261106-b4-ovl-containerized-sync-v4-0-6ddde0b7dd8a@toxicpanda.com>
In-Reply-To: <20261106-b4-ovl-containerized-sync-v4-0-6ddde0b7dd8a@toxicpanda.com>
To: Miklos Szeredi <miklos@szeredi.hu>, Amir Goldstein <amir73il@gmail.com>, 
 Christian Brauner <brauner@kernel.org>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
 Christoph Hellwig <hch@infradead.org>, Chris Mason <mason@kernel.org>, 
 Chengguang Xu <cgxu519@mykernel.net>, linux-unionfs@vger.kernel.org, 
 linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Chengguang Xu <charliecgxu@tencent.com>, Josef Bacik <josef@toxicpanda.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openssh-sha256; t=1793972217; l=4908;
 i=josef@toxicpanda.com; h=from:subject:message-id;
 bh=ShoZ3R3MxC3sYDTcalzCqLuyMKorjbXwVRDmd2jMSfw=;
 b=U1NIU0lHAAAAAQAAADMAAAALc3NoLWVkMjU1MTkAAAAgUBr36M/n0nWN0DNbnxwzIiCZez6MG
 JiruuNaSCI/zXsAAAAGcGF0YXR0AAAAAAAAAAZzaGE1MTIAAABTAAAAC3NzaC1lZDI1NTE5AAAA
 QG+ioD038uFbqNV0Ub+6sxgimiEGwuYUmqPKac/lR0IRMeRxTFfv88GCxVFZSsDKyWWPDaUrche
 jEyWcDfxuSQc=
X-Developer-Key: i=josef@toxicpanda.com; a=openssh;
 fpr=SHA256:C8kOX2QUJCMqnCX+KEeoqRAjLo9L+ELOSH2NSAJHqGA

From: Chengguang Xu <charliecgxu@tencent.com>

Now overlayfs can only sync own dirty inodes during syncfs,
so remove unnecessary sync_filesystem() on upper file system.

Do that with fsync=relaxed only.  Call ->sync_fs() and write the block
device of the upper filesystem instead, which is what sync_filesystem()
does after it has written the inodes.  Do the same for a read-only
remount.

Upper inodes that have no overlay inode, like whiteouts and the work
directories, are not tracked.  It is up to ->sync_fs() and the block device
to get them to disk.  ext4, xfs and btrfs log all metadata, and ext4
without a journal keeps it in the buffers of the block device.

With many containers on one upper filesystem, stopping one of them no
longer writes out the dirty data of all the others.

Signed-off-by: Chengguang Xu <charliecgxu@tencent.com>
[josef: everything after the first paragraph, no wait_sb_inodes() on the
 upper filesystem]
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 Documentation/filesystems/overlayfs.rst |  2 +-
 fs/overlayfs/params.c                   | 14 +++--------
 fs/overlayfs/super.c                    | 41 ++++++++++++++++++++++++++-------
 3 files changed, 37 insertions(+), 20 deletions(-)

diff --git a/Documentation/filesystems/overlayfs.rst b/Documentation/filesystems/overlayfs.rst
index 1a59500834a1..34fc4e6f8a84 100644
--- a/Documentation/filesystems/overlayfs.rst
+++ b/Documentation/filesystems/overlayfs.rst
@@ -830,7 +830,7 @@ Traditionally, syncfs(2) and unmount of an overlay sync the entire upper
 filesystem, including the dirty data of other overlays that share it.
 Overlayfs can be told to only write back the files that were modified
 through the overlay, and then ask the upper filesystem to commit its
-metadata.
+metadata and write its block device.
 
 On traditional local filesystems with a single journal (e.g. ext4, xfs),
 fsync on a file also persists the parent directory changes, because they
diff --git a/fs/overlayfs/params.c b/fs/overlayfs/params.c
index 549fc1e83ac9..6de99e79eb6b 100644
--- a/fs/overlayfs/params.c
+++ b/fs/overlayfs/params.c
@@ -774,22 +774,14 @@ static int ovl_reconfigure(struct fs_context *fc)
 {
 	struct super_block *sb = fc->root->d_sb;
 	struct ovl_fs *ofs = OVL_FS(sb);
-	struct super_block *upper_sb;
-	int ret = 0;
 
 	if (!(fc->sb_flags & SB_RDONLY) && ovl_force_readonly(ofs))
 		return -EROFS;
 
-	if (fc->sb_flags & SB_RDONLY && !sb_rdonly(sb)) {
-		upper_sb = ovl_upper_mnt(ofs)->mnt_sb;
-		if (ovl_should_sync(ofs)) {
-			down_read(&upper_sb->s_umount);
-			ret = sync_filesystem(upper_sb);
-			up_read(&upper_sb->s_umount);
-		}
-	}
+	if (fc->sb_flags & SB_RDONLY && !sb_rdonly(sb) && ovl_should_sync(ofs))
+		return sync_filesystem(sb);
 
-	return ret;
+	return 0;
 }
 
 static const struct fs_context_operations ovl_context_ops = {
diff --git a/fs/overlayfs/super.c b/fs/overlayfs/super.c
index 27e30d0ace80..7e1703814a56 100644
--- a/fs/overlayfs/super.c
+++ b/fs/overlayfs/super.c
@@ -15,6 +15,7 @@
 #include <linux/seq_file.h>
 #include <linux/posix_acl_xattr.h>
 #include <linux/exportfs.h>
+#include <linux/blkdev.h>
 #include <linux/pagemap.h>
 #include <linux/writeback.h>
 #include <linux/backing-dev.h>
@@ -270,18 +271,42 @@ static int ovl_sync_fs(struct super_block *sb, int wait)
 	/*
 	 * Not called for sync(2) call or an emergency sync (SB_I_SKIP_SYNC).
 	 * All the super blocks will be iterated, including upper_sb.
-	 *
-	 * If this is a syncfs(2) call, then we do need to call
-	 * sync_filesystem() on upper_sb, but enough if we do it when being
-	 * called with wait == 1.
 	 */
-	if (!wait)
-		return 0;
-
 	upper_sb = ovl_upper_mnt(ofs)->mnt_sb;
 
+	if (ovl_should_sync_upper_fs(ofs)) {
+		/* Enough if we do it when being called with wait == 1 */
+		if (!wait)
+			return 0;
+
+		down_read(&upper_sb->s_umount);
+		ret = sync_filesystem(upper_sb);
+		up_read(&upper_sb->s_umount);
+
+		return ret;
+	}
+
+	/*
+	 * sync_filesystem() has already written the dirty inodes of this
+	 * overlay through ovl_write_inode().  What is left are the last two
+	 * steps of sync_filesystem() on the upper filesystem.  They have to
+	 * take care of the upper inodes that have no overlay inode, like
+	 * whiteouts and the work directories.  Do not write the inodes that
+	 * others have dirtied on the upper filesystem.
+	 */
 	down_read(&upper_sb->s_umount);
-	ret = sync_filesystem(upper_sb);
+	/* Like sync_filesystem(), do not call ->sync_fs() on a read-only sb */
+	ret = 0;
+	if (sb_rdonly(upper_sb))
+		goto out;
+
+	if (upper_sb->s_op->sync_fs)
+		ret = upper_sb->s_op->sync_fs(upper_sb, wait);
+	if (!ret && wait)
+		ret = sync_blockdev(upper_sb->s_bdev);
+	else if (!ret)
+		ret = sync_blockdev_nowait(upper_sb->s_bdev);
+out:
 	up_read(&upper_sb->s_umount);
 
 	return ret;

-- 
2.55.0

