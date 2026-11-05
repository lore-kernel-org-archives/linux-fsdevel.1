Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.180
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793892077;
	b=rgrZAlkRWDcNI9fhDGV62JMV1mDjIzdMn2tbd4MpB7HQNGKPCGOl4Ftc6FBjC80fqb8K
	 17TUwLpMYchBbCfG8SVBffxEnuLKmq+BlplcanPJlKCZp8EQRzcWXF9eCO7p82sbQGl1p
	 39h9fPWwHEaq6ooNXvHrubI4+geOAXYvIBe/gwt9gmkNEnXAod3xQeEEgBeLpv6Ujj0Lx
	 LkiBIDuGljgIgcqQcpGUA+le8/6GLgJJGC/ZHuJXhQdYppAZJwtOaZwkFVnfggcCM2rqD
	 DqGjzljqub+FijeMOfbxY/fje7BXV0XT7/SvDii/NvG7zqO8w/ku9QYlBuM2nW5JI9Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793892077;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	 References:In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:
	 X-Developer-Key;
	bh=u2u9PsPEFuJjBc6T1esj7oeDK3O7JwKIO6kYyidKbLY=;
	b=mCGfq6DYTcLmyaTR8WeaRfqWE85KWR0/8aN+43Z9RBlugzjbujmCYohceIS3xkXQppum
	 Z0DD37mf0I1L9HJi/kQRw4bqYWYUgtavVCx3KfceEPd/eHHCZf4vn5CmJDJ6l+bXOYv+2
	 pbrOtDnScZIVkcbi4yJP4GYnZ9ZMszrj2coDCK5eEtPQsNjLA2AlKGPqX6w0pqjMPjiRd
	 ClNgVZXQDOTC1zu8oGpjKVnGu45xsCdQ1+cmsjoGRmTAwBr85uN+9yERxKa9OaDFY8xVH
	 ooFCmOfzBg6t05QTq6VGXtzGGi5SvcK74SjK2cvPQP9bpvnkNe7jvypDefJDRM50A9g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=toxicpanda.com;
	spf=pass smtp.mailfrom=toxicpanda.com;
	dkim=pass header.d=toxicpanda.com header.i=@toxicpanda.com header.a=rsa-sha256 header.s=google header.b=rqPPKMgk;
	arc=none smtp.remote-ip=209.85.221.180
Received: from mail-vk1-f180.google.com (mail-vk1-f180.google.com [209.85.221.180])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFAE0606D83B
	for <linux-fsdevel@vger.kernel.org>; Thu,  5 Nov 2026 15:21:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EFAE0606D83B
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=toxicpanda.com header.i=@toxicpanda.com header.a=rsa-sha256 header.s=google header.b=rqPPKMgk
Received: by mail-vk1-f180.google.com with SMTP id 71dfb90a1353d-5eafb65e204so641006e0c.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 05 Nov 2026 07:21:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda.com; s=google; t=1793892076; x=1794496876; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=u2u9PsPEFuJjBc6T1esj7oeDK3O7JwKIO6kYyidKbLY=;
        b=rqPPKMgkREkU9IM211ra3k8AITo9T+TdNDhco6Oy60gtAM2RnRAKMggyHKkB4jLaSs
         0r9s/bfxnQAXHahfiW2nyVtgFkMQ0n7u1IHZODS/U9HER4Q0JOoPMLF/vm5Hqu9i+XQz
         XAqaJRpdK4CamQW7eDb8stBOv2z+fYBFmTDh/HbJISeOEhRmQ81xJGoc2NAcnoG8Tbes
         P7aoACeIOyBklmTYbsiURKGDjOd1fqzO0ebyGCG1pbHMEt48DO5ayhwlLKFQ5Yca8eAe
         GtAjVAatAZ2oQpZ/hg5WP2ob8L8VRCw+KHXnYfYZfdipb2KK72+QvrY3WmwfoXezTn2A
         92LA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793892076; x=1794496876;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=u2u9PsPEFuJjBc6T1esj7oeDK3O7JwKIO6kYyidKbLY=;
        b=SiphTA1DFrk1h4ELp6POTCdtdo8UADt3+Kc+h9Su/b49i0zMwONTDsGwHJLKv9VJFU
         T2v1HZu8HyLm0hpKVmFjPCUODB2SyNDmpRHlYChysquYWy+6fe0ShUhrmgFI1OU8utP5
         qc25txMvqJW09Grtnv6HTne+SuMtC2ZcxNJNgMKMWjMOqg5S8D94xWbKqAWeqpnwa+wz
         xO1roa+dG7cu+9bOOBYLXe5ihLcBR+68upoD1QlJyzy3G9YqximKjUR3ND4O2mVxuiH5
         bYwpSu1jZXd+UaWOHeHaPtPgqNTvsPvZiubXN+DBRoRNtldDPDkeLQVl47tLc65NT6Pf
         CKog==
X-Gm-Message-State: APuU4Z/5BC+GvDrHpdXr0rjYTzlheodMX2gsJrhIqhOOjzG8QmeLVjB9
	aA7loetuBqCSI5CvZTVMGrYR72wFf1CVcp1JAYipEp5peGqoXMZLO4I6vWfhUcjb4Z4HUs/kvAM
	nloEfcj8=
