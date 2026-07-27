Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBE6739DBF8
	for <linux-fsdevel@vger.kernel.org>; Mon, 27 Jul 2026 11:40:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785152408; cv=none; b=K37uo1PLpluGkhNvj7WWuX76DUEBDwDQPGej1kxtQ2oHC1eOk6jdynpKOx+CWiSxapdiKghOmlp+MBIA4PNGWKl2YiKXs+lzNdVogAiJBOzBnhH6dsmqD4eF4A2T8wlRLeedL68vEiSsZ+gy5lKzmU4whSCnBkZaLvl7snUhAQY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785152408; c=relaxed/simple;
	bh=bi8BA5oS5R3RGDXFaAMjH9VjI7t5/jzE6E9xn3TWcOI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iawMaitU3EhETIkNTb3hwihgX8wFdEJChtDSxDybJHvf36e426yp/XhW4ORhZCXiJENKJAYM1MNfP0NOs1F+QO3m03Cc0uQredFta0D+5f4Pm5JwCWbThYWDc9ZbRJjQNLnYPerPQIsQibfoFdLi3NFF6MjYl4JjU1N1Ch4QpuY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Fl/eAaJb; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=sCH0xysY; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Fl/eAaJb";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="sCH0xysY"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1785152405;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=XjT/PIWbG/51hlsr95HE/1iGTwI0BlJqCQFAOLtkIYs=;
	b=Fl/eAaJbLNmn6K3f9B5SxPuJAICi/lgV+d7k+IV9asTpWoFDWA2LPJXvH3LE4CunB22ssP
	mDQerjG6OfvMipxfa1L1hh9jtKo+z+pg+38ynG7x6x00OvyWS+D7AQZlpgPETU5zOIpDZg
	trA+/S9jP9rh6ik7YrCngBdz2D3vR6o=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-397-2QT6bxpuM1eBWIRvacwngA-1; Mon, 27 Jul 2026 07:40:04 -0400
X-MC-Unique: 2QT6bxpuM1eBWIRvacwngA-1
X-Mimecast-MFC-AGG-ID: 2QT6bxpuM1eBWIRvacwngA_1785152403
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-4955e865174so15591125e9.3
        for <linux-fsdevel@vger.kernel.org>; Mon, 27 Jul 2026 04:40:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1785152403; x=1785757203; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=XjT/PIWbG/51hlsr95HE/1iGTwI0BlJqCQFAOLtkIYs=;
        b=sCH0xysYgEIstUl7aHJV13gWXGcHqK3vteCbmXo+v/y8na5SUTj32Ol4E7VRzya6wD
         6L5WAmI4EVYmHDJFp39XC5FEDKqbLdGtaS1VDaBpGkmSS7O9F4eHITqr4umPc/0ZsH3k
         H7ng5WvdoFhw4U4MEznbW8TzKVCwHKXhH2zjlAC3atFWv9vW4xUA3onvXzckYE7T6kEq
         qSBbvz7GEyCbvm0Mxi9Ut6KNIPQh/l55QvuQlc/rVw2uhg6prR/OIdr9tM9LPlrYOfkW
         a7IH9P5KqayRyS4iw2b0kX6T5a6c3+SmQbtsjvy+KmjzBu377fHj+2GP185CWbJZq56u
         zY8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785152403; x=1785757203;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=XjT/PIWbG/51hlsr95HE/1iGTwI0BlJqCQFAOLtkIYs=;
        b=UzVR83q48+7F7ridjNqEiPaeVteUS9EMafdhHdFiouIER868FeOlSLOAEMdlWkgzfW
         UIPUOJs4jxgqnHiOu4dfYP4PUurh63s0XyJ8LD+1JfREZ1g+jje9sA0nZdzvazUD7DCx
         JlEvrKKtUToihlJO/kRMaZfqc5Q3s6N0Ps624oDCUxWcwOEoIndJKxqkUuKG6bEh1u5z
         USj0nV4pU8NJPsNRmnSbLcavINoqsVSVrhluAKFSlKZZ4l+Q6kTJUhGsGWqB1fROGEIf
         6ZItkUe9s2RzMr4pFi3KE2sRFwPVpszjsQ/w7oDc/rkwy4iJKGbQBDzqxvzgDrdZ7QWF
         ZiMA==
X-Forwarded-Encrypted: i=1; AHgh+RqpRLC/sbCDsN+/oXaJ/HwckglT2RY5RTIvKLMTbCGgcGdTNgq3+5s7XFc7nEf2A9veZRkcb9JzpjurkHVM@vger.kernel.org
X-Gm-Message-State: AOJu0Yy4U5azcdu0S5jtTIUG1jH8kaGC9FwWcpr2mB9vc2jHpE5mKggY
	sXQ2gR+zJk5FlTlAvDUrzkUS6lCpJsLKpPhOGri8eq4HHHIvZ4gJwY+J/USUy8LN8+r42b1SWfe
	kNCh6vhQQlOcIpR6zDG9EIVTld0qdpg/3EW5bXGvsx5xKheMAS8ouBYBB+U8kYNUumg==
