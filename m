Received: from canpmsgout04.his.huawei.com (canpmsgout04.his.huawei.com [113.46.200.219])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F29413E8C65;
	Wed, 26 Aug 2026 09:25:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.219
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787736344; cv=none; b=DORpn6V1KnQKqTdpt5GFU1Op9mCO4Sm7ckCUgX+OP2g2+/t/wxwx0rpDoUOyPwNOTXwCw5HFfTM6Rr4A3a0KoXtsMsCAInJ10/O3HY4PpPXvl6BAld7tacwTosAOG+YA0ohDPoldY6gqO4FdBTOb85lqvlEI73kLxN1/K8G7SUA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787736344; c=relaxed/simple;
	bh=0mAik/i9N56JtyuHFVuPGWREFimlRQb3aDwMWBlPxeI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hAHOw5n2BbnvHpH2hq/qb6rUdy3g4p81pv8vbqXmP3yaMzHY3OleL4pECs/E2OUe0CXnJN2Hy+yEE9nNWtiOYxjT9CjCFKUvaYvgQql+37rKhfAQ87e7p6UqGJQcItSOYEqdvuC4PdQGxQBbQGJh5hNbU+qCZfScygUGSiVxgyA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=4/tAT6Kh; arc=none smtp.client-ip=113.46.200.219
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="4/tAT6Kh"
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=OsSkMIhsameVeQcyubflsAKjqyDPzlK/Dltq516R/Cc=;
	b=4/tAT6KhStANNCVtYQC+DB5wYYXDiC3tT34fBpKlCqPTh2I1YSkgN/f/nRnKQCczgulZrLa5x
	SMtVukw+4IMcbUBzz4us12yj4rcnLybfHqc3ah2t+jgK2r5itK8c4c82rj9Gk9VcSKgK+3/ji5n
	r0Yl4uQkkWaI+TBCQprUFWY=
Received: from mail.maildlp.com (unknown [172.19.162.144])
	by canpmsgout04.his.huawei.com (SkyGuard) with ESMTPS id 4hVJrX05jqz1prQB;
	Wed, 26 Aug 2026 17:14:52 +0800 (CST)
Received: from dggpemf500011.china.huawei.com (unknown [7.185.36.131])
	by mail.maildlp.com (Postfix) with ESMTPS id 8733E4056D;
	Wed, 26 Aug 2026 17:25:39 +0800 (CST)
Received: from huawei.com (10.90.53.73) by dggpemf500011.china.huawei.com
 (7.185.36.131) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Wed, 26 Aug
 2026 17:25:37 +0800
From: Jinjie Ruan <ruanjinjie@huawei.com>
To: <catalin.marinas@arm.com>, <will@kernel.org>, <mark.rutland@arm.com>,
	<chenhuacai@kernel.org>, <kernel@xen0n.name>, <maddy@linux.ibm.com>,
	<mpe@ellerman.id.au>, <npiggin@gmail.com>, <chleroy@kernel.org>,
	<tglx@kernel.org>, <mingo@redhat.com>, <bp@alien8.de>,
	<dave.hansen@linux.intel.com>, <hpa@zytor.com>, <akpm@linux-foundation.org>,
	<baoquan.he@linux.dev>, <rppt@kernel.org>, <pasha.tatashin@soleen.com>,
	<pratyush@kernel.org>, <ruirui.yang@linux.dev>, <kees@kernel.org>,
	<thuth@redhat.com>, <gshan@redhat.com>, <jic23@kernel.org>,
	<james.morse@arm.com>, <ardb@kernel.org>, <leitao@debian.org>,
	<yeoreum.yun@arm.com>, <sourabhjain@linux.ibm.com>, <coxu@redhat.com>,
	<tangyouling@kylinos.cn>, <hbathini@linux.ibm.com>, <adityag@linux.ibm.com>,
	<ionut.nechita@windriver.com>, <liaoyuanhong@vivo.com>, <seanjc@google.com>,
	<fuqiang.wang@easystack.cn>, <makb@juniper.net>, <piliu@redhat.com>,
	<ebiggers@kernel.org>, <jbouron@amazon.com>, <mclapinski@google.com>,
	<me@linux.beauty>, <graf@amazon.com>, <bgwin@google.com>, <robh@kernel.org>,
	<takahiro.akashi@linaro.org>, <palmer@rivosinc.com>, <x86@kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	<loongarch@lists.linux.dev>, <linuxppc-dev@lists.ozlabs.org>,
	<kexec@lists.infradead.org>, <linux-fsdevel@vger.kernel.org>,
	<linux-mm@kvack.org>
CC: <ruanjinjie@huawei.com>
Subject: [PATCH v3 13/17] crash: Improve elfcorehdr segment identification
Date: Wed, 26 Aug 2026 17:25:37 +0800
Message-ID: <20260826092541.3905933-14-ruanjinjie@huawei.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260826092541.3905933-1-ruanjinjie@huawei.com>
References: <20260826092541.3905933-1-ruanjinjie@huawei.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: kwepems500002.china.huawei.com (7.221.188.17) To
 dggpemf500011.china.huawei.com (7.185.36.131)

Only checking ELFMAG is insufficient, as other segments like the
kernel image or an ELF initrd may also start with \x7fELF, leading
to misidentification. This is especially problematic when elfcorehdr
is not the last segment, such as:

	kexec -d --t bzImage -p bzImage --initrd=/bin/true

Add an "e_type == ET_CORE" check to ensure the correct segment is
identified, and break early after finding it.

Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
---
 kernel/crash_core.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/kernel/crash_core.c b/kernel/crash_core.c
index bd3f82b62751..0730c4ea8054 100644
--- a/kernel/crash_core.c
+++ b/kernel/crash_core.c
@@ -737,9 +737,14 @@ static void crash_handle_hotplug_event(unsigned int hp_action, unsigned int cpu,
 			mem = image->segment[n].mem;
 			ptr = kmap_local_page(pfn_to_page(mem >> PAGE_SHIFT));
 			if (ptr) {
+				Elf64_Ehdr *ehdr = (Elf64_Ehdr *)ptr;
+
 				/* The segment containing elfcorehdr */
-				if (memcmp(ptr, ELFMAG, SELFMAG) == 0)
+				if (memcmp(ptr, ELFMAG, SELFMAG) == 0 && ehdr->e_type == ET_CORE) {
 					image->elfcorehdr_index = (int)n;
+					kunmap_local(ptr);
+					break;
+				}
 				kunmap_local(ptr);
 			}
 		}
-- 
2.34.1

