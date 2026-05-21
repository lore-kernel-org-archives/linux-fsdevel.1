Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B27D013A3F7;
	Thu, 21 May 2026 15:38:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=82.195.75.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779377909; cv=none; b=KqWu3g5ntBiPCp0QoYvCCntBwtA3G0S7seSyVsSWThS9Lne0tbfoHmRLAu5aFPaUMAy+6qy2rV0VmibH7Ej8lZyN6uIsg3NMa886o53RYo/IwMvjJpcyCO7QnPKzWYRQr7idGJPz/sJvCGfjpiydTMQ8XvOlEQXmSXpbTLgH9Pw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779377909; c=relaxed/simple;
	bh=4wgrl3D8nD9c1Q470J+khwWsDcgO3aS8CNOgqX2uAzE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Sq7zBl9VoUwSk2mcaJHfwB27lw4iCXC/QpyyAI3hgPWNdr3ENzUFS8qZwV/tf3uBeXIOpHOWfdjbaBJGAByOE0u+CvA5akAwkBrboHjuSc84KuIbG6CdlIRFyUU7ijwjmhmi9TP9It5xmbM8wOps9bAhWkDhf2kvGNpOFxKJN3Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=debian.org; dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b=ZKIX/r5D; arc=none smtp.client-ip=82.195.75.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=debian.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b="ZKIX/r5D"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:In-Reply-To:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
	Reply-To:Content-ID:Content-Description;
	bh=BiwGXBDleJnRB76Cc4aUQ3VNDGdC6PSI6jdz2j7NAqU=; b=ZKIX/r5DVwOwU4kv5X03pnBVJr
	+8KKLbccKE98AcjKOajbZi5y1JJyHz8MrRuF4PaKUsJfUkzAMHrKWjJ5DOw4tBWJYdGq1iSPLBeb+
	KNuE3ImhUmmYZSoCIv80tIquz8xC8+rrTDpVzxiVvtjgk+h+fMy0f8ABLfgW6baZXbcWfcEWBo7MX
	0DFCxvjV0H30nZdKi8CprXEzYmTskg8CX/N/oHsiSauqzqdMBzgiHQtgB1OByBZjuireqG7r2Wber
	enbRJOBsIGIf4ICmId+9BrBQpYgzEKsV4OvC2YKW9F7W7YbphYYH5pIVD7wfspeug/a0MvvfcgEUP
	62P5eheQ==;
Received: from authenticated user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <leitao@debian.org>)
	id 1wQ5TV-003z9E-0i;
	Thu, 21 May 2026 15:38:17 +0000
Date: Thu, 21 May 2026 08:38:12 -0700
From: Breno Leitao <leitao@debian.org>
To: Mateusz Guzik <mjguzik@gmail.com>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, 
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, Shuah Khan <shuah@kernel.org>, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	usama.arif@linux.dev, kernel-team@meta.com
Subject: Re: [PATCH 1/2] fs/pipe: bulk pre-allocate pages outside pipe->mutex
 in anon_pipe_write
Message-ID: <ag8lIqhAmJtW4Rtv@gmail.com>
References: <20260515-fix_pipe-v1-0-b14c840c7555@debian.org>
 <20260515-fix_pipe-v1-1-b14c840c7555@debian.org>
 <q37bmptbjr2gysl2g67bqo5axxqor4lsrrnf7ajixxjdrumbup@tgu3kz6kien5>
 <ag3Ty3T24wjn1aFw@gmail.com>
 <CAGudoHGT+8FW9HsN+ymQ2QECVjmwkx=xNQ9=WnjYWirXcA6u4w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAGudoHGT+8FW9HsN+ymQ2QECVjmwkx=xNQ9=WnjYWirXcA6u4w@mail.gmail.com>
X-Debian-User: leitao

On Thu, May 21, 2026 at 02:58:48PM +0200, Mateusz Guzik wrote:
> On Wed, May 20, 2026 at 7:09 PM Breno Leitao <leitao@debian.org> wrote:
> > On Fri, May 15, 2026 at 10:18:19PM +0200, Mateusz Guzik wrote:
> > > This change is quite a hammer.
> >
> > Are you seeing any downside/trade-off with this current approach?
> >
> 
> Well there is a lot to say about the current code to begin with, I'm
> going to refrain from writing long rants here as that's of no use in
> this thread.
> 
> The idea behind the patch has a lot of merit and I'm definitely not
> protesting it or denying there is a problem.

