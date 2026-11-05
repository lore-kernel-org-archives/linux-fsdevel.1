Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.160.175
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793890709;
	b=3GeXMG3l5poDsyyVYTT9n8RdiGYrwps/4nv7syYQHFnNxq/lcUF/O3D/WddPCZaXLphZ
	 NjROA/jOYGqe/q3f3vVg0yPZvBSvkzjZ+0oku9LBwmGk0mDbxXztoBWoEON0PG2cQzTCA
	 wCDMUQ/sTsvhQ/AzV0DFsT9Uq+hdg1UJ4pQ2VNDDyX68iOGn+E4L0Dc3C3xpiV+VkcXvK
	 FJSOeVps0pbkpDhconnZC4JyeE0Gi95w8NKHsfvksDNVjScZG0blDTBcUG4ZbVCAUqDBE
	 5lP6G+ihLvC61QJ2Zz4ZqfQt3DVLa50dKBn2EngM2Wc3O69lwEO5+ny/r7kBhHffmzQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793890709;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	 References:In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:
	 X-Developer-Key;
	bh=LU4dOUmsl/B5Tdxs3wxAiXTWWMfymKaeaVEzCu9fZtQ=;
	b=vlxyXSMUmigKcnuhl9ym8mw+mTCpE0iqVI1yDErBEIVcZFoofi8rtusvTvJVje4bDjed
	 M33Kq+lUPiRJH7VdXdpMcEmrfaufkP3AaCDXuC+PMmVTMj6TDrdqf+Nx7Adtg6zUxp8eq
	 35VqBUSLDvCMqU8u557Prtha2oY7Y6tu/7v7s287ed+QSYK3icSJbJbO9uJehnixwYBpo
	 /ROm7tKSPnNTifHg9ahwXyJJlHuKAhK268T2aMDXHTwU9lvmUku71jfsphjnPzA54pfU9
	 xqiFysB3F1JqxRnL8fwT4xWuCMe/Pi/zoSgLJqFZVJUv1pfgPyja/FthU19a+2o27DQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=toxicpanda.com;
	spf=pass smtp.mailfrom=toxicpanda.com;
	dkim=pass header.d=toxicpanda.com header.i=@toxicpanda.com header.a=rsa-sha256 header.s=google header.b=fxlOoeR2;
	arc=none smtp.remote-ip=209.85.160.175
Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CBA76083631
	for <linux-fsdevel@vger.kernel.org>; Thu,  5 Nov 2026 14:58:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3CBA76083631
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=toxicpanda.com header.i=@toxicpanda.com header.a=rsa-sha256 header.s=google header.b=fxlOoeR2
Received: by mail-qt1-f175.google.com with SMTP id d75a77b69052e-53c4b82919fso24466311cf.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 05 Nov 2026 06:58:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda.com; s=google; t=1793890708; x=1794495508; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=LU4dOUmsl/B5Tdxs3wxAiXTWWMfymKaeaVEzCu9fZtQ=;
        b=fxlOoeR2Kitk0N9nkf948rfF1MPm/jmyD/E6H6ASot99aPgCEr/2nq06EborePeFoP
         TK6WRP5Qd14vkATTGz+fkKw9j8TnqeTOw5v5Ud/HAlAn52lKC/Jeg1GHUXbLndC13H8R
         RwrNZ5u6u5iJTyrsvdsOMbnDJPyJWT5U9slnyPFpu7ZEZwzsIOmFs/v7ARPODR0fVKmL
         HrpHLVMpM8mxtthpVh1ehgg90oZmQtGocEY40jEhJ+WeK1tgQ7BxNlrQRC6UaK6cS9Pc
         zWrKQu35iSo3HsVxpeJtPL4Q9Ou3AalThTtKRkVj3vdvl0gC4fcrkqvrxVQ9wEak4Jfu
         mtUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793890708; x=1794495508;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=LU4dOUmsl/B5Tdxs3wxAiXTWWMfymKaeaVEzCu9fZtQ=;
        b=sgv/FCrZ9VCwcHo+u0qS+9FcbnEL+CMR+DDLOG+RneVh0xDXNmI5U4t5Em+T+Td6y8
         PL4efTM4WyenxWdEKp6gIf4nNt4bPyrojSsrzZXDYX2IJSmQy9YJa72ra9uX1gKl2rRY
         JDSZR68P2eml4rx5dUnXovs0DD19D7KeEG3XdCORGqejrmHKoy5dujIabIpXi/+MympU
         GM4ieZlIL22eDFRj6PepMmirzOWp7RZW6W2Al4H7RmLW1nXEHRt4yMOEcMI0VnmufDiz
         0g6QsSpDxwNpI0Mm8IzlNsZ8vsAQoNrOV8SOWVg6z9C0sPlABww2iv0IFoKrLZhhDfrA
         upQQ==
