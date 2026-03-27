Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1049030DD1C
	for <linux-fsdevel@vger.kernel.org>; Fri, 27 Mar 2026 01:27:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774574875; cv=none; b=VnMIb39MqntTxNKcee654EVI5j+7ohFE/j8oQpXggOtZ9AvbddTBsiCmCTurEclFXMjMBwre9v8nJWJiWMt4ME2jcmmmVLI0mIScp0tqIM+Ol47NzU9a3+o7kxMuig7n0+xy2NyBO1x3pfellJqyyEWPfj8jRJavd7DrYjPaM5Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774574875; c=relaxed/simple;
	bh=sZvbAAoLX6MMs8UmZwBWoB88rdKjClt5XNHyqaQXPT0=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hpoJroJzfmke0uAOfW9O8e0XyTHfi2KibvhIHMedLFUf5bL2NA3oG6w8BVQSLECRF76daDGny4CZu+ytCXsgZKxZup04fq1cr8nrxn8LZHUNMGmsPKpG4v0sZ1iVuZn32WKrB1sBgnmnVljU5O2KKffP3X0HX2TFTYZaa58t9J0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=THu6+sDo; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="THu6+sDo"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A957FC116C6;
	Fri, 27 Mar 2026 01:27:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774574874;
	bh=sZvbAAoLX6MMs8UmZwBWoB88rdKjClt5XNHyqaQXPT0=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=THu6+sDoYw/Mneu0sfBOXGE26TlI7T3DtnFurVOqdbjS7dKnrFRMBdhfBXjOVzfnX
	 oLcnJMOYksECcELQZi7WNoZTziHaK5Xdzrqf+8RoYT3IMNvekEY6uUw49+fXmjtE2o
	 zgQRoiystcHa7EYbKrbc3phU/zu6phCxkbRLtNzTBnw7z68cXr3lUxU7EbDHIAphAp
	 9wlUu23Tgnf7kINVlQmybdZCCR5WmFphFH3a3b0qH/66JB1CoB4Bdmzo+etXdAOoun
	 BI5gnP7dxLjE7Zmjb7SlF+R8lR2J46hmp4KGASifisYca0nTVDml+e3xboVEOkU/kq
	 NCjSKgnMhnmdQ==
Date: Thu, 26 Mar 2026 18:27:54 -0700
Subject: [PATCH 12/17] mount.fuse3: integrate systemd service startup
From: "Darrick J. Wong" <djwong@kernel.org>
To: djwong@kernel.org, bschubert@ddn.com
Cc: linux-fsdevel@vger.kernel.org, bernd@bsbernd.com, miklos@szeredi.hu,
 neal@gompa.dev, joannelkoong@gmail.com
Message-ID: <177457463335.1008428.1944341460263677597.stgit@frogsfrogsfrogs>
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

Teach mount.fuse3 how to start fuse via systemd service, if present.

Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
---
 util/mount_service.h  |    8 +++++++
 doc/fuservicemount3.8 |   10 ++++++++
 util/fuservicemount.c |   48 +++++++++++++++++++++++++++++++++++++++++
 util/meson.build      |   12 +++++++---
 util/mount.fuse.c     |   58 +++++++++++++++++++++++++++++++------------------
 util/mount_service.c  |   18 +++++++++++++++
 6 files changed, 128 insertions(+), 26 deletions(-)


diff --git a/util/mount_service.h b/util/mount_service.h
index 2b670c5569aa88..f02e08b9976b17 100644
--- a/util/mount_service.h
+++ b/util/mount_service.h
@@ -29,4 +29,12 @@ int mount_service_main(int argc, char *argv[]);
  */
 const char *mount_service_subtype(const char *fstype);
 
+/**
+ * Discover if there is a fuse service socket for the given fuse subtype.
+ *
+ * @param subtype the subtype of a fuse filesystem type (e.g. Y from fuse.Y)
+ * @return true if available, false if not
+ */
+bool mount_service_present(const char *subtype);
+
 #endif /* MOUNT_SERVICE_H_ */
