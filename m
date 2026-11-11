Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.174
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794371010;
	b=X5MmEuFoOv6PrA/Shppp1badSDDKKeMWNj5pdvG9ZtV6Nz6k0DziCOLNew3MfD1KflAJ
	 tezctP+uw8a1F1VeYeuB+LNoEyy4ylV+7A/1sL+4AClG9SzbZ0l5q/S/onfp83HOvqcMs
	 1AxEg8eKLzDVHIoPhP8Nkcybdlxpubkj7ZUtxQmFtb3BcB21bn2XudSr1++96PgPXuU8r
	 1aQvR8ad4JqCEXXGyKrPfy4zqoXBnS6umtJbp6LfKL+qJNwwhwalznLYCa0BDOd336DH9
	 s1JgdooPN4Lzre5yTHozbF+9vRJkFOWeC1Z1z5HgRQAhdRnt6VT9yvd8XbKKbnqiRIg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794371010;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=8TP2cltB6myhAN3zqq3XC6T8gNcR9V3LAoG3G2EM6wY=;
	b=BOxhrEbngYmsu8YB3UHqXDR90cSk9CYpNgEm1FxGm77xkIcX2VHjXsu2Wb1KA316wAvK
	 JbD7ZVs2MfnMNK9heQYwgrkolZQ5lFsy2dskgY4UOI6pZcRYFlwDTR+ZLvxEYUkrwI321
	 UjOHJID6JMEbVuM9Pj4/8EMmfb8ZucojM0VTmCJuzPWDR1lNxljqg2kzzlBiIT0kjFfC2
	 OZ+wb0TIrDFPSaYK1Vl9NLhEIvDhjSlETcfWc/vEm3I28cpPt+N7EPnzAJVLeToJB3lJn
	 4WztQTYv0SDismPXtZsDzvy96kkIceejRTBXrhg07KJK6EZRmf0WakXTaHkZne2mWHw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Fen0ScLX;
	arc=none smtp.remote-ip=74.125.82.174
Received: from mail-dy1-f174.google.com (mail-dy1-f174.google.com [74.125.82.174])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7699606A31C
	for <linux-fsdevel@vger.kernel.org>; Wed, 11 Nov 2026 04:23:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B7699606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Fen0ScLX
Received: by mail-dy1-f174.google.com with SMTP id 5a478bee46e88-37198ed3727so3483539eec.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 10 Nov 2026 20:23:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794371009; x=1794975809; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=8TP2cltB6myhAN3zqq3XC6T8gNcR9V3LAoG3G2EM6wY=;
        b=Fen0ScLXmhaK+yaDIgQ136/qilWNldR7SWWcw78zV2UOs41dWlxU5iVusttf0r5HJp
         e+ZrS7twa4D/2I+09r5w5de2NN3wANmX4N7DXqTScWj/z0ZJ2nqISonJ7ErJK5h8ehaa
         OAtK80N04TyrtOc4k6zMsjLgWs7ZImMfj50wQRr3MDSedxKaTdN3vzRKqIfE0Zqx1aLW
         VTz8fQGGdOYEsABiOSkXYwZiX/+WwCUUZTg+oZ7pmMHKTjG4eBEDjhGiOkGq1m+YwPdQ
         2IFS10YKxd7Ig3kSNqhzoG0+eojfpPYh/fvbBt+SDxkdLqDBiF5OxPJ02P+uvzHbe/kR
         bpoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794371009; x=1794975809;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=8TP2cltB6myhAN3zqq3XC6T8gNcR9V3LAoG3G2EM6wY=;
        b=BKBncQS9lb6MvxVeX/UzU42ck/0F9gBx/uXudq1Jf1SnMhT1TWAyEGdlQVfARojOYm
         P6CZOS+jcZ2Oz6cS8w2+Lm8nrfTptssRh/SkZ98Lu6n0KAg/K5ojdbcmx0HgkLaVshJl
         vCmyELkXBgw2p73HMdQZ7O+GPff9ZA1Up0FFAcR4djJHXX4KR9cJdj9qHRr5PK/zNwCt
         3MXYNdX9VnrzJL8EV3PBTrAw2206t7I4P1Qf4O0Vzpi2ZgPP2c8j0LBPhmTmd6YzwbEY
         M9jlb5lzvFpVRWMEFX05wHLPsDdw/lJGX1aNuyiAnxiV3O6I3F37CmR9nwEvircmid40
         WB2A==
X-Forwarded-Encrypted: i=1; AL+hErF99ikjgXV4HGFCxk5MN6f9tyhomzQYl9WD6Trf7LL+ogExus7w/2A9naSC88qfNUe5KAu5w2D68ikg58MS@vger.kernel.org
X-Gm-Message-State: APuU4Z9qGXuaywFMRD2Zrl2r26K5jGtU899pE1/6JFJxCJJraBA8ZhC4
	68thlLEmZKA43x60ZbHno9zFq30KfhcgADZ1qk8TL6SiQWpmCfOy+bFD
