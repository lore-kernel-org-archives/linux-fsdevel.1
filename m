Received: from smtp03-ext2.udag.de (smtp03-ext2.udag.de [62.146.106.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBD1C377561;
	Fri, 10 Apr 2026 21:56:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.146.106.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775858210; cv=none; b=gCmXlm3zJpilSREvPsiiplEyrTd+4mFLroxevtWgLxxrBAPRBFnd8xgyyMbPcbim3xk8GdfzApT/EYnMZ5RKhP5CxMPkf/j29REjLUNKpTQR5eN0UwTiDXG3iP002aDjSSeSm1sm1c9QPNakWLAPFx5hRA715J3frDRdGopIm/I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775858210; c=relaxed/simple;
	bh=z3Ev7tO/Cz5kcZdXrQTDKcOqxFiXfAHhtBFhGLLVMPg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gi31pO2Bvo3qu/xrbFteSan/1BFYhauxa7KWI2zVbB+0LuIGVFEhUDe4PcHYepzm1LmhFtUEeCpiH+AQpX7IhfTfiGfDVNiJRWtFqaLsFEltTXlsP+9eoqB5fN7bi+kzan8fqv6kzUCyS6ahN02vZV54JA8wg6qfyWC7+YuFJnE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=birthelmer.de; spf=pass smtp.mailfrom=birthelmer.de; arc=none smtp.client-ip=62.146.106.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=birthelmer.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=birthelmer.de
Received: from localhost (113-140-067-156.ip-addr.inexio.net [156.67.140.113])
	by smtp03-ext2.udag.de (Postfix) with ESMTPA id 4D43AE05AA;
	Fri, 10 Apr 2026 23:49:11 +0200 (CEST)
Authentication-Results: smtp03-ext2.udag.de;
	auth=pass smtp.auth=birthelmercom-0001 smtp.mailfrom=horst@birthelmer.de
Date: Fri, 10 Apr 2026 23:49:10 +0200
From: Horst Birthelmer <horst@birthelmer.de>
To: Joanne Koong <joannelkoong@gmail.com>
Cc: Bernd Schubert <bernd@bsbernd.com>, Bernd Schubert <bschubert@ddn.com>, 
	Miklos Szeredi <miklos@szeredi.hu>, linux-fsdevel@vger.kernel.org, Jian Huang Li <ali@ddn.com>, 
	stable@vger.kernel.org, Horst Birthelmer <hbirthelmer@ddn.com>
Subject: Re: Re: Re: Re: [PATCH 0/2] fuse: Fix possible memleak at startup
 with immediate teardown
Message-ID: <adlpMVjXfOKyIUPr@fedora>
References: <20251021-io-uring-fixes-cancel-mem-leak-v1-0-26b78b2c973c@ddn.com>
 <4b5a8040-b62c-4d75-a474-70d0b4759461@bsbernd.com>
 <CAJnrk1ZohxcDERszbii8ZM0g1ZzTwk6+wEqRWpCoSwBXzgavkg@mail.gmail.com>
 <adiiTGjP1tqZfIrI@fedora>
 <CAJnrk1Y37_=OtwZHK_-AEN9Fysoi8VapeiQmv-xxvWjZJZn8+Q@mail.gmail.com>
 <adlE6dSPAlMH-ek-@fedora>
 <CAJnrk1acOQ4vm0bj+uLsx7vRodcwJBbfxjY=mn0BJ_j_eMr11Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJnrk1acOQ4vm0bj+uLsx7vRodcwJBbfxjY=mn0BJ_j_eMr11Q@mail.gmail.com>

On Fri, Apr 10, 2026 at 01:09:36PM -0700, Joanne Koong wrote:
> 
> Gotcha, thanks for clarifying.
> 
> Without the original patch, can queue_refs still be 0 by the time
> fuse_abort_conn() is called? The only case where I see that is when
> the sqes are in the middle of being registered but haven't grabbed the
> queue ref yet, and then the abort logic runs (I am going to write more
> about this race in a reply to Bernd's other message in this thread),
> but other than that I don't see how without the original patch we run
> into this case since teardown -> queue ref decrement only happens in
> fuse_uring_stop_list_entries() which only is triggered on the abort
> path. Are you talking about a subsequent fuse_abort_conn() call (the
> one called from fuse_dev_release())?
> 

To your first question if this can happen without the patch.
I have not seen it but the async teardown of the entry could run before
fuse_abort_conn() could it not?

With the patch the stack usually looks something like

Daemon Process Exit
  └─> io_uring_task_cancel()
      └─> io_uring_cancel_generic(true, NULL)
          └─> io_uring_try_cancel_requests(ctx, current, true)
              └─> io_uring_try_cancel_uring_cmd(ctx, task, true) 
                  └─> file->f_op->uring_cmd(cmd, IO_URING_F_CANCEL) 
                      └─> fuse_uring_cmd(cmd, IO_URING_F_CANCEL) 
                          └─> fuse_uring_cancel(cmd, issue_flags)
                              └─> fuse_uring_entry_teardown(ent, issue_flags) 

And this runs before fuse_abort_conn().

Without the patch fuse_uring_cancel() does not call fuse_uring_entry_teardown() directly.
You are completely right in the current version there is no other call to 
fuse_uring_stop_queues() than the one in Fuse_uring_abort().

So yes, without the modification there is no way queue_refs == 0 by the time
fuse_abort_conn() runs.

To your second question. 
Yes I meant fuse_dev_release().

> 
> Thanks,
> Joanne
> >

Thanks,
Horst
