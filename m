Received: from embla.dev.snart.me (embla.dev.snart.me [54.252.183.203])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1316A3002D8;
	Thu, 18 Jun 2026 18:15:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.252.183.203
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781806516; cv=none; b=eRABWDP2zC7OzNs6LSnuanojUBhiYreZNxMfzNXir31yzEsu6Tf3XbjgHhHSdG1r9RRe87joXAQLrnMxqnDhLplAZVPi/c7pdxdemoynNImAP1U/iZ/7yDVrLeJWxGmoHie/wUUpF0z/PDYXvGXBHko8mi7yopeW5GHUjbuonbQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781806516; c=relaxed/simple;
	bh=X/MnVOmkJ0gI+VUSxWkNomko3RDLFV3r6pvzW3N+R4g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qnM1INfU5A6QJVQqhw2Vt5ydbS/YP/cZeHeat4YD5koJw7fBpUZpBmkhaGHDL5muNF16IsYO3kqi/dmQDoTrmuoPNrtkydtIz49iibZG4DzNPUNg4ErnlPDb1eCwZVw8TTjc9OrtynpDJHDnmrAN9b04dLhYLyRQN7WnTIGZwzU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=dev.snart.me; spf=pass smtp.mailfrom=dev.snart.me; dkim=pass (1024-bit key) header.d=dev.snart.me header.i=@dev.snart.me header.b=HX5L3T3p; arc=none smtp.client-ip=54.252.183.203
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=dev.snart.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dev.snart.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=dev.snart.me header.i=@dev.snart.me header.b="HX5L3T3p"
Received: from embla.dev.snart.me (localhost [IPv6:::1])
	by embla.dev.snart.me (Postfix) with ESMTP id BCC081D484;
	Thu, 18 Jun 2026 18:15:06 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 embla.dev.snart.me BCC081D484
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=dev.snart.me; s=00;
	t=1781806508; bh=X/MnVOmkJ0gI+VUSxWkNomko3RDLFV3r6pvzW3N+R4g=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=HX5L3T3pzoUlYu+rzGtPe38gYhNo5gRPKakfVdMPO5r09XxjHUkACEZgNzjmsCIhy
	 0kTSMSOBbDsdlttNaEzk+OF/AHEMeh+EcCrj6xbuEdVdFsuhAVGWL9DCA67X+wgHBL
	 if5BAt5rO4es3BcbkiQLVRy3WGhJopABzijXrYzw=
Received: from [192.168.1.18] ([182.226.25.243])
	by embla.dev.snart.me with ESMTPSA
	id ZZB7G6o1NGrRnQYA8KYfjw
	(envelope-from <dxdt@dev.snart.me>); Thu, 18 Jun 2026 18:15:06 +0000
Message-ID: <dcd1e216-ab68-4b64-a870-c7c700437151@dev.snart.me>
Date: Fri, 19 Jun 2026 03:15:03 +0900
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
> +		ret = exfat_extend_valid_size(inode, i_size_read(inode));
This incurs uninterruptible write amplification. Say you fallocated()'d
or truncate()'d a 1TB file on a USB stick, it will probably take as long
as it takes to fill the VDL hole. Some people will find that
unacceptible. This is a problem unique to exfat, and not the limitation
of the kernel implementation but rather that of the exfat format itself.
There's nothing we can do about it except somehow we make the write
amplification cases interruptible/cancelable from userspace if need be.

From what I gathered, userland used to dd swap images before doing
mkswap and using them for filesystems without fallocate() support(like
FAT on a live usb stick). Even with the ones that did, there was no
guarantee that the swap would function properly, it was not worth it.

tbh, I genuinely wonder if there's a real use case for using swap images
on exfat. Has any user come forward with this bug with a valid use case?
I think we should ask ourselves if we're patching exfat to just make the
test work rather than fixing the real problems. You can't make
fs-agnostic test cases. Some fs need special treatment, unfortunately.
If we didn't allow that, (x)fstests wouldn't just be possible.

This has been my two cents. Now it's up to maintainers to decide. At the
end of the day, defered write amplification on swapon() could just
become another quirk of exfat.

Davo
