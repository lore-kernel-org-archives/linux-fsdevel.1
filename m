Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.222.173
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793891985;
	b=R2Cfhshd0CrMWKOrPhoRhqSMufU8QFmhyhdNvfyL0nhXnXohDzZHXfDn77X26CgK5JGB
	 aLCbIoUSlvcSUsUSWkAfZK1sf4sAkSy1MnYjo/bJKuOqcwoVnS3nzw+WJks2IQR7QnZD+
	 D2LRXYWp0G3FTwk1LZyE7pFY4ZMVYDwukR4XDjj9IN0t7rqQX9Bg1Czi5eibIxNZ8oyys
	 1UBSqS+rBr/Nd72Dsl7KMS2+nFjfruMEAqsIDnj2lZuYeBuAkWHuZQzHU7GVz3m05/x6b
	 BEhSmpDcWVfuklR6HoAtPQDLuk4EkPH6UklEtvpzU8mfBYxErLoKz07E4kYyVutwIng==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793891985;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	 References:In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:
	 X-Developer-Key;
	bh=cRNMxxh4wEFVeDfxqY5yeMLBZP38uw3f4s9uomnABAA=;
	b=cPZ1nIrvGIYcz5zl88M2nmt8eR1xU3wv0BjFlv8VF0+tUzYhP6tQv9FjllFlRM4fmvef
	 tZDH2/qnR/pm/R4fbD1NVbPoy+bANYtRNPN4oHFSGHN7gQpavHjL13tc0PW+xN0Xs1qPl
	 dhTJxraHd6Zx4kRfmKY4NhsGscE+RBnUdZ2vyG1ilR4cQcFK2YDhvdHLYigI+IrMMEkNv
	 661dSVEIvj0jSHeRWTsaZwBupIzjarbc4w6G4q6y/yxURn0zjrMJ3qVxBeCWpsXooTWs7
	 8FdAXQiiVcu6IBxczXj2A376jdmd+d+tqCzT3EfSdJVG4YRGnLY8R3y59XHFYs4GxzA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=toxicpanda.com;
	spf=pass smtp.mailfrom=toxicpanda.com;
	dkim=pass header.d=toxicpanda.com header.i=@toxicpanda.com header.a=rsa-sha256 header.s=google header.b=scTABPmO;
	arc=none smtp.remote-ip=209.85.222.173
Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com [209.85.222.173])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68BDD606D82F
	for <linux-fsdevel@vger.kernel.org>; Thu,  5 Nov 2026 15:19:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 68BDD606D82F
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=toxicpanda.com header.i=@toxicpanda.com header.a=rsa-sha256 header.s=google header.b=scTABPmO
Received: by mail-qk1-f173.google.com with SMTP id af79cd13be357-93ece7a73b9so227276185a.3
        for <linux-fsdevel@vger.kernel.org>; Thu, 05 Nov 2026 07:19:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda.com; s=google; t=1793891984; x=1794496784; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=cRNMxxh4wEFVeDfxqY5yeMLBZP38uw3f4s9uomnABAA=;
        b=scTABPmOCvWmAYDrRi6iogcfDSS2pnLPzZvzKZ6LGspi69Ftyf6HnFnle1fejtG3WZ
         ggkJmYkUjvKrngBQ9d1xSavaJiHXgAqHRxVJwdLr9PTW6wa61YJ7eu5tpBnBpOBZID66
         JY94QzzJ0Iq6Co8YBhMFdTFbEs6AV65RZ1VO71BJIv4WF/wACAQX8fKvRi+M1J3sCIis
         iVeYmXhAFItaJ2yWb46n+YnXO7qQkpB+JEC3RmmhdzjhiB5B5jdsPzXEIoITGe2g+qnL
         xWjQSyrRc95b8QJwkaULRFVIRprTmPYELZQRCOwcas9JNhhrjkyR0fddUgc1VyE6Gjrg
         VabQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793891984; x=1794496784;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=cRNMxxh4wEFVeDfxqY5yeMLBZP38uw3f4s9uomnABAA=;
        b=UhHKp26hIXAQeIrvbMmVW+NZ0H/GLXFEHWJfF75CJJnh+tEgSjnpOXg9IeRbclkL3R
         hWm0rZUhbv2Fi/8uk2V3Gwwcdc+nfkKAfnXz9QL3LXPGSjAfeyP0qDbVHTTI440Tehz1
         h3hR1+phFOOUBNbXhJuQHS1wVGBIpT1Z87P3z90vmsegxc8kKGSRBFsaJfI9btxi1caE
         HWIw+SBIEmKMhLu2LwY+38jfIoYnsT2rGEq4onGq1vwdvIz6kMT1AamCcIAsdBOtN2Ob
         HDLoqQIGUjRzwV0yTNC2eSpaLXAIKcaSpe/eLXAszE73KmrE6T+aP885RGxeext9gq0B
         +2EA==
