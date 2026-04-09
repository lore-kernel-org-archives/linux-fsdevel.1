Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C1EB2FD1D0
	for <linux-fsdevel@vger.kernel.org>; Thu,  9 Apr 2026 19:41:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775763677; cv=none; b=u6M3Y27ftvWr4kh8OZX6dPjBD9TLnvKAXmSk7lqvw8zo5huICLqF5wVFVPYpvIJtw9GzQXHqs2x1OIOyzJM1Hd9qkz6mvC7iUfOHGR1l7H/JyFWEML2SxD6DB55gChSqh+Uq/JiSfy/Yuiy1UN3i5Mvd9PHENRzqBL2XB1mEdj4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775763677; c=relaxed/simple;
	bh=/PJnG0g81Uazm2ySSpdx1M8cQl48Pc3TVCyGFdK3QVM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=M41wIO+nshV0j+jZC8JfC3719ZYj11gytb8MsEjIV+vwAnCNdNm/vIuSES/n0SsWhWGqWgKTGJT9/de/GwEZpH22dymjZf71JpCXjemkbQ5EZ25nDHOKsqkUQBusbblitCb1b83Y/uZdeix7JTtICWBaPJDFAE8rQTQZma9Qymo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=IVVVpo3i; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="IVVVpo3i"
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-43cfbd17589so916335f8f.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 09 Apr 2026 12:41:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1775763674; x=1776368474; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ge1b1xcWybylA8rGPuIV1asvwgEzJw2EpZ+7Ph4FvfI=;
        b=IVVVpo3i9YxLpshkTpz+q0gx5M/I0xp5GAoTjNzH6mWcq/npmz9mzz3x3Z1KEgzTJv
         xuZwWnSs8bIETuFodSuX6Ge+7yBrisM91UJhaCuHEnw8vbvqVYqRfsmQUxp/8yscTgX2
         3DihES4q3ScQ1BMM/SrWNyk5qS1DI1w++dFVxMmNeOUc2eNy+Um8gXODKolgVmP4xHVR
         MfLy8oaH8KhPIOC0k/1/9tdd+w0GaHYOBmKnVLg5Amc8q+RyMByLVcF9BDo7jcDECluZ
         kB/DRyQJjpeXGBQWNI21aEqTl0AvpNemir1OBt8cC9HmTr5CMDfpLayJrcKmAz/pDRZR
         ZBnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775763674; x=1776368474;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ge1b1xcWybylA8rGPuIV1asvwgEzJw2EpZ+7Ph4FvfI=;
        b=CZ7yfzQwUREXp0b3dum6BMLTuCVtGpYB3Brp62EZjGtQSuc/1mQd82/GwEPh0BGcnx
         yw8frTeaFwCwlc9CDMM+7AqckSXcjwjfyEghNfhOKYrlMLPhawc1WqSDgpVhn8/0TCHG
         4HxFs0+zj53XjV+wFGTYQrCP0uNyundSpk7l+3zZpKae4PuscYcY7QME94NPwXJJVWQB
         UmDzo+4qNEErVhxahai1wZ0dbyi5SvNu6LOh/cIH3uvJhif3uW+HtvhZkXF4R8NX8PFa
         88UTuk/VEWXloCKH7Mc4Dg1utIj1yKc7ic4x9ZsU0gHRYxUZt6+es+WBypol3NLRMYFt
         tqgw==
X-Forwarded-Encrypted: i=1; AJvYcCVOPUMLSXeBplTQ6XWvk1S7bnTUJe2mxiJQskdQCPOEfpVvKcRRVzxH9z2j6ppI1g8rfrvGXO/ufa8PR0Mn@vger.kernel.org
X-Gm-Message-State: AOJu0Yylpk6Ni+MtV961BXICWJIYbKnw7APWdxC3hBdSZFq+E2o7FGx0
	CQd1j7/6fujhGleEsjAz5gCHiof3YgWno6TAKARbucFguVIxWVSLzOGU/Re8fSzuzrU=
