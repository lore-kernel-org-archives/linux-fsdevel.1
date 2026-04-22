Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A30F34F48E;
	Wed, 22 Apr 2026 23:21:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776900118; cv=none; b=tMOHTbg0Kc6MTfv7jfpcTfGXzBXdV8lspaomLwFiDLFOpyb3sLd5Vz7MmpuZ76e+dXdGk94NJSkvECDK1mj2YVo0qQ6A4xOjl7I5By7qc26+uiSDKNc5wLQP3wA862w8LejNhHSkoSs/21R93v2H0JWWEX1MOoNvR7vrxSfmlWU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776900118; c=relaxed/simple;
	bh=UNCbDvUix/6fcD3ir7GQaG2O0AXlLax60sqntYviLZM=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=llGmQqjh2wbinWfdsa6kYUeMBo3nTVFCNztqKDRhIX9D5y6Y+eddYFgVFJgPB2pCpo0HaeT9Ppf49iWHPPb+xplEnpX7MpyE6da9za1+3MiMvRq1VbKyFv2VnjP5NzL0nIKrMTs/5FoX1J45zIc1N068qXX23k2dYA9qrsj+Wi8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rrmyNUQe; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rrmyNUQe"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3EC56C19425;
	Wed, 22 Apr 2026 23:21:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776900118;
	bh=UNCbDvUix/6fcD3ir7GQaG2O0AXlLax60sqntYviLZM=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=rrmyNUQeE2SWb9UwUEQjJ4rItMz6S2xlxCEqnv3LqGFhmH3TcPReBiBCK1eBj0Kkx
	 4z/i6EvwltZdLAJ/2RgzqplTn2Ypjtp8wRBctMXhFV8/UvBM3bKlj18lPA50qhLrfr
	 KB86JytoWJMJqtjXlx6j1EajnEtYOvv2mRlN34/bDp9uyQz5Vqe9Oc1hY2Z87G+Xj6
	 C7WZ89ofpsFp/Ktyw5Ps3wN/tQyCl1Q/svqR3IeF2IESQ6mKPqpqxXsjH3XKUiMuNK
	 q0lKRoj8TMv+4Cs42OMz62G96jIh+P19eZnUr2rtGbGkdqH57r1h7HScXIJtBaJ7iq
	 R7+MnXSIgVP8w==
Date: Wed, 22 Apr 2026 16:21:57 -0700
Subject: [PATCH 10/13] mount_service: allow installation as a setuid program
From: "Darrick J. Wong" <djwong@kernel.org>
To: djwong@kernel.org, bernd@bsbernd.com
Cc: neal@gompa.dev, linux-fsdevel@vger.kernel.org, joannelkoong@gmail.com,
 miklos@szeredi.hu, fuse-devel@lists.linux.dev
Message-ID: <177689988720.3820166.15604780601293995595.stgit@frogsfrogsfrogs>
In-Reply-To: <177689988489.3820166.4979104167640003535.stgit@frogsfrogsfrogs>
References: <177689988489.3820166.4979104167640003535.stgit@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

From: Darrick J. Wong <djwong@kernel.org>

Allow installation of the mount service helper as a setuid program so
that regular users can access containerized filesystem drivers.

Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
---
 README.md              |    3 +++
 test/ci-build.sh       |   14 ++++++++++++++
 util/install_helper.sh |    6 ++++++
 util/meson.build       |    3 ++-
 4 files changed, 25 insertions(+), 1 deletion(-)


diff --git a/README.md b/README.md
index 6cf23cd870109a..92b85522e7890a 100644
--- a/README.md
+++ b/README.md
@@ -98,6 +98,9 @@ Security implications
 
 The *fusermount3* program is installed setuid root. This is done to
 allow normal users to mount their own filesystem implementations.
+If built, the *fuservicemount3* program will also be installed setuid
+root so that normal users can access containerized filesystem
+implementations.
 
 To limit the harm that malicious users can do this way, *fusermount3*
 enforces the following limitations:
diff --git a/test/ci-build.sh b/test/ci-build.sh
index 8b019a0b5e52c1..f6e6c3d9de4e4e 100755
--- a/test/ci-build.sh
+++ b/test/ci-build.sh
@@ -60,11 +60,18 @@ non_sanitized_build()
 
         # libfuse will first try the install path and then system defaults
         sudo chmod 4755 ${PREFIX_DIR}/bin/fusermount3
+        test -x "${PREFIX_DIR}/sbin/fuservicemount3" && \
+                sudo chmod 4755 ${PREFIX_DIR}/sbin/fuservicemount3
 
         # also needed for some of the tests
         sudo chown root:root util/fusermount3
         sudo chmod 4755 util/fusermount3
 
+        if [ -x util/fuservicemount3 ]; then
+                sudo chown root:root util/fuservicemount3
+                sudo chmod 4755 util/fuservicemount3
+        fi
+
         ${TEST_CMD}
         popd
         rm -fr build-${CC}
@@ -101,11 +108,18 @@ sanitized_build()
     ninja
     sudo env PATH=$PATH ninja install
     sudo chmod 4755 ${PREFIX_DIR}/bin/fusermount3
+    test -x "${PREFIX_DIR}/sbin/fuservicemount3" && \
+        sudo chmod 4755 ${PREFIX_DIR}/sbin/fuservicemount3
 
     # also needed for some of the tests
     sudo chown root:root util/fusermount3
     sudo chmod 4755 util/fusermount3
 
+    if [ -x util/fuservicemount3 ]; then
+        sudo chown root:root util/fuservicemount3
+        sudo chmod 4755 util/fuservicemount3
+    fi
+
     # Test as root and regular user
     sudo env PATH=$PATH ${TEST_CMD}
     # Cleanup temporary files (since they are now owned by root)
diff --git a/util/install_helper.sh b/util/install_helper.sh
index 76f2b47fe6c8f9..4c6f9dc3dc70aa 100755
--- a/util/install_helper.sh
+++ b/util/install_helper.sh
@@ -11,6 +11,7 @@ bindir="$2"
 udevrulesdir="$3"
 useroot="$4"
 initscriptdir="$5"
+sbindir="$6"
 
 # Both sysconfdir and bindir are absolute paths (since they are joined
 # with --prefix in meson.build), but need to be interpreted relative
@@ -31,6 +32,11 @@ if $useroot; then
     chown root:root "${DESTDIR}${bindir}/fusermount3"
     chmod u+s "${DESTDIR}${bindir}/fusermount3"
 
+    if [ -e "${DESTDIR}${sbindir}/fuservicemount3" ]; then
+        chown root:root "${DESTDIR}${sbindir}/fuservicemount3"
+        chmod u+s "${DESTDIR}${sbindir}/fuservicemount3"
+    fi
+
     if test ! -e "${DESTDIR}/dev/fuse"; then
         mkdir -p "${DESTDIR}/dev"
         mknod "${DESTDIR}/dev/fuse" -m 0666 c 10 229
diff --git a/util/meson.build b/util/meson.build
index 85b54d5d322dcb..e15dd9bbb0c486 100644
--- a/util/meson.build
+++ b/util/meson.build
@@ -46,4 +46,5 @@ meson.add_install_script('install_helper.sh',
                          join_paths(get_option('prefix'), get_option('bindir')),
                          udevrulesdir,
                          '@0@'.format(get_option('useroot')),
-                         get_option('initscriptdir'))
+                         get_option('initscriptdir'),
+                         join_paths(get_option('prefix'), get_option('sbindir')))

