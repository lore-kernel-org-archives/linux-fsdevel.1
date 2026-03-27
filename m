Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DE882D0638
	for <linux-fsdevel@vger.kernel.org>; Fri, 27 Mar 2026 01:29:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774574953; cv=none; b=ro9XOcBaPhqR/wnhjCszphSFBoBt2MOdTLgstHHXWpdhcFe3VZ13i9xfYadxf/irl8x+u00l30l9912EfbgtbunksrRLjnUlC2em2RTC3s672xZkx0DItRhG0qCqdm/oqF/N1v7qDEscaLrd/u3w4qHx1w+hB0+5axjy/yBopRU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774574953; c=relaxed/simple;
	bh=nA5s3ElYTX75Wy+AIjv/H8A23T4Nhvr+zHL12+F+giQ=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QlxZfDp9fqFK99kwmvbGtPrdLakR/kWJOldWiw7kExlP9W+p/fuUAe6pani995tHBMPp0N9kALHV5gIzi9oPC31Gb4QTAtONWha28CY1tprJ4vC3Z2ix9FOGwSLRwQDmYcImqhV4MCqmtRenYihT0NbDhAvrpwwpzghk3g1mKnY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PdxQCN7N; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PdxQCN7N"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3E173C116C6;
	Fri, 27 Mar 2026 01:29:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774574953;
	bh=nA5s3ElYTX75Wy+AIjv/H8A23T4Nhvr+zHL12+F+giQ=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=PdxQCN7NWGZxLpBepGpW3gloUUl+BNFgprR6IFm/do+MT4XWJvBo+ge8qxpt9o0Xc
	 2+YMTQNVGzK5rWo9kUm4PX8nkpH3gMoC+vCuLBiFE/SiPlJ1UcHxhivZRvMgUFTfWK
	 78eFVsQaF8WVZ19WzhzEIv4eTGpxLOEvDBqiGDFnTo5VAOaceq9qY14PlfAHxb06CY
	 ErIIMGlX2HT/zFROcMsnKnWSWz8T8+wxGuh8lM8Ckw6/WkV8hvP0sR9FTBoGqa1vK5
	 9ksZV1n4XpkYk4RTHOTykkahYISaE4ny3Cp4uEOdjo4R8cNr64BN3gz7FrjCU03hwk
	 2e1tU+EAKiCKQ==
Date: Thu, 26 Mar 2026 18:29:12 -0700
Subject: [PATCH 17/17] nullfs: support fuse systemd service mode
From: "Darrick J. Wong" <djwong@kernel.org>
To: djwong@kernel.org, bschubert@ddn.com
Cc: linux-fsdevel@vger.kernel.org, bernd@bsbernd.com, miklos@szeredi.hu,
 neal@gompa.dev, joannelkoong@gmail.com
Message-ID: <177457463428.1008428.6991907403668845476.stgit@frogsfrogsfrogs>
In-Reply-To: <177457463048.1008428.11432672970504238251.stgit@frogsfrogsfrogs>
References: <177457463048.1008428.11432672970504238251.stgit@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

From: Darrick J. Wong <djwong@kernel.org>

This is the only example fuse server that exports a regular file instead
of a directory tree.  Port it to be usable as a systemd fuse service so
that we can test that capability.

Signed-off-by: Darrick J. Wong <djwong@kernel.org>
---
 example/meson.build        |    6 +++
 example/null.c             |   33 +++++++++++++-
 example/nullfile.socket.in |   15 ++++++
 example/nullfile@.service  |  102 ++++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 154 insertions(+), 2 deletions(-)
 create mode 100644 example/nullfile.socket.in
 create mode 100644 example/nullfile@.service


diff --git a/example/meson.build b/example/meson.build
index 0a7cc3dbf31da4..c08a81747e68ae 100644
--- a/example/meson.build
+++ b/example/meson.build
@@ -10,6 +10,12 @@ if not platform.endswith('bsd') and platform != 'dragonfly'
     # support mounting files, This is enforced in vfs_domount_first()
     # with the v_type != VDIR check.
     examples += [ 'null' ]
+
+    if platform.endswith('linux')
+        configure_file(input: 'nullfile.socket.in',
+                       output: 'nullfile.socket',
+                       configuration: private_cfg)
+    endif
 endif
 
 single_file_examples = [ 'hello_ll' ]
diff --git a/example/null.c b/example/null.c
index ec41def40ed5c5..3e7e43f722a432 100644
--- a/example/null.c
+++ b/example/null.c
@@ -17,15 +17,24 @@
  *
  *     gcc -Wall null.c `pkg-config fuse3 --cflags --libs` -o null
  *
+ * Change the ExecStart line in nullfile@.service:
+ *
+ *     ExecStart=/path/to/nullfile
+ *
+ * to point to the actual path of the nullfile binary.
+ *
+ * Finally, install the nullfile@.service and nullfile.socket files to the
+ * systemd service directory, usually /run/systemd/system.
+ *
  * ## Source code ##
  * \include passthrough_fh.c
  */
 
-
-#define FUSE_USE_VERSION 31
+#define FUSE_USE_VERSION FUSE_MAKE_VERSION(3, 19)
 
 #include <fuse.h>
 #include <fuse_lowlevel.h>
