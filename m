Received: from canpmsgout02.his.huawei.com (canpmsgout02.his.huawei.com [113.46.200.217])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F6DA4570FA;
	Fri, 18 Sep 2026 10:04:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.217
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789725861; cv=none; b=S44I8EjllcVwcskDiJKCJFYkjdI4ip7FkLTyObzx0jNG9iHH2o2E0jaq9aKf95HtrsyidAMAyjijWjTbAF4hLvPrBjYxIZqKYJWv7r7sGxALbst7W93H+GDvBDwKtjZcV9yRIOhIo2DeHsJLUHm0ifEBJMELcmM9TPInASQt230=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789725861; c=relaxed/simple;
	bh=OMbzw4uT78uE0UCyzaGrvjYdVsESPkacJ328Z3Pvr3E=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GrkLcikC09IUCgnTgdhDdYGEYzBYITvOobWvP3i8BuHiCMOGIi+nw9TdsTBmyHTrxnzXb9cdMWrX08H0836wu/mqjzv5EPYVVlDqaceJ9aUPUNQkH+ADPPjPhdFeVTG+4Xq3axApIp2e1yEvPPP2KtdItFIDIR9UelFt5v+cdfM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=Ez/wOSF7; arc=none smtp.client-ip=113.46.200.217
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="Ez/wOSF7"
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=gzeLYP4W/HVtauBH6zrP+s/J9Q0YG9Qv0eMgDswYLO0=;
	b=Ez/wOSF7kN0QxhLrYOxwsAq0t/qVSH7zO1LO6a7rzHbsnPODXfipqqsojEw0qCoGxc7ny7coD
	r5CTzt7mwcrfYR0Ns1b2jGOyjEoC1z/DtVergIB5XHUbsALHHtqEUbsn6WEYdxjWUtLytZbUcoZ
	lEboIM0h4256GoXqxjGf9KM=
Received: from mail.maildlp.com (unknown [172.19.162.197])
	by canpmsgout02.his.huawei.com (SkyGuard) with ESMTPS id 4hmSbq689nzcb4c;
	Fri, 18 Sep 2026 17:52:55 +0800 (CST)
Received: from kwepemk200008.china.huawei.com (unknown [7.202.194.74])
	by mail.maildlp.com (Postfix) with ESMTPS id E5DD54057D;
	Fri, 18 Sep 2026 18:04:10 +0800 (CST)
Received: from huawei.com (10.90.53.73) by kwepemk200008.china.huawei.com
 (7.202.194.74) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Fri, 18 Sep
 2026 18:04:09 +0800
From: Jinjie Ruan <ruanjinjie@huawei.com>
To: <catalin.marinas@arm.com>, <will@kernel.org>, <mark.rutland@arm.com>,
	<chenhuacai@kernel.org>, <kernel@xen0n.name>, <maddy@linux.ibm.com>,
	<mpe@ellerman.id.au>, <npiggin@gmail.com>, <chleroy@kernel.org>,
	<ritesh.list@gmail.com>, <sshegde@linux.ibm.com>, <tglx@kernel.org>,
	<mingo@redhat.com>, <bp@alien8.de>, <dave.hansen@linux.intel.com>,
	<hpa@zytor.com>, <gregkh@linuxfoundation.org>, <rafael@kernel.org>,
	<dakr@kernel.org>, <akpm@linux-foundation.org>, <baoquan.he@linux.dev>,
	<rppt@kernel.org>, <pasha.tatashin@soleen.com>, <pratyush@kernel.org>,
	<ruirui.yang@linux.dev>, <kees@kernel.org>, <thuth@redhat.com>,
	<ruanjinjie@huawei.com>, <gshan@redhat.com>, <ardb@kernel.org>,
	<james.morse@arm.com>, <leitao@debian.org>, <yeoreum.yun@arm.com>,
	<sourabhjain@linux.ibm.com>, <robh@kernel.org>, <coxu@redhat.com>,
	<tangyouling@kylinos.cn>, <liukexin@kylinos.cn>, <guodongtai@kylinos.cn>,
	<maqianga@uniontech.com>, <zhangtianyang@loongson.cn>, <blum@kernel.org>,
	<adityag@linux.ibm.com>, <chao.gao@intel.com>, <kas@kernel.org>,
	<vishal.l.verma@intel.com>, <seanjc@google.com>, <piliu@redhat.com>,
	<jbouron@amazon.com>, <me@linux.beauty>, <mclapinski@google.com>,
	<graf@amazon.com>, <bgwin@google.com>, <eric.devolder@oracle.com>,
	<hbathini@linux.ibm.com>, <takahiro.akashi@linaro.org>,
	<lizhengyu3@huawei.com>, <palmer@rivosinc.com>, <x86@kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	<loongarch@lists.linux.dev>, <linuxppc-dev@lists.ozlabs.org>,
	<driver-core@lists.linux.dev>, <kexec@lists.infradead.org>,
	<linux-fsdevel@vger.kernel.org>, <linux-mm@kvack.org>