X-Gm-Gg: AeBDieuOcRnl1KH98amArw1Ao03XelmTrOa6NbA1YWZee2TTfKsf3hvWlLwc5GwBsLj
	y4aASpaFRHL2kPX6TlM4AD3AZnGJrKDCONc6ULh3JTxTS3uQ3gSGJ+Bb/oNLj1UC0lE2e7ORIla
	kSWjreiVfGU2Zo4RbcBFbrj0LCkKw9FCaKfM5f7Mdfc8kfZT1uMgZeD5p9yCtbJGYyxEsqEMXaz
	ME+s5G/N7YpwZKlH7lK90abVcztKUoEpiQW5JPii6XdJtAtKQBK8CpfRkF+UOUX3c/qfx045cHm
	0rYD8cLJyuvmbWPQUeELWBfDec2RLLfUn+snUvCrRMzWotEV/RF9dV902iF6NCals4v8XvPImwp
	nG2N3M9+4+EFTEMK8xtOeWa0Ok1L3nfyC706fM88vOdqyz7Y1K5o/vWAajxhNOc6wHeXZjw+Ksw
	fVaDmSpMNigXhCTJx7RriM/9N8xkCDR5laAQ==
X-Received: by 2002:a05:6000:607:b0:43c:f81f:3e6f with SMTP id ffacd0b85a97d-43d6423cfdemr517256f8f.8.1775763674566;
        Thu, 09 Apr 2026 12:41:14 -0700 (PDT)
Received: from localhost (109-81-92-28.rct.o2.cz. [109.81.92.28])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43d63e50289sm1144780f8f.28.2026.04.09.12.41.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Apr 2026 12:41:13 -0700 (PDT)
Date: Thu, 9 Apr 2026 21:41:12 +0200
From: Michal Hocko <mhocko@suse.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Kefeng Wang <wangkefeng.wang@huawei.com>,
	David Hildenbrand <david@kernel.org>,
	Christian Brauner <brauner@kernel.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	"Matthew Wilcox (Oracle)" <willy@infradead.org>,
	Jan Kara <jack@suse.cz>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Lorenzo Stoakes <ljs@kernel.org>, Mike Rapoport <rppt@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Vlastimil Babka <vbabka@kernel.org>, linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org
Subject: Re: [PATCH RFC] fs: drop_caches: introduce per-node drop_caches
 interface
Message-ID: <adgA2IKrdStZJ6AX@tiehlicka>
References: <20260409063503.3475420-1-wangkefeng.wang@huawei.com>
 <addP4MKmA8zfSN1o@tiehlicka>
 <dbb92553-58ba-42e1-b7df-b8450bd69d33@huawei.com>
 <20260409081619.34f172dad0e5a56923b7eb2d@linux-foundation.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260409081619.34f172dad0e5a56923b7eb2d@linux-foundation.org>

On Thu 09-04-26 08:16:19, Andrew Morton wrote:
> On Thu, 9 Apr 2026 16:08:37 +0800 Kefeng Wang <wangkefeng.wang@huawei.com> wrote:
> 
> > > Quite honestly drop_caches is not the best interface to build any new
> > > functionality on top of. It has backfired a lot in the past and we have
> > > tried to make it extra clear that this should be used for debugging
> > > purposes only. Extending it further sounds like a bad step.
> > 
> > 
> > I am not clear about this history of this interface, but some of our
> > products do use this interface :(
> 
> I added it more than 20 years ago (before debugfs existed) as a way of
> exercising cold-cache testing fs/pagecache code.  My stress-testing
> code was previously using umount/mount but this was inconvenient for
> some reason.
> 
> But the damn thing because so popular!  Mainly because our caching code
> has always been problematic in various ways and people found that
> drop_caches was an effective workaround :(
> 
> So it's an unhappy story.  Caching causes people problems, caching code
> doesn't get fixed, people get stuck on using a stupid debug thing which
> I guess I should have just kept local in my tree.

<rant>
Our caching strategies might not be fitting all existing usecases but as
usual we are targetting as many of them as viable. The problem with
drop_caches is that it has grown unproportianal amount of cargo cult and
grown into "solution for any performance problems" magic pill. Even when
proven to cause more problems than it solves so many times. Again and
again. That is really sad. Same as THP causes more problems than it
solves and that you should be using 2GB of swap space or that swap out
is a signal of a disaster. There are more and they are hard to die.
</rant>

-- 
Michal Hocko
SUSE Labs