+#include <fuse_service.h>
 #include <stdio.h>
 #include <stdlib.h>
 #include <string.h>
@@ -117,6 +126,26 @@ int main(int argc, char *argv[])
 	struct fuse_args args = FUSE_ARGS_INIT(argc, argv);
 	struct fuse_cmdline_opts opts;
 	struct stat stbuf;
+	struct fuse_service *service = NULL;
+	int ret;
+
+	if (fuse_service_accept(&service) != 0)
+		return 1;
+
+	if (fuse_service_accepted(service)) {
+		if (fuse_service_append_args(service, &args) != 0)
+			return 1;
+		if (fuse_service_finish_file_requests(service) != 0)
+			return 1;
+
+		fuse_service_expect_mount_mode(service, S_IFREG);
+
+		ret = fuse_service_main(service, args.argc, args.argv,
+					&null_oper, NULL);
+
+		fuse_opt_free_args(&args);
+		return fuse_service_exit(ret);
+	}
 
 	if (fuse_parse_cmdline(&args, &opts) != 0)
 		return 1;
diff --git a/example/nullfile.socket.in b/example/nullfile.socket.in
new file mode 100644
index 00000000000000..23e57a25f2eb93
--- /dev/null
+++ b/example/nullfile.socket.in
@@ -0,0 +1,15 @@
+# SPDX-License-Identifier: GPL-2.0-or-later
+#
+# Copyright (C) 2026 Oracle.  All Rights Reserved.
+# Author: Darrick J. Wong <djwong@kernel.org>
+[Unit]
+Description=Socket for nullfile Service
+
+[Socket]
+ListenSequentialPacket=@FUSE_SERVICE_SOCKET_DIR_RAW@/nullfile
+Accept=yes
+SocketMode=0220
+RemoveOnStop=yes
+
+[Install]
+WantedBy=sockets.target
diff --git a/example/nullfile@.service b/example/nullfile@.service
new file mode 100644
index 00000000000000..665f8d4226ff49
--- /dev/null
+++ b/example/nullfile@.service
@@ -0,0 +1,102 @@
+# SPDX-License-Identifier: GPL-2.0-or-later
+#
+# Copyright (C) 2026 Oracle.  All Rights Reserved.
+# Author: Darrick J. Wong <djwong@kernel.org>
+[Unit]
+Description=nullfile Sample Fuse Service
+
+# Don't leave failed units behind, systemd does not clean them up!
+CollectMode=inactive-or-failed
+
+[Service]
+Type=exec
+ExecStart=/path/to/null
+
+# Try to capture core dumps
+LimitCORE=infinity
+
+SyslogIdentifier=%N
+
+# No realtime CPU scheduling
+RestrictRealtime=true
+
+# Don't let us see anything in the regular system, and don't run as root
+DynamicUser=true
+ProtectSystem=strict
+ProtectHome=true
+PrivateTmp=true
+PrivateDevices=true
+PrivateUsers=true
+
+# No network access
+PrivateNetwork=true
+ProtectHostname=true
+RestrictAddressFamilies=none
+IPAddressDeny=any
+
+# Don't let the program mess with the kernel configuration at all
+ProtectKernelLogs=true
+ProtectKernelModules=true
+ProtectKernelTunables=true
+ProtectControlGroups=true
+ProtectProc=invisible
+RestrictNamespaces=true
+RestrictFileSystems=
+
+# Hide everything in /proc, even /proc/mounts
+ProcSubset=pid
+
+# Only allow the default personality Linux
+LockPersonality=true
+
+# No writable memory pages
+MemoryDenyWriteExecute=true
+
+# Don't let our mounts leak out to the host
+PrivateMounts=true
+
+# Restrict system calls to the native arch and only enough to get things going
+SystemCallArchitectures=native
+SystemCallFilter=@system-service
+SystemCallFilter=~@privileged
+SystemCallFilter=~@resources
+
+SystemCallFilter=~@clock
+SystemCallFilter=~@cpu-emulation
+SystemCallFilter=~@debug
+SystemCallFilter=~@module
+SystemCallFilter=~@reboot
+SystemCallFilter=~@swap
+
+SystemCallFilter=~@mount
+
+# libfuse io_uring wants to pin cores and memory
+SystemCallFilter=mbind
+SystemCallFilter=sched_setaffinity
+
+# Leave a breadcrumb if we get whacked by the system call filter
+SystemCallErrorNumber=EL3RST
+
+# Log to the kernel dmesg, just like an in-kernel filesystem driver
+StandardOutput=append:/dev/ttyprintk
+StandardError=append:/dev/ttyprintk
+
+# Run with no capabilities at all
+CapabilityBoundingSet=
+AmbientCapabilities=
+NoNewPrivileges=true
+
+# We don't create files
+UMask=7777
+
+# No access to hardware /dev files at all
+ProtectClock=true
+DevicePolicy=closed
+
+# Don't mess with set[ug]id anything.
+RestrictSUIDSGID=true
+
+# Don't let OOM kills of processes in this containment group kill the whole
+# service, because we don't want filesystem drivers to go down.
+OOMPolicy=continue
+OOMScoreAdjust=-1000

