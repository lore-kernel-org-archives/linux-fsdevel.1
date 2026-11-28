Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=220.197.31.5
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795854525;
	b=F50G3Jm1Uz/ahHhwtiz/hJxKlqBaoDNXK+h4fzuRrsKCAurDaiJgFzN/o13uvbsnr2of
	 kie4K3cH+hH3g0piIYoX2u0ckLMBx5ACf5Ite5L1qT4URGrMk7SjbuSYnfnY0NY3D+HcQ
	 Gqy+rfZAW/87TOApOeLhDRxg1GrQQNf2oJNE3kzUA8m4Ume05J0QQ+c5DQHadFkjPlFwE
	 PoU0BuZ8o0iEJpCIJefyGBXKqWDqpbShzT1JFbga2Pwhpj4mn33U3ZLKKjnqJUOldwP+7
	 kl/Fs1x6mybE8Yql/8WvCwMc+MpsAia/AGsl3dR5hEk6LtpTMFZlHV2t0/3DUcLIJiw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795854525;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-Id:X-Mailer:MIME-Version:Content-Transfer-Encoding:
	 X-CM-TRANSID:X-Coremail-Antispam:X-CM-SenderInfo;
	bh=98DjPq0k77S6BY+ei2O96+19h+dMB8NHTMDNKHV/HtY=;
	b=Gzn5PxQq4QUQL1Oc5WJ8yacwEfte/6D7cps+pMODJDk1vVhaMJxQ/lrUxTj++16YOHuc
	 Y3tXPZD9D2SpVK107dNGtIvTCj2QzsIX2rzj3EbEim4CTp5D1hR2m2A2u9DWkxvA4pA9N
	 cbuU4WAQNQ2eN5NhsiKlznLR+hjszbHrAdEJWVKczp2iU1DMrzDI7wShvlW23TodXMDz8
	 zbxetmSgOGq5h+NuHfXMgyvS/XoZNVZ6lS685rrqz0El4xmJNSjpWZh1uUImzF0QXWeEn
	 GQNcBhpXs3IV8JIJNAxIwUlBmBYKKSpxX5RsfUvr5dvOSXI8gAg68edjFvAzPj3707A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=163.com;
	spf=pass smtp.mailfrom=163.com;
	dkim=pass header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=T1hz9zak;
	arc=none smtp.remote-ip=220.197.31.5
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B97C606A334;
	Sat, 28 Nov 2026 08:28:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4B97C606A334
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=T1hz9zak
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=98
	DjPq0k77S6BY+ei2O96+19h+dMB8NHTMDNKHV/HtY=; b=T1hz9zakpCaESXv5m/
	j7egMUti2NuouMJGlAccA2KvDCVs0S2uJeCr4ML18WBD2QKzX2zBiISTs5emHW3l
	GWlw8DjnKgxXbeikfixYApoNmRHFS3PdNootHvWsA0qCGaq7XySbD0Jh7Ge4kzb6
	T9wX2KruzzguHsCBaQc2ook9g=
Received: from shaos.localdomain (unknown [])
	by gzga-smtp-mtada-g0-3 (Coremail) with SMTP id _____wD3X1eskApruM8PLA--.19391S2;
	Sat, 28 Nov 2026 16:28:29 +0800 (CST)
From: shaos <shawnq1@163.com>
To: slava@dubeyko.com
Cc: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
	Yangtao Li <frank.li@vivo.com>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] hfsplus: bound B-tree map node traversal
Date: Sat, 28 Nov 2026 08:28:28 +0000
Message-Id: <20261128082828.3075144-1-shawnq1@163.com>
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
X-CM-TRANSID:_____wD3X1eskApruM8PLA--.19391S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxAw1UtryDuF1DXF4fXF47Arb_yoWrur1kpF
	Zxtayay3WvqF1Fqws3Ka10q3Wa9wn7JrWa93WkXw4xZwn8Xr1xtr10yFyYqFsrAFWkWrWY
	qFW5Wa4Fgay7tFDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jw_-PUUUUU=
X-CM-SenderInfo: pvkd40jtr6il2tof0z/xtbC0A2sumsKkK0cVQAA3e

Hello,

hfs_bmap_alloc() follows the next pointer of each B-tree map node without
checking for a cycle or an upper bound.  A crafted HFS+ image can make a
full map node point to itself.  Mounting the image then loops in the
allocation-map scan and consumes CPU; the mount task remains alive after
SIGKILL.

The reproducer creates the image and tests a self-cycle, a non-cyclic
full map, and a normal map.  The cycle hung in two vulnerable runs.  The
non-cyclic full-map fixture returned -ENOMEM when it reached node 8192,
without hanging; the normal-map control mounted successfully.  With this
patch, mounting the cycle returns -EIO promptly, and the normal-map
control still mounts successfully.

