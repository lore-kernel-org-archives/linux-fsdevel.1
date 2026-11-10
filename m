Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=82.195.75.108
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794314794;
	b=aRaI0IPvX9fyzGNU8z4rhW6vsYmUikMSuIZ9wiS3ylxHTqTH3yyhfChTCoWroWl29FbI
	 AWRgRL5f4iHpPJH5CXv72rHjcJE3gIUH8STUQ/IVxUW7c6H544KJsozh045diO53jJze5
	 G5VquAFz2ShpvKhVLJZ1heY+ENwkf4eSNfTyecuFCEF4o/YzmnxqxYzCINPwcu/c8MjTK
	 vRZ+Zyyd1dUU7TnzIr+0MVeMVI2u+MHXC2jmD6Poeu9epctVHA0u2NVQqPtV/g2+FryCW
	 yVEQ8OaF0dD29MbHdj1wJrW8ULgAfbn3YJ7/4nKwelEWcNMvGvB2rrzMMKz5S4qCXYA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794314794;
	h=DMARC-Filter:DKIM-Signature:Received:Date:From:To:Cc:Subject:
	 Message-ID:References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To:X-Debian-User;
	bh=74G19pmPKgFskXMMqzM3YOhI7qcVhKFNeIMLbYsSlng=;
	b=UXnvbmZyx2FN5clTFm9aIQVbYaBk4xiErY5kIVks7Z3PL6EiVLR97fNSIhqGxD//ooQH
	 XPtxVF4JS9YNBE/CHqr3uzNGw44UPfQI0CAyfFjvY8kqqM+/4hK678lEYJqbFsfdU2XG6
	 YFrVySLnCVa7aNaEJE+Bgdc8fnK4hDYd9rid0anxzwsEyrHdwwx1WvRJMsbCUPMD7vuis
	 Zy57U2kJeOwE6L+NV3ts8xosJ445hCGLlEHRwQkuF40gnQNssI5QaqqVwUsNPHXeRGlbm
	 YAIBmKusDZkPsMzaMr72xRf/Q9XzrKc3wbVrE573gJGovV7a5WWIlqmCJ5/0Q6ddMkw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=debian.org;
	spf=pass smtp.mailfrom=debian.org;
	dkim=pass header.d=debian.org header.i=@debian.org header.a=rsa-sha256 header.s=smtpauto.stravinsky header.b=VgZih2zJ;
	arc=none smtp.remote-ip=82.195.75.108
Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1477B606A326;
	Tue, 10 Nov 2026 12:46:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1477B606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=debian.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=debian.org header.i=@debian.org header.a=rsa-sha256 header.s=smtpauto.stravinsky header.b=VgZih2zJ
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=74G19pmPKgFskXMMqzM3YOhI7qcVhKFNeIMLbYsSlng=; b=VgZih2zJbpE1+7Mmc0TTYtTGde
	yt+WciGHO2YL1gnkpV2goaaJOv2m76RK0+5th2x5guoX1uFGRADRIwwNLjUQBH0eZYfOi8KVCul1E
	/qgjMfgOVl9APNaIs41yW6iHw9lFfg+JHBgIfyus+flyyuAd44g6c6e+idAot0F02DMhCHzL75HSn
	v+jpx7YPWeO664rjxkTg6oBIToGyHZuRiZAd9OKgYPd40OAA0W3/NYCHjmKiUzah38MCx/GwHvnfr
	Hm7RtwHbMNe6Vd9prr2PXTNCH5j93+YLCGhLNF+L2Z1Q3sM/CENbm73EecPrMs2JUknVqa3fdCrKl
	G3s4o0vQ==;
Received: from authenticated-user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <leitao@debian.org>)
	id 1xQlF3-00CPQj-0Q;
	Tue, 10 Nov 2026 12:46:25 +0000
