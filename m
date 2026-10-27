Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793122740;
	b=edYqIz/bMQoeqcVAqIWTRWhbIfrW2UZxPtNuEb1OqXXOhPVDuxTV+kqLSGsN1Pi7eDvY
	 fx8AikIHGo6ZOTiv/RNE1nrca0ltib86whrQNRHdrv8/lZ0PWI6Sl/mCw7KKox9TMJMWE
	 56hxbMgV9OYMOLR2VFvCZiFGQCHGkT8XXEy8Oey9Pev+5V0RC7gx8uOTGNmlAoRtvRxip
	 5Yxb5OvGkzSNCFNGtSBJoh98AzpACGCd3jWU82cnJyJtjCeoYleihMIa+aI5aq8FqNnl0
	 +h3DxwZKBNNJyH6DC1FpzG6hxgwL5iNXamGr4qY4uNUi1y/a3ONXx6luIcrKW5L1oDA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793122740;
	h=Received:DKIM-Signature:From:To:Cc:Subject:In-Reply-To:References:
	 Date:Message-ID:User-Agent:MIME-Version:Content-Type;
	bh=2cBJI2nnIkywytYzxR6H/QQFOPTi1qFD5/ttRLHdX9w=;
	b=Q1bYhp6aXyyS3Rmb08xGL82PQGIcxbbvXoytE1j31V1qjPb1W8EKgpVQpvvB+Nd0j0W3
	 hVG7ViYHIYMyBNVRblqzJZtU90bqgTgE4bQd5OzZbzhnNkd2DsEtjJUXm9/EaagFju5hs
	 McxHx96xml64C2VaU3quy9ZO0bvAUkUYHigIG0P5WLi7MOG0SVsVNVzZ9sAu2mRFwMVbm
	 fNPd4nLjKdLVL0zpVsEjvgCz2jUJU9NjhZmFBm87I4UvRhsuA+Nc5bDxhfXLbv/jPaEW5
	 B9tuVrEQ+uguUzDt6khUQCBtB+/dfjiUi/dvdxNsMHdf0yQ+xEaoL0WMiQ/rgXgVwNA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="XJSi/vmL";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC0E0606A31D;
	Tue, 27 Oct 2026 17:38:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XJSi/vmL
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BAC361F01825;
	Tue, 27 Oct 2026 17:38:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793122739;
	bh=2cBJI2nnIkywytYzxR6H/QQFOPTi1qFD5/ttRLHdX9w=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date;
	b=XJSi/vmLDkwnReKwKmEX4JRALl4syw+iIaeGn0uJWZZMKBFHHtHiF7enafrQ9woRP
	 yoSRlydCDwzuwwl/OCE+bZzKi3TXFoBvcoJ7/8vdphLqH13Vv4flItJXCKhApdPjX5
	 1fhiuCB7uODos7v0qtlUXi9BUb8CZY6nWHQ8JhpV8fhP6cfpK7Sb1TnmkbRqOB7ra7
	 8cu4ZAjnKmBA7PU8Ne84zg0Cmmg3Gh5PgrGF7ASspqYFeRa0sOzJLgYGuukSpK0FBJ
	 qjrKoONkCB6PmdFb5kmfDuZmQRqF1xnZH1d8ct2sQ+Bidhd/moOzuhhrX9Swacz4DS
	 c10ssfWxCS0og==
From: Pratyush Yadav <pratyush@kernel.org>
To: "David Hildenbrand (Arm)" <david@kernel.org>
Cc: Pratyush Yadav <pratyush@kernel.org>,  Alexander Viro
 <viro@zeniv.linux.org.uk>,  Christian Brauner <brauner@kernel.org>,  Jan
 Kara <jack@suse.cz>,  "Matthew Wilcox (Oracle)" <willy@infradead.org>,
  Hugh Dickins <hughd@google.com>,  Baolin Wang
 <baolin.wang@linux.alibaba.com>,  Andrew Morton
 <akpm@linux-foundation.org>,  Zi Yan <ziy@nvidia.com>,  "Liam R. Howlett"
 <liam@infradead.org>,  Nico Pache <nico.pache@linux.dev>,  Ryan Roberts
 <ryan.roberts@arm.com>,  Dev Jain <dev.jain@arm.com>,  Barry Song
 <baohua@kernel.org>,  Lance Yang <lance.yang@linux.dev>,  Usama Arif
 <usama.arif@linux.dev>,  Kiryl Shutsemau <kas@kernel.org>,  Pasha Tatashin
 <pasha.tatashin@soleen.com>,  Mike Rapoport <rppt@kernel.org>,  Matthew
 Brost <matthew.brost@intel.com>,  Joshua Hahn <joshua.hahnjy@gmail.com>,
  Byungchul Park <byungchul@sk.com>,  Gregory Price <gourry@gourry.net>,
  Ying Huang <ying.huang@linux.alibaba.com>,  Alistair Popple
 <apopple@nvidia.com>,  Kairui Song <kasong@tencent.com>,  Qi Zheng
 <qi.zheng@linux.dev>,  Shakeel Butt <shakeel.butt@linux.dev>,  Axel
 Rasmussen <axelrasmussen@google.com>,  Yuanchu Xie <yuanchu@google.com>,
  Wei Xu <weixugc@google.com>,  Baoquan He <baoquan.he@linux.dev>,
  Johannes Weiner <hannes@cmpxchg.org>,  Michal Hocko <mhocko@kernel.org>,
  Lorenzo Stoakes <ljs@kernel.org>,  linux-fsdevel@vger.kernel.org,
  linux-kernel@vger.kernel.org,  linux-mm@kvack.org,
  kexec@lists.infradead.org
Subject: Re: [PATCH 0/3] mm: allow freezing mappings
In-Reply-To: <fcb7b786-53e5-49bb-8505-63eb8bb4e836@kernel.org> (David
	Hildenbrand's message of "Tue, 27 Oct 2026 18:35:51 +0100")
References: <20261027173031.763213-1-pratyush@kernel.org>
	<fcb7b786-53e5-49bb-8505-63eb8bb4e836@kernel.org>
Date: Tue, 27 Oct 2026 18:38:52 +0100
Message-ID: <2vxz33troxg3.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain

On Tue, Oct 27 2026, David Hildenbrand (Arm) wrote:

> On 10/27/26 18:30, Pratyush Yadav wrote:
>> From: "Pratyush Yadav (Google)" <pratyush@kernel.org>
>> 
>> Hi,
>
> Hi,
>
> we're in the merge windows and focused on fixing things (apparently all of the
> kernel). This is not the right time to discuss new changes.

Sorry. I thought the MM tree was open to changes in the merge window.
Please feel free to ignore this until you are done with the merge
window. I can also resend it after -rc1/-rc2 if you'd like.

-- 
Regards,
Pratyush Yadav
