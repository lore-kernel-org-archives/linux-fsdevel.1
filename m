Received: from canpmsgout07.his.huawei.com (canpmsgout07.his.huawei.com [113.46.200.222])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E6383EDE42;
	Wed, 26 Aug 2026 09:25:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.222
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787736348; cv=none; b=DZTXChJ9tdSFqIk1uh1uSBT1iepAHG80ZT+qVggEJFejSsuHlMQIgfoJtWhHwX2Ecgq/9xn+FEdyqv1SWykhbrBv9sJUhw3mnyYBPrtqHEapBixkk4+K/EmFC8h+N0KWeUnt387NETpQ2hYLTTHMmIqU7DAxV6mg1wKeXv5G9Ok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787736348; c=relaxed/simple;
	bh=sFgvpqXBFjB0DXF/Xo6Q5XaYIo/m7UqgznW5dkzn1TQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HcBiYPoQqz5z3i8YDuoQNNKRMV/b4j+UD+cvvawlfFhzs1iAuXm9QYLHvargTHsGJKVhnurKhM9cHbbhS/jHMasainxi9+W5/wIjHbu9P0en4u+zoF/4NNOcr/j6QQrLHdFgFzB/+T9QPXk8+pK03EJrKHujg2vHX1urXKl0CKs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=sd/H+UNC; arc=none smtp.client-ip=113.46.200.222
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="sd/H+UNC"
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=3yLl9In8Wv4o0ZdsQbHCo1Df/gDSHHkfLMajcmTmIOU=;
	b=sd/H+UNCaNAatBnZBdwzX8iqrWgk9CvZKeHro8YXwCBizriBg8j/ic2nCnNuWmYjOd30NiN+s
	o0gHA+GVWfBZxWfQc5kddUQtVkrxsFSTSz7Qz2UeV8XoAt1UtBiJcSp4/Oy1mZg78qh4xUuqL3O
	bguC9nDFMKh9jB1NsetGV8w=
Received: from mail.maildlp.com (unknown [172.19.163.214])
	by canpmsgout07.his.huawei.com (SkyGuard) with ESMTPS id 4hVJrf3mV2zLlXB;
	Wed, 26 Aug 2026 17:14:58 +0800 (CST)
Received: from dggpemf500011.china.huawei.com (unknown [7.185.36.131])
	by mail.maildlp.com (Postfix) with ESMTPS id 298AF4057C;
	Wed, 26 Aug 2026 17:25:44 +0800 (CST)
Received: from huawei.com (10.90.53.73) by dggpemf500011.china.huawei.com
 (7.185.36.131) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Wed, 26 Aug
 2026 17:25:41 +0800
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
Subject: [PATCH v3 15/17] crash: Simplify CRASH_MAX_MEMORY_RANGES handling
Date: Wed, 26 Aug 2026 17:25:39 +0800
Message-ID: <20260826092541.3905933-16-ruanjinjie@huawei.com>
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

Set CRASH_MAX_MEMORY_RANGES to 0 when MEMORY_HOTPLUG is disabled, then
remove the now unnecessary IS_ENABLED(CONFIG_MEMORY_HOTPLUG) checks in
powerpc and x86 arch_crash_get_elfcorehdr_size().

No functional change intended.

Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
---
 arch/powerpc/kexec/crash.c | 4 +---
 arch/x86/kernel/crash.c    | 4 +---
 kernel/Kconfig.kexec       | 3 ++-
 3 files changed, 4 insertions(+), 7 deletions(-)

diff --git a/arch/powerpc/kexec/crash.c b/arch/powerpc/kexec/crash.c
index fc0105c7af4c..c47e3f867ea1 100644
--- a/arch/powerpc/kexec/crash.c
+++ b/arch/powerpc/kexec/crash.c
@@ -474,9 +474,7 @@ unsigned int arch_crash_get_elfcorehdr_size(void)
 	unsigned long phdr_cnt;
 
 	/* A program header for possible CPUs + vmcoreinfo */
-	phdr_cnt = num_possible_cpus() + 1;
-	if (IS_ENABLED(CONFIG_MEMORY_HOTPLUG))
-		phdr_cnt += CONFIG_CRASH_MAX_MEMORY_RANGES;
+	phdr_cnt = num_possible_cpus() + 1 + CONFIG_CRASH_MAX_MEMORY_RANGES;
 
 	return elf64_phdr_size(phdr_cnt);
 }
diff --git a/arch/x86/kernel/crash.c b/arch/x86/kernel/crash.c
index 99eb8583d932..116410ac90fb 100644
--- a/arch/x86/kernel/crash.c
+++ b/arch/x86/kernel/crash.c
@@ -407,9 +407,7 @@ unsigned int arch_crash_get_elfcorehdr_size(void)
 	unsigned int sz;
 
 	/* kernel_map, VMCOREINFO and maximum CPUs */
-	sz = 2 + num_possible_cpus();
-	if (IS_ENABLED(CONFIG_MEMORY_HOTPLUG))
-		sz += CONFIG_CRASH_MAX_MEMORY_RANGES;
+	sz = 2 + num_possible_cpus() + CONFIG_CRASH_MAX_MEMORY_RANGES;
 	sz *= sizeof(Elf64_Phdr);
 	return sz;
 }
diff --git a/kernel/Kconfig.kexec b/kernel/Kconfig.kexec
index a97ed9605602..e6251dfe451a 100644
--- a/kernel/Kconfig.kexec
+++ b/kernel/Kconfig.kexec
@@ -160,7 +160,8 @@ config CRASH_HOTPLUG
 
 config CRASH_MAX_MEMORY_RANGES
 	int "Specify the maximum number of memory regions for the elfcorehdr"
-	default 8192
+	default 8192 if MEMORY_HOTPLUG
+	default 0 if !MEMORY_HOTPLUG
 	depends on CRASH_HOTPLUG
 	help
 	  For the kexec_file_load() syscall path, specify the maximum number of
-- 
2.34.1

