Received: from confino.investici.org (confino.investici.org [93.190.126.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC4FE3AAF76;
	Mon, 17 Aug 2026 14:05:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.190.126.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786975534; cv=none; b=Oz4aYdaT0tmInplsrCREECGPayQ18H6RZwjT+9g3MllOBEVfyb1LZuVdMzl9ov1C+vd+Kf5UjwJscg2brhGi1YQtVBjlq4/lWfiZdVOPNIDoEtzgg6+lftwPaROwST4zDkwk5aIy5lznA5jK82EA+dzDQfwgc/Eyt3xrWNwt9y4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786975534; c=relaxed/simple;
	bh=1QMimSzjdEJwLfxs2maF6Q8yFtkrBMaFVrfhfu8b9J0=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=aTooRDfYFR+8YIAnK0S41lZ4j5zUq15wb7ezh5l8qMCiqCLOkfv7H7St1Thj2qCsFSNHl7zvCx2kefnE7zFGn2COjhtsYUcdH/RQoBE0A3yum7GKPXPkA81TtTtCvfB6sLuCZUBMyslxAQVEtcPaNCrXaN2sVuaDdITZJqbc7mc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=grrlz.net; spf=pass smtp.mailfrom=grrlz.net; dkim=pass (1024-bit key) header.d=grrlz.net header.i=@grrlz.net header.b=IdANnYMD; arc=none smtp.client-ip=93.190.126.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=grrlz.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=grrlz.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=grrlz.net header.i=@grrlz.net header.b="IdANnYMD"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=grrlz.net;
	s=stigmate; t=1786975529;
	bh=4B633A1BFXz3QnMJ7GjsJGouuVbnGVqxnSyFxj5JBO8=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:From;
	b=IdANnYMDDRiqe1QM3GlYoxohkeifa5s4OgBoSk0LX9rMHe4CddtYkabsEgX6v+XXd
	 W0khG6MclelfnW3ZRi2PVIUChrjs2Cg5JGo+wrAvUqz3AilHKLHxrXdSYxG8bP3w6K
	 vlEH5fImQxYDz314+gJvRyOiMZCyZ0kVkNYY/C1c=
Received: from mx1.investici.org (unknown [127.0.0.1])
	by confino.investici.org (Postfix) with ESMTP id 4hNvk14gKDz10px;
	Mon, 17 Aug 2026 14:05:29 +0000 (UTC)
Received: by mx1.investici.org (Postfix) id 4hNvk00QXJz10q6;
	Mon, 17 Aug 2026 14:05:28 +0000 (UTC)
Date: Mon, 17 Aug 2026 15:05:29 +0100
From: Bradley Morgan <include@grrlz.net>
To: Joel Granados <joel.granados@kernel.org>
CC: akpm@linux-foundation.org, hannes@cmpxchg.org, jackmanb@google.com,
 kees@kernel.org, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org, linux-mm@kvack.org, mhocko@suse.com,
 shijianlin11@foxmail.com, shuah@kernel.org, surenb@google.com,
 vbabka@kernel.org, ziy@nvidia.com
Subject: Re: [PATCH v2 4/4] sysctl: Add 0013 to test partially updated vectors
In-Reply-To: <iahrpgl333k2cniihxiv4qbkgtalxmhn47gyzrq2xd7jshxbtd@cniqn2gdnqfw>
References: <20260814-lklm-partial_ctlvec-v2-4-9df50d26e477@kernel.org> <1EF80864-F479-44F2-8CD7-28383515F483@grrlz.net> <iahrpgl333k2cniihxiv4qbkgtalxmhn47gyzrq2xd7jshxbtd@cniqn2gdnqfw>
Message-ID: <9CD9A226-E6E3-4552-B12D-1AB984B8B21F@grrlz.net>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 8bit

On 17 August 2026 14:54:12 BST, Joel Granados <joel.granados@kernel.org>
wrote:
>On Sat, Aug 15, 2026 at 05:05:59PM +0100, Bradley Morgan wrote:
>> The test covers the parse error, the out of range value and the
>> first value failing. That's the right coverage.
>> 
>> The shellcheck disable should say why. The test functions are only
>> called through the dispatch string, so shellcheck thinks they are
>> unreachable.
>I expect to remove this in the new sysctl selftests.
>
>> 
>> run_int_array_no_partial_update() uses spaces for its comment lines
>> while the code uses tabs.
>good catch 
>
>> 
>> reset_vals() has no case for int_0003, so sysctl_test_0013 calls it
>> for nothing. Drop the call or add a case for int_0003.
>The TARGET is reset to "". right?
>

From what I recall! note I review loads of kernel/ files, I'll rant a
little below, some of it is related. Heh.

>I'm reluctant to do more work on the sysctl.sh file as everything will
>probably be replaced.
>
>Thx
>
>Best
>> 
>> Nits aside, the test does what it should:
>> 
>> Reviewed-by: Bradley Morgan <include@grrlz.net>
>> Thanks!
>


RANT:

I've been thinking, I hate clicking on the stupid mailto links on lore
just to review a patch, I need to be CCed in most kernel/ patches anyway. 
I already am, but im mostly a "pity" CC, because I spent time reviewing 
patch, and like, I ask people all the time to CC me on most kernel/
patches they do, but that's negligible..

I have knowledge On sysctl, id love to wonder why I don't even
get_maintainers catch yet. (And if I do, I don't even get CCed! Omg..!

I really hope one day I get either reviewer or get_maintainers CCed so I
don't have to go through this headache each and every time I bloody review!


Sorry for that rant, I tend to think out loud. (Or overthink)



Thanks!