X-Gm-Message-State: APuU4Z/kg88c+zyIcheLTlEMegLBe8HMugAjq5VhnIk9wxBSbxr99Aht
	T4foKbBmjHpORdU+k/a365ZQ7C9w7UUP6AZ9uIyGm51YiWuFc1dBWTUohJ0q8pmgzjY=
X-Gm-Gg: AYBFou1TcGGQM+ynMwOZyXSGMn41228N2YcBTTxJTnfMs0w1q4Mmrlqy0k+yJBIyWjF
	ZYOB35OBspEWCIg55jwt/XAUIVl+mlon6wga5ydkFDyw2RQi9MNY98u/MbknNAXa/RWHMNHAtEP
	NSbXAmqX2GzUJ/6OVxAgHgxwUNqADqsFnKYjWlE1pXDkccDv0HUGq/6HoJoFybBF+yQKOCJeWiD
	sQbzbelmm9FzJk9c3VQ54COUiGxLnXNkamyG6LQrT3qVpA5Dkgen1q2lcIXDn3kzzPT/LJ3mRsg
	mKfGuA6ElRB3fDYU7/bhBU4XEKmxTqasQVYTEuPGp3htXJsRuHYuGcZFVwI2+fbZHyFU4pRyV1x
	GwoIQie1qxdtyWIXrIDzFpej4aknFBZLhzoNWVlrEzM5fMaZuKG0Ub1HHSmwd0dCHT5RLBlPZ45
	q6QOaS2cOsgUCtiMid5m8U+abNW1X4kM/CZTDIlLsvgt1/T/4nNahel/6TJh8josd0BvmfxwWla
	zjuJjP8l5WLuhFpxWcweUIRybT9niBosxJXKJxsl3lx1DdzadR9cCMI7G/trlYqyEynoHRwg2+V
	AXY/nInZp9V9CdOMoZ5aguZfc4aR6LmdBUhJ62RcNIcJlA==
X-Received: by 2002:ac8:5f08:0:b0:536:6013:bea6 with SMTP id d75a77b69052e-542b3a795e9mr327766541cf.2.1793890708025;
        Thu, 05 Nov 2026 06:58:28 -0800 (PST)
Received: from toxicpanda.com ([153.61.196.252])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91e7dfb2f7dsm49266906d6.9.2026.11.05.06.58.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Nov 2026 06:58:27 -0800 (PST)
From: Josef Bacik <josef@toxicpanda.com>
Date: Thu, 05 Nov 2026 14:57:08 +0000
Subject: [PATCH RFC v3 17/90] cgroup: add cgroup_cell_chown()
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
Message-Id: <20261105-b4-cells-v3-17-bc9095937a84@toxicpanda.com>
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
X-Developer-Signature: v=1; a=openssh-sha256; t=1793890670; l=3057;
 i=josef@toxicpanda.com; h=from:subject:message-id;
 bh=C7OjEBtvUCVisXbdbWldloZn3RonvyOXbj/wk//BDlM=;
 b=U1NIU0lHAAAAAQAAADMAAAALc3NoLWVkMjU1MTkAAAAgUBr36M/n0nWN0DNbnxwzIiCZez6MG
 JiruuNaSCI/zXsAAAAGcGF0YXR0AAAAAAAAAAZzaGE1MTIAAABTAAAAC3NzaC1lZDI1NTE5AAAA
 QOlwUnZj7vY01RAHvY6vvksbJPiN17kq2SPgu4uHpXYpmS1jnzvyFpInyruLUtjk+nmOyxfPM4h
 SUhgTzqBBYwU=
