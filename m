Received: from embla.dev.snart.me (embla.dev.snart.me [54.252.183.203])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6807433CEBB;
	Thu, 18 Jun 2026 19:59:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.252.183.203
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781812749; cv=none; b=tSoSq51pvUTbeHQz11jqcNdmbztvSxD0TcHPIrndN1GjgQ6bJrG0tit6SDPZgp2KK9llc/bHk0U1GdKLd2r0pBMg3WPOrCi/MwNNyr3A3Btmjeof3UqBz0NgI4uelWhAoMU+it0BmxS6sd/IufzKwCC0Ock53R2gvaTHEeDQ51A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781812749; c=relaxed/simple;
	bh=XiB6cOHEz1SakwTX8FF3i4cbFV7tGVBveLL6tt4QM3k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ICQQdi9u5GIq3FBOSA9rzeV+3lapZW1FlOMb7J738FgJobMn1hD2kID28Zs/BbBC0IcKDDeJrN80kY0+rgIohIP/QAEnp1ph3jCeTVFSxCxDa79rcexVTaZ4tnbPP00KqZbaRj+6vCN0Heb+3CLnmJzrKWFqeHtnbaYigm2r7yk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=dev.snart.me; spf=pass smtp.mailfrom=dev.snart.me; dkim=pass (1024-bit key) header.d=dev.snart.me header.i=@dev.snart.me header.b=ZN2QIMdT; arc=none smtp.client-ip=54.252.183.203
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=dev.snart.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dev.snart.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=dev.snart.me header.i=@dev.snart.me header.b="ZN2QIMdT"
Received: from embla.dev.snart.me (localhost [IPv6:::1])
	by embla.dev.snart.me (Postfix) with ESMTP id 59BF31D484;
	Thu, 18 Jun 2026 19:59:05 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 embla.dev.snart.me 59BF31D484
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=dev.snart.me; s=00;
	t=1781812746; bh=XiB6cOHEz1SakwTX8FF3i4cbFV7tGVBveLL6tt4QM3k=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=ZN2QIMdTEklYOaoUiCq/uM2/u7r77E7wVGNZO3FpEyJfNrnAtF+AvCstBYi9Lr3HO
	 jzVu/d6x3B7qpGES/pednC3mnBPONFOfcHEI8xV2qNTGYOXC7t1S5wKjkqFheYIJju
	 CvFF6XnqE0XtC+5HTH0VQscPMjgoQHimoo+rthII=
Received: from [192.168.1.18] ([182.226.25.243])
	by embla.dev.snart.me with ESMTPSA
	id HJjxBAlONGompQYA8KYfjw
	(envelope-from <dxdt@dev.snart.me>); Thu, 18 Jun 2026 19:59:05 +0000
Message-ID: <f6318cff-3c74-48fe-9297-368386b3251b@dev.snart.me>
Date: Fri, 19 Jun 2026 04:59:04 +0900
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] exfat: implement swap activate
To: Andrea Cervesato <andrea.cervesato@suse.de>,
 Namjae Jeon <linkinjeon@kernel.org>, Sungjong Seo <sj1557.seo@samsung.com>,
 Yuezhang Mo <yuezhang.mo@sony.com>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
 jack@suse.cz, chrubis@suse.cz, Andrea Cervesato <andrea.cervesato@suse.com>
References: <20260618-exfat_swap_activate-v1-1-4c6a465df295@suse.com>
From: David Timber <dxdt@dev.snart.me>
Content-Language: en-US, ko
Autocrypt: addr=dxdt@dev.snart.me; keydata=
 xjMEYmJg1hYJKwYBBAHaRw8BAQdAf5E+ri1XLtjqYbZdHOyc8oS+1/XJ5bSlbx5WHXmVBZzN
 IERhdmlkIFRpbWJlciA8ZHhkdEBkZXYuc25hcnQubWU+wpQEExYKADwWIQQn/Jn96EMUaIoF
 X+T/ldyyrZpWaAUCYmJg1gIbAwULCQgHAgMiAgEGFQoJCAsCBBYCAwECHgcCF4AACgkQ/5Xc
 sq2aVmjJZwD8COjPlUwccrlRvbNQ6f87DWchtYO0o8W2DNRM3RLps0EA/jEhIbRV6AsyC8jr
 30Ut3aJ3/mO/6G4sLj7OvkEEBH0MzjgEYmJg1hIKKwYBBAGXVQEFAQEHQFpgtIgaByv9lIEY
 EmpavMO0pYjtu7TMJynwdnGYkN9LAwEIB8J4BBgWCgAgFiEEJ/yZ/ehDFGiKBV/k/5Xcsq2a
 VmgFAmJiYNYCGwwACgkQ/5Xcsq2aVmhFCwEA0kM9VyYB4bLCM7+SuXUUH+5Ec99Nj4RXxFad
 Key9GuwA/2BZK6bNyrLSfEk2JDRoskqf7OIL0wa6JOD5SrBnMe8E
