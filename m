Received: from ewsoutbound.kpnmail.nl (ewsoutbound.kpnmail.nl [195.121.94.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B8C0367F4D
	for <linux-fsdevel@vger.kernel.org>; Mon, 29 Jun 2026 15:53:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.121.94.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782748389; cv=none; b=GgQeOz4CozdY6IUPB5NcMhOj/yLHy6lf7xXYVU6uNnmUdKgUXaA/s0L28EoauP4++l2qKjvbA7zqem0pgYO8Vmup6BTd90he6PtLM5wgzHAL/PecqBrf57zTfO6VsTI7n5IFJLXwE8smSGzMGMe/GrEQ7jPXlnqouJX9cpZzoLM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782748389; c=relaxed/simple;
	bh=HBKTeC1UYr7Vk89U6ngW2mnqbwXYsD8bAab7Bs4X8WM=;
	h=Date:From:To:Cc:Message-ID:Subject:MIME-Version:Content-Type; b=aPAKb74RMiOAUk5sZxMELEXXjA2RxXppfaKz4dw1HvP/iJVsbnBbtIo0AYHSGlBp9i9JIneZ1VU4Cxkvz7zDWYaV+rCCc3cNIFJNqLpX5Lb1aHFOkJUIjY/SPaDFmy+sbZSn8+9zGvS7eLrQYZEmIPZurYIJEGUpZHKyEbf6Uwk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xs4all.nl; spf=pass smtp.mailfrom=xs4all.nl; dkim=pass (2048-bit key) header.d=xs4all.nl header.i=@xs4all.nl header.b=CYYwjCju; arc=none smtp.client-ip=195.121.94.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xs4all.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xs4all.nl
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=xs4all.nl header.i=@xs4all.nl header.b="CYYwjCju"
X-KPN-MessageId: 9df1d06d-73d2-11f1-8f53-005056992ed3
Received: from mta.kpnmail.nl (unknown [10.31.161.190])
	by ewsoutbound.so.kpn.org (Halon) with ESMTPS
	id 9df1d06d-73d2-11f1-8f53-005056992ed3;
	Mon, 29 Jun 2026 17:53:05 +0200 (CEST)
Received: from mtaoutbound.kpnmail.nl (unknown [10.128.135.190])
	by mta.kpnmail.nl (Halon) with ESMTP
	id 9df0c82a-73d2-11f1-b2f5-0050569977a2;
	Mon, 29 Jun 2026 17:53:05 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=xs4all.nl; s=xs4all01;
	h=content-type:mime-version:subject:message-id:to:from:date;
	bh=qOONzDv5IesMk7FmwRmWzL6ygdLiibOwc8oHhYY7XrQ=;
	b=CYYwjCju+XLArjuTKBz0rrgXA4PLF1scq5Z9TAbxDpheI1kftsve8cZWZubzZzt7lm3S5PF5Psgz/
	 N1wrbUfnted0yFscCXf5Ln5kBMztNOhchSVRRSb8y3skkscFCj4ow7gW/cfmOzyhc/GaqbZouwIxaM
	 kWDY99XmbTddF7l8Fh/LhJIFZ+wtQG3zzJJqRYXHtjrUF2SViD/npnB5qd9rR6aaBI8ZgaoMB8Ip1Q
	 e51pdzWU9Hh9uqpiWtrgftegg5bgyOcCQok6cnlfiudA3bllo8f4khxCDXOcIVdiS0koEYUinR7jRK
	 An3HSbZH8OpsqMhPFpbLmdCX3cZSGtQ==
X-KPN-MID: 33|BaQkabgEHsvisp719waZgGn9YmCzBfLF6CdmDC6kBge5ST+vHdIs5hmt2c/mJhl
 wZT24V09hy0jB+gHTHdAHqYeYlCyAV300xMHTsPvqixY=
X-CMASSUN: 33|yBKuqd4nIaS/wjALx6AA/ZAeyWBS4N0LHbMMZ2RpRUrbo8EFpPBvuB6eefB8n/7
 PNOApHam61ycLPX/T2Yy/PQ==
X-KPN-VerifiedSender: Yes
Received: from cpxoxapps-mh01 (cpxoxapps-mh01.personalcloud.so.kpn.org [10.128.135.207])
	by mtaoutbound.kpnmail.nl (Halon) with ESMTPSA
	id 9ddd7143-73d2-11f1-916a-005056995d6c;
	Mon, 29 Jun 2026 17:53:05 +0200 (CEST)
Date: Mon, 29 Jun 2026 17:53:05 +0200 (CEST)
From: Jori Koolstra <jkoolstra@xs4all.nl>
To: Luis Henriques <luis@igalia.com>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Message-ID: <701701086.3381067.1782748385402@kpc.webmail.kpnmail.nl>
Subject: Re: [PATCH] posix_acl: remove useless code
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Priority: 3
Importance: Normal

On Mon, Jun 29, 2026 at 04:45:54PM +0100, Luis Henriques wrote:
> This is just a trivial clean-up: it removes an unnecessary return branch.
> 
> Signed-off-by: Luis Henriques <luis@igalia.com>
> ---
>  fs/posix_acl.c | 2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/fs/posix_acl.c b/fs/posix_acl.c
> index b4bfe4ddf64e..6df5de23aac4 100644
> --- a/fs/posix_acl.c
> +++ b/fs/posix_acl.c
> @@ -740,8 +740,6 @@ static int posix_acl_fix_xattr_common(const void *value, size_t size)
>  	count = posix_acl_xattr_count(size);
>  	if (count < 0)
>  		return -EINVAL;
> -	if (count == 0)
> -		return 0;
>  
>  	return count;
>  }

Right, well spotted. Feel free to add:

Reviewed-by: Jori Koolstra <jkoolstra@xs4all.nl>
