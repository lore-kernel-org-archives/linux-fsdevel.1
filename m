Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B98137700D
	for <linux-fsdevel@vger.kernel.org>; Wed, 11 Mar 2026 11:40:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773229250; cv=none; b=g+6CgYhE8WySD+x3J/Z7NYJD+v/bpb8KgPpBGALv0DmFlLw6sKTUD/W1AdXswi7A7RC/+fGNPyUPfduVCElCjkFTcYphKfbJWs5WS0zvhlS29El7qFcQqcdwvqw/4FgICs/tajjDX5hRlKJ/A45h8CW6pB9AYZvfsD62tSPDLrE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773229250; c=relaxed/simple;
	bh=20znycAiWYwgVpDq1AEoFnk1IQDyUcy9AAi5peaAKMg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QS1qd+5VFDzpY/P3v+xSXA7OYXZsdvXBMKx04f3774hbZ36nKo5L8tcJg+Q2eutnI9bEX15yN4CZdIq8Z87v/sKayDaxxSOHJ0z+7xOLGyLiUaFHr3Yf2QGTAc7WrJMFtmtAwDPuf2i0BzqDpz3Tkf+mkKS7Ils48dn+MRsLkRQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=JPxldiaA; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=fut8wmbN; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JPxldiaA";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="fut8wmbN"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1773229248;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=hghvzVba1q/xAQn2tH8MfPNoAAIYmfTOne/cK1QhKyo=;
	b=JPxldiaAezuIdMZKc5FA8pyHzrazYiIEcDXAKHki8Ekxa3oIowJuqy4ar1bkfD6KUB8o6W
	I1kybWT7TyX9JFKSJo/8DhOEEKxtjDkC6ZEups+On7QLGw7f9UYfFm9tLvDW94axHqZ2g9
	rvq1W25zuRdrA+2uIBifs1oKLKaivQY=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-645-QcPn1QNePimuAyoVE8cwYQ-1; Wed, 11 Mar 2026 07:40:47 -0400
X-MC-Unique: QcPn1QNePimuAyoVE8cwYQ-1
X-Mimecast-MFC-AGG-ID: QcPn1QNePimuAyoVE8cwYQ_1773229246
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-4853b0af42aso38077775e9.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 11 Mar 2026 04:40:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1773229246; x=1773834046; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=hghvzVba1q/xAQn2tH8MfPNoAAIYmfTOne/cK1QhKyo=;
        b=fut8wmbNXv0G1xxo5yznVsFqUOntF5SqY3o/FFahGl+gHps5y/4bo2Kd9wOjuSGVPg
         kpwLWnpKs+V8aBUxY/UebM76Qir6WONjHkyQAzKTPWIFZo+7B7s7D99KS7gpOIlCZKnq
         4L4BHsImAk/+zpk/n1ddP2vRtPDO1J+mAWcLoK3V3tuww730CGKeElg3COvKy+vZ7bHb
         MnrS+L1FjYt0pBp9nqR+8heWifHfpATMskDp4s55A6HdmQTSktmen4TlafeAmfOEXYFl
         dUuHLUqeKX6QR/G4eSoDQNPRUX0oUglegzBwf1jUITwT9JfHeCjMv28lOl2xuE7Lr721
         edFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773229246; x=1773834046;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hghvzVba1q/xAQn2tH8MfPNoAAIYmfTOne/cK1QhKyo=;
        b=xR79CtPcVzbv+ioFQHFZugZVerkfoft3AjdrUCaSM9En2ZhBNZNPLhEgSJe1fNQpWa
         vZiMBuoOyaMRSsWGU8kFQytUL16V6fJCCOkoS+GQKMTbjK8GJhTEUgULVkqPu/Itykpr
         dJkAA0CfV5Q8/VRocSnpOMW8GLA8Pms1yYwriLOWVQGSkPhtgKsq7mF6RWU0g6q8BWGL
         7zxpzBa0goz7TRF2wwRIUd5vHgpe7FrQ8YK6/hmXBV/Z4oXYuwU4X3g5nv5PDM0vidUf
         Ybc/pFNHlzD9ZRCsopk5llhgxM1KAwPdxme6oGADNJ6KuPPE35A/Z7CAUqlDHxKDdwZo
         XZBQ==
