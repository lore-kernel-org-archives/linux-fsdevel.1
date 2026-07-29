Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C455438DC4C
	for <linux-fsdevel@vger.kernel.org>; Wed, 29 Jul 2026 14:58:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785337128; cv=none; b=ptAg+50l2OQ2pd1e/o8T80O1aR3ioYxJDELe4cWGOM0wCDeviKYsozq53iiqXc+K1r2O7LJ9D078U59MSY4JU/SzgNatfS1NsPweH6BX0/Z1GyuGKjCi/xA3sgoymT04wkEDYsqPNs1GISZgviayBG/iYLqPnANcMHOxHXueXB4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785337128; c=relaxed/simple;
	bh=sm1CjsBhnbe61JQz9EwXW51g1yOzx1f8NR5CXUUdoug=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cZJcIDHGkJtEdy5uTuiC3HId6Pv8ZoV+/yBLTDfMZK8wMcxHyA8i2byq6dP1TLbYQBKUYiN7Zf+t4P+ot4oNJfpdbY9aASqiI3HeffPq92KYFz0WaSoJFTKn8bfkaY5TTIHCXyjiJiQSIy+N+sZ0aNXof4IP3mzL7UV2E7+YQGo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gI88mhdx; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gI88mhdx"
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-47db714766aso1320489f8f.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 29 Jul 2026 07:58:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785337125; x=1785941925; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=cKoiuuQYeGD8Tbtc4pZQX60de+u8VNdhsS7KoJZyOyk=;
        b=gI88mhdxFV0ZEPKk6iqpgjYZBSqP0C2cbhCZuwZKyPA6iSm520TPwWRZNpuLNs4oPp
         rT2hLbng/iOo9BZYWFhsGs5Ey5Xs2XgJsT8RuZk7pJUdAAec5Xhc0iJlnr7IqtB4pBVi
         6LIBIWSYl186Nl+D/sdx4jGYAKUGrgjdNavX/0iAC1f+6wW9TbJZAK6Fs2ZP+bxLs5RH
         dlx2oaMpF/tFinjamS/MDOartyfO+gjnsQqf4aPfePDSwdNRWgwxBreS9PCNOzFk7S/U
         B3oHfwJLvThW594iN0KGmJNYXzZu5jYgo2IDvR1oZIenqHZPQWHLGn9ye7BGKIHw7HQI
         4/vQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785337125; x=1785941925;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=cKoiuuQYeGD8Tbtc4pZQX60de+u8VNdhsS7KoJZyOyk=;
        b=NJQkpdAfDUV2DJgb+RKXkwnCW7YPgtSajrS9FvXwbU7r4Lo1il0q/k7uZnrw+o3wxj
         RMdY9Pv+f+ZA4MFgBI8K99WOIFgX0LTo0t1I0uNpLDIbep7dcDlR9egus4YLN4ShQgCb
         hRFAkyAq4UcllhfQi9uoVEHX7H7dPW/9ieIoDj+08q7Gw+hsjZaI1kxdQmKOXuXiEIsb
         rRWGNU5gvNckzdIttJRruqmO8dwli5U7WkXtibIEaBSFxj4tGKbiqzsNPIbMsqQ5lHMr
         AWjA4z9qPiXY/qNTC3/ULTXMKNO7/9CrKdePQej+TLCaeUOgtbxp6GBy5YyffyfWW+P+
         9xuA==
X-Forwarded-Encrypted: i=1; AHgh+RqXuBo1itP5lNEalc5SyFUmVlntuhlPZ9PdCPQrm3U7QoW7s1ENOs90ibPX/Xq2Slr6SvMowtambKerJB4n@vger.kernel.org
X-Gm-Message-State: AOJu0YxUc48fYab75lTu6WsL29JLeH3cP8zIiY63o2k3pCduR4FWokm+
	rXKtuUAIMQKA1tO1O9fugklSaESfmbqGgzHgcpXEET+3VBgcGOZxZ6Ex
