Received: from embla.dev.snart.me (embla.dev.snart.me [54.252.183.203])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4600A346AD3;
	Sun,  3 May 2026 07:41:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.252.183.203
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777794075; cv=none; b=R7GcadoNxHULtyhBtN0FE8rLZ/68O3V49lTADZSa7QWtaY7VSXwhxyQZnvyYy6r8wBW5XmsVYwCXpeBOsDezNCcfsoqVGM9bVqqwEYIVcsuKA1hluCFmsWYd/hRVtTloMmPioF1AC14EDs+LqkebU5F1QekY7IUXoCgJDqe4rdc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777794075; c=relaxed/simple;
	bh=mg/KNrw0hRlSPXFSPAgmZQ3PsY/sIUTZ7V4wy8JJXvI=;
	h=Message-ID:Date:MIME-Version:Subject:References:From:To:
	 In-Reply-To:Content-Type; b=IxLfxIwURV7UzranNglgQ9kZ1IwXYRHUA6XcmNKi74eOmEXQZrYxdgZtuzoPnpyYgrkabt//Wb95cGYjPqrvG6i1+A+EvOKiORMja7C1b0KuSoGtqCITJF89bHc65YM4jy4wA6+S3Nis0a+8aeLJ6TdMvOmNHf9Wl3eLRs419bA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=dev.snart.me; spf=pass smtp.mailfrom=dev.snart.me; arc=none smtp.client-ip=54.252.183.203
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=dev.snart.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dev.snart.me
Received: from embla.dev.snart.me (localhost [IPv6:::1])
	by embla.dev.snart.me (Postfix) with ESMTP id 26A761D490;
	Sun,  3 May 2026 07:41:09 +0000 (UTC)
Received: from [192.168.1.18] ([182.226.25.243])
	by embla.dev.snart.me with ESMTPSA
	id rQP5MRX89mnzmQAA8KYfjw
	(envelope-from <dxdt@dev.snart.me>); Sun, 03 May 2026 07:41:09 +0000
Message-ID: <b6c3cbf5-d8da-4157-9b75-918633bbef1d@dev.snart.me>
Date: Sun, 3 May 2026 16:41:08 +0900
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [syzbot] [mm?] [exfat?] [f2fs?] memory leak in __kfree_rcu_sheaf
References: <69f6f8c5.050a0220.1584b9.0044.GAE@google.com>
From: David Timber <dxdt@dev.snart.me>
Content-Language: en-US, ko
Autocrypt: addr=dxdt@dev.snart.me; keydata=
 xjMEYmJg1hYJKwYBBAHaRw8BAQdAf5E+ri1XLtjqYbZdHOyc8oS+1/XJ5bSlbx5WHXmVBZzN
 IERhdmlkIFRpbWJlciA8ZHhkdEBkZXYuc25hcnQubWU+wpQEExYKADwWIQQn/Jn96EMUaIoF
 X+T/ldyyrZpWaAUCYmJg1gIbAwULCQgHAgMiAgEGFQoJCAsCBBYCAwECHgcCF4AACgkQ/5Xc
 sq2aVmjJZwD8COjPlUwccrlRvbNQ6f87DWchtYO0o8W2DNRM3RLps0EA/jEhIbRV6AsyC8jr
 30Ut3aJ3/mO/6G4sLj7OvkEEBH0MzjgEYmJg1hIKKwYBBAGXVQEFAQEHQFpgtIgaByv9lIEY
 EmpavMO0pYjtu7TMJynwdnGYkN9LAwEIB8J4BBgWCgAgFiEEJ/yZ/ehDFGiKBV/k/5Xcsq2a
 VmgFAmJiYNYCGwwACgkQ/5Xcsq2aVmhFCwEA0kM9VyYB4bLCM7+SuXUUH+5Ec99Nj4RXxFad
 Key9GuwA/2BZK6bNyrLSfEk2JDRoskqf7OIL0wa6JOD5SrBnMe8E
To: syzbot <syzbot+cae7809e9dc1459e4e63@syzkaller.appspotmail.com>,
 Liam.Howlett@oracle.com, akpm@linux-foundation.org, chao@kernel.org,
 jaegeuk@kernel.org, jannh@google.com, linkinjeon@kernel.org,
 linux-f2fs-devel@lists.sourceforge.net, linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 lorenzo.stoakes@oracle.com, pfalcato@suse.de, sj1557.seo@samsung.com,
 syzkaller-bugs@googlegroups.com, vbabka@suse.cz
In-Reply-To: <69f6f8c5.050a0220.1584b9.0044.GAE@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 5/3/26 16:27, syzbot wrote:
> Hello,
>
> syzbot has tested the proposed patch and the reproducer did not trigger any issue:
>
> Reported-by: syzbot+cae7809e9dc1459e4e63@syzkaller.appspotmail.com
> Tested-by: syzbot+cae7809e9dc1459e4e63@syzkaller.appspotmail.com
>
> Tested on:
>
> commit:         66edb901 Merge tag 'v7.1-p3' of git://git.kernel.org/p..
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=11fb7082580000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=9645c21cfd1d3e8f
> dashboard link: https://syzkaller.appspot.com/bug?extid=cae7809e9dc1459e4e63
> compiler:       gcc (Debian 14.2.0-19) 14.2.0, GNU ld (GNU Binutils for Debian) 2.44
> patch:          https://syzkaller.appspot.com/x/patch.diff?x=17f2f326580000
>
> Note: testing is done by a robot and is best-effort only.

The error message might be misleading.

 1. the report is done after f2fs attempted to mount the corrupt image,
    not before
 2. f2fs exhibits undefined behaviour, evident from the fs attempting to
    do I/O out of blockdev bounds

This might have been cause by f2fs corrupting memory in which case the
leak report is invalid.

Davo

