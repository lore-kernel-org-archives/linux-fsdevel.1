Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7983A4156E8
	for <linux-fsdevel@vger.kernel.org>; Tue, 11 Aug 2026 08:18:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786436293; cv=none; b=Juziq4dMMOPdmqBbByR+ibsb9CZQh7fOu7Xs3Y1iIZkIzuobzEqBX3TQX2sBBK2+R3d1CMh+nKPJRYAekG+CYCmnVSdqHag2GEztruSiSVRwu1IcYAcDfCSHpXarCc/095xvyDwYRU4vNcSvYagN8yF7pXCmf1vTiYOV5ZqoPhg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786436293; c=relaxed/simple;
	bh=0m0VCrVFS50IL0+ZPUc8eV8aQ+yXJjlZWMeXsIJ1aBM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=l1XedoIsmATLhD7vaYdnRNzcg2xAqOmw9u5y6+TKGQEjw67glx5sW7AJSJm7/af8PK59yDJscb/tfGFnUZsUHlrdYLkWRhAMMT+gOZfEXPNwA/aYp/560wcrqY8W77aCcm+xR0FuGPyEZogyzYsQR89tvAdwPvivtzABMX7F2P8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=jGk31qTM; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=QmpED+JA; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="jGk31qTM";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="QmpED+JA"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1786436290;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=rQoYgawLl/uFdgKGximNInLlgWg1ECp2Ql+MmIdl1KM=;
	b=jGk31qTMZe89vYcLuMtG1w29oh5Txnm9VLlzyTkNm3Pa+A6Hs3LmIVqpzk6aCJKSCVSHOF
	ZX08u9Tdo/pGoR9S45MDsa+weOr+Wf0SpIQrTFJPGqoru8QyDmOmNOR17nz7K4ThLaYpYe
	Lk1eI6MtKN+3gHV+Q9eWuJAvhVPG1x4=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-362-cobujxLXMsCEDwHVwiHQCA-1; Tue, 11 Aug 2026 04:18:09 -0400
X-MC-Unique: cobujxLXMsCEDwHVwiHQCA-1
X-Mimecast-MFC-AGG-ID: cobujxLXMsCEDwHVwiHQCA_1786436288
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-4954a93c565so14789065e9.2
        for <linux-fsdevel@vger.kernel.org>; Tue, 11 Aug 2026 01:18:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1786436288; x=1787041088; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=rQoYgawLl/uFdgKGximNInLlgWg1ECp2Ql+MmIdl1KM=;
        b=QmpED+JAJESU5FyhCyTatmFHkwiMWEcr86kck2O1E19QIoD8iACqFSniC+z71Bpfq4
         lHB1cC5988ZWcEpXS2jBbpl+8bXcTaLF8Ptn6iuAQctnkw0EAWlxJH5T4lbUGq24RFMp
         GJqAElN8kpyPqFyZbfxEMzC7fY4Adwq29Anc1K6TT3RoJ8W6Cepb59LpBtoTldmd57sv
         +RK+pY23KXHX7vOSXvBWA/75gbtexXvCU7XavuoLarCi2r+Po0wiHkarYvRaQnDOgE96
         T/kbvYnmh4mQ1APbZLZmE5zJErEFlCpDXIta8RUNNQp2k8wDRzLHurpwSIdNXVBl5PSW
         UJ4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786436288; x=1787041088;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=rQoYgawLl/uFdgKGximNInLlgWg1ECp2Ql+MmIdl1KM=;
        b=qW9yf6Gj5xz6gOYaH4q/MubYZytC/O8yML9gaHsWb2ZyC0vmZoLSPdta01FBfxWGM6
         f5U8E1MIxKeqZ/3qb85Ih8yAWt6gdS9dG6OIhwsXHzSA/z0YPzx+Q2WCKi+vhTlol9Gl
         /OeEtz/G3RwVQNL4Sycc2xv6VYaLGrZrmDDyVC7bv28n1NgzpUaTFCkEfmPBpau7KrwP
         EDKzfFVlJf0Ze3gvhCYwZp0kLW3y2RixBWyKaYAN5BmwjgRv72P7wcAcNwd2A5i8yB3j
         /wjWT/ABotg5JzM2qiHELExMseR4hLNkTDTVyyF02l42u3kIYflhRO3QUPxsPI/j7gNX
         iapg==
X-Forwarded-Encrypted: i=1; AHgh+RrTGogrnXGiczhX2Uj5DvF6LNC2Y/yCK5oJJDg2+y9E1UYu9nQGRWee0O1FJv2tiLKqe8WODPeQGS4mbmqx@vger.kernel.org
X-Gm-Message-State: AOJu0Yw4YGysz5YiiyLNEA792dilmiR29oG006mF0XTzjm0SFcRs8hyY
	8BhSx6WZavjC1kiXvn56EEYplfjnHjyIAR52pIZwo+ZViMdG2Bld0z6xX39phkJ5tZjYyUMhWIA
	UNUldm+mK5jDd9eE7Sbw03cttM4ySQ0tQZH3jFgLmB9aEbRajTqV/35WwAH0FYK8q0A==
