Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 060D041C2FB;
	Tue, 10 Mar 2026 11:30:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773142206; cv=none; b=Rkz5/zHdwMhiYTM82AjX29jC9MthcCvjSPXydM7V2mDh1eFq/5FAvbcmoGu/V7eBlIFdkCwvsdw9Vaq5xjH83sWzWwccWvuiUGcAZHpGqc7FpV9OTm2Zx15D5NP5fIgPd7tgRJttzDDgMoonr3+Y6/H1gbsUIVCnL6d08mmtUtM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773142206; c=relaxed/simple;
	bh=CSgXfFw0GviOYmYdmkj2X2tkQkA8M2z2vqopfIwOOEo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=csQ3GZJBORY3zLE0IIZdiGTsDWhnPn0E54vsl7RDnGAtN6Ulga4tqkBUxGgr0pLveOA03/hWAaqKE+jPpdLOI5jmybONexDWEVey1SV9/LTEvy3bdHXuoo8p3f3i//8170KUHnlmdb/I39Cvo15xkoGK7JLKyn2M18wmHeedjPU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=P7qBKvJv; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="P7qBKvJv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C6C78C19423;
	Tue, 10 Mar 2026 11:30:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773142205;
	bh=CSgXfFw0GviOYmYdmkj2X2tkQkA8M2z2vqopfIwOOEo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=P7qBKvJvUr8NaPZru5tevNvqqS1CGR2GCylJMncVmgiDe0U2+VYf7KI2tcks10p6l
	 sK4lyFRwz+uAfZJhjz2vSO6sPqdSYecAX5aDytcjXw9oB9DNLf8YnyJdnaHglmzXBM
	 APPt+OWEg2A2guzl4wCDcL3nr17C0jKX9Evo+mXXZ6b/zXgmM/SEWK30rhrxHI/l9b
	 BrZrC1MTe2JlLUAzjQ9sLiAILL2Sf669JmdMpwu7ogulckqG/wvCik4vZQGZZ7PnFR
	 8346duu9vy31sQTQFAfSsutag07qTh27wSZkkygogGMsxUc6E2mPck9Iy889YYMLk6
	 qplnHGYMP7o/g==
Date: Tue, 10 Mar 2026 12:30:01 +0100
From: Christian Brauner <brauner@kernel.org>
To: Jann Horn <jannh@google.com>
Cc: linux-fsdevel@vger.kernel.org, 
	Linus Torvalds <torvalds@linux-foundation.org>, linux-kernel@vger.kernel.org, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Jens Axboe <axboe@kernel.dk>, Jan Kara <jack@suse.cz>, 
	Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH RFC v2 02/23] fs: add scoped_with_init_fs()
Message-ID: <20260310-wildkatzen-melodie-5ecfe567176b@brauner>
References: <20260306-work-kthread-nullfs-v2-0-ad1b4bed7d3e@kernel.org>
 <20260306-work-kthread-nullfs-v2-2-ad1b4bed7d3e@kernel.org>
 <CAG48ez27WdeHPQWeLaz39n62pFaGoqf3oc-st47qv28mgtQg-g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAG48ez27WdeHPQWeLaz39n62pFaGoqf3oc-st47qv28mgtQg-g@mail.gmail.com>

On Mon, Mar 09, 2026 at 04:19:36PM +0100, Jann Horn wrote:
> On Fri, Mar 6, 2026 at 12:30 AM Christian Brauner <brauner@kernel.org> wrote:
> > Similar to scoped_with_kernel_creds() allow a temporary override of
> > current->fs to serve the few places where lookup is performed from
> > kthread context or needs init's filesytem state.
> >
> > Signed-off-by: Christian Brauner <brauner@kernel.org>
> [...]
> > +static inline struct fs_struct *__override_init_fs(void)
> > +{
> > +       struct fs_struct *fs;
> > +
> > +       fs = current->fs;
> > +       smp_store_release(&current->fs, current->fs);
> > +       return fs;
> > +}
> 
> See my comments on patch 15 - I think you'll have to reorder this
> patch after the introduction of task_struct::real_fs and changing
> procfs to access task_struct::real_fs.
> 
> I'm not sure what the smp_store_release() is supposed to pair with; if
> you get rid of remote access to task_struct::fs as I suggest on patch
> 15, it could be a plain store, otherwise it would have to happen under
> task_lock().

Yes, that's right. I'll remove that.