X-Gm-Gg: AYBFou048c5nMwl45kEvm+LdX3GmQ5mrfKpDxlTEnaN5EmLbEI27eyGYXbOLrVgNeFS
	jXxvMyKMWZJrM33ZEGZOjonfCk5dERc+/NzY3OX5ukes42pIXpvGlpsZ90BeqPLL0aTSmPCCx6u
	HYusBdOVMjAPNUg7NNsdzuEinesPON3G0136oekleTt7MyvhUlSGNepmHQdC3YGV6xzQbQB+mj7
	UyiiaJmSP1Ctl70fGevtx7T0L3ZE/cgG/YJ1XqRVcBbfPstKrQr+qJ6k1DW5y6KL3P0U0d5lqn+
	w2/8sRZPg21SLqSwxgDEnsfYN3g9xrDuKQvIkhmBv7nTsJhItySI+ynCum7/YDetKChE6ZN35AZ
	/0gB27eC/L0U1UGHeUewfoPAg9yk4V/D7HrFbDJziin9ZDRM5Gyxa2brvJwsFZbVkxlpXvtAoG1
	Tva2+b8h0V5xj6I9sNnXmI7ugNXJWwszVLAQ7ZlL33FhGtVhPxcUJMEI6gA1Gutznp+l+SOc4gr
	wtdnoUTP+q7IfoSpvQx+b9ZtvGA81p6cYD/C5Zhvk5ShFaPRMo7qSFr2ADFVq416GsQy9GUBBcf
	3Ro+cAPj7uZg8KBVi3std0+HYzNFe6ZXn7hn9eA2zMLt8tHfuvN/YfPySJogtKTifOOQMVisCrn
	VQUlSr+xUUkg=
X-Received: by 2002:a05:7022:130d:b0:1b2:3e1d:17ee with SMTP id a92af1059eb24-1b3bef0a955mr1889024c88.9.1794371008492;
        Tue, 10 Nov 2026 20:23:28 -0800 (PST)
Received: from LAPTOP-KD1TH5BD.tail375eb4.ts.net ([47.11.96.168])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b3b5b11150sm15985536c88.5.2026.11.10.20.23.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Nov 2026 20:23:27 -0800 (PST)
From: Gopal Malaviya <gopalmalaviya53@gmail.com>
To: alireza.haddadi@it.uu.se
Cc: jack@suse.cz,
	willy@infradead.org,
	akpm@linux-foundation.org,
	vishal.moola@gmail.com,
	fujunjie1@qq.com,
	roman.gushchin@linux.dev,
	linux-mm@kvack.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	regressions@lists.linux.dev,
	tracekotae@gmail.com
Subject: Re: [PATCH] mm/filemap: let sequential faults restart mmap readahead
Date: Wed, 11 Nov 2026 04:23:10 +0000
Message-ID: <20261111042310.191979-1-gopalmalaviya53@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261109-mmap-miss-v1-1-8b44b33f3358@it.uu.se>
References: <20261109-mmap-miss-v1-1-8b44b33f3358@it.uu.se>
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Alireza,

I had sent a different fix for the same regression [1], reported by
Trace in [2]. Jan prefers yours, so I have dropped mine. I ran your
patch, also with the v2 change you describe to Jan, through the tests
I had: a KVM guest (x86_64, 2 vCPUs, 3 GiB), mm-hotfixes-unstable as
of 2026-11-08, ext4 and XFS with 16 KiB blocks on virtio-blk,
read_ahead_kb 128 unless noted.

The reproducer from [2] (2000 single-page faults 1 MiB apart, then a
64 MiB sequential read), major faults in the sequential part:

                       base   as posted   with v2 change
  ext4                16384           2                2
  XFS, 16 KiB blocks   4096        4096                2

Touching 1% of the pages of a cold 20 GiB file, larger than memory, in
random runs of 1, 2 or 4 adjacent pages, MiB read from disk with the
v2 change (first of two runs; the second was within 10%):

                       read_ahead_kb 128     read_ahead_kb 8192
                        base   with v2        base   with v2
  random                 259       234        1057      1070
  stride 2053 pages      271       236         992       992
  random 2-page runs     257       373        1135      2538
  random 4-page runs     240      1146        1200     57748

The 4-page runs at read_ahead_kb 8192, which is what this guest's
virtio-blk disk gets by default, read about 48 times more. As far as I
can tell, each run now has two misses and up to two hits on the new
window, so mmap_miss stays around MMAP_LOTSAMISS, and each time it is
back at the limit the next random miss gets the full 8 MiB
read-around. My patch ran into the same and kept mmap_miss at its cap
on that path; something like that may help here, but you and Jan know
this better.

On the Fixes tag: with the commits of the series built one by one,
commit 0b9c0aeba938 ("mm/filemap: count only the faulting address as
a mmap hit") alone does not show the problem (1 major fault with the
reproducer), and commit 9b0fcac3cfe7 ("mm/filemap: do not count
FAULT_FLAG_TRIED retries as mmap hits") does (16384). [2] is the same
regression, in case you want to add Reported-by and Closes tags for
regzbot.

I am happy to run these again on your v2. The tests were set up with
the help of an AI assistant.

[1] https://lore.kernel.org/all/20261109091444.128521-1-gopalmalaviya53@gmail.com/
[2] https://lore.kernel.org/all/20261105192517.228523-1-tracekotae@gmail.com/

Thanks,
Gopal