X-Gm-Gg: AYBFou0en6MsWm8OAgTGwurOdqGeb/xT9m69Rhn4D6aVNYMux2S6XXKec6ZAR2Wmd9f
	H5vdqsJQs4OW1JlJCeeQXG70O6CqBKoOtsG0zvG8p+u0skNlbiHN76pew3HnrFYmuKprFysc+2x
	6AhvFiU7Nq7Gz3obV5cFGfxcq3GW4dKW+nrVn9mcPk+8aN+4c9MVJDv2rW43ZY5KpCZDw9o0N1d
	avGHQsqx3vS3pOxXQ6HxCEqf26vf5j3rljnYYJuDNpEKSJ9AHRoqpb1bK2esHjJRUlntf1FrNAq
	v/CoKhZLzVHPKe1HAD9FcdLNXa+v71R0BhVj3H8dYHnGNtBXdiUWdv268uDw4d1XCcCwpjwpKPs
	xSCFGEVf7n1kedCq2fbSuJXO6yGDtiFrZbSK79FBY2KfUsdTuWubXRrRO5lXhJxvLTECC6cV2fh
	18XhESHylGw4ZL0yYpx5VaaZ/di8ns+izsPwDwykEjuZoJgC/eDnMeOmFbEIWITaAeTv7Cp1oBR
	vgNYvdnn0gkMSjVOzn2FCjmtiLCqduyCcSHxfK+Pf3x+guNd+G03fUkk0VpTy6Ee22O+Z39DUDO
	3jdPo9w/a/HzPxsNSKym4Z7kFoqpRYcy0+ZGcbCwjeyh
X-Received: by 2002:a05:6122:506:b0:5ea:e188:a5af with SMTP id 71dfb90a1353d-5ec6894ded1mr9818300e0c.11.1793892075876;
        Thu, 05 Nov 2026 07:21:15 -0800 (PST)
Received: from toxicpanda.com ([153.61.196.254])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-998d37aad94sm4845109241.0.2026.11.05.07.21.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Nov 2026 07:21:14 -0800 (PST)
From: Josef Bacik <josef@toxicpanda.com>
Date: Thu, 05 Nov 2026 15:02:49 +0000
Subject: [PATCH RFC v3 57/90] resctrl: let a cell change nothing
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
Message-Id: <20261105-b4-cells-v3-57-bc9095937a84@toxicpanda.com>
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
X-Developer-Signature: v=1; a=openssh-sha256; t=1793890934; l=2307;
 i=josef@toxicpanda.com; h=from:subject:message-id;
 bh=C92opVjn3f0vj1bT/yXpnChkXGGDp1qEgM2rpFsMc5I=;
 b=U1NIU0lHAAAAAQAAADMAAAALc3NoLWVkMjU1MTkAAAAgUBr36M/n0nWN0DNbnxwzIiCZez6MG
 JiruuNaSCI/zXsAAAAGcGF0YXR0AAAAAAAAAAZzaGE1MTIAAABTAAAAC3NzaC1lZDI1NTE5AAAA
 QMKEW3pc/80nYyED9rpa7CvnvI7XhWfomql1dcJdBJ9B9XfQzU8gbEdcv4Cn1d2ql9b8TmLlM0l
 1+OG3tgCHMws=
X-Developer-Key: i=josef@toxicpanda.com; a=openssh;
 fpr=SHA256:C8kOX2QUJCMqnCX+KEeoqRAjLo9L+ELOSH2NSAJHqGA

resctrl is delegated the same way as cgroupfs. A group belongs to whoever
created it, and the owner can write to its files, create groups below it,
and remove and rename them. A cell with a single id runs with the id of
the user who created it, so it owns every group that this user owns.

Moving a task to another group through the tasks file is already refused
across cells. But other operations affect tasks without checking them:

  - Removing a group moves its tasks to the parent.
  - Renaming a monitoring group moves its tasks to another control group.
  - A write to schemata, cpus or mode changes the conditions that the tasks
    of the group run under.

Creating groups also uses up hardware ids, of which there are only a few
for the whole machine.

All of this requires a builder that gives the cell access to resctrl. It
should not do that, but the boundary of a cell should not depend on nobody
making a mistake.

No part of resctrl can belong to a cell. So implement may_change() and
refuse every change by a task of a cell. Besides cgroupfs, resctrl is the
only kernfs based filesystem that is delegated by changing ownership.

Compile tested only.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/resctrl/rdtgroup.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/fs/resctrl/rdtgroup.c b/fs/resctrl/rdtgroup.c
index 6b7b7daa9fd3..e7f2ec56f371 100644
--- a/fs/resctrl/rdtgroup.c
+++ b/fs/resctrl/rdtgroup.c
@@ -12,6 +12,7 @@
 
 #define pr_fmt(fmt)	KBUILD_MODNAME ": " fmt
 
+#include <linux/cell.h>
 #include <linux/cpu.h>
 #include <linux/debugfs.h>
 #include <linux/fs.h>
@@ -4451,11 +4452,18 @@ static int rdtgroup_show_options(struct seq_file *seq, struct kernfs_root *kf)
 	return 0;
 }
 
+/* Nothing here is a cell's, whatever the modes say and whoever owns it. */
+static int rdtgroup_may_change(struct kernfs_node *kn, enum kernfs_change what)
+{
+	return current_cell() ? -EPERM : 0;
+}
+
 static struct kernfs_syscall_ops rdtgroup_kf_syscall_ops = {
 	.mkdir		= rdtgroup_mkdir,
 	.rmdir		= rdtgroup_rmdir,
 	.rename		= rdtgroup_rename,
 	.show_options	= rdtgroup_show_options,
+	.may_change	= rdtgroup_may_change,
 };
 
 static int rdtgroup_setup_root(struct rdt_fs_context *ctx)

-- 
2.55.0

