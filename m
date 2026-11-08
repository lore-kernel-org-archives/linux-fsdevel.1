Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=210.171.160.6
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794149775;
	b=sYKSqV6qW2k6mVdZKYLI3j8hNgV1725F0dy+VvoECuvOKpAYN1Em0XAu0c7Y0rrY4nmh
	 VdEuh8aWMlf/GmQnNwC3zBxXL5qJRvrZPQFvwr2algxFVF4dG46tKvyXZENhXY7k0sHcP
	 snoyhp7hDbY6y7cuw2cXlJgx5114a/gN2DEEnonU9lLsAQIHozQjnr2Qu8i+O4Xm0BL2b
	 m2XH9kbmnqKE+Iicw4cX61Pa5K0ola6Q05p1gj1dR4ZbvYUfWF3aAluUm0wFwHF65qSLt
	 Xq1lC1AcD8AjaAmy0n9ndDrCeEeQSMilXwr68iCvrGBQCL0EZBXhTwhHkYPdht3IYOA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794149775;
	h=DMARC-Filter:Received:DKIM-Signature:DKIM-Signature:Received:
	 Received:From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 User-Agent:MIME-Version:Content-Type;
	bh=AO5gXsGyrL2DAPHn3bgk3gqJloxBU64uVV+9Gnhdyjo=;
	b=lp3zdIqVMK8Q2AjMAligCyoyTNiZJNRPPgkztuExm4vB67k8bYoH94MiDWr4y2ZyKv5G
	 +2W4uhBsv5Jyy+5rmrAyCm3Bm5YGK+IoJfLWzgkFR5Ykz7iaaALAjD919S9X9iZDGyJGE
	 iZhukqbYnGckbqirL6p2Oh5mc+qezTJAJUvRTHLBTCPjNZTzg6zipGbdqCsj8hXBO6G1K
	 0y9FWq58FxHFWmiPggDpQXxFEo3DCDx0UXMoI4abOKXdwTDR28lmi+/iGbvwduMdW/796
	 Y5IzlqZTSalJYBgHzHKuAhBXqXsFpLbRyr/JeJMd/UyI8FFinRwt4uFYZ6O3o9hZibg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=mail.parknet.co.jp;
	spf=pass smtp.mailfrom=parknet.co.jp;
	dkim=pass header.d=parknet.co.jp header.i=@parknet.co.jp header.a=rsa-sha256 header.s=20250114 header.b="tFZ1YG/0";
	dkim=pass header.d=parknet.co.jp header.i=@parknet.co.jp header.a=ed25519-sha256 header.s=20250114-ed25519 header.b=1gNAQjyn;
	arc=none smtp.remote-ip=210.171.160.6
Received: from mail.parknet.co.jp (mail.parknet.co.jp [210.171.160.6])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25210606A31C;
	Sun,  8 Nov 2026 14:56:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 25210606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mail.parknet.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=parknet.co.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=parknet.co.jp header.i=@parknet.co.jp header.a=rsa-sha256 header.s=20250114 header.b=tFZ1YG/0;
	dkim=pass header.d=parknet.co.jp header.i=@parknet.co.jp header.a=ed25519-sha256 header.s=20250114-ed25519 header.b=1gNAQjyn