The issue requires a privileged writable mount of a crafted HFS+ image.
It demonstrates a local denial of service, not memory corruption or
privilege escalation.

Tested source revision:
HEAD commit:    8d7fe9885c62fc9a95bf55d9db244d9672a8aadc
git tree:       fe970b05333fb8e41da21e9e289f652abcc7cba7
source version: Linux 7.4.0-rc4
compiler:       gcc (Ubuntu 11.4.0-1ubuntu1~22.04.3) 11.4.0,
                GNU ld 2.38

console output:
https://gist.githubusercontent.com/shaos26/9280cbfdae1690b6b20c86bfe0c8db8e/raw/131205d3de25b8c5fe42864362c6e2e1009f90a1/console-output.txt
kernel config:
https://gist.githubusercontent.com/shaos26/9280cbfdae1690b6b20c86bfe0c8db8e/raw/d63b446bf570fc993d04b3ffeae979b3db4a6eec/kernel-config.txt
reproducer:
https://gist.githubusercontent.com/shaos26/9280cbfdae1690b6b20c86bfe0c8db8e/raw/d734030b8907670c9aefd748bd6663d894d828a2/poc.c
initramfs init:
https://gist.githubusercontent.com/shaos26/9280cbfdae1690b6b20c86bfe0c8db8e/raw/ce28f3f2f53dce541ad5cb7f5b110a378af9e2e6/init
patched-kernel config:
https://gist.githubusercontent.com/shaos26/9280cbfdae1690b6b20c86bfe0c8db8e/raw/d204ab19c4a8824c83293b94741f80cc0fa52b0a/patched-kernel-config.txt

Build the kernel at the tested revision with the attached configuration.
Build poc.c statically, place it at /poc in a minimal initramfs, and use
the supplied init script as /init.  The initramfs needs a static BusyBox
at /bin/busybox.  Run the cycle case with:

    gcc -O2 -Wall -Wextra -static -o poc poc.c
    mkdir -p rootfs/bin
    cp poc rootfs/poc
    cp init rootfs/init
    cp <static-busybox> rootfs/bin/busybox
    chmod 0755 rootfs/init rootfs/poc rootfs/bin/busybox
    (cd rootfs && find . -print0 | cpio --null -o -H newc) |
        gzip -9 > initramfs.cpio.gz

    qemu-system-x86_64 -m 2G -smp 2 \
        -kernel <linux-tree>/arch/x86/boot/bzImage \
        -initrd initramfs.cpio.gz \
        -append 'console=ttyS0 rdinit=/init pocmode=cycle lsm=landlock' \
        -nographic -monitor none -no-reboot

The init script runs /poc with the value of pocmode.  Repeat with
pocmode=normal for the successful mount control.  The no-cycle fixture
is also available as pocmode=nocycle.

Bound traversal by both the B-tree header's node count and the number of
complete nodes that fit in the tree file.  This prevents a malformed
header from permitting an unbounded walk:

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Signed-off-by: shaos <shawnq1@163.com>
---
 fs/hfsplus/btree.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/fs/hfsplus/btree.c b/fs/hfsplus/btree.c
index bd4dbdbc8f98c..7aff41420c098 100644
--- a/fs/hfsplus/btree.c
+++ b/fs/hfsplus/btree.c
@@ -534,6 +534,7 @@ struct hfs_bnode *hfs_bmap_alloc(struct hfs_btree *tree)
 	struct hfs_bmap_ctx ctx;
 	struct page *page;
 	u32 nidx, idx;
+	u32 max_nodes, nodes_seen = 1;
 	u8 *data, byte, m;
 	int i, res;
 
@@ -543,6 +544,9 @@ struct hfs_bnode *hfs_bmap_alloc(struct hfs_btree *tree)
 	if (res)
 		return ERR_PTR(res);
 
+	max_nodes = min_t(u64, tree->node_count,
+			  tree->inode->i_size >> tree->node_size_shift);
+
 	nidx = 0;
 	node = hfs_bnode_find(tree, nidx);
 	if (IS_ERR(node))
@@ -592,8 +596,15 @@ struct hfs_bnode *hfs_bmap_alloc(struct hfs_btree *tree)
 			hfs_dbg("create new bmap node\n");
 			next_node = hfs_bmap_new_bmap(node, idx);
 			hfs_btree_write(tree);
-		} else
+		} else {
+			if (nodes_seen >= max_nodes) {
+				pr_err("invalid btree map node chain\n");
+				hfs_bnode_put(node);
+				return ERR_PTR(-EIO);
+			}
+			nodes_seen++;
 			next_node = hfs_bnode_find(tree, nidx);
+		}
 		hfs_bnode_put(node);
 		if (IS_ERR(next_node))
 			return next_node;
-- 
2.34.1

Thanks,

shaos

