Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.222.170
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793891919;
	b=wRcoszRtvNoVXDqqjQHCN6Ya2DmfhRH8bGGLNyDR+x0NQC8dfq8/+CiirvfIxsk5BNPJ
	 ZxFGXN5R56buxvE8en7atPaRDz1qMAdvGXl5B3SfuFDJ/B5gCwMP+GuRAHQCODVr87Ljm
	 EDZHV7KqjeYa/me/kWrB2s7T5cmMlxd/AVCNi0WteO6oexykGEC3lrfUHN0cODKADZyLP
	 IvLeYaOuiU+EVXGCYm/1Zdek4ExI0pnU76M29uDMPNA9SkLW5c+qT2CH1X2YwMuQHuf3o
	 hC8UdJBLeQMUgl0mCxUVZgHuzU7DTBMye1YMPfIwKEBSQ8gIkriRQGiLsVVqMZJhGDA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793891919;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	 References:In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:
	 X-Developer-Key;
	bh=u3Saw14AeNgoLrMRw2Q0vFBfX7A0xbhwSu2a1hU09AU=;
	b=SWLGENLQA0w+iCMN0Wn0vHDfI5akFHzdVi2XOjkkW8lXHOv5P4fdt7OmOI07MqylT4k6
	 pP0Lj0RUbQnPJOEdk9MWd54mqEZ7VP9YHbQoJWQvjEro8wmo5uCNXKKhPzRVY8GKZAJ0W
	 Z83VWIfwRmoYQPmoUsjOwxpfIN49RZBDSkFVT1Z0r3G3dcxClL6NAnHyGAiPJ7vTB/PWI
	 OTBPQ5nHu2uzVxPxblBt4MK7Clz+IIlPKboYEzGgNaQQbXlcwpFRk2tR4WDXh411d6F0u
	 JI0Uzovdtnru8j4IDZx5NZmhphS8F5cyA8jYPLiRwh2wY3N3zH2Vh+fycp+cQcI5M6w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=toxicpanda.com;
	spf=pass smtp.mailfrom=toxicpanda.com;
	dkim=pass header.d=toxicpanda.com header.i=@toxicpanda.com header.a=rsa-sha256 header.s=google header.b=Gt3lxpbr;
	arc=none smtp.remote-ip=209.85.222.170
Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com [209.85.222.170])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4B3C606A32C
	for <linux-fsdevel@vger.kernel.org>; Thu,  5 Nov 2026 15:18:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D4B3C606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=toxicpanda.com header.i=@toxicpanda.com header.a=rsa-sha256 header.s=google header.b=Gt3lxpbr
Received: by mail-qk1-f170.google.com with SMTP id af79cd13be357-93e6eb77f0bso207663085a.3
        for <linux-fsdevel@vger.kernel.org>; Thu, 05 Nov 2026 07:18:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda.com; s=google; t=1793891918; x=1794496718; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=u3Saw14AeNgoLrMRw2Q0vFBfX7A0xbhwSu2a1hU09AU=;
        b=Gt3lxpbra0j6Niq/bpy+vrflzf18A2h77H4PNPD4TWwuv6bzk+uzh+u1NPe5lrPp5W
         y+NEp8iqCUuvz1YJI8f4pwNnBmpppgMFVxUCVidpTnTKpc21fLLdp5bCNiPEoGXsOy43
         QebM1p1Q5iILszZ+C+6VYGnhFVgSMra90MtxZ/UJA17cowvhamMjK9o+4dN63V8qZjN2
         wK2pD2PLVDjIDrdmgkj0fits9GA8cQ+jSmNLBSEzkTi1KICvVXQRjxtaaaBX91Jkir4+
         CGR5+XlAPVvuGrx22PaFNyoROjdP6TypuZVEEBD9TxmCly4UiARxLTAjyoINqm7xCrf5
         pWmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793891918; x=1794496718;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=u3Saw14AeNgoLrMRw2Q0vFBfX7A0xbhwSu2a1hU09AU=;
        b=YsFBhOkUaCC0y8YSMaVvLQ4+slTdljHckx47Tv0twh4ONAA7WMiMCPF6tRhSe4RPOw
         c+2zgSaAqMYoaSyyT4AfSHJiqKoD67rm/CiqL0QHWVcvuADjJj/hWqG3DF1CQHpSbPD4
         Tp/O09jHJgt0d80jrUn5QmZ6zuWsevXsn99U3Axz8gZ+Be46kFrZ19K+8+6qf5eCmFod
         06AMIs/Na1Y8RvIgv6WzRCWF1Vedg+0juu9QDBQrQwqHuM9czbWK66OE0Px28yfK4xFc
         WzlMMjUK6wmNzsXcBklh+WndYi/dVDvDVvwr5a6lV9AcEYX+mBhxOJk1uHzBtYWFn1zb
         JAjQ==
