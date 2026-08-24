Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABC6A377AB6;
	Mon, 24 Aug 2026 16:50:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787590215; cv=none; b=RjL4GWDPgdkPb0fElazgDfTKjmeangbVJMCF+cuFjhwLbN3VKhfkaq+4L6SYou/gPXhHs7eQe/DYc6xwxW+kbYllKnT8k69HD6dKcEfQeXhTZyi+sGBIT7NLl+MgyIEHHo+4ZcHcmuMB1OuGRVDl+quSuIDqcPoIGSCwK1isO7Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787590215; c=relaxed/simple;
	bh=gB/W2AwGuYnUdV02C1WHn9rEEuav21wWQRm6ZS59zg0=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=meiSNylAX8cD7fQlXlInO17cgicCaM5NLQCt5KbybzxrSHMXpS1kZOhvcjwYlWPJ53kv46WPWBLyJ8dO5jbsIZeTREMvQWwbvl9s1fSl1Jk8LNXyYYhE+y2rKwLkk2lpK0WauoipfV9R8NPjScEGnJxmsEE5bLypSa9lZP89XR0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=aXZxO0zQ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="aXZxO0zQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3D4361F00AC4;
	Mon, 24 Aug 2026 16:50:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux-foundation.org; s=korg; t=1787590214;
	bh=yseZkVGQ9rf3oPmFC/SPm8JowGtTQz1Ns5eX4eC76ao=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=aXZxO0zQHCWLNlFAvOfDzXgrfiYSOMTwTaVBAmBJz2pPKfIUHkwJBnwJ/W5YOtEJI
	 L1S/6tDtBfjm72GxWhC9CIPNH/8hhm1zu8DkrOYYx+n30nMfKV2kLOAh5J0nEjpMC5
	 4gHJ4VNCu7l1Bir7CGUMewDci3OfhTtjF179tg34=
Date: Mon, 24 Aug 2026 09:50:13 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
Cc: linkinjeon@kernel.org, linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org, sj1557.seo@samsung.com,
 syzkaller-bugs@googlegroups.com
Subject: Re: Please drop 64d9183203eeb in mm-nonmm-unstable ([syzbot]
 [exfat?] WARNING in fat_ent_write)
Message-Id: <20260824095013.ec38b9d5d5ec33922aad47e2@linux-foundation.org>
In-Reply-To: <875x0z6f0u.fsf@mail.parknet.co.jp>
References: <6a8bf715.dbb3a75c.13dd47.0065.GAE@google.com>
	<875x0z6f0u.fsf@mail.parknet.co.jp>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 24 Aug 2026 18:31:29 +0900 OGAWA Hirofumi <hirofumi@mail.parknet.co.jp> wrote:

> https://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm.git/commit/fs/fat/misc.c?h=mm-nonmm-unstable&id=64d9183203eebe33de6188b70a8c1e91f52885db (fat: restore original value when fat_ent_write failed)
> 
> This commit was missing to consider about the path of error by sync
> write.  Since current bh write clears uptodate flag if got I/O error, so
> this patch doesn't work for now with wait==true.
> 
> Please drop this patch at least until stop clearing the uptodate by bh
> sync write and buffer is reusable after the error.

This is now in Linus's tree, as 64d9183203ee.  Please send along a fix,
with 

Fixes: 64d9183203ee ("fat: restore original value when fat_ent_write failed")
