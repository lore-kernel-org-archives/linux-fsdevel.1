Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D48B3D564B
	for <linux-fsdevel@vger.kernel.org>; Wed, 25 Mar 2026 12:38:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774442295; cv=none; b=f9iKc8e1woCPDRg4CPqgNVLZaeNpEiVK8/sLKbEjOR+LtjIgr2cMxj3SluBl2IXnk2EFAlW6xobPOBIHkLyRRU8LHfljsx65yJ2fh7JbM5whFHiAacm6f5DXJjIrmMkoHkR/v9tLiJUsw+HDm2S/mmMTybMlAuniu4wUekmtRHI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774442295; c=relaxed/simple;
	bh=B7XEYkMQi5D0EqTXN0etgYXPUL8EADhsGgGCE2iqsCA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gWnqmYSEQnnN4Jz5NkCcSrUVY1NKnHqKe55BSbQTXh8QYHdNDwaeapaVy0uSe3LYQVfp5cI9nqPc6BAbfCarbKX9Vg4WjYOQettKt9e6QeEwf5tFVBA17lmodPJJsmOsYaObGra+CX/ckp2S0hacmAcgVI0hPRKQ9xO1rD2fCRg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=SkCzScCu; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=AOLIh0Ue; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SkCzScCu";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="AOLIh0Ue"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1774442292;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=zq66uLldOzJDWwFuTQSicat9HZ9onClHiQ97FMgB8gk=;
	b=SkCzScCuCdyNL1RUnpfJxBIL5F2VO8pgYLuuZuGNC9Z7wh9ucam59gxfaUWvYHjCDdoC+y
	RRXrtom8b1qSiG/Ppj48o875UHfOfbbJMeJmhANxnVoORpUCS7gtaIhqIe0mXwLjgiLik4
	ddN8iVF7b7wala8rYTxzBWNqM8iGoBQ=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-572-CqPk5TZDOWurBEmt3I_djQ-1; Wed, 25 Mar 2026 08:38:11 -0400
X-MC-Unique: CqPk5TZDOWurBEmt3I_djQ-1
X-Mimecast-MFC-AGG-ID: CqPk5TZDOWurBEmt3I_djQ_1774442290
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-4837bfcfe0dso53976745e9.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 25 Mar 2026 05:38:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1774442290; x=1775047090; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=zq66uLldOzJDWwFuTQSicat9HZ9onClHiQ97FMgB8gk=;
        b=AOLIh0Ue5a3o1fyEajsXxRCiEAE4Rrq4bwtTWcmkudbfF4EGebeo9SW56XtdYxL7gQ
         xeW4CNOMySdctnDl5F1p0NWrzINeidFsK1GsBMK5qy8II2QIIYddb+3Fodhb3uT+VKGE
         1v7e5LdWnAHVsWJeK6ghIqQJmUl6MJOFosAG6lA5C/uDp58EhWy87J3zWlWPJZjfwZK2
         KWy9GMHLWJUNInaYYcCVszumxavzYJx2dmfjsh7j+8dniUK6L50dzCuKbj5d27T2iZIZ
         WZQcz9r++SsteOFi0YBkYD1BI3vq48IWcbFzmeCDWMrPkfvMwKPhtayf8UlyVwkx66Ug
         +ELQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774442290; x=1775047090;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zq66uLldOzJDWwFuTQSicat9HZ9onClHiQ97FMgB8gk=;
        b=VDo9TogKzZroiFB1bmk+BAl0WhBZSRJFaADyNZNkGNQPf0ABEYVxFqs9TwSqFCkKbT
         0NDq8lzi5GB1pjXtg7BilXVt8vz3QVCgBp9Z5Uv914nwfilmUSd8pdJwa+cVi+umTHU1
         kv2AR0kgkCd5AJd0avBIsQr8gJ+9AuPreggVj8w7VzS9aZAA7Oipn/Xz1eFJmzQPRO+c
         TOxzUHbgaRd7pLMxrHTKE4J7jvkHAvf6JGLtfYKKPSjYu0DAIQKUetdZ1l+B9gQ9oJcY
         uHpQfKYhLy3gynMOOB+KAIt3ALMmr6JGg1CfMhMXesL1COSSOhmoCpF6InwY1M4v7wVC
         zBHg==
X-Forwarded-Encrypted: i=1; AJvYcCVkGrmc7pMqmE+40U8EdAdFrPP4SyCSS6hRndL2ejB+RLkx5m6QJZ5fnwQPcTZOCCPMD4HsWyG3+tMe80vn@vger.kernel.org
X-Gm-Message-State: AOJu0YwKI60rfq3YrKS9cquSZHTGPOBR7AYGgOz/TxL51IdCubo4JrfM
	dqIZan1Lvw30XcYfch2VdnlSfQ/mq8fqB9xV+2w4kOvB6lKScViyKDI49SVARJNrMzR90BUpLVM
	JzKbGzO48tVJb3YhkDYBRh232NZbvTtp9EvJ15H0DwrxCHK98EUYuTsSDVME0au95+w==
