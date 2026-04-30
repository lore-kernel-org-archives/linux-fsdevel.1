Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C59D19E839
	for <linux-fsdevel@vger.kernel.org>; Thu, 30 Apr 2026 11:22:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777548156; cv=none; b=a3tlGWSlGK5zttKBcW7ZQbzrU+IH6BvyAHjFMbNOot+sRSp620r21mcQrwwXKV3F97s9J8pUakRKC1wJulyl06WF+IA2/jX+MO/3WrsB6QPUohBCsIEFyytEJnOFN+UejSFshZmfZvs6UM7ioVo2tOGWeqVCtDRg+6eVhQ+xMbw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777548156; c=relaxed/simple;
	bh=Top18xpO/wCyBn1TqvLzdapkVPN4jAZpLJmOzCgPbyE=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=t4/b8nkW5Plcmah9jqCj5PZ/IQWMahezvL2xMtQmhDLAQP3g/p0yEmpTWX2BMyEzU2x0hDzAMtHaUEX15dWCAS/YaHxNUHr7mT4LVKssvUs6X4M2j3cKAEMvDzRyEnGeZKoL4ULa4svrqf48P6QMkzkYCNaCehPPOdBzzdkN3lU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XibJbFCb; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XibJbFCb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B0B05C2BCB3;
	Thu, 30 Apr 2026 11:22:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777548156;
	bh=Top18xpO/wCyBn1TqvLzdapkVPN4jAZpLJmOzCgPbyE=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=XibJbFCbToRNFJx9aCpkZtAWrnVxsO3NAqPf0mubS9Kngo93FeIjyxQZeWR/TmWPR
	 72MSN/uUas9nKa4eDWrUPJzG998xM3R9Z6UW6L2LB0JOv+4pyCEvqUMUuT0pavpKtr
	 LxQfa9mQKO27esNlsNFF3YxbweOq+qHgwuYc+I92sozaY5HA5AnbKUC4DNoQfqIlsZ
	 DQv3awYjbRUyKP1FQUssFjAIjF2uSmgoJpfNVopHYQHQYaZ6cIeUcSKerdpAiHpxKr
	 B3+NJeA1OhlYc2HiS5Cx2ZsCTYyHtO+Z8xDlyL22wJEXf2YlG/0P52e1Lt1N6pmqxV
	 aLSXTvpfq8dog==
Message-ID: <2bd55e996401939a75a6d03d6608198dc1d4fc53.camel@kernel.org>
Subject: Re: [PATCH v2 11/14] fuse: add pinned headers capability for
 io-uring buffer rings
From: Jeff Layton <jlayton@kernel.org>
To: Joanne Koong <joannelkoong@gmail.com>, miklos@szeredi.hu
Cc: bernd@bsbernd.com, axboe@kernel.dk, linux-fsdevel@vger.kernel.org
Date: Thu, 30 Apr 2026 12:22:32 +0100
In-Reply-To: <20260402162840.2989717-12-joannelkoong@gmail.com>
References: <20260402162840.2989717-1-joannelkoong@gmail.com>
	 <20260402162840.2989717-12-joannelkoong@gmail.com>