X-Gm-Gg: AR+sD12fCppsBp7kqzS32fB/TC3Vss08GZIw24YFC2cg24qwN1pCyyJk1ueXVh9Sx9n
	zaONKu45v/RVrk4aPH1PvB7UZ9sToSnLf76tJUkr7bj0w4iQkPzuRfbH8g2TIgXDgIjTmWoUGP6
	xz8lOd9kw1MEo6UJzbNTdZTu3ZAe5uFITKeO7EprNe4pi+CWP30yOe7xnkouw3YISvqYqxIaqQW
	cHfTC+xeQTJuJ+Vk5r8E0YlUUPZ4gp6pf/54ml7UeSywJpydAx9qV1br3qYoJxXjVoAXXCj2RNq
	DJEupvn1+xBXJDs61NqwY5vpAsbuOc4TgKN2MWwrV2w1h8w+EhUdOMKfKgdpw0PFMQbEpmwP1S7
	Mh23azbEFxgZ9Dv9PMebf5BYONk2GEDDTJWB1njWCIQxpAKL1+/415baxdHckqv64vbIHnQ+cfx
	1ITqPNW6OSDjf1BBWkwRvwo60TzA7Q4Z8B28zAwKdKeGRBWO5reK1gFrHrwWVkv9k+COhHUfl7U
	yLpddQ5qS/qZPLDUpT6yyGJIhBvSwAWtcz/BkwObJlgU+12gVSvW/UqcJsJOGwj0R+c099HGw7y
	/QW2Gflqye4T415YtXvwXwL/GjEkRA==
X-Received: by 2002:a05:6000:480b:b0:47f:9096:3f01 with SMTP id ffacd0b85a97d-47fbabf8e1fmr3840554f8f.22.1785337124848;
        Wed, 29 Jul 2026 07:58:44 -0700 (PDT)
Received: from ?IPV6:2620:10d:c096:325:77fd:1068:74c8:af87? ([2620:10d:c092:600::1:640])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47fb6aa392asm8175195f8f.5.2026.07.29.07.58.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 29 Jul 2026 07:58:43 -0700 (PDT)
Message-ID: <1bd5710b-29c8-4a8c-8f26-72d9e71c2321@gmail.com>
Date: Wed, 29 Jul 2026 15:58:34 +0100
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v2 1/1] pipe: only enable the extra wake_up(rd_wait)
 for edge-triggered consumers
To: Oleg Nesterov <oleg@redhat.com>, Breno Leitao <leitao@debian.org>,
 Christian Brauner <brauner@kernel.org>, Mateusz Guzik <mjguzik@gmail.com>,
 Jens Axboe <axboe@kernel.dk>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>,
 Alexey Gladkov <legion@kernel.org>, linux-kernel@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, io-uring@vger.kernel.org
References: <amdNxsTODR4MCl3R@redhat.com> <amdPACI3kw8PobPx@redhat.com>
Content-Language: en-US
From: Pavel Begunkov <asml.silence@gmail.com>
In-Reply-To: <amdPACI3kw8PobPx@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 7/27/26 13:28, Oleg Nesterov wrote:
> pipe_poll() unconditionally sets poll_usage on the first call, forcing
> anon_pipe_write() to wake up readers on every write even if the pipe was
> not empty. But this is only needed for edge-triggered consumers: epoll
> with EPOLLET and io_uring without (unsupported) IORING_POLL_ADD_LEVEL.
> poll() and select() users pay for it for no reason.

Sounds good, especially with prep patches you mentioned.

The only note your problems are caused by IORING_OP_POLL_ADD, which
is not that important comparing to other polled io_uring requests,
and they also set EPOLLET while should be fine with level. Not
asking to change anything, io_uring should just stop setting EPOLLET
for them. And IIUC poll callback implementations don't care about
EPOLLET, at least before this patch.


