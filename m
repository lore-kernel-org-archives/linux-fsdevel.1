Received: from smtp153-141.sina.com.cn (smtp153-141.sina.com.cn [61.135.153.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28B8631E850
	for <linux-fsdevel@vger.kernel.org>; Thu, 28 May 2026 05:43:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=61.135.153.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779947043; cv=none; b=oYZx4fI6lrc61cbTnPxWvkMSxTWsR7GuK7C5U4P5pSjnSJZURqz5I7yCYdW+LMCEdimgc3krc2NLXR41yu5w3Gf/ouPOmVHTlegxpj0L1o1PTFkxtO/6DBa4JRzR2Qfc0bNMJKps8XpfNdHKKCxd0KgQYFDbxnk5lWmiNOyq1Ws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779947043; c=relaxed/simple;
	bh=C7JHlHzPIIDbcrjvTTaZykxa0kwfZ19sATnFMjQgAWY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kN/rCjxzaFitJ3i0NST+PrUYDT2juWWNztbpgw4+9NisOEyilqWWMHoUMbL0keN9gQ7u+du58c5+5whBAAtejcEdxhSu8s4CnAee7BXOHsxyDyQ6F7A5Rh2uP0+BRdF+mC1Ti5nkDqZqcY/H17HGEBFxylozjGh4vSO7dnjlmI4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sina.com; spf=pass smtp.mailfrom=sina.com; dkim=pass (1024-bit key) header.d=sina.com header.i=@sina.com header.b=K0hn5QGI; arc=none smtp.client-ip=61.135.153.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sina.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=sina.com header.i=@sina.com header.b="K0hn5QGI"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sina.com; s=201208; t=1779947037;
	bh=cx/MeDnSm8Ccc4831CYFK65RBNwl+E+0XHr2pEV7eW0=;
	h=From:Subject:Date:Message-ID;
	b=K0hn5QGIUn3CuFSbXrPLBUFWATQ2RVzkY77eXJKCOZIJPLCs6ZoVLRyGEej0NrpeW
	 o3SF0zzBGbTuEKmu+t9z3yX7mSFM2V+LYqABYrYMPIEn7vKm1ITu/JknRReGht2A0M
	 QK6O4YHEaJfcwLRqnTPuYO1yoHoSKVc9cCUz4PYs=
X-SMAIL-HELO: localhost.localdomain
Received: from unknown (HELO localhost.localdomain)([114.249.62.144])
	by sina.com (10.54.253.31) with ESMTP
	id 6A17D60E000062C1; Thu, 28 May 2026 13:43:45 +0800 (CST)
X-Sender: hdanton@sina.com
X-Auth-ID: hdanton@sina.com
Authentication-Results: sina.com;
	 spf=none smtp.mailfrom=hdanton@sina.com;
	 dkim=none header.i=none;
	 dmarc=none action=none header.from=hdanton@sina.com
X-SMAIL-MID: 9341726816115
X-SMAIL-UIID: 4C03AE2645D34C15B349F3C5E267BA13-20260528-134345-1
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
Date: Thu, 28 May 2026 13:43:31 +0800
Message-ID: <20260528054334.1159-1-hdanton@sina.com>
In-Reply-To: <ahZeYQ0cLE1i8TGs@fedora>
References: <ag0lS_CbKO9R5CV8@fedora> <94076bc9-2c09-4bb6-8468-b6b8af419cb9@I-love.SAKURA.ne.jp> <ag1nfIFcykmQHbkk@fedora> <1ab8c579-eb76-4227-8a72-6ec819135219@I-love.SAKURA.ne.jp> <ag1223nAa0wZ8ALC@fedora> <fda8abc8-6aa2-463b-bf72-865f6b838034@I-love.SAKURA.ne.jp> <ahRocb0Vs_m6RF_O@fedora> <1a9f53d4-6f48-4df8-a3d8-2b0e442a163a@I-love.SAKURA.ne.jp> <ahZGxoI6oHQ_vSrx@fedora> <d1b5a737-f0e3-4927-b762-430b37fbb2f9@I-love.SAKURA.ne.jp>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Tue, 26 May 2026 22:00:49 -0500 Ming Lei wrote:
>On Wed, May 27, 2026 at 10:35:56AM +0900, Tetsuo Handa wrote:
>> On 2026/05/27 10:20, Ming Lei wrote:
>> >> Of course we should try to figure out the root cause first, but how can we do?
>> > 
>> > Definitely unexpected write IO(after umount & loop closed) from btrfs is more serious,
>> > which may cause data loss, so CC btrfs list and maintainer.
>> 
>> Why do you assume that the culprit is btrfs?
>> 
>> https://syzkaller.appspot.com/bug?extid=bc273027d5643e48e5b3 indicated that
>> this similar race is also happening with jfs.
>
> I just didn't see the above report on jfs.
> 
> It doesn't change anything, the same question still stands: unexpected write IO is issued
> or crosses umount & last closing of loop disk.
>
Given the loop workqueue that triggered the jfs warning, can you specify
the reason why the workqueue in question is NOT flushed while closing disk?
