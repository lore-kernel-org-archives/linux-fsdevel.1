Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E2F34E36F7
	for <linux-fsdevel@vger.kernel.org>; Tue, 22 Sep 2026 09:00:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790067637; cv=none; b=EOOlqTJAIUbwEPA7wSGEkbqewaP2KE9qc2nKX/Xi2Ud68Wa1lmWJtTTaDCG0yVQw/olfzm4cRMT5zYz7XiZbZ7h3qbZhiCt6F6FYXXdH+6U4qPrlJXUHFVPuzSUjh2QLzARH/29N6nXluprk53FCWimvDkKYbN1WyL9+JxGpDpA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790067637; c=relaxed/simple;
	bh=HmmHSOBi6Fqj+ayaB0kp+lUWkEfnbaCEl7Q3FaEXEB8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gBu/t64QHmgw1F6S8Br9Y4FjAidu1VJCF5Vg170pZ/PEjxtNH9uvwFy8qs17RjtDTdhiKC0f3kyUjbzWNx56sQrQFYun7t2tZa0MELQAUsN6BOQ4ZfjoVpV9qRJ9gl32FXN9FUoN2lKExOxrwD2984CDtbamg7uab1JU/jK+7EI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=SnYZK+LM; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=KOE7z+u9; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SnYZK+LM";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="KOE7z+u9"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1790067635;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=8YJMnxCx7h1aVciSzhmVbEN46xY6rfHQRJ4daqV9A0s=;
	b=SnYZK+LMDE7gGrg6l7IcDTNmdilwHNWT+A9W8Te1ofRL9Zr1CaKTdMm8KwHy+46xpFCjXW
	u84pw0HkfUxXtFFswxPfyiS6tU6uzgNAwYhQSpjqIOPvgAfTspnn6+0/p2nvqnKIxpUGgW
	ltO1EX/PmAJ5psyFvmEu4zyrSOutaxc=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-546-sSzwobLtNbW_pzxRSX-sXw-1; Tue, 22 Sep 2026 05:00:33 -0400
X-MC-Unique: sSzwobLtNbW_pzxRSX-sXw-1
X-Mimecast-MFC-AGG-ID: sSzwobLtNbW_pzxRSX-sXw_1790067632
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-c29d3ad6b74so230671666b.3
        for <linux-fsdevel@vger.kernel.org>; Tue, 22 Sep 2026 02:00:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1790067632; x=1790672432; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=8YJMnxCx7h1aVciSzhmVbEN46xY6rfHQRJ4daqV9A0s=;
        b=KOE7z+u9C7oNATH36eQvXSuBqjV1NU5/FO9jlqNU2ITbJWF77RuMnDaWGbvqellU6G
         LQcQ5DvfLM0x6Chn7TBVvQLcH1dVaTvvhc7/tQTzT4aCZlWSXjRHDXuU9kTJ/9qWikM8
         gO2t1AuwdLF3v0KGq6sn9JLe5GT+Xa2xPt5Aa9IVLzGsJJvkdsq/LPEqPaT+KsJ15Zen
         hWyR0r0mgILogLJwoOPi7Nh+dRL7c6+zsMZ6Fu67i5Fkix2qEJtgrcLVlDYSMSe8nFgA
         4P+of10ZZjAfU3JdpL1Pe426SNH+wogIdGLT5tc75Tpx1bjcPPZJ0Ef2Ug+ogv2OXnq8
         dN1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790067632; x=1790672432;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=8YJMnxCx7h1aVciSzhmVbEN46xY6rfHQRJ4daqV9A0s=;
        b=mf+Bb7EMdHg/mMFLAxYVSkPyaiiEtDuszk7bxqvY6XkVLvq8c9P7BC3NrtvZqQeo70
         dZ6wvN9Exq03VQDsuShQmksW7ehIJz7afZe2lGTF8k4p79xdmjf0duLxhY4sZDET927O
         vfHKnYo5nDeYfBd3l4ocyLljXxUKu28/AVD3GMyh6rH4orFQxCg2i34TQzOY7wKWkmxq
         kCIDMPqQCdf5LwmhYI5gkOyWzf2N+d0mFbkYCuqokEmJLkqae+zEuINTGtcsId65MLOf
         b/u7SabEYrmRfvgEN4W+TFkqKtsSOb0wP4Uyvtzcjro3RHjYps4LKlKVRoW6exJnYsjP
         IIvA==