X-Gm-Gg: AR+sD12rtJ68kM+XzhJ8X14JmKH9cDAfKAYJ40l0qVQ7/a9CQI92F9q/gSdBqtWf0UV
	7WjvjrLWnEHdgvvYJSueAohjPG53Faow5hFa5kySRnLsELaUfuLAYAfOgjq+d5fPP3qz8kFzQAx
	dvzcB+2NCfS5UqbPw10gHp6WMwJ04QQKxPh1prvaLml35QZKfY2fA3hHRhHMFYCKKoY3Kgd2WLi
	XldrwAuTZ/iCfyBOSrSeC0wVqeERFVkiDGO7E61uhQxPNJ/qGGiiho+hHI7h2Ek9ObkOGbwZyCg
	NIvBbFAoIsXn6y6O0RZzWkrkPCxvFArRCoVDtPbz1FVeTbB5o7cGtHSayJZ6ScqQvjRJ/T0k4i2
	bAR6RdK+nWCyhZImkYs0NMtK1fxS2CoY3OgpVSg==
X-Received: by 2002:a05:600c:4683:b0:499:5210:c537 with SMTP id 5b1f17b1804b1-4997842c1efmr23685955e9.1.1786436287862;
        Tue, 11 Aug 2026 01:18:07 -0700 (PDT)
X-Received: by 2002:a05:600c:4683:b0:499:5210:c537 with SMTP id 5b1f17b1804b1-4997842c1efmr23685055e9.1.1786436287342;
        Tue, 11 Aug 2026 01:18:07 -0700 (PDT)
Received: from aalbersh-thinkpadx1carbongen13.rmtcz.csb ([91.245.205.131])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-499788f11b8sm26013505e9.10.2026.08.11.01.18.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Aug 2026 01:18:07 -0700 (PDT)
Date: Tue, 11 Aug 2026 10:18:05 +0200
From: Andrey Albershteyn <aalbersh@redhat.com>
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: Andrey Albershteyn <aalbersh@kernel.org>, linux-xfs@vger.kernel.org, 
	fsverity@lists.linux.dev, linux-fsdevel@vger.kernel.org, ebiggers@kernel.org, hch@lst.de, 
	linux-ext4@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net, 
	linux-btrfs@vger.kernel.org
Subject: Re: [PATCH v14 13/21] xfs: use read ioend for fsverity data
 verification
Message-ID: <anrZR9SarXJMBLgI@aalbersh-thinkpadx1carbongen13.rmtcz.csb>
References: <20260803200820.393203-1-aalbersh@kernel.org>
 <20260803200820.393203-14-aalbersh@kernel.org>
 <20260804183632.GO3556460@frogsfrogsfrogs>
 <anmNNNNy4YsV_KLB@aalbersh-thinkpadx1carbongen13.rmtcz.csb>
 <20260810183102.GY3556460@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260810183102.GY3556460@frogsfrogsfrogs>

> > > "If we have fsverity and block device integrity attached to this bio,
> > > we need to run both validations from the separate fsverity workqueue
> > > to avoid deadlocking due to fsverity issuing its own reads."
> > > 
> > > (Assuming I understand the fsverity && pi case correctly.)
> > > 
> > > One thing I'm not clear about -- why is it safe to do the fsverity
> > > validation here if PI isn't enabled?  Can't that also issue IO to pull
> > > in merkle tree blocks?
> > 
> > Without PI, fsverity metadata is read without XFS bio completion
> > path, we don't get here for the descriptor/metadata reads
> > (see xfs_get_iomap_read_ops()). So, we won't block the queue, as
> > data ioends won't be mixed with metadata ioends.
> > 
> > With PI, all fsverity reads goes through this path. We could get a
> > case that data ioend is waiting for metadata IO to be completed which
> > in turn is pending for data ioend to be finished (due to batch
> > processing of multiple BIOs in the bio_complete wq).
> > 
> > So, this will issue more IO, but this IO will not get onto this
> > queue (it will go through iomap_bio_submit_read()).
> 
> Ah, ok.  Maybe add to that comment:
> 
> "If we have fsverity enabled but block device integrity is not enabled,
> completion of the fsverity metadata reads does not require a workqueue
> so there is no deadlock potential."
> 
> then?
> 
> (Just echoing you to make sure I understand completely.)
> 

yes,

I've changed it to:

+       /*
+        * If we have fsverity and block device integrity attached to this bio,
+        * we need to run fsverity verification of data folios from a separate
+        * fsverity workqueue. This is necessary to avoid deadlocking due to
+        * fsverity issuing more reads of fsverity metadata which would be
+        * processed by the same worker in the BIO completion workqueue.
+        *
+        * Without device integrity, fsverity metadata IO will not use ioends for
+        * completion.
+        */


-- 
- Andrey

