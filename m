Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F38073EFD15
	for <linux-fsdevel@vger.kernel.org>; Thu,  9 Jul 2026 08:51:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783587109; cv=none; b=f9AfSv3dzpYDpLvVg5KcP/Fy8hGXwGBfk1WGnTAHIWJKfQX4WypGIIQ0Tb3dA6UNG24c/rMG7EVP7IVHrS7pKa4mc/DNvlRWovtSX3/3BC72Avp9aexXIXSOqYYQzD9+stVrRpTzziEut+pMIbt/FupwH6iU7Nb0ea2vsRqOXDE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783587109; c=relaxed/simple;
	bh=znq26plhwxInEG6rMm+26AmDR8mHesOo4g2XGqxnm+E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aSbsG5Rjeuaa2AVDLThKpUTWkUprRcJ99LNtWEqlTD5ZAq1EKVDVK7pcrah2wIfbxzNk8ccQuteSIq1+/beoC5vxjUrJYKPdYlDXo9qw4v02BEhYsWrInX4kydfqup+xmHj1JALnSqT4shel2ZmVuUDzdm6Kf2WWgSUTtB3lDl0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=iza834L5; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=mb9tmnJO; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iza834L5";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="mb9tmnJO"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1783587106;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=eb5jDTkXBTPOE342mmNfwm5lDoBFxjZ2KPIK/Aydl/0=;
	b=iza834L5VL4ghd3uS/qwfK26v06iCDCHiZ2z7zsaJ0ylLcpa1eWADTc9i9X/fWm19bl264
	QgI4N5jNYKNxZTzfat48yOmrhvb4Ppip5zPTruRZhbA8nwMVjFxHxJrVCipqrgHMlrH0Qy
	8cA6E9aJVUxYbReHXlmNFov4FiM2kHE=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-681--PPxiEaLON6q4odSo9Yy3g-1; Thu, 09 Jul 2026 04:51:44 -0400
X-MC-Unique: -PPxiEaLON6q4odSo9Yy3g-1
X-Mimecast-MFC-AGG-ID: -PPxiEaLON6q4odSo9Yy3g_1783587104
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-493ce4b7777so11770265e9.3
        for <linux-fsdevel@vger.kernel.org>; Thu, 09 Jul 2026 01:51:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1783587104; x=1784191904; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=eb5jDTkXBTPOE342mmNfwm5lDoBFxjZ2KPIK/Aydl/0=;
        b=mb9tmnJOxe0IeNGz8lpg27hc0lZao0ZDKiErb8gR+oA1BiN/M0lEjw703xzD/rhdRo
         TaSzi7ZFGw/M/gLoZmBUquUvTfTEgo2gjYfqZCYRAwgnL4AcnzmZgKGTVcBjfSPNICEJ
         vMO/w0GLOdKHabVF0gAlcG/BYJTV7A3tnSIsrfa9HFGiOWHaZtf9scgQobSq7VK4r+ls
         JBC7nremmJR/3XtQewg5q4xDZAyFrZZ1z6/VziesNr59dPCAdH2KnmhMv8DWF678Rr8P
         2NPcS4x3HD36QI0TsD3LLrsUcKdPimzk5uINsuWpHb5o59TzVu79mfEziF+zBU4e+pbs
         mu5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783587104; x=1784191904;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=eb5jDTkXBTPOE342mmNfwm5lDoBFxjZ2KPIK/Aydl/0=;
        b=Zfp0htZ+GWwjs6nW4A2TWkVp6N+CgLLhR7JvQlFuz5mRUc4FcGat3i971xqgthf5zV
         1GDpMuV8EyOd23Nyhng7+SjyP9K/oICpqmfbJb3wWJQlIabA+c66oyKuyeVbd6uo4CBN
         vBzvWbzml1G7LI6lDYLjjw7KJvI6d0iWBGFy0+jsXmqZk2uLvijWUKRWKEcwxSrKRZQ7
         8ccocHShVNMGxeSvYmDSUrRYk9AGnnVPQqtQAGM71ALtZibz5StguVsSe+an3BlaT1M9
         XjK4WbIrSxFGAkHcH/PWUEVs04i0REjxfVnPURM/RBXOzO9J1i7l29ddOFOQBy/DjX5m
         cKqA==
