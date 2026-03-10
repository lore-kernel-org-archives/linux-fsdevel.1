Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10C6F3AF657
	for <linux-fsdevel@vger.kernel.org>; Tue, 10 Mar 2026 13:22:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773148931; cv=none; b=DSIHqc540itgtYTqd2+ZYJk4uHfGrkwSV/X2b3/dAfeVoU7dYaW0s4LcMFrhqyeoYNBzPW6hXRmN2FR+AT6FWGPJuqfCxQrkX+xm+dH1X9BR9miG9z+ZYF6ZW9Da2OB3+IYXIiHy34fhv1E11rbTy9ESdayxf4DKWR7vvXzR2N8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773148931; c=relaxed/simple;
	bh=7C48eJwQxF2SZSyojjO4eehKdtPdDBqSboD/LkVXOwA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AYGeDBxiQMINTbp3VS/3n5Bd4x0IR+4khISO1vIOEw8y98wzPWBcIktk3iuzCASsswBMyzd5/NtfmuJinp4QkIRsZbAz/+A0X6wtR+DYc3j3e9Gg0YhY+WkPf73YL45p6aP97OrxC3f/H4WQIUuhxHv97ZA8oGptFoRkx9STDZ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=E51kNjIN; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=DLhvlaPb; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="E51kNjIN";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="DLhvlaPb"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1773148927;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=5/adDEbR57gUpYJcJq84OoDVxrrM3xMPFmZCRo0jKXM=;
	b=E51kNjIN4UKbGW9DyZ5aBLaeo/X1fN08TYjWYCgYq8Q8qw25+tZQtb5W5ajU6MN7BBBW11
	0YDBivfD6ObYrVaZ07AfmguXniohVg3EyJDviAgsAuscNKdssFGgICyGTgh1yznjOgNpE3
	ekU6IHdwiHFWZVShb4nqu/2AD28lhx4=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-643-ZB_7ex7aNLmZmW_Uk0eU4w-1; Tue, 10 Mar 2026 09:22:05 -0400
X-MC-Unique: ZB_7ex7aNLmZmW_Uk0eU4w-1
X-Mimecast-MFC-AGG-ID: ZB_7ex7aNLmZmW_Uk0eU4w_1773148925
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-8cd81506677so1375229085a.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 10 Mar 2026 06:22:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1773148925; x=1773753725; darn=vger.kernel.org;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5/adDEbR57gUpYJcJq84OoDVxrrM3xMPFmZCRo0jKXM=;
        b=DLhvlaPbwaSFQKg/FmxemLJJZifDd7cIIhpxvIrZaWROKjgqKnQK81zS2r/WSu9mvZ
         1x4TVLhhO06glvOYJXTBYTQHe1C/lCEECiyKmpprEGkSpnbhT/+Xy+wfN5x6paEUKxsd
         eleVUcWebznHZRscghpqRSurxi7A6fJyr8+SC/oFm4tth2mVEOc19JKZit9S00HY03E/
         XNzQnAGkguTRFL3rrkTJWt1Ev4Xq7DVoDTHr6r9kNjeVPxV8v11X5FGr4E58NddnvLYv
         QUA4HTbgZjVMx4thX/P6FGMyY+HUc/G2+EnczacjtLqtmfpojjqt59bZxWNPmXy2pn5x
         ulpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773148925; x=1773753725;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=5/adDEbR57gUpYJcJq84OoDVxrrM3xMPFmZCRo0jKXM=;
        b=RQm8rDXT0R2H47+48DUYn0uRgIBgbqxkrQjRw/ARtR9wz3MMjcwaapCJn8yTkmbr4i
         T4X/XgyRZ79yTeSWW/dDF3rJBKgAab3Yo2ySaoJK6XYDqsc+qIgv31qYwWri7alUzczX
         kQFykLqU+s4Lw0kpf5cS8O3/W+0CCW11DWhrImTNt00TiN0Jw6g5fLyuvWONnCJH/grW
         su+CvYXCX2JJBNLJDrq8OfeTePTtQAtj2OqRyVufr3QHKB3jAI9EBNQU76+iwwI0Kb7y
         TFLgp3P/h5u8xUYF4ZhOn70hRmbIjfHG2US6c4RMwhAZ5Cp8yids0rIDVX9e1N/0yOE5
         NExg==
X-Forwarded-Encrypted: i=1; AJvYcCWUSAzDVcWujHAXsl43dXX4IWp9mhGaQ4cv8k8WjXKfcaIW0wq2RLZ2XG3vfOsi20Nj7L2UTP92CSWAmH/T@vger.kernel.org
X-Gm-Message-State: AOJu0YxnWDBaH4JMu/EOQFmVV1Xu9tqrv0itufQ8DLvzUNWgfpuNiaoD
	uOzqNwlE4uQ22F9ZviK9OjVMsfgkN2KlR0PFETs97+uhyOL1no8nq8Cqnzwlvj5YOdfrPuX0bQN
	+7axXPSvJM5iKgNwXaEv19ftsAAEyYA1rX+8VXtFBcbpMON64kwWkSHTE+6shzW+GM4U=
