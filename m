Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 241CE2E7F25
	for <linux-fsdevel@vger.kernel.org>; Thu,  7 May 2026 13:48:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778161732; cv=none; b=ZvEDprzKFlwTem01dPjLzODNfTzznEs8Z1FUnWEJ+SY6UngvJNKPTPZz/QZh5MjxmTQDHjatfWnuaVCPr85E/h9DWQP+q0HspnBneeSvE893HkfXKkuDTzJ3wQ7FhUf1WheFtDcZkx57iCZHZJDK+b0ykzapBd0o0KC4A4TwCCg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778161732; c=relaxed/simple;
	bh=wZ02jFw3QnrL9pqajGTExiKalcO5ytwNykzapPkeuqI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TMtKkvdckLuL9CGi8LOIY0LFbzUCJ3yZoiHwYEP+Bv6K7SUcXMYK0p3a0uiWWD/RWA5ad+7NfenlSWUCu97/19b+5HrpI4MvgX0vy97nM4v3RZ1jKmgHVAu53SCaR/6f3t3C+Ms2++I8hEIefb3enJgVc1ixOvTPwQRIWw/NnWs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FZHlPL53; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FZHlPL53"
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-44dd5cb0f81so1333310f8f.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 07 May 2026 06:48:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778161729; x=1778766529; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=wK6TAzUloopPTE8hTYakXrmDxC5izFYA6vF+OBwvd2A=;
        b=FZHlPL53CtmZ71yeP77OWcsAqJU2KuWusqJ6zxb0XJ4sQd2xJqAmD3eu+wPcPa1nCN
         4jmV4OZEjvphadF5GSQ8Vi7q0II54juEhKFKpBrjDZl202pPENy0yppjKqoZ3AMoeBf6
         jT5U0+Sq/IRMhGonL2yNrvC50QlYF2QPTxCIjGhiBLxj5YbnLB54byNfHh5+UX0/46yI
         DwVcvkgJpwxQYBt4N07Vyb1Lnr0AFrlQd1WrO1PF/PaGXR9t5XsivE/p2a5v1FYbbbyY
         GnxklEQJKwC3djVDu4lxL1gamYeg31L/DrAgGqOqeeNQtnfA6uNZHBJom3t0qiL48h6f
         tDeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778161729; x=1778766529;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wK6TAzUloopPTE8hTYakXrmDxC5izFYA6vF+OBwvd2A=;
        b=GlKt5Th9J9imYOYlmzUUZaRaVvCE1Io9kBU5n7hsXiMDv1Ob0KNGhBxaDe7MHn3KBf
         Zngoc+Ir3PsdB+A5p9hQDjQVRshgz7FlobL9KFa95xabWoRpCwFFlKqitjuyD//PupaK
         qpElhsII2eukWLE/dslthZId3StxDdV8kJcV0Mk9QFPbcTCGH1CLkvKBaVD38pV3qbcV
         u3EPKHa3yEx0pmsvilf4Ji/BCTeruNTenwMrCXPpsB7fPLcSkS1jef7kIXYNpBVP9t0L
         +8+FLfYCQFhiZUCkTJKuhtOqoRmdMzOvALcQJLC+3XtKKMJvRYx6P0C79K2CJSf1bDXr
         5ilg==
X-Forwarded-Encrypted: i=1; AFNElJ//ZMvvHFaRAzc7+IqIqzaBeqeZ9F7mZ6s+HCUjCEIsG+MWmp+5qEqOGlmkwvT+VxD2AoeCpGUUj8ByG3hD@vger.kernel.org
X-Gm-Message-State: AOJu0Yy/Z9DrPMLcu0JoTVr0OTGA8ktSS8s/W5LEBhT5u4GEV0P8loiW
	HYOiBzqCMHI1TPcN9Wcdi8oJX2Re6uO2i7nxkJ9MBaPKdfCxNbve7uU=
X-Gm-Gg: AeBDiet19YM1p7KWQnCmDrbpD98Pbbrr2Ac6IYDcDKdD8+xh3+bqqsrWlc7NXT8b5+3
	OZV4VgCVsIY0qYIuwoMoc1bJf5t3dJkPSHDGbJLN1oXfCKFHX3Y/NBXrWterhfjT3G7Ag4rEwao
	nr2EXD2hKiKmjVVou4XqbcUhmfIt9pHRdlAEpqNb7w0SH7uMjUY9f3iPRcyXJqHDaT91O9bCNBH
	Vq4RV61jYLUzq+YfPswzrzvfGmy1KsjHLvCid009aZkzL2NrG0XEJ6mmNAXNK5jz4pPsixx8XS+
	EEnBSc31u3AjgByXizpzIQ3hMfOZ/Z+sM7Ke2kSbGp6AjLNl522+YxutlxiBjo2bdDjuWDi/k6P
	4CELq+ekRBlf6kNcQA42IHIoTMX0/5TqkgKPNBFhOfgNF7CTK7ZTJR9SpAZneo/bjHUL7NUj77U
	5q06bqs0DXEq0i6F558rq3qkvZ7TN53hlPSZygDbAa+0WgHpu0ggXCKViTzCTnMGk5eFqlyQDiL
	cd4hg==
X-Received: by 2002:a05:6000:2b0a:b0:453:dc4d:9265 with SMTP id ffacd0b85a97d-453dc4d94afmr439849f8f.10.1778161729149;
        Thu, 07 May 2026 06:48:49 -0700 (PDT)
Received: from p183 (dynamic-vpdn-brest-46-53-134-148.brest.telecom.by. [46.53.134.148])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4505285e765sm19800064f8f.10.2026.05.07.06.48.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 May 2026 06:48:48 -0700 (PDT)
Date: Thu, 7 May 2026 16:51:10 +0300
From: Alexey Dobriyan <adobriyan@gmail.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,
	Danilo Krummrich <dakr@kernel.org>, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] sysfs: upgrade OOB write by buggy .show hook into WARNing
Message-ID: <a9b349db-230d-4cd7-bc65-23257d005a5a@p183>
References: <5f794f46-5afd-405c-9747-76f2c95d4598@p183>
 <3cc3e8c6-c6e8-4625-a88f-f5708b935dab@p183>
 <2026050720-plating-cling-153a@gregkh>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <2026050720-plating-cling-153a@gregkh>

On Thu, May 07, 2026 at 11:05:16AM +0200, Greg Kroah-Hartman wrote:
> On Thu, May 07, 2026 at 12:01:43PM +0300, Alexey Dobriyan wrote:

> > --- a/fs/sysfs/file.c
> > +++ b/fs/sysfs/file.c
> > @@ -70,9 +70,8 @@ static int sysfs_kf_seq_show(struct seq_file *sf, void *v)
> >  	 * The code works fine with PAGE_SIZE return but it's likely to
> >  	 * indicate truncated result or overflow in normal use cases.
> >  	 */
> > -	if (count >= (ssize_t)PAGE_SIZE) {
> > -		printk("fill_read_buffer: %pS returned bad count\n",
> > -				ops->show);
> > +	if (count >= PAGE_SIZE) {
> > +		WARN(1, "OOB write or bad count %zd at %pS\n", count, ops->show);
> 
> This is going to be interesting to see what triggers, so I'll go queue
> this up soon.
> 
> And this implies you did hit this on ext4?

The check was triggered by out-of-tree module.
ext4 is me testing the patch with a custom written buggy hook.

	/sys/alexey
