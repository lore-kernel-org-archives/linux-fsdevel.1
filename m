Received: from www262.sakura.ne.jp (www262.sakura.ne.jp [202.181.97.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A5072BD11
	for <linux-fsdevel@vger.kernel.org>; Wed, 15 Apr 2026 11:50:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.181.97.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776253829; cv=none; b=YmVG2ASO5H7Ohq80xdYsr9iubgdmua8pFNaXxB9uVMyKLfS4Nv8MiwuYkGrNYbtQ/l9/jcqwBVDc0gUnN7xS7tb7pqHuM0D5G/wieswaWHB8o8Bugy5Xrw26BH+mIvhKSPqlf5vsr5nW2gunCIexYfqoHbSDysZsL4yqS01UJm8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776253829; c=relaxed/simple;
	bh=/GvumrhOTrjfHdsYSf8dhy+IY0v7RZ80XZSrxH2zwds=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jAKT0G4sZXTziVX+Fbu69IAaRO9lZwccqMvNuL8HC9tVk5/xtuA37nQkkv9TxJFYZOShZK9faVFpikw6XigakuSFYl4OvPD3EwKcSQoY2PTEF1cWKz5psCqGdRlqjq6OQdgmO/0zBirQ0nN3TCKKh1wmB5c0wWvJ55Y0vY2yNz4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp; arc=none smtp.client-ip=202.181.97.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp
Received: from www262.sakura.ne.jp (localhost [127.0.0.1])
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 63FBoD31031659;
	Wed, 15 Apr 2026 20:50:13 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from [192.168.1.5] (M106072072000.v4.enabler.ne.jp [106.72.72.0])
	(authenticated bits=0)
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 63FBoDB5031656
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
	Wed, 15 Apr 2026 20:50:13 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Message-ID: <b7edb87d-8734-43ed-93e4-5be72294c3bc@I-love.SAKURA.ne.jp>
Date: Wed, 15 Apr 2026 20:50:10 +0900
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [linux-next] fuse: wrong usage of no_free_ptr() in
 cuse_channel_open()
To: Miklos Szeredi <miklos@szeredi.hu>, Miklos Szeredi <mszeredi@redhat.com>
Cc: linux-fsdevel <linux-fsdevel@vger.kernel.org>
References: <ee4992b1-06ce-40f9-b554-bfcadd45cf97@I-love.SAKURA.ne.jp>
 <CAJfpegs+8pcuQFBNB_0TfDh2Fo3_13pcpVNNzRdR=eZ-tvx35A@mail.gmail.com>
Content-Language: en-US
From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
In-Reply-To: <CAJfpegs+8pcuQFBNB_0TfDh2Fo3_13pcpVNNzRdR=eZ-tvx35A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Virus-Status: clean
X-Anti-Virus-Server: fsav204.rs.sakura.ne.jp

On 2026/04/13 18:49, Miklos Szeredi wrote:
> On Sun, 12 Apr 2026 at 09:05, Tetsuo Handa
> <penguin-kernel@i-love.sakura.ne.jp> wrote:
>>
>> syzbot is failing to test linux-next kernels since next-20260403, for
>> commit 288de43f7c73 ("fuse: change fud->fc to fud->chan") is causing
>> "cat /dev/cuse" to trigger NULL pointer dereference problem.
>>
>> The problem is that fch is NULL as of calling fuse_dev_alloc_install(), for
>> fuse_conn_init() uses no_free_ptr(fch) instead of plain fch; in other words,
>> you are calling no_free_ptr() too early.
> 
> Thanks, fixed.

"cat /dev/cuse" hits WARN_ON(fud->pq.processing) as of
commit fbe92cef04a4 (HEAD -> for-next, origin/for-next)
of mszeredi/fuse.git tree. Please check.

  WARNING: fs/fuse/dev.c:482 at fuse_dev_install_with_pq+0x10e/0x120 [fuse], CPU#5: cat/1194

