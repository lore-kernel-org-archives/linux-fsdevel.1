Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A5E138A738
	for <linux-fsdevel@vger.kernel.org>; Thu,  9 Apr 2026 22:23:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775773390; cv=none; b=hd7OKIEHT2MTvXAxIv6VqvbDccXsReVywxjUcdCWJSYOL3mo/iNE8mvvBrseqXok/wohWRMruygRCtY3XgfMO1KNwfqz+fB06Lg3rIe33fk7g1rkzKw4VH0iObg/b1EpLNaNBvAU3vmSUzOkCdLlostXkXEdVjbQjAUD8II3Z54=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775773390; c=relaxed/simple;
	bh=9hbxj4FYpowIqwvvaj9u4yPtIbDxGGTNmVEHjpXTxZ8=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=k08QViE/WdxjWDQ8MVlMoTPlIMRF2dPAaLPXrqIHwdHnqlimwKXWDgMwiMeCLBmN1BBrEvqxiChyncTnN36YRmbeeHJBKH8WikihuH6CUHlhiHnXtBNTlvlYCuWl+ZbqKisIP7Li1lA22tqyNioBNDz42eQVLDyHR8bvt9MuAPU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=S6vp66c7; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="S6vp66c7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CECE6C4CEF7;
	Thu,  9 Apr 2026 22:23:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775773389;
	bh=9hbxj4FYpowIqwvvaj9u4yPtIbDxGGTNmVEHjpXTxZ8=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=S6vp66c7kEBBd6udv+FfVzNMqTq7sbY00vC5901kT0kq6VnTpnxZ+t7ibvmZUezmH
	 BxSr4IxjBB+/c0EInVRgyN7Tt6Csby3ytKylBSqs6x9fuFcFbSJ7kjEssCVJhzluPn
	 TJRvM55YCMfnpIrD/iOxKwtSkItnGC2/NwMz/tarwKvtA9j8ZBUuXaGG7aKm6pMnCk
	 HSHun4JVxVxJbed/wL77i4jS4yqYStDGAHKmBrdCpx3yLtOYt4uryDkNLBrWIFkaz1
	 NGaUZKorAq4781zdT9L8Ks+7R4eAUaV6XAdyvHaP0Mtf3JQA0HgQ10ZwvKP6p/ekbb
	 RBZlZ19dk9FDw==
Date: Thu, 09 Apr 2026 15:23:09 -0700
Subject: [PATCH 10/13] mount_service: allow installation as a setuid program
From: "Darrick J. Wong" <djwong@kernel.org>
To: djwong@kernel.org, bschubert@ddn.com
Cc: miklos@szeredi.hu, neal@gompa.dev, linux-fsdevel@vger.kernel.org,
 bernd@bsbernd.com, joannelkoong@gmail.com
Message-ID: <177577270394.2064074.3287109636193996200.stgit@frogsfrogsfrogs>
In-Reply-To: <177577270167.2064074.16504004857564657756.stgit@frogsfrogsfrogs>
References: <177577270167.2064074.16504004857564657756.stgit@frogsfrogsfrogs>
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

