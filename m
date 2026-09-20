Received: from canpmsgout06.his.huawei.com (canpmsgout06.his.huawei.com [113.46.200.221])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 501C33403EA;
	Sun, 20 Sep 2026 03:14:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.221
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789874051; cv=none; b=IOphT0FD/1/n4DEdg0ShdcTayEGljBd5h6JMkXeHAK0d+uBdsTQWMhLmjedXgVtl+oEeMIPCLjrX2KiZYwZ7qmKl7M11uE7oz5NsCBnd23eNkrh9xq6W0b+aoC4Ols+8KPN222kX/6ryjpqh0VstA3ekVikjAZKpD70ca8ktKyk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789874051; c=relaxed/simple;
	bh=HAMi7+oZdiukKChTrHSeSa7wUVBgpWSMFhtujEm4BfA=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=nJTvdRJLyttjwNmKN2ZEOores7MzAZ4lbTbOxoc+EOP5aUEI9/vM8dYzi09Sn1OiY2h5BKkgJ77LlMzX1/mqy1WjGLJZxX/l4Z2zFTByNJK/WlvcIybCeVHD4RQoCiUQUIbMNNmSXtCtjsOnrf6um9BHHE1DCNilk7PO52njFJM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=vdnPyXL/; arc=none smtp.client-ip=113.46.200.221
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="vdnPyXL/"
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=Y6VD7DCnH5Wvn+wLxKkGYY5QQQQVDg52h78IKUBAQi8=;
	b=vdnPyXL/sZl6KsrVijZZPPrCyCxRV/tFodClDTuKzGvY6Af9QA/vmT7WI7iRz+JtR0iJaghc9
	rWMdPn+sthbDccaL/g5uqlDOWi+EKPS9b8rocHseUe3ni4l7EY17RAxGh2/pEBTk4sDiwv9WLI3
	CaDH9HqNKl1QubrRmWw4cks=
Received: from mail.maildlp.com (unknown [172.19.163.0])
	by canpmsgout06.his.huawei.com (SkyGuard) with ESMTPS id 4hnWNk6BPnzRhQs;
	Sun, 20 Sep 2026 11:01:58 +0800 (CST)
Received: from kwepemk200008.china.huawei.com (unknown [7.202.194.74])
	by mail.maildlp.com (Postfix) with ESMTPS id C57E740537;
	Sun, 20 Sep 2026 11:13:58 +0800 (CST)
Received: from [10.67.109.254] (10.67.109.254) by
 kwepemk200008.china.huawei.com (7.202.194.74) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Sun, 20 Sep 2026 11:13:55 +0800
Message-ID: <97dce1c2-827a-437f-bff0-9c7057cc2923@huawei.com>
Date: Sun, 20 Sep 2026 11:13:54 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 00/17] crash: Rework and add arm64 crash hotplug
 support
To: Breno Leitao <leitao@debian.org>
CC: <catalin.marinas@arm.com>, <will@kernel.org>, <mark.rutland@arm.com>,
	<chenhuacai@kernel.org>, <kernel@xen0n.name>, <maddy@linux.ibm.com>,
	<mpe@ellerman.id.au>, <npiggin@gmail.com>, <chleroy@kernel.org>,
	<ritesh.list@gmail.com>, <sshegde@linux.ibm.com>, <tglx@kernel.org>,
	<mingo@redhat.com>, <bp@alien8.de>, <dave.hansen@linux.intel.com>,
	<hpa@zytor.com>, <gregkh@linuxfoundation.org>, <rafael@kernel.org>,
	<dakr@kernel.org>, <akpm@linux-foundation.org>, <baoquan.he@linux.dev>,
	<rppt@kernel.org>, <pasha.tatashin@soleen.com>, <pratyush@kernel.org>,
	<ruirui.yang@linux.dev>, <kees@kernel.org>, <thuth@redhat.com>,
	<gshan@redhat.com>, <ardb@kernel.org>, <james.morse@arm.com>,
	<yeoreum.yun@arm.com>, <sourabhjain@linux.ibm.com>, <robh@kernel.org>,
	<coxu@redhat.com>, <tangyouling@kylinos.cn>, <liukexin@kylinos.cn>,
	<guodongtai@kylinos.cn>, <maqianga@uniontech.com>,
	<zhangtianyang@loongson.cn>, <blum@kernel.org>, <adityag@linux.ibm.com>,
	<chao.gao@intel.com>, <kas@kernel.org>, <vishal.l.verma@intel.com>,
	<seanjc@google.com>, <piliu@redhat.com>, <jbouron@amazon.com>,
	<me@linux.beauty>, <mclapinski@google.com>, <graf@amazon.com>,
	<bgwin@google.com>, <eric.devolder@oracle.com>, <hbathini@linux.ibm.com>,
	<takahiro.akashi@linaro.org>, <lizhengyu3@huawei.com>, <palmer@rivosinc.com>,
	<x86@kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>, <loongarch@lists.linux.dev>,
	<linuxppc-dev@lists.ozlabs.org>, <driver-core@lists.linux.dev>,
	<kexec@lists.infradead.org>, <linux-fsdevel@vger.kernel.org>,
	<linux-mm@kvack.org>
References: <20260918100442.3841135-1-ruanjinjie@huawei.com>
 <aq0UR62q6gGJUQ49@gmail.com>
From: Jinjie Ruan <ruanjinjie@huawei.com>
In-Reply-To: <aq0UR62q6gGJUQ49@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: kwepems500001.china.huawei.com (7.221.188.70) To
 kwepemk200008.china.huawei.com (7.202.194.74)



在 2026/9/18 18:41, Breno Leitao 写道:
> On Fri, Sep 18, 2026 at 06:04:25PM +0800, Jinjie Ruan wrote:
>> When CPU or memory hotplug events occur, the elfcorehdr in the kdump
>> image becomes stale, potentially leading to incomplete crash dumps.
> 
> Looking through the series, it seems to mix bug fixes with new
> feature work. Would it make sense to split out the fixes so they
> can land independently, and keep the new features as a separate
> patchset?

Hi, Breno,

Thanks for the review. I agree with splitting the series. I will
separate the bug fixes into an independent patchset so you can pick them
up more easily. Please note that the arm64 crash hotplug feature depends
on these fixes, so they need to land first. I will send out the split
patches soon.

> 
> I'm currently rolling out crashdump CMA across the Meta fleet, so
> right now I care mostly about picking up isolated bug fixes. As it
> stands, it's difficult to tell which patches are fixes and which
> are features.

Only the last three patches are related to the feature, and all the
preceding patches are bug fixes. I will separate them out.


-- 
Best regards,
Jinjie

