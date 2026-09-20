Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16DD23DDAFD;
	Sun, 20 Sep 2026 11:29:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789903760; cv=none; b=bt6swPyV2peo7a7dF0dBDE8m1Go0DI3BKPfDLQbi2moBLoKD7Ea5nsfPsCFj5fF08MJls1ZbT0bGmbQJvgql5Fb4XIRAiYHZ3CuByktdq/cnGORY6oH3qOgw8eGqpVMBmtD4Um7pEXucxeX3boZ83fAPSP8IG3PQuRjHE4TuEuA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789903760; c=relaxed/simple;
	bh=7Hcp0/OzwntqibpBRHCSzfnUhIke5Wok4uwkEkvWi8Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DexXRR6/PBX4ARk4vJEbCSuaOYqR5aTMVoO84nnlHFxb1YRAkhd2fVMlVb1LvCjKEbfCtms9Jg10JuKjllc/TU99xedQFD4ymAPJortVftIF7TQBJZCHEvqZ9CZDey5pm6ybXMXNVZFmm+vesLLm0AYuKMeQkB06l9TL0m9AzRI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QnDqEQbR; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QnDqEQbR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CCBE01F000FF;
	Sun, 20 Sep 2026 11:29:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789903758;
	bh=3U6uTfmVLXx9LAthbhE05WIU/IQj/WEaffO5SLaljzw=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=QnDqEQbRnCaiNWOiuPvJf4HSsi0883smMjIkM4GhbTLtrvyF/wXRGi45gjiLetOlD
	 30wA82bSRIBi6c8S95TeOLEevXHSoxzFiR0auGxKan+3XqNlG7QOI+IKek35cesHmq
	 Z0T6VMCFIYapdI1XY7V6Nm2PTho8+zRlyqEUYtIp5mj65POjftVqGDcbNNnUQi81AL
	 1eNeUDwJ2SmdHKF+5BwV0QpXsn8PNR/yhcQ59+c0uG/aTVL8X5VgZITNx2s/S+ePc/
	 M5BYNM34sH6Gasn3CYNb9V1jggZy6v9m4C9DS5INRP8GcCK2wm9lsgtsI7I7rliSf9
	 3g8dvFIU7E7WQ==
Message-ID: <d64eabce-ebfb-45a6-9ef3-74280dc2c5a3@kernel.org>
Date: Sun, 20 Sep 2026 13:29:15 +0200
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] vboxsf: fix endless write loop and data corruption on
 short copy
To: Kentaro Shiomi <k.shiomi@techhowto.blog>,
 Jori Koolstra <jkoolstra@xs4all.nl>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260919174136.3325-1-k.shiomi@techhowto.blog>
From: Hans de Goede <hansg@kernel.org>
Content-Language: en-US, nl
In-Reply-To: <20260919174136.3325-1-k.shiomi@techhowto.blog>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

+To: Jori Koolstra, who maintains vboxsf now.

Regards,

Hans

On 19-Sep-26 19:41, Kentaro Shiomi wrote:
> vboxsf_write_end() ignores the number of bytes that the generic write
> path managed to copy into the folio: it initialises nwritten with the
> requested length, writes that many bytes to the host and returns the
> requested length even when copied == 0.
> 
> generic_perform_write() then sees status != 0, so it never calls
> fault_in_iov_iter_readable(), advances pos by the full length and loops
> again with an iterator that has not been advanced at all.  The result is
> an endless loop that keeps appending zeroed data to the file (filling up
> the host file system) while flooding the log with
> 
>   WARNING: lib/iov_iter.c:624 at iov_iter_revert+0x1fc/0x270
> 
> because iov_iter_revert() is called with copied - status, i.e. a
> negative value.
> 
> The same accounting bug can silently corrupt data: when the folio is
> already uptodate, the stale part is not zeroed, so a short copy makes
> vboxsf write the old folio contents to the host and report success.
> 
> A short copy is not an error condition - it happens whenever the source
> pages are not faulted in yet, e.g. when writing directly from an mmap of
> another file or from shared memory (virtiofsd does exactly this).
> 
> Return the number of bytes that were actually copied, and reject the
> write entirely when nothing was copied so that the generic code faults
> the source pages in and retries.
> 
> Signed-off-by: Kentaro Shiomi <k.shiomi@techhowto.blog>
> ---
> Found while running a nested VM (QEMU/KVM) inside a VirtualBox guest: the
> virtiofsd instance exporting a directory that lives on a vboxsf mount writes
> straight from the shared guest memory, so the source pages are not faulted in
> and every write takes the short-copy path.  Creating a 6-byte text file grew
> the file to 29 KB within seconds and a small PNG reached 202 MB before the VM
> was killed; the guest ran out of disk space because ~16 GB of logs were
> written in the meantime.
> 
> Reproduced without virtiofsd or nested virtualisation by writing a few bytes
> to a vboxsf file from a PROT_READ mapping (memfd or another file) that has not
> been read yet: with the mapping touched first the write succeeds, without it
> the write never returns and only dies on SIGKILL.
> 
> Tested on Ubuntu 26.04.1 (6.x userspace, kernel 7.0.0-31-generic) as a guest of
> VirtualBox 7.2.16 on a Windows host.  With the patch applied, writes from
> non-faulted pages, partially copied writes and in-place rewrites all produce
> byte-identical files on the host, and the virtiofsd workload completes with no
> kernel warnings.
> 
> While investigating I also hit an unrelated NULL pointer dereference in
> vboxsf_release_sf_handle() when opening a vboxsf file with O_DIRECT; that one
> will be reported separately.
> 
> A DKMS package with this patch is available at
> https://github.com/kentaro-shiomi/virtualbox-vboxsf-endless-write-loop-fix
>  fs/vboxsf/file.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/vboxsf/file.c b/fs/vboxsf/file.c
> index 7a7a3fbb2..1e9f61883 100644
> --- a/fs/vboxsf/file.c
> +++ b/fs/vboxsf/file.c
> @@ -307,7 +307,7 @@ static int vboxsf_write_end(const struct kiocb *iocb,
>  	struct inode *inode = mapping->host;
>  	struct vboxsf_handle *sf_handle = iocb->ki_filp->private_data;
>  	size_t from = offset_in_folio(folio, pos);
> -	u32 nwritten = len;
> +	u32 nwritten = copied;
>  	u8 *buf;
>  	int err;
>  
> @@ -315,6 +315,10 @@ static int vboxsf_write_end(const struct kiocb *iocb,
>  	if (!folio_test_uptodate(folio) && copied < len)
>  		folio_zero_range(folio, from + copied, len - copied);
>  
> +	/* Nothing copied: reject so generic_perform_write() faults in and retries */
> +	if (!copied)
> +		goto out;
> +
>  	buf = kmap(&folio->page);
>  	err = vboxsf_write(sf_handle->root, sf_handle->handle,
>  			   pos, &nwritten, buf + from);

