Received: from mail-oi2-f12.google.com (mail-oi2-f12.google.com [74.125.231.204])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03AC82DB789
	for <linux-fsdevel@vger.kernel.org>; Sun, 20 Sep 2026 13:39:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.231.204
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789911599; cv=none; b=pEJ7c4DRY6PbWRV2VVQAASE8Z67dfeJkwjA3lByKx8/bP4X1DdkwM4G2Wb+m50oV/2sONmzG8wwUdUM7OVeIdo3JDNNulqyH5sWN2LxHnqBJWaKHYDtjm9Uaidfgkzz9/wcjLMX2S3LTSEx+wMKOUO2OYyhZP1lenci6EIaFPCU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789911599; c=relaxed/simple;
	bh=0Z6Ur5B6bJJOeDgQ/Dj4Kz+7/b/YMAa6rc/wlOIyarM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rWjDTZpp/03kaSZuPR/4+BRfUFlGBAqViB65e9dLs4UUZ1bjMrOKOBNOhWQavoPz7PvSRRK/I0DseRD4GGgWd4ghzaAl5cd21l/a6mc1j5CktXLP3Z5EF3IQF34v3ifVnDXe5cFSr1UeZ4HEE2kk/nharkhX9Yvxe/b9p2amqAo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fqPIDr13; arc=none smtp.client-ip=74.125.231.204
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fqPIDr13"
Received: by mail-oi2-f12.google.com with SMTP id 46e09a7af769-804ef461aedso1235587a34.0
        for <linux-fsdevel@vger.kernel.org>; Sun, 20 Sep 2026 06:39:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789911597; x=1790516397; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=yxUkkgeGlmRw+l40HMZLKgm5cFxw+sBpLHwN+11g3Ls=;
        b=fqPIDr13ZT734AYX1dGmXv5AWQoBNy0uhDZ7tkO7eP3NaL0vSjRMrhKOBotF/WpBo0
         UZ8hUf1e/5sUZiTNspb8G2Vh7X92L9cvCO6kX3mq6/OWVO+AI1n2b4CgsgbDgnuGO+3l
         o4hoOztNMTWstgHHgAprNDCJUzTwMNR8kcjzjx2PBPh7S0BqJ9m2yabYAp9yhm6XP2ti
         BmWi1+KdrU293iFcr8uJ/ZfR8bDZKiMkMiOc5QPxHkU8XxLul+pZCg/t2z+acyv4vt5W
         BI/3xdN3QJoHdzl2Kv0RmXAarPmhYXjW3mzzSp1mDDR1vREOcg/0WLiAT2xrLeZ0GLUr
         j5xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789911597; x=1790516397;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=yxUkkgeGlmRw+l40HMZLKgm5cFxw+sBpLHwN+11g3Ls=;
        b=X4W5XUIE0n9DdkwlYttTvtU8xkJlu92gmO5n7ql2x3n+UucJBqaVD2cnNYaSy+nHZu
         63IIP4bllmnd2nZiyV8yAFmACCIaAonrQ+Vo5a2Hgk6VoJjQZoGbBkAb88f6Aj1Hrc3B
         aVlCwoOBP0LVkBvbCkFBFbZujMG6QoEeQkFWlPVqfIJrEtS4HZYYcyheM1LF0cuoPAnf
         rMObyASDDBC8jC+I+XIh4wDFjdRwRkOODTc0W2jaERFLt3AFWS6aGFGZ6Z6e4u5RPmn0
         8rBj0+EDb+AFw3eV2GyIuQB0p8dR3VznQYEwEiwMt16Zh6ZRLgp9zRv0XKr/FI7Onw8K
         xVzQ==
X-Forwarded-Encrypted: i=1; AKwUvByLuM4i10qyzr86JwFeCBhkQFSS1EJwTQegejM60EeS+3TFI+eM1rr5LFNkdupbkQOnHnbywqJtRZyC2pdF@vger.kernel.org
X-Gm-Message-State: AFuF++nkSqSINsrQIusUCnFIaRKFXO22WmjxqTpeTs2nBMSmun7/XkYL
	Tmkr1wkPN6VWYtX35R7B61H8MVv1rlUQlEfaiELaCjL1kmyphMXsZxNK
