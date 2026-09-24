Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F2FB4AF67B;
	Thu, 24 Sep 2026 18:41:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790275274; cv=none; b=Rz2ehrImRORiiLDekhv/Zz9jckwNd741mp0JVY+6R4kvOBl/AT77ePzk080vGwGjaZP7y8pCYa4cOK+ylc9Ffro8oIWoM7crO2M4VdmxF/+GKPWSSptIUh6P3e65Z7dT5oC8yK+yoxHK8aJj2qpqoyQy4WWsa99Guz8N05k/ltQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790275274; c=relaxed/simple;
	bh=6ndVrRIy51AGmbVgCkfLIqLQv0hsl6Y4OhT02ryJ2zk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=b1favDo1vd1dKofFuK75uP2J4H+Bo7RGKd8nzQgXbsiww90NWOqsyLGQknyHPSSPBt+L/NjdAvD9EoOw01/e/4N0h7gOvSU54zZiZWpxfjw7TjSxqzU1X1OC2A5Cezi28Lo9cLtkwIqZq983L22qs+dg96fX/TdLRjpvURZgDnQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fmb5faaU; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fmb5faaU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EE07E1F00893;
	Thu, 24 Sep 2026 18:41:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790275273;
	bh=ybl7q68jsdIc+tMHDO8l+eHsv2NxMbejfctGTO/viNw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=fmb5faaU//RDFv2xEnXo7Frf3s9Ce/tSq+lvg53e1C9BvKeC9AwEmqi5bWSFHXCNt
	 ur1WU19Ny1cQsdPhkwpa2cdNM1w5ll12ae7/f4mIBLTmzE6luDK6IvZmauHJInPkY3
	 rEHqLXtfEnYSPL+H2n1/MvfuGgHsaWzgjKFveGc/xpMNaPM/Y6OlbQnBGjvPHFPzk8
	 1lWM9vFfEOyOep1s+8BiEHJc9H2R7uq3ttPkym3QJcd5kJg/WyaqRD+XM/e/m6HKKt
	 j6QH/Vdb3cq2qzi0qwQhDhFz6bPWJLgloyCm0V2bZRx3E6R3HcAU8fCe61BbsInLm4
	 PxsZsbhpIxYBg==
Date: Thu, 24 Sep 2026 20:41:06 +0200
From: Alexey Gladkov <legion@kernel.org>
To: Joel Granados <joel.granados@kernel.org>
Cc: Kees Cook <kees@kernel.org>, linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	Ondrej =?utf-8?B?TW9zbsOhxI1law==?= <omosnacek@gmail.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Ryan Roberts <ryan.roberts@arm.com>,
	Serge Hallyn <serge@hallyn.com>,
	"Eric W . Biederman" <ebiederm@xmission.com>
Subject: Re: [PATCH RFC 2/4] sysctl: Apply sysctl context when flag is active
Message-ID: <arVuwhdP1WJMk0Fo@example.org>
References: <20260924-lklm-sysctl-headerctx-template-v1-0-b25e51c66ba7@kernel.org>
 <20260924-lklm-sysctl-headerctx-template-v1-2-b25e51c66ba7@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260924-lklm-sysctl-headerctx-template-v1-2-b25e51c66ba7@kernel.org>

On Thu, Sep 24, 2026 at 04:34:10PM +0200, Joel Granados wrote:
> Whenever CTL_TABLE_F_CTX_DATA is set on the entry, overlay the ->data
> entry contained in inst on the entry to be passed to proc_handlers. No
> table sets the flags yet, so there is no functional change.
> 
> Signed-off-by: Joel Granados <joel.granados@kernel.org>
> ---
>  fs/proc/proc_sysctl.c | 27 ++++++++++++++++++++++++++-
>  1 file changed, 26 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/proc/proc_sysctl.c b/fs/proc/proc_sysctl.c
> index fe32337892f9badc897a29e9176e66790003fb05..1ed9f4e1a17e28c5db1d07356390cbee968cb91f 100644
> --- a/fs/proc/proc_sysctl.c
> +++ b/fs/proc/proc_sysctl.c
> @@ -550,12 +550,31 @@ static struct dentry *proc_sys_lookup(struct inode *dir, struct dentry *dentry,
>  	return err;
>  }
>  
> +/* Returns @entry itself when it is not flagged, else a resolved copy in @buf. */
> +static const struct ctl_table *sysctl_apply_ctx(struct ctl_table_header *head,
> +						const struct ctl_table *entry,
> +						struct ctl_table *buf)
> +{
> +	ptrdiff_t off;
> +
> +	if (!(entry->flags & CTL_TABLE_F_CTX_DATA))
> +		return entry;
> +
> +	off = (const char *)entry->data - (const char *)head->ctx.tmpl;
> +
> +	*buf = *entry;
> +	buf->data = (char *)head->ctx.inst + off;
> +
> +	return buf;
> +}

