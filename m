Received: from mta1.migadu.com (out-235.mta1.migadu.com [95.215.58.235])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3915B495051
	for <linux-fsdevel@vger.kernel.org>; Wed,  2 Sep 2026 12:51:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.235
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788353514; cv=none; b=D9/kpq24sq9p5RsPa9LtpRSc71Heh7YBYIGWTshRQGuUZuSJttBulK+KqDLnXd48tLmoMdkNf4grmaamR4ZvQpSfi1YyVwpQq8JD+WNaicPLKrOmtge+YocxalEukN49QfNR+covZi64xdFUL90PJcn6YijcKXdhko7LgFfQXx4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788353514; c=relaxed/simple;
	bh=tpDxEjwAM4Z3tcZlQ8FduIdTuWHyaHUuGyRrq6OnN2s=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=NTBT07KFx9yD0wU1apj5ACHUvzZ71XGNna2m9+UUmP0Zm+kjDTAzHqvNCOdfJgsezoPFBF3g1/2TNOeOe3vwv5J4UTJX+KtzJNfQOwpfCF6gh4Nfis9fwElRcS8rlHjQJOpPTWHiMt5COKZEMrE8d7B/OpC71la+YB3A2j4bfJc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=X0UDvp9o; arc=none smtp.client-ip=95.215.58.235
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="X0UDvp9o"
X-Envelope-To: linux-fsdevel@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=tpDxEjwAM4Z3tcZlQ8FduIdTuWHyaHUuGyRrq6OnN2s=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1788353508; v=1; x=1788958308;
 b=X0UDvp9owiQsJm/X2vB0jS198NLYIH/HsFxS13fa3tteUr0hmQM6thLpmRPSuLUHhr6ETCir
 oJT4iSMhH0FmxSZceX5y4yr+kg4bs72Jj8UeSnUgEde36ueBGDYzgkYSGU0jaiw3gNv71JXQ27f
 u1qblRCD0ZvzmsdrB9hcXxFs=
X-Envelope-To: linux-fsdevel@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 1a541c8069397e4d;
	Wed, 02 Sep 2026 12:51:48 +0000
X-Mizu-Trace-ID: 1a541c8069397e4d
X-Migadu-Flow: FLOW_OUT
From: Tao Cui <cui.tao@linux.dev>
To: linux-fsdevel@vger.kernel.org,
	jlayton@kernel.org,
	cel@kernel.org
Cc: alex.aring@gmail.com,
	viro@zeniv.linux.org.uk,
	brauner@kernel.org,
	linux-kernel@vger.kernel.org,
	avagin@openvz.org,
	khorenko@virtuozzo.com,
	bcodding@redhat.com,
	cui.tao@linux.dev,
	Tao Cui <cuitao@kylinos.cn>
Subject: [PATCH v2] fs/locks: filter OFD locks from /proc/locks for foreign pid namespaces
Date: Wed,  2 Sep 2026 20:51:39 +0800
Message-ID: <20260902125139.975253-1-cui.tao@linux.dev>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Tao Cui <cuitao@kylinos.cn>

Since Linux 4.9, /proc/locks only shows locks whose owning process is
visible in the reader's pid namespace.  The check cannot see the
owner of an OFD lock, though: locks_translate_pid() always returns
-1 for FL_OFDLCK, so an OFD lock held outside of that namespace
bypasses the filter and is shown with its device/inode numbers and
byte range, e.g.

    4: OFDLCK ADVISORY  WRITE -1 fd:00:70536961 0 EOF

This was observed on a Kubernetes node: a pod reading /proc/locks
listed the OFD write lock of an unrelated host process, while the
POSIX locks of the very same process were correctly hidden.  The
device/inode pair identifies which host file is locked, the byte
range discloses where it is actively written, and the
appearance/disappearance of entries reflects host task activity,
contrary to the documented per-pidns visibility of /proc/locks
(proc_locks(5)).

OFD locks record the owner tgid in flc_pid, so use it for the
visibility decision in locks_show(), mirroring what
locks_translate_pid() does for POSIX locks.  The pid column is still
reported as -1 for OFD locks; only the filter decision changes.
Remote locks keep their negative flc_pid and stay visible as before.

Verified with an OFD and a POSIX write lock held in the initial pid
namespace while a process in a fresh pid namespace reads /proc/locks:
the OFD entry is visible without this patch and hidden with it, the
POSIX entry is hidden in both cases.

Signed-off-by: Tao Cui <cuitao@kylinos.cn>

---

Changes since v1: keep remote OFD locks (negative flc_pid) visible in
non-initial pid namespaces, as locks_translate_pid() does for remote
POSIX locks.
---
 fs/locks.c | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/fs/locks.c b/fs/locks.c
index 6e4ff7fcec05..4af1385682e4 100644
--- a/fs/locks.c
+++ b/fs/locks.c
@@ -3022,6 +3022,25 @@ static int locks_show(struct seq_file *f, void *v)
 
 	cur = hlist_entry(v, struct file_lock_core, flc_link);
 
+	/*
+	 * OFD locks are reported with pid -1, so the filter below cannot see
+	 * their owner; flc_pid holds the owner tgid, so filter on it.
+	 * Remote locks keep a negative flc_pid and stay visible as before.
+	 */
+	if ((cur->flc_flags & FL_OFDLCK) && cur->flc_pid > 0 &&
+	    proc_pidns != &init_pid_ns) {
+		struct pid *pid;
+		bool visible = false;
+
+		rcu_read_lock();
+		pid = find_pid_ns(cur->flc_pid, &init_pid_ns);
+		if (pid)
+			visible = pid_nr_ns(pid, proc_pidns) != 0;
+		rcu_read_unlock();
+		if (!visible)
+			return 0;
+	}
+
 	if (locks_translate_pid(cur, proc_pidns) == 0)
 		return 0;
 
-- 
2.43.0