X-Gm-Gg: ATEYQzy58iJMOzs1MpNH6gVtldikBokiKj78KDYIYOuS0XPBxm6AhMfnZ6uqlVTST7+
	IlXRmvRrYuqzT0Th/5uPHw2dFUuOcsx2tZWs1leoHGQOM4wh/67Rjk55qFaiPp3BUlt0KNoGEDk
	yVSfUIy4pUAKEkuIOUf08SosS8JXoYeGj10PCXSCUZYuXR0ptT9CbvpzhrpgHyAOtT+foVQXO/W
	S3t6fLrr1DodqI3WwhvgRcJ42ulAyNPCfRbMq8kdDiqQAPohMZ2tIvlehUmP1wVj2Th5SJMVosE
	9kdaUUhfPrF+Ky3Fvfsmd74SX5Bnt6xsFHpWZly5nGZyPjZcxKScq9A7A/yQ18d2SEFLKOsz7ne
	faUy6ubn5htTpG6OkoIkbUvPHp4DNsSvbKwcBjGHGlAMtbmXkWf+9oCu/
X-Received: by 2002:a05:620a:3713:b0:8ca:1240:4991 with SMTP id af79cd13be357-8cd6d4f9469mr1830788485a.45.1773148924749;
        Tue, 10 Mar 2026 06:22:04 -0700 (PDT)
X-Received: by 2002:a05:620a:3713:b0:8ca:1240:4991 with SMTP id af79cd13be357-8cd6d4f9469mr1830766185a.45.1773148922638;
        Tue, 10 Mar 2026 06:22:02 -0700 (PDT)
Received: from redhat.com (c-73-183-52-120.hsd1.pa.comcast.net. [73.183.52.120])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8cd8576db0esm474754485a.47.2026.03.10.06.21.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Mar 2026 06:22:01 -0700 (PDT)
Date: Tue, 10 Mar 2026 09:21:58 -0400
From: Brian Masney <bmasney@redhat.com>
To: Philipp Hahn <phahn-oss@avm.de>
Cc: amd-gfx@lists.freedesktop.org, apparmor@lists.ubuntu.com,
	bpf@vger.kernel.org, ceph-devel@vger.kernel.org, cocci@inria.fr,
	dm-devel@lists.linux.dev, dri-devel@lists.freedesktop.org,
	gfs2@lists.linux.dev, intel-gfx@lists.freedesktop.org,
	intel-wired-lan@lists.osuosl.org, iommu@lists.linux.dev,
	kvm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-block@vger.kernel.org, linux-bluetooth@vger.kernel.org,
	linux-btrfs@vger.kernel.org, linux-cifs@vger.kernel.org,
	linux-clk@vger.kernel.org, linux-erofs@lists.ozlabs.org,
	linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	linux-gpio@vger.kernel.org, linux-hyperv@vger.kernel.org,
	linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-leds@vger.kernel.org, linux-media@vger.kernel.org,
	linux-mips@vger.kernel.org, linux-mm@kvack.org,
	linux-modules@vger.kernel.org, linux-mtd@lists.infradead.org,
	linux-nfs@vger.kernel.org, linux-omap@vger.kernel.org,
	linux-phy@lists.infradead.org, linux-pm@vger.kernel.org,
	linux-rockchip@lists.infradead.org, linux-s390@vger.kernel.org,
	linux-scsi@vger.kernel.org, linux-sctp@vger.kernel.org,
	linux-security-module@vger.kernel.org, linux-sh@vger.kernel.org,
	linux-sound@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-trace-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
	linux-wireless@vger.kernel.org, netdev@vger.kernel.org,
	ntfs3@lists.linux.dev, samba-technical@lists.samba.org,
	sched-ext@lists.linux.dev, target-devel@vger.kernel.org,
	tipc-discussion@lists.sourceforge.net, v9fs@lists.linux.dev,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Daniel Lezcano <daniel.lezcano@kernel.org>,
	Thomas Gleixner <tglx@kernel.org>
Subject: Re: [PATCH 56/61] clk: Prefer IS_ERR_OR_NULL over manual NULL check
Message-ID: <abAa9vQg4BSxl1BJ@redhat.com>
References: <20260310-b4-is_err_or_null-v1-0-bd63b656022d@avm.de>
 <20260310-b4-is_err_or_null-v1-56-bd63b656022d@avm.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260310-b4-is_err_or_null-v1-56-bd63b656022d@avm.de>
User-Agent: Mutt/2.2.14 (2025-02-20)

On Tue, Mar 10, 2026 at 12:49:22PM +0100, Philipp Hahn wrote:
> Prefer using IS_ERR_OR_NULL() over using IS_ERR() and a manual NULL
> check.
> 
> Semantich change: Previously the code only printed the warning on error,

Semantic ...

> but not when the pointer was NULL. Now the warning is printed in both
> cases!
> 
> Change found with coccinelle.
> 
> To: Michael Turquette <mturquette@baylibre.com>
> To: Stephen Boyd <sboyd@kernel.org>
> To: Daniel Lezcano <daniel.lezcano@kernel.org>
> To: Thomas Gleixner <tglx@kernel.org>
> Cc: linux-clk@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> Signed-off-by: Philipp Hahn <phahn-oss@avm.de>

With the minor typo addressed:

Reviewed-by: Brian Masney <bmasney@redhat.com>