Ack, thanks for the support.

> > Yes. v2 will have anon_get_page_prealloc(pipe, &tpp) doing both:
> > top up to PIPE_PREALLOC_MAX based on tmp_page[] occupancy, and
> > keep the policy in one place.
> >
> 
> Note I lost the 'pipe' word. This definitely needs to be anon_pipe_-prefixed.

Ack!

> As a nit you could sprinkle some predicts in a separate commit,  for
> example "if (!pipe->readers) {" definitely warrants an unlikely().
> 
> The real deal is the following: the wakeup policy is to *always*
> wakeup *all* readers if any data is available and *all* writers if any
> space is available. In case of heavily shared usage this leads to the
> thundering herd problem (and it is causing performance issues with the
> BSD and GNU makes). While this cannot be changed by default, I was
> thinking about an opt-in fcntl which changes to policy to only wake up
> one waiter.

Happy to look at it as a follow-up series once this one lands.

Also, I am not reusing the leftover pages back to pipe->tmp_page, given
I really don't expect to have much leftovers, but, I am happy to do so,
in case you think this would be useful.

Anyway, my reading of the discussion above changed my approach to the
following patch. Is it any better?

Thanks for you suggestions so far,
--breno

commit 2394068de8ee0ab9e582ce9776990ed695397553
Author: Breno Leitao <leitao@debian.org>
Date:   Fri May 15 01:35:13 2026 -0700

    fs/pipe: bulk pre-allocate pages outside pipe->mutex in anon_pipe_write
    
    anon_pipe_write() takes pipe->mutex and then, from the per-iteration
    anon_pipe_get_page() helper, used to call alloc_page(GFP_HIGHUSER |
    __GFP_ACCOUNT) once per page while still holding it. That allocation
    can sleep doing direct reclaim and/or runs memcg charging, which extends
    the critical section and stalls a concurrent reader on the very same
    mutex.
    
    For writes that span more than one full page, bulk pre-allocate up to
    PIPE_PREALLOC_MAX (8) pages with alloc_pages_bulk() before taking
    pipe->mutex. anon_pipe_get_page() consumes from pipe->tmp_page[] first,
    then from the prealloc array, and only falls back to alloc_page() under
    the mutex for writes larger than PIPE_PREALLOC_MAX pages (rare) or for
    single-page writes. Sub-PAGE_SIZE writes are unchanged: the merge path
    handles them without needing a fresh page.
    
    The prealloc array, its count, and the helpers operating on it live in
    struct anon_pipe_prealloc:
    
      - anon_pipe_get_page_prealloc() issues a single alloc_pages_bulk()
        call before the mutex is taken.
      - anon_pipe_free_pages() runs after mutex_unlock() and put_page()s
        any leftover prealloc pages, keeping put_page() off the critical
        section. Leftovers happen when the per-pipe tmp_page[] cache or the
        merge path covered some of what we preallocated, or when the write
        exits early.
    
    This can improve the pipe throughput up to 48% and reduce the latency in
    33%.
    
    Suggested-by: Mateusz Guzik <mjguzik@gmail.com>
    Signed-off-by: Breno Leitao <leitao@debian.org>

diff --git a/fs/pipe.c b/fs/pipe.c
index 9841648c9cf3e..a6441c44f1e3f 100644
--- a/fs/pipe.c
+++ b/fs/pipe.c
@@ -111,7 +111,32 @@ void pipe_double_lock(struct pipe_inode_info *pipe1,
 	pipe_lock(pipe2);
 }
 
