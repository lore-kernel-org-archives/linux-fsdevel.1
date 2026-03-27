Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53D622E9733
	for <linux-fsdevel@vger.kernel.org>; Fri, 27 Mar 2026 01:25:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774574734; cv=none; b=UL28jU9Y//JqC6Q+r38Sy0folnb92hQCayitHOurwjJPx3aqbACg3GadKZe/SGl0t9fJs1ZR+o6q1QDKHFtcfwshOYo8Iq8V+vaf42DiQL/+hOX8u/cyAmDKbPJtRYxm3TwC+uRRi1a1YObH5x8Sa5J8x3TeUx4iyD/icjIJbNY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774574734; c=relaxed/simple;
	bh=ggxrvrFWgHQciKn2zSgJLlCoblEcD6xfqYLmqQ741dw=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LANfBKvPiM7WHXNhIwO84qHCyg1Axb6+Asn+bjafwS5L9d2ngIgGOuZY9j1LLg8yk6X93tto58nm9xinBCRVg97IqACSSYeE/DYVFkcYlwqYpOVMCzy148piLjV28WK1s5nE13XeduMU4NcRMwbY5uPbn2ovHknNI6+uATwFxgc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aGGatB5D; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aGGatB5D"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D328CC116C6;
	Fri, 27 Mar 2026 01:25:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774574733;
	bh=ggxrvrFWgHQciKn2zSgJLlCoblEcD6xfqYLmqQ741dw=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=aGGatB5DTOQvO3jm54UXKO20PX+oZbb9baMY2cxc9xqgr0wcSemqxydcvTLSlg2G+
	 pj3xtL3BRlOLRrYN8qbxYoygDFPjIiam2dvEKef0HvLf/RZ6Uf3+IVMcgmQZvQLD4n
	 2sjymhsyMkwuw69CZ7+z2QkxYnPsM9Y99yli5HZP1a8lZ1+05+q1bwVOZrOi+AL7xZ
	 dXfglTaZle4ZVdb6jCS1CmYHA9aMmjeca1vHnj4J6jFVgTxAt2hUPw6N/G3a0c/Q+h
	 eLSXTfjNbe7qPYl9OFe7ZHTz3al7r9HUiHJ3jclFEANjsZ3H8YU/UFEdXlXs3itFvJ
	 5E/6XPPHWMeYQ==
Date: Thu, 26 Mar 2026 18:25:33 -0700
Subject: [PATCH 03/17] mount_service: create high level fuse helpers
From: "Darrick J. Wong" <djwong@kernel.org>
To: djwong@kernel.org, bschubert@ddn.com
Cc: linux-fsdevel@vger.kernel.org, bernd@bsbernd.com, miklos@szeredi.hu,
 neal@gompa.dev, joannelkoong@gmail.com
Message-ID: <177457463171.1008428.692188550544402497.stgit@frogsfrogsfrogs>
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

Create a fuse_main wrapper for fuse services.

Signed-off-by: Darrick J. Wong <djwong@kernel.org>
---
 include/fuse.h         |   33 ++++++++++++++++++++++++++++
 lib/fuse_versionscript |    1 +
 lib/helper.c           |   57 +++++++++++++++++++++++++++++++++++++++++-------
 3 files changed, 83 insertions(+), 8 deletions(-)


