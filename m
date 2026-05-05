Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA9853A2549;
	Tue,  5 May 2026 05:24:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777958678; cv=none; b=Uva8h2s0pGJSZnFkt2s7NfVW24oAsNyK2SomvI3z9TYXD/xrHFnke5XtqHbHmaU35tH+vG0xJXGccQMV8sauD0Vj2fYkfAYqA15HeA0CiJdAjwfwUQmU5AmCMSniBBdVnHdY2+EDELNZGaLcTxHG3TS2v0plSHC+JezKm2o8VXc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777958678; c=relaxed/simple;
	bh=JOMuYDqsC0SpvvZDHuMTCod2q/pAy/tOrKT1t2Qn0g4=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rzuGWMcwHdchk+T9ja33DsCHptfHLDRqfSbYmDdAz3o0AKU1k6dyV4UDVxYEJ6nRvTjslzKPgCVfFv9MAQ+CtPQUkDPVY0y57/D1Xf6EkQHMpOnL2UVW/Jj3vOW+35ax/GSN9LiVao7R2969dp5pMv9hE/3aU8bTfL3WsIhrkdg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Wbr6Y22U; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Wbr6Y22U"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 64801C2BCB4;
	Tue,  5 May 2026 05:24:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777958678;
	bh=JOMuYDqsC0SpvvZDHuMTCod2q/pAy/tOrKT1t2Qn0g4=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=Wbr6Y22UX6YYbCjzVto5+AjWh1UFM5d6GsMVmKYjgP6zsUwx2aQ6Dx46l4ucp1fWo
	 J+TPtJuoNsxjKgVWwwPfLqo4two4BjMcre6WMjlnVm9SnV7RZj5VZvpfsMeiXLHGY/
	 Sc/9N8hnkvUryWKxPpAyi51yrRp0ojAfoyiTo0HwBb8t4S3ErYucjYFVzTLuMdnReJ
	 FZgLBs8EwbvtQS5Lf9XQP5NXc4fUNvSGQp892xLeFpqCOrtV6h/0RGSj5b0ujLQPqm
	 pxaqQ+l5o+jvrPSX7rwsG+u4xM3IRPNbZPccpKCVI04mzHkFgSuK6cqMezVX5a2yKk
	 DqiFpfS8rEWVg==
Date: Mon, 04 May 2026 22:24:38 -0700
Subject: [PATCH 03/10] examples: improve documentation of the new systemd
 service fuse servers
From: "Darrick J. Wong" <djwong@kernel.org>
To: djwong@kernel.org, bernd@bsbernd.com
Cc: joannelkoong@gmail.com, neal@gompa.dev, fuse-devel@lists.linux.dev,
 linux-fsdevel@vger.kernel.org, miklos@szeredi.hu
Message-ID: <177795853739.1133612.4172736040951763446.stgit@frogsfrogsfrogs>
In-Reply-To: <177795853647.1133612.5178638086120838710.stgit@frogsfrogsfrogs>
References: <177795853647.1133612.5178638086120838710.stgit@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

From: Darrick J. Wong <djwong@kernel.org>

Say a bit more about what the sample files are actually trying to do.

Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
---
 example/single_file.h |    4 ++++
 example/service_hl.c  |   20 ++++++++++++++++++--
 example/service_ll.c  |   20 ++++++++++++++++++--
 example/single_file.c |    4 ++++
 4 files changed, 44 insertions(+), 4 deletions(-)


diff --git a/example/single_file.h b/example/single_file.h
index 86edb51afb3384..290dd6051ed6f5 100644
--- a/example/single_file.h
+++ b/example/single_file.h
@@ -4,6 +4,10 @@
  *
  * This program can be distributed under the terms of the GNU GPLv2.
  * See the file GPL2.txt.
+ *
+ * This file is shared library code for example fuse servers that want to
+ * expose a single regular file that wraps another file in a manner that goes
+ * beyond simple passthrough.  It is not itself a fuse server.
  */
 #ifndef FUSE_SINGLE_FILE_H_
 #define FUSE_SINGLE_FILE_H_
diff --git a/example/service_hl.c b/example/service_hl.c
index 9c4f3ae7a6cf3c..ea041f670f2ec5 100644
--- a/example/service_hl.c
+++ b/example/service_hl.c
@@ -8,7 +8,15 @@
 
 /** @file
  *
- * minimal example filesystem using high-level API and systemd service api
+ * Minimal example filesystem using high-level API and systemd service API.
+ *
+ * - Shows how to build a high level FUSE filesystem server that can be managed
+ *   by systemd
+ * - Enables on-demand filesystem mounting via socket activation
+ * - Demonstrates requesting resources from the mount-caller's environment
+ * - Allows running FUSE servers with minimal privileges; isolated mount,
+ *   network, and pid namespaces; and a separate uid/gid (unlike traditional
+ *   FUSE which needs mount permissions and runs in the caller's environment)
  *
  * Compile with:
  *
@@ -25,7 +33,15 @@
  * to point to the actual path of the service_hl binary.
  *
  * Finally, install the service_hl@.service and service_hl.socket files to the
- * systemd service directory, usually /run/systemd/system.
+ * systemd service directory, usually /run/systemd/system.  Run these commands
+ * to activate:
+ *
+ *     systemctl daemon-reload
+ *     systemctl start service_hl.socket
+ *
+ * Then mount with:
+ *
+ *     mount -t fuse.service_hl /dev/sda /mnt
  *
  * ## Source code ##
  * \include service_hl.c
diff --git a/example/service_ll.c b/example/service_ll.c
index 8958a221e09a66..33a8bd48bc1215 100644
--- a/example/service_ll.c
+++ b/example/service_ll.c
@@ -8,7 +8,15 @@
 
 /** @file
  *
- * minimal example filesystem using low-level API and systemd service api
+ * Minimal example filesystem using low-level API and systemd service API.
+ *
+ * - Shows how to build a low level FUSE filesystem server that can be managed
+ *   by systemd
+ * - Enables on-demand filesystem mounting via socket activation
+ * - Demonstrates requesting resources from the mount-caller's environment
+ * - Allows running FUSE servers with minimal privileges; isolated mount,
+ *   network, and pid namespaces; and a separate uid/gid (unlike traditional
+ *   FUSE which needs mount permissions and runs in the caller's environment)
  *
  * Compile with:
  *
@@ -25,7 +33,15 @@
  * to point to the actual path of the service_ll binary.
  *
  * Finally, install the service_ll@.service and service_ll.socket files to the
- * systemd service directory, usually /run/systemd/system.
+ * systemd service directory, usually /run/systemd/system.  Run these commands
+ * to activate:
+ *
+ *     systemctl daemon-reload
+ *     systemctl start service_ll.socket
+ *
+ * Then mount with:
+ *
+ *     mount -t fuse.service_ll /dev/sda /mnt
  *
  * ## Source code ##
  * \include service_ll.c
diff --git a/example/single_file.c b/example/single_file.c
index 6932eac3a2f276..aeceac83c517c1 100644
--- a/example/single_file.c
+++ b/example/single_file.c
@@ -4,6 +4,10 @@
  *
  * This program can be distributed under the terms of the GNU GPLv2.
  * See the file GPL2.txt.
+ *
+ * This file is shared library code for example fuse servers that want to
+ * expose a single regular file that wraps another file in a manner that goes
+ * beyond simple passthrough.  It is not itself a fuse server.
  */
 #define _GNU_SOURCE
 #include <pthread.h>