X-Gm-Message-State: APuU4Z9r6GR3tC5ZEsHw6h2DUtBKSdV3Ug04/IX0kNcMTALk1qGYT5NL
	/ansOeAnRezV6O1DlkDT0R7ZcNmLv3ZxJ0+pyEAH3R8sxEl5SZ0PST3JES+GSL0QCzA=
X-Gm-Gg: AYBFou0TDpGqPFiPwiPQNV3vMCCtZvq7Irkbw4UOvma6eFqBa5x8gvwdIIsPRlAg0rV
	TvaWsCL8+L0wcTyA84IIjP2kkLOdf9yZnwaqeFd9EWjKFxTW4Fm0bITsI4GWfQpkWY/j/GPdGQM
	GsIFVzxD2EUPg3SmPmA6xwV72YOesBBo4oecvITDouhEbOIRZNLZaNgYARnBQSo9r6v+nJ59Rur
	PLHAqXSjt7mwRcIRpdcnvWG/QtbkRh12pkb/cUCK0mid0GKbb8D88bFKzzyA831Vj6K7OdMxa6w
	+flt8TVWayDHFHqaiiEp5t6CN85YwfOphoKSTWYngKTW0fG3SeijAb0G+fOgmJlFbe+sju+pjOw
	i1bIBIbo3WwkwJHP7s3UBh3qWR8C4edYnSWZr2Ow+MEV6VLKxmj5EKapVsnBI0skjybroK6v5+S
	CUjBpgXS3jEM6Vcw1ymFMSrwL8Ec+XQw5Lyru7qsAs+hPNgJjKFvjlidx+OGk3jT+2KqGJ4FSn6
	pKXasc74s+/OmRo1O23+ew5SpQty02e4Hm0HcX5HzQG1M4eDy3BuI1/dl1ynfucJOHgh7HJZB7P
	FXpkt3yDpamzCCgB/2MP4/unInbRuGQepsqH3xQnFqD8
X-Received: by 2002:a05:620a:800d:b0:93f:3219:835f with SMTP id af79cd13be357-94421841ad6mr3361715885a.81.1793891917573;
        Thu, 05 Nov 2026 07:18:37 -0800 (PST)
Received: from toxicpanda.com ([153.61.196.254])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91e7e7b1e92sm49240606d6.45.2026.11.05.07.18.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Nov 2026 07:18:36 -0800 (PST)
From: Josef Bacik <josef@toxicpanda.com>
Date: Thu, 05 Nov 2026 15:02:42 +0000
Subject: [PATCH RFC v3 50/90] cgroup: keep a task of a cell within the
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
Message-Id: <20261105-b4-cells-v3-50-bc9095937a84@toxicpanda.com>
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
X-Developer-Signature: v=1; a=openssh-sha256; t=1793890934; l=4379;
 i=josef@toxicpanda.com; h=from:subject:message-id;
 bh=T7zyIF7UbMMeZS9+88t4AtANJYB/cFwa9D3UlpPBUuM=;
 b=U1NIU0lHAAAAAQAAADMAAAALc3NoLWVkMjU1MTkAAAAgUBr36M/n0nWN0DNbnxwzIiCZez6MG
 JiruuNaSCI/zXsAAAAGcGF0YXR0AAAAAAAAAAZzaGE1MTIAAABTAAAAC3NzaC1lZDI1NTE5AAAA
 QM24hXwhuMLzhhwRhvGOjKJ62CBtWUxeM2ESIv3i6wH6s0H+iEmduanxaWi5mfOEQ9Q2M5WbnJi
 z5EOEMWsH7gw=
X-Developer-Key: i=josef@toxicpanda.com; a=openssh;
 fpr=SHA256:C8kOX2QUJCMqnCX+KEeoqRAjLo9L+ELOSH2NSAJHqGA

The kernel finds the tasks of a cell through the budget. A task that got
out of the budget would survive a kill, and the cell would be reported
dead while that task is still running.

Refuse to migrate a task of a cell out of the budget, no matter who asks.
Refuse CLONE_INTO_CGROUP by a task of a cell if the target is outside of
the budget. On every other hierarchy, refuse to move the task away from
the cgroup it was born in.

