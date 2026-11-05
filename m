Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.222.170
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793892008;
	b=dZvt0eVkOapJOgwEB9NN/89Z3HZWnVaZgBMS4nsssvLk5nMdC8s6oUYUsLDobc4ce791
	 WaqIfmKexhNuC1oJuddApeTRSqgQNXxx5SS4oh9o7fmGMCpQ1PgCDTRWJYoLqtmuErMAP
	 CJDbIKlI0iiCc+4/yXnl9DoT1q9nqYxs5FgeGf9fBCiePJAX47sPis8CDAIMCGoJ9Vvml
	 uUjlnZEtm8GJfhbTBeSG2TueGFLO9dVPHViTrmMRri9q5qDaDWF9POWtWnlvhdmxmOWhr
	 X8Ijb5C+hj2o7IFpb0MwfgySavibwjCQoDLBCIBSN9IWt9PxoqPqLo0JX2/rcuHpEtQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793892008;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	 References:In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:
	 X-Developer-Key;
	bh=r8FaPeA3g2MwMDYscdMf9Z/dM0SNFU2kGC/MByXbCsc=;
	b=mRknX4Ts55/Qnse4CRla9AYNO4Qf87Sf4z4Muc6w+91ySAXH1uKJO9t1gHwQEZN3MnYy
	 G1dweR5NLgPJycZEdWx+3qpp2nQY9qQej+4+rGafPsBJEBaZLlakvoVfd+t/pD2RvSdaG
	 tZ0VMhQ3PhZEVRaOpAeFXlvlBBKqDhN3ZRhJ+r+4f6HasXKxqEKK3cBwak029yYvx24M0
	 bkGhrijPAtl4YZct7QdNriD9XdiDOGz8vg1SxqWgvjpdCUtX4LH5LqiRjqWKlC99yiORP
	 gI836wARcyKVh2LZxlYewsKzvGLAZDxQoR+0vp8sCfAEyqyhCMyBf1Q7MeHRSpUhe0g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=toxicpanda.com;
	spf=pass smtp.mailfrom=toxicpanda.com;
	dkim=pass header.d=toxicpanda.com header.i=@toxicpanda.com header.a=rsa-sha256 header.s=google header.b=DqNX65Xn;
	arc=none smtp.remote-ip=209.85.222.170
Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com [209.85.222.170])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B36FE606D815
	for <linux-fsdevel@vger.kernel.org>; Thu,  5 Nov 2026 15:20:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B36FE606D815
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=toxicpanda.com header.i=@toxicpanda.com header.a=rsa-sha256 header.s=google header.b=DqNX65Xn
Received: by mail-qk1-f170.google.com with SMTP id af79cd13be357-93e64d52949so168202985a.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 05 Nov 2026 07:20:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda.com; s=google; t=1793892007; x=1794496807; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=r8FaPeA3g2MwMDYscdMf9Z/dM0SNFU2kGC/MByXbCsc=;
        b=DqNX65XnAasEzvBonH3UUIfLkjOnOOpyPeMPKejtQ9Rhv11bkh5VRmptp7hjNjjyQ+
         6Mt0fgZ5GW07kC8N9ayZaRuH78rHz2nu4EMqqxEVFdIKrZFtvimwaHQzE2ooBx2SYHkr
         eb+D76FLOlcARPtdRsqVEp+tsALwx6C9NCIpG6ybzS9vFVY1CL0LCmq2QZtQNpRN+j6S
         XoV8eYkLfdaRbdH2UcqDG4hOA90QF5i4Y7VT6zWnVvDK2v0dfdc8VOk34ZvGBjE63jfN
         cLdvePADNsU6ny1rH7Agb5U2p2Qmr5i77Y5nhqdyxfiOWmmHMyhQbwMjUgDVlHBW3A0V
         O3sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793892007; x=1794496807;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=r8FaPeA3g2MwMDYscdMf9Z/dM0SNFU2kGC/MByXbCsc=;
        b=SJOYeWHShQ8jxtmgkZRBX0YB9MVGKT1H3mc+wmjA4cwQAfUDJxVYR8bi/3gXnEKID8
         4DAXlRpEUDn+Gz8Z4K51nA2LZfheMysY4POE4hw1aZp59DbBf0eGZj3MxZCmo356mYqi
         Lh05twnTN6I1YpoY6BUtMNRKFtO9s5SVwEmlAjfBSRmgVLKmDIVNmTipS39KCZ0ccsFd
         SCFnHKzD0A8sRYkdPV4n9btDyIOmZ1EMU9YONSEMnavqVC5C5oPb2YSzAreZiSsiqHYf
         759JSAy6e5X03CR9oUDdKDdEaGDNuyfCroDxkx544gT3z6qo+xYE5gSNUSfI8iwMKufc
         K5Mw==