X-Gm-Message-State: APuU4Z/Oflw5Kix0Qxik+xRWsqEgejTdFVqnERuLU/4Af8CayFAYRyId
	DXq1YpnubSEbzwVsgbAQOjLiuFP2rVGRADq4oUS27a2Xj+KW+XcyUfnflTYlpD19QQ0=
X-Gm-Gg: AYBFou1QnWgkA5CcLaENcaw1a1Og/2T0KiDNnbtxyhybyQ/aQcSauscyV7IwGWiW7Cb
	hQmQczsVRJC9wMQ4MZzX7AYdg3hv1pFBZ5xaxUrOTKi1299WvYvj5zo7UQvVgAK0BLqhd9qerIm
	8JWcLmMNcxQnmpdJUWzpSbZ6wGnDKLCXFl/FkipayJT/w/nsjt7x/Oqk8hs9IjmVco9J1gwKhAj
	77RcKynF/3a9VYq+Hl8+0bejW0BEIkxKRXSdsF+RtrJqf6+2pArQSakPxftR+EkCC+q6ug3R+Aj
	trL00LHJT27I6lu9usyNMFooyTwGN+0aU896FbrIgMi0rN9/Zv0qGsveLaJXlbJXVxwSisLAXgj
	9gvs0vDi2feCySpitesrElAUT4nZZrv8f/VHVHzxyMRqe+So9OkGHYq056vr0pPkP+YmFHTDnh2
	lcej/AeZdvRVKebR6ewA/GTtJb4SofPjVS5z5TqB6v+rM8Y+1NTZSxsjpn228f194kpPwcddUwy
	In0UWUMCFyw6WohrgwNjzhHUwnMziX7l4ShW0kAYvkC5wntz0JOwNjTBGLwP9cSATFyx1Yj0+Ym
	OOgkV4XrXOjrbuG0FCnXnG0A4tm9EBqvNDFTCW5RkFycNQ==
X-Received: by 2002:a05:620a:29ca:b0:93e:c12c:f13e with SMTP id af79cd13be357-944217f9b72mr3087975785a.72.1793891984290;
        Thu, 05 Nov 2026 07:19:44 -0800 (PST)
Received: from toxicpanda.com ([153.61.196.254])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-945d4898a06sm482230185a.42.2026.11.05.07.19.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Nov 2026 07:19:43 -0800 (PST)
From: Josef Bacik <josef@toxicpanda.com>
Date: Thu, 05 Nov 2026 15:02:45 +0000
Subject: [PATCH RFC v3 53/90] cgroup: let a cell change nothing outside its
 budget
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261105-b4-cells-v3-53-bc9095937a84@toxicpanda.com>
References: <20261105-b4-cells-v3-0-bc9095937a84@toxicpanda.com>
In-Reply-To: <20261105-b4-cells-v3-0-bc9095937a84@toxicpanda.com>
To: Christian Brauner <brauner@kernel.org>, 
 James Bottomley <James.Bottomley@HansenPartnership.com>, 
 Andrew Halaney <andrew@amutable.com>, Jeremy Bingham <jbingham@gmail.com>, 
 Tahera Fahimi <taherafahimi@linux.microsoft.com>, 
 Serge Hallyn <sergeh@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Josef Bacik <josef@toxicpanda.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openssh-sha256; t=1793890934; l=6158;
 i=josef@toxicpanda.com; h=from:subject:message-id;
 bh=Ji/ldMlHSXHBr6ItIHuNoiW1mq90yLNc9mjVK6j+aCM=;
 b=U1NIU0lHAAAAAQAAADMAAAALc3NoLWVkMjU1MTkAAAAgUBr36M/n0nWN0DNbnxwzIiCZez6MG
 JiruuNaSCI/zXsAAAAGcGF0YXR0AAAAAAAAAAZzaGE1MTIAAABTAAAAC3NzaC1lZDI1NTE5AAAA
 QHjBgOVuk2qGlVl5Lz1Wo7U633KrRzQnTEOb6yjwlfPKLCjToiMBamHDPkqoUSo7MHzDoysyDKs
 qluC77auZmwg=