Received: from ibmpc.myhome.or.jp (server.parknet.ne.jp [210.171.168.39])
	by mail.parknet.co.jp (Postfix) with ESMTPSA id 3F4F420BD288;
	Sun,  8 Nov 2026 23:56:12 +0900 (JST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=parknet.co.jp;
	s=20250114; t=1794149772;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=AO5gXsGyrL2DAPHn3bgk3gqJloxBU64uVV+9Gnhdyjo=;
	b=tFZ1YG/0mDHkENWsFTGkYBRqv21VmMOqbPPFVU2btvk5jUtU3qYKHMIbccxqmCy4lDMwTM
	FEOwRL9r4RHHYCoV+9Q0DALtaYe8GxTR7yVXMddiT9B1TLdpBACDKvXigiLRKyAn8wVXTq
	gsmBfLNlEn7rtdgiOBsB1WA+ym2LG213s9vk6WlZmm1B/InRkJMJ7LNHLad3oZSgm+jNml
	evGV5+hrNOZ5f6TY1H80zE0nazvM2FcN9ls6ZkmKTUd5I9YhX9hZQU0oiQkE7HVypg2f6U
	gTVXtTQjSBBS5zJ3DPQcUF4uJkyGzE0NDnbcGGg3Uu8EHo/RypFWtj8H8Hlz0w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=parknet.co.jp;
	s=20250114-ed25519; t=1794149772;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=AO5gXsGyrL2DAPHn3bgk3gqJloxBU64uVV+9Gnhdyjo=;
	b=1gNAQjynlkgaJPTR7SeGIWS3OOwBOeUnhge4y9gdCv78VBrLma1puuhw5sYgGMScmpHAqf
	d1c4eNReTcSewjCg==
Received: from devron.myhome.or.jp (devron.myhome.or.jp [192.168.0.3])
	by ibmpc.myhome.or.jp (Postfix) with ESMTPS id BC4EDE001A6;
	Sun, 08 Nov 2026 23:56:11 +0900 (JST)
Received: by devron.myhome.or.jp (Postfix, from userid 1000)
	id A02E722001DF; Sun, 08 Nov 2026 23:56:11 +0900 (JST)
From: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
To: Matheus Alves de Almeida <matheus.aalmeida@inf.ufrgs.br>
Cc: linux-fsdevel@vger.kernel.org,  brauner@kernel.org,  djwong@kernel.org,
  hch@lst.de,  linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 3/8] fat: add iomap direct I/O support
In-Reply-To: <20261031164326.278125-4-matheus.aalmeida@inf.ufrgs.br>
References: <20261031164326.278125-1-matheus.aalmeida@inf.ufrgs.br>
	<20261031164326.278125-4-matheus.aalmeida@inf.ufrgs.br>
Date: Sun, 08 Nov 2026 23:56:11 +0900
Message-ID: <87mrrjtlro.fsf@mail.parknet.co.jp>
User-Agent: Gnus/5.13 (Gnus v5.13)
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain

Matheus Alves de Almeida <matheus.aalmeida@inf.ufrgs.br> writes:

> Replace the deprecated ->direct_IO() path with ->{read,write}_iter() and
> iomap_dio_rw(). Add fat_file_open() to advertise direct I/O support.
>
> Signed-off-by: Matheus Alves de Almeida <matheus.aalmeida@inf.ufrgs.br>
> ---
>  fs/fat/Kconfig |   1 -
>  fs/fat/fat.h   |   1 +
>  fs/fat/file.c  | 119 ++++++++++++++++++++++++++++++++++++++++++++++++-
>  fs/fat/inode.c |  36 ---------------
>  fs/fat/iomap.c |  24 ++++++++++
>  5 files changed, 142 insertions(+), 39 deletions(-)
>

[...]

> diff --git a/fs/fat/file.c b/fs/fat/file.c
> index c27d4e7f698c..177a26186ddc 100644
> --- a/fs/fat/file.c
> +++ b/fs/fat/file.c
> @@ -201,11 +201,126 @@ int fat_file_fsync(struct file *filp, loff_t start, loff_t end, int datasync)
>  	return blkdev_issue_flush(inode->i_sb->s_bdev);
>  }
>  

[...]

> +static ssize_t fat_file_write_iter(struct kiocb *iocb, struct iov_iter *iter)
> +{
> +	ssize_t ret;
> +
> +	if ((iocb->ki_flags & IOCB_DIRECT) == 0)
> +		return generic_file_write_iter(iocb, iter);
> +
> +	ret = fat_file_dio_write_iter(iocb, iter);
> +	if (ret == -ENOTBLK)
> +		ret = 0;
> +	else if (ret < 0)
> +		return ret;
> +
> +	/* Fall back to buffered I/O if we could not do DIO */
> +	if (iov_iter_count(iter)) {
> +		ssize_t done;
> +
> +		done = fat_file_write_iter_buffered_fallback(iocb, iter);
> +		if (done < 0)
> +			return done;

If fat_file_dio_write_iter() wrote some, this should return ret (how
many written), instead of the error? Or it never happen?

> +		ret += done;
> +	}
> +
> +	return ret;
> +}

Thanks.
-- 
OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
