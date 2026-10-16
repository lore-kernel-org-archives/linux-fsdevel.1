Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEF0839E6FD
	for <linux-fsdevel@vger.kernel.org>; Fri, 16 Oct 2026 02:45:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792118701; cv=none; b=mTJqBUPHl6rh9qdIIQpmUAX50BoBpMcbX5zbG/VNmoVT1Q1s+AcbTo7lMkZoFQ63l7TjNPSdBVJLcQ2X/HuuDe3NL4m25zwfZ9T+obHWL5t4lhC2mGArqMD0N79MHPNjLBn+bI/d0P6ZHGoJ0W27C1ZyfwwhQDI8aODD0Vi+dKw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792118701; c=relaxed/simple;
	bh=0Vxm4VZCZ8jpZLCSVg0ggNJMQhCWNG8XahSTGZ9xNlg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Jt95MSzzfdB1VVqzvJjTPGRb2Lt3/2FL2yOt35YrWwLegCeAw9g5Wn6YTG4pZIEYYCHs4wCRC11GJ2SvnWQzDXjZCJ8ydngft9489cJw2u7DA9kozkHj5mSqmfppNchoN/g8+b7CSO6MSzIQDQ5XtlJbFRduU0ylKHtdIyTEhNo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=g0/xjsdw; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g0/xjsdw"
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2e8246b13cbso43978465ad.2
        for <linux-fsdevel@vger.kernel.org>; Thu, 15 Oct 2026 19:45:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792118700; x=1792723500; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=bhQu6i5bnomJdqlUlby+n7UCmgHRVsFKdREdnXuUkFg=;
        b=g0/xjsdwYah8Qb5dh7lkmite/VXew6BEbd1hvCLTn/1Yx08UtcS6BOw2365TdjI2JV
         wJMACAcM+SGvoZC2C4xRu8JgXr6th25nQNOPVEx3UbC2S9R9mJh72y17MNaTQkFBVFyK
         qnIeADbUIUUa4GyaSeOYoKwRE9ZKtnX3kXwf0ePhkxiPo6DZgcwl3mb9ZRRbJYk1VtxS
         GffZ4E29zxTpMHuCt2L+7DDgFQquI0/r7ONAiAjcssQrYhHg59PDnACtq5HsOXIGldzQ
         CWUfC6bGiHJ3fFKq1yn4UOtLvKUW/QkFCpe5o5C9pUMOFcJQ/pvMK5nzne/od1Qwga/Y
         IwJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792118700; x=1792723500;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=bhQu6i5bnomJdqlUlby+n7UCmgHRVsFKdREdnXuUkFg=;
        b=tKh57jc4TTsFt8HWEJX4v/aiNcVEwctzZ2Ojfp9Dj1XJ0ZKUMJFJYi1H6CKMY83FN/
         8I81kJKf3/od2us0WLv/v7IHKNadQ5A/MGR9P+cUygM9WHSdVp5GbfGqmgP1wStSm+5y
         zAcnK5l6CqXRHcoiRz2ay8+eNuoKTwTbWcN4z4ZhfX7p6joHRfEPLL5Nt4rq3UBP5o/j
         Fux9NZjOCz0k9K0TVlmJ/j6phKZmjgcjd1MGSkMpgevecCjQ4EDeyVwHqQiu/Kaaksi2
         PnucDzEBN7uA0ZQzNM9QnrKBUxOuMXVic3cFnT6/Lys7JZWjLDX4HG6tVN9/pttv3GGf
         eeyw==
X-Forwarded-Encrypted: i=1; AKwUvBwjsNUBph3WnYApereiCKfT/RxWZIoSjJINBpuru8dgdWOy6kHT+KhEprtjTasaan4YI1MXB5E50iwZGbVH@vger.kernel.org
X-Gm-Message-State: AFq9FYKEYRp0v4ZmVidq5J5ZQjrxP3kBHDljoQzX6nUrHJL4Db5HG1Hj
	OByiKQ8F4+ngnAD4EEfN+SNZmAs8fFjEsYlPxOTf0LF3y+N0YIMGEqWi
X-Gm-Gg: AYBFou0THYATPgZ0LSyMy19ch0f1JWGoZho649AQU1ipNhTzmalGmWWfMhmRkm67aaq
	sK80vm44AMX9OyszQiL6UkQ81Sb+b5+WdKkDpgNG/lw1irR8MvAWrplsgUxBPLRwmE1zBrHqRZa
	PyOU34jBgSJEZ4Icj1h6MsSQo9j+JMUlFVqK2iygBDupJPfMw+SoT/afcS0wIU2EFB06t74M6Ey
	FXegUfOzwGBZcmMp0GQdpDhs54cvGUhuL7+wY3ccBcv00f5ulnnyRS2SQx23mo0bkCVwexEUk+G
	HuN21m4DfuE0+5T+TX7bNcTSnkbtJ7fAXyqKXxLcfo96utY31Q2I5i+6TQ9jho28gwyFBFzHvqK
	1tx+gUNWWj+pcuiq0HW2+GDTBeWNBPWR9B9tRqhVOTUFZFNNZf11X4C5pH4RgUItFnqMhsJUmlv
	KegtQkh6idnl1qf4FKWH2ikn29N+iQqTiffBm9NFgtuH5VwuNt1q2nzqGj6uxUq6L9IDbTMTo1v
	A8blsmRosU=
X-Received: by 2002:a17:90a:b90:b0:3ab:be66:ddb7 with SMTP id 98e67ed59e1d1-3abbe66df61mr9344941a91.47.1792118699948;
        Thu, 15 Oct 2026 19:44:59 -0700 (PDT)
Received: from ancienth-X870E-Nova-WiFi ([125.186.72.2])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3acc48f4cadsm1769353a91.12.2026.10.15.19.44.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Oct 2026 19:44:59 -0700 (PDT)
From: Daehyeon Ko <4ncienth@gmail.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>,
	Jens Axboe <axboe@kernel.dk>,
	Keith Busch <kbusch@kernel.org>,
	Hannes Reinecke <hare@kernel.org>,
	linux-block@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] iov_iter: validate extracted segment for bvec alignment
Date: Fri, 16 Oct 2026 11:44:37 +0900
Message-ID: <20261016024439.4069212-1-4ncienth@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261015181702.21329d323eb40d145a6d0c9d@linux-foundation.org>
References: <20261015061907.2713943-1-4ncienth@gmail.com> <20261015181702.21329d323eb40d145a6d0c9d@linux-foundation.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Yes for bio-based drivers, but not necessarily for blk-mq hardware drivers.

The worst effect I have confirmed is an alignment-contract bypass.  An
unprivileged O_DIRECT preadv() produced bvecs with offset/length pairs
(1, 4095) and (0, 1).  The bio reached brd_submit_bio(), and the read
completed 4096 bytes instead of failing with -EINVAL.

I have not demonstrated harmful behavior on real DMA hardware.  For a
normal blk-mq target, blk_mq_submit_bio() calls __bio_split_to_limits(),
where bio_split_io_at() rejects the misaligned bvec before queue_rq().
Virtio-blk and loop both returned -EINVAL in my controls.

So a bio-based driver can receive a bvec which violates its advertised
dma_alignment, but any further effect is driver-specific.  I have not
reproduced memory corruption or a crash on real hardware.
