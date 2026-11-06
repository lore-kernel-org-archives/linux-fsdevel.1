Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=91.218.175.91
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793947100;
	b=Cona8GKRvIoNn4mrTlPUoAYCalbEk5no5HhNqdn4YEshsqyoTFIpqDHICEgc+zqkwkbw
	 cOzWBoMkEfkYi7oFjBvHuvYgjuBOWrqqzE3+RYwbeIQ+HDSrhiVdaOI9mcQBqrnpCsrqd
	 S5p0EyYhjZeIKjg7RQsPG8VpCNL5WLdTKJKj8b2aLUCbAmIutJthMxX9z9Aud5XEup8SA
	 DiTVqWHMAnLmAZaCjpjthN6SwERF56jy9M+UOOndwHbQoce6mGGP36FtGu+HxbhZp9Mj7
	 ecRThvohIXoeMqYZiKix0Rlvz+pIjtHPOQbpeICQuXguD8C8jfMNtIi5ksgxYblp+Qg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793947100;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=tcht1R5s/T4pHG5HNU6dTugC2c81irUDLp57CkDkwJg=;
	b=qFAc4xu0e068lhaEbQWP/NocFfdlAVsSbG4EX4Bdfcj7+HIRxdi64CzYoPK1OZf/Kb2W
	 XLuXZxi0TVkQY6Im5zYZc4vGAqT5HeLl1U8fnHe7XN3RIcQCXoW4s7K76ZLpEf8zYIWB1
	 aYxJVtn9a8ZYDeJvISb72TgfA4UKJ2EvWHxCHhmuR5sV16b+rs3Jxpti2YoF/dHbjZxRB
	 3Vd2/dWw2/7SCa0Hr6UTeCtIe4vLa1qHlqr4oGlJMLciLj/gzAyftcdRdqgVh8gUoN3R8
	 Xook6b9IIva6EaOG+Y8iyxyTVCVkk0eWEeB6NFBmu5G8UjJHeL2RqMIMyJWaeLEondA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	arc=none smtp.remote-ip=91.218.175.91
Received: from mta0.migadu.com (out-91.mta0.migadu.com [91.218.175.91])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF38E606A32C
	for <linux-fsdevel@vger.kernel.org>; Fri,  6 Nov 2026 06:38:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EF38E606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Envelope-To: linux-fsdevel@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=tcht1R5s/T4pHG5HNU6dTugC2c81irUDLp57CkDkwJg=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1793947096; v=1; x=1794551896;
 b=QfFBfMJqKZgCax0UNwVIBGuXekl2lbdBW7zSO4+ipBP3z7qJ0nblJww6chQ8uL6nLj+Vy8i7
 ZPl6wNO0XFcZ4/jmaoh0UFyBELnarRn3C9kvG9XCT6oSH61Os87h0wSAHV4yFtAIs4FKj51+3+7
 A1ZBAI+9H5wEv0yPiJV0qTNc=
X-Envelope-To: linux-fsdevel@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 28db605e17711592;
	Fri, 06 Nov 2026 06:38:11 +0000
X-Mizu-Trace-ID: 28db605e17711592
X-Migadu-Flow: FLOW_OUT
From: Lance Yang <lance.yang@linux.dev>
To: ljs@kernel.org
Cc: akpm@linux-foundation.org,
	david@kernel.org,
	jgg@ziepe.ca,
	jhubbard@nvidia.com,
	peterx@redhat.com,
	willy@infradead.org,
	jack@suse.cz,
	riel@surriel.com,
	liam@infradead.org,
	vbabka@kernel.org,
	harry@kernel.org,
	jannh@google.com,
	lance.yang@linux.dev,
	ziy@nvidia.com,
	matthew.brost@intel.com,
	joshua.hahnjy@gmail.com,
	byungchul@sk.com,
	gourry@gourry.net,
	ying.huang@linux.alibaba.com,
	apopple@nvidia.com,
	baolin.wang@linux.alibaba.com,
	nico.pache@linux.dev,
	ryan.roberts@arm.com,
	dev.jain@arm.com,
	baohua@kernel.org,
	usama.arif@linux.dev,
	kas@kernel.org,
	xu.xin@linux.dev,
	chengming.zhou@linux.dev,
	maddy@linux.ibm.com,
	npiggin@gmail.com,
	mpe@ellerman.id.au,
	chleroy@kernel.org,
	ritesh.list@gmail.com,
	sshegde@linux.ibm.com,
	pfalcato@suse.de,
	kasong@tencent.com,
	qi.zheng@linux.dev,
	shakeel.butt@linux.dev,
	axelrasmussen@google.com,
	yuanchu@google.com,
	weixugc@google.com,
	baoquan.he@linux.dev,
	rppt@kernel.org,
	surenb@google.com,
	mhocko@suse.com,
	leon@kernel.org,
	sj@kernel.org,
	rakie.kim@sk.com,
	rientjes@google.com,
	viro@zeniv.linux.org.uk,
	brauner@kernel.org,
	peterz@infradead.org,
	mingo@redhat.com,
	acme@kernel.org,
	namhyung@kernel.org,
	mark.rutland@arm.com,
	alexander.shishkin@linux.intel.com,
	jolsa@kernel.org,
	irogers@google.com,
	adrian.hunter@intel.com,
	james.clark@linaro.org,
	mhiramat@kernel.org,
	oleg@redhat.com,
	john.johansen@canonical.com,
	georgia.garcia@canonical.com,
	paul@paul-moore.com,
	jmorris@namei.org,
	serge@hallyn.com,
	zohar@linux.ibm.com,
	roberto.sassu@huawei.com,
	dmitry.kasatkin@gmail.com,
	eric.snowberg@oracle.com,
	wufan@kernel.org,
	stephen.smalley.work@gmail.com,
	omosnacek@gmail.com,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	kvm@vger.kernel.org,
	damon@lists.linux.dev,
	linux-trace-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org,
	apparmor@lists.ubuntu.com,
	linux-security-module@vger.kernel.org,
	linux-integrity@vger.kernel.org,
	selinux@vger.kernel.org
Subject: Re: [PATCH 07/13] mm/madvise: convert madvise_vma_behavior() to use vma_flags_t
Date: Fri,  6 Nov 2026 14:38:01 +0800
Message-ID: <20261106063801.47076-1-lance.yang@linux.dev>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20261105-late-2026-vma-flags-v1-7-0d3cd15ab75f@kernel.org>
References: <20261105-late-2026-vma-flags-v1-7-0d3cd15ab75f@kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit


On Thu, Nov 05, 2026 at 09:30:58PM +0000, Lorenzo Stoakes (ARM) wrote:
>Replace use of the legacy vm_flags_t flags with vma_flags_t values
>throughout the madvise logic.
>
>In order to do so, update ksm_madvise() and hugepage_madvise() to take a
>vma_flags_t pointer, and update their other callers in mremap and the
>powerpc KVM ultravisor code accordingly.
>
>In the latter case we replace vm_flags_reset() with vma_overwrite_flags().
>The VMA is write locked at this point, so the atomic flags preserved by
>vma_overwrite_flags() cannot differ from those copied, and the behaviour
>is unchanged.
>
>No functional change intended.
>
>Signed-off-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>
>---

Reviewed-by: Lance Yang <lance.yang@linux.dev>