X-Gm-Message-State: APuU4Z8S6bB11VWK5H8uan2DlKolOREmc00J71Hk5M56t88vOqNnah0U
	jqaU4FMu5ajC2FQi31QxVeZEFy7iuJQKxvPIDwKs7K4WDiD+t2AE0FyPX4h0QOIva4s=
X-Gm-Gg: AYBFou3z/F9VBxqdpq0CiPfpojJ2SlV4s8yDyUEQrqgC9rVTEcLdG9UQotoumNgcfZi
	DX316x9U0HzOWoGwhViTjB1PzKFOZoJIIVuTwitNczsdSA4AVaalDRGZWydR7+bUkKtAZd+WsCJ
	bNtyG+NUfdbAqwbWN/9JwajPtoq2Iir71/sLS1Kn2RkLEG9yCV47+0Q+Q30j5eA0LpW5EqkF3ZY
	g2wp2KMbCGG0au6vreS0V6sShEGHyNKMUOSKgF/YJ28h/5a06b61C8fE2Idbhy3YSVMKJSTPGpU
	8RkIjx23aqN/xux6bC9u300S8BPn40GQnHzSJlP38SntZgQzi2LcIl3UXcmQbDA5GLmAGqUYO5Y
	i7Ke0IF90vC/J7AoY8x3mEiMvCKhcomGJ4S2pZqOe4KxA8IMdHTM3ci9XOIDdjJeZDx/yaPqkQR
	vnmrzgpLgEReDBV+vEg0DIOyRT9rDl33+OL3K7yfzqs4anszHqGtOB3DSF3atBMGi7uk9SE8e3D
	oel2DOUXUbfqcwpoHGAbkEUSzaqrFe5vLKLxxQX///NsROvonViVL8U/p5XV2cfHXZFR/yU5dGQ
	iVy4NZWJs73Ic2oJzUQgLacJ0FcuddfH
X-Received: by 2002:a05:620a:8088:b0:93e:f9ba:6902 with SMTP id af79cd13be357-94421581766mr3216527885a.9.1793892006294;
        Thu, 05 Nov 2026 07:20:06 -0800 (PST)
Received: from toxicpanda.com ([153.61.196.250])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-945d47e5dfdsm485922385a.17.2026.11.05.07.20.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Nov 2026 07:20:04 -0800 (PST)
From: Josef Bacik <josef@toxicpanda.com>
Date: Thu, 05 Nov 2026 15:02:46 +0000
Subject: [PATCH RFC v3 54/90] cgroup: leave the limits of a budget to who
 is above
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
Message-Id: <20261105-b4-cells-v3-54-bc9095937a84@toxicpanda.com>
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
X-Developer-Signature: v=1; a=openssh-sha256; t=1793890934; l=3164;
 i=josef@toxicpanda.com; h=from:subject:message-id;
 bh=6vzKkOEq7igqZTpW20nvePOWGbvjWlle0iz1kbWCdas=;
 b=U1NIU0lHAAAAAQAAADMAAAALc3NoLWVkMjU1MTkAAAAgUBr36M/n0nWN0DNbnxwzIiCZez6MG
 JiruuNaSCI/zXsAAAAGcGF0YXR0AAAAAAAAAAZzaGE1MTIAAABTAAAAC3NzaC1lZDI1NTE5AAAA
 QLtF+UGftIJzVvE/VGpipyFLfSOgDIncCf7UkA/3RZKB4EhMVoWuGifntrWxrH33E8t1HpEL8k5
 4i/QRrCNhlA0=
