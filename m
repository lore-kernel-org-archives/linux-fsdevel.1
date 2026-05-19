Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE7EA348C70
	for <linux-fsdevel@vger.kernel.org>; Tue, 19 May 2026 14:22:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.179
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779200528; cv=pass; b=GVjOsiNPP2ycDjJfy4RBncsihY5SWldqfsGiODgPZ5Z8gZMRHAWIK14RdsEBrjjzoWiCJlZy9uqS1kjEneQHHbw6A9Lgw8e+LBBEIyCXzww4mUv2Ep4NO9Xsq+H2lv18JAH38knGBmRzO4P9kwJSQDPzaOxp6Xgk9PkmL/b/29w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779200528; c=relaxed/simple;
	bh=y+M1i1Jwkb3OqjTadF8kS1TR5MfxLtXzn9n20tTMyW4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NBYmygFWtbFQqi6eRgwT7XWieepEKdG0+APH0omvaSrTJG2MCtaIZT06sDDlGG6mHePmM2aNqtWjfxYF2iqYOvlDJ4fWDZ7GFtp6KCcSJLKTafTksu8SzmqrN7DAv+uQvvLu1WGfLYuqVBIAwikv7NQg7BzsH7VkxsWlIJqN//E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=hRKJuhlL; arc=pass smtp.client-ip=209.85.160.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="hRKJuhlL"
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-51306c9f2a8so44004121cf.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 19 May 2026 07:22:06 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779200526; cv=none;
        d=google.com; s=arc-20240605;
        b=JmR/43+w3U1CGe04zk41JZYymSMWu8Ez9xMBtDTyTMlAEJPfKF5OpJFJhUClldgFHQ
         1SelrnaRbLurHbdFlQAu9l6OHzRzOX/3PUaSVL0GcC8SOwYLthFNQW6ESgVDELf2heGe
         ZkFlJu8U1my8MbPw/IjVUJJXaZqyCKNy6biQmOt3EB9x+PFkkkzsw5KEzDR7IFHwSEGT
         NebQih3yh0qgEqHgQNR2myQlCq/8O5Sna3kq+qtGGIKTftFoDDS0iiJatMjrjTWfCUij
         4BgzRzVTKQnkw3aeIr/u9IJ246zFKFoHTfSKgqcANK5PTvip2y5Smu/hBzyzSLLTiu9T
         1f8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=y+M1i1Jwkb3OqjTadF8kS1TR5MfxLtXzn9n20tTMyW4=;
        fh=Oare2YH2opvM57pEc/6Qbes8Y7bpqcXZ/+s7apfjNzQ=;
        b=B66HTenKzE0MBKZm2HWiMLClQrttIdVsjO2dQYTmKK6+Ol4KSaMypaYZ7lREizwcj5
         jIeB5wlwvNWI7BQczOUBqgp3Etb70AFeEgX45h2f42vUswVDqiOpXy8QXVHsyJamZpQz
         /CXZsAwzd2sK3O3UALanzHdBc+9UkeYW5ZFcONy6b2nfIgoBeyCKWdsd11JSWqxIhL+J
         Kkfp8JlBSP0Y496+z1+CUeU9m7YwmST4YFvR35jYOsGS08uwJz7sro/JnCNmSGJvqkqs
         RcXwHpIvn4z2BLbY8znXfFihh1T1laitm9px3DBVKZ8LNYmDDH+bUXPEfHcakZwC/6If
         iJQw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1779200526; x=1779805326; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=y+M1i1Jwkb3OqjTadF8kS1TR5MfxLtXzn9n20tTMyW4=;
        b=hRKJuhlL58fyI7+79yckyoy52Q7uISZB+DFfJ2STt94ZK/v0rRuR7uu+4jYm9aZsKF
         7pzSZlsx0jO3F3QeXyZsyo/AKwi/VMj3Ss9LEdGybuKqjH1XYBzSJ76LoY02mPHlAMec
         3M/hGo/NgXzXr/jVvyCUuhMCTDv2Zqrj87fKA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779200526; x=1779805326;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=y+M1i1Jwkb3OqjTadF8kS1TR5MfxLtXzn9n20tTMyW4=;
        b=m/+XsrEj6vJek5CUgbK5WLqvSFWp61AWLxbu6duplxZnfAqu/vAuydpk1wowJvj+HY
         pbNylK2tq64V1Ewr1nb59xdkIrOs5ryKyORuXugk5h2DEGSWjBa8wYPYr4fH8/rGXLse
         niUTf4jztenTqHPBPxuTeLNYr1Jo0RSr6slLVjEHLQhrdri44RZKOq4K0nszf3tbnBnf
         P6HplXzsY3SpoiR6K29bIJHKk71fJEUz/gJRaVCHbbR43NCCZ4lionNreeLhdPWZU/6h
         9h2IJnc1cvwpEy7oLbjU9uImJeR++r3qIwz2LNun3tLizWb1OCGB+itldd1a2zsu0TnL
         B/Gw==