Autocrypt: addr=jlayton@kernel.org; prefer-encrypt=mutual;
 keydata=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
 QZIQXVeAA+smfTT0tDrisj1U5x6ZB9b3nBg65kc=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.3 (3.58.3-1.fc43) 
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2026-04-02 at 09:28 -0700, Joanne Koong wrote:
> Allow fuse servers to pin their header buffers by setting the
> FUSE_URING_PINNED_HEADERS flag alongside FUSE_URING_BUFRING on REGISTER
> sqes. When set, the kernel pins the header pages, vmaps them for a
> kernel virtual address, and uses direct memcpy for copying. This avoids
> the per-request overhead of having to pin/unpin user pages and translate
> virtual addresses.
>=20
> Buffers must be page-aligned. The kernel accounts pinned pages against
> RLIMIT_MEMLOCK (bypassed with CAP_IPC_LOCK) and tracks mm->pinned_vm.
> Unpinning is done in process context during connection abort, since vmap
> cannot run in softirq (where final destruction occurs via RCU).
>=20
> Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
> ---
>  fs/fuse/dev_uring.c       | 228 ++++++++++++++++++++++++++++++++++++--
>  fs/fuse/dev_uring_i.h     |  23 +++-
>  include/uapi/linux/fuse.h |   2 +
>  3 files changed, 243 insertions(+), 10 deletions(-)
>=20
> diff --git a/fs/fuse/dev_uring.c b/fs/fuse/dev_uring.c
> index 9f14a2bcde3f..79736b02cf9f 100644
> --- a/fs/fuse/dev_uring.c
> +++ b/fs/fuse/dev_uring.c
> @@ -11,6 +11,7 @@
> =20
>  #include <linux/fs.h>
>  #include <linux/io_uring/cmd.h>
> +#include <linux/vmalloc.h>
> =20
>  static bool __read_mostly enable_uring;
>  module_param(enable_uring, bool, 0644);
> @@ -46,6 +47,11 @@ static inline bool bufring_enabled(struct fuse_ring_qu=
eue *queue)
>  	return queue->bufring !=3D NULL;
>  }
> =20
> +static inline bool bufring_pinned_headers(struct fuse_ring_queue *queue)
> +{
> +	return queue->bufring->use_pinned_headers;
> +}
> +
>  static void uring_cmd_set_ring_ent(struct io_uring_cmd *cmd,
>  				   struct fuse_ring_ent *ring_ent)
>  {
> @@ -200,6 +206,37 @@ bool fuse_uring_request_expired(struct fuse_conn *fc=
)
>  	return false;
>  }
> =20
> +static void fuse_bufring_unpin_mem(struct fuse_bufring_pinned *mem)
> +{
> +	struct page **pages =3D mem->pages;
> +	unsigned int nr_pages =3D mem->nr_pages;
> +	struct user_struct *user =3D mem->user;
> +	struct mm_struct *mm_account =3D mem->mm_account;
> +
> +	vunmap(mem->addr);
> +	unpin_user_pages(pages, nr_pages);
> +
> +	if (user) {
> +		atomic_long_sub(nr_pages, &user->locked_vm);
> +		free_uid(user);
> +	}
> +
> +	atomic64_sub(nr_pages, &mm_account->pinned_vm);
> +	mmdrop(mm_account);
> +
> +	kvfree(mem->pages);
> +}
> +
> +static void fuse_uring_bufring_unpin(struct fuse_ring_queue *queue)
> +{
> +	struct fuse_bufring *br =3D queue->bufring;
> +
> +	if (bufring_pinned_headers(queue)) {
> +		fuse_bufring_unpin_mem(&br->pinned_headers);
> +		br->use_pinned_headers =3D false;
> +	}
> +}
> +
>  void fuse_uring_destruct(struct fuse_conn *fc)
>  {
>  	struct fuse_ring *ring =3D fc->ring;
> @@ -227,7 +264,10 @@ void fuse_uring_destruct(struct fuse_conn *fc)
>  		}
> =20
>  		kfree(queue->fpq.processing);
> -		kfree(queue->bufring);
> +		if (bufring_enabled(queue)) {
> +			fuse_uring_bufring_unpin(queue);
> +			kfree(queue->bufring);
> +		}
>  		kfree(queue);
>  		ring->queues[qid] =3D NULL;
>  	}
> @@ -309,14 +349,131 @@ static int fuse_uring_get_iovec_from_sqe(const str=
uct io_uring_sqe *sqe,
>  	return 0;
>  }
> =20
> +static struct page **fuse_uring_pin_user_pages(void __user *uaddr,
> +					       unsigned long len, int *npages)
> +{
> +	unsigned long addr =3D (unsigned long)uaddr;
> +	unsigned long start, end, nr_pages;
> +	struct page **pages;
> +	int pinned;
> +
> +	if (check_add_overflow(addr, len, &end))
> +		return ERR_PTR(-EOVERFLOW);
> +	if (check_add_overflow(end, PAGE_SIZE - 1, &end))
> +		return ERR_PTR(-EOVERFLOW);
> +
> +	end =3D end >> PAGE_SHIFT;
> +	start =3D addr >> PAGE_SHIFT;
> +	nr_pages =3D end - start;
> +	if (WARN_ON_ONCE(!nr_pages))
> +		return ERR_PTR(-EINVAL);
> +	if (WARN_ON_ONCE(nr_pages > INT_MAX))
> +		return ERR_PTR(-EOVERFLOW);
> +
> +	pages =3D kvmalloc_objs(struct page *, nr_pages, GFP_KERNEL_ACCOUNT);
> +	if (!pages)
> +		return ERR_PTR(-ENOMEM);
> +
> +	pinned =3D pin_user_pages_fast(addr, nr_pages, FOLL_WRITE | FOLL_LONGTE=
RM,
> +				     pages);
> +	/* success, mapped all pages */
> +	if (pinned =3D=3D nr_pages) {
> +		*npages =3D nr_pages;
> +		return pages;
> +	}
> +
> +	/* remove any partial pins */
> +	if (pinned > 0)
> +		unpin_user_pages(pages, pinned);
> +
> +	kvfree(pages);
> +
> +	return ERR_PTR(pinned < 0 ? pinned : -EFAULT);
> +}
> +
> +static int account_pinned_pages(struct fuse_bufring_pinned *mem,
> +				struct page **pages, unsigned int nr_pages)
> +{
> +	unsigned long page_limit, cur_pages, new_pages;
> +	struct user_struct *user =3D current_user();
> +
> +	if (!nr_pages)
> +		return 0;
> +
> +	if (!capable(CAP_IPC_LOCK)) {
> +		/* Don't allow more pages than we can safely lock */
> +		page_limit =3D rlimit(RLIMIT_MEMLOCK) >> PAGE_SHIFT;
> +
> +		cur_pages =3D atomic_long_read(&user->locked_vm);
> +		do {
> +			new_pages =3D cur_pages + nr_pages;
> +			if (new_pages > page_limit)
> +				return -ENOMEM;
> +		} while (!atomic_long_try_cmpxchg(&user->locked_vm,
> +						  &cur_pages, new_pages));
> +
> +		mem->user =3D get_uid(current_user());
> +	}
> +
> +	atomic64_add(nr_pages, &current->mm->pinned_vm);
> +	mmgrab(current->mm);
> +	mem->mm_account =3D current->mm;
> +
> +	return 0;
> +}
> +
> +static int fuse_bufring_pin_mem(struct fuse_bufring_pinned *mem,
> +				void __user *addr, size_t len)
> +{
> +	struct page **pages =3D NULL;
> +	int nr_pages;
> +	int err;
> +
> +	if (!PAGE_ALIGNED(addr))
> +		return -EINVAL;
> +
> +	pages =3D fuse_uring_pin_user_pages(addr, len, &nr_pages);
> +	if (IS_ERR(pages))
> +		return PTR_ERR(pages);
> +
> +	err =3D account_pinned_pages(mem, pages, nr_pages);
> +	if (err)
> +		goto unpin;
> +
> +	mem->addr =3D vmap(pages, nr_pages, VM_MAP, PAGE_KERNEL);
> +	if (!mem->addr) {
> +		err =3D -ENOMEM;
> +		goto unaccount;
> +	}
> +
> +	mem->pages =3D pages;
> +	mem->nr_pages =3D nr_pages;
> +
> +	return 0;
> +
> +unaccount:
> +	if (mem->user) {
> +		atomic_long_sub(nr_pages, &mem->user->locked_vm);
> +		free_uid(mem->user);
> +	}
> +	atomic64_sub(nr_pages, &current->mm->pinned_vm);
> +	mmdrop(mem->mm_account);
> +unpin:
> +	unpin_user_pages(pages, nr_pages);
> +	kvfree(pages);
> +	return err;
> +}
> +
>  static int fuse_uring_bufring_setup(struct io_uring_cmd *cmd,
> -				     struct fuse_ring_queue *queue)
> +				    struct fuse_ring_queue *queue,
> +				    u64 init_flags)
>  {
>  	const struct fuse_uring_cmd_req *cmd_req =3D
>  		io_uring_sqe128_cmd(cmd->sqe, struct fuse_uring_cmd_req);
>  	u16 queue_depth =3D READ_ONCE(cmd_req->init.queue_depth);
>  	unsigned int buf_size =3D READ_ONCE(cmd_req->init.buf_size);
>  	struct iovec iov[FUSE_URING_IOV_SEGS];
> +	bool pinned_headers =3D init_flags & FUSE_URING_PINNED_HEADERS;
>  	void __user *payload, *headers;
>  	size_t headers_size, payload_size, ring_size;
>  	struct fuse_bufring *br;
> @@ -354,7 +511,17 @@ static int fuse_uring_bufring_setup(struct io_uring_=
cmd *cmd,
>  		return -ENOMEM;
> =20
>  	br->queue_depth =3D queue_depth;
> -	br->headers =3D headers;
> +	if (pinned_headers) {
> +		err =3D fuse_bufring_pin_mem(&br->pinned_headers, headers,
> +					   headers_size);
> +		if (err) {
> +			kfree(br);
> +			return err;
> +		}
> +		br->use_pinned_headers =3D true;
> +	} else {
> +		br->headers =3D headers;
> +	}
> =20
>  	payload_addr =3D (uintptr_t)payload;
> =20
> @@ -385,8 +552,15 @@ static bool queue_init_flags_consistent(struct fuse_=
ring_queue *queue,
>  					u64 init_flags)
>  {
>  	bool bufring =3D init_flags & FUSE_URING_BUFRING;
> +	bool pinned_headers =3D init_flags & FUSE_URING_PINNED_HEADERS;
> +
> +	if (bufring_enabled(queue) !=3D bufring)
> +		return false;
> +
> +	if (!bufring)
> +		return true;
> =20
> -	return bufring_enabled(queue) =3D=3D bufring;
> +	return bufring_pinned_headers(queue) =3D=3D pinned_headers;
>  }
> =20
>  static struct fuse_ring_queue *
> @@ -423,7 +597,7 @@ fuse_uring_create_queue(struct io_uring_cmd *cmd, str=
uct fuse_ring *ring,
>  	fuse_pqueue_init(&queue->fpq);
> =20
>  	if (use_bufring) {
> -		int err =3D fuse_uring_bufring_setup(cmd, queue);
> +		int err =3D fuse_uring_bufring_setup(cmd, queue, init_flags);
> =20
>  		if (err) {
>  			kfree(pq);
> @@ -437,8 +611,10 @@ fuse_uring_create_queue(struct io_uring_cmd *cmd, st=
ruct fuse_ring *ring,
>  	if (ring->queues[qid]) {
>  		spin_unlock(&fc->lock);
>  		kfree(queue->fpq.processing);
> -		if (use_bufring)
> +		if (use_bufring) {
> +			fuse_uring_bufring_unpin(queue);
>  			kfree(queue->bufring);
> +		}
>  		kfree(queue);
> =20
>  		queue =3D ring->queues[qid];
> @@ -605,6 +781,25 @@ static void fuse_uring_async_stop_queues(struct work=
_struct *work)
>  	}
>  }
> =20
> +static void fuse_uring_unpin_queues(struct fuse_ring *ring)
> +{
> +	int qid;
> +
> +	for (qid =3D 0; qid < ring->nr_queues; qid++) {
> +		struct fuse_ring_queue *queue =3D READ_ONCE(ring->queues[qid]);
> +		struct fuse_bufring *br;
> +
> +		if (!queue)
> +			continue;
> +
> +		br =3D queue->bufring;
> +		if (!br)
> +			continue;
> +
> +		fuse_uring_bufring_unpin(queue);
> +	}
> +}
> +
>  /*
>   * Stop the ring queues
>   */
> @@ -643,6 +838,9 @@ void fuse_uring_abort(struct fuse_conn *fc)
>  		fuse_uring_abort_end_requests(ring);
>  		fuse_uring_stop_queues(ring);
>  	}
> +
> +	/* unpin while in process context - can't do this in softirq */
> +	fuse_uring_unpin_queues(ring);
>  }
> =20
>  /*
> @@ -758,6 +956,11 @@ static int copy_header_to_ring(struct fuse_ring_ent =
*ent,
>  		int buf_offset =3D offset +
>  			sizeof(struct fuse_uring_req_header) * ent->id;
> =20
> +		if (bufring_pinned_headers(ent->queue)) {
> +			memcpy(ent->queue->bufring->pinned_headers.addr + buf_offset,
> +			       header, header_size);
> +			return 0;
> +		}
>  		ring =3D ent->queue->bufring->headers + buf_offset;
>  	} else {
>  		ring =3D (void __user *)ent->headers + offset;
> @@ -785,6 +988,11 @@ static int copy_header_from_ring(struct fuse_ring_en=
t *ent,
>  		int buf_offset =3D offset +
>  			sizeof(struct fuse_uring_req_header) * ent->id;
> =20
> +		if (bufring_pinned_headers(ent->queue)) {
> +			memcpy(header, ent->queue->bufring->pinned_headers.addr + buf_offset,
> +			       header_size);
> +			return 0;
> +		}
>  		ring =3D ent->queue->bufring->headers + buf_offset;
>  	} else {
>  		ring =3D (void __user *)ent->headers + offset;
> @@ -1399,7 +1607,13 @@ fuse_uring_create_ring_ent(struct io_uring_cmd *cm=
d,
> =20
>  static bool init_flags_valid(u64 init_flags)
>  {
> -	u64 valid_flags =3D FUSE_URING_BUFRING;
> +	u64 valid_flags =3D
> +		FUSE_URING_BUFRING | FUSE_URING_PINNED_HEADERS;
> +	bool bufring =3D init_flags & FUSE_URING_BUFRING;
> +	bool pinned_headers =3D init_flags & FUSE_URING_PINNED_HEADERS;
> +
> +	if (pinned_headers && !bufring)
> +		return false;
> =20
>  	return !(init_flags & ~valid_flags);
>  }
> diff --git a/fs/fuse/dev_uring_i.h b/fs/fuse/dev_uring_i.h
> index 66d5d5f8dc3f..05c0f061a882 100644
> --- a/fs/fuse/dev_uring_i.h
> +++ b/fs/fuse/dev_uring_i.h
> @@ -42,12 +42,29 @@ struct fuse_bufring_buf {
>  	unsigned int id;
>  };
> =20
> -struct fuse_bufring {
> -	/* pointer to the headers buffer */
> -	void __user *headers;
> +struct fuse_bufring_pinned {
> +	void *addr;
> +	struct page **pages;
> +	unsigned int nr_pages;
> +
> +	/*
> +	 * need to track this so we can unpin / unaccount pages during teardown
> +	 * when not running in the server's task context
> +	 */
> +	struct user_struct *user;
> +	struct mm_struct *mm_account;
> +};
> =20
> +struct fuse_bufring {
> +	bool use_pinned_headers: 1;
>  	unsigned int queue_depth;
> =20
> +	union {
> +		/* pointer to the headers buffer */
> +		void __user *headers;
> +		struct fuse_bufring_pinned pinned_headers;
> +	};
> +
>  	/* metadata tracking state of the bufring */
>  	unsigned int nbufs;
>  	unsigned int head;
> diff --git a/include/uapi/linux/fuse.h b/include/uapi/linux/fuse.h
> index 8753de7eb189..e57244c03d42 100644
> --- a/include/uapi/linux/fuse.h
> +++ b/include/uapi/linux/fuse.h
> @@ -244,6 +244,7 @@
>   *  7.46
>   *  - add FUSE_URING_BUFRING flag
>   *  - add fuse_uring_cmd_req init struct
> + *  - add FUSE_URING_PINNED_HEADERS flag
>   */
> =20
>  #ifndef _LINUX_FUSE_H
> @@ -1306,6 +1307,7 @@ enum fuse_uring_cmd {
> =20
>  /* fuse_uring_cmd_req flags */
>  #define FUSE_URING_BUFRING		(1 << 0)
> +#define FUSE_URING_PINNED_HEADERS	(1 << 1)
> =20
>  /**
>   * In the 80B command area of the SQE.

Reviewed-by: Jeff Layton <jlayton@kernel.org>
