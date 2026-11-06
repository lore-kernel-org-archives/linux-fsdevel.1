Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=95.215.58.184
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793949134;
	b=M4vnKq9nanVQhrSTJA0l9MfiJ0tEPQco7RzX8eM8VRV0rUmdYfwjWYp2v1qNNEp3+fwW
	 4Ob36dZvgOEjrIeI3jXspHxe0mIWOd0zHPBv5+NKugNdonxsb/Q61KJOuaq/OFDmNeyzQ
	 nttzV9YwHpr3kJ44JsUpKoAvsL3oARwoAATEg2XnmZU+peu7FM0qxf8oWAOnpEcuLqVt5
	 r+kiXWLB8A5XXz09aWJR3kcu+Io+46ZeBvrLVG2iNriz2QXEMDR5IIWkYzgokmoHpZZal
	 6h3ht77fW4594Vwl1rQEcAxzurr2q+kB5P4wDEqqtEygHSKw61nNlJiIpx+6xZ8Ppuw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793949134;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=2tr7RAK1Z1e7MRIJGh8p+CCxNaKqEt5LEou42TFWdC0=;
	b=kgkEUOr8YDUScMgv3esjVNm/IJzYtt3LfXXxTEi9TUuHuDeCu08xf6+r+hSBix6ukFL3
	 fsefwBWCr47kzzZdMr89mIUb75uSXAYLK38k+YGMoOIvbDAHKvJDqCladmP8AO/K+xaPM
	 tj0vMeNYKgjYrFQOMuln5IrXLl7Zw0o5hoQFLQzmz0a6vjYFsG+jGgDTv9D5FBhyFbZ9k
	 dW96WlC0P1YRGmGOMV+IWGzeOCwRCvaY8u6oRTknopXFQ7wIUBPGwDi8Olk2J02jGlQSA
	 uP9/AuBQ/C868jVpA2o/EepC/RzFnUmhsOci1DYMLgquNlhOyBWL5nOBvnfYidTPIpw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=hUWosO7V;
	arc=none smtp.remote-ip=95.215.58.184
Received: from mta1.migadu.com (out-184.mta1.migadu.com [95.215.58.184])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 635D6606A32E
	for <linux-fsdevel@vger.kernel.org>; Fri,  6 Nov 2026 07:12:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 635D6606A32E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=hUWosO7V
X-Envelope-To: linux-fsdevel@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=2tr7RAK1Z1e7MRIJGh8p+CCxNaKqEt5LEou42TFWdC0=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1793949131; v=1; x=1794553931;
 b=hUWosO7VT/rCOyObOqACqZsQEy19bkG1P26xbOjYFvsoQbtiwvyMiwrnRjaYlwh2wYqYwpjv
 JV3qhCrQks7lpYRfunnGdRIINQ495SS2MPPRiaWzoE+0ql6RTPU1MCiu8zryk/gZqLRS6y3XZJw
 Uv4Ngz0djRsmju7g3j2Zqqw0=
X-Envelope-To: linux-fsdevel@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 007461dbe1b04954;
	Fri, 06 Nov 2026 07:12:09 +0000
X-Mizu-Trace-ID: 007461dbe1b04954
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
Subject: Re: [PATCH 11/13] uprobes: convert VMA flag tests to use vma_flags_t
Date: Fri,  6 Nov 2026 15:12:00 +0800
Message-ID: <20261106071200.52897-1-lance.yang@linux.dev>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20261105-late-2026-vma-flags-v1-11-0d3cd15ab75f@kernel.org>
References: <20261105-late-2026-vma-flags-v1-11-0d3cd15ab75f@kernel.org>
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


On Thu, Nov 05, 2026 at 09:31:02PM +0000, Lorenzo Stoakes (ARM) wrote:
>Replace use of the legacy vm_flags_t flags with vma_flags_t values in the
>uprobes VMA validity checks.
>
>No functional change intended.
>
>Signed-off-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>
>---

Reviewed-by: Lance Yang <lance.yang@linux.dev>
