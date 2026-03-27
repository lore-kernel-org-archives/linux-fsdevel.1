Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB72F2D541B
	for <linux-fsdevel@vger.kernel.org>; Fri, 27 Mar 2026 01:28:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774574890; cv=none; b=jCqyDF1A+uHfDEdxCQS39Sfn6+AjU4nh3tZpiJQhxLjXAq2epBEs/xqXx1px32xbyWmiy+hLYXz1RF/mATiCBsy+JRAjTd1QoFoqW2SZTVaYwEaa5WrJxjm/TfOnwv477KdwDyMBqE51dn6gTFvjcktvAAw2KVvVi0n02+Kn43Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774574890; c=relaxed/simple;
	bh=5D0HfYoWaGRemtxvnzJ1X/Sc3YrkNGXQ2aFoppbgfiU=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ucmjmBjtWOzkbY6B89sVRR633WV1roUZgz+ZczLEvJxxgDR2CjDhqp7fnNX1hDcuCz9DKE0ezTMHNJkEYZl/4+RPvK4/mLiIvdNLMD6vcFhjxKDcuUSMi8MDtfGbY8ivDg+E6/n3Rv9aPafvgCU0oRyjWFcY8yAmSKq+NExt32E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ihHzzHmy; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ihHzzHmy"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5E34EC116C6;
	Fri, 27 Mar 2026 01:28:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774574890;
	bh=5D0HfYoWaGRemtxvnzJ1X/Sc3YrkNGXQ2aFoppbgfiU=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=ihHzzHmyOXCySa7wrHffrbhzSBACCvdv/dJbgHcYP3u9Fe0xP3ax2JbLA/VNtr+ni
	 Iaia/bopYrfyb8Rmjc8m0lSvmvqA/NKZdHmKWvjzn/Oyhm3+Qejl31jfc4+GbYdxbE
	 eQcHodeGVSY2853EM1spz4Ux56vkfkkgWYxRuVXvlX9njBr1jMw4SYgot/6EByv+OG
	 EkNTvepujXh+gj40td7AB71VaTJ10Z2XavHrUsyT1QCQ1O4XE4KytbFcTDdTPMUNei
	 eOIG1+UYO4i6s8sq+jI5UatQsDl0/GIX6eZS+KbK9D1wbw1PJbpqgxi//efeTPNr9P
	 FJRYAfOjmfp0A==
Date: Thu, 26 Mar 2026 18:28:09 -0700
Subject: [PATCH 13/17] mount_service: allow installation as a setuid program
From: "Darrick J. Wong" <djwong@kernel.org>
To: djwong@kernel.org, bschubert@ddn.com
Cc: linux-fsdevel@vger.kernel.org, bernd@bsbernd.com, miklos@szeredi.hu,
 neal@gompa.dev, joannelkoong@gmail.com
Message-ID: <177457463352.1008428.7765384137409374319.stgit@frogsfrogsfrogs>
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

Allow installation of the mount service helper as a setuid program so
that regular users can access containerized filesystem drivers.

Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
---
 README.md              |    3 +++
 test/ci-build.sh       |    7 +++++++
 util/install_helper.sh |    6 ++++++
 util/meson.build       |    3 ++-
 4 files changed, 18 insertions(+), 1 deletion(-)


diff --git a/README.md b/README.md
index bcf1210e6a23fa..b692a6f6915635 100644
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
index 8b019a0b5e52c1..6fddcb6bc42d72 100755
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
diff --git a/util/install_helper.sh b/util/install_helper.sh
index 76f2b47fe6c8f9..1c076739b8bfd8 100755
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
 
+    if [ -x "${DESTDIR}${sbindir}/fuservicemount3" ]; then
+        chown root:root "${DESTDIR}${sbindir}/fuservicemount3"
+        chmod u+s "${DESTDIR}${sbindir}/fuservicemount3"
+    fi
+
     if test ! -e "${DESTDIR}/dev/fuse"; then
         mkdir -p "${DESTDIR}/dev"
         mknod "${DESTDIR}/dev/fuse" -m 0666 c 10 229
diff --git a/util/meson.build b/util/meson.build
index 1741d2843ad074..efc188194b3816 100644
--- a/util/meson.build
+++ b/util/meson.build
@@ -44,4 +44,5 @@ meson.add_install_script('install_helper.sh',
                          join_paths(get_option('prefix'), get_option('bindir')),
                          udevrulesdir,
                          '@0@'.format(get_option('useroot')),
-                         get_option('initscriptdir'))
+                         get_option('initscriptdir'),
+                         join_paths(get_option('prefix'), get_option('sbindir')))

