Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3979A331A6E;
	Thu,  3 Sep 2026 02:17:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788401845; cv=none; b=RTcJrJ98isSSuzTOCMSIZpi80aq9Yh0K47uX6wDsPc8mOBJWNdVk1pJMZVWNtx8CR9gsdtFOEJM98gk1Wgut0e36a7fDlRYKAekRdKeSbZIyW7h3EjU1ZUfgkmwV5vkMginOEUBzCPAuaQC1XgaPQNEhXRezXkl+E6VbUekhWpM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788401845; c=relaxed/simple;
	bh=9V9meKK+nlsTtdgyOIBDrYbfmOvrSL+d8jNKzeVDk5Q=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=jW2X6ta/Ebz0j3lwkTy5NqUYdVW546pqVQWdxQV88+OAkPVbMz2BTANgKtgZh2mp2K3g8dA9JlfRW8WJI7qawg2oAnU/JY2BSWsvXJqR7kvPzrXYCIjF5TceL2HHmdS3B0/hSCeSv07GhI3oJxbBDw24hhzdnoR5X3P8ZEuotfI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=uxoEp2z3; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="uxoEp2z3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E70DF1F000E9;
	Thu,  3 Sep 2026 02:17:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux-foundation.org; s=korg; t=1788401841;
	bh=9RbG7VHeuVj53+b3LCtWcmq5nQiRaYTjwCeLdKUdcPM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=uxoEp2z3+eV686EWjn6iSZZJpO2HR/bCDAnlTbTrQgswao0KOZZOP+gfj3puHGzaS
	 KYJJNbCrzCb5bnDCL710Xdt5tn9ifonO8zp2Pbr3REKEinYWV2qWh+7qFHCGd7Db1E
	 vy+JjIqT1tP2LicClpOdpOt+xXb33r9Bkw4+dVyg=
Date: Wed, 2 Sep 2026 19:17:20 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Disha Goel <disgoel@linux.ibm.com>
Cc: Christian Brauner <brauner@kernel.org>, shuah@kernel.org,
 wenyang.linux@foxmail.com, jlayton@kernel.org, jack@suse.cz,
 djwong@kernel.org, aleksa@amutable.com, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] selftests/filesystems: fix missing and stale TARGETS
 entries
Message-Id: <20260902191720.464705fabe41818d747ff3c7@linux-foundation.org>
In-Reply-To: <cecdc333-f58a-4e8b-a3f5-774fd0e69cf7@linux.ibm.com>
References: <20260703150742.58991-1-disgoel@linux.ibm.com>
	<20260706-geerntet-neonlicht-liege-d005ee1904b3@brauner>
	<cecdc333-f58a-4e8b-a3f5-774fd0e69cf7@linux.ibm.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Mon, 31 Aug 2026 15:16:45 +0530 Disha Goel <disgoel@linux.ibm.com> wrote:

> Gentle ping — is this patch merged or queued for a future merge window.
> 

I can help with that ;)

The four Fixes: targets are problematic.  How are backporters to figure
out what kernel version(s) need the patch?

I guess these things crept in over time and a four-patch series would be
too elaborate.

I'll just queue it for 7.3-rcX and will let others figure out the
fallout.

The underlying code has changed somewhat, but the fixups were simple.


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

