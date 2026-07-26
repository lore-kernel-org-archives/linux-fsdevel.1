Received: from ewsoutbound.kpnmail.nl (ewsoutbound.kpnmail.nl [195.121.94.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D36402848A7
	for <linux-fsdevel@vger.kernel.org>; Sun, 26 Jul 2026 20:50:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.121.94.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785099033; cv=none; b=sD/TrAf6wlqsmcA90VibVVQvBH1kyPD6L/NcWaz3RPpE7RiWVryj1S7GscRIo4n1nIHLlADqVTiNDFyW64ICNQNB5RAonlheaulrx8USIqnkyxjVmnsfgiGigAyb4hoNCrmHPgapiM8gmf+GtlfgWxneGWDkgYMZRKwSU4MJ4N8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785099033; c=relaxed/simple;
	bh=qwQMe/HRz61R1w7YPZ+pHzfk3+s3Vt9kQrT+hrYKY1Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pjEItJ3upm2f4pDiDjMdv3OqSUcOSuPm+HK27BRcof573p+AA15CX5+3Bnu/boI4AF7IMYh3COmztFWGm4i+f4aVZmjjug7A9z7J8tpjqh2lynAblOmT1d0ehMDxv8aPLwMM/OmILpjpZVJWDWcB9d6dZidc2O1DaV3dQR7++Ok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xs4all.nl; spf=pass smtp.mailfrom=xs4all.nl; dkim=pass (2048-bit key) header.d=xs4all.nl header.i=@xs4all.nl header.b=ZR6jAUFO; arc=none smtp.client-ip=195.121.94.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xs4all.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xs4all.nl
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=xs4all.nl header.i=@xs4all.nl header.b="ZR6jAUFO"
X-KPN-MessageId: 9cafce0c-8933-11f1-8f54-005056992ed3
Received: from smtp.kpnmail.nl (unknown [10.31.155.5])
	by ewsoutbound.so.kpn.org (Halon) with ESMTPS
	id 9cafce0c-8933-11f1-8f54-005056992ed3;
	Sun, 26 Jul 2026 22:50:19 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=xs4all.nl; s=xs4all01;
	h=content-type:mime-version:message-id:subject:to:from:date;
	bh=9yiqbmKagn6IAd1xKde9X32jMmpKwE6RTxFUDy3dAT4=;
	b=ZR6jAUFOK3BStmj2H3L2p0B/Cq5GJKNW8OIEVbmiJRFHGZNuMUWIJRC32xfapIDhe/KRpwA8ERbau
	 OMfYAG+y77JbSgZdBRTYefnpamkgBfN0YDVBuPwdLLZ8JpKdWMDPmhjvAcV2PjQ6YHzf7XhAXuYohs
	 si9SoerYPXMWfiknJ+8rOrRSdH6zEastUpw6qT/IM74ZeAb+a8vjnerSK5CyrSCxcAMCFlhTDe/QCu
	 vFfSEE1Y+WzUoo7IDgBxWb5/DrNH0YgrqeALdGnbH6HKKwjPJNtLUb97onzeDRfxvHQTTFiCTBgUzp
	 dMMxy6qbX4Wxx0BJMSj+gWHP4kksv9Q==
X-KPN-MID: 33|Y0AXcPB6hyAOD2TG/96ENkqIjZJDLd407Q1agGDvyRdLRRntAkCPrqmNlxUdkpo
 YlMl7RIYQLieoktQ9mKFYZA==
X-KPN-VerifiedSender: Yes
X-CMASSUN: 33|+Z21vaTBTRuW3jxhHED9DxMsyVH44TvP5PeQHtjC6iHxg4aJKV+UB6e4RPFom8Z
 /XHScnPbe8JOLq4HDlydo0w==
Received: from localhost (unknown [178.226.150.234])
	by smtp.xs4all.nl (Halon) with ESMTPSA
	id 9c8bc361-8933-11f1-87f9-00505699b758;
	Sun, 26 Jul 2026 22:50:18 +0200 (CEST)
Date: Sun, 26 Jul 2026 22:50:13 +0200
From: Jori Koolstra <jkoolstra@xs4all.nl>
To: Christian Brauner <brauner@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, linux-mm@kvack.org, 
	Farid Zakaria <farid.m.zakaria@gmail.com>, jannh@google.com
Subject: Re: [PATCH v3 12/24] binfmt_misc: convert the entry file to seq_file
Message-ID: <amZyqIIbvR8t08HW@lt-jori.localdomain>
References: <20260710-work-binfmt_misc-locking-v3-0-a162f7cb58d6@kernel.org>
 <20260710-work-binfmt_misc-locking-v3-12-a162f7cb58d6@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260710-work-binfmt_misc-locking-v3-12-a162f7cb58d6@kernel.org>

On Fri, Jul 10, 2026 at 11:33:13AM +0200, Christian Brauner wrote:
> Reading an entry file allocates a whole page and formats the status
> into it with a chain of manually advanced sprintf() calls, silently
> relying on MAX_REGISTER_LENGTH plus the hex-expanded magic and mask
> always staying below PAGE_SIZE. Convert the read side to seq_file
> which sizes its buffer as needed and gets rid of the open-coded
> pointer arithmetic including the last bin2hex() user in the file.
> The output is byte for byte identical.
> 
> seq_open() clears FMODE_PWRITE for historical reasons and would
> silently turn pwrite() on entry files into -ESPIPE even though
> bm_entry_write() accepts writes at any offset. Restore the flag in
> bm_entry_open() the same way kernfs does for its seq_file backed
> files so pwrite() keeps working.
> 
> The only user-visible difference is that seeking is now bound by
> seq_lseek() instead of default_llseek(), i.e. SEEK_END stops working
> on entry files, which nothing can sensibly use anyway.
> 
> The status file keeps its simple_read_from_buffer() as it only ever
> returns one of two fixed strings.
> 
> Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
> ---
>  fs/binfmt_misc.c | 74 +++++++++++++++++++++++++++++---------------------------
>  1 file changed, 39 insertions(+), 35 deletions(-)
> 
> diff --git a/fs/binfmt_misc.c b/fs/binfmt_misc.c
> index 252e1f2a8347..23a2020d9266 100644
> --- a/fs/binfmt_misc.c
> +++ b/fs/binfmt_misc.c
> @@ -12,7 +12,6 @@
>  
>  #include <linux/kernel.h>
>  #include <linux/module.h>
> -#include <linux/hex.h>
>  #include <linux/init.h>
>  #include <linux/sched/mm.h>
>  #include <linux/magic.h>
> @@ -25,6 +24,7 @@
>  #include <linux/namei.h>
>  #include <linux/mount.h>
>  #include <linux/rculist.h>
> +#include <linux/seq_file.h>
>  #include <linux/fs_context.h>
>  #include <linux/syscalls.h>
>  #include <linux/fs.h>
> @@ -577,40 +577,47 @@ static int parse_command(const char __user *buffer, size_t count)
>  
>  /* generic stuff */
>  
> -static void entry_status(struct binfmt_misc_entry *e, char *page)
> +static void bm_seq_hex(struct seq_file *m, const u8 *data, int size)
>  {
> -	char *dp = page;
> -	const char *status = "disabled";
> +	for (int i = 0; i < size; i++)
> +		seq_printf(m, "%02x", data[i]);
> +}
> +
> +static int bm_entry_show(struct seq_file *m, void *unused)
> +{
> +	struct binfmt_misc_entry *e = m->private;
>  
>  	if (test_bit(MISC_FMT_ENABLED_BIT, &e->flags))
> -		status = "enabled";
> +		seq_puts(m, "enabled\n");
> +	else
> +		seq_puts(m, "disabled\n");
>  
> -	dp += sprintf(dp, "%s\ninterpreter %s\n", status, e->interpreter);
> +	seq_printf(m, "interpreter %s\n", e->interpreter);
>  
>  	/* print the special flags */
> -	dp += sprintf(dp, "flags: ");
> +	seq_puts(m, "flags: ");
>  	if (e->flags & MISC_FMT_PRESERVE_ARGV0)
> -		*dp++ = 'P';
> +		seq_putc(m, 'P');
>  	if (e->flags & MISC_FMT_OPEN_BINARY)
> -		*dp++ = 'O';
> +		seq_putc(m, 'O');
>  	if (e->flags & MISC_FMT_CREDENTIALS)
> -		*dp++ = 'C';
> +		seq_putc(m, 'C');
>  	if (e->flags & MISC_FMT_OPEN_FILE)
> -		*dp++ = 'F';
> -	*dp++ = '\n';
> +		seq_putc(m, 'F');
> +	seq_putc(m, '\n');
>  
>  	if (!test_bit(MISC_FMT_MAGIC_BIT, &e->flags)) {
> -		sprintf(dp, "extension .%s\n", e->magic);
> +		seq_printf(m, "extension .%s\n", e->magic);
>  	} else {
> -		dp += sprintf(dp, "offset %i\nmagic ", e->offset);
> -		dp = bin2hex(dp, e->magic, e->size);
> +		seq_printf(m, "offset %i\nmagic ", e->offset);
> +		bm_seq_hex(m, e->magic, e->size);
>  		if (e->mask) {
> -			dp += sprintf(dp, "\nmask ");
> -			dp = bin2hex(dp, e->mask, e->size);
> +			seq_puts(m, "\nmask ");
> +			bm_seq_hex(m, e->mask, e->size);
>  		}
> -		*dp++ = '\n';
> -		*dp = '\0';
> +		seq_putc(m, '\n');
>  	}
> +	return 0;
>  }
>  
>  static struct inode *bm_get_inode(struct super_block *sb, int mode)
> @@ -695,23 +702,18 @@ static void remove_binfmt_handler(struct binfmt_misc *misc,
>  
>  /* /<entry> */
>  
> -static ssize_t
> -bm_entry_read(struct file *file, char __user *buf, size_t nbytes, loff_t *ppos)
> +static int bm_entry_open(struct inode *inode, struct file *file)
>  {
> -	struct binfmt_misc_entry *e = file_inode(file)->i_private;
> -	ssize_t res;
> -	char *page;
> +	int ret;
>  
> -	page = kmalloc(PAGE_SIZE, GFP_KERNEL);
> -	if (!page)
> -		return -ENOMEM;
> -
> -	entry_status(e, page);
> -
> -	res = simple_read_from_buffer(buf, nbytes, ppos, page, strlen(page));
> +	ret = single_open(file, bm_entry_show, inode->i_private);
> +	if (ret)
> +		return ret;
>  
> -	kfree(page);
> -	return res;
> +	/* seq_open() clears FMODE_PWRITE, bm_entry_write() takes any offset */
> +	if (file->f_mode & FMODE_WRITE)
> +		file->f_mode |= FMODE_PWRITE;
> +	return 0;
>  }
>  
>  static ssize_t bm_entry_write(struct file *file, const char __user *buffer,
> @@ -759,9 +761,11 @@ static ssize_t bm_entry_write(struct file *file, const char __user *buffer,
>  }
>  
>  static const struct file_operations bm_entry_operations = {
> -	.read		= bm_entry_read,
> +	.open		= bm_entry_open,
> +	.read		= seq_read,
>  	.write		= bm_entry_write,
> -	.llseek		= default_llseek,
> +	.llseek		= seq_lseek,
> +	.release	= single_release,
>  };
>  
>  /* /register */
> 
> -- 
> 2.53.0
> 

Reviewed-by: Jori Koolstra <jkoolstra@xs4all.nl>
