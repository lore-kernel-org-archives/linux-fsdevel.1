Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.222.175
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793890710;
	b=oReNJ+sm+u6ggopv7kkwhZs/trnndaY9WcRcEEkITBe/x6m6JiyZcloXb7+22g95sj2C
	 A0b9VJLjsF7fPyaY9FrRzVOGwFmyxHBynk3gRMzp6dd2PEQdZ3NTzqr6aHymT6qj1+DoN
	 ByK2mKeqSd6UVHKJnspTr5/Ei8RO0Hp/9UgZ6cwTu7zbJt8AAmO+P8Hf3QdHGT30MIeKW
	 H6ATkfU9FUNAU5aco5ECzq8fRbmrQx/xXQFelumqSlTBAZyWN/fLjqB1q3X6nxxluP/0u
	 fIMnv6iSd06eEKjgWCCxZEYqoulrtqmn2S3I3wRCqvamo8ylwCiJ7nmOqKk4ytRu/8Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793890710;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	 References:In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:
	 X-Developer-Key;
	bh=h4VrnWA7ZgcXhuGabyGlnTx8ufAcZg7zGdUYfMWpviY=;
	b=JaJNVrxQY4ur54ly2cTw1GjTsUT8TkemTiGKBYI0Mq2lhtGN3bGmEBEEoK2dVGu4i/AS
	 lsj0J43oAymHTJeE2cjvFgglO00WzErUh0AoT6I5VaAWmmc0fDXsZt1KPJiFxsR2d4gYo
	 IHpurInILFFTn3c1xcgxo6E3At4PrFc7cp6l70WSLjtJG+w8KpZehOohnRhACFtloZRRd
	 TeuMN7CSuDLsmsG/57tcemCr+Ivtax2qT1+8+6RrGGqBtVAH6r5ZXYutLfTxmNJvd/a8/
	 QbPKYJqxjl8GWfZXPQM2O+3O9rxED1Vj7umq7ovIT8WORRNjC9+dMyeXDA9En7UBhMQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=toxicpanda.com;
	spf=pass smtp.mailfrom=toxicpanda.com;
	dkim=pass header.d=toxicpanda.com header.i=@toxicpanda.com header.a=rsa-sha256 header.s=google header.b=N6N2oxvU;
	arc=none smtp.remote-ip=209.85.222.175
Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com [209.85.222.175])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A37960A2611
	for <linux-fsdevel@vger.kernel.org>; Thu,  5 Nov 2026 14:58:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4A37960A2611
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=toxicpanda.com header.i=@toxicpanda.com header.a=rsa-sha256 header.s=google header.b=N6N2oxvU
Received: by mail-qk1-f175.google.com with SMTP id af79cd13be357-93ece7a73b9so225337285a.3
        for <linux-fsdevel@vger.kernel.org>; Thu, 05 Nov 2026 06:58:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda.com; s=google; t=1793890709; x=1794495509; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=h4VrnWA7ZgcXhuGabyGlnTx8ufAcZg7zGdUYfMWpviY=;
        b=N6N2oxvULytWHtefdcgJgyRSBflsm7Yk1PfWyrFhUW7RxxCDkDiyNMZUHOUaLr4PZn
         DPdMMeJYMS9n/APVrfkungNZTezMtTygYkTam68MoDwR2kMLPnQdEdOAYnNnErq4BeEc
         l9dCgumJVwyXTgbIUkCfJML0AJGe3IwA90O9sm2BhnixqcF6f9hfwgl7pRdkEdP1LYhh
         ULfQ78NBpep5puCy6ukWPNtVwsWDbe2DcBgpi+KWJDB712b696JqBApwYX9uOBXbsjpk
         MKZ9YFXYNWGD7JW5tY778fp5ydqnuG85IX2ScWawUMNmx5mbL+IfWz1zmBzoZyRsceXU
         v4hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793890709; x=1794495509;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=h4VrnWA7ZgcXhuGabyGlnTx8ufAcZg7zGdUYfMWpviY=;
        b=FblQmOoz+kcWfvPdAVaNOmPhmjvrmiwhIlQhMfHVHj++fYEurlBPFAIoajEl8/Ax4K
         pAcBLrtQfVNixTk/+cZ+pgUMfs7dSF3x+iMVOe9NJ2T35YedKQ+/OtDy6wpLOroODIpN
         +0KkThu/yb97xe3tn1Ce4FvBGNsPbuEf4gZcJS7jONewtN9qM0lo0gYLsamZAuXegvPE
         kiF7Ef5qQg9DTJ4FLApU+/mUGzn49LsjUsNgBk9KFQS3NeswNqXsnn8IS2FaTxtZ5r3M
         IHo2jqICtNCmehxteT5S3gStFfja1lN0TxgZRrE6WKuBe+I1TUjRomAeX3IMDoHkGriP
         LYWg==
