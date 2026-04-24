Received: from va-2-26.ptr.blmpb.com (va-2-26.ptr.blmpb.com [209.127.231.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D2DC3E8C79
	for <linux-fsdevel@vger.kernel.org>; Fri, 24 Apr 2026 18:05:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.127.231.26
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777053948; cv=none; b=FUdBw+AX6GyqwhhXsEIT1uW7Lbk68S85hDaO4ymHwOzAAPxcRBdXANnG8EIfWXX16viJashy+FP7MHfN6GBB0qb5onLyLTyTtlTiFfkx7lO5tWh5qymDg/0fAXtFX6jMa2E2KRU5c+qfjgzT3VxyJNuNUB3kLD8hOhoHIk7yBEk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777053948; c=relaxed/simple;
	bh=HPysnfB0ZZ4K08cFmhgwZh+hL+nIlGlCEX569aLOEPQ=;
	h=Subject:Content-Disposition:To:Mime-Version:References:
	 In-Reply-To:Cc:From:Date:Message-Id:Content-Type; b=Z6p81KXzDHH7Nhlz2eVDVu/Om2a1RgqSfBlOs5UzapHhKUihFde5AvavwUR+4TRy0+MO4rZQKRpQWmUJF+ytmgb/jv/kqYqwDbZhoWxU6++szjVu48onli+foMEBSlLNcry5BCU7ixunk7GB6pj9MyzK9Rcd9q0HKL1XCyrIF70=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cherr.cc; spf=pass smtp.mailfrom=cherr.cc; dkim=pass (2048-bit key) header.d=cherr.cc header.i=@cherr.cc header.b=tiwEkl/b; arc=none smtp.client-ip=209.127.231.26
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cherr.cc
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cherr.cc
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cherr.cc header.i=@cherr.cc header.b="tiwEkl/b"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=feishu2604220257; d=cherr.cc; t=1777053826; h=from:subject:
 mime-version:from:date:message-id:subject:to:cc:reply-to:content-type:
 mime-version:in-reply-to:message-id;
 bh=Ugwgs62IxNPablVdIXqbGoOJmPgtkIqzqLOaAOEODLE=;
 b=tiwEkl/bcSrn/obKTjWup16HDnkVAP2X5fGB7WemupXiixyR+bC/PzY7vpGDfmWv6o2HIf
 xgfltf+Eh5B6mAG/aXA/871RTKbafSyWgmi+piuFwAgXhXino6RgHHtabCcNt7Pc9ikxRd
 USJAEX4/p18SYthYQeqxo3RI9AKfgFVgG/PcJj9Fz30IC29OZnqLwi5WTBBF1v0U8y3zSS
 2uBdKfOsOLGQMTPH3z/4vovA57yOVCfy/xrBa3cA+1PcKZF0Y1qtvc0uKOE9d+nv90WKvg
 gr2a1Lrm3bbnVIEUDm2NgIC02ss8vdI06KFJv/Tl/BdszZCLquUWiQ6Ozlun8Q==
Subject: Re: [PATCH] proc: fix comm_write return value when truncated or error
Received: from pve.cherr ([111.40.58.183]) by smtp.feishu.cn with ESMTPS; Sat, 25 Apr 2026 02:03:43 +0800
Content-Disposition: inline
To: "Alexey Dobriyan" <adobriyan@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260424-fix_proc_write_return-v1-1-7a793c2aad32@cherr.cc> <20260424035028.a811dd6bc8248b640a9fd7c2@linux-foundation.org> <3f91ed95-b38e-4049-b69c-13335b13ae44@p183>
In-Reply-To: <3f91ed95-b38e-4049-b69c-13335b13ae44@p183>
Cc: "Andrew Morton" <akpm@linux-foundation.org>, 
	"Shengzhuo Wei" <me@cherr.cc>, "John Stultz" <johnstul@us.ibm.com>, 
	"Yao Zi" <me@ziyao.cc>, <linux-kernel@vger.kernel.org>, 
	<linux-fsdevel@vger.kernel.org>
From: "Shengzhuo Wei" <me@cherr.cc>
Date: Sat, 25 Apr 2026 02:03:41 +0800
Message-Id: <aeuwfe6xy74R2qm4@pve.cherr>
Content-Type: text/plain; charset=UTF-8
X-Original-From: Shengzhuo Wei <me@cherr.cc>
X-Lms-Return-Path: <lba+269ebb080+ebb451+vger.kernel.org+me@cherr.cc>
Content-Transfer-Encoding: 7bit

On 2026-04-24 16:28, Alexey Dobriyan wrote:
> > > Fixes: 4614a696bd1c ("procfs: allow threads to rename siblings via /proc/pid/tasks/tid/comm")
> > 
> > December 2009.
> > 
> > Hopefully no userspace is depending on the broken return value of a
> > write to /proc/pid/comm.
> > 
> > Arguably we should leave the code as-is and add an apologetic comment
> > explaining the situation.
> 

First, there's a plain bug regardless: assigning -EINVAL to a size_t count and
returning it as ssize_t produces a bogus positive value on the error path.
Introducing a dedicated ssize_t ret fixes this without changing any
success-path behavior, the change is on a permission failure path, so it's hard 
to imagine anyone depending on the broken behavior, but worth mentioning

> Yes, this issue must all over virtual filesystems.
> 
> Patch may break stuff in the other direction too:
> 
> if process is doing "full write" loop, and write hook gets string
> which is too long, then the last piece will be written, not truncated
> first part.

For the truncation case, I agree returning a short count breaks the
full-write idiom. But sliently truncating isnt't great either. Maybe we
should reject overlong writes and return -EINVAL instead? That's also an
ABI change and breaks the userspace, so it needs discussion, but at
least it fails loudly.

> 
> 	/proc/alexey

Very happy to hear from your opinions and sorry for my poor English.
Best regards.
