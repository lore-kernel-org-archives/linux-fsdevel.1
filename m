Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD882156661;
	Mon, 28 Sep 2026 01:21:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790558490; cv=none; b=YYtQPCpSDbfm4oNZdgJHy0l3Bb208mFWKX64E23NytiWm/xZyjFfnNkbyJiRZrgCy1o1GboOrbL6R3gI2RNUYriv5j1WSjkqrmMXZwhILHzSwkWNBdcBJIk6A+CdAibYOkDgtKwU19E2z/scNKih5P/L0GwX1WXoYFl9Zg9SIJ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790558490; c=relaxed/simple;
	bh=223lbBBOBYvHfHswH/+cq71fsL/Rtya9YNwryV9ATqQ=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=tVfMsQqZ6Mpdd0TxQGijOqfsMS5Sq9B9RLAvoYN2LXbYe7Jvn8fw1etNGq6p8kTrQ6eTqN3Z83f0IubTPpW0x6sXkPVjNTv6HV5dSRd0//7DArFm7xuH//vCNh1xU2zE6z8t2C1oSIXY96yZl6K7WEO2TXTgQ25q33EJTnX0BX0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=FlYaT3DA; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="FlYaT3DA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 171201F000FF;
	Mon, 28 Sep 2026 01:21:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux-foundation.org; s=korg; t=1790558489;
	bh=IwgEYC+EOUu78KaSTj6f9PgZGuetPh+6B+GH1lRqcxI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=FlYaT3DANAy9Nz6tft8AjtyYuu3wXgXHO/noabrJgSsL28WguhdxFIjQ7AAAc+vDC
	 m34rkbQKRR/w0Z18Wz062N4D2sLHUi+Ty0a5v1TU1Tyr60TlrZY4FqtDcWcsETx9hW
	 0lXoWr7c9Mnv58cVGHrLVdF4tlld85uG0qFP9aLg=
Date: Sun, 27 Sep 2026 18:21:28 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Matthias Goergens <matthias.goergens@gmail.com>
Cc: Jan Kara <jack@suse.cz>, linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>
Subject: Re: [PATCH] kdev_t: shift in dev_t in MKDEV()
Message-Id: <20260927182128.2e11d7f0f57f298e5c1aa5b9@linux-foundation.org>
In-Reply-To: <20260927224958.508964-1-matthias.goergens@gmail.com>
References: <20260927224958.508964-1-matthias.goergens@gmail.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 28 Sep 2026 06:49:58 +0800 Matthias Goergens <matthias.goergens@gmail.com> wrote:

> MKDEV(ma, mi) evaluates ((ma) << MINORBITS) in whatever type the
> caller passes, usually int.  For majors >= 2048 (legal: majors go up
> to 4095) the result exceeds INT_MAX, which C11 leaves undefined for
> a signed left shift; shifting a negative ma is undefined regardless
> of the major's value.  In practice, on the compilers and two's
> complement targets the kernel supports, both cases wrap to the
> intended bit pattern; this patch makes the macro well defined
> regardless by casting the major to dev_t before shifting.  For major and
> minor numbers in range, the device number it produces is unchanged.
> 
> isofs feeds the Rock Ridge 'PN' entry's dev_high and dev_low into
> MKDEV() while holding them in int variables (fs/isofs/rock.c), so a
> crafted image can drive this exact shift.  Fixing the macro covers
> every caller instead of just that one.

Thanks, lgtm.

> Signed-off-by: Matthias Goergens <matthias.goergens@gmail.com>
> ---
>  include/linux/kdev_t.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Boy, that's old code.  Greg, if anyone.

> diff --git a/include/linux/kdev_t.h b/include/linux/kdev_t.h
> index 4856706fbfeb..2dbbd47f1e68 100644
> --- a/include/linux/kdev_t.h
> +++ b/include/linux/kdev_t.h
> @@ -9,7 +9,7 @@
>  
>  #define MAJOR(dev)	((unsigned int) ((dev) >> MINORBITS))
>  #define MINOR(dev)	((unsigned int) ((dev) & MINORMASK))
> -#define MKDEV(ma,mi)	(((ma) << MINORBITS) | (mi))
> +#define MKDEV(ma, mi)	(((dev_t)(ma) << MINORBITS) | (mi))
>  
>  #define print_dev_t(buffer, dev)					\
>  	sprintf((buffer), "%u:%u\n", MAJOR(dev), MINOR(dev))
> -- 
> 2.55.0
