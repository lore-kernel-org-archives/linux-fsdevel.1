Received: from mx.kolabnow.com (mx.kolabnow.com [185.254.79.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1530813AA2D;
	Mon, 15 Jun 2026 08:40:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.254.79.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781512861; cv=none; b=XIwm0eY3FA9nAHV5VdsLQPnakuq6tTxgaGcW2a8S2cKw9TM7Ac6s0I+qwY/hhQt9oj8lXjBRkq4jjWZiw+UEse9CP+N81X/WlueCy4nYpHMZEJHsuYcvAypmRw4LY8vctIM5PK5Kswu2x/9e/Oj4m4oy/UEkx4nMiSMiVLdDfD0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781512861; c=relaxed/simple;
	bh=JRk/4ZN6yP/KjfQtCaRcaXEj2Qj2XDtUv/mY9bLApD4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XsxNhE63eQ0o/3nsR7JFHrzK3E98dlCii000JdHw8W5WvGoOPGbCdQnTq6qnOdjAqrx03gyjvyNYSJJAUPhkhflzhS8VFVD+tZrEg2sbDx/s8KHdPXd0nNA5WK+eTE/y6QbiZz2soPTalmlRwbdMfDT2OexxMGPI07KPzMiF1cY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hansg.org; spf=pass smtp.mailfrom=hansg.org; dkim=pass (2048-bit key) header.d=hansg.org header.i=@hansg.org header.b=Bzocm7jo; arc=none smtp.client-ip=185.254.79.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hansg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hansg.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hansg.org header.i=@hansg.org header.b="Bzocm7jo"
Received: from postfix.kolabnow.com (unknown [10.17.5.252])
	by mx.kolabnow.com (Postfix) with ESMTPS id BE25BF607E;
	Mon, 15 Jun 2026 10:34:10 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=hansg.org; h=
	content-transfer-encoding:content-type:content-type:in-reply-to
	:content-language:from:from:references:subject:subject
	:mime-version:date:date:message-id; s=dkim2; t=1781512450; x=
	1782376451; bh=JRk/4ZN6yP/KjfQtCaRcaXEj2Qj2XDtUv/mY9bLApD4=; b=B
	zocm7joy/qVw69ar5E3kd4G13T8Oi1ZFKU8vrExQZ9i9uF/lhRFsZc2KS9F48p2P
	NYYJ/77CdgsKCo+MXLS34atE775ztlq/TS2DSJjWT5EAxmwio7I0NV9h0AKmyFeg
	0hMtiql8SG6mTJjxdMZ79KdTbO5eU9BWgjFcu+Uj/e8MMuBhkYl4o29UCWMcNuYz
	SotqZ7IN1c10afGYgRARCZfnPe6FfuKahTTr4DcFxfm4Z6fQq3jIftpWGpIJKTqq
	Ejc/KXN1fsQPBI85koFfvbhTpKRohDSSWx0sk+9ERddZ9U41hE4cGut8dNZhro78
	8hBenAMyxhAR65CLKttmw==
Message-ID: <afece0e2-84cb-4240-8722-0f8453dbd40a@hansg.org>
Date: Mon, 15 Jun 2026 10:34:04 +0200
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: MAINTAINERS: take over vboxsf from Hans de Goede
To: Jori Koolstra <jkoolstra@xs4all.nl>,
 Christian Brauner <brauner@kernel.org>, Al Viro <viro@zeniv.linux.org.uk>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-kernel@vger.kernel.org,
 "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
References: <20260614191040.3007723-1-jkoolstra@xs4all.nl>
From: Hans de Goede <hans@hansg.org>
Content-Language: en-US, nl
In-Reply-To: <20260614191040.3007723-1-jkoolstra@xs4all.nl>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Jori, et al.,

On 14-Jun-26 21:10, Jori Koolstra wrote:
> I talked to Hans de Goede about two weeks ago in person. He expressed he
> would rather have someone else maintain vboxsf and was thinking about
> orphaning it. Since I am already doing filesystem stuff anyway, I am
> fine with doing this. (vboxsf is a thin layer between the vfs and the
> Virtual Box guest device driver).
> 
> I have no major plans for vboxsf, but I do want to support passing
> physical addresses to the host; the communication protocol seems to
> allow for it and it would mean we can get rid of some kmap calls.
> 
> Signed-off-by: Jori Koolstra <jkoolstra@xs4all.nl>

Right, as Jori said I really haven't had time to work on this
for the last year(s) so I was considering orphaning this.

I'm happy to see someone else take this over:

Acked-by: Hans de Goede <johannes.goede@oss.qualcomm.com>

Regards,

Hans




> ---
>  MAINTAINERS | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index c8d4b913f26c..0b75202eb9c6 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -28390,7 +28390,7 @@ F:	include/linux/vbox_utils.h
>  F:	include/uapi/linux/vbox*.h
>  
>  VIRTUAL BOX SHARED FOLDER VFS DRIVER
> -M:	Hans de Goede <hansg@kernel.org>
> +M:	Jori Koolstra <jkoolstra@xs4all.nl>
>  L:	linux-fsdevel@vger.kernel.org
>  S:	Maintained
>  F:	fs/vboxsf/*