diff --git a/doc/fuservicemount3.8 b/doc/fuservicemount3.8
index e45d6a89c8b81a..aa2167cb4872c6 100644
--- a/doc/fuservicemount3.8
+++ b/doc/fuservicemount3.8
@@ -7,12 +7,20 @@ .SH SYNOPSIS
 .B mountpoint
 .BI -t " fstype"
 [
-.I options
+.BI -o " options"
 ]
+
+.B fuservicemount3
+.BI -t " fstype"
+.B --check
+
 .SH DESCRIPTION
 Mount a filesystem using a FUSE server that runs as a socket service.
 These servers can be contained using the platform's service management
 framework.
+
+The second form checks if there is a FUSE service available for the given
+filesystem type.
 .SH "AUTHORS"
 .LP
 The author of the fuse socket service code is Darrick J. Wong <djwong@kernel.org>.
diff --git a/util/fuservicemount.c b/util/fuservicemount.c
index 9c694a4290f94e..d39d9c486c8997 100644
--- a/util/fuservicemount.c
+++ b/util/fuservicemount.c
@@ -9,10 +9,58 @@
  * This program wraps the mounting of FUSE filesystems that run in systemd
  */
 #define _GNU_SOURCE
+#include <stdbool.h>
+#include <stdio.h>
+#include <string.h>
+#include <stdlib.h>
 #include "fuse_config.h"
 #include "mount_service.h"
 
+static int check_service(const char *fstype)
+{
+	const char *subtype;
+
+	if (!fstype) {
+		fprintf(stderr,
+			"fuservicemount: expected fs type for --check\n");
+		return EXIT_FAILURE;
+	}
+
+	subtype = mount_service_subtype(fstype);
+	return mount_service_present(subtype) ? EXIT_SUCCESS : EXIT_FAILURE;
+}
+
 int main(int argc, char *argv[])
 {
+	char *fstype = NULL;
+	bool check = false;
+	int i;
+
+	/*
+	 * If the user passes us exactly the args -t FSTYPE --check then
+	 * we'll just check if there's a service for the FSTYPE fuse server.
+	 */
+	for (i = 1; i < argc; i++) {
+		if (!strcmp(argv[i], "--check")) {
+			if (check) {
+				check = false;
+				break;
+			}
+			check = true;
+		} else if (!strcmp(argv[i], "-t") && i + 1 < argc) {
+			if (fstype) {
+				check = false;
+				break;
+			}
+			fstype = argv[i + 1];
+			i++;
+		} else {
+			check = false;
+			break;
+		}
+	}
+	if (check)
+		return check_service(fstype);
+
 	return mount_service_main(argc, argv);
 }
