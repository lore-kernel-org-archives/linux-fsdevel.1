Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B1D02FD1B3;
	Wed, 29 Apr 2026 14:39:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777473561; cv=none; b=s2Jo8yxo+mRUNZR7Xk8w73d+xMj3PXrsdq5+LFtreLrxsLpS82mklJb7xNy541lbbbkcj+atW30FLSlyNSjBEi86fOaVuCnnd5uRrxVexPW7KryeoGEdfvaZh4axnq4V8+dg+SCADsOBowAeEW+YuF/gGvXaYub+GmqvCgrbwxU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777473561; c=relaxed/simple;
	bh=6zWyEADGqIgaNNmDsuL5SXnOGMpmAxyfQ9j9YojixbA=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YfPHtifA5v3ThlEC4Iu2Z7hIyGuEq7yFhmNozBQj1JhXrZFciWOzIwvAsI5BYjUcRWVEjwkY7S+iqDAeWED8ZUZ04HftUnjE4qawhCGvWNtZKQH4tgDCz907rjGZkde3stQmQWqbjspe3NNOVJ55q7P7AHzRM24TGcXC8CmPLlo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=F34jf4OK; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="F34jf4OK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C72E0C19425;
	Wed, 29 Apr 2026 14:39:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777473560;
	bh=6zWyEADGqIgaNNmDsuL5SXnOGMpmAxyfQ9j9YojixbA=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=F34jf4OKBU7S7Zzts+kEmXgEAdDWhDhMVMSic4dFqP1e8TvI/jHYjZEWzBrYh8GH8
	 LbagUln4+Ygob0nvmMZZWGaNcsq9v2txi/dOTMFNivYvy1STPGQjqDiq8dHAssoL5+
	 jAtRUpGEG345C8XgbLkK1nNZR9EiVygvRzd38XWEOwM+fsAi52QXcSUOTLcnNISKIi
	 Tjwl9iMPXPeWQ+aOqaqBHoDjUhwl4UtN6tEnWB0v7LycjGYD9uduaIs8rfAarjQIxz
	 szPp+53xDXu1JxhtcrcQDlA6Qz0kyUJ/uZfNyfRZHwxRNX6mgFbjZcPxkHfXP1i4g9
	 VNckpj/bJMGCQ==
Date: Wed, 29 Apr 2026 07:39:20 -0700
Subject: [PATCH 01/25] libfuse: bump kernel and library ABI versions
From: "Darrick J. Wong" <djwong@kernel.org>
To: djwong@kernel.org, bernd@bsbernd.com
Cc: miklos@szeredi.hu, linux-fsdevel@vger.kernel.org,
 fuse-devel@lists.linux.dev, joannelkoong@gmail.com, neal@gompa.dev
Message-ID: <177747211584.4104686.885020731568259699.stgit@frogsfrogsfrogs>
In-Reply-To: <177747211463.4104686.1151865355399948078.stgit@frogsfrogsfrogs>
References: <177747211463.4104686.1151865355399948078.stgit@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

From: Darrick J. Wong <djwong@kernel.org>

Bump the kernel ABI version to 7.99 and the libfuse ABI version to 3.99
to start our development.  This patch exists to avoid confusion during
the prototyping stage.

Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
---
 include/fuse_kernel.h  |    5 ++++-
 ChangeLog.rst          |    5 +++++
 lib/fuse_versionscript |    3 +++
 lib/meson.build        |    4 ++--
 meson.build            |    2 +-
 5 files changed, 15 insertions(+), 4 deletions(-)


diff --git a/include/fuse_kernel.h b/include/fuse_kernel.h
index f0dee3d6cf51b0..842cc08a083a6f 100644
--- a/include/fuse_kernel.h
+++ b/include/fuse_kernel.h
@@ -240,6 +240,9 @@
  *  - add FUSE_COPY_FILE_RANGE_64
  *  - add struct fuse_copy_file_range_out
  *  - add FUSE_NOTIFY_PRUNE
+ *
+ *  7.99
+ *  - XXX magic minor revision to make experimental code really obvious
  */
 
 #ifndef _LINUX_FUSE_H
@@ -275,7 +278,7 @@
 #define FUSE_KERNEL_VERSION 7
 
 /** Minor version number of this interface */
-#define FUSE_KERNEL_MINOR_VERSION 45
+#define FUSE_KERNEL_MINOR_VERSION 99
 
 /** The node ID of the root inode */
 #define FUSE_ROOT_ID 1
diff --git a/ChangeLog.rst b/ChangeLog.rst
index 15c998cf1623b8..3cb95081d42d06 100644
--- a/ChangeLog.rst
+++ b/ChangeLog.rst
@@ -1,3 +1,8 @@
+libfuse 3.99-rc0 (2025-12-19)
+===============================
+
+* Add prototypes of iomap and syncfs (djwong)
+
 libfuse 3.18.0 (2025-12-18)
 ===========================
 
diff --git a/lib/fuse_versionscript b/lib/fuse_versionscript
index acd1d28907c614..af17e7ab2d7c88 100644
--- a/lib/fuse_versionscript
+++ b/lib/fuse_versionscript
@@ -247,6 +247,9 @@ FUSE_3.19 {
 		fuse_service_session_unmount;
 } FUSE_3.18;
 
+FUSE_3.99 {
+} FUSE_3.19;
+
 # Local Variables:
 # indent-tabs-mode: t
 # End:
diff --git a/lib/meson.build b/lib/meson.build
index d9a902f74b558f..ff311d4002da0e 100644
--- a/lib/meson.build
+++ b/lib/meson.build
@@ -50,12 +50,12 @@ fusermount_path = join_paths(get_option('prefix'), get_option('bindir'))
 libfuse = library('fuse3',
                   libfuse_sources,
                   version: base_version,
-                  soversion: '4',
+                  soversion: '99',
                   include_directories: include_dirs,
                   dependencies: deps,
                   install: true,
                   link_depends: 'fuse_versionscript',
-                  c_args: [ '-DFUSE_USE_VERSION=319',
+                  c_args: [ '-DFUSE_USE_VERSION=399',
                             '-DFUSERMOUNT_DIR="@0@"'.format(fusermount_path) ],
                   link_args: ['-Wl,--version-script,' + meson.current_source_dir()
                               + '/fuse_versionscript' ])
diff --git a/meson.build b/meson.build
index de038df8d92071..9fa17d08c39b6b 100644
--- a/meson.build
+++ b/meson.build
@@ -1,5 +1,5 @@
 project('libfuse3', ['c'],
-        version: '3.19.0-rc0',
+        version: '3.99.0-rc0',  # Version with RC suffix
         meson_version: '>= 0.60.0',
         default_options: [
             'buildtype=debugoptimized',

