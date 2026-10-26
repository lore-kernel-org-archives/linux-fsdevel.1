Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793023267;
	b=mMZIsOY0+5ZLqfCP+HhHarpn/w3OURviIj0GPkzjqrhHz6tDCtKSn1HLx+8WE1SMBHMu
	 ZWL98IkJHqe9bIbE0HB1B8YBlqgudu60JewjZ7hssYnMa5qnAD3xpTVc5rxYSKlKCGaXk
	 FTPeiSHuWdc96ueHkwyza5vqGXHNjlHcmj6PZWedJgjW75zIQakddwwcEh9IlAgONTjdY
	 OtFudcJdyrgELfJwYNwAwMb/ChX91arQH+1MedethWnTe8UFBZZzPAwKUzgTanOed1exw
	 AdfiegTW45ZeSVKcE6uEbcnTBY7+2wjmqH5pfkWg7ojvw4RkEeGauVRJOHhiU2dyl5A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793023267;
	h=Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=Qd8SckGcNFT3VY4u1R7h7MaYbTFN08zspInLBXA+4hA=;
	b=tvGeVST7RHYG3dLD73hVcOqeacFqs+qR1E8L3NA4m/RR8PI75qQ1TTqusVAjS+ncbW9h
	 +nkpnsmE+1hxiU2w2B0Qn0ztUwZXPhXtNNuAV3aMZsyGYlsLOMWFEWuLGNHhg9FXGN11r
	 ErNQqkclKrD82tXi6/uNZ3LRkO6C2GK3IEE8aRiaLkh7h00jy0xefpUYPaVW30g6idngC
	 yJ21nlarhdKXXgBF1sFnMjjAcJJ4IeRqKkY1Et079xELH0m7XsFyaItMrOazVXJeR8rwM
	 /lffbvBCOm4dpBeMiYwtnkv6HYKJiSHkqWO4YU6mRWKNyrnVPVdDIKGRvY03qXI+qNg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=PPFYYjsc;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E02C606A31A
	for <linux-fsdevel@vger.kernel.org>; Mon, 26 Oct 2026 14:01:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=PPFYYjsc
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 572901F01825;
	Mon, 26 Oct 2026 14:01:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793023266;
	bh=Qd8SckGcNFT3VY4u1R7h7MaYbTFN08zspInLBXA+4hA=;
	h=From:Date:Subject:To:Cc;
	b=PPFYYjsc4WpJyxWJl2Ygbi/9Gc0WuQRf0w+j9HJMLXfADo+66Aekh5qqPRJzeiLz3
	 jq+qJqOGDw7QoCjZGZFL4s8hu91M2mWn5Th+yloMRuSeDgOQEKNtfo9zjKTH0Z5mOP
	 H7GYrEx9oNyjGcf6b+R8KiRMpSTv8eZFnKhK0JX3vI1EsOCMhEsD1qNXqOBtbj9AkK
	 1NIzhbwVYhCrRSGIN7UBYxMcfagINbQgXjNSB9p2ggXuxCaji56RS4oAE1YGFr22pH
	 tBLXGhSQlAKBbBPDLM4/f1It9qFBao/PcmmX7Cd6FMFgUpQKrBQMH6grOEi5GhVX5v
	 BktyeX7heqEeA==
From: Christian Brauner <brauner@kernel.org>
Date: Mon, 26 Oct 2026 15:00:42 +0100
Subject: [PATCH] libfs: hold one mount reference for all pins
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
Message-Id: <20261026-work-libfs-pin_fs-v1-1-99ef52ee10a3@kernel.org>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yWM0QrCMAxFf2Xk2ZauyJj+ioi0NXNR6UaibjD27
 zbbwyWccO9ZQJAJBc7VAow/EhpygfpQQepDfqChe2Hwzjd1iZkGfpk3xU7MSPlWToupPWJq3Ml
 5KLuRsaN5c16uO8s3PjF9VKSNGARN5JBTry9V2k1pd6XVAqzrH/yAy4+eAAAA
