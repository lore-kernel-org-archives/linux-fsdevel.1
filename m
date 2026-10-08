Received: from out30-133.freemail.mail.aliyun.com (out30-133.freemail.mail.aliyun.com [115.124.30.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24BEB3C343F;
	Thu,  8 Oct 2026 07:59:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791446351; cv=none; b=S4N1TKMpcFpVW6vm02A6AwsBhCA0QFbFIejmdPzlm3CLdue2o7JJWps5M3FAzyRy/kxZVGH/aF09e7dACl89BvQ+yJC8sW7/R14WSDH0Fyu+82PoYfxQNeZqqIfd6/aaZqcrjAoRlsqUfugRhWKKqLBKIkdoaoG3+CqnoveCAE4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791446351; c=relaxed/simple;
	bh=qDJV4NUK9keKCwSgXigvksFKxRBTA2m8mTNRC0Bn7eg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=du31s4piuw56fVfVKTzDQ1Z5M/ZJFtttqQfDzeXYfJZgC2nOZ6JCEa83syu1ym37y7ndW6ooBpk0NXoIxPJfBILsXU8AObW7usQ1MZpAtGT3Lfd4jY8V96Kt5C/cCO0FLZICHAvaWgOJVd2Xbg57JUAC9FnNrBMy9vT7comnzOU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=fVnhGmaO; arc=none smtp.client-ip=115.124.30.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="fVnhGmaO"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1791446339; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=HcrCKp2Z/lN3tk4V8Y2aF9bTvR6+Hep4GNXCTRa+zWE=;
	b=fVnhGmaOL9Oz8hO+1ur5ogeXt+UlLmnY/0KWY0+xtijK+oglL14GoqDVZOHQoAoECZ5LB0L3OkDK3xT1CwtL+qJ0lsXYKktBIgql6ZboLYmlydhtjhii/gW5SG/p4kv3JQbM1Yr9Z69yCJ5p805bR5y7a5z2eEIIe1maqah+H9g=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R181e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033045133197;MF=baolin.wang@linux.alibaba.com;NM=1;PH=DS;RN=11;SR=0;TI=SMTPD_---0XCMHsUt_1791446336;
Received: from 30.74.113.73(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0XCMHsUt_1791446336 cluster:ay36)
          by smtp.aliyun-inc.com;
          Thu, 08 Oct 2026 15:58:57 +0800
Message-ID: <6aa5a165-3ba6-4974-b549-fed7318ead49@linux.alibaba.com>
Date: Thu, 8 Oct 2026 15:58:56 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [BUG] shmem: FALLOC_FL_PUNCH_HOLE vs fault-around race corrupts
 page cache / rss counters
To: Ayush Ranjan <ayushr@modal.com>, Pedro Falcato <pfalcato@suse.de>
Cc: Hugh Dickins <hughd@google.com>, Matthew Wilcox <willy@infradead.org>,
 Andrew Morton <akpm@linux-foundation.org>, Jan Kara <jack@suse.cz>,
 David Hildenbrand <david@kernel.org>, Gregory Price <gourry@gourry.net>,
 linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20260924061708.1645968-1-ayushr@modal.com>
 <arTdLsBENhrpOyk-@pedro-suse.tail5790ac.ts.net>
 <20260925053027.1998394-1-ayushr@modal.com>
 <20260925065013.3682431-1-ayushr@modal.com>
 <20261003033107.1488699-1-ayushr@modal.com>
From: Baolin Wang <baolin.wang@linux.alibaba.com>
In-Reply-To: <20261003033107.1488699-1-ayushr@modal.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 10/3/26 11:31 AM, Ayush Ranjan wrote:
> Hi all,
> 
> Gentle ping on this. 

Sorry for the late reply due to my vacation.

The reproducer in my previous mail [1] triggers
> "Bad page cache ... still mapped when deleted" on 6.18.46 within a
> couple of minutes on a 128-CPU bare-metal box, with no fork() and no
> gVisor involved.
> 
> We continue to hit this in production at low frequency, so I am happy
> to test patches or collect more data if that would help.

Now I can reproduce this issue on my machine with the latest mm-unstable 
branch, and I understand the race. I have confirmed that Andrew's patch 
can fix it. You can try Andrew's patch.

