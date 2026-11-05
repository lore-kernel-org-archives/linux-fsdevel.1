Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=160.30.148.34
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793887847;
	b=weCSye8S6iwHoJqhsdwFIG7tOdPyik7b6B1+y3CGUR8cG4hfaQNQn+F5Vw0u+fy9DLSp
	 dxyQi2Bf51hNYd2Dt7ug/jf6TqnTmeRrf3v3hDx1p2ghxzOgwg6chXC5Y9Ty/3ErF/YP+
	 Za+5u41hULPBr2XMrmaM0erApkG60qHKaj07P0s5ZFQ6WerUZ6+eX+AmUmfjtUw0FmuP/
	 4LRO7g53/JXbmj3Kjldyvrj1LVMNxojr+UF9KES0esbNsAKjUJplYbtILdxM7Hjr1W542
	 rUm2nEHbBrKUkUkUiDCdn16lwSzSOQX+yqARZOfbnTYXtBObccgkPUNREktxw6EdzEw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793887847;
	h=DMARC-Filter:Received:Received:Received:X-Zmail-TransId:X-Mailer:
	 Message-ID:Date:Mime-Version:From:To:Cc:Subject:Content-Type:X-MAIL:
	 X-TLS:X-ENVELOPE-SENDER:X-SOURCE-IP:X-CLEAN:
	 X-Fangmail-Anti-Spam-Filtered:X-Fangmail-MID-QID;
	bh=CibUYVH+7OYY+APiKvZin4in4hp417rNXMuqELO13JY=;
	b=HrJK+nUxbshogO9+QNKfK7hDsnSkcYjA7OumDEDA7OM2A27pljlRd65TvSpydYQZVkBE
	 8XzhlMxTz2Td4QH1ixug0+xqnYhlFOXujW51sWSHDDC974+kY1f537OsaPRxckU4Po5xL
	 Uihxxu8yJsHqDg4stZRogD4bfVSQ6iPo9S4dQdND7cbpP46Nv2TldECjBJzbI6lWI7H0r
	 k7LRxizLjsbX67ztPjOoE2JPc0hIKfGkFgQ/YIaaoSxh+Qg4eY3vyM+/wkgMhzniQKJhL
	 DFfKQR8OFIFsYwy/kUvzdpqq8Mcuvknsmz2wCRgtbF6yTx4sDmmuqR12NIbKvIHUI6Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=zte.com.cn;
	spf=pass smtp.mailfrom=zte.com.cn;
	arc=none smtp.remote-ip=160.30.148.34