X-Change-ID: 20261026-work-libfs-pin_fs-8ec84ec60902
To: linux-fsdevel@vger.kernel.org
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
 kernel test robot <yi1.lai@intel.com>, 
 "Christian Brauner (Amutable)" <brauner@kernel.org>
X-Mailer: b4 0.17-dev-ce4c1
X-Developer-Signature: v=1; a=openpgp-sha256; l=2475; i=brauner@kernel.org;
 h=from:subject:message-id; bh=w0471I/h64gQOkhqKMZh/t7tHutdsGqwS0dOZguuUq0=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWTdj5XLzLq7fMeDYPajbz5WtroltoTs5mUxr5D7NdnKR
 C+WfatbRykLgxgXg6yYIotDu0m43HKeis1GmRowc1iZQIYwcHEKwESYPBgZll8WOOEkFjRFLFVn
 0aInkte76m7+nLxHjTMvMeHEndwtIQx/eBbVbE7S/FyxraJv8jvbb8ktLTs3XlWVdrZL0ZV1mMb
 MBQA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

simple_pin_fs() takes a reference on the internal mount for every pin
and simple_release_fs() drops it again. So every debugfs, tracefs,
securityfs, configfs, apparmorfs, drm and vfio file that is created and
removed costs a mntget() and a mntput() on that mount.

The mount comes from vfs_kern_mount() and not from kern_mount(), so it
never gets MNT_NS_INTERNAL and mntput_no_expire() can't take the fast
path for it. Each of those mntput()s ends up in
mntput_no_expire_slowpath(), takes mount_lock and sums the per-cpu
counters in mnt_get_count() to find out whether it dropped the last
reference. It never did for anything but the last pin, that's what the
pin count is for.

The reference per pin never bought anything. The pin count under
pin_fs_lock is what keeps the mount alive, nothing looks at the mount's
refcount to find out how many pins there are and the mount is only torn
down once the last pin is gone.

Keep the reference vfs_kern_mount() returned as the one reference the
pins hold. Further pins only bump the count and the last
simple_release_fs() drops the reference. The refcount of a pinned mount
now changes when it is first pinned and when the last pin goes away.
Everything in between is a spinlock and a counter.

Reported-by: kernel test robot <yi1.lai@intel.com>
Closes: https://lore.kernel.org/oe-lkp/202610130959.d3ca4cfa-lkp@intel.com
Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
---
 fs/libfs.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/fs/libfs.c b/fs/libfs.c
index 27d7dc16fcb0..ab2a30ce8509 100644
--- a/fs/libfs.c
+++ b/fs/libfs.c
@@ -1103,10 +1103,11 @@ int simple_pin_fs(struct file_system_type *type, struct vfsmount **mount, int *c
 		if (IS_ERR(mnt))
 			return PTR_ERR(mnt);
 		spin_lock(&pin_fs_lock);
-		if (!*mount)
+		if (!*mount) {
 			*mount = mnt;
+			mnt = NULL;
+		}
 	}
-	mntget(*mount);
 	++*count;
 	spin_unlock(&pin_fs_lock);
 	mntput(mnt);
@@ -1116,11 +1117,12 @@ EXPORT_SYMBOL(simple_pin_fs);
 
 void simple_release_fs(struct vfsmount **mount, int *count)
 {
-	struct vfsmount *mnt;
+	struct vfsmount *mnt = NULL;
 	spin_lock(&pin_fs_lock);
-	mnt = *mount;
-	if (!--*count)
+	if (!--*count) {
+		mnt = *mount;
 		*mount = NULL;
+	}
 	spin_unlock(&pin_fs_lock);
 	mntput(mnt);
 }

---
base-commit: 24a19b953e2a3d0ea5a8c4951a0ab8f32720c907
change-id: 20261026-work-libfs-pin_fs-8ec84ec60902

