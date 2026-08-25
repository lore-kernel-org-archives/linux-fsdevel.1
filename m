Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A6383FDBEA
	for <linux-fsdevel@vger.kernel.org>; Tue, 25 Aug 2026 11:15:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787656518; cv=none; b=Zjge9YBiUET9Qlhhp0Q+iYoNm3FK6qQVD4/n1/Z5HsxLFrJ/HQHw7oy6rJn7aoW+cC66vDhJqRn6lT+U5Fy+IBnBn+iKD30afJ1CsuXdf3Jvlr0BvgBKb1IZ4Q4OwAfAvyyhJjqwZRBAhdQXvN3AegiHp0arBhzWaqE/oaRYi5M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787656518; c=relaxed/simple;
	bh=GKN8g4QDBFDef8bKiPT7Dvw3NomvdxmD3jUAwR8N0Mo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jvuox3+/tmReiyOrGHMW/oMAa6FzVs3+L7mPYUYoEG6FOmrUzNtsa38+GGNzrRnxhOwoOmEfWLWzcNwlr0Dz7f0brnmLrS01a0sxqwXOYXvqURGelAA++JxHTqvWWHIgzzXQHAgilljtL7WLKx0K9ZwL4sPVY7YnWjwpbN3lnJg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HMktEPZE; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HMktEPZE"
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-395cf2535acso820816a91.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 25 Aug 2026 04:15:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787656517; x=1788261317; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=GKN8g4QDBFDef8bKiPT7Dvw3NomvdxmD3jUAwR8N0Mo=;
        b=HMktEPZERGupv1Sa3dsMl7Pkj3eIvvaB7Qmt2XPUQGcA8Jk0M9hdbYGbd4NPGx6Rqe
         EfxBuDKV86WDzqZcZZ/F5C18ilxTlGTRnm3r+3mEeiGWfU+82FR2zQXt5KegptLRRBMX
         /VDTWjPQbdURSMi272bYEj67Yqb835FltgV4TOCxLMfANye/bja8PrD2qBvk/xizMN1W
         Vv4G1MABzwQkaaeTAdh0MkCv6UhVcWjTM3Dnda8IW8wPT8jlOsUFkb8/ECvsPpz8EMDH
         jzCzpS58X4GKvCxolp9xuM4l8WJ8I8biNj0r8ovUhOQZBMFOihL3qqMGsrX4+HwSMmhm
         gfhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787656517; x=1788261317;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=GKN8g4QDBFDef8bKiPT7Dvw3NomvdxmD3jUAwR8N0Mo=;
        b=L/G6G9QoGHsgjikDzf9YlxvPa0ZUMtWvKj22FdYDKmkuEQFVejoJI1pd+vREhVcm4p
         9T7QGzcqA1+cPGCMGfHJIJxqD7OUKe0R8sFYKN0Gp0PnDrTYMEaDHi1L0VRfbHHP+sIa
         AQY7PEP10NQ0KXcyrGRaBpKDf2nDjn3FnAyd0EddpauoYnzdWO2Z2rf7t4Pyr/1IxBkB
         fG/u+Zjn98hfs3R4HAqu/WIrdpPuK7ETX+U62J6FCH0X8BFlgzwawbXOKRh8wI+to41P
         dbeB3eQFLcqBcqPKcb2EhRWVbi8w4IYoXbeRKDkhIZZ95xAUPodghZDJkXnH65HI5k6w
         lb9w==
X-Forwarded-Encrypted: i=1; AHgh+Rpm7WP21oWBjqmg1qNk8FcECt6EcecxtsSgOG3KN/kxX7wr5fPP+by1W5FiwdcJL54Fjs0w8VC9jNEA98dK@vger.kernel.org
X-Gm-Message-State: AFuF++kds5ulChdViL03nIcFZAzOMvDOLEofq1enYodrqiHE9FBXPW6N
	k4urTPHdPLRyzW1KzseKXFMUsUtv1DIqRS25wwQ2pXWArf+fnMxC+g9B
X-Gm-Gg: AR+sD12+Jvok7/3JEnf9iSjT8X2VA3YcE2ZPSskEJ+BIzyJrSM8CqOJ81E9MAKcyJE0
	v1S9PO1md42w3LSULfxGBA6Jq1juyebMaJ6iKVxDtPGwjoFeSdjPEXNcHN13WC87u2KgUKAwoS4
	SXC+fooWs+7/pf74CRYmXFF5daINvRHaqSHSNi4UAwCbfF21R+sT4hXu0CHwAgv+T9l9u6XcCWQ
	Pudy9xDOwLwtt0hMV8HYXUWoMnrGtYDKZumotCIxMwZSUZWlVKmeH/HsRSrxgMP/LvVaP4E/pwI
	FmI5+Oys1ZecDWFzqqMowKpKarX5tcf/Z8RsIbYhsYqUn2IQ70iHBCrOR8lS/rLl+2tftpt8le6
	v+MJRXgJryfCje2HoRVHGRLUr4mPdXZGF/svrk5vO/BhfoDL/IWMymmaOC89R3cgQr7+GACbkg+
	E00a4PXXmO7mIJzVe+H5aXyjPfzZLCuoQxjaJ5gH1XSnGdgyBYktl2nxiVvTwNAbWibsSriwYU+
	5eU23GkGnGESgvwNdDpfI7U8sTMXt+kHS9hRoByEWU=
X-Received: by 2002:a17:90b:2712:b0:394:ed5c:ff9f with SMTP id 98e67ed59e1d1-39645b19ef1mr8212048a91.17.1787656516295;
        Tue, 25 Aug 2026 04:15:16 -0700 (PDT)
Received: from localhost ([2409:40c4:101c:e5a9:a28f:e499:1b07:43b3])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3282afb407bsm6628824eec.30.2026.08.25.04.15.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Aug 2026 04:15:15 -0700 (PDT)
From: Lovekesh Solanki <lovekeshsolanki00@gmail.com>
To: lovekeshsolanki00@gmail.com
Cc: brauner@kernel.org,
	eulgyukim@snu.ac.kr,
	gregkh@linuxfoundation.org,
	jack@suse.cz,
	jjy600901@snu.ac.kr,
	kees@kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-usb@vger.kernel.org,
	stable@vger.kernel.org,
	stern@rowland.harvard.edu,
	viro@zeniv.linux.org.uk
Subject: Re: [PATCH] USB: gadget: fix NULL pointer dereference in gadget_dev_ioctl()
Date: Tue, 25 Aug 2026 16:45:11 +0530
Message-ID: <20260825111511.328160-1-lovekeshsolanki00@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260825104601.315401-1-lovekeshsolanki00@gmail.com>
References: <20260825104601.315401-1-lovekeshsolanki00@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch was intended for a different report. Please ignore it.

Sorry for the confusion.

Thanks,
Lovekesh
