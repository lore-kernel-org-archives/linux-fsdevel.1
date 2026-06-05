Received: from va-1-115.ptr.blmpb.com (va-1-115.ptr.blmpb.com [209.127.230.115])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 278314B8DEB
	for <linux-fsdevel@vger.kernel.org>; Fri,  5 Jun 2026 09:03:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.127.230.115
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780650195; cv=none; b=needy4C1Y+OSSSijw882WXhy8LvAuqXnHqC/06/QEyzbp+lM4y9llsy79A7muBZCk5DkjQgKSxdajGH2Bp/wcqUI1Pctf3IoZ6LUueZwNX6sW/ETEFPTmYRhJEWjgOqFEwZT6SthmZ+gSRZcUDMNbAurs0SC8FzgiAU42ANA46k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780650195; c=relaxed/simple;
	bh=SEu5L5p9R3LotcsfpdA9MeWrpa37/7OAXVtlDZH9nZ4=;
	h=To:From:Cc:Date:Content-Type:In-Reply-To:References:Subject:
	 Message-Id:Mime-Version; b=D3QQQAZGLiQ2qQjPJGYEFq3a4L7hzBQdcfqO3os63Y/P9OM+kCEQfluraagQE2FLB3VXgCR/FmeW9kTQFtuB2NUqcsNZjLLvMTGR6yXFZtCV0QpYHtP4u4WN+/a631L2/3iCVqbyyrGZLscW89CYhS8eQhDP6mtvh7ZZO2uqb0c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=GhfL0htl; arc=none smtp.client-ip=209.127.230.115
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="GhfL0htl"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=2212171451; d=bytedance.com; t=1780650180; h=from:subject:
 mime-version:from:date:message-id:subject:to:cc:reply-to:content-type:
 mime-version:in-reply-to:message-id;
 bh=6SyzDHDMYTgBfhMChkkRfH45Szq2eRp8NbfZhcJZHl8=;
 b=GhfL0htlT8NBg9XvJLz4qy79RtNKdH+OjJyvndCr7KnJSbxSFywwREUUHuqwv+0uiY0Zxr
 LfJCEk9m16vhsF6HQbaKQ4d1e8sAzSaqJn5GPyYp7y60wC8H9Ar9ox7sT9N4r1hIaLMN55
 Csp7ll/GjZk/A0BhVIbP24ggv6q8CTYzdq2OiNLcVusJL72VDwkdzvxt458vZ7krC7LPza
 U6wJ1iA1jjuI1n2C90/uiN4Wkqr14Lq2RUlQEzPe0bVOmWeNun29KjuinVQVloJI6g7HS2
 hGIEHboZkxaOHIB855h3uO6gNw7K7VDuvFl+yI99vLhLl1qYGZMunzD5KxeQrw==
To: "Matthew Wilcox" <willy@infradead.org>
From: "Jia Zhu" <zhujia.zj@bytedance.com>
Content-Transfer-Encoding: 7bit
X-Lms-Return-Path: <lba+26a2290c2+0fbedb+vger.kernel.org+zhujia.zj@bytedance.com>
X-Original-From: Jia Zhu <zhujia.zj@bytedance.com>
Cc: "Jia Zhu" <zhujia.zj@bytedance.com>, "Theodore Ts'o" <tytso@mit.edu>, 
	"Andreas Dilger" <adilger.kernel@dilger.ca>, 
	"Alexander Viro" <viro@zeniv.linux.org.uk>, 
	"Christian Brauner" <brauner@kernel.org>, "Jan Kara" <jack@suse.cz>, 
	"Baokun Li" <libaokun@linux.alibaba.com>, 
	"Ojaswin Mujoo" <ojaswin@linux.ibm.com>, 
	"Ritesh Harjani" <ritesh.list@gmail.com>, 
	"Zhang Yi" <yi.zhang@huawei.com>, <linux-ext4@vger.kernel.org>, 
	<linux-fsdevel@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Date: Fri,  5 Jun 2026 17:02:53 +0800
Content-Type: text/plain; charset=UTF-8
In-Reply-To: <aiBuZE5NWMfOGAA6@casper.infradead.org>
References: <20260603134800.25155-1-zhujia.zj@bytedance.com> <aiBuZE5NWMfOGAA6@casper.infradead.org>
Subject: Re: [PATCH] ext4: avoid full buffer walks for large folio partial writes
Message-Id: <20260605090253.32822-1-zhujia.zj@bytedance.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0

On Wed, Jun 03, 2026 at 07:11:48PM +0100, Matthew Wilcox wrote:
> Is this a common case for you, or is this something you noticed by
> inspection?

This was found by our kernel release benchmark.  We run libMicro as part
of that test suite:

  https://github.com/rzezeski/libMicro

The regression shows up in buffered write/pwrite/writev overwrite tests
on ext4 large folios.

> Wouldn't you get just as much benefit from this?

Yes.  I tested this approach, and it gives almost the same result as my
original partial-commit helper.

I agree this is a better direction for block_commit_write().  It keeps the
existing buffer-head state handling and only stops the tail walk after an
already-uptodate folio has been committed through @to.  That removes the
main large-folio cost in our small-overwrite benchmark while keeping the
change much closer to the old code.

> I'm unconvinced that this is safe ...

Agreed.  The original ext4_block_write_begin() change was too aggressive.
Seeking directly to @from also skips the prefix buffers, which makes the
old side effects harder to prove.

For v2 I plan to drop that part and keep the existing walk from the head.
The ext4 change would only stop after @to when the folio was already
uptodate on entry, similar to your block_commit_write() suggestion:

+       bool folio_uptodate = folio_test_uptodate(folio);
+
        for (bh = head, block_start = 0;
-            bh != head || !block_start;
+            (bh != head || !block_start) &&
+            (!folio_uptodate || block_start < to);
             block++, block_start = block_end, bh = bh->b_this_page) {
                ...
        }

So the prefix path and all in-range handling stay unchanged.  The only
skipped work is the tail part after @to, and only for a folio that was
already uptodate before write_begin() started.

> ... converting ext4 to use iomap instead of buffer heads.

I strongly agree that iomap is the right direction for ext4.  The iomap
buffered write path would make this particular buffer-head walk cost go
away.

The reason I am still looking at this path is that the regression is
visible in our LTS upgrade testing from 6.12 to 6.18.  It was introduced
by the ext4 large-folio enablement in v6.16.  For example, in our
libMicro release benchmark with THP always enabled, usecs/call, lower is
better:

case        v6.12        v6.18        regression
write_u1k   0.609        4.659        +665.0%
write_u10k  1.408        4.869        +245.8%

The iomap conversion is the long-term fix, but it does not help kernels
which still use the buffer-head buffered write path.  I would like to keep
this as a small regression fix for that path, and make it minimal enough
to be suitable for stable/LTS backport.

Would this v2 direction look OK to you?
