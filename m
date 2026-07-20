Received: from mail-qk1-f181.google.com (mail-qk1-f181.google.com [209.85.222.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A7F04CA283
	for <linux-fsdevel@vger.kernel.org>; Mon, 20 Jul 2026 19:35:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784576163; cv=none; b=M5m9l8Sf9o0UE+YpxzJvV9vnh/SykKsbaGIU0G+F9tthQGhhgutpfH5HSE01Ef/6nPtnV8LM1hHMzsG5zIdWjIOZ5AjlUgSrgAadFMCHUAHh6cGDvrV9UF4I2iJ0+w+Ej6xQX8lX7r/JtxRqnWcPVCUw4epr5ZdKQwjXXUXZPic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784576163; c=relaxed/simple;
	bh=99pkAOPGtwB/BzPLgYWE1L+4EzvxcH4p7JFn3jZ80+c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=g1PDUQSmyTFiI3e9DjFALYxSOm9V3NtrUoCruTznA4bkwLEcNOmFIFm6PaJloR/ySET0u3NT49JGRPWoard9uOjcDOn/kWxPfaRXHk7Iu0+MyFw62LCLEJBbzgjf5+a7YGadN4PUDgUG656wmLMrofsRc3Xf3rhXt+1mE0Q7Dkk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=pBudzOTg; arc=none smtp.client-ip=209.85.222.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="pBudzOTg"
Received: by mail-qk1-f181.google.com with SMTP id af79cd13be357-92e622cc874so782476485a.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 20 Jul 2026 12:35:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1784576157; x=1785180957; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=yyvPve12WhVPZzxgug/++OGUAj2qo04o06OFhCcQQmk=;
        b=pBudzOTg3CQS7bU6aa2/3qCLPH06+plLdsnBfPa4htG/DFZuTcu0A4+CWaWMPirDgG
         bn33DXYjMF44s/PkOZpbV+tUJgqPMzmcNA3pbkX1eXE96jV7KSwmYYTqFbzPQFL8Avl0
         28rLcXH2cafiKbRSFus/ifFddlVgbssJBFdCH7iDJKzejdZMjzZywJKLroAlVCaCtPWc
         36xHymoV+jWp5ncSipVMfKyPg2rfmAcqPZvLugfGi4y37TQYH2DCdF+FI8V5g2089JlF
         teoPcfWmvE4q4UNNd/WZgXDLBgjhHm/PVW/bpGFMgnwms1VTaYzaqvAIqvg3EVKUGkNj
         5O1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784576157; x=1785180957;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=yyvPve12WhVPZzxgug/++OGUAj2qo04o06OFhCcQQmk=;
        b=S8Q3ZJUB1k8ysgwK1jD3gEqHPmwl0xeoKXUGft+IdgFZmK7nZFT7IiP2G+YQa+Zz/H
         YmCI7MGo1H3RY2SjKHbISqDutI4k4G4l6ItW1N3fZpwolMBDaVWfpLuhUYqn6oLaTaII
         2Y0KwKss71kIoxuQtYBxY7tqAW1SCsBCMQDu+UD0tgsiFPtt8hjD2MWv/4nxC/W3yimO
         r4urccMDz3kjua4Y41GJAXR9MP9UKz/sFcNy4SyuN+VgyNuY9M6eRGRB3dTsdUVNxVka
         /ChhdZhqrPPTP+zpR9PlYaT1KYSSm64pXEhjdYU3HQehnfG1ckOoRi+yKK5mCg3PcXTp
         4RXQ==
X-Forwarded-Encrypted: i=1; AHgh+RqqRTuSBi+1Du8TA89SQmK+XXZLlmuY9mYiqJUMJfCjoxnFROBJ6xO7O+iBkot5VU2wQr/cEncCNrvHtMne@vger.kernel.org
X-Gm-Message-State: AOJu0YwXBNPWsYrTROKWsSWaZbj55+JVppigswNZGV+Yc54bnWF88haa
	pkMEWOX+uPhF4IalqVNpqagYN78SS9X6sNZTnHpeppWBampDrldsRWeyBk3HNSclcFY=
X-Gm-Gg: AfdE7cnDq3SvcYbB6LjJo0K2ls1YK/B6ZyjnnMZytTKgvybD2SRBNuM/kYsV1/fQiY5
	dT/ZGfyh4lAvdLBd4nwcinJt8sXqT6M+NM90+4Ap6YiIFFploqTGROyZNeSDyEp6Xk9GWBF8pHM
	tS4Bh+DBuscYQKAOqO6laLH26qrlrbJp5SMe8J0k9n3O3aeUCvAPE+TuzHvVuYH7fTDWw9kbaAL
	9krU4nqCZsBYSpesDan6+ODaZtpMUKB94V0q/cOfVrjCya3dKTp+6tB9j1Nrul7lCtZ0vQP7r1l
	JkFhlvyildCteNGpJujM0LSpKAYpUs/EgVp1rqKIHvBO2jEHSXk4pFAies7WylYDYc69Tp62qNF
	25UG9CTkBloMH9WXMklk0DQaqCcsURy5MEjlBViZn6cXZei/5qcmaq4nzLIKL/mO4sIwyO0MblW
	N6tzOLaTiclzaTct/bdxJA0mX3BuxHBt81aYrs1uSRWfAi13N23tN8d7j1t+TG1hY=
X-Received: by 2002:a05:620a:2855:b0:92e:c118:18e1 with SMTP id af79cd13be357-930b437e3afmr1539338685a.88.1784576157342;
        Mon, 20 Jul 2026 12:35:57 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F.lan (pool-173-79-60-52.washdc.fios.verizon.net. [173.79.60.52])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-930b545e47bsm957792285a.35.2026.07.20.12.35.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jul 2026 12:35:57 -0700 (PDT)
From: Gregory Price <gourry@gourry.net>
To: linux-mm@kvack.org
Cc: Zhigang.Luo@amd.com,
	arun.george@samsung.com,
	balbirs@nvidia.com,
	brendan.jackman@linux.dev,
	yuzenghui@huawei.com,
	apopple@nvidia.com,
	alucerop@amd.com,
	matthew.brost@intel.com,
	akpm@linux-foundation.org,
	david@kernel.org,
	ljs@kernel.org,
	liam@infradead.org,
	vbabka@kernel.org,
	rppt@kernel.org,
	surenb@google.com,
	mhocko@suse.com,
	corbet@lwn.net,
	skhan@linuxfoundation.org,
	gregkh@linuxfoundation.org,
	rafael@kernel.org,
	dakr@kernel.org,
	djbw@kernel.org,
	vishal.l.verma@intel.com,
	dave.jiang@intel.com,
	alison.schofield@intel.com,
	osandov@osandov.com,
	jannh@google.com,
	pfalcato@suse.de,
	jackmanb@google.com,
	hannes@cmpxchg.org,
	ziy@nvidia.com,
	pbonzini@redhat.com,
	osalvador@suse.de,
	joshua.hahnjy@gmail.com,
	rakie.kim@sk.com,
	byungchul@sk.com,
	gourry@gourry.net,
	ying.huang@linux.alibaba.com,
	kasong@tencent.com,
	qi.zheng@linux.dev,
	shakeel.butt@linux.dev,
	baohua@kernel.org,
	axelrasmussen@google.com,
	yuanchu@google.com,
	weixugc@google.com,
	yury.norov@gmail.com,
	linux@rasmusvillemoes.dk,
	longman@redhat.com,
	ridong.chen@linux.dev,
	tj@kernel.org,
	mkoutny@suse.com,
	sj@kernel.org,
	jgg@ziepe.ca,
	jhubbard@nvidia.com,
	peterx@redhat.com,
	baolin.wang@linux.alibaba.com,
	npache@redhat.com,
	ryan.roberts@arm.com,
	dev.jain@arm.com,
	lance.yang@linux.dev,
	usama.arif@linux.dev,
	xu.xin16@zte.com.cn,
	chengming.zhou@linux.dev,
	roman.gushchin@linux.dev,
	muchun.song@linux.dev,
	linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org,
	driver-core@lists.linux.dev,
	nvdimm@lists.linux.dev,
	linux-cxl@vger.kernel.org,
	linux-debuggers@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	kvm@vger.kernel.org,
	cgroups@vger.kernel.org,
	damon@lists.linux.dev,
	linux-kselftest@vger.kernel.org,
	kernel-team@meta.com
Subject: [PATCH v5 30/36] mm: add NODE_PRIVATE_CAP_NUMA_BALANCING for private-node NUMA balancing
Date: Mon, 20 Jul 2026 15:34:24 -0400
Message-ID: <20260720193431.3841992-31-gourry@gourry.net>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260720193431.3841992-1-gourry@gourry.net>
References: <20260720193431.3841992-1-gourry@gourry.net>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

By default NUMA balancing does not scan or prot_none private-node
folios, so the kernel never migrates them via access sampling.

Add NODE_PRIVATE_CAP_NUMA_BALANCING to opt a private node in.

Add folio_allows_numa_balance() to gate change_prot_numa() scans on
node eligibility. Opted-in private node participate like normal.

Unlike demotion, NUMA balancing is not reclaim-driven, so this
capability stands alone and does not require CAP_RECLAIM.

Signed-off-by: Gregory Price <gourry@gourry.net>
---
 include/linux/node_private.h | 29 +++++++++++++++++++++++++++++
 mm/internal.h                | 13 +++++++++++++
 mm/mempolicy.c               |  2 +-
 3 files changed, 43 insertions(+), 1 deletion(-)

diff --git a/include/linux/node_private.h b/include/linux/node_private.h
index 87b03444b2c97..5c3e070ed0deb 100644
--- a/include/linux/node_private.h
+++ b/include/linux/node_private.h
@@ -16,6 +16,7 @@ struct page;
 #define NODE_PRIVATE_CAP_USER_NUMA	(1UL << 1)	/* allow mempolicy */
 #define NODE_PRIVATE_CAP_HOTUNPLUG	(1UL << 2)	/* allow hot-unplug */
 #define NODE_PRIVATE_CAP_DEMOTION	(1UL << 3)	/* allow tiering demotion */
+#define NODE_PRIVATE_CAP_NUMA_BALANCING	(1UL << 4)	/* allow NUMA balancing */
 
 /**
  * struct node_private - Per-node container for N_MEMORY_PRIVATE nodes
@@ -143,6 +144,29 @@ static inline bool node_allows_demotion(int nid)
 	return ret;
 }
 
+/**
+ * node_allows_numa_balancing - may NUMA balancing scan/migrate this node?
+ * @nid: the node to test
+ *
+ * Access-based promotion/migration.  Unlike demotion this is not reclaim-driven,
+ * so CAP_NUMA_BALANCING stands alone (no CAP_RECLAIM dependency).
+ *
+ * return: true for normal nodes and private nodes opted into CAP_NUMA_BALANCING.
+ */
+static inline bool node_allows_numa_balancing(int nid)
+{
+	struct node_private *np;
+	bool ret;
+
+	if (!node_state(nid, N_MEMORY_PRIVATE))
+		return true;
+	rcu_read_lock();
+	np = rcu_dereference(NODE_DATA(nid)->node_private);
+	ret = np && (np->caps & NODE_PRIVATE_CAP_NUMA_BALANCING);
+	rcu_read_unlock();
+	return ret;
+}
+
 #else /* !CONFIG_NUMA */
 
 static inline bool folio_is_private_node(struct folio *folio)
@@ -180,6 +204,11 @@ static inline bool node_allows_demotion(int nid)
 	return true;
 }
 
+static inline bool node_allows_numa_balancing(int nid)
+{
+	return true;
+}
+
 #endif /* CONFIG_NUMA */
 
 #if defined(CONFIG_NUMA) && defined(CONFIG_MEMORY_HOTPLUG)
diff --git a/mm/internal.h b/mm/internal.h
index 62e68acae08a3..01ab8b32b0bd8 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -123,6 +123,19 @@ static inline bool folio_allows_madvise(struct folio *folio)
 	       node_allows_reclaim(folio_nid(folio));
 }
 
