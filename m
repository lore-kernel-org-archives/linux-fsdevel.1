Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A911C36D9EC
	for <linux-fsdevel@vger.kernel.org>; Mon, 11 May 2026 11:15:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778498147; cv=none; b=k7ePJIFbIfmoQFr26qC89T8UkF56dLKWQTPVUVVY57DLt85ms33jzzwW3e47lAl4uyvmIZU1ytCfg8JP+Klq6Vue2MAByz7PeKfqbtrEV/vAHl0MMGqqmJO+iVnxD+3cxWVTtUIdhoxzYjLevbJrXVqtxldKZGDXkjM1+YzQRmM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778498147; c=relaxed/simple;
	bh=RR1NenBgrAYdu1c55iySbUR6WPCvJPcX8MV/1pGj/Aw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FjrbmhDhLZTgypfu0aSKH6iDARD5HBWfLU8QzhoY7dfDdtSWKP4Bo1f2d5+Uj5NZrYt5hCw66TXal0xIzUmIJEYHAYK53uHR7FevUjO2DcN/wPG41uoPAlgwfW3fT7FMjpd/PvG3AUaMnhLdrOJy/VHo9zJspPn2llXUTBPR5aU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=eiOXnVzB; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=JD7RYlZU; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eiOXnVzB";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="JD7RYlZU"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1778498144;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=yQi40JXMVWHDZRjke+rHrQlcRrLFkKa2WRv/wpGjnDg=;
	b=eiOXnVzB/pI21G1epMBuoDXb6oNlBBDexTMU4Pa0JCBceD31HbvlXiXC/IZQa1Fj8l9LKV
	pw5PgOlAYz+3TPAX39WKLM4LkRWOgM1cChU19NATJtSHTy8eIWrTpo/2dvzXU9R2NFykm3
	lwEojr5JQKwtDDdhTXGyrl+BoIaiuCg=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-367-SST90N4COoeZJMGxbVMHfQ-1; Mon, 11 May 2026 07:15:43 -0400
X-MC-Unique: SST90N4COoeZJMGxbVMHfQ-1
X-Mimecast-MFC-AGG-ID: SST90N4COoeZJMGxbVMHfQ_1778498142
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-488d8deb75fso31275545e9.3
        for <linux-fsdevel@vger.kernel.org>; Mon, 11 May 2026 04:15:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1778498142; x=1779102942; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=yQi40JXMVWHDZRjke+rHrQlcRrLFkKa2WRv/wpGjnDg=;
        b=JD7RYlZU6EskBY0iebQXhrP6fG75D84nXogDPu32FfcEw63rnM1IikbMUF2W/1X4Dt
         vZt+Wq8PziYB+4Hp7ysslCShy8FNO/Ok6TcQ4mFZ6m0CiQTd60l6VyvOfoqewkkfBYYQ
         FkZf3iCfI+5BBlhha7ptXvQZyNtIxwStyV/4KlGARJYEQYkV5SXdLGUxd+I4kXg7z+vB
         r/CeTPBzHD4KfQFNbu0VqhuEplLProVADaEeS+0jmKCpu725WyJezz2C61yDE0sToe9q
         lDw3yxAMwWPWjke4qYIA79uVQLaRPgr0bJBWYyFBaIo/2EAZGrKxl8U4V5UuHvErYF9T
         vgyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778498142; x=1779102942;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yQi40JXMVWHDZRjke+rHrQlcRrLFkKa2WRv/wpGjnDg=;
        b=ERckTHCWGPebYexGCMFzyp9UF3+3YwVpUV3sgZorx4d7EtzC9H9O8nKa2RFbZFk2sP
         ktH9rqYbbrOA7/w26esPxhvYKaqvjm7v/LQwwTfateBECjQjulBCSGsEf4K8KAfs4QQY
         CI2zjGryoYKzTbWBAZCuhsG6aAhc7FXL9pj6RiZB6m3d1srdN8GWQojqqxOJTwStb/AV
         jokQof9YfFpDoD1BpW7B6BSWseJ1GFcTdcdYWvs7xP9VWiORa/UwCm78JITQjCZdd0xP
         pOjRAAuVEAwRhrz7ggrDgeO0Njy4JZ7zOvABZhcxaLn1EgBo2B4W7JUnUsnqzbyN/d4p
         Lu+Q==