X-Gm-Message-State: APuU4Z9jizs/xldaxjwyM8RjPQxb8Gi5WarA5N1I15kovwDHaoSEpIBs
	aaf/EHX6ak/vLHx6xOCPvsjIWFtCSp+LeVilMnFA3/vMoOiRT0IzEjDfuBGdc6qmQaQ=
X-Gm-Gg: AYBFou2VtdCR5bFjTS3j2C7LmiRr2rXid7haHXNF/5IhfUpqhWGby6CSNdaEG6d7DaK
	ldpEqaCFAM9r2lwlIQX8mqcJvjhUZWYH+mlsCTVPptr+u3vBfAmSvsGNyHJG27nqstM37y4DdDE
	iwzYWYi2KnzjryvaOkriLaTJwSpXo2iseScx/BFUOhB1s/zxjZmY8PVRkMzQUc1woEZDJPZ5vZY
	9fCkRwCDPT7H+U+66puZMfeu4bBmBntAACQIPeSDytpqOreMd9hPkU6atzyW9EfVfGj3vGnhbsk
	8yXs8LD44uzWa+pyeyCmSEm4dygYiOTWU3ZgfxErLKVnymXyYzCCk5AHAaB1uVkGmTRuvP6Ggyh
	MKbnJtJD+ohjiJJXM1nUTcSJE8cj9fU7f95R0XdW5SdqvbysLUcnlKQehJmIuGqKlOGiArH2gNr
	xmjcT/Vrv2LuntOBL+FutC9XXfk3a5W7QuzSa3Fazv/NFdRCrRUJv7XOGxozvLQjUoNztdhxTdB
	5SAOwsv8tpfQCE4olVwebDXMdOtFmWKfwh9N4giGsw/QD8WEaxyPW5LGeznVi0TPMTjIOUgzsAr
	gbKEjVDtPMUObspRwme91ra3+yZCiiQCLLa8YSadAlKc7Q==
X-Received: by 2002:a05:620a:84c4:b0:93f:dea:3b7e with SMTP id af79cd13be357-9442171286amr3115484685a.24.1793890709275;
        Thu, 05 Nov 2026 06:58:29 -0800 (PST)
Received: from toxicpanda.com ([153.61.196.242])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91e7dfb2f7dsm49267226d6.9.2026.11.05.06.58.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Nov 2026 06:58:28 -0800 (PST)
From: Josef Bacik <josef@toxicpanda.com>
Date: Thu, 05 Nov 2026 14:57:09 +0000
Subject: [PATCH RFC v3 18/90] cgroup: give the budget of a cell back
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
Message-Id: <20261105-b4-cells-v3-18-bc9095937a84@toxicpanda.com>
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
X-Developer-Signature: v=1; a=openssh-sha256; t=1793890670; l=2732;
 i=josef@toxicpanda.com; h=from:subject:message-id;
 bh=u1GZaQPiSin7FMbtHavx4OO5TkTes4ys58hMwg1veX8=;
 b=U1NIU0lHAAAAAQAAADMAAAALc3NoLWVkMjU1MTkAAAAgUBr36M/n0nWN0DNbnxwzIiCZez6MG
 JiruuNaSCI/zXsAAAAGcGF0YXR0AAAAAAAAAAZzaGE1MTIAAABTAAAAC3NzaC1lZDI1NTE5AAAA
 QO4NmBOWlVpJRoAnputLqeeA12+xZndEhJYqtWGwv/i/XfVDOBcHenv6Mcka08EAylJBD0PabTk
 /7ifAFgNDlg0=
