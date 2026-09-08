Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D817C5111B9
	for <linux-fsdevel@vger.kernel.org>; Tue,  8 Sep 2026 23:20:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788909656; cv=none; b=MI/YMfbTDjXmLWgaEOXdIjRemmDldNzTJU9J69aa8h9MALIAFH1u3Gw1Vse7vLIKCnDS6lVknIwRlspPUCTRjVxpq/39mKsF3fx22IA6W3Yzp6EWqixkcsMknlYongQ8L6pJ1Y5VaihO9IziAejrS/tdOfjWsoWXVNkybn/3nQQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788909656; c=relaxed/simple;
	bh=Wecw+9QrgZirVokurAeBUMi9T03tj337LxegaPg13iw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EY8KJc3ajWHMtQLJ84YjgvqPShEIRXaLu02ZkS7sPTXRPDTiUb9pSDbW6uGqRctjWGU+T/fmCVFPXZBqmI19GrI6NMWFf03bvF0YCRHxMvkIvRF2PzMhAKsamZCcaQrI4Ffi6x/C1p2pn4+IpdKZEa/9XiysCPnLyrcx5iQl4kU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bobrowski.net; spf=pass smtp.mailfrom=bobrowski.net; dkim=pass (2048-bit key) header.d=bobrowski.net header.i=@bobrowski.net header.b=ERKapIL0; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bobrowski.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bobrowski.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bobrowski.net header.i=@bobrowski.net header.b="ERKapIL0"
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-38e041ea211so4316496a91.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 08 Sep 2026 16:20:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bobrowski.net; s=google; t=1788909654; x=1789514454; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=ME4T4I0fml2p5iiDAE13UqY89i33BgyIDriKnzcytM8=;
        b=ERKapIL0I28esERqml8fFrJdJFDB/nRClYalESgMt9eMxlQFdIKaythiKGZOo0AxHc
         4awbjlOGQhxUsbTzIdsfAd8wQRyViykaxFwC16/aPY4F66ESH+1dYFW48QMFztLkHNrq
         UFl2m+/TEcTmFPZPMHhtAZ0/gtteiIgK9VWaVlb8Jqh4EloZzomrkde7LyC2eIbylJ1l
         OxoTiLLUyi25YDSZIvj2lBh+T5ckyPWX5AZe95DysSvQDSJduE+MK8FOSkAjwlwohxrs
         0JjvR0hVjWcktRrmHdQI8FxnwoeGTzjwLsEzSXn8whW9664CFCR6/hq+qFxUggkzCMbe
         N7UQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788909654; x=1789514454;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=ME4T4I0fml2p5iiDAE13UqY89i33BgyIDriKnzcytM8=;
        b=CWyEMcpBJa2u+TOrKQrv0kPQUnj/1gRyEJ+UEK+HIXpfsScToX3m6S9A0C4uGQT0QK
         HbxD/P3nyGpv9XEo5tztK1MAUeeQbADanFsyOBPcRmH8lfES/Hh0v9jO6NYTZqGbY61y
         bgf1iPyemE8nEET2sOvrSxmlU0+rCTlXzUgxoysbnqhKcz1t34FersSwMWF4J0u/jAAh
         O/odeXkxkm1JfW70dZlVVy7oBLLLHnGXmY2uErLj4+E+ozR67sVMA5gAzGJnM/tkyupx
         vaxCKLXU7p84We02DLJQymAVtWNyjDwxOiiVKUhl1eyzD/EiNxrO47BOgIi4GLMGIrcI
         vGkw==
X-Forwarded-Encrypted: i=1; AKwUvBxavRzxmfaQAQzlYPO/fDZvYk/D8I8w8LZflFVDP5EIuvAkTfQ5aODHtShPw/x6iICLLKfqvOxgI6TYCurW@vger.kernel.org
X-Gm-Message-State: AFuF++noJtQgQH6UlJw9Y4PWyurV53OuSSbdtXAmLZ/Zj8234q8y5LsZ
	jJ2yYd4zFO0HA7kXKFbtH2jacE8idlKm1ItKur9GIDEW2ZAEZVLIe4nCapaeg8zEacGT