X-Developer-Key: i=josef@toxicpanda.com; a=openssh;
 fpr=SHA256:C8kOX2QUJCMqnCX+KEeoqRAjLo9L+ELOSH2NSAJHqGA

A cgroup is delegated by giving somebody ownership of its directory and of
cgroup.procs, cgroup.threads and cgroup.subtree_control. The builder of a
cell cannot do that for the root user of the cell. It cannot name the
kuid, and cgroupfs could not store that kuid through a chown anyway.

Add cgroup_cell_chown(), which changes the owner directly on the kernfs
nodes. The files that hold the limits keep their owner.

The function can fail half way if it runs out of memory. The caller undoes
a partial change by calling it again with the previous owner. That second
call cannot fail: kernfs_setattr() only allocates memory the first time
the attributes of a node are set, and the nodes in question have already
been changed once.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 include/linux/cgroup.h |  1 +
 kernel/cgroup/cgroup.c | 37 +++++++++++++++++++++++++++++++++++++
 2 files changed, 38 insertions(+)

diff --git a/include/linux/cgroup.h b/include/linux/cgroup.h
index a5ef01688e7f..0e45a5a1afea 100644
--- a/include/linux/cgroup.h
+++ b/include/linux/cgroup.h
@@ -154,6 +154,7 @@ struct cgroup *cgroup_get_from_path(const char *path);
 struct cgroup *cgroup_get_from_fd(int fd);
 
 struct cgroup *cgroup_cell_budget_get(struct file *file, kuid_t *uid, kgid_t *gid);
+int cgroup_cell_chown(struct cgroup *cgrp, kuid_t uid, kgid_t gid);
 struct cgroup *cgroup_v1v2_get_from_fd(int fd);
 
 /* Was this controller blocked from v1 hierarchies by cgroup_no_v1= ? */
diff --git a/kernel/cgroup/cgroup.c b/kernel/cgroup/cgroup.c
index c4bbb70f490f..fb2775006087 100644
--- a/kernel/cgroup/cgroup.c
+++ b/kernel/cgroup/cgroup.c
@@ -7124,6 +7124,43 @@ struct cgroup *cgroup_cell_budget_get(struct file *file, kuid_t *uid, kgid_t *gi
 	}
 	return cgrp;
 }
+
+/**
+ * cgroup_cell_chown - hand a cgroup to somebody
+ * @cgrp: the cgroup
+ * @uid:  the new owner
+ * @gid:  the new group
+ *
+ * Changes what delegating a cgroup is about: the directory, cgroup.procs,
+ * cgroup.threads and cgroup.subtree_control. The limits stay with whoever is
+ * above.
+ *
+ * Return: 0 or a negative error, in which case some of it may have changed. To
+ * undo that call this again with what it was. All that kernfs_setattr() can fail
+ * for is the memory for the attributes of a node that never had any set, so it
+ * does not fail for a node that has been changed.
+ */
+int cgroup_cell_chown(struct cgroup *cgrp, kuid_t uid, kgid_t gid)
+{
+	static const char * const files[] = {
+		"cgroup.procs", "cgroup.threads", "cgroup.subtree_control",
+	};
+	struct iattr iattr = {
+		.ia_valid = ATTR_UID | ATTR_GID, .ia_uid = uid, .ia_gid = gid,
+	};
+	int i, ret;
+
+	ret = kernfs_setattr(cgrp->kn, &iattr);
+	for (i = 0; !ret && i < ARRAY_SIZE(files); i++) {
+		struct kernfs_node *kn = kernfs_find_and_get(cgrp->kn, files[i]);
+
+		if (!kn)
+			continue;
+		ret = kernfs_setattr(kn, &iattr);
+		kernfs_put(kn);
+	}
+	return ret;
+}
 #endif /* CONFIG_CELLS */
 
 /**

-- 
2.55.0

