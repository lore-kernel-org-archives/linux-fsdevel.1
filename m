Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com [209.85.222.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5C5E2C3768
	for <linux-fsdevel@vger.kernel.org>; Thu,  6 Aug 2026 12:52:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786020743; cv=none; b=rCXoPRIZcFV8ICzi586p8fYfQ0Lii111rTpmvX6x/SRoZQSg15CHJMeM4SUSF930o0J/a9lXErqc2JQtmzXF1qlzmeFanacHWDX5pCBrGBeUjYtNse6T2d3oV0RZ4DOqRFU7MUCspYeXQk+Mn+O4JDBt5bv7bRwRJJ5/FN41i1w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786020743; c=relaxed/simple;
	bh=E+t1gFtcHDiraPPrfsroY+Aj4GCqUrp3X08deU2GKIU=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=i1/2B2qvLImDoEj1/IkbhLLXXHpb9ffmg9GJIX5qSulvQhQdY80Ik6EAGI2Wapp4+/4tpnsK9cd6xXRecvWb92K3FcAk0HbQXAIL8okx3sRMTX0R7iOD0xs211c0zAxQTpo/psACqBR11TgnwtweXPOFmOSu3szrnTyO6tN5LQE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20251104.gappssmtp.com header.i=@kernel-dk.20251104.gappssmtp.com header.b=QJpPa04w; arc=none smtp.client-ip=209.85.222.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20251104.gappssmtp.com header.i=@kernel-dk.20251104.gappssmtp.com header.b="QJpPa04w"
Received: by mail-qk1-f170.google.com with SMTP id af79cd13be357-930f618435cso138718985a.3
        for <linux-fsdevel@vger.kernel.org>; Thu, 06 Aug 2026 05:52:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20251104.gappssmtp.com; s=20251104; t=1786020741; x=1786625541; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:date:message-id
         :subject:references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=vo5x/LABgr4z5KWlM8OBLiF0UJfhkaG4qblmSgV8YMA=;
        b=QJpPa04wKEU93cVUT6IOHEoTbPdj1SLgqIogOrZevNcBUAQ4+egaELr2nW/8bkBY8P
         QEz/4gTs+dY30vIaqKCtk6FJeoTG7uYJ8Te8GJDPLJs+GsvvAGl+iWBa7WckxDks+nDw
         YUxNfptFq5UvWrSb2YWhxsPNYE7rIMrRe1ic5P7Fm9hcBNXrg6rnWjd9syuWKjTG3o0q
         QHkmWriyni3+mWGrQSrf1S5FcsaVVZvUKyzybfTu+gP38m2XkiJcarJBGX5y6FGm+YEw
         Qn98v+3MuEtBsSLGFM9qAQzZxolAsRE5FcgM9EzVu2zmcicsyDqMD0NYvor8/u8yxEZa
         R7Ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786020741; x=1786625541;
        h=content-transfer-encoding:content-type:mime-version:date:message-id
         :subject:references:in-reply-to:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=vo5x/LABgr4z5KWlM8OBLiF0UJfhkaG4qblmSgV8YMA=;
        b=AUw9r3kfaFsqYEP1+BuEMViFwLDSXSxc64sN1VFXj5ViwpLA6Ml92GitjrLNL3lPDF
         XC7M00EAnNZupE5Y4fc5zMG1jNqn6yd2HNpt0khsjgjcoRyZl5O3CWua7Kmg3p5MEP8O
         bw9f6QLfiMwvKh6w02rvQqmczjZrdwVTtBgAmyzwNk9YVBmBrH8ctjGFcGCo1IJ4HzrR
         13jRwvr+csWxBNtyfp8DdWMHf4q+Q1shpaZDT/b4rnpYxl2VeZKzPEu7V4126A2Puey9
         YO8Ky0zuSz/D+sUSRXVCFUaTEyWTrdiUWJG/+4VvmLnCVUCiMdcXCHfxnZDb9lKtaIbc
         yW6g==
X-Forwarded-Encrypted: i=1; AHgh+RrlXL9N2FHEjhnlEmEqNHFf+kq0u2gR3oGxAwXinHi36QewYksg/yzS4pt6U5vh3HlgZXKg3ehG5i/8R4EP@vger.kernel.org
X-Gm-Message-State: AOJu0YyjhNAwvCH1TcSgqimKHTuR83ePXJCP4XYZRrZu6ZrGSEFZk8as
	GCy2JFF3kx6TpB+dRHD3kKUHV/DexQ7KJ1IAFFkDqMBaOVLM6DzGijzht6VF/vFSnAs=
X-Gm-Gg: AR+sD13BD49Zh7Apirb7YLqSlR+qidU0M2CdNE1F71aEvjj1AQnMU82ZOyKvOsQUfnS
	ejV06C6zOCPF21PZ/DD8VvERUPvX+eTqg3z+NKTApfVqPYLlb4Ik6GF0A6unbBJzrjwqYuBa+jL
	VOEHudsMXDOcn3IEOSeDwswIOu+SxHvKHJ5HCvuCJNoAmhDPwTIgtSVbgGpO9lLLilDJ27/5iRG
	CrvhoOU7vVvAwJI/WeG7w2MsdrbibYI1tMpDA8WlXCT2OXifGvOYP1lwn/26+AfD37EQ39VgOm3
	6LuwjFTn87zBX0yOWA7UHVHGgWWufk1QREiEb5KOTcvMa1A2n5sJSmpQcW8zN1OR+tw0gzYxEwA
	g4iSIkUWzoFBBZmo+f92n1alVC6Qdr/KvJ7oBvhzIvyQuFlV8Ml/Tvm6RgEdsBfUmPtOwC34vxX
	Syb3by/v72mUZJBMB6zBJgiqsj9hy4Cp9wQbQ2hLh/wikfe2SpTSFnqP/Suxo2fxCO9+pR4mY4n
	OfNsJSWpOxI+FAq8tJwfaqTxzC9/Ld4OjoDggVK1Z417YpF
X-Received: by 2002:a05:620a:2311:20b0:930:84d0:fd3b with SMTP id af79cd13be357-93648fafbc7mr1150209885a.7.1786020740525;
        Thu, 06 Aug 2026 05:52:20 -0700 (PDT)
Received: from [127.0.0.1] ([2605:59ca:42bb:f910:6d9f:8dfb:ae1:441b])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-9365ef833edsm123847685a.3.2026.08.06.05.52.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Aug 2026 05:52:19 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: linux-block@vger.kernel.org, Pavel Begunkov <asml.silence@gmail.com>
Cc: Jonathan Corbet <corbet@lwn.net>, Damien Le Moal <dlemoal@kernel.org>, 
 Alasdair Kergon <agk@redhat.com>, Mike Snitzer <snitzer@kernel.org>, 
 Mikulas Patocka <mpatocka@redhat.com>, 
 Benjamin Marzinski <bmarzins@redhat.com>, 
 Dongsheng Yang <dongsheng.yang@linux.dev>, Zheng Gu <cengku@gmail.com>, 
 Vishal Verma <vishal.l.verma@intel.com>, Dan Williams <djbw@kernel.org>, 
 Dave Jiang <dave.jiang@intel.com>, 
 Alison Schofield <alison.schofield@intel.com>, 
 Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>, 
 Sagi Grimberg <sagi@grimberg.me>, Chris Mason <clm@fb.com>, 
 David Sterba <dsterba@suse.com>, Alexander Viro <viro@zeniv.linux.org.uk>, 
 Andrew Morton <akpm@linux-foundation.org>, 
 Ilya Dryomov <idryomov@gmail.com>, Alex Markuze <amarkuze@redhat.com>, 
 Viacheslav Dubeyko <slava@dubeyko.com>, Hannes Reinecke <hare@kernel.org>, 
 linux-doc@vger.kernel.org, dm-devel@lists.linux.dev, nvdimm@lists.linux.dev, 
 linux-nvme@lists.infradead.org, linux-btrfs@vger.kernel.org, 
 io-uring@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
 ceph-devel@vger.kernel.org
In-Reply-To: <4e4c21858705a200bd8848ffe4080522e3eb5c1c.1786018753.git.asml.silence@gmail.com>
References: <4e4c21858705a200bd8848ffe4080522e3eb5c1c.1786018753.git.asml.silence@gmail.com>
Subject: Re: [PATCH 1/1] block: rename bi_bvec_done
Message-Id: <178602073720.2137920.17721545855702977301.b4-ty@b4>
Date: Thu, 06 Aug 2026 06:52:17 -0600
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15.2


On Thu, 06 Aug 2026 13:19:27 +0100, Pavel Begunkov wrote:
> struct bvec_iter::bi_bvec_done is used an offset in the current bvec,
> let's rename it accordingly for better clarity. I also plan to use it
> for non-bvec based iteration in the future like dma-buf, so drop the
> "bvec" part.

Applied, thanks!

[1/1] block: rename bi_bvec_done
      commit: b539aeacf8cc5e9d8e5d94625d2d9c697a167add

Best regards,
-- 
Jens Axboe



