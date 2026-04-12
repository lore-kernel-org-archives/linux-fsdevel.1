Received: from www262.sakura.ne.jp (www262.sakura.ne.jp [202.181.97.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C58942AA9
	for <linux-fsdevel@vger.kernel.org>; Sun, 12 Apr 2026 07:44:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.181.97.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775979869; cv=none; b=WGYtacN+G1eHwgmDdJwDvAa5xk2XJLFH9v5HYWeFjCT3RG3b745OF+xTukQ0PO4tSVWYqfzShzfslfJdNpq2ZcnEY5D9PaGJ1RjTlwEwrYb5u4DAvk/IiXmx4QXQlt6qfr7OW7MMn7CJuGmSyYXrGyy+6iXXDnDaxBEDigUP9MQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775979869; c=relaxed/simple;
	bh=pnX8oCDjZN99xrgmD0U6AwR/OQ6ii4zVkCqYu+qNd8M=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=gFIlbWGpnZQCrQyP84MqNgkxOPlkAWSnju+bjRlE0dgZkPbMO3aKFGMt7GqpB8pWtGsyjAVuWK9CFhfuKKYo4RZbdv65YaRaYyuU1Fp2PdU/yidljvKnKiMLDQMltOfKMtq9wwKT9E97n5bW+bHxOUUdIUvSe0zXsLmDo9ESE2k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp; arc=none smtp.client-ip=202.181.97.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp
Received: from www262.sakura.ne.jp (localhost [127.0.0.1])
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 63C75QBI021442;
	Sun, 12 Apr 2026 16:05:26 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from [192.168.1.5] (M106072072000.v4.enabler.ne.jp [106.72.72.0])
	(authenticated bits=0)
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 63C75QXZ021439
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
	Sun, 12 Apr 2026 16:05:26 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Message-ID: <ee4992b1-06ce-40f9-b554-bfcadd45cf97@I-love.SAKURA.ne.jp>
Date: Sun, 12 Apr 2026 16:05:25 +0900
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: Miklos Szeredi <miklos@szeredi.hu>, Miklos Szeredi <mszeredi@redhat.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Subject: [linux-next] fuse: wrong usage of no_free_ptr() in
 cuse_channel_open()
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Virus-Status: clean
X-Anti-Virus-Server: fsav305.rs.sakura.ne.jp

syzbot is failing to test linux-next kernels since next-20260403, for
commit 288de43f7c73 ("fuse: change fud->fc to fud->chan") is causing
"cat /dev/cuse" to trigger NULL pointer dereference problem.

The problem is that fch is NULL as of calling fuse_dev_alloc_install(), for
fuse_conn_init() uses no_free_ptr(fch) instead of plain fch; in other words,
you are calling no_free_ptr() too early.

  --- a/fs/fuse/cuse.c
  +++ b/fs/fuse/cuse.c
  @@ -521,7 +521,7 @@ static int cuse_channel_open(struct inode *inode, struct file *file)
           */
          fuse_conn_init(&cc->fc, &cc->fm, file->f_cred->user_ns, no_free_ptr(fch));
          cc->fc.release = cuse_fc_release;
  -       fud = fuse_dev_alloc_install(&cc->fc);
  +       fud = fuse_dev_alloc_install(fch);
          fuse_conn_put(&cc->fc);
          if (!fud)
                  return -ENOMEM;

Please be sure to include a fix for this problem before sending pull
request to Linus, or syzbot would have to disable CONFIG_CUSE because
syzbot will start failing to test all kernels due to this problem.

Reported-by: syzbot+9b639ce94c265f1daf1f@syzkaller.appspotmail.com
Link: https://syzkaller.appspot.com/bug?extid=9b639ce94c265f1daf1f