Subject: [PATCH v5 01/17] kexec: Fix CMA segment address translation with non-zero text_offset
Date: Fri, 18 Sep 2026 18:04:26 +0800
Message-ID: <20260918100442.3841135-2-ruanjinjie@huawei.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260918100442.3841135-1-ruanjinjie@huawei.com>
References: <20260918100442.3841135-1-ruanjinjie@huawei.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: kwepems100001.china.huawei.com (7.221.188.238) To
 kwepemk200008.china.huawei.com (7.202.194.74)

kimage_load_cma_segment() and kimage_map_segment() translate a CMA
segment to a kernel virtual address with page_address(cma), ignoring
segment->mem. But arm64's image_load() adds text_offset to segment->mem,
so the kernel payload is copied to the wrong offset while image->start
points past it, and kexec jumps into the middle of the kernel.
kimage_map_segment() has the same problem for any CMA segment whose mem
was moved.

Add kimage_cma_vaddr() to translate a boot physical address inside a CMA
segment to its virtual address, and use it in both places.

Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Baoquan He <baoquan.he@linux.dev>
Cc: Mike Rapoport <rppt@kernel.org>
Cc: Pasha Tatashin <pasha.tatashin@soleen.com>
Cc: Pratyush Yadav <pratyush@kernel.org>
Cc: Pingfan Liu <piliu@redhat.com>
Cc: Justinien Bouron <jbouron@amazon.com>
Cc: Sourabh Jain <sourabhjain@linux.ibm.com>
Cc: stable@vger.kernel.org
Fixes: 07d24902977e ("kexec: enable CMA based contiguous allocation")
Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
---
 kernel/kexec_core.c | 16 ++++++++++++++--
 1 file changed, 14 insertions(+), 2 deletions(-)

diff --git a/kernel/kexec_core.c b/kernel/kexec_core.c
index dc770b9a6d05..7f7cb77f0caa 100644
--- a/kernel/kexec_core.c
+++ b/kernel/kexec_core.c
@@ -738,11 +738,23 @@ static struct page *kimage_alloc_page(struct kimage *image,
 	return page;
 }
 
+/*
+ * Translate a boot physical address inside a CMA segment to a kernel
+ * virtual address.  Architecture loaders may move segment->mem away from
+ * the CMA base (arm64 adds text_offset), so the offset must be preserved.
+ */
+static void *kimage_cma_vaddr(struct page *cma, unsigned long mem)
+{
+	unsigned long cma_base = page_to_boot_pfn(cma) << PAGE_SHIFT;
+
+	return page_address(cma) + (mem - cma_base);
+}
+
 static int kimage_load_cma_segment(struct kimage *image, int idx)
 {
 	struct kexec_segment *segment = &image->segment[idx];
 	struct page *cma = image->segment_cma[idx];
-	char *ptr = page_address(cma);
+	char *ptr = kimage_cma_vaddr(cma, segment->mem);
 	size_t ubytes, mbytes;
 	int result = 0;
 	unsigned char __user *buf = NULL;
@@ -965,7 +977,7 @@ void *kimage_map_segment(struct kimage *image, int idx)
 
 	cma = image->segment_cma[idx];
 	if (cma)
-		return page_address(cma);
+		return kimage_cma_vaddr(cma, image->segment[idx].mem);
 
 	addr = image->segment[idx].mem;
 	size = image->segment[idx].memsz;
-- 
2.34.1

