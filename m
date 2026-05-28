Received: from r3-17.sinamail.sina.com.cn (r3-17.sinamail.sina.com.cn [202.108.3.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 609FC369208
	for <linux-fsdevel@vger.kernel.org>; Thu, 28 May 2026 23:01:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.108.3.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780009312; cv=none; b=CWNZD7v6idFiyvSWV0fySY2VcIVvY8/W6/7GZAHMTS1a6rX4R8gTPztynKNUxf4X/x4GN9KTrFCDObhYWbYzw7n1MgfyQSbNnNfZGhiQHKK23DXhCNTNlZUpzJXm3ePwxGcZNM+dzTQ5Hl2xH8l+CTNJbGGhq1E6c1hL5tnZsn8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780009312; c=relaxed/simple;
	bh=1T8/I6TvjiS18ZZDLJG7k3gfStyk9dmBa1e4cJe4Qtk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=P8D1UdWb26K/ewHQW0MGwAgy3a7eIEWeB8mLmlo6leQ9BmVYkxg0vJQPjB5g6Nq/9cl7AOgBtczEqDqexdsqVxAVYNZiq//Hv6zzo0ZCaikZ3HmuI+X4pGmi4UZzqOewP4pJGkxNvI6kVgBwbhp/fbIL3uR4YUi49zqd7SDEh3o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sina.com; spf=pass smtp.mailfrom=sina.com; dkim=pass (1024-bit key) header.d=sina.com header.i=@sina.com header.b=qC0RKqio; arc=none smtp.client-ip=202.108.3.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sina.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=sina.com header.i=@sina.com header.b="qC0RKqio"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sina.com; s=201208; t=1780009309;
	bh=ew4LKtHTQRw4JU9dPbT+Bkxy6WAebg2DDIpNh0S9wiE=;
	h=From:Subject:Date:Message-ID;
	b=qC0RKqioj5PQGHs1mZq2hT8cjFh6t7ZuxTB7Ef8CtBvBV/y+5gALlZ+vbEBo011iG
	 LjRJ1MnEQ1EbjPAizGzx1V9RLb39yGPcn2ZL4pNTY9RUEIvYZICSoPZ/SZnZQdhvn/
	 FTGi7z3DGSRGefoDh1wynIDbbbgbJaBP9O1ZJICU=
X-SMAIL-HELO: localhost.localdomain
Received: from unknown (HELO localhost.localdomain)([114.249.62.144])
	by sina.com (10.54.253.34) with ESMTP
	id 6A18C92B0000506E; Thu, 29 May 2026 07:01:01 +0800 (CST)
X-Sender: hdanton@sina.com
X-Auth-ID: hdanton@sina.com
Authentication-Results: sina.com;
	 spf=none smtp.mailfrom=hdanton@sina.com;
	 dkim=none header.i=none;
	 dmarc=none action=none header.from=hdanton@sina.com
X-SMAIL-MID: 5580266291955
X-SMAIL-UIID: 978DE95D27164842A9C09416F2C93710-20260529-070101-1
From: Hillf Danton <hdanton@sina.com>
To: Ming Lei <tom.leiming@gmail.com>
Cc: Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
	Jens Axboe <axboe@kernel.dk>,
	Bart Van Assche <bvanassche@acm.org>,
	Christoph Hellwig <hch@lst.de>,
	Damien Le Moal <dlemoal@kernel.org>,
	linux-block <linux-block@vger.kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	linux-btrfs@vger.kernel.org,
	David Sterba <dsterba@suse.com>,
	linux-fsdevel@vger.kernel.org,
	Christian Brauner <brauner@kernel.org>
Subject: Re: [PATCH v3] loop: Fix NULL pointer dereference in lo_rw_aio()
Date: Fri, 29 May 2026 07:00:47 +0800
Message-ID: <20260528230050.1185-1-hdanton@sina.com>
In-Reply-To: <20260528054334.1159-1-hdanton@sina.com>
References: 
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Thu, 28 May 2026 13:43:31 +0800 Hillf Danton wrote:
>On Tue, 26 May 2026 22:00:49 -0500 Ming Lei wrote:
>>On Wed, May 27, 2026 at 10:35:56AM +0900, Tetsuo Handa wrote:
>>> On 2026/05/27 10:20, Ming Lei wrote:
>>> >> Of course we should try to figure out the root cause first, but how can we do?
>>> > 
>>> > Definitely unexpected write IO(after umount & loop closed) from btrfs is more serious,
>>> > which may cause data loss, so CC btrfs list and maintainer.
>>> 
>>> Why do you assume that the culprit is btrfs?
>>> 
>>> https://syzkaller.appspot.com/bug?extid=bc273027d5643e48e5b3 indicated that
>>> this similar race is also happening with jfs.
>>
>> I just didn't see the above report on jfs.
>> 
>> It doesn't change anything, the same question still stands: unexpected write IO is issued
>> or crosses umount & last closing of loop disk.
>>
> Given the loop workqueue that triggered the jfs warning, can you specify
> the reason why the workqueue in question is NOT flushed while closing disk?
>
Got it, the loop workqueue is NOT flushed to avoid deadlock, see d292dc80686a
("loop: don't destroy lo->workqueue in __loop_clr_fd") for detail.
And the deadlock can be reproduced by flushing the loop workqueue with
disk->open_mutex held [1].

[1] Subject: Re: [syzbot] possible deadlock in blkdev_put (3)
https://lore.kernel.org/lkml/000000000000ea753505da2658d5@google.com/
