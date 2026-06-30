Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51DA53C4B82;
	Tue, 30 Jun 2026 20:10:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782850213; cv=none; b=ukJMuXlE34Q2HA48TwJLmoXVazr7RiltA1ikvuPGuVzLLfHIUh+RIdQKlFqQpizr3IpfLPvjw7md00gwn7NnlsoDOwV8QfAERlyCymEVvDHFPDyEPCEmAkwiQCgmcIhyJsSyG8kfFfJuZNErYPeBBxoWoazFou2SBOyU3Y+6HJA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782850213; c=relaxed/simple;
	bh=iO8ujInNVyabX2ZWh09Ltw75KC+2jtU4rqTBKnZWFiM=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=S/TfTaQ0EzJTT2ccUCjxakeuhZTFgVZsHFQIaWgS/y6lc0AFI/1uTreQi0nFSKX5/a2JOjlRDY+IlpZ5xGHeuuTaaTeCrI2DGmrutYWsR4TjHrw1Saje2ln670PxEmURPppr4JiWiCHg0AqoAUbcCGPY02iR6/ZvQidM+TMhecI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=dZ+o9t6D; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="dZ+o9t6D"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ACB6E1F000E9;
	Tue, 30 Jun 2026 20:10:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux-foundation.org; s=korg; t=1782850211;
	bh=D52+2NrsvcEJci+uMqHVsVt4ZToE+I4dK91ZEILJB6k=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=dZ+o9t6DDJKHyIRX2WaoXi4NNe9xsX7vYCLoKB4uLp11XUj4Ldgfs/WKRMmjWeKw7
	 Up2wOcLIqvM5xiRkw6Y5gpwvEqZULBU33VRAdKq1tzn2ILyjHl/c6uiDNZ6nK0HTs5
	 NZ2EzJwXVm5RPpn7XyXYfqSVP4VAhwul5J/QdR9E=
Date: Tue, 30 Jun 2026 13:10:11 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Longxing Li <coregee2000@gmail.com>
Cc: syzkaller@googlegroups.com, willy@infradead.org,
 linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org
Subject: Re: [Kernel Bug] KASAN: slab-use-after-free Read in
 filemap_free_folio
Message-Id: <20260630131011.67546c6e472150e22c3e7c7c@linux-foundation.org>
In-Reply-To: <CAHPqNmzacLWxDM4CSyEorgyh1tEyBfeOVr2gwUvUrtjZRCuh7A@mail.gmail.com>
References: <CAHPqNmyHRaGj0fn+2FvvaJYi4WYOVmai6XX3bRCwbAZoj_GwWg@mail.gmail.com>
	<CAHPqNmzacLWxDM4CSyEorgyh1tEyBfeOVr2gwUvUrtjZRCuh7A@mail.gmail.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Tue, 30 Jun 2026 23:24:58 +0800 Longxing Li <coregee2000@gmail.com> wrote:

> Dear maintainers,
> 
> I'm trying to fix this issue.

Great, thanks.

> The bug analysis and patch fix are as follows.
> ========================================================
> Bug Summary
> 
> ext4_add_complete_io() queues i_rsv_conversion_work without holding an
> extra inode reference. If the inode is unlinked & evicted before the
> delayed work runs, ext4_do_flush_completed_IO() accesses a freed inode —
> use-after-free.

You omitted the ext4 developers!

	scripts/get_maintainer.pl -f --no-rolestats fs/ext4

is a good way to find them.

Also, your email client is converting tabs to spaces.


So please fix those things up and resend?