Date: Tue, 10 Nov 2026 04:46:21 -0800
From: Breno Leitao <leitao@debian.org>
To: Mateusz Guzik <mjguzik@gmail.com>
Cc: Christian Brauner <brauner@kernel.org>, 
	kernel test robot <yi1.lai@intel.com>, oe-lkp@lists.linux.dev, lkp@intel.com, 
	linux-kernel@vger.kernel.org, Oleg Nesterov <oleg@redhat.com>, linux-fsdevel@vger.kernel.org
Subject: Re: [linus:master] [fs/pipe] f7f4665dc5:
 lmbench3.PIPE.bandwidth.MB/sec 18.5% regression
Message-ID: <avMQxhpHhIPM_6HP@gmail.com>
References: <202611041404.befe64cd-lkp@intel.com>
 <20261105-trommeln-einspannen-radius-ccb4e174e407@brauner>
 <auygOHcuBba_o132@gmail.com>
 <CAGudoHFpNbxL13ZOWiyyLSPpmzXcB=e=RBZ8ZGk+Oc58Aad9pA@mail.gmail.com>
 <au2vjpu_yqNa83pN@gmail.com>
 <CAGudoHF3de_55YvdztPs7QiYs25u6nPEV=uMOzfr=bWmwof69g@mail.gmail.com>
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGudoHF3de_55YvdztPs7QiYs25u6nPEV=uMOzfr=bWmwof69g@mail.gmail.com>
X-Debian-User: leitao

On Fri, Nov 06, 2026 at 02:44:54PM +0100, Mateusz Guzik wrote:
> > 6) Any other idea?
> 
> The SMAP stuff is the primary problem right now. To reiterate: every
> single buffer read/write takes a SMAP trip, which is very expensive
> even on modern uarchs. Refactoring this into i/o under one SMAP round
> would provide a visible speed up. It also happens to not pose a
> tradeoff in terms of memory usage and would be my first avenue of
> attack if I was working on this.
> 
> All that said, one reader vs one writer scenario definitely makes
> sense to optimize.

I've spent some tokens on it, and it seems to give ~5% improvement on
the pipe bench. Is this what you had in mind (in a single patch format)?

commit 724fa7def2700d51a7f0427d0de06c123b3bf8e9
Author: Breno Leitao <leitao@debian.org>
Date:   Mon Nov 9 05:04:45 2026 -0800

    x86/uaccess, fs/pipe: copy a run of pipe buffers in one user access section
    
    Mateusz has been constantly suggesting that The SMAP stuff is the
    primary problem right now in the pipe code, which summarizes to
    anon_pipe_read() copying one pipe_buffer per copy_page_to_iter() call.
    
    On x86 every call opens and closes its own user access section, so a 64
    KiB read that drains a full default pipe executes 16 STAC/CLAC pairs.
    
    The pipe's pages are not contiguous, so the copies stay separate.
    
    Move the body of copy_user_generic() into unsafe_copy_user_generic(),
    which leaves STAC/CLAC to the caller's user access section, and turn
    copy_user_generic() into a STAC/CLAC wrapper around it. The existing
    callers get the same code. (This will eventually be a second patch if/once
    this becomes an non-PoC)
    
    When the destination is a plain user buffer (ITER_UBUF, which is what
    read(2) passes), copy up to PIPE_DEF_BUFFERS consecutive anonymous
    buffers that the read consumes whole inside one scoped user write access
    with unsafe_copy_user_generic(), then release them. The buffers are
    looked up before the section starts, so that only the copies run with
    user access enabled.
    
    What this buys depends on what SMAP costs the CPU. With the buffer by
    buffer loop, booting with clearcpuid=smap speeds pipe_bench up by 4-14%
    on a Sapphire Rapids Xeon Gold 6450C.
    
    pipe_bench from the pipe selftests runs 1, 2 or 5 writers against 1, 5
    or 10 readers on one 1 MiB pipe, with 64 KiB writes and reads.
    Throughput change from this patch, median of 2 boots x 5 runs, SMAP on:
    
                                   Sapphire Rapids
      1 writer, 1 reader                  +5.2%
      5 writers, 10 readers               +8.0%
      all 9 mixes                    +5% to +15%
    
    Suggested-by: Mateusz Guzik <mjguzik@gmail.com>
    Link: https://lore.kernel.org/all/CAGudoHF3de_55YvdztPs7QiYs25u6nPEV=uMOzfr=bWmwof69g@mail.gmail.com/
    Signed-off-by: Breno Leitao <leitao@debian.org>

