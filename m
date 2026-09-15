Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28E793CF1E6
	for <linux-fsdevel@vger.kernel.org>; Tue, 15 Sep 2026 01:57:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789437475; cv=none; b=qqJNTKQ6s/B8TjLP32Fp6zFioMeDshxw+zOzAVDQ9Z23gn6N+IlleE/yNjKuu20vqPQfjAeLtTJQ+BqNczBt36JViR/GuGdo+Mc3iJi3csdXmofkC5wCktXFRj2VDN313Kby6jR5opOgq58mqOOlEerNO3DRl0QIii56baHNWYk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789437475; c=relaxed/simple;
	bh=RzPgH/3eGo+TdM3AJC5ylErp3efZkoBM2RxE6XOg6z8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cK/ePNrnSmC4fH+tKJ/lLpMtQlRmX22qXEu+g5CbkhFv4tCw1c7QxERFpj4aEPQqx5/CNRuI5VXDNPBrCGMbFzWw+8+GpkWyhZPvS/BKNUxD2Rpu8US3iWrIrKwU9yY8KlL5dGlRqHQKO275NpQvpmtjyFS+gKxs4yX3+C1oXew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=oTquKce7; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oTquKce7"
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-86aecf49833so25933b3a.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 14 Sep 2026 18:57:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789437473; x=1790042273; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=8LtHfoqQuWljZWMj5fNvShJKWJ7Eo3q2bY3EGg9Y51M=;
        b=oTquKce7kKml8UudqBdJjRYYXkK7xVBS0OZtZssEc4L6A8jL91zwz31t7CCC2AfJ9Z
         M6F4E01S2fn/GKHTMMVFxIOZWofX6DrXzM3ILW+siPw8AOLa6PutVF8DwY7lkBmZ1KjL
         3BUeL4nljRO+69XLDcCYzoTyhMaU9DShKdjHA4bl0Bc/GAaohyhYb1StPRgvGdc7Sudh
         +6fz4fEmatET/8zD5q541u5TQcuHAcb3wtfPgA3B8oG64DfAWAXpbYq4s6MsO9L70aiv
         oAKLAQBYwHQH8nlxVXejuT++l3BtE43uKUXqQAQOsHwH3/55s3wRd94FgbWVBWvWpAT9
         c31A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789437473; x=1790042273;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=8LtHfoqQuWljZWMj5fNvShJKWJ7Eo3q2bY3EGg9Y51M=;
        b=Utp9x7UgXTFQzeaG3qHHalBFKcCPFL5R4nCqElouvBVoKMIQac4WRpg6mNj5HY55ZG
         KZQVRINEgEPqMR1UjrHsBWrH2cnbp0ItUQO51AVGKVbzbzUF89njyFPdLuIXyyc4oVds
         Yrkh/53cfkp301qC7N57i3L/MWl5h5Al3AVeKFmjhy2cGvec+RMwoxq1pgBWUwvC7iT+
         tJLvq1EqkmkFRAOrhh8ZbZ5SBkyJF7x8wgjj1b2nauYwRUJE+IeG50bNi8pTzRJ/zTvx
         KXParwD2U0juA8YduGZdnlumjM5Qj5V33KbrxsLj03XZkGi1q2bQpSpdefomQHvMu05B
         xIGQ==
X-Forwarded-Encrypted: i=1; AKwUvBzYUnhtBfhhF0NhWSRn4EbdlQMOPCtuY1bjx5I7TGMTtkOMbxxD61LuC8FQ6B5ExQRYhTTjcaHNpJ79o/31@vger.kernel.org
X-Gm-Message-State: AFuF++l7R5G9VTMXqeVVNA/zBXfvDuXXhp948eeAxnCYNN57mqo8b0zD
	djqtIhTs7rVjPDfT5oekP+UkwXfzqc1N3rRbkEwByMVGnDzKmIIaqjGY
X-Gm-Gg: AYBFou3oP1Ukr+1/TXmA+Odpi8XWCK0umsoVPDJ1r1xDS3aduvOYojgGgmryI5Udz9z
	2fRK1eFjzIDi+8SmeajwYEttKi0EHJ/hRaoiu63SWTRMnjyblZviajdxlCUP7AM05zbPuGi35c0
	oKiqf2Lg8I3Zo9Ba1hnfTc3DNTbWNx0LblTaHCvAOnJyr3leSGgwFQO6i/JSOfrhKoMKdPrvnKC
	4mRWDdhZ4TwhpvAudxe3QiKC3wPhntBpjb+v/GxGZK/tZal6a5eYZcHC4mgSrGSkGCMxJ5PLpnL
	pLVAiccQF+AcWucq8CyuT4BKQrRJTyHCW+MupxK6S4KkFYUAa5YHl+hFlFs7wRZoUsNzrdRhcE4
	MEyUG5SH/3Z+ii6lpsh51+EwWGGP83hg4l5xBlIncNh2h1Cn2i+cAEZOiqHm+JAIYmmcbQsHf85
	gVGrXQPd5C0Wg30k/icCVan7YnW74pmvNAenj/6z/BLnVl0JOhD1cbl0qmBIblU5lzBCudmftFN
	KSZ2GsMFm3e271rgUK60FB4rj78AZ8M
X-Received: by 2002:a05:6a00:3a01:b0:86d:117e:5db3 with SMTP id d2e1a72fcca58-8708c45f131mr2265230b3a.26.1789437472373;
        Mon, 14 Sep 2026 18:57:52 -0700 (PDT)
Received: from qiwenjie-ThinkCentre-M760t.mioffice.cn ([43.224.245.241])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-86b6139e3bfsm5231011b3a.50.2026.09.14.18.57.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Sep 2026 18:57:51 -0700 (PDT)
From: Wenjie Qi <qwjhust@gmail.com>
To: jaegeuk@kernel.org,
	chao@kernel.org
Cc: linux-f2fs-devel@lists.sourceforge.net,
	linux-kernel@vger.kernel.org,
	hch@lst.de,
	jack@suse.cz,
	axboe@kernel.dk,
	tz2294@columbia.edu,
	baohua@kernel.org,
	linux-block@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org,
	qiwenjie@xiaomi.com,
	qwjhust@gmail.com
Subject: Re: [PATCH v5 0/2] f2fs: enable buffered RWF_DONTCACHE
Date: Tue, 15 Sep 2026 09:57:45 +0800
Message-ID: <20260915100000.1789437600-1-qwjhust@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1788795700.git.qiwenjie@xiaomi.com>
References: <cover.1788438786.git.qiwenjie@xiaomi.com> <cover.1788795700.git.qiwenjie@xiaomi.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Jaegeuk and Chao,

Friendly ping on this series.  v5 includes the mixed-bio completion update,
the syzbot NULL-kiocb fix, and the additional memory-pressure data.

Please let me know if this direction is acceptable or if another revision is
needed.

Thanks,
Wenjie
