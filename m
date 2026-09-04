Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B9B0495054
	for <linux-fsdevel@vger.kernel.org>; Fri,  4 Sep 2026 18:37:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788547021; cv=none; b=j3O9Swe3B/GOVK6XTXRiDfEKCJ9y9/kKCfskQAIEBJTKaFkLxVO9A28FWfECsRNkQCMTKERT5nqfveND4qpAszzu0StPgovn3K2E8jPYNRsUljDZ99DBXgDrZav9ZfKWRgyZhO2b4psecY54ftwyiiBbgwulOgsa0RFmzJ4kTA0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788547021; c=relaxed/simple;
	bh=qsR0Xm8dALXPKBNDagamM1xEiloNNnbPk4UfV/Jp74U=;
	h=Date:To:From:Subject:Message-Id; b=p6HVDVPFzBtIuLavKF7rp386p/q9NRZbKXqv0S2Bi1w1rgKTsSNy9CFJ1yKiCjmtLo2X2Wo7X6nXtgrFa7K0fzoVYzfT0P1JgwE2CeeBXVLg1F+x2nDtx/E70fTN3SsqbUlpNFZBOPQAbDg8p05JPo4PnV+V34jGZ3qVhwnGOqE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=V0t9PS+q; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="V0t9PS+q"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B81CD1F00A3D;
	Fri,  4 Sep 2026 18:36:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux-foundation.org; s=korg; t=1788547019;
	bh=U3hljtUw4C/9Cl2ryGYaJ35lFH6GYP2suJCef5NwhwU=;
	h=Date:To:From:Subject;
	b=V0t9PS+qtoBfVX6LXy+rUmnRL1ZM4evYOirYGqRsM418OxQUYTWFRdOVJqd7i1euc
	 cLWjseab33S70s8EalUm/IGkgeE4vUiGtwM6Wy4k251sYLwkkrRaTffok9cGoqm1M7
	 TTV6d4QY4kjAMSRYngyFTZzHjcgXtjRT9zIUUF4o=
Date: Fri, 04 Sep 2026 11:36:59 -0700
To: wenyang.linux@foxmail.com,shuah@kernel.org,jlayton@kernel.org,jack@suse.cz,djwong@kernel.org,disgoel@linux.ibm.com,akpm@linux-foundation.org,linux-fsdevel@vger.kernel.org,brauner@kernel.org,akpm@linux-foundation.org
From: Andrew Morton <akpm@linux-foundation.org>
Subject: [patch 1/1] selftests/filesystems: fix missing and stale TARGETS entries
Message-Id: <20260904183659.B81CD1F00A3D@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>

From: Disha Goel <disgoel@linux.ibm.com>
Subject: selftests/filesystems: fix missing and stale TARGETS entries
Date: Fri, 3 Jul 2026 20:37:42 +0530

filesystems/eventfd, filesystems/open_tree_ns and filesystems/xattr were
never added to TARGETS when introduced.  filesystems/openat2 was moved
from selftests/openat2/ but the TARGETS entry was never updated, leaving a
stale entry pointing at a directory that no longer exists.

Fix this by adding the four missing subdirectories to TARGETS and
removing the stale openat2 entry.

Link: https://lore.kernel.org/20260703150742.58991-1-disgoel@linux.ibm.com
Fixes: 7c37857fc23a ("selftests: add eventfd selftests")
Fixes: b8f7622aa6e3 ("selftests/open_tree: add OPEN_TREE_NAMESPACE tests")
Fixes: 7e28fef5d4db ("selftests/xattr: path-based AF_UNIX socket xattr tests")
Fixes: fe087927046c ("selftests: move openat2 tests to selftests/filesystems/")
Signed-off-by: Disha Goel <disgoel@linux.ibm.com>
Reviewed-by: Christian Brauner (Amutable) <brauner@kernel.org>
Cc: "Darrick J. Wong" <djwong@kernel.org>
Cc: Jan Kara <jack@suse.cz>
Cc: Jeff Layton <jlayton@kernel.org>
Cc: Shuah Khan <shuah@kernel.org>
Cc: Wen Yang <wenyang.linux@foxmail.com>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---

 tools/testing/selftests/Makefile |    5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

--- a/tools/testing/selftests/Makefile~selftests-filesystems-fix-missing-and-stale-targets-entries
+++ a/tools/testing/selftests/Makefile
@@ -35,8 +35,11 @@ TARGETS += fchmodat2
 TARGETS += filesystems
 TARGETS += filesystems/binderfs
 TARGETS += filesystems/epoll
+TARGETS += filesystems/eventfd
 TARGETS += filesystems/failfs
 TARGETS += filesystems/fat
+TARGETS += filesystems/openat2
+TARGETS += filesystems/open_tree_ns
 TARGETS += filesystems/overlayfs
 TARGETS += filesystems/statmount
 TARGETS += filesystems/mount-notify
@@ -47,6 +50,7 @@ TARGETS += filesystems/empty_mntns
 TARGETS += filesystems/fsmount_ns
 TARGETS += filesystems/fscontext_ns
 TARGETS += filesystems/mntns_cleanup
+TARGETS += filesystems/xattr
 TARGETS += firmware
 TARGETS += fpu
 TARGETS += ftrace
@@ -103,7 +107,6 @@ TARGETS += prctl
 TARGETS += proc
 TARGETS += pstore
 TARGETS += ptrace
-TARGETS += openat2
 TARGETS += rdma
 TARGETS += resctrl
 TARGETS += riscv
_
