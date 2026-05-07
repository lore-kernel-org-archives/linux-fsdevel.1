Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 507AA3FB7D5
	for <linux-fsdevel@vger.kernel.org>; Thu,  7 May 2026 13:50:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778161801; cv=none; b=oKRCPg8s8pUemhSKHDiGohS949Cy86xo96phhcAvo7BLezPEp274kxzufFVvhN7blYeiCpcB3CddTbrT8aD0lH8NO8VybNanSj4kIwhOMRLgex51WIn3396J7a6lWHu+1V4Hwim13jIRncLWTNMtErz/xqYicGCjlVIDNI4RTmA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778161801; c=relaxed/simple;
	bh=y+uKXvWavECBqe4i8FCfX/X2zoA3kl9zR298cLW4eYE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MmnuMFu4koigiiWiawED3wu0/XaSrqLnG05D4ZnzZLAHq2yM4Wj6ZGgRKk5vqYxb6PYA/sVrg0hFo4STFwJty+12lo1iITDMzZSvvPccc2/uHjFG+I/XvefUob06AJG+pkh1eGsU6fUAMe4wG/4PHZnQ80OBxbzTLriGe5IhqPw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gfA+0+PR; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gfA+0+PR"
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-48374014a77so10636085e9.3
        for <linux-fsdevel@vger.kernel.org>; Thu, 07 May 2026 06:50:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778161799; x=1778766599; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=63Zk1soB0pWql4fWbhVmbD4zB7eoGfppwocKxntreYI=;
        b=gfA+0+PRHAILV5/9eXw0/MsEwPSgexDM30cv/MYoHLkqOhntysumGb5VZNllVQZFML
         lPXj1pUEOXf1MkFoQaInmZDf1ypj0KMbzOF9RpXCcc+PYEc1dL87Zggc+LN0KnqyRwue
         /G1VH0a7dOcM+aBvI83GbhmFkLLbbn/h5rCj8Q08a+8sOmPAbLuJQNVyNuPSUWktW8JO
         vraDNT/BNDZZHippk6ZR5wJNvRRIDUedbqVjENOcJLEeSOAD22/d0GU+uzQRB8RCquu6
         1p25HCdNNJEil+SqtlCqkh4i/J7EStxlevPR6VXhI592pFUdxpuH7gji5OBAbQnB/3wz
         L75w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778161799; x=1778766599;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=63Zk1soB0pWql4fWbhVmbD4zB7eoGfppwocKxntreYI=;
        b=OqA+G0EjXj5gWo61IE/Aa4UBR7LRthvRpd41yRM+12HnfP/KN6wkr/hLRpW5fUV3+w
         tueYjjkf9B9BtgqpvZdnDEqoXYuvSZ0AeujtoBx3QVz9ly1ykPxJoiRXYU9B8BASEB85
         /hnSezZIi1aOwJQ86ha9MsDtuJemrdpBgj1oohlhPAEifl7aXQgyp1Ft8qqvPa0FphSS
         M5TvV5bHk/1ZCUQoaQTGZ+jwrFeucS3OQc4a31W2CjGmC6zQpY9D+ndaCeIDEwqCQ3iq
         hqrtc1ANRHybuo2+DqPGef/YnPKfec2D78KmZB0jIs1An7yd0NyBUSuwAem6sD+4oUFR
         Z1eA==
X-Forwarded-Encrypted: i=1; AFNElJ8qvOnLCAzSEBtTRDA7zBwDnzSqDRD44+E1P6FZGx2t0bOAtqfIi3g3zhVH3Adfle6z2nnzM1KDzARDBKvE@vger.kernel.org
X-Gm-Message-State: AOJu0Yx36zzF5fByrJSDz+ZbAcjwG9hKJPKVm4oULOrmoEQxa3pCUpyL
	HIj5B5gR58+wB1ZLUG0/K5Gd3tuSByPse6Y4iRcjsX9Sy33mIf7SjMo=
X-Gm-Gg: AeBDievxtDtizjLuFGtrRlt8LcTfZ6HZu21W7G+yOvXQHE2c4IhfdspwgaMvrJal4/i
	YF+LBe9SGHoJNGTxA8YJFmDQ5uhnQKeaUOxYp+F5r6C44cFlI1TsUqegedXOgam+Jb2yrJ7nWTt
	pEIOV5oyyGD4eypY9YKg2r5kq6dM1weguE7DrHvqXBTYcArCIn3+3t0TYC/2DnWQNdGN49CB4ib
	lKTHASanDaCUAOf6aZQClqek4ksSYNFYNeARbvE8T+JXINcVQnzzb5+g4w0sV6fwtRp46+GMGua
	HCFquEnxppN2Fxq46UwMLXqU4CIDRB4zfLC3voJnhRBDP2pUuY6Jiz1mjrGs29UEyDyY/2wYQL7
	DVVIo+uNoKxtUHt1V2FjJfz389zfCdRU0+0N+4LTDcvEui5LeB3KdceLqilXdaUnVy2by7XMPjQ
	uf8C/HSy+2sP0xs0gqFKK7yjHzHvOQYTJJhB/K4jfJMvY8ruH9Q2KEdyMRaEPnHXNZZibrcLpbZ
	sipJQ==
X-Received: by 2002:a05:600c:871b:b0:483:709e:f238 with SMTP id 5b1f17b1804b1-48e51f4652fmr137400015e9.29.1778161798241;
        Thu, 07 May 2026 06:49:58 -0700 (PDT)
Received: from p183 (dynamic-vpdn-brest-46-53-134-148.brest.telecom.by. [46.53.134.148])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48e5382a327sm224564925e9.0.2026.05.07.06.49.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 May 2026 06:49:57 -0700 (PDT)
Date: Thu, 7 May 2026 16:52:19 +0300
From: Alexey Dobriyan <adobriyan@gmail.com>
To: Danilo Krummrich <dakr@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	linux-fsdevel@vger.kernel.org, driver-core@lists.linux.dev
Subject: Re: [PATCH] sysfs: upgrade OOB write by buggy .show hook into WARNing
Message-ID: <7bc745f1-a8fb-4bfd-8b85-657333a1bbf1@p183>
References: <5f794f46-5afd-405c-9747-76f2c95d4598@p183>
 <3cc3e8c6-c6e8-4625-a88f-f5708b935dab@p183>
 <DICC6TIGNBZA.1ZW4SSME21HRF@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <DICC6TIGNBZA.1ZW4SSME21HRF@kernel.org>

On Thu, May 07, 2026 at 11:28:29AM +0200, Danilo Krummrich wrote:
> (Cc: driver-core)
> 
> On Thu May 7, 2026 at 11:01 AM CEST, Alexey Dobriyan wrote:
> > Buggy .show hook will get just 1 line of dmesg:
> >
> > 	fill_read_buffer: ext4_attr_show+0x0/0x600 returned bad count
> >
> > It may or may not oops later in some unrelated process.
> >
> > But buggy .show hook most likely is corrupting random memory past sysfs
> > buffer therefore deserving more. WARN, make it more visible and let
> > QA machines panic earlier.
> >
> > Also, delete useless cast -- "count" is >=0 at this point.
> >
> > Signed-off-by: Alexey Dobriyan <adobriyan@gmail.com>
> 
> Reviewed-by: Danilo Krummrich <dakr@kernel.org>
> 
> NIT: This patch also cleans up the stale "fill_read_buffer:" prefix, and instead
> points out the actual caller, which could be mentioned in the commit message --
> no need to resend for this though.

Yes. WARN prints enough information to locate the bug, so stale function
name just goes away.