X-Forwarded-Encrypted: i=1; AFNElJ+VQCGdO1WA5hhy9sbpXa9ExglWjprTskepVWQl0Z/iQDUNMHv+SehN4W2LZ5feP364ylOtTX5UE+6d2eSb@vger.kernel.org
X-Gm-Message-State: AOJu0Yz3D4dbm849Uf7jndPOxRDtgQtO+wa8EJDRLNTL0YTD24jzKLVD
	jkey3OfpF8kXjtkvSFTF1Grkz9w2iXwISdwUCVwTMU8qOO3mPhCXolqUXzkbcmozGEBBtFhQik/
	tM8fMZP05pwiR4/8FCGlNZ+k0cnIS/f1P+QTyNbk9AQ==
X-Gm-Gg: Acq92OFGcTnGodDXvPAKBXKls56XH1pHFmEklk+aabQ3uYFYibRGXqYY6XjSxC+Yh4k
	8GMNCAXOIlQOOrDBfflqUPvNKZVn63D1212tAJ/BIPgqyGcXVUcPHcd/IZBG6ywmu1UHykiUxRL
	6Skj9h0lMSWbXrh8eQzikzzu5KIxobo3ptqk/4bs2+aQaO74SBTLdRe8lbDdT+DZqovFKc5184s
	15/A4qvVMDQYE1ZhEBLfY88Ux/ydOeotGDAdElfmSDw/XqppTkzkToD2N8tHZVg2pLatjiVcUon
	ytxURZo1p0dnkJqJaD8C2T/JhRzFAkzkeDseFlE=
X-Received: by 2002:a05:622a:28c:b0:50f:b4c0:62ff with SMTP id
 d75a77b69052e-5165a26a6f9mr287555641cf.54.1779200525585; Tue, 19 May 2026
 07:22:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260519-fuse-dir-pagecache-v1-1-1f060c65930d@google.com>
 <CAJfpegv63pO9k1mvYct_U+aSuiHHVBxCdNgsaj3FhK8ZX_m0Mg@mail.gmail.com> <CAG48ez2gP5nfASBgZe_QiFcAQfnHd2D68gDiofOjxuGix2jajQ@mail.gmail.com>
In-Reply-To: <CAG48ez2gP5nfASBgZe_QiFcAQfnHd2D68gDiofOjxuGix2jajQ@mail.gmail.com>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Tue, 19 May 2026 16:21:54 +0200
X-Gm-Features: AVHnY4Kj6tkpT6WfW6pmL4BP3mlQS7MBLS5jfC_rf2HODZRB_pKQgRciMoje7gs
Message-ID: <CAJfpegv6N3oQnTmvjNbHYno7nn_4yuy47mKYvUHU76F8bC-asw@mail.gmail.com>
Subject: Re: [PATCH] fuse: reject fuse_notify() pagecache ops on directories
To: Jann Horn <jannh@google.com>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 19 May 2026 at 16:12, Jann Horn <jannh@google.com> wrote:

> Should it be `!(S_ISREG() || S_ISBLK())` ?
> I think block devices are supposed to act roughly like regular files
> in terms of pagecache, but IDK how that works in the context of FUSE.
> Let me know which way you prefer and I'll send a v2.

Handling I/O on block devices (or any special files for that matter)
is completely out of fuse's control.

So definitely shouldn't allow manipulating the cache for those, though
I don't think it would actually do that since in the case of block
devices the page cache resides in struct block_device, not on the fs's
device node.

Thanks,
Miklos
