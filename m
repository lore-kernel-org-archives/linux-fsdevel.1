Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFB63353EDB;
	Fri, 13 Feb 2026 10:44:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770979488; cv=none; b=rX5fd2aRS0ZhLNhH+9P7kRt+VCSBsBnSrPG8mtLNBbgWnbom0VsscmkHG8V4Krjkzk7hEZ2jTQzoMeIjEuSseyYCIkTq34P0nz56ajA/L1mROneyYBtsmo/u6hYCnVBae8wVocJKuoCnABBMtSW4HBhMdtb+xPcssUD+GCfY9iQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770979488; c=relaxed/simple;
	bh=LpgbViYueVfs8znDGiGm/oh4caXky7ehWf+alC0Sk7c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Toz1rhiE/ZqMM3raZVxs1seHdl1Am0ui9W+WANPFCMAuOObBAjr4mzY7+ocYZPaHxVuM+x4CkLndW7O6K5w64BqKMjMLfXhdWU8tKdrySg3746fN+OJDD2EkIF2xKJejhLUHT2KAVhTAW9xLP+zFc282pceVA8YuN77s7r0Uv3Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eEhY8TjU; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eEhY8TjU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A7353C4AF09;
	Fri, 13 Feb 2026 10:44:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770979488;
	bh=LpgbViYueVfs8znDGiGm/oh4caXky7ehWf+alC0Sk7c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=eEhY8TjUTmLFtA8f763ww2my/jgDgDJfIzvXY/7RMR8CEjtGqAtm6rnRqDjCZB/jE
	 PlxfiZrxwoBRux5oASg5MBzvuWuFuzTTWcKLvKbZNg2z+g72Cezz/KnGdf1ACZhC/T
	 acl0rjpnm0JOTP5iXaYdlPxATCNvGbmyCt0XN2ZU/VrGnYAWrF//Uo6FXb+o9Lzoy3
	 yLxyc134uWJKgYn3+d3ecrGbC9KgD4oOKqa6pu/MFAa4K/80xip+dDF4dT9Gl69jdF
	 UADi2mb2JaCaqmpKdQa09CaIoCcQnHN0pdJDs9YYdyE00RZNugs0YhY6h61oWLHe9s
	 YLekbm9Dr0R6A==
From: Alexey Gladkov <legion@kernel.org>
To: Christian Brauner <brauner@kernel.org>,
	Dan Klishch <danilklishch@gmail.com>
Cc: Al Viro <viro@zeniv.linux.org.uk>,
	"Eric W . Biederman" <ebiederm@xmission.com>,
	Kees Cook <keescook@chromium.org>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v8 1/5] docs: proc: add documentation about mount restrictions
Date: Fri, 13 Feb 2026 11:44:26 +0100
Message-ID: <654e021422520a7b25df0cc8591b7643519585fa.1770979341.git.legion@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1770979341.git.legion@kernel.org>
References: <cover.1768295900.git.legion@kernel.org> <cover.1770979341.git.legion@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

procfs has a number of mounting restrictions that are not documented
anywhere.

Signed-off-by: Alexey Gladkov <legion@kernel.org>
---
 Documentation/filesystems/proc.rst | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/Documentation/filesystems/proc.rst b/Documentation/filesystems/proc.rst
index 8256e857e2d7..c8864fcbdec7 100644
--- a/Documentation/filesystems/proc.rst
+++ b/Documentation/filesystems/proc.rst
@@ -52,6 +52,7 @@ fixes/update part 1.1  Stefani Seibold <stefani@seibold.net>    June 9 2009
 
   4	Configuring procfs
   4.1	Mount options
+  4.2	Mount restrictions
 
   5	Filesystem behavior
 
@@ -2410,6 +2411,19 @@ will use the calling process's active pid namespace. Note that the pid
 namespace of an existing procfs instance cannot be modified (attempting to do
 so will give an `-EBUSY` error).
 
+4.2	Mount restrictions
+--------------------------
+
+If user namespaces are in use, the kernel additionally checks the instances of
+procfs available to the mounter and will not allow procfs to be mounted if:
+
+  1. This mount is not fully visible.
+
+     a. It's root directory is not the root directory of the filesystem.
+     b. If any file or non-empty procfs directory is hidden by another mount.
+
+  2. A new mount overrides the readonly option or any option from atime familty.
+
 Chapter 5: Filesystem behavior
 ==============================
 
-- 
2.53.0