X-Developer-Key: i=josef@toxicpanda.com; a=openssh;
 fpr=SHA256:C8kOX2QUJCMqnCX+KEeoqRAjLo9L+ELOSH2NSAJHqGA

Whatever a task of a cell creates is owned by ids that are only lent to
the cell, and must not outlive the cell. The filesystem helpers that
decide whether an id can be stored take care of that, but not everything
in cgroupfs goes through them. Enabling a controller in
cgroup.subtree_control adds files to every child of the cgroup.
cgroup_add_file() assigns those files to the writer, directly through
kernfs.

Below the budget that is fine, because cgroup_cell_budget_put() removes
everything there. Anywhere else the files remain, and would belong to the
next cell that is lent the block. For that to happen, a builder has to
expose more of cgroupfs than the budget, and there has to be a
cgroup.subtree_control out there that the cell can write to. Neither
should be the case. But the rule that a lent id is never left behind
should not depend on nobody making a mistake.

Modes and owners do not help with a cell that has a single id either. It
runs with the id of the user who created it, so it owns every cgroup that
was delegated to that user. It could rename cgroups of a legacy hierarchy,
change their modes, and replace or exhaust the extended attributes that a
service manager keeps on them.

Implement may_change() for cgroupfs. Refuse every change by a task of a
cell to a cgroup that is not within its budget, whatever the mode and the
owner are. The check looks at the task that makes the change, not at the
task that opened the file, because the file may have been passed to the
cell.

No cgroup of a legacy hierarchy is within a budget, so a task of a cell
cannot change anything there.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 include/linux/cell.h            |  7 +++++++
 kernel/cell/boundary.c          | 26 ++++++++++++++++++++++++++
 kernel/cgroup/cgroup-internal.h |  1 +
 kernel/cgroup/cgroup-v1.c       |  1 +
 kernel/cgroup/cgroup.c          | 19 +++++++++++++++++++
 5 files changed, 54 insertions(+)

diff --git a/include/linux/cell.h b/include/linux/cell.h
index 0c3c65b93f2b..2107cd3c994b 100644
--- a/include/linux/cell.h
+++ b/include/linux/cell.h
@@ -242,4 +242,11 @@ bool cell_may_migrate(struct task_struct *task, struct cgroup *dst);
 static inline bool cell_may_migrate(struct task_struct *t, struct cgroup *d) { return true; }
 #endif
 
+/* A task of a cell changes nothing outside of the budget. */
+#ifdef CONFIG_CELLS
+bool cell_may_change_cgroup(struct cgroup *cgrp);
+#else
+static inline bool cell_may_change_cgroup(struct cgroup *cgrp) { return true; }
+#endif
+
 #endif /* _LINUX_CELL_H */
diff --git a/kernel/cell/boundary.c b/kernel/cell/boundary.c
index 251a8516e76a..3f5cc898dc48 100644
--- a/kernel/cell/boundary.c
+++ b/kernel/cell/boundary.c
@@ -34,3 +34,29 @@ bool cell_may_migrate(struct task_struct *task, struct cgroup *dst)
 	budget = READ_ONCE(cell->budget);
 	return budget && cgroup_is_descendant(dst, budget);
 }
