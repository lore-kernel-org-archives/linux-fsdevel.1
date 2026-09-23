Received: from mail-pj2-f25.google.com (mail-pj2-f25.google.com [74.125.227.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E996A3FE347
	for <linux-fsdevel@vger.kernel.org>; Wed, 23 Sep 2026 17:52:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790185937; cv=none; b=r2Sfbewr2y/6GGfLttHnZyoaNY1qBrjyIXUO/95/93NfpTUe91bo7syT/Vy2zKh96MNqfyBW9a+L15O33FmA95auKl4g3+StevZqGg9EN9IsUFoBoD59qxzAio6Bm95KJbsfuva9WesEbtQutSYRuGQVNp8c8c2h+HPBIJE13YM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790185937; c=relaxed/simple;
	bh=e05vuqU9V1yGBeORnVhoyj/I78Tes4W9ncGbQG7vTZY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BadVyWB5ICo786AjqxA27gVTaKTZVSYuJwXVclCwsjfowsrQm/v/In6EWq7TkrPXPhi6Xq02AzMnJe4/uRx9cFfIoFgP25Slq0s9WAjRCe59YsojslZzAGiDIIurGClutbahDZ50JV5EzyolxOdDNxNnL3zXqzqfuDGQi8uNNQk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YMpqf2u5; arc=none smtp.client-ip=74.125.227.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YMpqf2u5"
Received: by mail-pj2-f25.google.com with SMTP id d9443c01a7336-2dd4b43b20bso6424105ad.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 23 Sep 2026 10:52:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790185932; x=1790790732; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=+YM4UPQf2Bykc1kLBU8Ib/16iU1QOsuSr6b4r/9jhjQ=;
        b=YMpqf2u50eZoTdvPdH4p0Y0msYVimMhocrQKZV8Qqvw1ChfuJhOL3/689TbPlcTa0X
         JFBtqIm8ZGA5nfR9dBgepL2F7mStiUZPBrXE++yBR29K0rmHL37a9jRQx4+pMAEZnCpy
         6OMqvlzgh3n++dWJymWGRkBYbTohg0BJ3Df6KqCz0jCx2e7sWYvJedarDV9s0R4AcFUg
         ROcOF+ayfnNZVvj6wWrtQbSs6eclgLNCNNYouvi9JQ9gRu82GBuRFJcbRxAsOygF9Y0i
         2fWSnxH3SS6PZuit1tTjnyGgnUrllVWJSf0LXVPf1Vhtb5J1wPZFqy+UKym0uKbU2MJP
         KZAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790185932; x=1790790732;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=+YM4UPQf2Bykc1kLBU8Ib/16iU1QOsuSr6b4r/9jhjQ=;
        b=JSl3JkXJN1NoRUoed0rQZj5VSd3uGLtqtxDENiGpbWF3Xjdda2nQDuaqbXYp+mEzaQ
         VDNMnP4xHFo6SIhY+Q9kjBgy2rcY73BXjRIr0tkiENxgLZOzYxxGbBEtP4CBj0RTG8yp
         xaRscBg8rF4igp1/1/dfL5O8fCpIBM9+qUU4J/yJHrhQUDDJveRjRphE9kzs+QD7SPY2
         SPqakOj1kpSC8+jxHuzrq3TsxJT51GoDRxKnEovJYjqZMBoGDlesa38nJlfOwutOV7Al
         UH22gbTJuLocub55p7jWqMrgde1WL8usiD9fd1vdFoWAa++787hMw35JOIBt4/KFltUQ
         hW/g==
X-Forwarded-Encrypted: i=1; AKwUvBzzP+9JzrJzptrxSBQMfHkT+7c1joi00xgVEQhtuuCV+JGl64ddYPNC95nwiNHdZcJn8E9JyPWfX1b2vKEA@vger.kernel.org
X-Gm-Message-State: AFuF++lyDNmgDU1ZWjwuIRqZY/wxIrkgiTuagxPrDJZuryORopwStnK+
	uPCfYnD9D60qO1O3kp1RPlIKqtn2tFRWnWNUhOhGU53CqqiQFnio8oAB
X-Gm-Gg: AYBFou0BYTH+W64EURBOjzwdGbBqJY3yyMfI/Uxf4Bcgm9WakWoq3b3gfiwjZ41Wv4i
	xPCh0BdmEvGWn6c9WXwKs/6CXQewMzT+NmLg0UrhT9ez02V7tFLiJGzuvOZm7YHHNGiglVBQJj3
	UyWUAYJ3DVeGqHunQMzFjg+xGVXLYlB9ydi40Pi+mjVYHEQBnbMffK6XU0hB5DSv09Bl6RtJB89
	YnLAsZe8U0PDizO5753y9fvf+mnaD35AukBcSyk97XpnsY7D3DoH9erh+8LHgtrCiQ3aaYk0GUe
	ie+4tNLLvxVMUE8VE1nC/I+RoVEacYLJ+u+284bGhx5dnsU26Ek/8Jksh5VTHyCFL8GOqPoc5So
	5kqxrOtgVeffOEzSUpVF3v9RoF2R5ndMWvu4ZPV5G3Snnk15Dj/m01gJsHjTiSuX39nH6K271HF
	CxAzFCGvSZznnReGq1NbwmwvPeEchG90AlWSCRLF3YO47PisUlJsJU/CgvwjJme4E6quRHJWF6b
	nld2M06TQL2Am827bJx2tSNgaz0hgkQESQPlASSauElH1euQehzOlmKcMi6IWqruJp31RFO5dAK
	XY30LpJa0xs3kB9mErm1Zxty63AZGkxMXedx2LndJ9pChlSvDyS8cEzvLIMU/A==
X-Received: by 2002:a17:90b:3985:b0:39e:6a81:f34c with SMTP id 98e67ed59e1d1-3a07e6be348mr3096520a91.38.1790185931440;
        Wed, 23 Sep 2026 10:52:11 -0700 (PDT)
Received: from spider.bream-herring.ts.net ([103.252.203.158])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a082872cfasm1893957a91.2.2026.09.23.10.52.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Sep 2026 10:52:10 -0700 (PDT)
From: Matthias Goergens <matthias.goergens@gmail.com>
To: Jan Kara <jack@suse.cz>
Cc: Thomas Schmitt <scdbackup@gmx.net>,
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] isofs: Always advance to the next block in readdir and lookup
Date: Thu, 24 Sep 2026 01:52:08 +0800
Message-ID: <20260923175208.1576995-1-matthias.goergens@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <vjb4g4xyuare7b6w6lwtbuijboeqhrzdo4vboi7fgpyeu4prtx@gv2zvtsbae6u>
References: <20260922121912.2258134-2-jack@suse.cz> <20260923153134.771632-1-matthias.goergens@gmail.com> <vjb4g4xyuare7b6w6lwtbuijboeqhrzdo4vboi7fgpyeu4prtx@gv2zvtsbae6u>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Wed 23-09-26 18:55:11, Jan Kara wrote:
> So I agree what you do is easier to understand so I'll fold it into the
> previous commit. Just I'm not sure it is a realistic failure case - that
> would mean a directory would contain full block of zeros which I don't
> think can happen. Plus this infinite loop was there forever AFAICS and
> nobody complained...

Thanks for folding it in.

Maybe I'm missing something, but I thought the loop came in with
3c01d9263683.  Before it, both walkers advanced with
(pos + ISOFS_BLOCK_SIZE) & ~(ISOFS_BLOCK_SIZE - 1), which moves on even
when pos is already aligned, and mainline lists the reproducer images
fine; only for_next spins on them.  Is there an older path that loops
that I haven't found?

Agreed that a well-formed image with 2048-byte blocks won't have such a
block.  But only the first byte of the directory block has to be zero,
since the walk doesn't look past it: a crafted image needs one byte, and
faulty hardware or an incomplete copy that returns a zeroed sector does
it too.  The task then can't be killed.

Matthias
