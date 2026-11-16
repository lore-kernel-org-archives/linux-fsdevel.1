Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=46.30.189.100
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794869016;
	b=4h3V9GKiLkgFdMMHXEGNEnLq/G14KERPDJX7hk6BCv3OzTAKdpoYsX7r/Vb4WxaBPrjS
	 8z1gZ2PzAZp85AM4vKakZ0meW4+uZUcSUkNLO59hv7A5NUqEfRXhPl7hWr4vKBFjLb+8R
	 LS+gtQ9k5/XBOrKuMB+vXGNCoby5hw9JOLFkT7uewLXZw7Ssdh0nu3UjQ5hZiAtqPbCK5
	 Rz4rHtQHqnGsvy50JLaGIIELNaP+jX35R+vgqGjuzEm78lamE0ub2nLA/Qtms5tKYVUcq
	 IaXrrg8tOUW9MG3ow7m6JTI9vJzwKehgOtOQ4BoDJIivz9aR7imhtBsLZBfELYpbF/w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794869016;
	h=DMARC-Filter:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=6KY2FKP+FBfUQwA57M/uE9a8s4UDJI0J/zaSKYPKyLc=;
	b=GJ3EZ0dt8CS5MIdnDNXL20KKFFtnLaR8bKuVoPqAAOHrY8+iMlJSGn2TUhdiR2nnU91M
	 oFnMfnSth6ym8VKGgOR4N5rJzz34GCDzXzF5elFVA7cb6r5XhGr8aRpTUVRgrNJp0pLAZ
	 wQm1Pntp5ABL8frOw/F1JWWIvLU/KPjQUvZR9f8fXXc72+6DqcpBlCj4P7M9IziHN1OYR
	 YIGNSS8zhtm3GZdCRbiLDmE6Te2JFhp6XTHJuWWvGpfhEc/H1Si7lkipeRXZ/TwH1ztaU
	 yOyahfME83Nl93kgwhjfiYAmBmZuUVwPU4l6hM5F+tUsbKIBzct4JPlJbMQxkRqKzig==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=iodev.co.uk;
	spf=pass smtp.mailfrom=iodev.co.uk;
	arc=none smtp.remote-ip=46.30.189.100
Received: from iodev.co.uk (iodev.co.uk [46.30.189.100])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 657E4606A329;
	Mon, 16 Nov 2026 22:43:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 657E4606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=iodev.co.uk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iodev.co.uk
Received: from localhost (unknown [79.116.217.174])
	by iodev.co.uk (Postfix) with ESMTPSA id B31B05E22D3;
	Mon, 16 Nov 2026 23:43:29 +0100 (CET)
From: Ismael Luceno <ismael@iodev.co.uk>
To: linux-kernel@vger.kernel.org
Cc: Ismael Luceno <ismael@iodev.co.uk>,
	Ismael Luceno <iluceno@suse.de>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>,
	linux-fsdevel@vger.kernel.org (open list:FILESYSTEMS (VFS and infrastructure))
Subject: [PATCH 2/8] init: mount devtmpfs before the root filesystem
Date: Mon, 16 Nov 2026 23:43:18 +0100
Message-ID: <20261116224316.11237-12-ismael@iodev.co.uk>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261116224316.11237-10-ismael@iodev.co.uk>
References: <20261116224316.11237-10-ismael@iodev.co.uk>
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

devtmpfs is mounted after the root filesystem, which leaves the root
mount with no /dev nodes to look devices up by.  A filesystem that has
to open block devices other than the one it was given has nothing to
open them by, and without an initrd there is no userspace around to
create the nodes either.

Mount it on the initial root before the root filesystem is mounted, so
the root filesystem can resolve device paths.  This is what lets a
multi-device btrfs root assemble itself with no initrd to run the
device scanner.

This mount is on the initial root and goes away with it at the pivot,
so the existing mount after mount_root() is kept: that is the one that
ends up in the new root.

This is only needed by the btrfs root device scan, so it is done only when
CONFIG_BTRFS_ROOT_SCAN is set; without it boot is unchanged.

Signed-off-by: Ismael Luceno <ismael@iodev.co.uk>
Signed-off-by: Ismael Luceno <iluceno@suse.de>
---
 init/do_mounts.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/init/do_mounts.c b/init/do_mounts.c
index b088021b1546..febcc37f9128 100644
--- a/init/do_mounts.c
+++ b/init/do_mounts.c
@@ -480,6 +480,20 @@ #define CIFSROOT_RETRY_MAX	5
 
 	if (root_wait)
 		wait_for_root(saved_root_name);
+
+	/*
+	 * Mount devtmpfs before the root filesystem, so that the filesystem
+	 * mounting it can look devices up by path.  A multi-device btrfs root
+	 * needs this: it has to open its other devices to assemble the
+	 * filesystem, and there is no userspace around to create the nodes.
+	 *
+	 * This one is on the initial root and goes away with it below; the
+	 * mount after mount_root() is the one that sticks around.  Only the
+	 * btrfs root device scan needs it.
+	 */
+	if (IS_ENABLED(CONFIG_BTRFS_ROOT_SCAN))
+		devtmpfs_mount();
+
 	mount_root(saved_root_name);
 	devtmpfs_mount();
 
