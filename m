Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D09632B123
	for <linux-fsdevel@vger.kernel.org>; Thu, 25 Jun 2026 09:03:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782378192; cv=none; b=BGLCrw6t1cjNsApHimnEA5nbx/wMgOW7QoO5hyKkPbRlNaqe4b/GEXRoIekmdfErN79Zy3I6JrXgUU1cLRYjifnrWMrUB606gv9FoyUegSvIcQdIKV+NxP+hrG+BnxSjaQmk/nfyZOQ6j9fS1I/+Wyvx1e/44il9ZmaelWL0vXg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782378192; c=relaxed/simple;
	bh=FguPNFEFgDgE8rgvKN7AiVQat7qypuBZ+3etEcHfrYM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dtu7RyouCJVRLoZTzzZLRxsC8wlmLp43GefWwiFbWvXjWQnSp0GJZ0bsAYeHSJbclsIjmugiY1DMtX9A43sRBvDTH0b3ElloUkT1cRhXMxL7mTb7JJn6JQjeb4sbi2uKVPgwmdWbtdxV66x2xjRvKIT45905QLN1AOJHmbdsKIk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lOXJoCtW; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lOXJoCtW"
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-490b3637b90so13139275e9.3
        for <linux-fsdevel@vger.kernel.org>; Thu, 25 Jun 2026 02:03:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782378189; x=1782982989; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HBSEPUdUYWVlvar6bWIrKaomQq421L3gUjBqqjys/Kg=;
        b=lOXJoCtW3HddOvhqI21M0MrdbMGEeCA203jHr464PdrunmvNXlIQvSoKPMYGOwu4m4
         RFwzCGN4SEIzuyefzRGvqyCJB/GtkeMBWZzjp4qmsNb6mas2NSkYMNhJavf0maEmpgGq
         0vvVPDFPNdbWI17P5aDEiI8RSUl8o1BtTA3eX3kxrgBI6XMsaISmMPROcZfJK7G1h09P
         RzBwVnOWIQCPYHq67uns8cLfchsPhr8HW69dmF0nK2HkL0V+pgurnozJUMe39BUxWAvU
         RpjIZlh296DGwdKkfZklxNtaZWULelbrJR/kq7UqaUkZhA0GlrrRQyRyaByTUYa6sM2A
         BNwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782378189; x=1782982989;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=HBSEPUdUYWVlvar6bWIrKaomQq421L3gUjBqqjys/Kg=;
        b=NvaK0IgF24hfhQbiQL6waGHWR88bvguQZcs+wVPRVnGF1PVZqDmRS0V1v0crchv5bf
         jxAslqwzXK5AVc4+MSmQ3IvO71YvLkIbmsT+0xi9Mcc251xlXlKy/U5A3z0+x3P3rkCq
         lFPgFHHwX7kFn7fahHThSoYvmrXiiTgLdID0uxlzj1gqlHccPb2+Dfec5822kHtRxZ1H
         GSWdZfL1bCKoohgWOuRKvAPtul4RS0f2HoZzwhZGjSDKdhqJY9bytfAJhtDV1qXW2vbh
         +4GYzolsoMoKJ0D/dw88eu7H/Y+yIxoE2oMniW9WlaoyEc2xluQSV0E+90O2IHJYeCiJ
         c+PQ==
X-Forwarded-Encrypted: i=1; AFNElJ/V7DeeqeS1UDZ0XdxZwLEw0CQ6KZoDmO9KbiW8IZ+5LVwGnDWRC7XhSxte0UVTZtXYUAENIGH4W/3By7DO@vger.kernel.org
X-Gm-Message-State: AOJu0YwypzQTSVJuIKYc/0PD2uSOtHaDlXtYe2P6K+jv1CzZkImXqZ3E
	tOT4qPIfgCWDcZ/Dbr6DA17ghqvEMpgybBMF55xvzxsci+dvymNZw0M2
X-Gm-Gg: AfdE7cmxbQXF7f4HczAKgjhJj+ArmLJc2hXfJLNRMSZNYWCjMRHs9RlG7r/lEsmiJtE
	A7pRkoHjdBX7gev/T5WEAjD206V8my0AnpPBoSVXjV5Oodd+s91hZSqOLCeqTP7H902ZYeSNMNY
	XtO3lUhOA0wnJcQ1o+hchiI2MHqJMqlIGbanFrdN5Nu77ELgoPC4Cx907dtH5wBDcQSQkypqnbe
	p2loDrl3tQeFBesCesL6rORKPVyRbJsrmBKNU6+XehNv5w8eLrEeNWNZx8JXAfjgX8juwbNRTM5
	pRv6yNdcMk+KmAUl8YvnjTuHV2l3sOSRw3Kaw4zQ+H0i4Sc6MmKQUuDGN5k/Vv85IIZoiqMiWjQ
	L9EFE7WNJ55FaOQmGJaLlIcHYIwfF5NedXpheL+Su40wSKKNGDyxIpws1asgEhD700MmECije/O
	EYrSs1H77uFF2arju2PsE=
X-Received: by 2002:a05:600c:c059:20b0:490:bb3e:30c2 with SMTP id 5b1f17b1804b1-49266885955mr16491185e9.18.1782378187463;
        Thu, 25 Jun 2026 02:03:07 -0700 (PDT)
Received: from localhost ([212.73.77.104])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-49265975147sm55948915e9.5.2026.06.25.02.03.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 25 Jun 2026 02:03:06 -0700 (PDT)
From: Askar Safin <safinaskar@gmail.com>
To: val@packett.cool
Cc: akpm@linux-foundation.org,
	axboe@kernel.dk,
	brauner@kernel.org,
	david@kernel.org,
	dhowells@redhat.com,
	fuse-devel@lists.linux.dev,
	hch@infradead.org,
	jack@suse.cz,
	joannelkoong@gmail.com,
	linux-api@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	miklos@szeredi.hu,
	netdev@vger.kernel.org,
	patches@lists.linux.dev,
	pfalcato@suse.de,
	rostedt@goodmis.org,
	safinaskar@gmail.com,
	torvalds@linux-foundation.org,
	viro@zeniv.linux.org.uk,
	willy@infradead.org
Subject: Re: [PATCH 0/3] vmsplice: make vmsplice a trivial wrapper for preadv2/pwritev2
Date: Thu, 25 Jun 2026 12:03:01 +0300
Message-ID: <20260625090303.3796964-1-safinaskar@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <83f05c55-efba-4bf5-abfe-d2ab0819e904@packett.cool>
References: <83f05c55-efba-4bf5-abfe-d2ab0819e904@packett.cool>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Val Packett <val@packett.cool>:
> speaking of fuse_dev_splice……_write actually, this series has broken 
> xdg-document-portal!
> 
> https://github.com/flatpak/xdg-desktop-portal/issues/2026
> 
> Specifically what happens is that the EINVAL is returned due to oh.len 
> != nbytes:
> 
> fuse_dev_do_write: oh.len 16400 != nbytes 15526
> 
> (where 16400 == 16384 (read len) + 16, 15526 == 15510 (file len) + 16)
> 
> After reverting the series, there is no error because oh.len 
> becomes 15526 too.

Please, test v2 version of my fixes:
https://lore.kernel.org/lkml/20260625083409.3769242-1-safinaskar@gmail.com/ .

This should fix this bug.

-- 
Askar Safin