X-Gm-Gg: AYBFou00knpmc4AYmcIJ/3xXB+CrvwcQkE0H6Fla1m7FtkHoqMxKe4t95QPxoW43lmd
	LzL4XZq18x5kFOy+AW4IK3/gnEEod3RbNAs/zHRHVn3nOsZSBF03nFhfvW3bPs2AuoiB+mwnjuS
	5qkuIF3yzLNxfkhXI7y8qQfxg2+uRZKuZ2UkOCC7EIz/LRZO5gqAmBjfvMaEml348Z/mg7DEELN
	KFxTQVUgrGCGx9ZZNUQ4fRJ8pkzr6SEBWI/ckakohZYculUJsypOVBh7hVLaJEBE7E8yoItokae
	Ae9d7rnBK7mrNlA48tdmcWeb6h1niG/1P1Cf9e4x+s/sNeU5U/8z2HsjoFZ4G2bRZRkBdFySWbY
	InTzhuHJrirlHIRykCOA98y+MCLT0IC5yfKblHo35oI8R7kFGPVBXxgraJib9rHWZPNY+Cy/fT8
	Y+6cgUBeX6Nlq/n2h8QPOPTbNakLip3wgz6tT5ebksKAp7/KW9MPtDr0XfkWBXg46dHOLdqp8S9
	kThNfMMa0sDdwuR7vtIwzsiGtc7zLPcUB1Y4PdwdJL5QZ3yBuE=
X-Received: by 2002:a17:90b:2c88:b0:398:ba56:b926 with SMTP id 98e67ed59e1d1-39b262e28c2mr51899372a91.25.1788909653985;
        Tue, 08 Sep 2026 16:20:53 -0700 (PDT)
Received: from lima-development (163-53-146-23.ip4.superloop.au. [163.53.146.23])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3397c13dfb1sm1890239eec.2.2026.09.08.16.20.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Sep 2026 16:20:53 -0700 (PDT)
Date: Wed, 9 Sep 2026 09:20:46 +1000
From: Matt Bobrowski <matt@bobrowski.net>
To: Paul Moore <paul@paul-moore.com>
Cc: daan@amutable.com, KP Singh <kpsingh@kernel.org>,
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	linux-fsdevel@vger.kernel.org,
	linux-security-module@vger.kernel.org
Subject: Re: [PATCH v3 2/2] selftests/bpf: verify mount idmaps reach inode
 hooks
Message-ID: <aqCYTn8RwpqrPrgO@lima-development>
References: <20260904-lsm-mount-idmaps-v3-0-920a1963675d@amutable.com>
 <20260904-lsm-mount-idmaps-v3-2-920a1963675d@amutable.com>
 <CAHC9VhSmpwpvjVPaEKVVA0BnYkn1M+-f4wYDb8uvcL2MQfH9MA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHC9VhSmpwpvjVPaEKVVA0BnYkn1M+-f4wYDb8uvcL2MQfH9MA@mail.gmail.com>

On Tue, Sep 08, 2026 at 06:22:31PM -0400, Paul Moore wrote:
> On Fri, Sep 4, 2026 at 10:48 AM Daan De Meyer via B4 Relay
> <devnull+daan.amutable.com@kernel.org> wrote:
> >
> > From: Daan De Meyer <daan@amutable.com>
> >
> > Extend the BPF LSM selftest to exercise create, link, symlink, mkdir,
> > mknod, and permission through both the VFS identity idmap and a real
> > idmapped tmpfs mount.
> >
> > Record the idmap observed by each hook and verify that every updated hook
> > receives the mapping used by the VFS operation. This provides regression
> > coverage for passing mount idmaps through inode security hooks.
> >
> > Signed-off-by: Daan De Meyer <daan@amutable.com>
> > ---
> >  tools/testing/selftests/bpf/prog_tests/test_lsm.c | 231 ++++++++++++++++++++++
> >  tools/testing/selftests/bpf/progs/lsm.c           |  79 ++++++++
> >  2 files changed, 310 insertions(+)
> 
> Do any of the BPF LSM folks want to review/ACK this patch from Daan?

Sure, will take a look this evening.