-static struct page *anon_pipe_get_page(struct pipe_inode_info *pipe)
+#define PIPE_PREALLOC_MAX 8
+
+struct anon_pipe_prealloc {
+	struct page *pages[PIPE_PREALLOC_MAX];
+	unsigned int count;
+};
+
+/*
+ * Bulk pre-allocate pages outside pipe->mutex. Callers must gate on
+ * total_len > PAGE_SIZE; single-page writes are handled by the in-lock
+ * alloc_page() fallback. Any pages not consumed by the write loop are
+ * freed by anon_pipe_free_pages() after the mutex is dropped.
+ */
+static void anon_pipe_get_page_prealloc(struct anon_pipe_prealloc *prealloc,
+					size_t total_len)
+{
+	unsigned int want = min_t(unsigned int,
+				  DIV_ROUND_UP(total_len, PAGE_SIZE),
+				  PIPE_PREALLOC_MAX);
+
+	prealloc->count = alloc_pages_bulk(GFP_HIGHUSER | __GFP_ACCOUNT,
+					   want, prealloc->pages);
+}
+
+static struct page *anon_pipe_get_page(struct pipe_inode_info *pipe,
+				       struct anon_pipe_prealloc *prealloc)
 {
 	for (int i = 0; i < ARRAY_SIZE(pipe->tmp_page); i++) {
 		if (pipe->tmp_page[i]) {
@@ -121,6 +146,15 @@ static struct page *anon_pipe_get_page(struct pipe_inode_info *pipe)
 		}
 	}
 
+	if (prealloc->count) {
+		unsigned int idx = prealloc->count - 1;
+		struct page *page = prealloc->pages[idx];
+
+		prealloc->pages[idx] = NULL;
+		prealloc->count = idx;
+		return page;
+	}
+
 	return alloc_page(GFP_HIGHUSER | __GFP_ACCOUNT);
 }
 
@@ -139,6 +173,17 @@ static void anon_pipe_put_page(struct pipe_inode_info *pipe,
 	put_page(page);
 }
 
+/* Called after pipe->mutex is dropped, to keep put_page() off the critical section. */
+static void anon_pipe_free_pages(struct anon_pipe_prealloc *prealloc)
+{
+	while (prealloc->count) {
+		unsigned int idx = prealloc->count - 1;
+
+		put_page(prealloc->pages[idx]);
+		prealloc->count = idx;
+	}
+}
+
 static void anon_pipe_buf_release(struct pipe_inode_info *pipe,
 				  struct pipe_buffer *buf)
 {
@@ -438,6 +483,7 @@ anon_pipe_write(struct kiocb *iocb, struct iov_iter *from)
 	ssize_t chars;
 	bool was_empty = false;
 	bool wake_next_writer = false;
+	struct anon_pipe_prealloc prealloc = {};
 
 	/*
 	 * Reject writing to watch queue pipes before the point where we lock
@@ -455,6 +501,18 @@ anon_pipe_write(struct kiocb *iocb, struct iov_iter *from)
 	if (unlikely(total_len == 0))
 		return 0;
 
+	/*
+	 * Bulk pre-allocate pages outside pipe->mutex for writes that span more
+	 * than one full page. alloc_page() with GFP_HIGHUSER may sleep doing
+	 * reclaim and runs memcg charging, so doing it under the mutex
+	 * extends the critical section and stalls the reader. The merge path
+	 * handles sub-PAGE_SIZE writes without a fresh page; single-page and
+	 * >PIPE_PREALLOC_MAX-page writes fall back to alloc_page() under the
+	 * mutex for the remainder.
+	 */
+	if (total_len > PAGE_SIZE)
+		anon_pipe_get_page_prealloc(&prealloc, total_len);
+
 	mutex_lock(&pipe->mutex);
 
 	if (!pipe->readers) {
@@ -512,7 +570,7 @@ anon_pipe_write(struct kiocb *iocb, struct iov_iter *from)
 			struct page *page;
 			int copied;
 
-			page = anon_pipe_get_page(pipe);
+			page = anon_pipe_get_page(pipe, &prealloc);
 			if (unlikely(!page)) {
 				if (!ret)
 					ret = -ENOMEM;
@@ -579,6 +637,7 @@ anon_pipe_write(struct kiocb *iocb, struct iov_iter *from)
 	if (pipe_is_full(pipe))
 		wake_next_writer = false;
 	mutex_unlock(&pipe->mutex);
+	anon_pipe_free_pages(&prealloc);
 
 	/*
 	 * If we do do a wakeup event, we do a 'sync' wakeup, because we
