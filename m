Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.219.48
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794079199;
	b=PTUT63gTF4auP8WXZcUkEXvK0qvxbIxdOQb2nN2pCVb3VDclFJOBwP62kBFFyOVB1C7Y
	 hAc69drKtFZkX47F70sNpdfRh3FDxkztSX7o9l3v3e1/r5Xdn2QOCQTRASag3MG1EjMuf
	 ahoesK80xRqQS0pG5G9wtoaRVGrhGjY8Be9E/x+ogPYM8Fl/4JZwF5OAD1G9y9FXnviZ6
	 bZYDId8b05W1w9UKaOMwx9igWyKGFtfBk4L56ZsIImmyZirjsWoxngvZKXYhXVR7UzLpR
	 7yzufbACp0j/+FqEIf4Ccvy2nvZCEL8dmxhVNJKy/iIwc+kEXDj22xXbnDm9Vgg8JtA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794079199;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key;
	bh=yyz+TCgoPL1RPM4ciC0T5BUQFlfpuuTjnTjdwz3J2B4=;
	b=QnJXKF8YhDpr96rq6sBOAEpH5vM+c7NR45gNn5bDceK4wdfBng40NJX64jy51oH0xnbx
	 qcIhQsSkZhzDthCUjefx7Fw4zIhcfJiu+XPy+DaLfswnKHKmTzN/wpCnuEvnsWtnROQ0y
	 PWVja37kze4mYT2rR8iXWi9Pl61OG6zIz+JIcoKHNob7Y0CA7cdYzOuyEiLXMYK4S3QE/
	 cZ7iw9rKJ9mDkVMG+Z50K1i0MzCLKOyGbLpiFTHB9vviMaBjxU4Q+dy7AWzJJ0ASaRJgT
	 ENlvHhWbJnzTudPd2Gfo2umWzY+WRjhimPuAxTYJcqbIoCoTgvmiVd9S/Sq0ssuGjow==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=toxicpanda.com;
	spf=pass smtp.mailfrom=toxicpanda.com;
	dkim=pass header.d=toxicpanda.com header.i=@toxicpanda.com header.a=rsa-sha256 header.s=google header.b=jhCXnqXt;
	arc=none smtp.remote-ip=209.85.219.48
Received: from mail-qv1-f48.google.com (mail-qv1-f48.google.com [209.85.219.48])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC6BD606D819
	for <linux-fsdevel@vger.kernel.org>; Sat,  7 Nov 2026 19:19:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DC6BD606D819
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda.com header.i=@toxicpanda.com header.a=rsa-sha256 header.s=google header.b=jhCXnqXt
Received: by mail-qv1-f48.google.com with SMTP id 6a1803df08f44-91ccfb88e4dso19939266d6.0
        for <linux-fsdevel@vger.kernel.org>; Sat, 07 Nov 2026 11:19:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda.com; s=google; t=1794079198; x=1794683998; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=yyz+TCgoPL1RPM4ciC0T5BUQFlfpuuTjnTjdwz3J2B4=;
        b=jhCXnqXtZhNManQzhOa7bUYKsxRSop+m6mAKqX3CTlPMw/6n+c2JU5JU+Ai1GFr03Y
         kHhPZECL8LDMAbXEeOkTbzJdinPCLwZM/1ftLYhk7U7c8Bx3u95Rb5qtlQ5Yj8u1UIHb
         NM1H8ARt9yv0THG1UzcvA0jQior0s6qA2KgcJHZCC+Aa6ch4c3LRxBKDCIOCcwBBjr6Y
         scgIH56KUiC/a24YXf9ZiuuaPoDdsSNDj2pg817FMMX2ZjO5cv+6T+t7gqdsD1PTgJQm
         t1cywZDmtCKVGEx4pz1ypp1Bdif7UT1E4M96U5Eap8cwa6N8jZ29eXcHNOsrbNSCjYyC
         iOow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794079198; x=1794683998;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=yyz+TCgoPL1RPM4ciC0T5BUQFlfpuuTjnTjdwz3J2B4=;
        b=zg8025y+bXhdIt1Zi0IPQur57hsHl/bc7CIPEpoNbyVuv8DsJ+mk4UPDWWblhcGDJP
         kUUj3eSDe3peJP7z3988dmcsSkAuFDedsxLAPNXmFbwACVGR3qLLzWgVmNqTeXy2F+eR
         bjtJf9U9f0L4gxEOECoBg3lZIoPnU7BBr+NKWcxDWEYkQCUjRy5yIPY7t9scSCqq+o44
         35Fe+XNfM+qzhzXq3WyEoUC1WYzwGIYrZEM5UzyW7waCQ/YgM+JUQR/33CmenxgqUXbS
         uunYAm8VUSkKKORGwUyqJNNND6CfeKmORjLwp2M7hH4zObQ3FlfObxh9twwd2oV6GbTW
         HrYg==
X-Forwarded-Encrypted: i=1; AL+hErGL+8/NN44OR2GACWgFUUf6dLlQ2mltqyy/7H+JcoIN1biKCfFpbRKk/s0XtNifFQE5XOuPZHHzn/5HmHGi@vger.kernel.org
X-Gm-Message-State: APuU4Z+ijp02tMIRTqJOzsv7AyWxf7XONousK1jWJFOtCoAKjWa14Eqd
	HVEBWNUSQFEpH3oLgu4FSYTPo5+Vdu5RLuRS9LY4XxKEvtpJGMvsFYMuJ8/xjLLQgdU=
