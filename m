Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.219.46
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793890713;
	b=gxOzMximqiIOAGCjIfDaTZcNyM1MCwKM/c2UPt3PJoMp8+D1vKpXK3z8XnDp2bU7nJjm
	 Uh1VhWKf0x+Gbaotnu31iwHR/oAp5sDALtcr5zzg+4bp3g/1hzAr8yE1BuYlt4pmpju1J
	 894R7P5D3uHSKZfLdYZrE8hIIB/0ePPHW+Lrwa7J+Hy1z5DJ2/9vGefXxkYVXcr5Je82s
	 PX2UXsqZlNqzFnPxt9S3pK6ZKIRPdELJvy+WqYkDgZcmdWZuVgnHyJWBeRy3yFVMwkyAP
	 j5mV8JilDQz9LHaFGv0w6qit9iwx5p6SH0VoX4/HQLsc9VxPBIcgyEV5N7W3RnjiIbQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793890713;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	 References:In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:
	 X-Developer-Key;
	bh=MGaILMQfdt4chI3i7y0XG67rqkk49m3Gf84vXa5blcw=;
	b=5EVyzfaY8HkUPkxCrHWLUwZwacEL9SPwmYjTiD/kaN6zg52ut/SGg8vdB+na5ZDlN7Jp
	 oLM/8vrQLIoTlHNP6UN0nA8r8MZdDPshS9n0/pdW67lqkYFlU0pF2yrMoW4gmwQJ+7P8l
	 b6QpvXX+lJ4vLIb2Dt62S0ywh3cGSdqNKa1rQidWJHmwbkKWBnSf5NRJFhUimdbesNeii
	 UsweF5JMbl30Nv4YYTEDryRsiXoa1/JLZppLJCx3K0DmsDIhuTXvFD3Vipqq2i6T/0giN
	 z6XJ4l2Ocq/kBjbLlRCM9lac+0f9WMCTPAaz3h4BCkzoBwG9xyTuRne23Q+lOxtAiXw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=toxicpanda.com;
	spf=pass smtp.mailfrom=toxicpanda.com;
	dkim=pass header.d=toxicpanda.com header.i=@toxicpanda.com header.a=rsa-sha256 header.s=google header.b=ARBGbxGY;
	arc=none smtp.remote-ip=209.85.219.46
Received: from mail-qv1-f46.google.com (mail-qv1-f46.google.com [209.85.219.46])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2779560A2620
	for <linux-fsdevel@vger.kernel.org>; Thu,  5 Nov 2026 14:58:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2779560A2620
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=toxicpanda.com header.i=@toxicpanda.com header.a=rsa-sha256 header.s=google header.b=ARBGbxGY
Received: by mail-qv1-f46.google.com with SMTP id 6a1803df08f44-91c11468b5fso20184516d6.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 05 Nov 2026 06:58:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda.com; s=google; t=1793890712; x=1794495512; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=MGaILMQfdt4chI3i7y0XG67rqkk49m3Gf84vXa5blcw=;
        b=ARBGbxGYZf8apk2d3UWc46lm8VDLjyKnGemvEZq1gKWSENKQGdufwjisYxk+ADl96Z
         99t5TzcoFXakO4O3xNZjOU8QtyKSPe4XlR/9ilMgfnmAno6DVz2tmqL+SLKbQLCB5w8+
         2Y5SBy2Zdb+nm7ineKqnXb48hNn7aQNQllIQ2zzEyghxHCWbPC0uISs0s4lAS4bYVFuf
         L0CzsoRdl4BB176KTv5EvU5zbf+VeLf1Q+BaFcJbqFSRNqHAE/cT3pRl+Ovteqfcz5CN
         LULJqd1rzBXwP1FDxfdJivq9VWGtmblhkL7+F1Ox2UvfFZBhUdUeCUtI5RbCgBnatjV8
         MxGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793890712; x=1794495512;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=MGaILMQfdt4chI3i7y0XG67rqkk49m3Gf84vXa5blcw=;
        b=EcCBq3sFiMdiIBWWbvcfn+icr1Pa5BDRGIPUDycvqj3RnMd58RkxVBD83006buZ35g
         EUEvlWbh+qdovaBVk247VCtIce+rcK2sHQzqub3zns6NrhCI9DnnfMxPQPTgYEW033zP
         vc5zqwiTKT7v6bNgMr0pQEdAWgqAyMbMZHfgFK59w8cCURsfeSeQheoOK7YKAhnaAUbQ
         qgiRtlq8WsVayKI18xrobntCJzFBvvEWcMK8tsqx+sTTbrUEgg54WujvNa96jn4wIZRG
         lqbUsbF1BPh8bKaxcFBGQ9gzpo1nJkKTILvq7V4FGJ7DWpleX00ESw/BwzrHLdyD+QxQ
         NcIw==
