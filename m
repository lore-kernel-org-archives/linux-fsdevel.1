Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 049371DED4C
	for <linux-fsdevel@vger.kernel.org>; Wed,  1 Apr 2026 00:39:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775003997; cv=none; b=TAyci2PR6/FvmpdFUHHLMXHqsP+5qoMQhKxesDPYnB/2KGfKKbnnnBc8wNxSGFL3Tpj/rS5w+LIwRQOE2gS9nReg9LkjEtYr4Paf/jntxtqG6jWLRz1K/glWGsiHVAi4htEqH6F6HDIf1tK5LUbWOdr2i2NA6GWwxqPvHjETtc8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775003997; c=relaxed/simple;
	bh=wmSFvBfh4bZliCkgGsH9ns7uhrjGl8UKSk7zMYjjaMU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=n2a1G0gC6vnZPgPLt7auKxZDfrmS+2jgMWcNG+MMUzy0PJDzXuJ9MPBLzQsNd2NQ9SDtS2dwX+OLGZqo8SMkyqpd2ZflfjM1HUcDK9Ix/0FeTCd0lVYBs7TUsQ+vm5HcIcUuekli3HDFw1a8X2BTVrRBq7AwXpcB2lHDO5ekPJQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=fwXnNihg; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=DsUaTbES; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fwXnNihg";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="DsUaTbES"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1775003995;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ZlAyR4IsTCd6Wy9tY8fsi0F7XjnqGFSW2B8UQN2ZazM=;
	b=fwXnNihgx1DSAhtOamatFR15FV662OWPCGO6ik+eHZ0cZh7fvhNsP79zfb0EYU+WgLHn3U
	FC0PN8RxISRmbgK5cQChGvL6uLCX1BWQW2dvFzI9CmDjY4ozC+LFU8TNMxA8aKkROkLHYL
	wtIaOO/mx6INWBUfbhG6YpOQ/EpOeLM=
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com
 [209.85.215.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-648-3lWV1ZmEMsGroaPAVLe97A-1; Tue, 31 Mar 2026 20:39:53 -0400
X-MC-Unique: 3lWV1ZmEMsGroaPAVLe97A-1
X-Mimecast-MFC-AGG-ID: 3lWV1ZmEMsGroaPAVLe97A_1775003993
Received: by mail-pg1-f199.google.com with SMTP id 41be03b00d2f7-c7385a1476aso3997842a12.2
        for <linux-fsdevel@vger.kernel.org>; Tue, 31 Mar 2026 17:39:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1775003992; x=1775608792; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ZlAyR4IsTCd6Wy9tY8fsi0F7XjnqGFSW2B8UQN2ZazM=;
        b=DsUaTbESdyWwWwnOcJxuedkKiT20EeVnZqP1BgvtcRtLEVfF4yipsQRW5BXewgL5Z2
         +SqsmHm8P8TuySf4SU7QifdFu1m5FYujDTfy/+ZMcnTjNNM4Kiwb1SSX+6HFRaG2CUI5
         j6Tl4Ca8S5UiCDFEItGRiod8bCXKdrqpXOOq6DcjB4alrHg6ginQIbl2DJN1qM5bIaHZ
         244kvJsl92LSZqzs+hiE9sN5QXM1QGEES4yufMtZFBGliYrKJRgZElkozjcXUw3oKFEO
         rPkcIlf/sDFLPGmX4OdClGMj/fyqq35JVqmOYQHu7zgdPSSUFxh5zV2v6uG6TkRbx0yl
         B67Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775003992; x=1775608792;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZlAyR4IsTCd6Wy9tY8fsi0F7XjnqGFSW2B8UQN2ZazM=;
        b=XT7nZZ4BKXICVRJUx3jpU/GQNXjF3Ri/o2Xh1FjEee2AKwBRVDg9DW9sh/E427s+Iu
         /qAJMiRtwLcm2W3RMmLxZyqF+IhE+qaRpCnFofOGK7pYNDfy9Y1b4AQg43OFp6OCMlp7
         maj6FVxyrBx5+XlKzzWX20hIMzyUBaP8K79gPSs5IiS2kItqMCz9bgz5lm0gecIy/aKc
         YFWyG1EgfBnECCCtAe+8bUOdzX2p97LhIJDtb2oC60igCbE+qBSXHSD1ZT7eHJpTTsbs
         AXHr4gJShCfWcTYC0YLL2im1kYRSH3JqbUS/imklh4nkfLpOlNSigwsRp3DurwYAWmuX
         Db8g==
X-Forwarded-Encrypted: i=1; AJvYcCXU/DQvELANI5APjZa//jYqOjrpmN08HbSftQu8FHKG5Ncr5MkZXfujUENnX1J2xVME0vni2TxOsbIb7ySz@vger.kernel.org
X-Gm-Message-State: AOJu0Ywi8tscFNYEmQmyuE5QlIgxWtacQpnSoY57hbt4yLUI+N9Cgcjw
	2zqIdX23uqx6+h7nUIFsPc91YipdcoMtE5uTubx3RKUbbb0RfHoHP21ObQ7dDRV67myPLLaQx1b
	OOkYl/NijFtgsdGtlRxYnUkW49VUr9OPwih/kxvoGIAZ9od8p6UV4e7pXxoFfAJHg9Z8=
X-Gm-Gg: ATEYQzxYrtBJnPkm9iaUaYCoh6zUMHVm4W0CgmqfvLy4xvkKtdEd92Z6dI/0DFQz9du
	X/8G6w1h3KdY3LMnkQtT5wgcEw94D3z69my+5YwVIkCiccnwxs2X/B/iuPsypEBjGo3j+VGlK3D
	crEbJzPmDCLwScNstZ8I337xAYIt7Xiy9JWSMt1G4StXftfvxmKCykNkBJ75Kwsnn9MWuvz/aHQ
	p9/FGZToy+Hyl1bwmd3PCOpLInTExIvHcUBJ581kh1CHl+2Do9UXTpipolUrx97dytuxWAWPM2O
	84FzNrM3TTAEPL0X9sEkQte/hWbAAzm9iq5PAyf/yQA7qC0FdlEcN+Q7ZrSpfzBrwlyxBQhyaDk
	xnXu4C9SwnFKL2qOHfA==
X-Received: by 2002:a05:6a00:94c9:b0:82c:7767:5bb2 with SMTP id d2e1a72fcca58-82ce898c25amr1699799b3a.21.1775003992505;
        Tue, 31 Mar 2026 17:39:52 -0700 (PDT)
X-Received: by 2002:a05:6a00:94c9:b0:82c:7767:5bb2 with SMTP id d2e1a72fcca58-82ce898c25amr1699778b3a.21.1775003992032;
        Tue, 31 Mar 2026 17:39:52 -0700 (PDT)
Received: from redhat.com ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82cd706985esm4659303b3a.34.2026.03.31.17.39.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Mar 2026 17:39:51 -0700 (PDT)
Date: Wed, 1 Apr 2026 08:39:49 +0800
From: Li Wang <liwang@redhat.com>
To: "David Hildenbrand (Arm)" <david@kernel.org>
Cc: akpm@linux-foundation.org, rppt@kernel.org, ljs@kernel.org,
	Liam.Howlett@oracle.com, vbabka@kernel.org, surenb@google.com,
	mhocko@suse.com, shuah@kernel.org, aubaker@redhat.com,
	linux-mm@kvack.org, linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v4] selftests/mm: skip hugetlb_dio tests when DIO
 alignment is incompatible
Message-ID: <acxpVd5hQUuGPQCF@redhat.com>
References: <20260330125307.98581-1-liwang@redhat.com>
 <96d14f27-ca0f-413d-8b61-768933ee70ba@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <96d14f27-ca0f-413d-8b61-768933ee70ba@kernel.org>

> > +static void run_test(int fd, unsigned int start_off,
> > +		     unsigned int end_off, unsigned int align)
> 
> Nit: prefer to-tab alignment in MM land.

Yes, I noticed Andrew (thanks!) corrected it and added to -mm mm-new branch.

> > +{
> > +	if (!check_dio_alignment(start_off, end_off, align))
> > +		return;
> 
> Is there a reason we just perform that at the beginning of
> run_dio_using_hugetlb(), avoiding run_test() entirely?

That will make the run_dio_using_hugetlb() have too many args and
uncomfortable to read, yes, it's more likely personal preference.
 
> In general, LGTM, thanks!
> 
> Feel free to add my
> 
> Acked-by: David Hildenbrand (Arm) <david@kernel.org>

Thanks a lot!

-- 
Regards,
Li Wang