I had to create a more complex version of the context because,
unfortunately, yours approach doesn't cover all current use cases and does
not check the variable's type based on this offset.

In my RFC [1] I showed Linus, I included three illustrative examples (a
simple one, a worse one, and the ugliest one). In the net/mpls/af_mpls.c
we need to have netns and struct mpls_dev in same time [2]. A namespace
alone isn't enough for us. Unfortunately, this isn't the only place where
this approach is used.

Also, I really wanted to avoid dealing with void pointer arithmetic
as much as possible.

A long time ago, Linus had already pointed out to me that having
"void *ctl_data" was a bad solution [3]:

  There is no reason to have some pseudo-generic "void *ctl_data" that
  makes it ambiguous and allows for type confusion and isn't
  self-documenting. I'd rather have a properly typed pointer that is
  just initialized to NULL and is not always used or needed, but always
  has a clear case for *what* it would be used for.
  
  Yes, yes, we have f_private etc for things that are really very very
  generic and have arbitrary users. But 'sysctl' is not that kind of
  truly generic use.

Yes, my version still has similar code, but the offset is calculated at
compile time and a type check is made.

I like my version better because I've checked all the places where the
ctl_table list is cloned, and I know for sure that my version will be able
to handle all those use cases. And, you known, I wrote it :)

But seriously, don't get me wrong, I'm totally fine if you continue with
your version. The main thing is that it should cover all existing
use cases.

[1] https://lore.kernel.org/linux-fsdevel/cover.1788018958.git.legion@kernel.org/
[2] https://web.git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/net/mpls/af_mpls.c#n1429
[3] https://lore.kernel.org/all/b0ccbb2489119f1f20c737cf1930c3a9c4e4243a.1644862280.git.legion@kernel.org/T/#m5d0b462c317f9cd0e772b5df60ec8ceba41dcac0

> +
>  static ssize_t proc_sys_call_handler(struct kiocb *iocb, struct iov_iter *iter,
>  		int write)
>  {
>  	struct inode *inode = file_inode(iocb->ki_filp);
>  	struct ctl_table_header *head = grab_header(inode);
>  	const struct ctl_table *table = PROC_I(inode)->sysctl_entry;
> +	struct ctl_table ctx_entry;
>  	size_t count = iov_iter_count(iter);
>  	char *kbuf;
>  	ssize_t error;
> @@ -567,6 +586,8 @@ static ssize_t proc_sys_call_handler(struct kiocb *iocb, struct iov_iter *iter,
>  	 * At this point we know that the sysctl was not unregistered
>  	 * and won't be until we finish.
>  	 */
> +	table = sysctl_apply_ctx(head, table, &ctx_entry);
> +
>  	error = -EPERM;
>  	if (sysctl_perm(head, table, write ? MAY_WRITE : MAY_READ))
>  		goto out;
> @@ -797,6 +818,7 @@ static int proc_sys_permission(struct mnt_idmap *idmap,
>  	 */
>  	struct ctl_table_header *head;
>  	const struct ctl_table *table;
> +	struct ctl_table ctx_entry;
>  	int error;
>  
>  	/* Executable files are not allowed under /proc/sys/ */
> @@ -810,8 +832,11 @@ static int proc_sys_permission(struct mnt_idmap *idmap,
>  	table = PROC_I(inode)->sysctl_entry;
>  	if (!table) /* global root - r-xr-xr-x */
>  		error = mask & MAY_WRITE ? -EACCES : 0;
> -	else /* Use the permissions on the sysctl table entry */
> +	else {
> +		/* ->permissions may inspect the entry, so resolve it first. */
> +		table = sysctl_apply_ctx(head, table, &ctx_entry);
>  		error = sysctl_perm(head, table, mask & ~MAY_NOT_BLOCK);
> +	}
>  
>  	sysctl_head_finish(head);
>  	return error;
> 
> -- 
> 2.50.1
> 
> 

-- 
Rgrds, legion

