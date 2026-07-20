Received: from mxhk.zte.com.cn (mxhk.zte.com.cn [160.30.148.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44514396B9D;
	Mon, 20 Jul 2026 07:38:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=160.30.148.35
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784533113; cv=none; b=MhyJEEOh3AtKNkyC6QKkG4U5PL/U/etptABRmw7ZGg+gTCmqnh9MIaZkjAq4QUag1Gaaez3kwvVCx385rUu2mLSGVbNgTWzdXwBp0wLbhm9Nd8TaurIkOCOCKEQQKQzLksNJkIr6QPp857GD7jZKj0sRN/oAbNAvobmK4Se5dws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784533113; c=relaxed/simple;
	bh=KiEwYI2Bg9KRdu6bTZTIWcPQ6z8ZUjBZQ92YKjygue4=;
	h=Message-ID:In-Reply-To:References:Date:Mime-Version:From:To:Cc:
	 Subject:Content-Type; b=b4JRHmjESbOuS5fwhMPDKWB1lHwT7RmLQijrkskMMdx9C8BvXvshAxJSGGrzaDhLedt0emQ6JsBsdi18DFP0vR83q2rlQ6EvQFn72+Nh67tM9F8c/DBn3wlYsaTnmcxQmcWpBgDKq+jj9LhlXOrxK0Lk5+gLRjYdMU04xxX0pR4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zte.com.cn; spf=pass smtp.mailfrom=zte.com.cn; arc=none smtp.client-ip=160.30.148.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zte.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zte.com.cn
Received: from mse-fl2.zte.com.cn (unknown [10.5.228.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mxhk.zte.com.cn (FangMail) with ESMTPS id 4h3XSG5Xwwz7VD94;
	Mon, 20 Jul 2026 15:38:22 +0800 (CST)
Received: from xaxapp04.zte.com.cn ([10.99.98.157])
	by mse-fl2.zte.com.cn with SMTP id 66K7cEmj047214;
	Mon, 20 Jul 2026 15:38:14 +0800 (+08)
	(envelope-from xu.xin16@zte.com.cn)
Received: from mapi (xaxapp04[null])
	by mapi (Zmail) with MAPI id mid32;
	Mon, 20 Jul 2026 15:38:16 +0800 (CST)
X-Zmail-TransId: 2afb6a5dd0685f6-f3887
X-Mailer: Zmail v1.0
Message-ID: <20260720153816171RRd991pToocX8jt6806EG@zte.com.cn>
In-Reply-To: <al3KlYMbmeR6iDX8@lucifer>
References: 20260717-b4-scalable-cow-virt-pgoff-v1-1-cf24910ef094@kernel.org,202607191155425057lNrNOYTi44E_jmidmtkn@zte.com.cn,al3KlYMbmeR6iDX8@lucifer
Date: Mon, 20 Jul 2026 15:38:16 +0800 (CST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
From: <xu.xin16@zte.com.cn>
To: <ljs@kernel.org>
Cc: <akpm@linux-foundation.org>, <david@kernel.org>, <liam@infradead.org>,
        <vbabka@kernel.org>, <rppt@kernel.org>, <surenb@google.com>,
        <mhocko@suse.com>, <jannh@google.com>, <pfalcato@suse.de>,
        <willy@infradead.org>, <jack@suse.cz>, <linmiaohe@huawei.com>,
        <nao.horiguchi@gmail.com>, <riel@surriel.com>, <harry@kernel.org>,
        <lance.yang@linux.dev>, <kees@kernel.org>, <ziy@nvidia.com>,
        <baolin.wang@linux.alibaba.com>, <npache@redhat.com>,
        <ryan.roberts@arm.com>, <dev.jain@arm.com>, <baohua@kernel.org>,
        <usama.arif@linux.dev>, <matthew.brost@intel.com>,
        <joshua.hahnjy@gmail.com>, <rakie.kim@sk.com>, <byungchul@sk.com>,
        <gourry@gourry.net>, <ying.huang@linux.alibaba.com>,
        <apopple@nvidia.com>, <peterx@redhat.com>, <chengming.zhou@linux.dev>,
        <arnd@arndb.de>, <gregkh@linuxfoundation.org>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>,
        <linux-kselftest@vger.kernel.org>
Subject: =?UTF-8?B?UmU6IFtQQVRDSCAwMS8xNV0gbW0vdm1hOiBpbnRyb2R1Y2UgVk1BIHZpcnR1YWwgcGFnZSBvZmZzZXQgZmllbGQgYW5kIGFkZCBoZWxwZXJz?=
Content-Type: text/plain;
	charset="UTF-8"
X-MAIL:mse-fl2.zte.com.cn 66K7cEmj047214
X-TLS: YES
X-ENVELOPE-SENDER: xu.xin16@zte.com.cn
X-SOURCE-IP: 10.5.228.133 unknown Mon, 20 Jul 2026 15:38:22 +0800
X-CLEAN: YES
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 6A5DD06E.001/4h3XSG5Xwwz7VD94

> > > This patch establishes fields within the vm_area_struct type to store the
> > > virtual page offset of VMAs.
> > >
> > > The virtual page offset of a VMA is equal to vma->vm_start >> PAGE_SHIFT if
> > > they are unfaulted or were not remapped, otherwise it is equal to this
> > > value at the point of first fault.
> > >
> > > Currently, anonymous folios belonging to CoW'd MAP_PRIVATE-mapped
> > > file-backed VMAs are tracked by their file offset. By adding virtual offset
> > > as a property of VMAs, we can now track them by their virtual page offset
> > > instead.
> > >
> > > By tracking this, we provide the means by which to eliminate this
> > > inconsistency, and more importantly lay the foundations for future work for
> > > the scalable CoW anonymous rmap rework.
> > >
> > > This patch simply adds the fields and some simple helpers. Subsequent
> > > patches will update mm code to make use of these fields correctly.
> > >
> > > The fields chosen are packed in the VMA such that, for 64-bit kernel
> > > builds, no additional space is taken up.
> >
> > It is not necessarily true that no additional memory will be consumed, as it
> > depends on whether the baseline kernel has CONFIG_PER_VMA_LOCK enabled.
> 
> We are moving to this being permanently enabled.
> 
> > Moreover, in the future evolution of mm, maintaining this benefit would
> > require that the layout of struct vm_area_struct before __vm_virt_pgoff_lo
> > remains unchanged, which seems impractical.
> 
> It isn't, we are very careful with this struct.

Ok, That will be nice.

> 
> >
> > My personal suggestion is: maybe we could simply add an unsigned long field,
> > say vm_virt_pgoff, without worrying about the increased memory footprint for
> > now. Additionally, it would be helpful to add some comments clarifying the
> > difference between this new field and the existing vm_pgoff, to aid understanding.
> 
> Nope that'd add 64 bytes per VMA for a typical usage which can add up to a lot.

Okay, but I hope at least we could be a bit more verbose in the comments, because
__vm_virt_pgoff_lo and __vm_virt_pgoff_hi are located somewhat far apart from each
other, which might cause considerable confusion for others seeing these two
variables for the first time, and clarify difference between this new field and the
existing vm_pgoff, to aid understanding.

Thanks.
