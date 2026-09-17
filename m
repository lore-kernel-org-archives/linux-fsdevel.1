Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CD064D597B
	for <linux-fsdevel@vger.kernel.org>; Thu, 17 Sep 2026 11:49:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789645766; cv=none; b=OQcxBuJVfJPb9JwDFMgYuD1YqXJwnmWB1cEywWAYKsCkFbVHLmb4aWLJ5eXHfGOBFicFVuw/16QlE2q9TZPm0YV1XNXKjIrNiVTiWsQ5sxgQ95dldR25YiirySEgo/0lISG1i7cGhS2sqP4czK4ZafoPekraj7V1uqXM4mP/5k4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789645766; c=relaxed/simple;
	bh=85CkSXkeZTzhoW35l6pc9+P51Ci9FF0DrK8QXb9/YWQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=MA4gv2EdSTuB9fUB8nxkJcw46Qi6Oulkns5eVaSGPsdTSQV5Gr2q5rQIN7r2A2uOOiAvLGwLMCuafr+BWAguFFFvS0N8gbUfbeBG1nePtn2fhVkfEaDeaAIVeeLDy1z4cgEVUBiNmtdDceRGVFbT/F77/9tedkoB7IvLnJrl5/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=URLPq2xz; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="URLPq2xz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 868FB1F000FF;
	Thu, 17 Sep 2026 11:49:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789645764;
	bh=gNlYhn5ymzwRqIpdTQ0z4riGl+8/5xobB3YY5V9ojHE=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=URLPq2xzCsIMDwVAQXU3JQAhEOSNCVOiEwBBHVTGewEpDYESmvMJbDvxsqeAP+JQI
	 aFYkUctXAc6dLTCGz53eQisnfrfiAvXgjGMaTsHz/NTbtRNZfdvwCmU9BWDewwyjnR
	 L66oazKKSgQbAhGPdWzitI1xv24E+fT1MGfjEF9SHq9qogTOlKuneQEbUU1JMFA7Ft
	 AIbVXEimI/j8ZCl8OM1QzR8FlEQSpUozhDJdD70g10KIDIrcUz0KslTKWqGJKqP9tV
	 bYcM2ZtpvoiywUFZFeuMLxYRImBpnpYjdoJRRBbJILlPPj6J9m+WYSIWS4Fx5AQB9r
	 Kl/0TO/bNglPg==
From: Christian Brauner <brauner@kernel.org>
Date: Thu, 17 Sep 2026 13:49:04 +0200
Subject: [PATCH 2/2] Revert "put_mnt_ns(): leave mounts connected"
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260917-work-put_mnt_ns-revert-v1-2-34d9b8679e68@kernel.org>
References: <20260917-work-put_mnt_ns-revert-v1-0-34d9b8679e68@kernel.org>
In-Reply-To: <20260917-work-put_mnt_ns-revert-v1-0-34d9b8679e68@kernel.org>
To: linux-fsdevel@vger.kernel.org
Cc: "To: Alexander Viro" <viro@zeniv.linux.org.uk>, 
 "To: Jan Kara" <jack@suse.cz>, "To: Noah Orlando" <Noah.Orlando@deshaw.com>, 
 Michael Vogt <michael@amutable.com>, 
 "Christian Brauner (Amutable)" <brauner@kernel.org>
X-Mailer: b4 0.17-dev-db0b7
X-Developer-Signature: v=1; a=openpgp-sha256; l=2354; i=brauner@kernel.org;
 h=from:subject:message-id; bh=85CkSXkeZTzhoW35l6pc9+P51Ci9FF0DrK8QXb9/YWQ=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWStvrxHe2/nqY4d1++WhEv3Z1yY9Mj41tPiZheFgz8Vb
 fvd183d0FHKwiDGxSArpsji0G4SLrecp2KzUaYGzBxWJpAhDFycAjCRg/MZ/spckTVjXLji16Tm
 CY9SND4pyJ6eMN3SW2GCOO+x5akOVWcZGd7IbRXe/37B0akTxWWa/d+mfdz1eHuBw8JQ9ie3Kk8
 dusQGAA==
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

This reverts commit 0342482a4d15358fe6931606caf58968de5d1d38.

Keeping every mount of a dying namespace attached to its parent changes
who owns it. An attached but unmounted mount is owned by its parent: the
parent's final mntput() is what drops the child's reference and takes
its superblock down. Before that commit only the namespace root was in
that position and every other mount dropped its own reference in
namespace_unlock().

That ownership rule turns any reference from a child's superblock back
to one of its ancestors into a cycle. The obvious case is a loop device:

    unshare -m sh -c 'mount -o loop /var/tmp/img /var/tmp/mp'

mount(8) opens the image from inside the new namespace, so the loop
device's backing file pins that namespace's copy of the root mount.
When the namespace dies the loop mount stays attached to that copy and
is owned by it. The copy can't reach zero because the backing file
holds it. The backing file is only put once the ext4 superblock
releases the block device and autoclear runs, and that needs the loop
mount to go first. Nothing breaks the cycle. The superblock, the loop
device and, since the root copy keeps all of its children.

systemd-sysext sets up its loop devices in a private mount namespace and
relies on autoclear when that namespace goes away, which is how this was
found. Anything that holds a file on an ancestor from a mounted
filesystem has the same problem. That includes ecryptfs lower paths,
erofs file-backed mounts, fuse passthrough backing files.

That's a bigger fix and not an -rc change. Revert.

Fixes: 0342482a4d15 ("put_mnt_ns(): leave mounts connected")
Reported-by: Michael Vogt <michael@amutable.com>
Link: https://gist.github.com/mvo5/63ef46482349f3b1c3957d463a0c9c6f
Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
---
 fs/namespace.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/namespace.c b/fs/namespace.c
index ae5dc64f8b45..b31c22d3eb70 100644
--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -6294,7 +6294,7 @@ void put_mnt_ns(struct mnt_namespace *ns)
 	guard(namespace_excl)();
 	emptied_ns = ns;
 	guard(mount_writer)();
-	umount_tree(ns->root, UMOUNT_CONNECTED);
+	umount_tree(ns->root, 0);
 }
 
 struct vfsmount *kern_mount(struct file_system_type *type)

-- 
2.53.0

