Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00EBE36A36E
	for <linux-fsdevel@vger.kernel.org>; Mon,  8 Jun 2026 11:40:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780918827; cv=none; b=ewRo5EMwybkmDGXP0IeHj6AOHp6Pyvk//msTbLjRxmB/RosdtTWa9oONHNpNs8Uu9eG8jVZyMriNm/Rn1Lmkvow+m0dJYkwuWd+1yRDT7dmucs+cWbMu0fuFcRGHUi2YmxMrGmKYGhQnjn7RxdDEe36JAiMAyYnU2Vi+fDzLYT8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780918827; c=relaxed/simple;
	bh=gt817j5d2FZcQYx9aiRFtGll+41qpg8M37eW3rPlaLM=;
	h=Message-ID:From:To:Cc:In-Reply-To:Subject:Content-Type:Date; b=uDLueJ+ZP06Ix9sRTNJ1CBHcSQGSeXzkk41wNoE0VJV/7FaRRYX370zCOsKzp09nbS6WbLI+BQw4f3O1P98I0MaEXH0Rc996RT6pnOjUxMksNF29thNqd36wvpkQ01WGvgjkLahgmIBiOgyttfObKmr05e+l9vZTr4h1Ur31a6M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=CU33JHhO; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="CU33JHhO"
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-45e9f4a3510so1906603f8f.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 08 Jun 2026 04:40:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1780918824; x=1781523624; darn=vger.kernel.org;
        h=date:content-transfer-encoding:subject:in-reply-to:cc:to:from
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=gt817j5d2FZcQYx9aiRFtGll+41qpg8M37eW3rPlaLM=;
        b=CU33JHhOJJpl7G85SmXd37aYDGyPNc1hcQU4q+6OJ/2MUTacmuThcIoEtwOpdud9nR
         9/HdLyCw/h6jDB7VnA4vDU8ICEQRvuBVcEz/L4CdSZ0GzGJTb1aL4wu6Dgvgw5vBRNyp
         wA1tJLT+bol7dh3VO+K7B7YxZKMLkw9lCpk52epadCuzaKdyARU4lmYukD8IxlpERS+Q
         uLUFqKLdIRuOCNN/e1LLwxwOPeJ+e6pVjjQj+injFQHEgDxYRUWWeBaAvQB9sgS8mKbz
         +8ARhmnOYxUGm2JN95dC+P7KudilAnUI00WGu1vcxdbCtJnLchqiBwacxAHLp3mnBJUR
         fq9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780918824; x=1781523624;
        h=date:content-transfer-encoding:subject:in-reply-to:cc:to:from
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gt817j5d2FZcQYx9aiRFtGll+41qpg8M37eW3rPlaLM=;
        b=e0sRgGUuwVVnWopYsUBah3+5uKTC2Jfz4Qjmi1Scl7qfPnhRkwztEdFc/wmGrj9aDM
         eL9sbbx91FeFxE6lQaHyEzUC/zuHa9PFhJ7amNm5Ggm1jtF3igMswhh5gaadHV1QmlrP
         tye/BrkPNMvFx5g8AezPQ7gNFcaLR84SrWt2wRbLy+ccwNvNvBxdD4Q3UoTyqfZokWkA
         6j+rwlPqv7YReKJOc5Ah/sgeytImD+Ms2K/6n2tvH6Gxr/zTBsmC2nt1A+x7AHQVp1+F
         X7/W9okdRIy1+5Gd0P8bdNVtrvo/CKP8s8mKKg9TCNgXTxUUZQyVMpJxrYXlnQ/QRX5W
         koKg==
X-Gm-Message-State: AOJu0Yy8LCq0LjpHdWCb5LpBpiPeshySE5B0WnnMuKSEAbrtrb5KaqPD
	CpzcOepqLKka9jaimP8yC7HBbfKV9yiqafsKdul/hFNOtTNZl/zjzJa3SaVR8Y6A6dE=