X-Gm-Message-State: APuU4Z/gKi5OdAQmS+mCP75/We3tTimOrUqVyWmqe5+FwTR5qL88xa3C
	EKmQB1rDF6y/fsjBW/GHCt8Gi6K03ROKXnwpPGWcB4NZy8SEjWK82iFWy0v5o7AjtE1+Vg2K8ms
	dzqZ8Im0=
X-Gm-Gg: AYBFou1a5XV8lPTd1ULEbX4QzJU/CWXa3SLSIhE4iWDZ5IjG/FZunMbFtH/iqvkAaKU
	9Tj1ySYhAIXAyOxZ9ZGQaWYWn7DCyvS0iCLUFyKVlWRRGIlhUPqGIJzp/FAlQdE+M8o2d4Fs4wi
	/t0N0cWjwwg0SxPPUpJx8l6v4kQc3abrWJlxlPj9eIxxQx/AXGTKPICebv1Z5DS1ZbfAy1ZzzEq
	PBUhQFDfEwxYNcseRO5auocvJKCOPjlG3agksw4OJ/nDgPZOO4EYt58bq7yDdQqA/5nQaMcMcQz
	eqNFnkMgcNoKOro6bl5dzXcyjOBHxPub5HeekLZIVjW5jpZOt2bETurI8SKovb73cbnHSuwZmLp
	B/ml4dtsQesawNi2lfnaZx+281Pwj3Ajb0DwW/g3+grb14FDsTAXDFMV9QZ8ndyN054jvtBfIy7
	TsaEEPI/zOkaItTHFCQ2PCd2RaFW7xsT51Jpw/1d5nH87eDEVzafCQCWQfqkf/GbzZHi5THSkGb
	FZp6aLoKbSuYdv6V0y++KzfXfQnFoPtNYr4whU2qMAN9kYOIQakcm/WPhbqXgEYveyjNHFkjEwx
	hzRI2O7SOLrLp0FpO2I/5vYcZepww1QldvYbU28mmHhNHg==
X-Received: by 2002:a05:620a:6483:b0:93e:acdd:acd9 with SMTP id af79cd13be357-944214d68bbmr2945212185a.7.1793890712094;
        Thu, 05 Nov 2026 06:58:32 -0800 (PST)
Received: from toxicpanda.com ([153.61.196.252])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-945d479e107sm478675985a.7.2026.11.05.06.58.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Nov 2026 06:58:31 -0800 (PST)
From: Josef Bacik <josef@toxicpanda.com>
Date: Thu, 05 Nov 2026 14:57:11 +0000
Subject: [PATCH RFC v3 20/90] cgroup: root a cgroup namespace at a given
 cgroup
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
Message-Id: <20261105-b4-cells-v3-20-bc9095937a84@toxicpanda.com>
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
X-Developer-Signature: v=1; a=openssh-sha256; t=1793890670; l=3752;
 i=josef@toxicpanda.com; h=from:subject:message-id;
 bh=5CSluj2vtjSNuvg7pODJ3ZESLlCLSmlnzudcUt7/8ZE=;
 b=U1NIU0lHAAAAAQAAADMAAAALc3NoLWVkMjU1MTkAAAAgUBr36M/n0nWN0DNbnxwzIiCZez6MG
 JiruuNaSCI/zXsAAAAGcGF0YXR0AAAAAAAAAAZzaGE1MTIAAABTAAAAC3NzaC1lZDI1NTE5AAAA
 QBSG6WoCW6bZ4VZGG1EWakfC2ytxq1dLYNArlzrzqVw8OIn7HD8k9GhL5QGy9uKe45yMZiCoq0j
 0sur/aYbNVgo=
X-Developer-Key: i=josef@toxicpanda.com; a=openssh;
 fpr=SHA256:C8kOX2QUJCMqnCX+KEeoqRAjLo9L+ELOSH2NSAJHqGA

copy_cgroup_ns() roots the new cgroup namespace at the cgroup of the
caller. The builder of a cell is not in the budget of the cell and never
will be.

Add cgroup_cell_ns(), which creates a cgroup namespace that is rooted at a
given cgroup, and cgroup_cell_cset(), which finds the css_set that it
needs.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 include/linux/cgroup.h    |  3 +++
 kernel/cgroup/cgroup.c    | 17 +++++++++++++++++
 kernel/cgroup/namespace.c | 44 ++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 64 insertions(+)