> Change pipe_poll() to set ->pipe_usage only if wait->_key & EPOLLET is
> true, this check should catch both users.
> 
> While at it, add READ_ONCE() in anon_pipe_write() to pair with WRITE_ONCE()
> in pipe_poll().
> 
> Test-case for epoll:
> 
> 	#include <unistd.h>
> 	#include <sys/epoll.h>
> 	#include <assert.h>
> 
> 	int main(void)
> 	{
> 		int pfd[2], efd;
> 		struct epoll_event evt = { .events = EPOLLIN | EPOLLET };
> 
> 		pipe(pfd);
> 		efd = epoll_create1(0);
> 		epoll_ctl(efd, EPOLL_CTL_ADD, pfd[0], &evt);
> 
> 		for (int i = 0; i < 2; ++i) {
> 			write(pfd[1], "", 1);
> 			assert(epoll_wait(efd, &evt, 1, 0) == 1);
> 		}
> 
> 		return 0;
> 	}
> 
> Test-case for io_uring:
> 
> 	#include <unistd.h>
> 	#include <sys/mman.h>
> 	#include <sys/epoll.h>
> 	#include <sys/syscall.h>
> 	#include <linux/io_uring.h>
> 	#include <assert.h>
> 
> 	int main(void)
> 	{
> 		struct io_uring_params p = {};
> 		int fd, pfd[2];
> 
> 		pipe(pfd);
> 
> 		fd = syscall(SYS_io_uring_setup, 2, &p);
> 		assert(fd >= 0);
> 
> 		void *ring = mmap(0, p.cq_off.cqes + p.cq_entries * sizeof(struct io_uring_cqe),
> 				  PROT_READ | PROT_WRITE, MAP_SHARED, fd, IORING_OFF_SQ_RING);
> 		assert(ring != MAP_FAILED);
> 		*(unsigned *)(ring + p.sq_off.tail) = 1;
> 
> 		struct io_uring_sqe *sqes = mmap(0, p.sq_entries * sizeof(*sqes),
> 				  PROT_READ | PROT_WRITE, MAP_SHARED, fd, IORING_OFF_SQES);
> 		assert(sqes != MAP_FAILED);
> 		sqes[0].opcode = IORING_OP_POLL_ADD;
> 		sqes[0].fd = pfd[0];
> 		sqes[0].len = IORING_POLL_ADD_MULTI;
> 		sqes[0].poll32_events = EPOLLIN;
> 
> 		syscall(SYS_io_uring_enter, fd, 1, 0, 0, 0, 0);
> 
> 		unsigned *cq_head = ring + p.cq_off.head;
> 		unsigned *cq_tail = ring + p.cq_off.tail;
> 		for (int i = 0; i < 2; ++i) {
> 			write(pfd[1], "", 1);
> 			syscall(SYS_io_uring_enter, fd, 0, 0, IORING_ENTER_GETEVENTS, 0, 0);
> 			assert(*cq_tail == ++*cq_head);
> 		}
> 
> 		return 0;
> 	}
> 
> Signed-off-by: Oleg Nesterov <oleg@redhat.com>
> ---
>   fs/pipe.c | 7 ++++---
>   1 file changed, 4 insertions(+), 3 deletions(-)
> 
> diff --git a/fs/pipe.c b/fs/pipe.c
> index 429b0714ec57..98b1e2385103 100644
> --- a/fs/pipe.c
> +++ b/fs/pipe.c
> @@ -689,7 +689,7 @@ anon_pipe_write(struct kiocb *iocb, struct iov_iter *from)
>   	 * Epoll nonsensically wants a wakeup whether the pipe
>   	 * was already empty or not.
>   	 */
> -	if (was_empty || pipe->poll_usage)
> +	if (was_empty || READ_ONCE(pipe->poll_usage))
>   		wake_up_interruptible_sync_poll(&pipe->rd_wait, EPOLLIN | EPOLLRDNORM);
>   	kill_fasync(&pipe->fasync_readers, SIGIO, POLL_IN);
>   	if (wake_next_writer)
> @@ -752,7 +752,6 @@ static long pipe_ioctl(struct file *filp, unsigned int cmd, unsigned long arg)
>   	}
>   }
>   
> -/* No kernel lock held - fine */
>   static __poll_t
>   pipe_poll(struct file *filp, poll_table *wait)
>   {
> @@ -761,7 +760,9 @@ pipe_poll(struct file *filp, poll_table *wait)
>   	union pipe_index idx;
>   
>   	/* Epoll has some historical nasty semantics, this enables them */
> -	if (unlikely(!READ_ONCE(pipe->poll_usage)))
> +	if ((filp->f_mode & FMODE_READ) &&
> +	    wait && (wait->_key & EPOLLET) &&
> +	    unlikely(!READ_ONCE(pipe->poll_usage)))
>   		WRITE_ONCE(pipe->poll_usage, true);
>   
>   	/*

-- 
Pavel Begunkov