X-Gm-Gg: ATEYQzztA26e41Wujgz29TIanf4/YYMFMuk4R79/jw/mfbmPcV+AXWC3Lfpr73MBPRp
	5Tk0T7Va9Z3Mo8/h7qDUDrVvbG9Zy3F7RLeSvUYU/9YqH3n3yimEtgygtnMJnTOsmmN8SO8eewV
	Tw4Yaa6qGr0AB6lmVCdxlcvFsqb+04oAYBii/ButLkFWbfUto3gGUfoTyMvOCOSMKG3LTHjK1pG
	cSs0DVJhrZHvjSO1D4cusC6T4Kaw3IRO7eL3Ng2A62ZxkVQEt4Vu3SEi1mQLUhkswIsuUO2xBrd
	/G4v78wcTq+yu4dWQ9Gvuqgml0BqetbaDSekgQcm1R+Ya3ttcqLezGx2hQZEemy9WkgBMwJ+smR
	REXm+hD1YJ+R+zQ==
X-Received: by 2002:a05:600c:3f16:b0:483:6d42:25c6 with SMTP id 5b1f17b1804b1-4871606db4amr51426215e9.23.1774442289655;
        Wed, 25 Mar 2026 05:38:09 -0700 (PDT)
X-Received: by 2002:a05:600c:3f16:b0:483:6d42:25c6 with SMTP id 5b1f17b1804b1-4871606db4amr51425715e9.23.1774442289131;
        Wed, 25 Mar 2026 05:38:09 -0700 (PDT)
Received: from thinky ([91.245.205.131])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-487116ee57esm120806865e9.14.2026.03.25.05.38.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Mar 2026 05:38:08 -0700 (PDT)
Date: Wed, 25 Mar 2026 13:38:07 +0100
From: Andrey Albershteyn <aalbersh@redhat.com>
To: Christoph Hellwig <hch@lst.de>
Cc: Andrey Albershteyn <aalbersh@kernel.org>, linux-xfs@vger.kernel.org, 
	fsverity@lists.linux.dev, linux-fsdevel@vger.kernel.org, ebiggers@kernel.org, 
	linux-ext4@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net, 
	linux-btrfs@vger.kernel.org, djwong@kernel.org
Subject: Re: [PATCH v5 07/25] iomap: introduce IOMAP_F_FSVERITY and teach
 writeback to handle fsverity
Message-ID: <std5dib2mf5nfd2gf3jbrhujvqr2tytczplopwfy4zrxrrmrgj@py7g4alrifbi>
References: <20260319170231.1455553-1-aalbersh@kernel.org>
 <20260319170231.1455553-8-aalbersh@kernel.org>
 <20260325080021.GF952@lst.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260325080021.GF952@lst.de>

On 2026-03-25 09:00:21, Christoph Hellwig wrote:
> > @@ -353,9 +353,16 @@ static inline bool iomap_block_needs_zeroing(const struct iomap_iter *iter,
> >  {
> >  	const struct iomap *srcmap = iomap_iter_srcmap(iter);
> >  
> > -	return srcmap->type != IOMAP_MAPPED ||
> > -		(srcmap->flags & IOMAP_F_NEW) ||
> > -		pos >= i_size_read(iter->inode);
> > +	if (srcmap->type != IOMAP_MAPPED)
> > +		return true;
> > +
> > +	if (srcmap->flags & IOMAP_F_NEW)
> > +		return true;
> > +
> > +	if (srcmap->flags & IOMAP_F_FSVERITY)
> > +		return false;
> > +
> > +	return pos >= i_size_read(iter->inode);
> 
> This might be a good time to document the various reasons for needing
> zeroing.

something like this?

--- a/fs/iomap/buffered-io.c
+++ b/fs/iomap/buffered-io.c
@@ -344,9 +344,27 @@ static inline bool iomap_block_needs_zeroing(const struct iomap_iter *iter,
 {
        const struct iomap *srcmap = iomap_iter_srcmap(iter);
 
-       return srcmap->type != IOMAP_MAPPED ||
-               (srcmap->flags & IOMAP_F_NEW) ||
-               pos >= i_size_read(iter->inode);
+       /*
+        * If this block is not mapped, we don't have any backing blocks to read
+        * yet
+        */
+       if (srcmap->type != IOMAP_MAPPED)
+               return true;
+
+       /*
+        * This block just got allocated and does not contain any meaningful data
+        */
+       if (srcmap->flags & IOMAP_F_NEW)
+               return true;
+
+       /*
+        * fsverity metadata is stored past i_size, we need to read it instead of
+        * zeroing
+        */
+       if (srcmap->flags & IOMAP_F_FSVERITY)
+               return false;
+
+       return pos >= i_size_read(iter->inode);
 }

> 
> > +/*
> > + * IO happens beyond inode EOF, fsverity metadata is stored there
> > + */
> > +#define IOMAP_F_FSVERITY	(1U << 10)
> 
> This comment feels a bit too sparse.  Here is my interpretation of what
> this flag does:
> 
> /*
>  * Indicates reads and writes of fsverity metadata.
>  *
>  * Fsverity metadata is stored after the regular file data and thus beyond
>  * i_size.
>  */

Thanks! I will update it

-- 
- Andrey