X-Gm-Gg: AYBFou1+V4WS0iqZtoMG9KdQEyJdVuFhzFmE9xahUY5V/asu8CZzOtb6oQY6+lHVD0+
	VkD3J9vb1ZDxxkpxQ1DZuLq31MyTyDeOiRUkmn8hJ4SLs1z4QapeI7py10fnO5NqwfUDFOnyuzs
	YAKzisp6Y6OW5JR1y/yq3CU96yHMCcShQxyrJTVuGucLMWBwSq0S1mQbLvYE8rL5fSPAKlyaG9l
	KYzH84DqkkVRNOEWXi/zCfXErawkOi5bCWbXVBpFjSfZWwySayazYJxgAfSRpJ66dVCF6Rw9gN5
	iCNKNwN+WPwt7hVlRLuj3NXTrFMroWqOzdm5cpkAmOE+5DPDCPYpFVc2ObM24SyQA1VAPZF+GLn
	Bf7ogTqb48wxi14KqZuJS8ZXC10d/tFGmXzKtXdobTVULMujJiz7KiXEaW1TOPLkockbFNjX6kZ
	1xRaf8+HqYXeflUODYL9/5ulR8aSRVm1qWRhCy+X3F+b0P6EQNJTcWLV6uRAknnOfUJdEqWVSOR
	XgkXzozUxirN9eErBcSCrZwtvFenOD5NqwGTOQv9QZerjAx+7zbq+GNrCL2ZuswGc9E8cxhza/D
	f+A=
X-Received: by 2002:a05:6830:2814:b0:7f6:96ad:36a8 with SMTP id 46e09a7af769-80de035a67amr7283786a34.8.1789911596678;
        Sun, 20 Sep 2026 06:39:56 -0700 (PDT)
Received: from fedora-laptop ([172.245.82.59])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-8107b8231a4sm5070777a34.3.2026.09.20.06.39.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Sep 2026 06:39:56 -0700 (PDT)
Date: Sun, 20 Sep 2026 08:39:50 -0500
From: Ming Lei <tom.leiming@gmail.com>
To: Christian Brauner <brauner@kernel.org>
Cc: Jens Axboe <axboe@kernel.dk>, linux-fsdevel@vger.kernel.org,
	linux-block@vger.kernel.org, Chris Mason <mason@kernel.org>
Subject: Re: ublk: consequences of a dead server are only failing on the last
 /dev/ublkcN release
Message-ID: <aq_iJpAgRi9ZfnOg@fedora-laptop>
References: <20260918-eisbrecher-toilette-worum-eb11f777c563@brauner>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260918-eisbrecher-toilette-worum-eb11f777c563@brauner>

Hello,