X-Gm-Gg: AYBFou1T7kyHhA60Jz4tWfT/8Y/ow4Zj6GxyHCO5cYgTWEpnXetZh5de+jqUz+DVGei
	JYpIksdqVLb76I0Zc7dkMNd1lqNZaxiE4+OVmvHcucPo/882kzVuvE++0dIzPBDOpxH1MFtSoAw
	sNz4JWNNNscNtD9c75Saf3TONilRaCFodXboqYjlVfYuTgjROKuLBx6/cYwqIaP1ApP1OUKLwQ9
	WiTMBl9JBEdYqcugAMeob1TX5C3M/FIwCTKQGwBZJ0YIo8y39BsNwQJoGKePymVT+jX7rFw5cCK
	Nxc6YSfA0t2Z/7jxe2BJ7KRuk3nb8WTOHiAtlvqXq5Im+gSAeoRcheq3hSpQ35HLTp+SFMPZr9b
	tOFHcHy36yBRy3JCCnP0UHthVJ/IWi2ShkgMXfg4dVKNjp7bAfQbyv7OGFbSYYW++fa4Aav2jyJ
	wgBKSvN+SRZnI5pg/6XwVBW+RWt+qgCUW28APH/a9vhZnV0L2+8XvWnHvP+6xOn3HJ/mePThVEI
	S6luvTHK05PlMcDE8nMBvnvSiWbgMgW9dzl++CpPb6+a7M/vONqbf29sDfY8zaG6lrrEfI4Vrhw
	wD3xS5kbOgAWl1scpaQhnEgo8LuG7Uk97MX8RP3jbQfR75c=
X-Received: by 2002:a05:6214:4302:b0:91e:81a3:d440 with SMTP id 6a1803df08f44-91ea96207b0mr83428466d6.16.1794079197856;
        Sat, 07 Nov 2026 11:19:57 -0800 (PST)
Received: from toxicpanda.com ([153.61.196.252])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91eceb56c90sm703446d6.3.2026.11.07.11.19.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Nov 2026 11:19:57 -0800 (PST)
From: Josef Bacik <josef@toxicpanda.com>
Date: Sat, 07 Nov 2026 19:19:37 +0000
Subject: [PATCH v5 8/8] ovl: implement containerized syncfs for overlayfs
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
Message-Id: <20261107-b4-ovl-containerized-sync-v5-8-d34b4ae57fdf@toxicpanda.com>
References: <20261107-b4-ovl-containerized-sync-v5-0-d34b4ae57fdf@toxicpanda.com>
In-Reply-To: <20261107-b4-ovl-containerized-sync-v5-0-d34b4ae57fdf@toxicpanda.com>
To: Miklos Szeredi <miklos@szeredi.hu>, Amir Goldstein <amir73il@gmail.com>, 
 Christian Brauner <brauner@kernel.org>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
 Christoph Hellwig <hch@infradead.org>, Chris Mason <mason@kernel.org>, 
 Chengguang Xu <cgxu519@mykernel.net>, linux-unionfs@vger.kernel.org, 
 linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Chengguang Xu <charliecgxu@tencent.com>, Josef Bacik <josef@toxicpanda.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openssh-sha256; t=1794079181; l=4798;
 i=josef@toxicpanda.com; h=from:subject:message-id;
 bh=Mk4AG64uyCvjs4ynhnVlu/B/QEf+yciM4nDTzhGVnWc=;
 b=U1NIU0lHAAAAAQAAADMAAAALc3NoLWVkMjU1MTkAAAAgUBr36M/n0nWN0DNbnxwzIiCZez6MG
 JiruuNaSCI/zXsAAAAGcGF0YXR0AAAAAAAAAAZzaGE1MTIAAABTAAAAC3NzaC1lZDI1NTE5AAAA
 QNA5+8X0bIazjZwZW6M8RCBna/Vn2OUFAkR9UTevs/wu3GMie+PUgjx0lBBrfk+MhzafNWCor4e
 eiTTkZRplPwg=
X-Developer-Key: i=josef@toxicpanda.com; a=openssh;
 fpr=SHA256:C8kOX2QUJCMqnCX+KEeoqRAjLo9L+ELOSH2NSAJHqGA

From: Chengguang Xu <charliecgxu@tencent.com>

Now overlayfs can only sync own dirty inodes during syncfs,
so remove unnecessary sync_filesystem() on upper file system.

Do that with fsync=relaxed only.  Call sync_fs_and_bdev() on the upper
filesystem instead, which is what sync_filesystem() does after it has
written the inodes.  Do the same for a read-only remount.

The root inode of an overlay is not hashed and cannot be on a dirty list,
so write its upper inode every time.

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
 fs/overlayfs/params.c                   | 14 +++----------
 fs/overlayfs/super.c                    | 36 +++++++++++++++++++++++++--------
 3 files changed, 32 insertions(+), 20 deletions(-)

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
index f38c6dd2ae47..72f5d81aff6a 100644
--- a/fs/overlayfs/super.c
+++ b/fs/overlayfs/super.c
@@ -270,18 +270,38 @@ static int ovl_sync_fs(struct super_block *sb, int wait)
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
+	 *
+	 * The root inode is not hashed, so it is never on the dirty list.
+	 * Write its upper inode every time.  sb->s_root is gone during an
+	 * unmount.  An error ends up in s_wb_err, like for any other inode.
+	 */
+	ovl_write_upper_inode(sb, d_inode(ovl_upper_mnt(ofs)->mnt_root),
+			      wait ? OVL_WRITE_WAIT : OVL_WRITE_START);
+
 	down_read(&upper_sb->s_umount);
-	ret = sync_filesystem(upper_sb);
+	ret = sync_fs_and_bdev(upper_sb, wait);
 	up_read(&upper_sb->s_umount);
 
 	return ret;

-- 
2.55.0