X-Forwarded-Encrypted: i=1; AHgh+RrKdQaE16FTmFhUo1eKW9SMLUrl1tLNq1j8IxlpRtbGXGNm2Hd1tHr79yLkR+JucNffLs9X0/BYpJ/mpNlC@vger.kernel.org
X-Gm-Message-State: AOJu0Yxnjf/Z8Gu4/s3zwqjMwT9dNs6vfL/IPDm/nY43NDUqTann3Lwe
	6OFm/7vyQllM9TtVVcjN9m++tTUxXjLJApxgpS40bpLuVR+DPnUwdeFMJRs869pgK2TSPZ+c0LY
	rRTQr6Ia74RDJ43FOgP9TBkAazL1P4jJAmHrc3rOpMraH/94ObhNErcDYw/2tbZ1Ihw==
X-Gm-Gg: AfdE7cl19iOqxm+r4vI0SBXIUDKXtrgH+SgXGNWmzPxMPwQWfqgjW4Vei9RcSgyHUdN
	qNgbdyN2aFjraRNAvUMzBXKBZrJJ8TvuhptkjBwiMbKnL4BmxQeyNjUvhrRenaVbxBzS9fKUMlM
	f5ZKgjwBAj9vjJQq6fiHTigaBoRE1frIP2nzokBLIJS0ldQUS/+1njTmgf9i3JeHlMq6kp2mij0
	k544yppwzlnFFMSYNaTwBIj/SxfucZlABNKmnyUOeXhBD7PeUQwYPJ6RfzHL2ifUzldn6kI8Wpo
	2kLTwy5+EtraXfcW+WOKEQi2YH82UE4/j/kbd78vI6z/0hEO0utHhTLqF+pqmNPpG+cpTIZbtRw
	3lRekCV4aFWW/b+MnS8QmBKVNAoa52lQO7nLNtQXfHlr37A==
X-Received: by 2002:a05:600c:628d:b0:493:bcef:5646 with SMTP id 5b1f17b1804b1-493e6862b68mr57369715e9.12.1783587103536;
        Thu, 09 Jul 2026 01:51:43 -0700 (PDT)
X-Received: by 2002:a05:600c:628d:b0:493:bcef:5646 with SMTP id 5b1f17b1804b1-493e6862b68mr57369285e9.12.1783587102989;
        Thu, 09 Jul 2026 01:51:42 -0700 (PDT)
Received: from aalbersh-thinkpadx1carbongen13.rmtcz.csb ([217.30.74.39])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-493e5a5d174sm144100205e9.2.2026.07.09.01.51.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jul 2026 01:51:41 -0700 (PDT)
Date: Thu, 9 Jul 2026 10:51:39 +0200
From: Andrey Albershteyn <aalbersh@redhat.com>
To: Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@meta.com>, linux-block@vger.kernel.org, 
	linux-ext4@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net, 
	linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org, axboe@kernel.dk, jack@suse.cz, 
	brauner@kernel.org, cem@kernel.org, jaegeuk@kernel.org, aalbersh@kernel.org, 
	tytso@mit.edu, Keith Busch <kbusch@kernel.org>
Subject: Re: [PATCH] fs: report direct io constraints through file_getattr
Message-ID: <ak9f0CXSegLq8l5w@aalbersh-thinkpadx1carbongen13.rmtcz.csb>
References: <20260708011843.1036846-1-kbusch@meta.com>
 <20260709071352.GA20180@lst.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260709071352.GA20180@lst.de>

On 2026-07-09 09:13:52, Christoph Hellwig wrote:
> On Tue, Jul 07, 2026 at 06:18:43PM -0700, Keith Busch wrote:
> > From: Keith Busch <kbusch@kernel.org>
> > 
> > Memory alignment constraints for direct io can vary depending on the
> > backing storage hardware. Provide support through file_getattr to report
> > the attributes necessary for applications to know how to construct valid
> > read and write requests.
> 
> This probably wants to be split in one patch for the new UAPI,
> one for the helper and one for each user.
> 
> And especially the UAPI one needs a much more detailed commit log
> explaining it, including why this duplicates some of the informastion
> already in statx and documenting the semantics for all the fields.
> 
> Andrey, is there a man page or other official documentation for
> file_setattr/file_getattr?

No, I had a draft in cover letter but haven't got to sending it to
man-pages. I will prepare a man page.

-- 
- Andrey