+
+/**
+ * cell_may_change_cgroup - may the caller change a cgroup?
+ * @cgrp: the cgroup
+ *
+ * A task of a cell changes nothing outside of the budget of the cell, whatever
+ * the modes say and whoever owns the cgroup, which a cell of one id does if its
+ * maker does. It writes to no file, makes, removes and renames no cgroup, and
+ * sets no mode, owner, time or extended attribute. See cgroup_may_change() for
+ * where this is asked.
+ *
+ * What it makes is owned by ids that were only lent to the cell. Some of that is
+ * made without the filesystem being asked whether it can store the id, such as
+ * the files that enabling a controller adds to the children of a cgroup. So it
+ * has to be where it goes with the cell, see cgroup_cell_budget_put().
+ *
+ * It goes by who is asking and not by who opened the file, which may have been
+ * handed to the cell.
+ *
+ * Return: true if the caller is in no cell, or @cgrp is the budget of its cell or
+ * lies below it.
+ */
+bool cell_may_change_cgroup(struct cgroup *cgrp)
+{
+	return cell_may_migrate(current, cgrp);
+}
diff --git a/kernel/cgroup/cgroup-internal.h b/kernel/cgroup/cgroup-internal.h
index 233fb8b45d2c..71744b453df5 100644
--- a/kernel/cgroup/cgroup-internal.h
+++ b/kernel/cgroup/cgroup-internal.h
@@ -258,6 +258,7 @@ int cgroup_lock_and_drain_offline(struct cgroup *cgrp);
 
 int cgroup_mkdir(struct kernfs_node *parent_kn, const char *name, umode_t mode);
 int cgroup_rmdir(struct kernfs_node *kn);
+int cgroup_may_change(struct kernfs_node *kn, enum kernfs_change what);
 int cgroup_show_path(struct seq_file *sf, struct kernfs_node *kf_node,
 		     struct kernfs_root *kf_root);
 
diff --git a/kernel/cgroup/cgroup-v1.c b/kernel/cgroup/cgroup-v1.c
index 216a2dcdde86..4c27e63774e6 100644
--- a/kernel/cgroup/cgroup-v1.c
+++ b/kernel/cgroup/cgroup-v1.c
@@ -1145,6 +1145,7 @@ struct kernfs_syscall_ops cgroup1_kf_syscall_ops = {
 	.mkdir			= cgroup_mkdir,
 	.rmdir			= cgroup_rmdir,
 	.show_path		= cgroup_show_path,
+	.may_change		= cgroup_may_change,
 };
 
 /*
diff --git a/kernel/cgroup/cgroup.c b/kernel/cgroup/cgroup.c
index 3fc1f9ac2268..accae30a901d 100644
--- a/kernel/cgroup/cgroup.c
+++ b/kernel/cgroup/cgroup.c
@@ -6488,11 +6488,30 @@ int cgroup_rmdir(struct kernfs_node *kn)
 	return ret;
 }
 
+/* Whatever the modes say, and whoever owns it. */
+int cgroup_may_change(struct kernfs_node *kn, enum kernfs_change what)
+{
+	struct cgroup *cgrp;
+
+	if (likely(!current_cell()))
+		return 0;
+
+	/* @kn may have been removed, and the cgroup may be on its way out. */
+	guard(rcu)();
+	if (kernfs_type(kn) != KERNFS_DIR)
+		kn = rcu_dereference(kn->__parent);
+	cgrp = rcu_dereference(*(void __rcu __force **)&kn->priv);
+	if (!cgrp || !cell_may_change_cgroup(cgrp))
+		return -EPERM;
+	return 0;
+}
+
 static struct kernfs_syscall_ops cgroup_kf_syscall_ops = {
 	.show_options		= cgroup_show_options,
 	.mkdir			= cgroup_mkdir,
 	.rmdir			= cgroup_rmdir,
 	.show_path		= cgroup_show_path,
+	.may_change		= cgroup_may_change,
 };
 
 static void __init cgroup_init_subsys(struct cgroup_subsys *ss, bool early)

-- 
2.55.0