diff --git a/util/meson.build b/util/meson.build
index 47c5f8ac213675..1741d2843ad074 100644
--- a/util/meson.build
+++ b/util/meson.build
@@ -6,21 +6,25 @@ executable('fusermount3', ['fusermount.c', '../lib/mount_util.c', '../lib/util.c
            install_dir: get_option('bindir'),
            c_args: '-DFUSE_CONF="@0@"'.format(fuseconf_path))
 
+mount_service_sources = []
+mount_service_cflags = []
 if private_cfg.get('HAVE_SERVICEMOUNT', false)
-  executable('fuservicemount3', ['mount_service.c', 'fuservicemount.c', '../lib/mount_util.c', 'fuser_conf.c'],
+  mount_service_sources += ['mount_service.c', '../lib/mount_util.c', 'fuser_conf.c']
+  mount_service_cflags += ['-DFUSE_CONF="@0@"'.format(fuseconf_path)]
+  executable('fuservicemount3', ['fuservicemount.c'] + mount_service_sources,
              include_directories: include_dirs,
              link_with: [ libfuse ],
              install: true,
              install_dir: get_option('sbindir'),
-             c_args: ['-DFUSE_USE_VERSION=317', '-DFUSE_CONF="@0@"'.format(fuseconf_path)])
+             c_args: ['-DFUSE_USE_VERSION=317'] + mount_service_cflags)
 endif
 
-executable('mount.fuse3', ['mount.fuse.c'],
+executable('mount.fuse3', ['mount.fuse.c'] + mount_service_sources,
            include_directories: include_dirs,
            link_with: [ libfuse ],
            install: true,
            install_dir: get_option('sbindir'),
-           c_args: '-DFUSE_USE_VERSION=317')
+           c_args: ['-DFUSE_USE_VERSION=317'] + mount_service_cflags)
 
 
 udevrulesdir = get_option('udevrulesdir')
diff --git a/util/mount.fuse.c b/util/mount.fuse.c
index f1a90fe8abae7c..b6a55eebb7f88b 100644
--- a/util/mount.fuse.c
+++ b/util/mount.fuse.c
@@ -49,6 +49,9 @@
 #endif
 
 #include "fuse.h"
+#ifdef HAVE_SERVICEMOUNT
+# include "mount_service.h"
+#endif
 
 static char *progname;
 
@@ -280,9 +283,7 @@ int main(int argc, char *argv[])
 	mountpoint = argv[2];
 
 	for (i = 3; i < argc; i++) {
-		if (strcmp(argv[i], "-v") == 0) {
-			continue;
-		} else if (strcmp(argv[i], "-t") == 0) {
+		if (strcmp(argv[i], "-t") == 0) {
 			i++;
 
 			if (i == argc) {
@@ -303,6 +304,39 @@ int main(int argc, char *argv[])
 					progname);
 				exit(1);
 			}
+		}
+	}
+
+	if (!type) {
+		if (source) {
+			dup_source = xstrdup(source);
+			type = dup_source;
+			source = strchr(type, '#');
+			if (source)
+				*source++ = '\0';
+			if (!type[0]) {
+				fprintf(stderr, "%s: empty filesystem type\n",
+					progname);
+				exit(1);
+			}
+		} else {
+			fprintf(stderr, "%s: empty source\n", progname);
+			exit(1);
+		}
+	}
+
+#ifdef HAVE_SERVICEMOUNT
+	/*
+	 * Now that we know the desired filesystem type, see if we can find
+	 * a socket service implementing that.
+	 */
+	if (mount_service_present(type))
+		return mount_service_main(argc, argv);
+#endif
+
+	for (i = 3; i < argc; i++) {
+		if (strcmp(argv[i], "-v") == 0) {
+			continue;
 		} else	if (strcmp(argv[i], "-o") == 0) {
 			char *opts;
 			char *opt;
@@ -366,24 +400,6 @@ int main(int argc, char *argv[])
 	if (suid)
 		options = add_option("suid", options);
 
-	if (!type) {
-		if (source) {
-			dup_source = xstrdup(source);
-			type = dup_source;
-			source = strchr(type, '#');
-			if (source)
-				*source++ = '\0';
-			if (!type[0]) {
-				fprintf(stderr, "%s: empty filesystem type\n",
-					progname);
-				exit(1);
-			}
-		} else {
-			fprintf(stderr, "%s: empty source\n", progname);
-			exit(1);
-		}
-	}
-
 	if (setuid_name && setuid_name[0]) {
 #ifdef linux
 		if (drop_privileges) {
diff --git a/util/mount_service.c b/util/mount_service.c
index 6e53447e1d65be..8f199ca18346cc 100644
--- a/util/mount_service.c
+++ b/util/mount_service.c
@@ -1511,3 +1511,21 @@ int mount_service_main(int argc, char *argv[])
 	mount_service_destroy(&mo);
 	return ret;
 }
+
+bool mount_service_present(const char *fstype)
+{
+	struct stat stbuf;
+	char path[PATH_MAX];
+	int ret;
+
+	snprintf(path, sizeof(path), FUSE_SERVICE_SOCKET_DIR "/%s", fstype);
+	ret = stat(path, &stbuf);
+	if (ret)
+		return false;
+
+	if (!S_ISSOCK(stbuf.st_mode))
+		return false;
+
+	ret = access(path, R_OK | W_OK);
+	return ret == 0;
+}

