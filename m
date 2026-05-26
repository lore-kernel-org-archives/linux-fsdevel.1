Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1D8038D6BD;
	Tue, 26 May 2026 16:23:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779812600; cv=none; b=b1dTA+dj1S3Tde1JOIddEbFqtXSDzqTfFjLL3YWfFLXmtAr88RVcYg3Bec1eiS1IAMBCb/FqgrbJh0ZZ2r8vuczpXUoK+Fs2hIxzsPU5zgej9+PcycZhJV8h3BEAbzauNDoF5umIwaRCNYboYnhvD80cbE47HTBnibyJWju/rug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779812600; c=relaxed/simple;
	bh=KBUPm4P6Bl8HVm5j5M0bks7G/t81X8NaLRQmYcZmSlQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Dumuvpj7lviJk7WfpmqiwKDmAR7dt0UguXMsd6L9jOWyQPjRyzf9m5onOrOYzcl4eSZFDwY6opLoU6nQyrGu/rB6vgHem8VOsBdiQwTek2+l7ri46TjMzuxOK4tMnbcFAChSHElj1cxigVijQYsJi2gC54TXvR+i+Ui+WlZcsCI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KatpinNM; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KatpinNM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 138661F000E9;
	Tue, 26 May 2026 16:23:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779812599;
	bh=KBUPm4P6Bl8HVm5j5M0bks7G/t81X8NaLRQmYcZmSlQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=KatpinNMFdRooR68kKMyhU6m4qPyr3dc39wmPeaRDNfl53kS0EzEWcYm+ieSahUZa
	 ouhlKiZEeggGGaeJa/O02sxmrnlzgpwgYXNXuyu/moAhLSqcV55Xf1AjHNstXCizim
	 HDnk7Sn1zo7R3Fl/pGTnCqfe5eX/v4iFbgTs8AShVunEZJWuVLqQPPRcaPfba2MqCF
	 yYfL3fsCwbNDQcu1W9BT7JoaDjzTTz8P/cVSQaTDEZFWaLKMk57CmZwOfXOepsBHP9
	 60X1w8Z78CDyYqEUGKr0FzfPvCMfVr8+7uozzgkqEU2wgF3MCy0gQ3tknW3AqT3oSU
	 /YtG5tHqGwDaw==
Date: Tue, 26 May 2026 17:23:17 +0100
From: Lorenzo Stoakes <ljs@kernel.org>
To: Jiaqi Yan <jiaqiyan@google.com>
Cc: linmiaohe@huawei.com, william.roche@oracle.com, harry.yoo@oracle.com, 
	jane.chu@oracle.com, nao.horiguchi@gmail.com, tony.luck@intel.com, 
	wangkefeng.wang@huawei.com, willy@infradead.org, akpm@linux-foundation.org, 
	osalvador@suse.de, rientjes@google.com, duenwen@google.com, jthoughton@google.com, 
	jgg@nvidia.com, ankita@nvidia.com, peterx@redhat.com, sidhartha.kumar@oracle.com, 
	ziy@nvidia.com, david@redhat.com, dave.hansen@linux.intel.com, 
	muchun.song@linux.dev, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v3 0/3] memfd-based Userspace MFR Policy for HugeTLB
Message-ID: <ahXI0cK9fsOByvKy@lucifer>
References: <20260203192352.2674184-1-jiaqiyan@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260203192352.2674184-1-jiaqiyan@google.com>

Hi Jiaqi,

It seems this series got stalled on review, wondered if you planned to
respin it at all?

Thanks, Lorenzo
