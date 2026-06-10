Received: from out30-130.freemail.mail.aliyun.com (out30-130.freemail.mail.aliyun.com [115.124.30.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8DAB288530
	for <linux-fsdevel@vger.kernel.org>; Wed, 10 Jun 2026 08:17:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781079465; cv=none; b=VLPGwtiQBoveoPeSnkdSbQ24MyXGHiz3V/bPI5zKF4eWj5TxLw00t/e2jDzZNM15RRbRWcyeBdYHkU+310rp4kcKiyT+0ZGU+J7qh1IdY1xAuRNfZliYyPHF0RZqRKoT3anBEfADmflvaismYJlely8gA9J+K2lG0zA6MKaZrws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781079465; c=relaxed/simple;
	bh=e9wSur0GiQahXmadZV/c5KR6uk8cI8Ly2T/wGanJt+4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=g9AQHR2e06HlfiCdhlEFUhjGRdDn1i3Ca72M8kRFp2MLBSgV7kF70Hs7qjIGfiDiqlXauFZ7WQQq418eNG6153M1Un4L90VjX/IkWKJaMX5XHdU6uN6GQP6OCfOJ/4/RQ5WlmbXdm15cSZHv+c3lbnDehZnZ0gWv1fM0PKo3Hmc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=h7kGg09o; arc=none smtp.client-ip=115.124.30.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="h7kGg09o"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1781079455; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=NvLb5tLKBpV/t6c6tnZ04ySoXMUHtz0wr3py0vqetoM=;
	b=h7kGg09o8mFDhKD/8nkZvhLuFT/G1UkBt+xPTs2KF8aua6VxljkXJBrZJDfrZHNli4IrWJKcKvMkv78+AUZwDCufgH61IJjerKj1RAiLOhOtQHx2Jmv6CLpvaCC+0RYit/IaZiwjBaBYYcnKDnVSchBDtOo8Q1zODcos9jL0rIA=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R261e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037026112;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=7;SR=0;TI=SMTPD_---0X4a3mdk_1781079453;
Received: from 30.221.130.225(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0X4a3mdk_1781079453 cluster:ay36)
          by smtp.aliyun-inc.com;
          Wed, 10 Jun 2026 16:17:34 +0800
Message-ID: <e36c9ef5-4cd0-4281-9598-c1bfb8ebfaa0@linux.alibaba.com>
Date: Wed, 10 Jun 2026 16:17:33 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Fanotify (hsm or erofs) / fuse / nbd / ... + write(mmap) deadlock
 vector followup
To: "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
Cc: Christian Brauner <brauner@kernel.org>, Miklos Szeredi
 <miklos@szeredi.hu>, Gao Xiang <xiang@kernel.org>, Song Liu
 <song@kernel.org>, Amir Goldstein <amir73il@gmail.com>,
 Jan Kara <jack@suse.cz>
References: <271c1c26-f170-462b-8a7f-686530fdd449@linux.alibaba.com>
 <53d0e50a-faa9-49e4-a8f5-d4d37bcba0c6@linux.alibaba.com>
 <CAOQ4uxh-kmoO03yCPaFnWcMjeOgqUi_19cGg4qdeY86ccz9ZyA@mail.gmail.com>
 <f0adaed4-1412-4722-8bdd-53f5e3823209@linux.alibaba.com>
 <CAOQ4uxj7gP=qpUvVbMbxbf6LdrYLeB4dX=vkUfOpi1ZfU0542Q@mail.gmail.com>
 <CAJfpeguXSh3-_3cbpzS-s4+Bq+7MVwazD+3P-diG=Qq70E2qrQ@mail.gmail.com>
 <d5f62836-62d1-4b8e-9694-bbab27112e7e@linux.alibaba.com>
 <649fdbbb-64f7-43d9-afd5-a3076e3ec946@linux.alibaba.com>
 <CAOQ4uxj+WAe+99FFi9RfMd5tpSwwP=rSH4dNuJEdhV1wL+5CDA@mail.gmail.com>
 <dff837f6-7480-4984-8728-802ddd78dda4@linux.alibaba.com>
 <CAOQ4uxi7DceKuh6+qGjuQJEFiE=HEFu4dMrc++VXUknRnX26JQ@mail.gmail.com>
 <95371379-97e9-4cb4-8358-ec014b765b74@linux.alibaba.com>
 <CAOQ4uxjh5VYkKLAKxhMsy-ZmrbRrgX4pFgBLFqsDqWMXeiqg3w@mail.gmail.com>
 <ac05da56-eb2a-4862-b887-8081f249d8ce@linux.alibaba.com>
 <CAOQ4uxi0yRavUeztRh-Eb8_HvpfmqkpPbWT9JgQhUn7EKXnryw@mail.gmail.com>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <CAOQ4uxi0yRavUeztRh-Eb8_HvpfmqkpPbWT9JgQhUn7EKXnryw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi all,

Amir just suggested that I posted a long off-list discussion
on the list right now, but since it seems to relate to
`sb->s_writers.rw_sem` locking design, I am not quite sure
how deep I could help generally: But here it goes.

The background is that we have discussed a generic deadlock
timing for several months as below:

fsA is a filesystem which supports fsfreeze, such as EXT4/XFS/...

fsB is a filesystem which have some relationship with a
userspace daemon (e.g. a filesystem with fanotify HSM hooks /
   fanotify + EROFS file-backed mounts / a FUSE filesystem or
   a filesystem backed by a virtual block device)

Thread A                           Thread B                                 Userspace deamon
  write(fsA_fd, mmap(fsB_fd))
   file_start_write()
    (take SB_FREEZE_WRITE read lock)

    handle fsB mmap fault read
     -> notify userspace and wait

                                    freeze_super
                                    (try to take SB_FREEZE_WRITE write lock)
                                                                             received/handling fsB mmap read request
                                                                             (do random something...)
                                                                             write(fsA_fd2)
                                                                              (take SB_FREEZE_WRITE read lock)
The problem timing here is thread A does
`write(fsA_fd, mmap(fsB_fd))` => file_start_write() (rwsem read),
then hits page fault and wait for userspace deamon to finish
the request;

Thread B does fsfreeze on fsA so it is waiting a write lock
(sb_wait_write(), rwsem write) and blocked on thread A;

And the userspace deamon is a handler handling page fault,
and trying to write to another file (fsA_fd2) on fsA again
and blocked on thread B (file_start_write(), rwsem read).

because of the specific locking timing is `R->W->R`, at least
the whole workflow won't proceed so the related processes
(and fsA above) will be stuck.


Since the issue is complex, I can only give my own thought
from the perspective of fanotify+EROFS use cases on this:

  - fsfreeze is typically unneeded, especially on typical
    cloud + container environment;

  - Also we could isolate the image backing file into another
    totally different local filesystem so that
    "write(fd, mmap(),..)" + fsfreeze won't be a practical
    issue.

  - In the worst case, user programs can be killed to recover
    the system, and fanotify already supports this way, so
    it shouldn't be too harmful;

  - this vector impacts all userspace approaches.


I also gave my own preliminary idea at LSF to Jan and Amir
(just for reference):

diff --git a/fs/super.c b/fs/super.c
index 378e81efe643..2897d3572e9e 100644
--- a/fs/super.c
+++ b/fs/super.c
@@ -2069,6 +2069,7 @@ static inline bool may_unfreeze(struct super_block *sb, enum freeze_holder who,
   */
  int freeze_super(struct super_block *sb, enum freeze_holder who, const void *freeze_owner)
  {
+    bool retried;
      int ret;

      if (!super_lock_excl(sb)) {
@@ -2111,7 +2112,15 @@ int freeze_super(struct super_block *sb, enum freeze_holder who, const void *fre
      sb->s_writers.frozen = SB_FREEZE_WRITE;
      /* Release s_umount to preserve sb_start_write -> s_umount ordering */
      super_unlock_excl(sb);
-    sb_wait_write(sb, SB_FREEZE_WRITE);
+    while (ret = sb_wait_write_timeout(sb, SB_FREEZE_WRITE)) {
+        if (retried) {
+            sb->s_writers.frozen = SB_UNFROZEN;
+            sb_freeze_unlock(sb, SB_FREEZE_FS);
+            deactivate_locked_super(sb);
+            return ret;
+        }
+        retried = true;
+    }
      __super_lock_excl(sb);

      /* Now we go and block page faults... */

It was simply to add a new sb_wait_write_timeout()
interface so that the writer (freeze_super) can be woken
up even when the locking order is already (R->W->R),
allowing the W (freeze_super) to be woken and the (R->R)
to be merged.

I wonder if this is a practical way since it allows
"write(fd, mmap(),..)" and workable for all approaches.
However, the main issue at least in my opinion is that
percpu_rwsem doesn't have percpu_down_write_timeout()
(but as for rwsem since down_write_killable() exists, I
think down_write_timeout() should be doable at least),
and I tried to vibe-code a version but have no idea if
it performs well.


Amir and other people may have other better ideas for
further discussion, but as Amir suggested, I've written
this...

Thanks,
Gao Xiang