The kernel itself may still move such a task. cgroup_transfer_tasks()
empties a legacy cpuset that has lost its last cpu, and those tasks have
to go somewhere. It does not operate on the default hierarchy, so it never
touches a budget.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 include/linux/cell.h   |  7 +++++++
 kernel/cell/Makefile   |  1 +
 kernel/cell/boundary.c | 36 ++++++++++++++++++++++++++++++++++++
 kernel/cgroup/cgroup.c | 13 +++++++++++++
 4 files changed, 57 insertions(+)

diff --git a/include/linux/cell.h b/include/linux/cell.h
index 86999efc083d..0c3c65b93f2b 100644
--- a/include/linux/cell.h
+++ b/include/linux/cell.h
@@ -235,4 +235,11 @@ void cell_init_exited(struct cell *cell, struct task_struct *tsk);
 static inline void cell_init_exited(struct cell *cell, struct task_struct *tsk) { }
 #endif
 
+/* A task of a cell stays within the budget. */
+#ifdef CONFIG_CELLS
+bool cell_may_migrate(struct task_struct *task, struct cgroup *dst);
+#else
+static inline bool cell_may_migrate(struct task_struct *t, struct cgroup *d) { return true; }
+#endif
+
 #endif /* _LINUX_CELL_H */
diff --git a/kernel/cell/Makefile b/kernel/cell/Makefile
index 1a2dcd469d10..0e5bc34808db 100644
--- a/kernel/cell/Makefile
+++ b/kernel/cell/Makefile
@@ -3,3 +3,4 @@ obj-y += core.o
 obj-y += slots.o
 obj-y += ids.o
 obj-y += spawn.o
+obj-y += boundary.o
diff --git a/kernel/cell/boundary.c b/kernel/cell/boundary.c
new file mode 100644
index 000000000000..251a8516e76a
--- /dev/null
+++ b/kernel/cell/boundary.c
@@ -0,0 +1,36 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Cells: what other subsystems ask about the boundary of a cell.
+ */
+#include <linux/cgroup.h>
+#include <linux/user_namespace.h>
+#include <uapi/linux/cell.h>
+
+#include "internal.h"
+
+/**
+ * cell_may_migrate - may a task be moved to a cgroup?
+ * @task: the task
+ * @dst:  the cgroup
+ *
+ * A task of a cell stays within the budget of the cell, whoever asks. On a
+ * hierarchy other than that of the budget no request moves it from where it was
+ * born. This is asked for every request. It is not asked when the kernel itself
+ * empties a legacy cpuset that lost its last cpu, see cgroup_transfer_tasks(),
+ * which works on legacy hierarchies only and so never touches a budget.
+ *
+ * Return: true if @task is in no cell, or @dst is the budget of its cell or
+ * lies below it.
+ */
+bool cell_may_migrate(struct task_struct *task, struct cgroup *dst)
+{
+	struct cgroup *budget;
+	struct cell *cell;
+
+	guard(rcu)();
+	cell = task_cell(task);
+	if (!cell)
+		return true;
+	budget = READ_ONCE(cell->budget);
+	return budget && cgroup_is_descendant(dst, budget);
+}
diff --git a/kernel/cgroup/cgroup.c b/kernel/cgroup/cgroup.c
index d3a36b586cd3..1286f5d318b0 100644
--- a/kernel/cgroup/cgroup.c
+++ b/kernel/cgroup/cgroup.c
@@ -3102,6 +3102,14 @@ int cgroup_attach_task(struct cgroup *dst_cgrp, struct task_struct *leader,
 	struct task_struct *task;
 	int ret = 0;
 
+	/*
+	 * A task of a cell stays within the cell's budget, whoever asks. On
+	 * any other hierarchy no request moves it from where it was born. The
+	 * kernel itself may, with cgroup_transfer_tasks(), out of a legacy
+	 * cpuset that lost its last cpu. That never touches a budget.
+	 */
+	if (!cell_may_migrate(leader, dst_cgrp))
+		return -EPERM;
 	/* look up all src csets */
 	spin_lock_irq(&css_set_lock);
 	task = leader;
@@ -7011,6 +7019,11 @@ static int cgroup_css_set_fork(struct kernel_clone_args *kargs)
 		goto err;
 	}
 
+	/* A task of a cell stays within the cell's budget, children and all. */
+	if (!cell_may_migrate(current, dst_cgrp)) {
+		ret = -EPERM;
+		goto err;
+	}
 	/*
 	 * Verify that we the target cgroup is writable for us. This is
 	 * usually done by the vfs layer but since we're not going through

-- 
2.55.0