In-Reply-To: <20260618-exfat_swap_activate-v1-1-4c6a465df295@suse.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 6/18/26 18:33, Andrea Cervesato wrote:
> From: Andrea Cervesato <andrea.cervesato@suse.com>
>
> exfat's fallocate allocates clusters without updating valid_size,
> leaving them invisible to bmap(). Extend valid_size to i_size so
> that generic_swapfile_activate() can map all blocks.
>
> This bug has been found during a Linux Test Project regression test
> using swapon/swapoff testing suite.
>
> Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
> Fixes: bf1797960c20 ("exfat: add fallocate FALLOC_FL_ALLOCATE_RANGE support")
> Link: https://patchwork.ozlabs.org/project/ltp/patch/20260608155241.270875-1-japo@linux.ibm.com/
> ---
> bf1797960c20 - ("exfat: add fallocate FALLOC_FL_ALLOCATE_RANGE support")
> introduces fallocate() support in exfat, but omits the swap activate
> implementation, causing EINVAL inside Linux Test Project swapon/swapoff
> testing suites which are testing these syscalls with many filesystems,
> including exfat.
>
> This turned out to be a bug inside the kernel. The patch implements
> swap activate in order to ensure that exfat valid_size is correctly
> updated and the generic_swapfile_activate() doesn't fail with EINVAL
> due to valid_size=0, which is passed to bmap().
> ---
>  fs/exfat/exfat_fs.h |  1 +
>  fs/exfat/file.c     |  2 +-
>  fs/exfat/inode.c    | 23 +++++++++++++++++++++++
>  3 files changed, 25 insertions(+), 1 deletion(-)
>
> diff --git a/fs/exfat/exfat_fs.h b/fs/exfat/exfat_fs.h
> index aff4dcd4e75a55296d536c19306813a566d6f0bb..18382c661d4358f8b80e6f7b5032a356a5905614 100644
> --- a/fs/exfat/exfat_fs.h
> +++ b/fs/exfat/exfat_fs.h
> @@ -489,6 +489,7 @@ int exfat_trim_fs(struct inode *inode, struct fstrim_range *range);
>  
>  /* file.c */
>  extern const struct file_operations exfat_file_operations;
> +int exfat_extend_valid_size(struct inode *inode, loff_t new_valid_size);
>  int __exfat_truncate(struct inode *inode);
>  void exfat_truncate(struct inode *inode);
>  int exfat_setattr(struct mnt_idmap *idmap, struct dentry *dentry,
> diff --git a/fs/exfat/file.c b/fs/exfat/file.c
> index 91e5511945d11b12658908dc6287fabd572d1d6a..12ed28c3ff896fb545bad58b47cccf808b48618d 100644
> --- a/fs/exfat/file.c
> +++ b/fs/exfat/file.c
> @@ -642,7 +642,7 @@ int exfat_file_fsync(struct file *filp, loff_t start, loff_t end, int datasync)
>  	return blkdev_issue_flush(inode->i_sb->s_bdev);
>  }
>  
> -static int exfat_extend_valid_size(struct inode *inode, loff_t new_valid_size)
> +int exfat_extend_valid_size(struct inode *inode, loff_t new_valid_size)
>  {
>  	int err;
>  	loff_t pos;
> diff --git a/fs/exfat/inode.c b/fs/exfat/inode.c
> index 1ea4c740fef9ef6932a75e122e1b0130c85533b2..5a395851062e4a14b456fa79546541227d8427e6 100644
> --- a/fs/exfat/inode.c
> +++ b/fs/exfat/inode.c
> @@ -11,6 +11,7 @@
>  #include <linux/time.h>
>  #include <linux/writeback.h>
>  #include <linux/uio.h>
> +#include <linux/swap.h>
>  #include <linux/random.h>
>  #include <linux/iversion.h>
>  
> @@ -534,6 +535,27 @@ int exfat_block_truncate_page(struct inode *inode, loff_t from)
>  	return block_truncate_page(inode->i_mapping, from, exfat_get_block);
>  }
>  
> +static int exfat_swap_activate(struct swap_info_struct *sis,
> +			       struct file *file, sector_t *span)
> +{
> +	struct inode *inode = file_inode(file);
> +	struct exfat_inode_info *ei = EXFAT_I(inode);
> +	int ret;
> +
> +	/*
> +	 * exfat's fallocate allocates clusters without updating valid_size,
> +	 * leaving them invisible to bmap(). Extend valid_size to i_size so
> +	 * that generic_swapfile_activate() can map all blocks.
> +	 */
> +	if (ei->valid_size < i_size_read(inode)) {
Also, if we want to do this, please ensure that ei->valid_size is cached
in by locking the inode or etc before referencing it.

I'll see if I can make exfat_extend_valid_size() interruptible by
placing missing fatal_signal_pending(current) check in both stable and
iomap branches.

Davo
