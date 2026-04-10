Received: from outbound.baidu.com (jpmx.baidu.com [119.63.196.201])
	by smtp.subspace.kernel.org (Postfix) with SMTP id 4E4CF322522;
	Fri, 10 Apr 2026 08:09:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=119.63.196.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775808583; cv=none; b=Tma73poKzXkcGo2vYsKfLzBilGUc2W1pXLKOaO0wSTd8MpffGYw2pwE3VrWayeQI3ELH0QN+FQalFSjc4Wv3Aj/PRf8MgmwAjeljFIocsCea/2v4IHBkqOLh1FEW/RI1Y6CiD1azYEn3ML6S7m5sXWy1vC++dcd5dn1qEMyiGyY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775808583; c=relaxed/simple;
	bh=U3T3Nmt8WQngqYwW23gJAjqWivbPR/W82jaF38xPcrQ=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=T4uyjlhAjuG1vqkrp58mkSyRZ0yKfOto8D1NdXdFehjiqEnDQpbg9sDu03HeRxCO60AcIpUaEWDQcS65iP7Hy6i06UHTNXHnH2JITA9qTDTQKSfbxDH5hLWHMK+2e6dpT5JDy5pLXpJNIoPI+lOJo5F3Z55KoAZdvO0KG/abxNc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=baidu.com; spf=pass smtp.mailfrom=baidu.com; dkim=pass (2048-bit key) header.d=baidu.com header.i=@baidu.com header.b=IfPgkFB+; arc=none smtp.client-ip=119.63.196.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=baidu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baidu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baidu.com header.i=@baidu.com header.b="IfPgkFB+"
X-MD-Sfrom: lirongqing@baidu.com
X-MD-SrcIP: 172.31.50.47
From: lirongqing <lirongqing@baidu.com>
To: Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner
	<brauner@kernel.org>, Jan Kara <jack@suse.cz>, Kees Cook <kees@kernel.org>,
	<linux-fsdevel@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-mm@kvack.org>
CC: Li RongQing <lirongqing@baidu.com>
Subject: [PATCH] fs/coredump: reduce redundant log noise in validate_coredump_safety
Date: Fri, 10 Apr 2026 04:09:18 -0400
Message-ID: <20260410080918.2319-1-lirongqing@baidu.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: bjhj-exc3.internal.baidu.com (172.31.3.13) To
 bjkjy-exc3.internal.baidu.com (172.31.50.47)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=baidu.com;
	s=selector1; t=1775808569;
	bh=XVCGD+rFsf43XDlKVku2Aq26Sh7eivzVMrrFZLWXJH8=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type;
	b=IfPgkFB+sc6OWsS1ZWYHvMKOYEqCT1w3AieFwYEv9HlKJBcj22RwlKihb1QdyNcXy
	 oHjN7tPwQ0MgWM4311uB3/A7SkX4TsbXrTWqn/qk+yLd2V7+UwsPFBu+VF1HC9jy4g
	 2M3p4BAiPkRmgK+Iz27NM/z/r3Q63EK6NxbMi3nHhgan+MxDfsaJpd+NiEjfx9AQeF
	 9UsNoRk6oNXqHaD8I5iDMjo1BGA4JyjcoOv+sYyKE0o71cH4qB+teMCYbD3u5UmEav
	 R0h07/sd8sYxPm2Z4TAVYOqhiF+tfFdoUq85PYfKu3GnusNPRsyPDHbiJeUPi7ejle
	 6x8e4t5CvgDuA==

From: Li RongQing <lirongqing@baidu.com>

Currently, writing to 'core_pattern' or 'suid_dumpable' sysctl nodes
always triggers validate_coredump_safety(), even if the values have
not changed. This results in redundant warning messages in dmesg:

"Unsafe core_pattern used with fs.suid_dumpable=2..."

This patch optimizes the procfs handlers to only invoke the safety
validation when an actual change in the configuration is detected:

1. In proc_dostring_coredump(), compare the new core_pattern string
   with the existing one using strncmp().
2. In proc_dointvec_minmax_coredump(), check if the new suid_dumpable
   value differs from the previous one.

This keeps the kernel log clean from repetitive warnings when
re-applying the same sysctl settings.

Signed-off-by: Li RongQing <lirongqing@baidu.com>
---
 fs/coredump.c | 3 ++-
 fs/exec.c     | 6 ++++--
 2 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/fs/coredump.c b/fs/coredump.c
index 29df8aa..9b357d2 100644
--- a/fs/coredump.c
+++ b/fs/coredump.c
@@ -1483,7 +1483,8 @@ static int proc_dostring_coredump(const struct ctl_table *table, int write,
 		return -EINVAL;
 	}
 
-	validate_coredump_safety();
+	if (strncmp(old_core_pattern, core_pattern, CORENAME_MAX_SIZE))
+		validate_coredump_safety();
 	return error;
 }
 
diff --git a/fs/exec.c b/fs/exec.c
index 9ea3a77..32b46e4 100644
--- a/fs/exec.c
+++ b/fs/exec.c
@@ -1975,9 +1975,11 @@ COMPAT_SYSCALL_DEFINE5(execveat, int, fd,
 static int proc_dointvec_minmax_coredump(const struct ctl_table *table, int write,
 		void *buffer, size_t *lenp, loff_t *ppos)
 {
-	int error = proc_dointvec_minmax(table, write, buffer, lenp, ppos);
+	int error, old = READ_ONCE(suid_dumpable);
 
-	if (!error && write)
+	error = proc_dointvec_minmax(table, write, buffer, lenp, ppos);
+
+	if (!error && write && (old != READ_ONCE(suid_dumpable)))
 		validate_coredump_safety();
 	return error;
 }
-- 
2.9.4

