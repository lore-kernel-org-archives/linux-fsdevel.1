Received: from mail-pj2-f13.google.com (mail-pj2-f13.google.com [74.125.227.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82536422535
	for <linux-fsdevel@vger.kernel.org>; Wed, 23 Sep 2026 17:52:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790185939; cv=none; b=b3PUD8C+7wrRDq2eZUe5hpzNskgb+i0rBJ2vSp+g0GYSUjaK1AvU/YlPMMRd1v85ojXu7u9ubehRF1XtnFsLyFUv2ZanPd0GXAwaVxwbP9f7vlQGps3s6f+3gsabvrG6J1Jtdd03StpfzbeZE8dfgQ+JqaLlYNKbSZbhnh7R8cA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790185939; c=relaxed/simple;
	bh=DRqmRpjUqDSGT29CT1Bz5Lx7GtaQYRiwcv3jI7PfffI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=c26bZMDiETFIl2JeoK/GwOQJ/sOnRNe54b4e/9SgSZub2/NYKtYlmOC/qdd1sdeA6egN/arpsOeiwmFLky9URfio2Yri/+geeRjdqtmPUoVEghCds51f5gI5XagWe/jeLTd/ImSPm123JeQ/jFIIh5ISZNN8El8ubO6q2im1BHw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=juvsEDej; arc=none smtp.client-ip=74.125.227.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="juvsEDej"
Received: by mail-pj2-f13.google.com with SMTP id 98e67ed59e1d1-398cb5615deso980928a91.3
        for <linux-fsdevel@vger.kernel.org>; Wed, 23 Sep 2026 10:52:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790185935; x=1790790735; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=p+wYMt5RgGNAL4xbHbIdqrpDL5phee97AhbS4gBla/k=;
        b=juvsEDejJBQJJon93p7IBtrDxqDkq6uGZ6eZeuxZiM4dp5BAJrt/FpRN2bIEIG8Dqa
         udsl8fQKK9Hw02ALkhmR85/GrJ+5vhNv+N5gP5QbvGGJ0L+JYsFQYVXCviwYIQ6FKi/S
         fqMEtjppRSfGmKcxGdRAoGnuABNAHYIt9g3iaV2iClk97/wIiMpize+SUVBBh1GfAxf2
         ksbUYsXuu+Vxoq7Uy3BzuftjK4WypT++/URs0CDxeA+3aQ102DtZE9sCHrG8u9YAVHkn
         f8m/AHe6p9YE/LG1HnTxrLD/EnTuElAJuuvEoztdEt3OD8B7iP6xiHeBIe4dQ5pwSfDv
         SVtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790185935; x=1790790735;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=p+wYMt5RgGNAL4xbHbIdqrpDL5phee97AhbS4gBla/k=;
        b=SyN3xzYBmP+6GiFtQuO1d2G83HnG0Cw8FsLVDLb+COKmA/CWSRW6YFeEQFccoyj8me
         HzTRgqHAKKw3o4KCZ7rjATDsX+vY3ylzBb0fMFKb+RqZtRdAQcnYBMWUjzHk6juD/cUy
         TGBLmzZwwWq7uyGIi5B3LhGpSdhRCsbCCppLWktjsIDeYdfnnx6woMSnvyn7WiJB2JCl
         9P2P0CjLxJJbb4+WGrmPqIsQZxk0OcjB1nILKiXSq1hGOt18xQDrE+bSAWfc6tM6LCC/
         Q+AWgL9uZVB8USadEJx585exWqikDd5q9ijctEnIsRTnIocFJ2xwLQ4P5XsfgH26XgD8
         IaKw==
X-Forwarded-Encrypted: i=1; AKwUvBz8foc1b/lWAUt3IQvA33YAR/FZ5UMEWFwsUXC/M8eKFIu+DBaMkKYKCmxk5zDocODG4REBu4l+9pnw0lld@vger.kernel.org
X-Gm-Message-State: AFuF++l0o/PLMVT9+qVoDlIdo+t7PFm+ZjBHoRzTzYu+kP53oMZc2u0c
	Z6uY1pM8lEMwY+nKe8cVEZ9IJf9fv80AbMt4JRHNO7mO4woe6vqlmJNs
X-Gm-Gg: AYBFou0Fq2j1KddhczInQNwHVZlxwjGqKHstbTJOkzVDGQSEX4equwsejGsWFbaanPl
	hBgYWlQeofBpxA7pMeUJfwpINPMH4hDg0GjI/7X4jmTTcYnyaXNGWva2Lqm9BhMljsFMJk1k5hw
	bYhweQfPliqkjnZQR0BYvmTQn+ZyaXwQqNip3NchDxyEqCO2r3cUjAy8774kiMZWAoP5Kx3Bu62
	67QFYXrFpugInxhVluvKcJQFbrKab2299DExKvL/eGVWepBTqBVD1ub35Zs4oAmYbQZI8CzUaIW
	PukWMTIQuHeEmOcWfSsy29gG2Yrx3SWOFEb1CeavjuKWH5UKyUZYzQD8T60t8LA5Y5dXlHjVoTO
	+1W7UUdKa9MVsmkn3sjSm+SdBb6WWSntAlySQ07x7O4q/MGocR+1+1FD56aQuvu97t5R6A6JsHv
	zS+C8EwmIumk2Tz5beh3cWhCSrL3KCn3WL3a4tDxGoeUu+0N6iIg11NlJ7GCQX4E5RTULSCXbEy
	vO55eA3fnEw9vUjdygsDhy3JTkGB+sMOqfHKWy6/CYAT3Fkl4M+7imIKONM/xBkYwo2VU/5mQnn
	vEjn+Do84MjkY57bow0JLIqGfueWvp4A2Jla1+PSMfo86qK96j24ONVxlVGMNa1k46xDgFuBlAz
	i1Bdv1Mk=
X-Received: by 2002:a17:90b:1cc7:b0:39e:6c69:9b9a with SMTP id 98e67ed59e1d1-3a07e6ec797mr2946391a91.63.1790185935232;
        Wed, 23 Sep 2026 10:52:15 -0700 (PDT)
Received: from spider.bream-herring.ts.net ([103.252.203.158])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2df6a5de5c8sm15188055ad.60.2026.09.23.10.52.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Sep 2026 10:52:14 -0700 (PDT)
From: Matthias Goergens <matthias.goergens@gmail.com>
To: Jan Kara <jack@suse.cz>
Cc: Christian Brauner <brauner@kernel.org>,
	chenyichong@uniontech.com,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] isofs: validate directory records in isofs_read_level3_size()
Date: Thu, 24 Sep 2026 01:52:11 +0800
Message-ID: <20260923175211.1577344-1-matthias.goergens@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <volfx2r3ystjmi6d2qaeyu37pjodjrp3sef6y3vmte3ia6aqoy@acwbpwhk5heq>
References: <20260923153220.777907-1-matthias.goergens@gmail.com> <volfx2r3ystjmi6d2qaeyu37pjodjrp3sef6y3vmte3ia6aqoy@acwbpwhk5heq>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Wed 23-09-26 19:13:03, Jan Kara wrote:
> Thanks! I've added the patch to my tree.

Thanks!  One correction to my commit message, if you're still able to
edit it: the out-of-bounds reads from all three fuzzer reproducers are
on de->flags, not in isonum_733(de->size).  The last paragraph would
then read:

  Found by fuzzing fs/isofs in a userspace harness with ASan
  (heap-buffer-overflow reads of de->flags).

Matthias