X-Gm-Gg: Acq92OEkLR3n2OpGtqOHyfrX6Y+n0w/hCmx7maFHIJQ1y0CYvzSSxf1Y/lJ3iO9UXqR
	u0PcV6mGfYM1NGU8zvAFIzh5Mp2OxsW5wSy63hV4hP6kp17aHEMGDFNKFkhERNDO4JHAFiQI9XF
	0JhrSxAB9BQ8cgREjsllu77vGmcNkDw1fOh9Aj898rZfoViFTqTNNcPHQ/atKQCVrIMZfVY0nLj
	kuK/r3HMoGd4ad44RCVog5MBg1sr42UShke0dhAoXDEqnq+1aQ+VU2EkEM3FGz32PPGsDcwI1Wo
	tH7Sp0z6oX94368uIw1ze67JJH0kiLnAy8sHxlJf37VKNlKrW9NMgr0WcIB5EVFlzejwLi0UAxY
	oKl2s0p1swAjbG8zc0PhXorhsliTYKqe7qnGFUmqN+f935XQYnBmbKB4QEqACBK1AtjappC9UOs
	/zHCDyyI8qAsF8id1jd0/GKa3LVVVyeFLoVwXpQyWRn8ScQ0mJXYWPiNG9PX0Pbc/o+krClNDrZ
	62J8w9oxbuMNa+v1OrtqrApq1FyoTzd2r596K7cEI8vlQ==
X-Received: by 2002:a05:6000:46cd:b0:460:1492:4f0d with SMTP id ffacd0b85a97d-4603063c591mr15377117f8f.34.1780918824402;
        Mon, 08 Jun 2026 04:40:24 -0700 (PDT)
Received: from localhost.localdomain (p200300ef2f13eb00c11aebd17f9598f1.dip0.t-ipconnect.de. [2003:ef:2f13:eb00:c11a:ebd1:7f95:98f1])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4601f2f2710sm40821903f8f.14.2026.06.08.04.40.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jun 2026 04:40:24 -0700 (PDT)
Message-ID: <6a26aa28.283787d8.1f1282.ba36@mx.google.com>
From: "Andrea Cervesato" <andrea.cervesato@suse.com>
To: "Askar Safin" <safinaskar@gmail.com>
Cc: linux-fsdevel@vger.kernel.org, "Christian Brauner" <brauner@kernel.org>, "Alexander
 Viro" <viro@zeniv.linux.org.uk>, "Jan Kara" <jack@suse.cz>, "The 8472" <kernel@infinite-source.de>, patches@lists.linux.dev, "David
 Howells" <dhowells@redhat.com>, linux-mm@kvack.org, "Collin Funk" <collin.funk1@gmail.com>, "Joanne
 Koong" <joannelkoong@gmail.com>, "Miklos Szeredi" <miklos@szeredi.hu>, "David
 Laight" <david.laight.linux@gmail.com>, "Matthew Wilcox" <willy@infradead.org>, "Christoph
 Hellwig" <hch@infradead.org>, "Steven Rostedt" <rostedt@goodmis.org>, fuse-devel@lists.linux.dev, "David
 Hildenbrand" <david@kernel.org>, "Pedro Falcato" <pfalcato@suse.de>, ltp@lists.linux.it, "Jens
 Axboe" <axboe@kernel.dk>, "Stefan Metzmacher" <metze@samba.org>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, "Andy
 Lutomirski" <luto@amacapital.net>, linux-api@vger.kernel.org, "Andrew
 Morton" <akpm@linux-foundation.org>, "Linus Torvalds" <torvalds@linux-foundation.org>, "Willy
 Tarreau" <w@1wt.eu>
In-Reply-To: <20260606061031.3744880-1-safinaskar@gmail.com>
Subject: Re: [LTP] [PATCH 0/5] vmsplice: fix some problems in my previous
 vmsplice patchset
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 08 Jun 2026 11:40:22 +0000
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>

Hi Askar,

the patch-set doesn't apply:

error: fs/read_write.c: does not exist in index
hint: Use 'git am --show-current-patch=3Ddiff' to see the failed patch
hint: When you have resolved this problem, run "git am --continue".
hint: If you prefer to skip this patch, run "git am --skip" instead.
hint: To restore the original branch and stop patching, run "git am --abort=
".
hint: Disable this message with "git config set advice.mergeConflict false"
Applying: vmsplice: open-code do_writev and do_readv
Patch failed at 0001 vmsplice: open-code do_writev and do_readv

https://github.com/linux-test-project/ltp-agent/actions/runs/27129052434/jo=
b/80065058557#step:8:21

Please update it to a new version after rebasing with the upstream master
branch.

Regards,
--
Andrea Cervesato
SUSE QE Automation Engineer Linux
andrea.cervesato@suse.com