On Fri, Sep 18, 2026 at 12:29:22PM +0200, Christian Brauner wrote:
> Hi,
> 
> Chris scanned a new series of mine for me and he reported some
> interesting behavior that I dug into.
> 
> A ublk request that was handed to the server is only failed once the
> last reference to /dev/ublkcN is dropped. So holding the file open keeps
> the request alive.
> 
> This causes any waiter to be stuck in D state and blocks STOP_DEV.
> 
> I'm attaching two reproducers:
> 
> (1) ublk_inherited_fd_test.c   the general case, no vfork involved
> (2) vfork_ublk_test.c          the holder of the reference is the waiter itself
> 
> Re (1):
> 
> A single-threaded ublk server fork()s a helper. The helper inherits the
> fdtable including /dev/ublkcN. Now another process opens /dev/ublkbN and
> writes 4 kb then fsync()s. The servers gets a WRITE and _exit()s without
> completing it - say it crashes:
> 
>   - The writer sleeps in folio_wait_writeback() in D state.
>   - STOP_DEV issued from another process never returns.
> 
>     The control command runs on an io-wq worker of that process, which
>     calls ublk_stop_dev() -> del_gendisk() -> bdev_mark_dead() ->
>     filemap_write_and_wait_range() and ends up waiting on the page that
>     won't be written back.
> 
>     Said process can't exit and io_wq_put_and_exit() waits for the
>     worker.
> 
> This can only be undone if the helper is SIGKILLed:
> 
>   # ublk0 up, server 119
>   # helper 123 forked by the server, holds the inherited fds
>   # WRITER fsync
>   # server 119 died with the WRITE in hand
>   # 2s after the server died:
>   # writer pid 124, state D:
>   #   folio_wait_bit_common
>   #   folio_wait_writeback
>   #   __filemap_fdatawait_range
>   #   file_write_and_wait_range
>   #   blkdev_fsync
>   #   do_fsync
>   # STOP_DEV from pid 125 has not returned after 5s:
>   # STOP_DEV issuer thread 126:
>   #   folio_wait_bit_common
>   #   folio_wait_writeback
>   #   __filemap_fdatawait_range
>   #   filemap_write_and_wait_range
>   #   bdev_mark_dead
>   #   blk_report_disk_dead
>   #   __del_gendisk
>   #   del_gendisk
>   #   ublk_stop_dev_unlocked.part.0
>   #   ublk_ctrl_uring_cmd
>   #   io_uring_cmd
>   #   io_wq_submit_work
>   #   io_worker_handle_work
>   #   io_wq_worker
>   # killing helper 123
>   # WRITER fsync returned -1 errno 5
>   # STOP_DEV returned after the helper died
> 
> What happens to a device after a server crash depends on whoever else
> holds /dev/ublkcN open: A forked helper, a process that got the fd via
> SCM_RIGHTS, or a vfork child.
> 
> I'm not sure whether that's intended semantics but it surely has
> confusion potential and should probably be at least documented.

It is attributed to ublk driver implementation and kernel:

1) ublk driver uses two-stage tear-down: 

- uring commands are canceled when exiting io_uring

- block requests are aborted when ublk server is down, which can only be signaled
by closing /dev/ublkcN; this stage depends on canceling uring commands.

Not get other idea for deciding if ublk server can be thought as being down.

But yes, it should be documented.

> 
> I suppose failing outstanding requests on server crash is intentionally
> not done for recover reasons or whatever. But maybe STOP_DEV should be
> made to work.

STOP_DEV needs to freeze request queue, which has to drain inflight
request.

> 
> Re (2):
> 
> vfork() makes it really ugly. Say a single-threaded ublk server vfork()s
> a child. The child opens /dev/ublkbN, writes some stuff and closes the
> fd. Since close(2) runs bdev_release() -> sync_blockdev() it waits for
> the write.

ublk driver shouldn't access to /dev/ublkbN, #2 is similar with that, so it
shouldn't be supported.

> 
> The write gets dispatched to the server's task work. But the server
> sleeps in wait_for_vfork_done() until the child execs or exits.
> 
> But the child cannot exec or exit because close(2) doesn't return.
> 
> ublk makes this more hairy though. Even a SIGKILL sent to the server aka
> the parent won't help. The vfork()ed child hangs on the close(2).
> 
> So that stays in D state forever with an undeletable device:
> 
>     server, after SIGKILL: gone
>     child:
>       State:  D (disk sleep)
>       folio_wait_bit_common
>       folio_wait_writeback
>       __filemap_fdatawait_range
>       filemap_write_and_wait_range
>       bdev_release
>       blkdev_release
>       __fput
>       fput_close_sync
>       __x64_sys_close
> 
> Unrelated, but also a potential issue:
> 
> The commit 7fc4da6a304b ("ublk: scan partition in async way") made
> partition scans run from a workqueue that holds disk->open_mutex while
> the server serves its reads and START_DEV returns before it's finished.
> 
> Any server that treats START_DEV's return as a signal that the disk is
> ready and doesn't serve requests hangs every open() of /dev/ublkbN on
> uninterruptible on open_mutex. You can combine that with (1) and (2).

START_DEV doesn't promise partitions scanning done when it is returned.

nvme multipath has similar usage too.


Thanks, 
Ming