X-Developer-Key: i=josef@toxicpanda.com; a=openssh;
 fpr=SHA256:C8kOX2QUJCMqnCX+KEeoqRAjLo9L+ELOSH2NSAJHqGA

The budget limits what a cell can use. The limits are set by the builder.
The seal gives the root user of the cell ownership of the directory,
cgroup.procs, cgroup.threads and cgroup.subtree_control, and of nothing
else.

That relies on modes and owners, which is not enough:

  - The files of a cgroup belong to whoever created it. An unprivileged
    builder creates the budget itself, so it owns the limits. A cell with
    a single id runs with the id of that builder, so it can write whatever
    it likes to its own pids.max and memory.max.
  - A cell with a block of ids can do the same through a file that
    somebody outside of the cell has opened and passed to it.
  - The cell owns the directory, so it can make it accessible to everybody
    on the host and set extended attributes on it.

cgroup already has the right rule, for cgroup namespaces with the
nsdelegate mount option. From inside of the namespace, the only files in
its root that can be written are those marked CFTYPE_NS_DELEGATABLE. The
cgroup namespace of a cell is rooted at the budget. But that rule depends
on how cgroupfs was mounted, it looks at the task that opened the file,
and it does not cover attributes.

So apply the rule to every task of a cell, in cgroup_may_change(). In the
budget itself such a task can create and remove cgroups and write to the
delegatable files. It cannot write to any other file there, and it cannot
set attributes on the directory or on the files in it. Below the budget
there are no restrictions.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 kernel/cgroup/cgroup.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/kernel/cgroup/cgroup.c b/kernel/cgroup/cgroup.c
index accae30a901d..a0836b115c79 100644
--- a/kernel/cgroup/cgroup.c
+++ b/kernel/cgroup/cgroup.c
@@ -6488,9 +6488,25 @@ int cgroup_rmdir(struct kernfs_node *kn)
 	return ret;
 }
 
+/*
+ * Is this what a cgroup is handed to somebody for? Making cgroups in it, and what
+ * is written to across a delegation boundary: see CGRP_ROOT_NS_DELEGATE, which
+ * goes by who opened the file and leaves the attributes to their owner.
+ */
+static bool cgroup_change_is_delegated(struct kernfs_node *kn,
+				       enum kernfs_change what)
+{
+	const struct cftype *cft = kn->priv;
+
+	if (what != KERNFS_CHANGE_CONTENT)
+		return false;
+	return kernfs_type(kn) == KERNFS_DIR || (cft->flags & CFTYPE_NS_DELEGATABLE);
+}
+
 /* Whatever the modes say, and whoever owns it. */
 int cgroup_may_change(struct kernfs_node *kn, enum kernfs_change what)
 {
+	struct kernfs_node *asked = kn;
 	struct cgroup *cgrp;
 
 	if (likely(!current_cell()))
@@ -6503,6 +6519,10 @@ int cgroup_may_change(struct kernfs_node *kn, enum kernfs_change what)
 	cgrp = rcu_dereference(*(void __rcu __force **)&kn->priv);
 	if (!cgrp || !cell_may_change_cgroup(cgrp))
 		return -EPERM;
+	/* The budget is what bounds the cell. Its limits are not the cell's. */
+	if (test_bit(CGRP_CELL_BUDGET, &cgrp->flags) &&
+	    !cgroup_change_is_delegated(asked, what))
+		return -EPERM;
 	return 0;
 }
 

-- 
2.55.0