X-Forwarded-Encrypted: i=1; AFNElJ+1mxjEU1tc5yzb/+suOgeaNbLY4vriHOc5Sb7V7wjlESTajNfw0r/vZR25ljp0Zf2ySWYovIyX/8FwDPfB@vger.kernel.org
X-Gm-Message-State: AOJu0Yz57c73zshPhR+IKnn1T4vFIZ7BmsWnrg1qgYyZxACYVOdnFBBw
	c4MECIXMf4k9vuvJJnvel5hBak5x5YornFNMxe8DGGhctSbxZ0c2qS/u4s2u7vs58fDRheq/EeT
	SK7VWbbdVVj5mXOiVEDtupNZgzaQKHTzVlI4+6ybuuyvTp9rD5ubQYIf3ILS5eF6nIQ==
X-Gm-Gg: Acq92OHCdWt2Ty9yoUZEIscUqtO0Tx+SZWFsw1UPEeYPO0OdE2JspjuQ4H8DItI6Tl2
	tI5NXJMFgAgLJwLgTbaoe9pkAIR4QYZ0XxM/xM92bQIYzP/30U9cC01uApia2dU9HsQ8lFfkiW9
	7taKTGjHwxPRe+XXpRZHs8WMNxUXNiVJT4orbf2iTFB7ZBhiRfSLWp83LN0g+cXPnPzE7GMz1/g
	if3JQihUUopwVU66MnQ0DrYjmjlU1uB702WK7LPi9kHLVmXMdb4v/510IK2LPJieKamQT3GutEU
	+VsF0YLqD55RzFV1EH0kRBe/u8NF/g0fYLOFjDz5x9zwwnq9lXuyrYaIUC9tcXIAEJaKIMRE+mb
	1atobyvAe5mY=
X-Received: by 2002:a05:600c:1f89:b0:48e:8741:fd4c with SMTP id 5b1f17b1804b1-48e8741ff98mr21083545e9.18.1778498141634;
        Mon, 11 May 2026 04:15:41 -0700 (PDT)
X-Received: by 2002:a05:600c:1f89:b0:48e:8741:fd4c with SMTP id 5b1f17b1804b1-48e8741ff98mr21082605e9.18.1778498140980;
        Mon, 11 May 2026 04:15:40 -0700 (PDT)
Received: from thinky ([217.30.74.39])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48e7040a9a9sm309872515e9.9.2026.05.11.04.15.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 May 2026 04:15:40 -0700 (PDT)
Date: Mon, 11 May 2026 13:15:39 +0200
From: Andrey Albershteyn <aalbersh@redhat.com>
To: Christoph Hellwig <hch@lst.de>
Cc: Andrey Albershteyn <aalbersh@kernel.org>, linux-xfs@vger.kernel.org, 
	fsverity@lists.linux.dev, linux-fsdevel@vger.kernel.org, ebiggers@kernel.org, 
	linux-ext4@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net, 
	linux-btrfs@vger.kernel.org, linux-unionfs@vger.kernel.org, djwong@kernel.org, 
	david@fromorbit.com
Subject: Re: [PATCH v9 00/22] fs-verity support for XFS with post EOF merkle
 tree
Message-ID: <hnsxzymuydf5evoxw4chao7rkixm4eafolebxfjtsqschgfazh@nll3fdfnsigx>
References: <20260428083332.768693-1-aalbersh@kernel.org>
 <20260507055217.GA19888@lst.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260507055217.GA19888@lst.de>

On 2026-05-07 07:52:17, Christoph Hellwig wrote:
> On Tue, Apr 28, 2026 at 10:33:06AM +0200, Andrey Albershteyn wrote:
> > This series based on v7.0 with Christoph's read ioends patchset [1].
> 
> That's not a good baseline.  We'll need it on the -rc that has everything
> from the current merge window at least.  It might also interact with
> the fsverity fix that just went in.

Sure, I will sent v10 with a latest master and that fix soon.

> 
> This might also be time to come up with a merge plan to figure out through
> what tree(s) to merge it as there don't seem to be any maintainer
> objections.
> 
> 

-- 
- Andrey