X-Gm-Gg: AR+sD10H2GrpB6c3WbVoewd6N4Xa7iCbOdNzE+DwDJh/C8LB/rfGNNbIyPiUKYWdJDa
	q4M58x5U+kwPZymrQVSMGE3HM5IPKMzFtIc1ISky7yANpvs+oVEm1+XS3PsNzQjfc0iWKJhvXH8
	SWGymGJQ2JJWDasORLRf2RfOoXbrsM+HVpSKWHLOUc18U/HLSLc81LwPkf4B0RD/eA7jB8XZsZ2
	cCuM1rBYhgws7BEKIqgejihpgExnUrb2LiHeeMJmiv5F4WRHfTI0Si6NJH1pFoU0Vdw0yoOwvRn
	dm3Vs1W91IBerLG6cxXeFR8MS6k6GodKgadsOKtQnHGWT36e7AhhzlJTk6sewmfCTYgXIbLQuGc
	jeR+zRGL6VpfokSQ4KiNs5exFkYXdNC5+Il0=
X-Received: by 2002:a05:600c:c87:b0:493:fa66:4861 with SMTP id 5b1f17b1804b1-496b5747df9mr103190365e9.25.1785152402887;
        Mon, 27 Jul 2026 04:40:02 -0700 (PDT)
X-Received: by 2002:a05:600c:c87:b0:493:fa66:4861 with SMTP id 5b1f17b1804b1-496b5747df9mr103189935e9.25.1785152402345;
        Mon, 27 Jul 2026 04:40:02 -0700 (PDT)
Received: from aalbersh-thinkpadx1carbongen13.rmtcz.csb ([217.30.74.39])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-496b499ccb4sm225617015e9.10.2026.07.27.04.40.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jul 2026 04:40:02 -0700 (PDT)
Date: Mon, 27 Jul 2026 13:40:01 +0200
From: Andrey Albershteyn <aalbersh@redhat.com>
To: Eric Biggers <ebiggers@kernel.org>
Cc: Andrey Albershteyn <aalbersh@kernel.org>, linux-xfs@vger.kernel.org, 
	fsverity@lists.linux.dev, linux-fsdevel@vger.kernel.org, hch@lst.de, 
	linux-ext4@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net, 
	linux-btrfs@vger.kernel.org, djwong@kernel.org
Subject: Re: [PATCH v13 02/23] fsverity: expose ensure_fsverity_info()
Message-ID: <amcy2KC3veaniXof@aalbersh-thinkpadx1carbongen13.rmtcz.csb>
References: <20260721184346.416657-1-aalbersh@kernel.org>
 <20260721184346.416657-3-aalbersh@kernel.org>
 <20260724233744.GB1901@sol>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260724233744.GB1901@sol>

On 2026-07-24 16:37:44, Eric Biggers wrote:
> On Tue, Jul 21, 2026 at 08:40:39PM +0200, Andrey Albershteyn wrote:
> > +/**
> > + * fsverity_ensure_verity_info() - cache verity info if it's not already cached
> > + * @inode: the inode for which verity info should be cached
> > + *
> > + * Ensure this inode has verity info attached to it, it's assumed the inode
> > + * already has fsverity enabled. Read fsverity descriptor and creates verity
> > + * based on that.
> > + *
> > + * This needs to be called at least once before any of the inode's data
> > + * can be verified (and thus read at all) or the inode's fsverity digest
> > + * retrieved.  fsverity_file_open() calls this already, which handles
> > + * normal file accesses.  If a filesystem does any internal (i.e. not
> > + * associated with a file descriptor) reads of the file's data or
> > + * fsverity digest, it must call this explicitly before doing so.
> > + *
> > + * Return: 0 on success, -errno on failure
> > + */
> > +int fsverity_ensure_verity_info(struct inode *inode)
> 
> There really should be a note here that if the file is also encrypted,
> then the encryption key has to have been set up first.  This was already
> gotten wrong when it was proposed for overlayfs to call this.

Sure I will add a note.

> Do we also need a more specific contract than "-errno on failure"?  The
> caller in xchk_inode_setup_verity() tries to distinguish between
> "metadata validation errors" and "runtime errors" by checking for a
> bunch of different error codes, and I'm not sure what that means
> exactly.

The scrub checks that if incore fsverity flag is set on the inode
we should be able to read verity info. If metadata is invalid,
"metadata validation error" happens, then scrub will clear fsverity
flag on incore and on-disk inode.

Not sure if this can be improved much, any new error codes won't
trigger scrub. Passing int *corrupted everywhere also doesn't seem
to help and changing everything to EFSCORRUPTED will change
file_open return code.

-- 
- Andrey

