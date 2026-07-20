Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com [209.85.222.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6028649218D
	for <linux-fsdevel@vger.kernel.org>; Mon, 20 Jul 2026 19:35:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784576138; cv=none; b=O4ymbtcloHMMlRjDy4r/xeiCAs39zZ11xqqMsSrRCX5UGzAODLSIzgD1si2v1UmSxmcn4kTp3bYWrb+MntCFzAV6nKz28vNetHnMFnWDg46GVrlK023kX87XEp/whCz1TgLUT4VvHFT0hAQgL3BMgEhy5Eigyz+JEp75QXQU1AY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784576138; c=relaxed/simple;
	bh=g/xiGWfO3mFmUtpjiaOltFkKmHg7U6hIcXuOmsbgzC4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Pf2Lu4pmLERM0YKFHpcrngXqPTS7B2SyRgW8pTVMxzDhQuqnejq0fTub2oeyWugASq6pHDtoJtsRaCOpWXsj0Sys3lx234zozbAqlVqbu7yZWxWLIMc9hwjgVNRAQotGrfP6SSGlLDBcti021vRjOcdh5HVqqSDVELB8VLomksM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=qVAOOK47; arc=none smtp.client-ip=209.85.222.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="qVAOOK47"
Received: by mail-qk1-f170.google.com with SMTP id af79cd13be357-92e5d50b0dbso540133785a.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 20 Jul 2026 12:35:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1784576133; x=1785180933; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=+bbISnSBqmxoccJ9u0omFuHBSz5EtUsg09tULZikjEs=;
        b=qVAOOK4788Wk7c6dCN4RNuK2xq6i4NE9EaVuDgyGLdYeHlkhXxOrGcfep7hvBzorDN
         WgP+iofP9T9InA6xUNDI6y40eGFhQmmQGu2ryB4X1jt6mu0jlibohzqtPIweiqeYlLxN
         l2Y7C+Rd57IkBvIGgIQh6QEjQWW6nUPV8oPd/ttNItp1mkBOqYvujfAdrJgZzi7nykuJ
         8Cxe6+neF4889J/0p3DVEPhMjAsh+q4pZ97vPLt5Zmadp8KGnTJitrQZxKQmv6i5K8n1
         25L6bKacWIJNZ8woVtGCiqsu98gnhOnXxyzQmJijH8SwutdYvPH/AbH+dWDJmIh8g7AZ
         QJGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784576133; x=1785180933;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=+bbISnSBqmxoccJ9u0omFuHBSz5EtUsg09tULZikjEs=;
        b=fYVAhzpmStquJ+YqhJn72OgIfOQaeLCBrg2zdTXeH6D8lM1qGS8BPBNY0UPPFvNCuE
         aqFmBzRRxT8UG40KcQI633L+NCHpAlyRgPKsYQ4Trb8wAPOGFWyR6dGjWwznKu/qyME+
         ENQz9Dh2JfHu5OeIszTk1HeRiMm8J0Ica0r3oB33NggVZzpOAw35OiHXwJrtT2Ad2Kf9
         rd36V0cke79pXBUPaatgM84nkVf9t3GHsH+eS777a0iUx6P68YRPDLcdjvrG1V+USnlG
         HIAozEW8oLlVUgPlmkMgOoCH09V/v418cbNJgaIvh0VaO5Q4u+Hx7Ok38s5JVts11sxV
         GsnQ==
X-Forwarded-Encrypted: i=1; AHgh+RpL1ZWB1/zrBQYZfq23aME0yESxaccuvb2l9hbxB3/aOm4EDVBAB+FBY09y1tIoCxplKWJGg5sJmF70MY33@vger.kernel.org
X-Gm-Message-State: AOJu0YyH+ZSvXj0AknWT48ZzRSoHQnIAy1kjAjh7qVUz65NRrRJR12nI
	ajhSs4z/9/vxulhIGPSLEpfrxzH/7gQskC3if33JebWI06Trw5QOOyJXBgzVL/lrXVI=
X-Gm-Gg: AfdE7cnHCHNEeuy/ciaFWCSUdFOICO/A3LK4IU3FnAo0tQ9hGamIFbGcx8Of/2phCuY
	3k7UvOk/0AuSYHo5XfGsCZO+auo9M/O+Tki62M/sH/XxUCjznNmS3LG6vfMo2DSMzmNtFW80vu4
	DzUOkiDEUmQFvaPdW0wVs3GINWg4FrFNdqACXwOHU2+RdCvAsw7hPU1wPyUg7qT4vsfuOtSa/JK
	PxPI0MQbiWHNiOS8DBktcvmsKXYBSdL0Q+pUDMUNhhvkCPUKm+E0m3mbVYPQwyWVS9qJnEpWbUn
	rjqi4HKTp/jVh41ZeNe4PGUg4b97EK9+8NjW638TLbyALFjw/6TGk04vriuJMiMchdXyz2FQYqT
	4SphWFEXS/iYr/olrFAkAYY52VJB7Jl3S9VTJwGSTyYJJJGpUQc4Q6a18U70qQxBts8nLnB+K/O
	+C+fMLAxdI/ay/mrCKPsHTHrOwV19/XpXBk+x9CNKAPSa2lg0XakT32jEQ8T6bC/4=
X-Received: by 2002:a05:620a:1a21:b0:930:9afd:e98b with SMTP id af79cd13be357-930b434f8d4mr1589642385a.88.1784576133081;
        Mon, 20 Jul 2026 12:35:33 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F.lan (pool-173-79-60-52.washdc.fios.verizon.net. [173.79.60.52])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-930b545e47bsm957792285a.35.2026.07.20.12.35.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jul 2026 12:35:32 -0700 (PDT)
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
Subject: [PATCH v5 21/36] proc/kcore: include private-node RAM in the kcore RAM map
Date: Mon, 20 Jul 2026 15:34:15 -0400
Message-ID: <20260720193431.3841992-22-gourry@gourry.net>
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

The kcore_ram_list bounds its scan at the highest pfn in N_MEMORY.

As a result, private nodes placed above the last N_MEMORY node, which is
the common case for device/CXL memory - is truncated out of /proc/kcore.

Include N_MEMORY_PRIVATE nodes in the scan boundary.  /proc/kcore is
root-only (CAP_SYS_RAWIO), so this exposes nothing new - it just lets
a debugger read private-node memory like any other RAM.

Signed-off-by: Gregory Price <gourry@gourry.net>
---
 fs/proc/kcore.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/fs/proc/kcore.c b/fs/proc/kcore.c
index 390547b992acd..f67194dc2a9b8 100644
--- a/fs/proc/kcore.c
+++ b/fs/proc/kcore.c
@@ -251,11 +251,14 @@ static int kcore_ram_list(struct list_head *list)
 {
 	int nid, ret;
 	unsigned long end_pfn;
+	nodemask_t mem;
 
 	/* Not initialized....update now */
 	/* find out "max pfn" */
 	end_pfn = 0;
-	for_each_node_state(nid, N_MEMORY) {
+	/* Include private node memory in the scan */
+	nodes_or(mem, node_states[N_MEMORY], node_states[N_MEMORY_PRIVATE]);
+	for_each_node_mask(nid, mem) {
 		unsigned long node_end;
 		node_end = node_end_pfn(nid);
 		if (end_pfn < node_end)
-- 
2.53.0-Meta