X-Developer-Key: i=josef@toxicpanda.com; a=openssh;
 fpr=SHA256:C8kOX2QUJCMqnCX+KEeoqRAjLo9L+ELOSH2NSAJHqGA

The ids of a cell are only lent to it. The cgroups that the cell created
below its budget are owned by those ids. So is the budget itself, once it
has been handed to the root user of the cell.

Add cgroup_cell_budget_put(). It removes everything below the budget,
returns the budget to its previous owner and clears CGRP_CELL_BUDGET. It
reports whether all of that worked, because the ids must not be lent to
another cell if it did not.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 include/linux/cgroup.h |  1 +
 kernel/cgroup/cgroup.c | 38 ++++++++++++++++++++++++++++++++++++++
 2 files changed, 39 insertions(+)

diff --git a/include/linux/cgroup.h b/include/linux/cgroup.h
index 0e45a5a1afea..4d9baf195f1e 100644
--- a/include/linux/cgroup.h
+++ b/include/linux/cgroup.h
@@ -155,6 +155,7 @@ struct cgroup *cgroup_get_from_fd(int fd);
 
 struct cgroup *cgroup_cell_budget_get(struct file *file, kuid_t *uid, kgid_t *gid);
 int cgroup_cell_chown(struct cgroup *cgrp, kuid_t uid, kgid_t gid);
+int cgroup_cell_budget_put(struct cgroup *cgrp, bool handed, kuid_t uid, kgid_t gid);
 struct cgroup *cgroup_v1v2_get_from_fd(int fd);
 
 /* Was this controller blocked from v1 hierarchies by cgroup_no_v1= ? */
diff --git a/kernel/cgroup/cgroup.c b/kernel/cgroup/cgroup.c
index fb2775006087..e5e6761522eb 100644
--- a/kernel/cgroup/cgroup.c
+++ b/kernel/cgroup/cgroup.c
@@ -7125,6 +7125,44 @@ struct cgroup *cgroup_cell_budget_get(struct file *file, kuid_t *uid, kgid_t *gi
 	return cgrp;
 }
 
+/**
+ * cgroup_cell_budget_put - the cell is gone, give its budget back
+ * @cgrp:   the budget. The reference is consumed
+ * @handed: the cgroup had been handed to the cell's root
+ * @uid:    who owned it before
+ * @gid:    likewise
+ *
+ * The cgroup is empty. Whatever the cell made below it is owned by ids that
+ * were only lent to the cell, so it goes, and the cgroup itself returns to its
+ * owner.
+ *
+ * Return: 0, or an error if something is left that is owned by the cell's ids.
+ */
+int cgroup_cell_budget_put(struct cgroup *cgrp, bool handed, kuid_t uid, kgid_t gid)
+{
+	struct cgroup_subsys_state *css;
+	struct cgroup *dsct;
+	int ret = 0;
+
+	cgroup_lock();
+	clear_bit(CGRP_CELL_BUDGET, &cgrp->flags);
+	if (handed && !cgroup_is_dead(cgrp)) {
+		cgroup_for_each_live_descendant_post(dsct, css, cgrp) {
+			if (dsct == cgrp)
+				continue;
+			ret = cgroup_destroy_locked(dsct);
+			if (ret)
+				break;
+		}
+	}
+	cgroup_unlock();
+
+	if (handed && !ret)
+		ret = cgroup_cell_chown(cgrp, uid, gid);
+	cgroup_put(cgrp);
+	return ret;
+}
+
 /**
  * cgroup_cell_chown - hand a cgroup to somebody
  * @cgrp: the cgroup

-- 
2.55.0