diff --git a/arch/x86/include/asm/uaccess_64.h b/arch/x86/include/asm/uaccess_64.h
index 20de34cc9aa6e7..28208db6132c27 100644
--- a/arch/x86/include/asm/uaccess_64.h
+++ b/arch/x86/include/asm/uaccess_64.h
@@ -115,10 +115,13 @@ static inline bool __access_ok(const void __user *ptr, unsigned long size)
 __must_check unsigned long
 rep_movs_alternative(void *to, const void *from, unsigned len);
 
+/*
+ * copy_user_generic() without the STAC/CLAC, for several copies inside one
+ * user access section. Returns the number of bytes not copied.
+ */
 static __always_inline __must_check unsigned long
-copy_user_generic(void *to, const void *from, unsigned long len)
+unsafe_copy_user_generic(void *to, const void *from, unsigned long len)
 {
-	stac();
 	/*
 	 * If CPU has FSRM feature, use 'rep movs'.
 	 * Otherwise, use rep_movs_alternative.
@@ -131,6 +134,16 @@ copy_user_generic(void *to, const void *from, unsigned long len)
 		_ASM_EXTABLE_UA(1b, 2b)
 		:"+c" (len), "+D" (to), "+S" (from), ASM_CALL_CONSTRAINT
 		: : "memory", "rax");
+	return len;
+}
+
+#define unsafe_copy_user_generic unsafe_copy_user_generic
+
+static __always_inline __must_check unsigned long
+copy_user_generic(void *to, const void *from, unsigned long len)
+{
+	stac();
+	len = unsafe_copy_user_generic(to, from, len);
 	clac();
 	return len;
 }

diff --git a/fs/pipe.c b/fs/pipe.c
index 4fa69192e6fba1..6f6041c94abefa 100644
--- a/fs/pipe.c
+++ b/fs/pipe.c
@@ -340,6 +340,115 @@ static inline unsigned int pipe_update_tail(struct pipe_inode_info *pipe,
 	return tail;
 }
 
+#ifdef unsafe_copy_user_generic
+/* One buffer of a batched read, looked up before the user access section. */
+struct pipe_copy_src {
+	void *kaddr;
+	size_t len;
+};
+
+/*
+ * Fill @run with the anonymous buffers from @tail on that the read consumes
+ * whole. Returns how many, with their total length in @lenp.
+ */
+static unsigned int anon_pipe_batch_lookup(struct pipe_inode_info *pipe,
+					   unsigned int head, unsigned int tail,
+					   size_t total_len,
+					   struct pipe_copy_src *run,
+					   size_t *lenp)
+{
+	struct pipe_buffer *buf;
+	size_t len = 0;
+	unsigned int n;
+
+	for (n = 0; n < PIPE_DEF_BUFFERS && tail + n != head; n++) {
+		buf = pipe_buf(pipe, tail + n);
+		if (buf->ops != &anon_pipe_buf_ops ||
+		    (buf->flags & PIPE_BUF_FLAG_PACKET) ||
+		    buf->len > total_len - len)
+			break;
+		run[n].kaddr = page_address(buf->page) + buf->offset;
+		run[n].len = buf->len;
+		len += buf->len;
+	}
+	*lenp = len;
+	return n;
+}
+
+/*
+ * Copy the @n buffers in @run, @len bytes in all, to @to inside one user
+ * access section. All or nothing: @to only advances if no copy faults.
+ */
+static bool anon_pipe_batch_copy(struct iov_iter *to,
+				 const struct pipe_copy_src *run,
+				 unsigned int n, size_t len)
+{
+	const struct pipe_copy_src *r, *end = run + n;
+	char __user *dst = to->ubuf + to->iov_offset;
+	size_t off;
+
+	if (should_fail_usercopy())
+		return false;
+	might_fault();
+	for (r = run, off = 0; r < end; off += r->len, r++)
+		instrument_copy_to_user(dst + off, r->kaddr, r->len);
+	scoped_user_write_access_size(dst, len, fault) {
+		for (r = run, off = 0; r < end; off += r->len, r++)
+			if (unsafe_copy_user_generic((__force void *)dst + off,
+						     r->kaddr, r->len))
+				goto fault;
+	}
+	iov_iter_advance(to, len);
+	return true;
+
+fault:
+	return false;
+}
+
+/* Release the @n buffers from @tail on, which a read consumed whole. */
+static unsigned int anon_pipe_batch_release(struct pipe_inode_info *pipe,
+					    unsigned int head,
+					    unsigned int tail, unsigned int n,
+					    bool *wake_writer)
+{
+	*wake_writer |= pipe_full(head, tail, pipe->max_usage);
+	while (n--)
+		tail = pipe_update_tail(pipe, pipe_buf(pipe, tail), tail);
+	return tail;
+}
+
+/*
+ * Copy a run of anonymous buffers that the read consumes whole to a plain
+ * user buffer inside one user access section, instead of one STAC/CLAC pair
+ * per buffer. Returns the bytes consumed, or 0 to go buffer by buffer.
+ */
+static ssize_t anon_pipe_read_batch(struct pipe_inode_info *pipe,
+				    struct iov_iter *to, size_t total_len,
+				    unsigned int head, unsigned int *tailp,
+				    bool *wake_writer)
+{
+	struct pipe_copy_src run[PIPE_DEF_BUFFERS];
+	unsigned int n;
+	size_t len;
+
+	if (!iter_is_ubuf(to))
+		return 0;
+	n = anon_pipe_batch_lookup(pipe, head, *tailp, total_len, run, &len);
+	if (n < 2 || !anon_pipe_batch_copy(to, run, n, len))
+		return 0;
+	*tailp = anon_pipe_batch_release(pipe, head, *tailp, n, wake_writer);
+	return len;
+}
+#else
+static ssize_t anon_pipe_read_batch(struct pipe_inode_info *pipe,
+				    struct iov_iter *to, size_t total_len,
+				    unsigned int head, unsigned int *tailp,
+				    bool *wake_writer)
+{
+	return 0;
+}
+#endif
+
 static ssize_t
 anon_pipe_read(struct kiocb *iocb, struct iov_iter *to)
 {
@@ -347,7 +456,7 @@ anon_pipe_read(struct kiocb *iocb, struct iov_iter *to)
 	struct file *filp = iocb->ki_filp;
 	struct pipe_inode_info *pipe = filp->private_data;
 	bool wake_writer = false, wake_next_reader = false;
-	ssize_t ret;
+	ssize_t ret, batched;
 
 	/* Null read succeeds. */
 	if (unlikely(total_len == 0))
@@ -393,7 +502,16 @@ anon_pipe_read(struct kiocb *iocb, struct iov_iter *to)
 		}
 #endif
 
-		if (!pipe_empty(head, tail)) {
+		batched = anon_pipe_read_batch(pipe, to, total_len, head,
+					       &tail, &wake_writer);
+		if (batched) {
+			ret += batched;
+			total_len -= batched;
+			if (!total_len)
+				break;	/* common path: read succeeded */
+			if (!pipe_empty(head, tail))	/* More to do? */
+				continue;
+		} else if (!pipe_empty(head, tail)) {
 			struct pipe_buffer *buf = pipe_buf(pipe, tail);
 			size_t chars = buf->len;
 			size_t written;