Received: from mxhk.zte.com.cn (mxhk.zte.com.cn [160.30.148.34])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86080606A336;
	Thu,  5 Nov 2026 14:10:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 86080606A336
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zte.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zte.com.cn
Received: from mse-fl2.zte.com.cn (unknown [10.5.228.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mxhk.zte.com.cn (FangMail) with ESMTPS id 4jL43320wKz4yjjB;
	Thu, 05 Nov 2026 22:10:39 +0800 (CST)
Received: from xaxapp02.zte.com.cn ([10.88.97.241])
	by mse-fl2.zte.com.cn with SMTP id 6A5EAUA6074069;
	Thu, 5 Nov 2026 22:10:30 +0800 (+08)
	(envelope-from shao.mingyin@zte.com.cn)
Received: from mapi (xaxapp02[null])
	by mapi (Zmail) with MAPI id mid32;
	Thu, 5 Nov 2026 22:10:32 +0800 (CST)
X-Zmail-TransId: 2afa6aec8e58bcc-eb307
X-Mailer: Zmail v1.0
Message-ID: <20261105221032737LKGdHz8FE-EFnNwJuw0N9@zte.com.cn>
Date: Thu, 5 Nov 2026 22:10:32 +0800 (CST)
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
From: <shao.mingyin@zte.com.cn>
To: <viro@zeniv.linux.org.uk>, <brauner@kernel.org>,
        <linux-fsdevel@vger.kernel.org>
Cc: <jack@suse.cz>, <josef@toxicpanda.com>, <linux-kernel@vger.kernel.org>
Subject: =?UTF-8?B?W1BBVENIXSBtb3VudDogZml4IHN0YXRtb3VudCgpIGFuZCBsaXN0bW91bnQoKSBvbiBlbXB0eSBtb3VudCBuYW1lc3BhY2Vz?=
Content-Type: text/plain;
	charset="UTF-8"
X-MAIL:mse-fl2.zte.com.cn 6A5EAUA6074069
X-TLS: YES
X-ENVELOPE-SENDER: shao.mingyin@zte.com.cn
X-SOURCE-IP: 10.5.228.133 unknown Thu, 05 Nov 2026 22:10:39 +0800
X-CLEAN: YES
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 6AEC8E5F.000/4jL43320wKz4yjjB

From: Shao Mingyin <shao.mingyin@zte.com.cn>

statmount() and listmount() on a foreign mount namespace fail with
-ENOENT when nothing is mounted on top of the namespace root.  That is
the case for an empty mount namespace created by
unshare(UNSHARE_EMPTY_MNTNS) or clone3(CLONE_EMPTY_MNTNS): its only
mount is the namespace root, a nullfs mount, and no rootfs is mounted
on it.

Both syscalls resolve the path anchor for a foreign namespace in
grab_requested_root().  It starts at ns->root and looks for a mount
whose parent is that root, i.e. the mount covering the namespace root:

	for (child = node_to_mount(ns->mnt_first_node); child;
	     child = listmnt_next(child, false)) {
		if (child != first && child->mnt_parent == first)
			break;
	}
	if (!child)
		return -ENOENT;

When nothing is mounted on the root the loop finds no candidate, so the
whole syscall fails although the mount id the caller asks about exists
in that namespace.  statmount() issued from inside the same namespace
succeeds, which shows that the mount is fine.

Fall back to the namespace root itself in that case.  Inside such a
namespace the root mount is what the members' root and cwd point at,
so it is the correct anchor; paths below it are resolved relative to
"/".

The same condition also occurs for an anonymous namespace created by
fsmount() or open_tree(OPEN_TREE_CLONE): it contains only the root
mount itself, and statmount(STATMOUNT_BY_FD) on such a mount fd failed
with -ENOENT for the same reason.

Fixes: 71aacb4c8c3d ("fs: Allow statmount() in foreign mount namespace")
Signed-off-by: Shao Mingyin <shao.mingyin@zte.com.cn>
---
Tested on 7.3.0-next-20261030 (x86_64 QEMU/TCG guest, defconfig
plus KASAN, no extra hardware).

A child process unshares into an empty mount namespace
(unshare(UNSHARE_EMPTY_MNTNS)), reads the unique mount ID of its root
with statx("/", STATX_MNT_ID_UNIQUE) and then blocks.  The parent opens
/proc/<pid>/ns/mnt and queries that namespace by mount ID.  The mount
ID is valid: statmount() from inside the child's own namespace returns
fs_type=nullfs on both kernels.

  unpatched                            patched
  statmount() ret=-1 errno=2 (ENOENT)  statmount() ret=0,
                                       mask=STATMOUNT_MNT_BASIC|
                                       STATMOUNT_FS_TYPE
  listmount() ret=-1 errno=2 (ENOENT)  listmount() ret=1,
                                       id=<root mount>

The patched kernel also still returns the mount for
statmount(STATMOUNT_BY_FD) on a mount fd obtained with
open_tree(OPEN_TREE_CLONE), i.e. for the anonymous namespace case.

Both kernels are otherwise clean: no KASAN report, no Oops, no WARN.
---
diff --git a/fs/namespace.c b/fs/namespace.c
index 25e196c05126..8a101a8c48f7 100644
--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -5888,8 +5888,14 @@ static int grab_requested_root(struct mnt_namespace *ns, struct path *root)
 		if (child != first && child->mnt_parent == first)
 			break;
 	}
+	/*
+	 * Nothing mounted on the root of the namespace: an empty mount
+	 * namespace (CLONE_EMPTY_MNTNS) or an anonymous namespace from
+	 * fsmount()/open_tree(OPEN_TREE_CLONE).  Use the namespace root
+	 * itself as the anchor then; there is no child covering it.
+	 */
 	if (!child)
-		return -ENOENT;
+		child = first;
 
 	root->mnt = mntget(&child->mnt);
 	root->dentry = dget(root->mnt->mnt_root);
