Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7577A2D9787;
	Sun, 31 May 2026 19:24:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780255500; cv=none; b=Uz6Nlvfr0Hq2dTxe5Y9dP7o5SXzKe7btwefrGGp/XbA6jtYJaiwnH5B42Jq6yqtm/i+dMzT0kTdH40edfKrSFT8jLHSyNqHSObesnjkSsAorp3keYE8xBLhd8dof1pOhNa71IkMT2FpOlLJ7HH+/daRS0wdFa6TX0tEKVT2ylAE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780255500; c=relaxed/simple;
	bh=4thto6ApMgQzLePk8QhDxaNshU7SAUo/AZxlyelN8qE=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=MWUCCyTxniBE5j/pOoEOh2bgMcPPF2f70fGpUY6ik89rTHytVCdxmuK8Zfz9N0MposuqH9x5g7NxsaocHu7eeTJQ/W0ehFtpiQwIXPL0M1y/udtWtmRCXTTkehiShb3/wxFz6tH4h6n1kqrLTYk1nvyPWlXGEBbMpL4qKse10Xc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=BqUnGLzc; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="BqUnGLzc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9434C1F00893;
	Sun, 31 May 2026 19:24:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux-foundation.org; s=korg; t=1780255499;
	bh=Uko1Vuv+TRAWbjerQEGKNfOSzZb/odVklCx5MByR3WQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=BqUnGLzcGY9YmhTi41lBU6NbdBR4BH3icQiVpu7Cu4k8LsPyfwWTbimSnSi491BMM
	 7gJbMySUzveXwFRISDc9OGmLtP2Pe98w/fnTvdELdKirOql5+FBFKEe1bgIk8/hkgk
	 t3xzRG/x170r1rjn3A4sInX2dhb71mwlk+YEOK18=
Date: Sun, 31 May 2026 12:24:58 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Dev Jain <dev.jain@arm.com>
Cc: liam@infradead.org, ljs@kernel.org, jgg@ziepe.ca, leon@kernel.org,
 david@kernel.org, shuah@kernel.org, vbabka@kernel.org, jannh@google.com,
 pfalcato@suse.de, balbirs@nvidia.com, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 rppt@kernel.org, surenb@google.com, mhocko@suse.com,
 linux-kselftest@vger.kernel.org, usama.arif@linux.dev,
 ryan.roberts@arm.com, anshuman.khandual@arm.com
Subject: Re: [PATCH v2 0/2] mm/hmm: A fix and a selftest
Message-Id: <20260531122458.864e9deac7425e1b71c14f3a@linux-foundation.org>
In-Reply-To: <20260530085413.1270139-1-dev.jain@arm.com>
References: <20260530085413.1270139-1-dev.jain@arm.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 30 May 2026 08:54:10 +0000 Dev Jain <dev.jain@arm.com> wrote:

> Patch 1 fixes a stale warning present from the time when only migration
> softleaf entries were supported at the PMD level.
> 
> Patch 2 adds some code into hmm-tests.c which exercises the pagemap path
> for PMD device-private entries.

David, I'll retain your ack on patch 1.

Sashiko has a concern about the selftest:
	https://sashiko.dev/#/patchset/20260530085413.1270139-1-dev.jain@arm.com