diff --git a/include/fuse.h b/include/fuse.h
index 595cac07f2be36..c7dae040857aca 100644
--- a/include/fuse.h
+++ b/include/fuse.h
@@ -1008,6 +1008,39 @@ static inline int fuse_main_fn(int argc, char *argv[],
 #define fuse_main(argc, argv, op, user_data) \
 	fuse_main_fn(argc, argv, op, user_data)
 
+#if FUSE_MAKE_VERSION(3, 19) <= FUSE_USE_VERSION
+struct fuse_service;
+int fuse_service_main_real_versioned(struct fuse_service *service,
+				     int argc, char *argv[],
+				     const struct fuse_operations *op,
+				     size_t op_size,
+				     struct libfuse_version *version,
+				     void *user_data);
+
+/**
+ * Same as fuse_service_main_fn, but takes its information from the mount
+ * service context.
+ */
+static inline int fuse_service_main_fn(struct fuse_service *service,
+				       int argc, char *argv[],
+				       const struct fuse_operations *op,
+				       void *user_data)
+{
+	struct libfuse_version version = {
+		.major  = FUSE_MAJOR_VERSION,
+		.minor  = FUSE_MINOR_VERSION,
+		.hotfix = FUSE_HOTFIX_VERSION,
+		.padding = 0
+	};
+
+	return fuse_service_main_real_versioned(service, argc, argv, op,
+						sizeof(*(op)), &version,
+						user_data);
+}
+#define fuse_service_main(s, argc, argv, op, user_data) \
+	fuse_service_main_fn(s, argc, argv, op, user_data)
+#endif /* FUSE_USE_VERSION >= FUSE_MAKE_VERSION(3, 19) */
+
 /* ----------------------------------------------------------- *
  * More detailed API					       *
  * ----------------------------------------------------------- */
diff --git a/lib/fuse_versionscript b/lib/fuse_versionscript
index 1fc73f417f90a0..43f8bf11b64548 100644
--- a/lib/fuse_versionscript
+++ b/lib/fuse_versionscript
@@ -236,6 +236,7 @@ FUSE_3.19 {
 		fuse_service_exit;
 		fuse_service_expect_mount_mode;
 		fuse_service_finish_file_requests;
+		fuse_service_main_real_versioned;
 		fuse_service_parse_cmdline_opts;
 		fuse_service_receive_file;
 		fuse_service_release;
diff --git a/lib/helper.c b/lib/helper.c
index 533526273207d5..3509f1aa0c8f79 100644
--- a/lib/helper.c
+++ b/lib/helper.c
@@ -15,6 +15,7 @@
 #include "fuse_misc.h"
 #include "fuse_opt.h"
 #include "fuse_lowlevel.h"
+#include "fuse_service.h"
 #include "mount_util.h"
 
 #include <stdio.h>
@@ -357,7 +358,8 @@ int fuse_daemonize(int foreground)
 	return 0;
 }
 
-int fuse_main_real_versioned(int argc, char *argv[],
+int fuse_service_main_real_versioned(struct fuse_service *service,
+			     int argc, char *argv[],
 			     const struct fuse_operations *op, size_t op_size,
 			     struct libfuse_version *version, void *user_data)
 {
@@ -367,8 +369,15 @@ int fuse_main_real_versioned(int argc, char *argv[],
 	int res;
 	struct fuse_loop_config *loop_config = NULL;
 
-	if (fuse_parse_cmdline(&args, &opts) != 0)
-		return 1;
+	if (service) {
+		if (fuse_service_parse_cmdline_opts(&args, &opts) != 0) {
+			res = 1;
+			goto out0;
+		}
+	} else {
+		if (fuse_parse_cmdline(&args, &opts) != 0)
+			return 1;
+	}
 
 	if (opts.show_version) {
 		printf("FUSE library version %s\n", PACKAGE_VERSION);
@@ -405,9 +414,17 @@ int fuse_main_real_versioned(int argc, char *argv[],
 		goto out1;
 	}
 
-	if (fuse_mount(fuse,opts.mountpoint) != 0) {
-		res = 4;
-		goto out2;
+	if (service) {
+		if (fuse_service_session_mount(service, fuse_get_session(fuse),
+					       0, &opts) != 0) {
+			res = 4;
+			goto out2;
+		}
+	} else {
+		if (fuse_mount(fuse, opts.mountpoint) != 0) {
+			res = 4;
+			goto out2;
+		}
 	}
 
 	if (fuse_daemonize(opts.foreground) != 0) {
@@ -421,9 +438,14 @@ int fuse_main_real_versioned(int argc, char *argv[],
 		goto out3;
 	}
 
-	if (opts.singlethread)
+	if (opts.singlethread) {
+		if (service) {
+			fuse_service_send_goodbye(service, 0);
+			fuse_service_release(service);
+		}
+
 		res = fuse_loop(fuse);
-	else {
+	} else {
 		loop_config = fuse_loop_cfg_create();
 		if (loop_config == NULL) {
 			res = 7;
@@ -434,6 +456,12 @@ int fuse_main_real_versioned(int argc, char *argv[],
 
 		fuse_loop_cfg_set_idle_threads(loop_config, opts.max_idle_threads);
 		fuse_loop_cfg_set_max_threads(loop_config, opts.max_threads);
+
+		if (service) {
+			fuse_service_send_goodbye(service, 0);
+			fuse_service_release(service);
+		}
+
 		res = fuse_loop_mt(fuse, loop_config);
 	}
 	if (res)
@@ -448,9 +476,22 @@ int fuse_main_real_versioned(int argc, char *argv[],
 	fuse_loop_cfg_destroy(loop_config);
 	free(opts.mountpoint);
 	fuse_opt_free_args(&args);
+out0:
+	if (service) {
+		fuse_service_send_goodbye(service, res);
+		fuse_service_release(service);
+	}
 	return res;
 }
 
+int fuse_main_real_versioned(int argc, char *argv[],
+			     const struct fuse_operations *op, size_t op_size,
+			     struct libfuse_version *version, void *user_data)
+{
+	return fuse_service_main_real_versioned(NULL, argc, argv, op, op_size,
+						version, user_data);
+}
+
 /* Not symboled, as not part of the official API */
 int fuse_main_real_30(int argc, char *argv[], const struct fuse_operations *op,
 		      size_t op_size, void *user_data);