X-Forwarded-Encrypted: i=1; AKwUvBxfDHBDYxmN3WsQAmeJEC8BDFQSiXx7a+wDzq/BRtZ54sfvHTST+xEu5IFUmWpXWv5lYhdmLNJ9RsPqBWpB@vger.kernel.org
X-Gm-Message-State: AFuF++moZFR+m8w35/NOWGv5OdSzGpHJ3KO1R1RCsQD1r96AhU+BC74g
	3/GIwgam8denaZqI0MFOngOb8Vg/zu1UfMqG+Uj39efhwS5yB28BayDA7l2D1Pmu08A2+h9Ej5g
	pY6SlNjtDGnt4TX+S3TAEDN1fgwxDEhcVzebugz1/zjPyOvsLKfhEBmEdcj9AYayhKA==
X-Gm-Gg: AYBFou0iFGNU/vOJ/7NZ3Hx6Lc0sDOsXXjlcQvnIvCXWYRv4dIi0+47a1FUOTBbv/nn
	rhf8SO5q+W5tCOduAAQgSFySZSSgpGFhYmplzpdiohPUGkFnf4MOaEArB/h55/NuSKM+Uq9dekk
	zOzaq7G4BakqTat10VRpHV3jJPxpKW5abDaEyjimWzX6O+raLOWtamQDIWT243/WYwmxGUbJCas
	+nd4j0K7hk94w+WAspCQ3vNroGiX+HZU5h+rvwTvwVVS9OiCqxXS7ekvwhIM3Ni5Vk/OddSCi6k
	+RfrNOcJnQLsbKIHqErVtXu0Kcm3cmbMPf2zx0P6a+xKTAOv1zYvASAyEgCSCGGE5gE1wjfDA1n
	EGhQIA+raO5ChK6cnY5AjuC0Veai8h1Ubgg==
X-Received: by 2002:a17:906:9fc1:b0:c29:4a1f:76be with SMTP id a640c23a62f3a-c2a15703413mr1217330366b.20.1790067627790;
        Tue, 22 Sep 2026 02:00:27 -0700 (PDT)
X-Received: by 2002:a17:906:9fc1:b0:c29:4a1f:76be with SMTP id a640c23a62f3a-c2a15703413mr1217326266b.20.1790067627294;
        Tue, 22 Sep 2026 02:00:27 -0700 (PDT)
Received: from aalbersh-thinkpadx1carbongen13.rmtcz.csb ([217.30.74.39])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c2a9c4309c7sm51460566b.6.2026.09.22.02.00.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Sep 2026 02:00:26 -0700 (PDT)
Date: Tue, 22 Sep 2026 11:00:26 +0200
From: Andrey Albershteyn <aalbersh@redhat.com>
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: Andrey Albershteyn <aalbersh@kernel.org>, ebiggers@kernel.org, 
	hch@lst.de, Carlos Maiolino <cem@kernel.org>, fsverity@lists.linux.dev, 
	linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org, linux-unionfs@vger.kernel.org, 
	linux-ext4@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net, 
	linux-btrfs@vger.kernel.org, david@fromorbit.com
Subject: Re: [PATCH v16 00/21] fs-verity support for XFS with post EOF merkle
 tree
Message-ID: <arJC542mXklAeswE@aalbersh-thinkpadx1carbongen13.rmtcz.csb>
References: <20260918111539.1003439-1-aalbersh@kernel.org>
 <20260922045144.GP2705364@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260922045144.GP2705364@frogsfrogsfrogs>

On 2026-09-21 21:51:44, Darrick J. Wong wrote:
> On Fri, Sep 18, 2026 at 01:15:12PM +0200, Andrey Albershteyn wrote:
> > Hi all,
> > 
> > This is next revision of fsverity for XFS.
> > 
> > The main change from v15 is addion of kmem cache
> > xfs_fsverity_ioend_cache instead of adding work_struct to iomap's ioend
> > struct.
> 
> FWIW, Sashiko found at least one or two bugs, but the reports only got
> echoed to the ext4 list.  Perhaps it's time to discuss allowing it to
> email linux-xfs for bugs that it claims to have found in xfs code?

I'm checking its report for fsverity series, but for other patches
not that often. So, maybe it would be useful for "critical" and
"high" priority issues (not sure if it's possible to configure it
that way).

*this time sashiko sent me a bunch of "no regression found" emails
which I think are not necessary

-- 
- Andrey