+/*
+ * folio_allows_numa_balance() - may NUMA balancing scan/migrate this folio?
+ *
+ * NUMA balancing is access-aware tiering migration, so it follows the tiering
+ * opt-in: false for ZONE_DEVICE and for N_MEMORY_PRIVATE nodes without
+ * CAP_NUMA_BALANCING, true for all other folios.
+ */
+static inline bool folio_allows_numa_balance(struct folio *folio)
+{
+	return !folio_is_zone_device(folio) &&
+	       node_allows_numa_balancing(folio_nid(folio));
+}
+
 /*
  * folio_allows_longterm_pin() - may this folio be long-term GUP-pinned?
  *
diff --git a/mm/mempolicy.c b/mm/mempolicy.c
index fe42a510590a2..4daba81fff7c7 100644
--- a/mm/mempolicy.c
+++ b/mm/mempolicy.c
@@ -874,7 +874,7 @@ bool folio_can_map_prot_numa(struct folio *folio, struct vm_area_struct *vma,
 {
 	int nid;
 
-	if (!folio || folio_is_private_managed(folio) || folio_test_ksm(folio))
+	if (!folio || !folio_allows_numa_balance(folio) || folio_test_ksm(folio))
 		return false;
 
 	/* Also skip shared copy-on-write folios */
-- 
2.53.0-Meta