X-Forwarded-Encrypted: i=1; AJvYcCV8z6DIwfXSDhJVjXIGVBAJNGfxxfN45Snfy88rv243B/I/AHoeLVkN8GBcKh8viL7Mf4TcUxSAqBU2ducd@vger.kernel.org
X-Gm-Message-State: AOJu0YxOz1Psro9tosthZxIFWyIklV32qkZSLIznD/IoNLcYRfQotKOq
	gw8+EPknoVAeOX5bWnANv/1qXVBEadM5J8XXHHKoSltQ3gKbk29wT8tgV27CmJJCF08rNUaHMI3
	qQ0XWKBGAA/5OPU5JaKDe6u2gnD5DVpiRhe69L9jSeQb1zw2hwAGXsFh673KcwPhROw==
X-Gm-Gg: ATEYQzyKeK8h7Y6zMhDlFvAEb+ffMMN7dMcqhtfJtFBBlqkj8ArjsiLsBM9wXljekDk
	/co1dRGp1BxWTZnmoqxD9l6jHJXSGRsycL+PQVjA7bWQqJGwkMjaFusbVoLQoy519Ytp7/QUoMC
	YVwM7rD3QVhjrGyunqJioE0+Lg9IaUy+8IhUoF2yuhWtLLpd+11WwqVdDVaVW1WK9fT27JWLC6H
	yk/bQ0CTJMtZPgL6fQ6AOFDPFJrNcPWhlFhKPHwv8vgQtSCKV0Bh1XMhpkYTmI2oiLtMuAFsBcv
	dAdryMrjflMh7HAXvQNPNnsKp26Yb2g5eqDAFGZ/NjGPonHxQvlh2TvKW/IpbbXa1lWL82bZ2vP
	vjexVRan2uOw=
X-Received: by 2002:a05:600c:a08:b0:485:4388:3492 with SMTP id 5b1f17b1804b1-4854b0b2979mr36839645e9.11.1773229246046;
        Wed, 11 Mar 2026 04:40:46 -0700 (PDT)
X-Received: by 2002:a05:600c:a08:b0:485:4388:3492 with SMTP id 5b1f17b1804b1-4854b0b2979mr36839045e9.11.1773229245499;
        Wed, 11 Mar 2026 04:40:45 -0700 (PDT)
Received: from thinky ([217.30.74.39])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-439f818d61esm6551972f8f.8.2026.03.11.04.40.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Mar 2026 04:40:45 -0700 (PDT)
Date: Wed, 11 Mar 2026 12:40:44 +0100
From: Andrey Albershteyn <aalbersh@redhat.com>
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: Andrey Albershteyn <aalbersh@kernel.org>, linux-xfs@vger.kernel.org, 
	fsverity@lists.linux.dev, linux-fsdevel@vger.kernel.org, ebiggers@kernel.org, hch@lst.de, 
	linux-ext4@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net, 
	linux-btrfs@vger.kernel.org
Subject: Re: [PATCH v4 17/25] xfs: use read ioend for fsverity data
 verification
Message-ID: <bjvosviztvgxswil77pbhw6227y3qss7govt74iyduhfoo7biu@uifmquvn67vj>
References: <20260309192355.176980-1-aalbersh@kernel.org>
 <20260309192355.176980-18-aalbersh@kernel.org>
 <20260310012105.GE1105363@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260310012105.GE1105363@frogsfrogsfrogs>

On 2026-03-09 18:21:05, Darrick J. Wong wrote:
> >  
> >  	spin_lock_irqsave(&ip->i_ioend_lock, flags);
> > -	if (list_empty(&ip->i_ioend_list))
> > -		WARN_ON_ONCE(!queue_work(mp->m_unwritten_workqueue,
> > +	if (list_empty(&ip->i_ioend_list)) {
> > +		if (IS_ENABLED(CONFIG_FS_VERITY) && ioend->io_vi &&
> > +		    ioend->io_offset < xfs_fsverity_metadata_offset(ip))
> > +			fsverity_enqueue_verify_work(&ip->i_ioend_work);
> 
> I think the fsverity metadata (merkle tree & descriptor) don't need any
> (read) ioend completion work since all we're doing is reading that into
> the pagecache and eventually fsverity will go look at those contents
> when it wants to verify some actual file data, right?

Yes, metadata don't need any verification. We skip it here and
enqueue only data (this check):

+		    ioend->io_offset < xfs_fsverity_metadata_offset(ip))

The metadata goes through normal read path ioend completion.

-- 
- Andrey