diff --git a/include/linux/cgroup.h b/include/linux/cgroup.h
index 57a4037671c9..af467b402448 100644
--- a/include/linux/cgroup.h
+++ b/include/linux/cgroup.h
@@ -154,6 +154,9 @@ struct cgroup *cgroup_get_from_path(const char *path);
 struct cgroup *cgroup_get_from_fd(int fd);
 
 struct cgroup *cgroup_cell_budget_get(struct file *file, kuid_t *uid, kgid_t *gid);
+struct css_set *cgroup_cell_cset(struct cgroup *cgrp);
+struct cgroup_namespace *cgroup_cell_ns(struct user_namespace *user_ns,
+					struct cgroup *cgrp);
 int cgroup_cell_chown(struct cgroup *cgrp, kuid_t uid, kgid_t gid);
 bool cgroup_cell_kill(struct cgroup *cgrp);
 int cgroup_cell_budget_put(struct cgroup *cgrp, bool handed, kuid_t uid, kgid_t gid);
diff --git a/kernel/cgroup/cgroup.c b/kernel/cgroup/cgroup.c
index 75f8367271aa..051b220e2850 100644
--- a/kernel/cgroup/cgroup.c
+++ b/kernel/cgroup/cgroup.c
@@ -7163,6 +7163,23 @@ int cgroup_cell_budget_put(struct cgroup *cgrp, bool handed, kuid_t uid, kgid_t
 	return ret;
 }
 
+/**
+ * cgroup_cell_cset - the css_set a cgroup namespace rooted at a cgroup needs
+ * @cgrp: a cgroup on the default hierarchy
+ *
+ * Return: a css_set that has @cgrp on the default hierarchy and the root on
+ * every other, with a reference, or NULL if @cgrp is dead or memory is short.
+ */
+struct css_set *cgroup_cell_cset(struct cgroup *cgrp)
+{
+	struct css_set *cset;
+
+	cgroup_lock();
+	cset = cgroup_is_dead(cgrp) ? NULL : find_css_set(&init_css_set, cgrp);
+	cgroup_unlock();
+	return cset;
+}
+
 /**
  * cgroup_cell_chown - hand a cgroup to somebody
  * @cgrp: the cgroup
diff --git a/kernel/cgroup/namespace.c b/kernel/cgroup/namespace.c
index 76660332ec64..987ec8cd5db6 100644
--- a/kernel/cgroup/namespace.c
+++ b/kernel/cgroup/namespace.c
@@ -87,6 +87,50 @@ struct cgroup_namespace *copy_cgroup_ns(u64 flags,
 	return new_ns;
 }
 
+#ifdef CONFIG_CELLS
+/**
+ * cgroup_cell_ns - make a cgroup namespace rooted at a given cgroup
+ * @user_ns: the user namespace that will own it
+ * @cgrp:    the cgroup, on the default hierarchy
+ *
+ * copy_cgroup_ns() roots the namespace wherever the caller happens to be. This
+ * is for a cell, whose builder is not in the budget.
+ *
+ * Return: the namespace with a reference, or an ERR_PTR().
+ */
+struct cgroup_namespace *cgroup_cell_ns(struct user_namespace *user_ns,
+					struct cgroup *cgrp)
+{
+	struct cgroup_namespace *new_ns;
+	struct ucounts *ucounts;
+	struct css_set *cset;
+
+	ucounts = inc_cgroup_namespaces(user_ns);
+	if (!ucounts)
+		return ERR_PTR(-ENOSPC);
+
+	cset = cgroup_cell_cset(cgrp);
+	if (!cset) {
+		dec_cgroup_namespaces(ucounts);
+		return ERR_PTR(-ENOMEM);
+	}
+
+	new_ns = alloc_cgroup_ns();
+	if (IS_ERR(new_ns)) {
+		put_css_set(cset);
+		dec_cgroup_namespaces(ucounts);
+		return new_ns;
+	}
+
+	new_ns->user_ns = get_user_ns(user_ns);
+	new_ns->ucounts = ucounts;
+	new_ns->root_cset = cset;
+
+	ns_tree_add(new_ns);
+	return new_ns;
+}
+#endif
+
 static int cgroupns_install(struct nsset *nsset, struct ns_common *ns)
 {
 	struct nsproxy *nsproxy = nsset->nsproxy;

-- 
2.55.0

