Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 636C935E923
	for <linux-fsdevel@vger.kernel.org>; Thu, 25 Jun 2026 01:00:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782349253; cv=none; b=sSmuljAUbL26iDU9auHc5Jl9QOIQM2d/2kDVikUHKwV6zDDGJWcHQ5YFfuxDIYZMf5efYxMD7QZ8AjeCFFwCHTuqYjzcdvIOU1q/3CSB+V9lfrDkMv2p1uc222leqkyMAdyLLCvpZSyk9bsy5Jnct26yyLBDIRApwuio0ma1a4M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782349253; c=relaxed/simple;
	bh=NIuHUaCbK+JQ3zUBEsVFN3pd5/PVNb3AxNOz0Cd4J+M=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=ZplNfL/cH3S017wpz5Z/uf1/ykFk2MkmIiwQa4z8s5vO1j4x87UJUz+XIHulAhxEU2jHrJMaX0gA95eNxfZiOC6eBO4Tc4cs8MfZLWBJXMIqnZ/G7jEcctzoh+HZEJvfYJ+vKf5i3tfy0JJBlAyzCRKh808bhc1NtwgndQqAkVY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=A2YxHMT6; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="A2YxHMT6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D1CD1F000E9;
	Thu, 25 Jun 2026 01:00:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux-foundation.org; s=korg; t=1782349251;
	bh=oj9mMOYBY8ngL22CLmtfBvnNJxVarI+p1U03u0pmCOM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=A2YxHMT6R/W8cj5JVYBHzylRScaxX8re6ESUJXmTTS3TlPC+zp96zusYCfBmHRHIH
	 oYpRwPmOv4HRSzULzt16HALnMArBaK5yk+zwnafUSAEHpi9hIzTXrkcM47tNVEj5wV
	 /vDsvYk0ICRjzQ0A89I4hewjyyc98sb3AIZRN/qA=
Date: Wed, 24 Jun 2026 18:00:51 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Jinjiang Tu <tujinjiang@huawei.com>
Cc: "David Hildenbrand (Arm)" <david@kernel.org>, <ziy@nvidia.com>,
 <luizcap@redhat.com>, <willy@infradead.org>, <linmiaohe@huawei.com>,
 <svetly.todorov@memverge.com>, <xu.xin16@zte.com.cn>,
 <chengming.zhou@linux.dev>, <linux-fsdevel@vger.kernel.org>,
 <linux-mm@kvack.org>, <wangkefeng.wang@huawei.com>, <sunnanyong@huawei.com>
Subject: Re: [PATCH] fs/proc: fix KPF_KSM reported for all anonymous pages
Message-Id: <20260624180051.134da6553b4f0c4c2785f730@linux-foundation.org>
In-Reply-To: <601fb5dd-18e1-4a6c-bc99-dc2a655240e2@huawei.com>
References: <20260622091539.836531-1-tujinjiang@huawei.com>
	<93e9c643-f6fb-4377-ac5a-d91e203ad1a6@kernel.org>
	<601fb5dd-18e1-4a6c-bc99-dc2a655240e2@huawei.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 23 Jun 2026 09:37:57 +0800 Jinjiang Tu <tujinjiang@huawei.com> wrote:

> > This only affects /proc/kpageflags (well, and hwpoison inject on a weird testing
> > interface), so it's not really that relevant for real workloads (debugging and
> > testing).
> >
> > So not sure whether we should CC:stable. Likely not.
> 
> /proc/kpageflags is generally used only for analysis and is unlikely to be
> used in production environments. I found this issue due to I was analyzing
> pfns allocated by which stacks are KSM-merged. So I think it's unnecessary
> to CC:stable.

Well, it's a bug.  The fix is super-simple so I think it's reasonable
to feed it back to users of earlier kernels.

